# meta developer: @RnPlugins
# meta name: IgnoreChat
# meta version: 1.0.1

import datetime
import logging
import re
import time
from telethon.tl.functions.account import UpdateNotifySettingsRequest, GetNotifySettingsRequest
from telethon.tl.types import InputNotifyPeer, InputPeerNotifySettings, Message, User, InputNotifyUsers, InputNotifyChats, InputNotifyBroadcasts

from .. import loader, utils

logger = logging.getLogger(__name__)


@loader.tds
class IgnoreChatMod(loader.Module):
    """Мутит чаты и убирает их в архив на время."""

    strings = {
        "name": "IgnoreChat",
        "processing": "<emoji document_id=5429411030960711866>💬</emoji> <b>Обработка...</b>",
        "ignore_success_pm": (
            "<emoji document_id=5260264520080695245>🔕</emoji> <b>Вы были добавлены"
            " в игнор на {}.</b>\n{}"
        ),
        "ignore_success_chat": (
            "<emoji document_id=5260264520080695245>🔕</emoji> <b>Этот чат был"
            " добавлен в игнор на {}.</b>\n{}"
        ),
        "ignore_success_other": (
            "<emoji document_id=5260264520080695245>🔕</emoji> <b>Чат {} добавлен"
            " в игнор на {}.</b>\n{}"
        ),
        "unignored_pm": (
            "<emoji document_id=5260268501515377807>📣</emoji> <b>Вы снова в эфире!"
            "</b>\n<i>(Срок игнора истёк)</i>"
        ),
        "unignored_chat": (
            "<emoji document_id=5260268501515377807>📣</emoji> <b>Этот чат снова в"
            " эфире!</b>\n<i>(Срок игнора истёк)</i>"
        ),
        "unignore_manual_success": (
            "<emoji document_id=5260268501515377807>📣</emoji> <b>Чат успешно"
            " убран из игнора.</b>\n{}"
        ),
        "reason_line": (
            "<emoji document_id=5257965174979042426>📝</emoji> <b>Причина:"
            "</b> <i>{}</i>"
        ),
        "forever": "<b>навсегда</b>",
    }

    strings_ru = {
        "_cls_doc": (
            "Мутит чаты и убирает их в архив на время, сохраняя старые настройки уведомлений."
        ),
        "_cmd_doc_cignore": "[ид/юз_чата] [время] [причина] - Добавить чат в игнор.",
        "_cmd_doc_cunignore": "[ид/юз_чата] [причина] - Убрать чат из игнора.",
    }

    def __init__(self):
        self.config = loader.ModuleConfig(
            loader.ConfigValue(
                "unignore_notify",
                False,
                "Отправлять уведомление о снятии игнора в чат.",
                validator=loader.validators.Boolean(),
            ),
            loader.ConfigValue(
                "silent_without_reason",
                True,
                "Скрывать уведомления и удалять команду, если игнор ставится без причины.",
                validator=loader.validators.Boolean(),
            ),
            loader.ConfigValue(
                "mute_tags",
                True,
                "Автоматически глушить упоминания в проигнорированных группах.",
                validator=loader.validators.Boolean(),
            ),
            loader.ConfigValue(
                "keep_mute_state",
                True,
                "Сохранять состояние мута, если чат уже был замучен до игнорирования.",
                validator=loader.validators.Boolean(),
            ),
        )

    async def client_ready(self, client, db):
        self.client = client
        self.db = db
        self.allclients = getattr(loader, "allclients", [])

    def _parse_time(self, time_str: str) -> int:
        if not time_str:
            return 0
        match = re.match(r"(\d+)([мчдн])", time_str, re.IGNORECASE)
        if not match:
            return 0

        value, unit = match.groups()
        value = int(value)
        unit = unit.lower()

        if unit == "м":
            return value * 60
        if unit == "ч":
            return value * 3600
        if unit == "д":
            return value * 86400
        if unit == "н":
            return value * 604800
        return 0

    @loader.command()
    async def cignore(self, message: Message):
        """[ид/юз_чата] [время] [причина] - Добавить чат в игнор."""
        args = utils.get_args_raw(message)
        parts = args.split(" ") if args else []

        target_chat = None
        duration_str = ""
        reason = ""

        if parts:
            first_arg = parts[0]
            looks_like_peer = (
                first_arg.startswith("@")
                or first_arg.startswith("-")
                or first_arg.isdigit()
                or re.match(r"^[a-zA-Z][a-zA-Z0-9_]{3,31}$", first_arg)
            ) and not re.match(r"^\d+[мчдн]$", first_arg, re.I)

            if looks_like_peer:
                try:
                    try:
                        peer_id = int(first_arg)
                    except ValueError:
                        peer_id = first_arg

                    target_chat = await self.client.get_input_entity(peer_id)
                    remaining = parts[1:]
                    if remaining:
                        if re.match(r"^\d+[мчдн]$", remaining[0], re.I):
                            duration_str = remaining[0]
                            reason = " ".join(remaining[1:])
                        else:
                            duration_str = ""
                            reason = " ".join(remaining)
                except Exception:
                    target_chat = None

            if target_chat is None:
                target_chat = await message.get_input_chat()
                if re.match(r"^\d+[мчдн]$", first_arg, re.I):
                    duration_str = first_arg
                    reason = " ".join(parts[1:])
                else:
                    duration_str = ""
                    reason = " ".join(parts)
        else:
            target_chat = await message.get_input_chat()

        if not target_chat:
            return

        duration = self._parse_time(duration_str)
        chat_id_int = await self.client.get_peer_id(target_chat)
        chat_id_str = str(chat_id_int)

        ignores = self.db.get("IgnoreChat", "ignores", {})

        is_private = False
        is_channel = False
        try:
            entity = await self.client.get_entity(target_chat)
            is_private = isinstance(entity, User)
            is_channel = getattr(entity, "broadcast", False)
        except Exception:
            pass

        is_already_muted = False
        try:
            def check_settings(settings):
                if not settings:
                    return False
                mute_until = getattr(settings, "mute_until", None)
                if mute_until:
                    if isinstance(mute_until, datetime.datetime):
                        if mute_until.tzinfo is None:
                            mute_until = mute_until.replace(tzinfo=datetime.timezone.utc)
                        return mute_until > datetime.datetime.now(datetime.timezone.utc)
                    return int(mute_until) > time.time()
                return False

            notify_settings = await self.client(GetNotifySettingsRequest(
                peer=InputNotifyPeer(peer=target_chat)
            ))
            if check_settings(notify_settings):
                is_already_muted = True
            else:
                if is_private:
                    global_peer = InputNotifyUsers()
                elif is_channel:
                    global_peer = InputNotifyBroadcasts()
                else:
                    global_peer = InputNotifyChats()
                global_settings = await self.client(GetNotifySettingsRequest(peer=global_peer))
                if check_settings(global_settings):
                    is_already_muted = True
        except Exception as e:
            logger.warning(f"Failed to check notify settings for {chat_id_str}: {e}")

        if duration > 0:
            unignore_time = int(time.time() + duration)
            ignores[chat_id_str] = {
                "unignore_time": unignore_time,
                "is_private": is_private,
                "is_already_muted": is_already_muted,
            }
            time_display = duration_str
        else:
            ignores[chat_id_str] = {
                "unignore_time": None,
                "is_private": is_private,
                "is_already_muted": is_already_muted,
            }
            time_display = self.strings("forever")

        self.db.set("IgnoreChat", "ignores", ignores)

        try:
            await self.client(
                UpdateNotifySettingsRequest(
                    peer=InputNotifyPeer(peer=target_chat),
                    settings=InputPeerNotifySettings(mute_until=2**31 - 1),
                )
            )
        except Exception as e:
            logger.warning(f"Failed to mute chat {chat_id_str}: {e}")

        try:
            await self.client.edit_folder(target_chat, 1)
        except Exception as e:
            logger.warning(f"Failed to archive chat {chat_id_str}: {e}")

        if not reason and self.config["silent_without_reason"]:
            try:
                await message.delete()
            except Exception:
                pass
            return

        reason_text = self.strings("reason_line").format(reason) if reason else ""
        current_chat_id = message.chat_id
        target_chat_id = chat_id_int

        if current_chat_id != target_chat_id:
            try:
                chat_entity = await self.client.get_entity(target_chat)
                chat_name = getattr(chat_entity, "title", None) or getattr(chat_entity, "username", None) or str(target_chat_id)
                if getattr(chat_entity, "username", None):
                    chat_name = f"@{chat_entity.username}"
            except Exception:
                chat_name = str(target_chat_id)

            await utils.answer(message, self.strings("ignore_success_other").format(chat_name, time_display, reason_text))
        else:
            template = (
                self.strings["ignore_success_pm"]
                if is_private
                else self.strings["ignore_success_chat"]
            )
            await utils.answer(message, template.format(time_display, reason_text))

    @loader.command()
    async def cunignore(self, message: Message):
        """[ид/юз_чата] [причина] - Убрать чат из игнора."""
        args = utils.get_args_raw(message)
        parts = args.split(" ") if args else []

        target_chat = None
        reason = ""

        if parts:
            first_arg = parts[0]
            looks_like_peer = (
                first_arg.startswith("@")
                or first_arg.startswith("-")
                or first_arg.isdigit()
                or re.match(r"^[a-zA-Z][a-zA-Z0-9_]{3,31}$", first_arg)
            )

            if looks_like_peer:
                try:
                    try:
                        peer_id = int(first_arg)
                    except ValueError:
                        peer_id = first_arg

                    target_chat = await self.client.get_input_entity(peer_id)
                    reason = " ".join(parts[1:])
                except Exception:
                    target_chat = None

            if target_chat is None:
                target_chat = await message.get_input_chat()
                reason = " ".join(parts)
        else:
            target_chat = await message.get_input_chat()

        if not target_chat:
            return

        chat_id_int = await self.client.get_peer_id(target_chat)
        chat_id_str = str(chat_id_int)

        ignores = self.db.get("IgnoreChat", "ignores", {})
        data = ignores.get(chat_id_str)
        is_already_muted = False
        if data and isinstance(data, dict):
            is_already_muted = data.get("is_already_muted", False)
        ignores.pop(chat_id_str, None)
        self.db.set("IgnoreChat", "ignores", ignores)

        if not (self.config["keep_mute_state"] and is_already_muted):
            try:
                await self.client(
                    UpdateNotifySettingsRequest(
                        peer=InputNotifyPeer(peer=target_chat),
                        settings=InputPeerNotifySettings(
                            mute_until=0,
                            silent=False,
                        ),
                    )
                )
            except Exception as e:
                logger.warning(f"Failed to unmute chat {chat_id_str}: {e}")

        try:
            await self.client.edit_folder(target_chat, 0)
        except Exception as e:
            logger.warning(f"Failed to unarchive chat {chat_id_str}: {e}")

        if not reason and self.config["silent_without_reason"]:
            try:
                await message.delete()
            except Exception:
                pass
            return

        reason_text = self.strings("reason_line").format(reason) if reason else ""
        await utils.answer(
            message, self.strings("unignore_manual_success").format(reason_text)
        )

    @loader.loop(interval=10, autostart=True)
    async def unignore_checker(self):
        ignores = self.db.get("IgnoreChat", "ignores", {})
        if not ignores:
            return

        now = int(time.time())
        modified = False

        for chat_id_str in list(ignores.keys()):
            data = ignores.get(chat_id_str)
            if not data or data.get("unignore_time") is None:
                continue

            if now >= data["unignore_time"]:
                modified = True
                chat_id_int = int(chat_id_str)

                client = next(
                    (c for c in self.allclients if str(c.tg_id) == str(self.client.tg_id)),
                    self.client,
                )

                try:
                    peer = await client.get_input_entity(chat_id_int)
                    is_already_muted = False
                    if data and isinstance(data, dict):
                        is_already_muted = data.get("is_already_muted", False)
                    if not (self.config["keep_mute_state"] and is_already_muted):
                        await client(
                            UpdateNotifySettingsRequest(
                                peer=InputNotifyPeer(peer=peer),
                                settings=InputPeerNotifySettings(
                                    mute_until=0,
                                    silent=False,
                                ),
                            )
                        )

                    try:
                        await client.edit_folder(peer, 0)
                    except Exception as e:
                        logger.warning(f"Failed to unarchive chat {chat_id_int}: {e}")

                    if self.config["unignore_notify"]:
                        template = (
                            self.strings["unignored_pm"]
                            if data.get("is_private")
                            else self.strings["unignored_chat"]
                        )
                        await client.send_message(chat_id_int, template)

                    ignores.pop(chat_id_str, None)

                except Exception as e:
                    logger.exception(f"Failed to auto-unignore chat {chat_id_int}")

        if modified:
            self.db.set("IgnoreChat", "ignores", ignores)

    async def watcher(self, message: Message):
        if not self.config["mute_tags"]:
            return

        if not getattr(message, "mentioned", False):
            return

        if not message.is_group:
            return

        chat_id_str = str(message.chat_id)
        ignores = self.db.get("IgnoreChat", "ignores", {})
        if chat_id_str not in ignores:
            return

        try:
            await self.client.send_read_acknowledge(
                message.chat_id,
                clear_mentions=True,
            )
        except Exception:
            pass