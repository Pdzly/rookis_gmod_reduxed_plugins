local CONFIG = {
}

local MANIFEST = {
    id = "rooki.time",
    author = "Rooki",
    name = "Adds a timer to the Main Screen",
    description = "Its just adds a Time!",
    version = "0.1",
    config = CONFIG,
    source = "https://raw.githubusercontent.com/Pdzly/rookis_gmod_reduxed_plugins/main/rookis_bg.lua",
    changelog = "Initial Release *It can have bugs!*.",
}

menup(MANIFEST)

return function()
    print(oldbg)

    if (oldbg) then
        DrawBackground = oldbg
    end
end