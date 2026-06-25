-- ================================================================
--   MM2 Trade Value Checker
--   Values by @unc3rtainti and codex
--   GUI: two panels (Your Offer / Their Offer), auto-scan + manual
-- ================================================================

local Values = {
    -- ===== SETS (Chroma) =====
    ["Chroma Ever Set"] = 136000, ["Chroma Alien Set"] = 41500, ["Chroma Bauble Set"] = 39800,
    ["Chroma Sun Set"] = 17750, ["Chroma Snow Set"] = 13250, ["Chroma Blizzard Set"] = 12250,
    ["Chroma Sweet Set"] = 5000, ["Chroma Bringer Set"] = 135, ["Chroma Slasher Set"] = 80,
    ["Chroma Pet Set"] = 35,
    -- ===== SETS (Godly) =====
    ["Traveler's Set"] = 14150, ["Ever Set"] = 5825, ["Celestial Set"] = 4725,
    ["Alien Set"] = 3200, ["Dark Set"] = 2980, ["Vampire's Set"] = 2925, ["Sakura Set"] = 2520,
    ["Sun Set"] = 1525, ["Snow Set"] = 1030, ["Soul Set"] = 990, ["Bauble Set"] = 930,
    ["Rainbow Set"] = 830, ["Bloom Set"] = 810, ["Ocean Set"] = 555, ["Xeno Set"] = 540,
    ["Corrupt Set"] = 530, ["Flowerwood Set"] = 515, ["Blizzard Set"] = 500, ["Bow Set"] = 410,
    ["Borealis Set"] = 305, ["Sweet Set"] = 275, ["Full Ice Set"] = 266, ["Pearl Set"] = 195,
    ["Bat Set"] = 158, ["Full Elderwood Set"] = 118, ["Candy Set"] = 117, ["Ice Set"] = 106,
    ["Elderwood Set"] = 80, ["Full Swirly Set"] = 77, ["Spectre Set"] = 76, ["Bringer Set"] = 73,
    ["Swirly Set"] = 62, ["Hallow Set"] = 55, ["Old Glory Set"] = 40, ["Slasher Set"] = 40,
    ["Iceflake Set"] = 38, ["Plasma Set"] = 35, ["Logchopper Set"] = 33, ["Virtual Set"] = 33,
    ["Ginger Set (Godly)"] = 32, ["Cookie Set"] = 30, ["Eternalcane Set"] = 30,
    -- ===== SETS (Legendary/Rare) =====
    ["Pumpkin Set"] = 410, ["Latte Set"] = 400, ["Bats Set"] = 146, ["Zombified Set"] = 95,
    ["Spectral Set"] = 93, ["Traveler Set"] = 93, ["Aurora Set (Legend.)"] = 83,
    ["Vampire Set (Legend.)"] = 83, ["Dark Set (Rare)"] = 81, ["Gingerbread Set"] = 63,
    ["Silent Night Set"] = 62, ["Pumpkin Set (2020)"] = 27, ["Pumpkin Set (2021)"] = 21,
    ["Pumpkin Set (2019)"] = 16, ["Eye Set"] = 14, ["Aurora Set (Rare)"] = 13,
    ["Zombie Set"] = 10, ["Toxic Set"] = 9, ["Cavern Set"] = 8, ["Vampire Set (Rare)"] = 8,
    ["Potion Set"] = 8, ["Frozen Set"] = 7, ["Ghost Set"] = 7, ["Mummy Set"] = 7,
    ["Slime Set"] = 7, ["Candy Swirl Set"] = 6, ["Icedriller Set"] = 6, ["Full Elite Set"] = 6,
    ["Lights Set"] = 6, ["Santa's Set (Legend.)"] = 6, ["Scratch Set"] = 6, ["Grave Set"] = 5,
    ["Snakebite Set"] = 4, ["Marble Set"] = 4, ["Wrap Set"] = 2, ["Haunted Set"] = 2,
    -- ===== SETS (Misc) =====
    ["Full Bringer Set"] = 210, ["Full Luger Set"] = 200, ["Luger Set"] = 145, ["Sparkle Set"] = 127,
    ["Collectible Set"] = 71, ["Vintage Set"] = 61, ["Eternal Set"] = 51,
    ["Full Colored Seer Set"] = 48, ["Skate Set"] = 30, ["Pals Set"] = 16,
    ["Colored Seer Set"] = 16, ["Wrapping Paper Set"] = 14, ["Godly Pet Set"] = 10,
    ["Small Set (107)"] = 1435, ["Small Set (103)"] = 1365,
    ["Full Chroma Set"] = 615, ["Chroma Weapon Set"] = 580,
    -- ===== GODLY WEAPONS =====
    ["Corrupt"] = 485, ["Gingerscope"] = 17750, ["Traveler's Axe"] = 8400,
    ["Celestial"] = 2000, ["Vampire's Axe"] = 1225, ["Harvester"] = 250,
    ["Icepiercer"] = 160, ["Icebreaker"] = 68, ["Batwing"] = 45,
    ["Elderwood Scythe"] = 42, ["Swirly Axe"] = 42, ["Hallowscythe"] = 32,
    ["Logchopper"] = 18, ["Icewing"] = 15, ["Ghost"] = 10, ["Blood"] = 8,
    ["Laser"] = 23, ["America"] = 7, ["Prince"] = 6, ["Shadow"] = 6,
    ["Phaser"] = 5, ["Cowboy"] = 4, ["Golden"] = 4, ["Splitter"] = 3,
    -- ===== CHROMA WEAPONS =====
    ["C. Traveler's Gun"] = 220000, ["Chroma Evergun"] = 76000, ["Chroma Evergreen"] = 60000,
    ["Chroma Bauble"] = 38000, ["C. Vampire's Gun"] = 32000, ["C. Constellation"] = 29000,
    ["Chroma Alienbeam"] = 27000, ["Chroma Raygun"] = 14500, ["Chroma Sunrise"] = 11250,
    ["C. Snowcannon"] = 8500, ["Chroma Blizzard"] = 8000, ["Chroma Sunset"] = 6500,
    ["C. Snow Dagger"] = 4750, ["C. Heart Wand"] = 4750, ["Chroma Snowstorm"] = 4250,
    ["Chroma Watergun"] = 3400, ["Chroma Treat"] = 2700, ["Chroma Sweet"] = 2300,
    ["Chroma Ornament"] = 1800, ["C. Darkbringer"] = 70, ["C. Lightbringer"] = 65,
    ["Chroma Luger"] = 52, ["C. Candleflame"] = 42, ["C. Elderwood Blade"] = 42,
    ["Chroma Laser"] = 42, ["C. Swirly Gun"] = 42, ["C. Cookiecane"] = 38,
    ["Chroma Slasher"] = 38, ["C. Deathshard"] = 35, ["Chroma Fang"] = 32,
    ["Chroma Gemstone"] = 32, ["C. Gingerblade"] = 32, ["Chroma Heat"] = 32,
    ["Chroma Seer"] = 32, ["Chroma Shark"] = 32, ["Chroma Saw"] = 30, ["Chroma Tides"] = 30,
    ["Chroma Boneblade"] = 25, ["Chroma Fire Bat"] = 5, ["Chroma Fire Bear"] = 5,
    ["C. Fire Bunny"] = 5, ["Chroma Fire Cat"] = 5, ["Chroma Fire Dog"] = 5,
    ["Chroma Fire Fox"] = 5, ["Chroma Fire Pig"] = 5,
    -- ===== GODLY GUNS / KNIVES =====
    ["Traveler's Gun"] = 5750, ["Evergun"] = 3350, ["Constellation"] = 2725,
    ["Evergreen"] = 2475, ["Turkey"] = 2450, ["Alienbeam"] = 2000, ["Vampire's Gun"] = 1700,
    ["Darkshot"] = 1500, ["Darksword"] = 1480, ["Blossom"] = 1265, ["Sakura"] = 1255,
    ["Raygun"] = 1200, ["Sunrise"] = 1025, ["Bauble"] = 900, ["Snowcannon"] = 800,
    ["Soul"] = 500, ["Sunset"] = 500, ["Spirit"] = 490, ["Rainbow Gun"] = 420,
    ["Flora"] = 410, ["Rainbow"] = 410, ["Bloom"] = 400, ["Heart Wand"] = 330,
    ["Ocean"] = 280, ["Waves"] = 275, ["Xenoknife"] = 270, ["Xenoshot"] = 270,
    ["Flowerwood Gun"] = 260, ["Flowerwood"] = 255, ["Blizzard"] = 250, ["Snowstorm"] = 250,
    ["Watergun"] = 250, ["Snow Dagger"] = 230, ["Borealis"] = 155, ["Australis"] = 150,
    ["Treat"] = 140, ["Sweet"] = 135, ["Bat"] = 120, ["Pearlshine"] = 100, ["Pearl"] = 95,
    ["Candy"] = 80, ["Heartblade"] = 68, ["Luger"] = 45, ["Red Luger"] = 42,
    ["Candleflame"] = 38, ["Darkbringer"] = 38, ["Elderwood Blade"] = 38,
    ["Elderwood Revolver"] = 38, ["Iceblaster"] = 38, ["Makeshift"] = 38,
    ["Phantom"] = 10, ["Spectre"] = 38, ["Sugar"] = 37, ["Lightbringer"] = 35,
    ["Ornament"] = 28, ["Green Luger"] = 25, ["Amerilaser"] = 23, ["Hallowgun"] = 23,
    ["Icebeam"] = 20, ["Nightblade"] = 20, ["Shark"] = 20, ["Swirly Gun"] = 20,
    ["Blaster"] = 18, ["Iceflake"] = 18, ["Plasmabeam"] = 18, ["Battleaxe II"] = 17,
    ["Ginger Luger"] = 17, ["Old Glory"] = 17, ["Pixel"] = 17, ["Plasmablade"] = 17,
    ["Slasher"] = 17, ["Cookiecane"] = 15, ["Eternalcane"] = 15, ["Gemstone"] = 15,
    ["Gingerblade"] = 15, ["Gingermint"] = 15, ["Jinglegun"] = 15, ["Lugercane"] = 15,
    ["Minty"] = 15, ["Nebula"] = 15, ["Swirly Blade"] = 15, ["Vampire's Edge"] = 15,
    ["Virtual"] = 15, ["Deathshard"] = 13, ["Battleaxe"] = 12, ["Bioblade"] = 10,
    ["Chill"] = 10, ["Clockwork"] = 10, ["Eternal III"] = 10, ["Eternal IV"] = 10,
    ["Fang"] = 10, ["Frostsaber"] = 10, ["Heat"] = 10, ["Spider"] = 10, ["Tides"] = 10,
    ["Eternal"] = 8, ["Eternal II"] = 8, ["Hallow's Blade"] = 8, ["Hallow's Edge"] = 8,
    ["Handsaw"] = 8, ["Xmas"] = 8, ["Boneblade"] = 7, ["Frostbite"] = 7,
    ["Ghostblade"] = 7, ["Ice Dragon"] = 7, ["Ice Shard"] = 7, ["Prismatic"] = 7,
    ["Pumpking"] = 7, ["Saw"] = 7, ["Eggblade"] = 5, ["Flames"] = 5,
    ["Snowflake"] = 20, ["Winter's Edge"] = 5, ["Peppermint"] = 4, ["Cookieblade"] = 3,
    ["Blue Seer"] = 3, ["Purple Seer"] = 3, ["Red Seer"] = 3, ["Seer"] = 3,
    ["Orange Seer"] = 2, ["Yellow Seer"] = 2, ["JD"] = 35,
    -- ===== LEGENDARIES =====
    ["Latte (Gun)"] = 200, ["Latte (Knife)"] = 200, ["Spectral (Knife)"] = 90,
    ["Traveler (Gun)"] = 90, ["Aurora (Gun)"] = 1, ["Vampire (Gun)"] = 7,
    ["Cotton Candy"] = 40, ["Beach"] = 30, ["Arctic (Gun)"] = 10, ["Cavern (Knife)"] = 7,
    ["Broken"] = 7, ["Icedriller"] = 5, ["Nightsky"] = 5, ["Ghost (Knife)"] = 5,
    ["Ginger (Gun)"] = 5, ["Bunnies"] = 4, ["Red Scratch"] = 4, ["Skulls"] = 15,
    ["Aurora (Knife)"] = 12, ["Spectral (Gun)"] = 3, ["Traveler (Knife)"] = 3,
    ["Vampire (Knife)"] = 1, ["Witched"] = 3, ["Blue Elite"] = 3, ["Green Elite"] = 3,
    ["Santa's Magic"] = 3, ["Santa's Spirit"] = 3, ["Energized (Gun)"] = 2,
    ["Blue Scratch"] = 2, ["Ghost (Gun)"] = 2, ["Chromatic (Knife)"] = 1,
    ["Frostfade (Knife)"] = 1, ["Icecracker"] = 1, ["Red Fire"] = 1, ["Cavern (Gun)"] = 1,
    -- ===== RARES =====
    ["Cane Knife (2018)"] = 725, ["Dungeon"] = 175, ["Darkknife"] = 80,
    ["Silent Night (Knife)"] = 50, ["Makeshift (Knife)"] = 45, ["Zombified"] = 40,
    ["Swirl"] = 25, ["Starry (Gun)"] = 20, ["Floral (Knife)"] = 12,
    ["Silent Night (Gun)"] = 12, ["Magma (Gun)"] = 10, ["Watcher (Gun)"] = 10,
    ["Icicles (Gun)"] = 8, ["Toxic (Knife)"] = 7, ["Ghastly (Gun)"] = 5,
    ["Candy Swirl (Gun)"] = 5, ["Sun"] = 5, ["Magma"] = 5, ["Ghostfire"] = 3,
    ["Jack"] = 3, ["Snakebite (Knife)"] = 3, ["Bats"] = 3, ["Monster"] = 3,
    ["Snowflakes"] = 2, ["Green Marble"] = 2, ["Orange Marble"] = 2, ["Toxic (Gun)"] = 2,
    ["Darkgun"] = 1, ["Gingerbread"] = 1, ["Candy Swirl (Knife)"] = 1,
    ["Snakebite (Gun)"] = 1, ["Bones"] = 1, ["Zombified (Knife)"] = 80, ["Brains"] = 1,
    ["Gingerbread (Knife)"] = 1, ["Sweater (Knife)"] = 60, ["Branches"] = 35,
    ["Zombified (Gun)"] = 15, ["Void"] = 12, ["Zombie (Gun)"] = 8, ["Frozen (Gun)"] = 5,
    ["Lights (Gun)"] = 5, ["Mummy 2018 (Gun)"] = 5, ["Potion (Knife)"] = 5,
    ["Gothic (Gun)"] = 3, ["Gingerbread (Gun)"] = 3, ["Webs"] = 3, ["Pumpkin Pie"] = 3,
    ["Holly (Gun)"] = 3, ["Potion (2017)"] = 3, ["Potion (Gun)"] = 3, ["Steel (Gun)"] = 2,
    ["Frozen (Knife)"] = 2, ["Mummy (2017)"] = 2, ["Mummy 2018 (Knife)"] = 2,
    ["Zombie (Knife)"] = 2, ["Zombie"] = 7, ["Wrap (Gun)"] = 1, ["Wrap (Knife)"] = 1,
    ["Lights (Knife)"] = 1, ["Moons"] = 1, ["Vampire"] = 1, ["Wolf"] = 1,
    -- ===== COMMONS =====
    ["Glitch1"] = 75, ["Glitch2"] = 50, ["Ghoulish"] = 150, ["Bats (Knife)"] = 145,
    ["Gifts (Knife)"] = 85, ["Pine (Knife)"] = 80, ["Sparkle9"] = 30,
    ["Snowman Gun"] = 22, ["Wrapped Gun"] = 22, ["Frosted (Knife)"] = 20,
    ["Snowflakes (Gun)"] = 20, ["CandyCorn 2017"] = 20, ["Sparkle10"] = 20,
    ["Sparkle8"] = 20, ["Sparkle7"] = 18, ["Elf (Knife)"] = 17, ["Coal (Knife)"] = 15,
    ["RIP"] = 15, ["Webbed (Gun)"] = 12, ["Prism"] = 12, ["Sparkle6"] = 12,
    ["Combat II"] = 10, ["Ecto"] = 10, ["Sparkle4"] = 10, ["Skool"] = 8,
    ["Sparkle5"] = 8, ["Tailslide"] = 8, ["Pumpkin (2019)"] = 7, ["Ollie"] = 7,
    ["Sidewinder"] = 7, ["Mummified"] = 5, ["Starry"] = 5, ["Euro"] = 4,
    ["Sketchy"] = 4, ["Grave (Gun)"] = 4, ["Slime (Knife)"] = 4,
    ["CandyCorn (2019)"] = 3, ["Alex"] = 3, ["Corl"] = 3, ["Denis"] = 3, ["Sub"] = 3,
    ["Ghosty"] = 1, ["Sparkle1"] = 3, ["Sparkle2"] = 3, ["Sparkle3"] = 3,
    ["Asteroid"] = 3, ["Slime (Gun)"] = 3, ["Slimy"] = 2, ["Grind"] = 2,
    ["Indy"] = 2, ["Elf (2018)"] = 1, ["Bats (Gun)"] = 1, ["Grave (Knife)"] = 1,
    ["Haunted (Gun)"] = 1, ["Haunted (Knife)"] = 1, ["Witch"] = 1,
    -- ===== PETS =====
    ["Zombie Dog"] = 800, ["Elf (2019)"] = 275, ["Black Cat"] = 240,
    ["Blue Pumpkin (2018)"] = 220, ["Dogey"] = 130, ["Red Pumpkin (2018)"] = 120,
    ["Green Pumpkin (2018)"] = 60, ["Pumpkin (2017)"] = 45, ["Mr. Reindeer"] = 45,
    ["Piggy"] = 30, ["Elf"] = 12, ["Red Pumpkin (2020)"] = 12,
    ["Green Pumpkin (2020)"] = 10, ["Red Pumpkin (2021)"] = 10, ["Skully"] = 10,
    ["<3"] = 10, ["Green Pumpkin (2021)"] = 8, ["Fairy"] = 8, ["Nobledragon"] = 8,
    ["Seahorsey"] = 8, ["Mr. Snowman"] = 7, ["Chilly"] = 7, ["Eyeball"] = 7,
    ["Green Pumpkin (2019)"] = 7, ["Jetstream"] = 7, ["Overseer Eye"] = 7, ["Pengy"] = 7,
    ["Purple Pumpkin (2018)"] = 7, ["Red Pumpkin (2019)"] = 7, ["Reindeer"] = 7,
    ["Rudolph"] = 7, ["Tankie"] = 7, ["Vampire Bat"] = 7, ["Blue Pumpkin (2020)"] = 5,
    ["Mechbug"] = 5, ["UFO"] = 4, ["Shadow Pumpkin"] = 3, ["Blue Pumpkin (2019)"] = 2,
    ["Badger"] = 1, ["Deathspeaker"] = 1, ["Electro"] = 1, ["Frostbird"] = 1,
    ["Ice Phoenix"] = 1, ["Phoenix"] = 1, ["Sammy"] = 1, ["Skelly"] = 1,
    ["Steambird"] = 1, ["Traveller"] = 1,
    -- ===== MISC =====
    ["Santa 2019"] = 35, ["Mystery Key"] = 1, ["Box of Blue Papers"] = 2,
    ["Box of Fertilizer"] = 2, ["Box of Gold Papers"] = 2, ["Box of Green Papers"] = 2,
    ["Box of Purple Papers"] = 2, ["Box of Red Papers"] = 2, ["Box of Ultra Wrap"] = 2,
    ["Skeleton Key"] = 5,
}

