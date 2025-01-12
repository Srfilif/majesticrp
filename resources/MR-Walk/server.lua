local db = exports["MR-Gamemode"]:getDatabase()

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
            if not db then
        p:outputChat("#FF0000[Error] No se pudo conectar a la base de datos.", 255, 50, 50, true)
        return
    end
        local walk = table.concat({...}, " ")
        if walk ~= "" and walk ~= " " then
            local s = trunklateText(p, walk)
            if s:find("Hombre") or s:find("hombre") or s:find("Mujer") or s:find("mujer") or s:find("Borracho") or
                s:find("borracho") or s:find("Prostituta") or s:find("prostituta") or s:find("Gang") or s:find("gang") or
                s:find("Gang2") or s:find("gang2") or s:find("Gordo") or s:find("Mujer2") or s:find("Mujer3") or
                s:find("Viejo") then
                local playerName = getPlayerName(p)
                if not playerName then
                    p:outputChat("#FF0000[Error] No se pudo obtener el nombre del jugador.", 255, 50, 50, true)
                    return
                end
                local query = dbQuery(db, "SELECT id FROM personajes WHERE nombre_apellido = ?", playerName)
                local result = dbPoll(query, -1)
        
                if not result or #result == 0 then
                    p:outputChat("#FF0000[Error] No se encontró un personaje con tu nombre en la base de datos.", 255, 50, 50, true)
                    return
                end
        
                -- Obtenemos el ID del personaje
                local characterID = result[1].id
                if not characterID then
                    p:outputChat("#FF0000[Error] No se pudo obtener el ID del personaje.", 255, 50, 50, true)
                    return
                end
                local updateQuery = dbExec(db, "UPDATE personajes SET caminata = ? WHERE id = ?", selectedWalk[2], characterID)
                if not updateQuery then
                    p:outputChat("#FF0000[Error] No se pudo actualizar el estilo de caminata en la base de datos.", 255, 50, 50, true)
                    return
                end
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
