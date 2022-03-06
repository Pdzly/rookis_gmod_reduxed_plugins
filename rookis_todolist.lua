local CONFIG = {
    savetofile = {"Should the Background data be cached into a file?", "bool", true, "It is good for Pictures that change after a while."},
    bg_url = {"Background URL", "string", "", "The Background URL (PNG OR JPG ONLY it should end with a .jp(e)g or .png)."},
}

local MANIFEST = {
    id = "rooki.todolist",
    author = "Rooki",
    name = "To-Do List in the Main Menu",
    description = "You can change the background to a url!",
    version = "0.1",
    config = CONFIG,
    source = "https://raw.githubusercontent.com/Pdzly/rookis_gmod_reduxed_plugins/main/rookis_bg.lua",
    changelog = "Initial Release *It can have bugs!*.",
}

menup(MANIFEST)