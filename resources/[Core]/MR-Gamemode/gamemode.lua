loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

_addCommandHandler = addCommandHandler
function addCommandHandler(comando, func)
    if type(comando) == 'table' then
        for i, v in ipairs(comando) do
            _addCommandHandler(v, func)
        end
    else
        return _addCommandHandler(comando, func)
    end
end

function blockPM(msg, r)
    cancelEvent()
end
addEventHandler("onPlayerPrivateMessage", getRootElement(), blockPM)

function changeNick()
    cancelEvent()
end
addEventHandler("onPlayerChangeNick", getRootElement(), changeNick)

function preventCommandSpam(command)
    if command == "register" then
        cancelEvent()
    elseif command == "login" then
        cancelEvent()
    elseif command == "logout" then
        cancelEvent()
    end
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)

function onLogout()
    cancelEvent()
end
addEventHandler("onPlayerLogout", getRootElement(), onLogout)

addEventHandler("onPlayerJoin", getRootElement(), function()
    if isElement(source) then
        local nick = removeColorCoding(source:getName())
        source:setTeam(Team.getFromName("Sin logear"))
    end
end)

function desbug(source)
    local x, y, z = getElementPosition(source)
    local CanDesbug = getElementData(source, "Desbug") or 0
    if CanDesbug == 0 then
        outputChatBox("#ff3d3d[DESBUG]#ffFFffHas usado /desbug Correctamente", source, 255, 255, 255, true)
        setElementPosition(source, x, y, z + 2)
        setElementData(source, "Desbug", 1)
        setTimer(function()
            setPedAnimation(source, false)
            setElementData(source, "Desbug", 0)
        end, 5000, 1)
    else
        outputChatBox("#ff3d3d[DESBUG]#ffFFffNo puedes usar este comando espera un poco...", source, 255, 255, 255, true)
    end
end
addCommandHandler("desbug", desbug)
function removeColorCoding(name)
    return type(name) == 'string' and string.gsub(name, '#%x%x%x%x%x%x', '') or name
end

teams = {{"Jail OOC", 20, 20, 20}, {"Staff", 170, 0, 170}, {"Sin logear", 255, 255, 255}, {"AFK", 227, 33, 33}}

addEventHandler("onResourceStart", resourceRoot, function()
    for i, v in ipairs(teams) do
        Team.create(v[1], v[2], v[3], v[4])
    end
    -- time

    setMapName("San Andreas")
    setGameType("Roleplay Español 1.0.0.2")

    for i = 0, 49 do
        setGarageOpen(i, true)
    end
    for index, players in ipairs(Element.getAllByType("player")) do
        if not notIsGuest(players) then
            removeColorCoding(players:getName())
        end
    end
end)

function MensajeRoleplay(player, texto, r, g, b)
    local pos = Vector3(player:getPosition())
    local x, y, z = pos.x, pos.y, pos.z
    local chatCol = ColShape.Sphere(x, y, z, 10)
    local nearPlayers = chatCol:getElementsWithin("player")
    for index, v in ipairs(nearPlayers) do
        v:outputChat("#F900FF* dsadsad " .. _getPlayerNameR(player) .. " " .. (texto or ""), 255, 255, 255, true)
    end
    if isElement(chatCol) then
        destroyElement(chatCol)
    end
end

local ids = {}

addEventHandler("onPlayerJoin", root, function()
    for i = 1, getMaxPlayers() do
        if not ids[i] then
            ids[i] = source
            setElementData(source, "ID", i)
            break
        end
    end
end)

