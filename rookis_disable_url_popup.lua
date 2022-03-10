local CONFIG = {
    clockmode = {"24 (on) / 12 (off) hours clock", "bool", true, "En/Disable the 24 / 12 Hours clock for the AM and PM"},
    hours = {"Enable Hours", "bool", true, "En/Disable hours on the clock"},
    minutes = {"Enable Minutes", "bool", true, "En/Disable minutes on the clock"},
    seconds = {"Enable Seconds", "bool", true, "En/Disable Seconds on the clock"},
    seperator = {"The seperator of the hours minutes and seconds.", "string", "", "For example: 11:10:59 if you enter ':'"},
    font_size = {"The Size of the Font.", "int", 15, "15 is default ( do not spam the save! )"},
}

local MANIFEST = {
    id = "rooki.time",
    author = "Rooki",
    name = "Clock",
    description = "Its just adds a clock!",
    version = "0.1",
    config = CONFIG,
    source = "https://raw.githubusercontent.com/Pdzly/rookis_gmod_reduxed_plugins/main/rookis_time.lua",
    changelog = "Initial Release *It can have bugs!*.",
}

menup(MANIFEST)

local tframe

local function getsize(font, text)
    surface.SetFont(font)

    return surface.GetTextSize(text)
end

local function setConfig()
    
end

local function activate()
    
end

local function deactivate()
    
end

hook.Add("ConfigApply", MANIFEST.id, function(id)
    if id == MANIFEST.id then
        setConfig()
    end
end)

if IsValid(pnlMainMenu) then
        setConfig()
        activate()
else
    hook.Add("MenuVGUIReady", MANIFEST.id, function()
        setConfig()
        activate()
    end)
end

return function()
    deactivate()
end