-- ================================================================
-- SERVICES & CONSTANTS
-- ================================================================
local Players   = game:GetService("Players")
local LP        = Players.LocalPlayer
local Camera    = workspace.CurrentCamera

local W, H = 540, 460

-- Colours
local C = {
    bg      = Color3.fromRGB(14, 14, 24),
    titleBg = Color3.fromRGB(9,  9, 18),
    panel   = Color3.fromRGB(22, 22, 36),
    row     = Color3.fromRGB(32, 32, 52),
    blue    = Color3.fromRGB(55, 115, 215),
    dblue   = Color3.fromRGB(35,  70, 160),
    red     = Color3.fromRGB(200,  50,  50),
    dred    = Color3.fromRGB(130,  30,  30),
    green   = Color3.fromRGB(55, 185,  85),
    gold    = Color3.fromRGB(215, 165,  35),
    text    = Color3.fromRGB(228, 228, 240),
    dim     = Color3.fromRGB(130, 130, 155),
}

-- ================================================================
-- SCREEN GUI
-- ================================================================
local SG = Instance.new("ScreenGui")
SG.Name             = "MM2ValueChecker"
SG.ResetOnSpawn     = false
SG.ZIndexBehavior   = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset   = true

local ok = pcall(function() SG.Parent = game:GetService("CoreGui") end)
if not ok or not SG.Parent then
    SG.Parent = LP:WaitForChild("PlayerGui")