addEventHandler("onResourceStart", resourceRoot, function(resource)
    setTimer(function()
        outputDebugString("")
        outputDebugString("")
        outputDebugString("Gamemode Majestic Roleplay Cargada con exito")
        outputDebugString("")
        outputDebugString("")
        outputDebugString(" _____       _         _   _        _____ _____ ")
        outputDebugString("|     |___  |_|___ ___| |_|_|___   | __  |  _  |")
        outputDebugString("| | | | .'| | | -_|_ -|  _| |  _|  |    -|   __|")
        outputDebugString("|_|_|_|__,|_| |___|___|_| |_|___|  |__|__|__|   ")
        outputDebugString("          |___|                                 ")
        outputDebugString("")
        outputDebugString("© Copyright Majestic Roleplay - Developed by SrFilif")
        outputDebugString("Ths is an open source gamemode | github.com/srfilif/majesticrp")
        outputDebugString("")
        outputDebugString("")
        outputDebugString("")
        outputDebugString("Servidor Inciado correctamente - Majestic Roleplay")
        outputDebugString("")
        outputDebugString("")
    end, 2000, 1)
end)

addEventHandler("onResourceStart", resourceRoot, function()
    for i, source in ipairs(getElementsByType("player")) do
        ids[i] = source
        setElementData(source, "ID", i)

    end
end)

addEventHandler("onPlayerQuit", root, function(type, reason, responsible)
    for i = 1, getMaxPlayers() do
        if ids[i] == source then
            ids[i] = nil

            if reason then
                type = type .. " - " .. reason
                if isElement(responsible) and getElementType(responsible) == "player" then
                    type = type .. " - " .. getPlayerName(responsible)
                end
            end
            break
        end
    end
end)

