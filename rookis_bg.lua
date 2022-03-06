local CONFIG = {
    bg_url = {"Background URL", "string", "", "The Background URL."},
}

local MANIFEST = {
    id = "rooki.background.url",
    author = "Rooki",
    name = "Background Changer",
    description = "You can change the background to a url!",
    version = "0.1",
    config = CONFIG,
}

menup(MANIFEST)
local OldDrawBackground = DrawBackground
local WebMaterials = {}
local materials_directory = "rooki_bg"

local function IsExtensionValid(body, headers)
    local contenttype = headers["Content-Type"]
    local isPNG = string.lower(string.sub(body, 2, 4)) == "png" or contenttype == "image/png"
    local isJPEG = string.lower(string.sub(body, 7, 10)) == "jfif" or string.lower(string.sub(body, 7, 10)) == "exif" or contenttype == "image/jpeg"

    return (isPNG and "png") or (isJPEG and "jpg")
end

local function GetExtension(url)
    local isPNG = string.EndsWith(url, ".png")
    local isJPEG = string.EndsWith(url, ".jfif") or string.EndsWith(url, ".jpg") or string.EndsWith(url, ".jpeg") or string.EndsWith(url, ".exif")
    
    return (isPNG and "png") or (isJPEG and "jpg")
end

local function GetMaterial(url)
    if not url then
        return
    end

    if WebMaterials[url] and IsValid(WebMaterials[url]) then
        return
    end
    local cleanurl = string.Replace(url, "/", "")
    cleanurl = string.Replace(cleanurl, ":", "")
    cleanurl = string.Replace(cleanurl, ".", "")
    local ending = GetExtension(url)
    if (file.Exists(materials_directory .. "/" .. cleanurl .. ending, "data")) then
        local dt = file.Read(materials_directory .. "/" .. cleanurl .. ending, "data")
        WebMaterials[url] = Material(dt)
        return
    end
    http.Fetch(url, function(body, size, headers)
        local extension = IsExtensionValid(body, headers)
        local parameters = {}

        print("Loading Started")
        if extension then
            WebMaterials[url] = true

            local material_path = materials_directory .. "/" .. cleanurl .. "." .. extension
            file.Write(material_path, body)
            local path = "data/" .. material_path

            local material = Material(path)
            WebMaterials[url] = material
            print("Finished Loading")
        end
    end, function(err)
        print(ply, "Failed to create material, error: " .. err, 1)

        return
    end)
end

local function load()
    local bgurl = menup.config.get(MANIFEST.id, "bg_url", "")
    if (not bgurl or bgurl == "" or IsInGame()) then return end
    GetMaterial(bgurl)
    function DrawBackground()
        surface.SetAlphaMultiplier(1)
        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(WebMaterials[bgurl] or Material("error"))
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end
end

if (not file.IsDir(materials_directory, "data")) then
    file.CreateDir(materials_directory)
end

hook.Add("ConfigApply", MANIFEST.id, function(id)
    if id == MANIFEST.id then
        WebMaterials = {}
        load()
    end
end)

if IsValid(pnlMainMenu) then
    load()
else
    hook.Add("MenuVGUIReady", MANIFEST.id, function()
        OldDrawBackground = DrawBackground
        load()
    end)
end

return function()
    DrawBackground = OldDrawBackground
end