end

-- ================================================================
-- HELPERS
-- ================================================================
local function rc(inst, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = inst
end

local function shadow(parent)
    -- subtle inner shadow via UIStroke
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(0,0,0)
    s.Transparency = 0.6
    s.Thickness = 1
    s.Parent = parent
end

local function Frame(parent, p)
    local f = Instance.new("Frame")
    f.BackgroundColor3 = C.panel
    f.BorderSizePixel  = 0
    for k,v in pairs(p or {}) do f[k]=v end
    f.Parent = parent
    return f
end

local function Label(parent, p)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.BorderSizePixel  = 0
    l.TextColor3       = C.text
    l.Font             = Enum.Font.GothamMedium
    l.TextSize         = 13
    l.TextXAlignment   = Enum.TextXAlignment.Center
    l.TextYAlignment   = Enum.TextYAlignment.Center
    for k,v in pairs(p or {}) do l[k]=v end
    l.Parent = parent
    return l
end

local function Btn(parent, p)
    local b = Instance.new("TextButton")
    b.AutoButtonColor = false
    b.BorderSizePixel = 0
    b.TextColor3      = C.text
    b.Font            = Enum.Font.GothamBold
    b.TextSize        = 13
    for k,v in pairs(p or {}) do b[k]=v end
    b.Parent = parent
    return b
end

local function Inp(parent, p)
    local i = Instance.new("TextBox")
    i.BorderSizePixel  = 0
    i.TextColor3       = C.text
    i.PlaceholderColor3= C.dim
    i.Font             = Enum.Font.GothamMedium
    i.TextSize         = 12
    i.ClearTextOnFocus = false
    for k,v in pairs(p or {}) do i[k]=v end
    i.Parent = parent
    return i
end

local function fmtNum(n)
    if not n then return "N/A" end
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,"):reverse():gsub("^,","")
end

local function getVal(name)
    if Values[name] then return Values[name] end
    local lo = name:lower()
    for k,v in pairs(Values) do
        if k:lower() == lo then return v end
    end
    return nil
end

-- ================================================================
-- MAIN WINDOW
-- ================================================================
local Win = Frame(SG, {
    Name             = "Window",
    Size             = UDim2.new(0, W, 0, H),
    Position         = UDim2.new(0.5, -W/2, 0.5, -H/2),
    BackgroundColor3 = C.bg,
    Active           = true,
    Draggable        = true,
})
rc(Win, 10)

-- ---- Title bar ----
local TBar = Frame(Win, {
    Size             = UDim2.new(1,0,0,38),
    BackgroundColor3 = C.titleBg,
})
rc(TBar, 10)
-- Mask bottom corners of titlebar
Frame(TBar, {Size=UDim2.new(1,0,0.5,0), Position=UDim2.new(0,0,0.5,0), BackgroundColor3=C.titleBg})

Label(TBar, {
    Size             = UDim2.new(1,-96,1,0),
    Position         = UDim2.new(0,12,0,0),
    Text             = "⚔  MM2 Trade Value Checker",
    Font             = Enum.Font.GothamBold,
    TextSize         = 15,
    TextXAlignment   = Enum.TextXAlignment.Left,
})

local MinBtn = Btn(TBar, {
    Size             = UDim2.new(0,28,0,22),
    Position         = UDim2.new(1,-66,0.5,-11),
    BackgroundColor3 = C.dblue,
    Text             = "–", TextSize = 17,
})
rc(MinBtn,5)

local XBtn = Btn(TBar, {
    Size             = UDim2.new(0,28,0,22),
    Position         = UDim2.new(1,-33,0.5,-11),
    BackgroundColor3 = C.dred,
    Text             = "✕", TextSize = 13,
})
rc(XBtn,5)
XBtn.MouseButton1Click:Connect(function() SG:Destroy() end)

-- ---- Content wrapper (shown/hidden on minimize) ----
local Content = Frame(Win, {
    Size             = UDim2.new(1,0,1,-38),
    Position         = UDim2.new(0,0,0,38),
    BackgroundTransparency = 1,
})

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    Win.Size = minimized and UDim2.new(0,W,0,38) or UDim2.new(0,W,0,H)
    MinBtn.Text = minimized and "+" or "–"
end)