function getFromName(player, targetName, ignoreLoggedOut)
    if targetName then
        targetName = tostring(targetName)

        local match = {}
        if targetName == "*" then
            match = {player}
        elseif tonumber(targetName) then
            match = {ids[tonumber(targetName)]}
        elseif (getPlayerFromName(targetName)) then
            match = {getPlayerFromName(targetName)}
        else
            for key, value in ipairs(getElementsByType("player")) do
                if getPlayerName(value):lower():find(targetName:lower()) then
                    match[#match + 1] = value
                end
            end
        end

        if #match == 1 then
            if notIsGuest(match[1]) or not notIsGuest(player) then
                return match[1], getPlayerName(match[1]):gsub("_", " "), getElementData(match[1], "ID")
            else
                if player then
                    outputChatBox(getPlayerName(match[1]):gsub("_", " ") .. " no esta logueado.", player, 255, 0, 0)
                end
                return nil -- not logged in error
            end
        elseif #match == 0 then
            if player then
                outputChatBox("No se encuentra al jugador.", player, 255, 0, 0)
            end
            return nil -- no player
        elseif #match > 10 then
            if player then
                outputChatBox(#match .. " jugadores encontrados.", player, 255, 204, 0)
            end
            return nil -- not like we want to show him that many players
        else
            if player then
                outputChatBox("Jugadores encontrados: ", player, 255, 204, 0)
                for key, value in ipairs(match) do
                    outputChatBox("  (" .. getElementData(value, "ID") .. ") " .. getPlayerName(value):gsub("_", " "),
                        player, 255, 255, 0)
                end
            end
            return nil -- more than one player. We list the player names + id.
        end
    end
end

addCommandHandler("id", function(player, commandName, target)
    if not notIsGuest(player) then
        local target, targetName, id = getFromName(player, target)
        if target then
            outputChatBox("La ID de " .. targetName .. " es " .. id .. ".", player, 255, 204, 0)
        end
    end
end)

function aiudaa(source, cmd, ayuda)
    if not notIsGuest(source) then
        if ayuda == "comandos" then
            source:outputChat(" ", 200, 50, 50)
            source:outputChat("#F26E03/duda /payuda /bug /bugeado /staffs", 150, 150, 150, true)
            source:outputChat("#F26E03/caminar /dardinero /pagar /agenda /info /anti-lag", 150, 150, 150, true)
            source:outputChat("#F26E03/idioma /caminar /limpiarchat /cc /stats /tengolag", 150, 150, 150, true)
            source:outputChat("#F26E03/dni /darlicencia /anim /graffiti /dejar [cargador]", 150, 150, 150, true)
            source:outputChat("#F26E03/llamar /colgar /contestar /fixcamera", 150, 150, 150, true)
        elseif ayuda == "facciones" then
            source:outputChat(" ", 200, 50, 50)
            source:outputChat("#F26E03Facciones actuales:", 180, 180, 180, true)
            source:outputChat("#F26E03CHPD - CHFD - CHMW - CHMED", 180, 180, 180, true)
            source:outputChat("#F26E03/contratar /aceptarcontrato /despedir", 150, 150, 150, true)
            source:outputChat("#F26E03/subirrango /bajarrango /miembros", 150, 150, 150, true)
        elseif ayuda == "casas" then
            source:outputChat(" ", 200, 50, 50)
            source:outputChat("#F26E03/comprarcasa /vendercasa /infocasa", 200, 200, 200, true)
            source:outputChat("#F26E03/rentar /unrentar /entrar /salir", 200, 200, 200, true)
        elseif ayuda == "vehiculos" then
            source:outputChat(" ", 200, 50, 50)
            source:outputChat("#F26E03/abrirveh /cerrarveh /localizarveh /venderveh", 200, 200, 200, true)
            source:outputChat("#F26E03/maletero /luces /candado /metermaletero /vermaletero", 190, 190, 190, true)
            source:outputChat("#F26E03/cinturon /vehiculos /estadoveh /comprarveh", 190, 190, 190, true)
        elseif ayuda == "chat" then
            source:outputChat(" ", 200, 50, 50)
            source:outputChat("#F26E03/yo /veryo /guardaryo /g /me /do /b ", 200, 200, 200, true)
            source:outputChat("#F26E03/nomp /mp /s /empezar", 190, 190, 190, true)
        else
            source:outputChat(" ", 200, 50, 50)
            source:outputChat("Syntax: /ayuda < >", 228, 207, 31, true)
            source:outputChat("#F26E03/ayuda comandos - /ayuda facciones ", 200, 50, 50, true)
            source:outputChat("#F26E03/ayuda vehiculos - /ayuda chat /ayuda casas", 200, 50, 50, true) -- /ayuda casas
        end
    end
end
addCommandHandler("ayuda", aiudaa)

local caminatas = {
    ["Hombre"] = {"Hombre", 118},
    ["Mujer"] = {"Mujer", 129},
    ["Mujer2"] = {"Mujer2", 131},
    ["Mujer3"] = {"Mujer3", 132},
    ["Borracho"] = {"Borracho", 126},
    ["Prostituta"] = {"Prostituta", 133},
    ["Gang"] = {"Gang", 121},
    ["Gang2"] = {"Gang2", 122},
    ["Gordo"] = {"Gordo", 55},
    ["Viejo"] = {"Viejo", 120}
}
addCommandHandler({"caminar", "walk", "caminata"}, function(p, cmd, ...)
    if not notIsGuest(p) then
        local walk = table.concat({...}, " ")
        if walk ~= "" and walk ~= " " then
            local s = trunklateText(p, walk)
            if s:find("Hombre") or s:find("hombre") or s:find("Mujer") or s:find("mujer") or s:find("Borracho") or
                s:find("borracho") or s:find("Prostituta") or s:find("prostituta") or s:find("Gang") or s:find("gang") or
                s:find("Gang2") or s:find("gang2") or s:find("Gordo") or s:find("Mujer2") or s:find("Mujer3") or
                s:find("Viejo") then
                p:outputChat("Estilo de caminar: #FF0033" .. tostring(caminatas[s][1]), 30, 150, 30, true)
                p:setWalkingStyle(caminatas[s][2])
            else
                p:outputChat("Solamente puedes poner estos estilos: ", 255, 100, 100, true)
                for i, v in pairs(caminatas) do
                    p:outputChat("#FF9000" .. caminatas[i][1], 60, 30, 100, true)
                end
            end
        else
            p:outputChat("Syntax: /caminar [texto]", 255, 50, 50, true)

        end
    end
end)