-- ================================================================
-- TWO TRADE PANELS
-- ================================================================
local PANEL_H = 290

local function makePanel(parent, xPos, headerCol, headerText)
    local panel = Frame(parent, {
        Size             = UDim2.new(0.5,-7,0,PANEL_H),
        Position         = UDim2.new(xPos, xPos==0 and 6 or 1, 0, 8),
        BackgroundColor3 = C.panel,
    })
    rc(panel, 8)
    shadow(panel)

    -- header
    local hdr = Frame(panel, {
        Size             = UDim2.new(1,0,0,28),
        BackgroundColor3 = headerCol,
    })
    rc(hdr, 6)
    Frame(hdr, {Size=UDim2.new(1,0,0.5,0), Position=UDim2.new(0,0,0.5,0), BackgroundColor3=headerCol})
    Label(hdr, {Size=UDim2.new(1,0,1,0), Text=headerText, Font=Enum.Font.GothamBold, TextSize=12})

    -- scroll
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size                = UDim2.new(1,-8, 1,-58)
    scroll.Position            = UDim2.new(0,4, 0,30)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel     = 0
    scroll.ScrollBarThickness  = 3
    scroll.ScrollBarImageColor3= headerCol
    scroll.CanvasSize          = UDim2.new(0,0,0,0)
    scroll.Parent              = panel
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,2)
    layout.Parent  = scroll

    -- total footer
    local totFrame = Frame(panel, {
        Size             = UDim2.new(1,0,0,26),
        Position         = UDim2.new(0,0,1,-26),
        BackgroundColor3 = headerCol,
    })
    rc(totFrame, 5)
    local totLabel = Label(totFrame, {
        Size    = UDim2.new(1,0,1,0),
        Text    = "Total: 0",
        Font    = Enum.Font.GothamBold,
        TextSize= 13,
    })

    return panel, scroll, layout, totFrame, totLabel
end

local _, MyScroll,  MyLayout,  MyTotFrame,  MyTotLabel  = makePanel(Content, 0,   C.blue, "🔵  YOUR OFFER")
local _, ThScroll, ThLayout,  ThTotFrame,  ThTotLabel  = makePanel(Content, 0.5, C.red,  "🔴  THEIR OFFER")

-- ================================================================
-- MANUAL INPUT ROW
-- ================================================================
local InputRow = Frame(Content, {
    Size             = UDim2.new(1,-12,0,28),
    Position         = UDim2.new(0,6,0,PANEL_H+14),
    BackgroundTransparency = 1,
})

local ItemBox = Inp(InputRow, {
    Size             = UDim2.new(1,-178,1,0),
    BackgroundColor3 = C.row,
    PlaceholderText  = "Type item name and press Enter / button →",
    TextXAlignment   = Enum.TextXAlignment.Left,
})
rc(ItemBox, 6)
do
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0,7)
    pad.Parent = ItemBox
end

local AddMyBtn = Btn(InputRow, {
    Size             = UDim2.new(0,82,1,0),
    Position         = UDim2.new(1,-174,0,0),
    BackgroundColor3 = C.dblue,
    Text             = "+ My Side",
    TextSize         = 12,
})
rc(AddMyBtn, 6)

local AddThBtn = Btn(InputRow, {
    Size             = UDim2.new(0,88,1,0),
    Position         = UDim2.new(1,-88,0,0),
    BackgroundColor3 = C.dred,
    Text             = "+ Their Side",
    TextSize         = 12,
})
rc(AddThBtn, 6)

-- ================================================================
-- BUTTON ROW
-- ================================================================
local BtnRow = Frame(Content, {
    Size             = UDim2.new(1,-12,0,32),
    Position         = UDim2.new(0,6,0,PANEL_H+48),
    BackgroundTransparency = 1,
})

local ScanBtn = Btn(BtnRow, {
    Size             = UDim2.new(1/3,-4,1,0),
    Position         = UDim2.new(0,0,0,0),
    BackgroundColor3 = Color3.fromRGB(45,150,75),
    Text             = "🔍 Auto Scan",
    TextSize         = 12,
})
rc(ScanBtn, 7)

local AutoBtn = Btn(BtnRow, {
    Size             = UDim2.new(1/3,-4,1,0),
    Position         = UDim2.new(1/3,2,0,0),
    BackgroundColor3 = Color3.fromRGB(80,55,140),
    Text             = "⏱ Auto: OFF",
    TextSize         = 12,
})
rc(AutoBtn, 7)

local ClearBtn = Btn(BtnRow, {
    Size             = UDim2.new(1/3,-4,1,0),
    Position         = UDim2.new(2/3,4,0,0),
    BackgroundColor3 = C.dred,
    Text             = "🗑 Clear",
    TextSize         = 12,
})
rc(ClearBtn, 7)

-- Status bar
local StatusL = Label(Content, {
    Size           = UDim2.new(1,-12,0,16),
    Position       = UDim2.new(0,6,1,-20),
    Text           = "Ready — open a trade window, then click  Auto Scan.",
    TextSize       = 11,
    TextColor3     = C.dim,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font           = Enum.Font.Gotham,
})

-- ================================================================
-- ITEM DATA
-- ================================================================
local myItems    = {}   -- { name, value }
local theirItems = {}

local function makeItemRow(scroll, name, val, idx)
    local row = Frame(scroll, {
        Name             = "r"..idx,
        Size             = UDim2.new(1,0,0,22),
        BackgroundColor3 = C.row,
    })
    rc(row, 4)
    Label(row, {
        Size           = UDim2.new(0.62,-4,1,0),
        Position       = UDim2.new(0,6,0,0),
        Text           = name,
        TextSize       = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate   = Enum.TextTruncate.AtEnd,
        Font           = Enum.Font.Gotham,
    })
    Label(row, {
        Size           = UDim2.new(0.38,-6,1,0),
        Position       = UDim2.new(0.62,0,0,0),
        Text           = val and fmtNum(val) or "?",
        TextSize       = 11,
        TextColor3     = val and C.green or C.gold,
        Font           = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Right,
    })
    return row
end

local function updateTotals()
    local myT, thT = 0, 0
    for _, it in ipairs(myItems)    do myT = myT + (it.value or 0) end
    for _, it in ipairs(theirItems) do thT = thT + (it.value or 0) end

    MyTotLabel.Text = "Total: " .. fmtNum(myT)
    ThTotLabel.Text = "Total: " .. fmtNum(thT)

    if myT == 0 and thT == 0 then
        MyTotFrame.BackgroundColor3 = C.dblue
        ThTotFrame.BackgroundColor3 = C.dred
        StatusL.Text      = "Ready — open a trade window, then click  Auto Scan."
        StatusL.TextColor3 = C.dim
        return
    end

    local diff = thT - myT
    local base = math.max(myT, thT, 1)
    local pct  = math.round(math.abs(diff) / base * 100)

    if math.abs(diff) <= base * 0.10 then          -- within 10% = fair
        MyTotFrame.BackgroundColor3 = Color3.fromRGB(105,85,15)
        ThTotFrame.BackgroundColor3 = Color3.fromRGB(105,85,15)
        StatusL.Text       = ("⚖ Fair trade (~%d%%) | You: %s | Them: %s"):format(pct, fmtNum(myT), fmtNum(thT))
        StatusL.TextColor3 = C.gold
    elseif diff > 0 then                            -- winning
        MyTotFrame.BackgroundColor3 = Color3.fromRGB(25,100,45)
        ThTotFrame.BackgroundColor3 = C.dred
        StatusL.Text       = ("✅ You WIN +%d%% (+%s) | You: %s | Them: %s"):format(pct, fmtNum(diff), fmtNum(myT), fmtNum(thT))
        StatusL.TextColor3 = C.green
    else                                            -- losing
        MyTotFrame.BackgroundColor3 = C.dblue
        ThTotFrame.BackgroundColor3 = Color3.fromRGB(130,30,30)
        StatusL.Text       = ("❌ You LOSE -%d%% (-%s) | You: %s | Them: %s"):format(pct, fmtNum(-diff), fmtNum(myT), fmtNum(thT))
        StatusL.TextColor3 = C.red
    end
end

local function refreshDisplay()
    for _, c in ipairs(MyScroll:GetChildren())  do if not c:IsA("UIListLayout") then c:Destroy() end end
    for _, c in ipairs(ThScroll:GetChildren())  do if not c:IsA("UIListLayout") then c:Destroy() end end
    for i, it in ipairs(myItems)    do makeItemRow(MyScroll, it.name, it.value, i) end
    for i, it in ipairs(theirItems) do makeItemRow(ThScroll, it.name, it.value, i) end
    task.wait()
    MyScroll.CanvasSize = UDim2.new(0,0,0, MyLayout.AbsoluteContentSize.Y + 4)
    ThScroll.CanvasSize = UDim2.new(0,0,0, ThLayout.AbsoluteContentSize.Y + 4)
    updateTotals()
end

-- ================================================================
-- AUTO-SCAN  (scans all GUI text elements, splits by screen centre)
-- ================================================================
local function autoScan()
    StatusL.Text       = "Scanning…"
    StatusL.TextColor3 = C.dim

    local newMy, newTh = {}, {}
    local seenObj   = {}   -- prevents counting same Instance twice
    local seenName  = {my={}, th={}}  -- prevents duplicate names per side
    local cX = Camera.ViewportSize.X / 2

    local roots = { LP:WaitForChild("PlayerGui") }
    pcall(function() table.insert(roots, game:GetService("CoreGui")) end)

    for _, root in ipairs(roots) do
        for _, desc in ipairs(root:GetDescendants()) do
            if not seenObj[desc] and
               (desc:IsA("TextLabel") or desc:IsA("TextButton")) then

                local ok2, txt = pcall(function() return desc.Text end)
                if ok2 and txt and #txt >= 2 then
                    local val = getVal(txt)
                    if val then
                        seenObj[desc] = true
                        local ap  = desc.AbsolutePosition
                        local entry = { name = txt, value = val }

                        if ap.X < cX then
                            if not seenName.my[txt] then
                                seenName.my[txt] = true
                                table.insert(newMy, entry)
                            end
                        else
                            if not seenName.th[txt] then
                                seenName.th[txt] = true
                                table.insert(newTh, entry)
                            end
                        end
                    end
                end
            end
        end
    end

    myItems    = newMy
    theirItems = newTh
    refreshDisplay()

    local total = #newMy + #newTh
    if total == 0 then
        StatusL.Text       = "⚠ No items found — make sure the MM2 trade window is open!"
        StatusL.TextColor3 = C.gold
    end
end

-- ================================================================
-- MANUAL ADD
-- ================================================================
local function manualAdd(side)
    local name = ItemBox.Text
    if not name or name:match("^%s*$") then
        StatusL.Text = "⚠ Enter an item name first."
        StatusL.TextColor3 = C.gold
        return
    end
    local val   = getVal(name)
    local entry = { name = name, value = val }
    if side == "my" then
        table.insert(myItems, entry)
    else
        table.insert(theirItems, entry)
    end
    ItemBox.Text = ""
    if not val then
        StatusL.Text       = "⚠ '"..name.."' not in value list (added as ?)."
        StatusL.TextColor3 = C.gold
    end
    refreshDisplay()
end

-- ================================================================
-- CONNECTIONS
-- ================================================================
ScanBtn.MouseButton1Click:Connect(function() pcall(autoScan) end)

ClearBtn.MouseButton1Click:Connect(function()
    myItems, theirItems = {}, {}
    refreshDisplay()
    StatusL.Text       = "Cleared."
    StatusL.TextColor3 = C.dim
end)

AddMyBtn.MouseButton1Click:Connect(function() manualAdd("my") end)
AddThBtn.MouseButton1Click:Connect(function() manualAdd("th") end)

ItemBox.FocusLost:Connect(function(enter)
    if enter then manualAdd("my") end
end)

-- Auto-repeat toggle (every 3 s)
local autoRunning = false
AutoBtn.MouseButton1Click:Connect(function()
    autoRunning = not autoRunning
    AutoBtn.Text             = autoRunning and "⏱ Auto: ON" or "⏱ Auto: OFF"
    AutoBtn.BackgroundColor3 = autoRunning
        and Color3.fromRGB(50,140,60)
        or  Color3.fromRGB(80,55,140)
end)

task.spawn(function()
    while SG.Parent do
        task.wait(3)
        if autoRunning then
            pcall(autoScan)
        end
    end
end)

-- ================================================================
print("[MM2ValueChecker] Loaded! Open a trade and click Auto Scan.")
-- ================================================================
