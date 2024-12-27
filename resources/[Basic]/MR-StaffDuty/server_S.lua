
function getPlayerID(id)
	v = false
	for i, player in ipairs (getElementsByType("player")) do
		if getElementData(player, "ID") == id then
			v = player
			break
		end
	end
	return v
end


----------------- Fuel
addCommandHandler("setgas", function(playerSource, commandName, id, amount)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Ayudante")) then
        local playerID = tonumber(id)
        local fuelAmount = tonumber(amount)

        if not playerID then
            outputChatBox("#ff3d3d* La ID de este jugador no es válida.", playerSource, 255, 255, 255, true)
            return
        end

        if not fuelAmount or fuelAmount < 0 or fuelAmount > 100 then
            outputChatBox("#ff3d3d* Por favor especifica una cantidad de gasolina válida (0-100).", playerSource, 255, 255, 255, true)
            return
        end

        local targetPlayer = getPlayerID(playerID)
        if targetPlayer then
            local veh = getPedOccupiedVehicle(targetPlayer)
            if veh then
                setElementData(veh, "Fuel", fuelAmount)
                outputChatBox("#ffFFff* Has establecido la cantidad de Gasolina del vehículo de #edff21"..getPlayerName(targetPlayer).." #ffFFff actualizada a: #00ff00" .. fuelAmount .. "%", playerSource, 255, 255, 255, true)
            else
                outputChatBox("#ff3d3d* El jugador no está en un vehículo.", playerSource, 255, 255, 255, true)
            end
        else
            outputChatBox("#ff3d3d* No se encontró al jugador con la ID especificada.", playerSource, 255, 255, 255, true)
        end
    else
        outputChatBox("#ff3d3d* No tienes permisos para usar este comando.", playerSource, 255, 255, 255, true)
    end
end)

-----------------





-----------------------------------------------

function cambiarSkin(playerSource, commandName, target, skin)
    -- Verifica si el jugador tiene permisos (Moderador o superior)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        -- Validar que se proporcionaron los argumentos necesarios
        if target and skin and tonumber(skin) then
            local targetPlayer
            local skinID = tonumber(skin)

            -- Buscar al jugador por ID o nombre
            if tonumber(target) then
                -- Buscar por ID
                for _, player in ipairs(getElementsByType("player")) do
                    if getElementData(player, "ID") == tonumber(target) then
                        targetPlayer = player
                        break
                    end
                end
            else
                -- Buscar por nombre
                targetPlayer = getPlayerFromName(target)
            end

            -- Verificar si se encontró al jugador objetivo
            if targetPlayer then
                -- Cambiar la skin del jugador
                setElementModel(targetPlayer, skinID)
                outputChatBox("#ffff3d[Administración] #ffffffHas cambiado la skin del jugador #ff3d3d" .. getPlayerName(targetPlayer) .. " #ffffffa la ID de skin #00ff00" .. skinID .. ".", playerSource, 255, 255, 255, true)
                outputChatBox("#ffff3d[Administración] #ffffffTu skin ha sido cambiada a la ID #00ff00" .. skinID .. " #ffffffpor #ff3d3d" .. getPlayerName(playerSource) .. ".", targetPlayer, 255, 255, 255, true)
            else
                outputChatBox("#ffff3d[Administración] #ffffffNo se encontró ningún jugador con el ID o nombre especificado: #ff3d3d" .. target .. ".", playerSource, 255, 255, 255, true)
            end
        else
            outputChatBox("#ffff3d[Administración] #ffffffUso correcto: /ss [Nombre o ID del jugador] [ID de la skin]", playerSource, 255, 255, 255, true)
        end
    else
        outputChatBox("#ffff3d[Administración] #ffffffNo tienes permiso para usar este comando.", playerSource, 255, 255, 255, true)
    end
end
addCommandHandler("ss", cambiarSkin)


-----------------------------------------------

local flyStatus = {}

function toggleFly(player)
    -- Verifica se o jogador está na ACL Moderator
    if not isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Moderator")) then
        outputChatBox("#ff3d3d* Tu no puedes usar este comando", player, 255, 0, 0,true)
        return
    end

    -- Verifica se o jogador está em um veículo
    if isPedInVehicle(player) then
        outputChatBox("#ff3d3d* Tu no puedes usar este comando en un vehiculo", player, 255, 0, 0)
        return
    end

    flyStatus[player] = not flyStatus[player]
    if flyStatus[player] then
        setElementAlpha(player, 0)
        triggerClientEvent(player, "onClientFlyToggle", player)
        outputChatBox("#ffff3d[Administracion] #ffFfffModo de vuelvo ha sido #00ff00Activado #ffFFffcorrectamente.", player, 0, 255, 0,true)
    else
        setElementAlpha(player, 255)
        triggerClientEvent(player, "onClientFlyToggle", player)
        outputChatBox("#ffff3d[Administracion] #ffFfffModo de vuelvo ha sido #ff0000Desactivado #ffFFffcorrectamente.", player, 255, 0, 0,true)
    end
end

addCommandHandler("fly", toggleFly, false, false)



-----------------------------------------------

function SetarVida(playerSource, commandName, id, vida)
	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
		if id and tonumber(id) and vida and tonumber(vida) then
			for _, player in pairs(getElementsByType("player")) do
				if getElementData(player, "ID") == tonumber(id) then
					setElementHealth(player, tonumber(vida))
					outputChatBox("[Servidor] Você definiu a vida do jogador com ID "..id.." para "..vida..".", playerSource)
					outputChatBox("[Servidor] A sua vida foi definida para "..vida.." pelo jogador "..getPlayerName(playerSource)..".", player)
					return
				end
			end
			outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
		else
			outputChatBox("[Servidor] Uso correto: /darvida [ID do jogador] [quantidade de vida]", playerSource)
		end
	else
		outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
	end
end
addCommandHandler("darvida", SetarVida)


-----------------------------------------------

function fixVehicleCommand(playerSource, commandName)
    -- Verifica se o jogador está na ACL Moderator
    if not isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource, 255, 0, 0)
        return
    end
    -- Verifica se o jogador está dentro de um veículo
    local playerVehicle = getPedOccupiedVehicle(playerSource)
    if not playerVehicle then
        outputChatBox("[Servidor] Você precisa estar dentro de um veículo para usar este comando!", playerSource, 255, 0, 0)
        return
    end

    fixVehicle(playerVehicle)
    outputChatBox("[Servidor] Veículo reparado com sucesso!", playerSource, 0, 255, 0)
end
addCommandHandler("reparar", fixVehicleCommand, false, false)


-----------------------------------------------

function DestruirVeiculo(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    local vehicle = getPedOccupiedVehicle(player)
                    if vehicle then
                        destroyElement(vehicle)
                        outputChatBox("[Servidor] O veículo do jogador com ID "..id.." foi destruído.", playerSource)
                        outputChatBox("[Servidor] Seu veículo foi destruído pelo jogador "..getPlayerName(playerSource)..".", player)
                    else
                        outputChatBox("[Servidor] O jogador com ID "..id.." não está em um veículo.", playerSource)
                    end
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /dv [ID do jogador]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("dv", DestruirVeiculo)

-----------------------------------------------

function DarColete(playerSource, commandName, id, armor)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) and armor and tonumber(armor) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    setPedArmor(player, tonumber(armor))
                    outputChatBox("[Servidor] Você definiu o colete do jogador com ID "..id.." para "..armor..".", playerSource)
                    outputChatBox("[Servidor] Seu colete foi definido para "..armor.." pelo jogador "..getPlayerName(playerSource)..".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /darcolete [ID do jogador] [quantidade de colete]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("darcolete", DarColete)

-----------------------------------------------

function IrAteJogador(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    local x, y, z = getElementPosition(player)
                    setElementPosition(playerSource, x, y, z)
                    outputChatBox("#ffFFffTe has tepeado a el jugador con la id  #DDFF00"..id..".", playerSource,255,255,255,true)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource,255,255,255,true)
        else
            outputChatBox("[Servidor] Uso correto: /ir [ID do jogador]", playerSource,255,255,255,true)
        end
    else
        outputChatBox("#ff3d3d* No tienes permiso para usar este comando.", playerSource,255,255,255,true)
    end
end
addCommandHandler("ir", IrAteJogador)


-----------------------------------------------

function PuxarJogador(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    local x, y, z = getElementPosition(playerSource)
                    setElementPosition(player, x, y, z)
                    outputChatBox("[Servidor] Você puxou o jogador com ID "..id.." até você.", playerSource)
                    outputChatBox("[Servidor] Você foi puxado pelo jogador "..getPlayerName(playerSource)..".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /puxar [ID do jogador]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("puxar", PuxarJogador)

-----------------------------------------------

function BanirJogador(playerSource, commandName, id, tempo,...)
local Tiempo = tempo * 86400
local Susuario = getPlayerFromName ( id ) 
local reason = table.concat({...}, " ")
--local kreason = "Motivo:"..reason.."."
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
     	if isElement( Susuario ) and getElementType( Susuario ) == "player" then
                   banPlayer(Susuario, true, true, true, playerSource, reason, tonumber(Tiempo))
                    outputChatBox("#ffffffUn miembro del staff baneo ("..tempo.." días(s)) a #ffff38"..id..". #ffffffRazón: #fd3939"..reason..".", root,255,255,255,true)
			
		else
		             outputChatBox("#ff3d3dJugador no encontrado", playerSource,255,255,255,true)
		end
   
   else
    
           outputChatBox("#ff3d3dNo tienes permisos para usar este comando", playerSource,255,255,255,true)
   end


end
addCommandHandler("banear", BanirJogador)

-----------------------------------------------

-----------------------------------------------

function KickarJogador(playerSource, commandName, id,...)
local Susuario = getPlayerFromName ( id ) 
     local reason = table.concat({...}, " ")
--local kreason = "Motivo:"..reason.."."
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
     	if isElement( Susuario ) and getElementType( Susuario ) == "player" then
                    kickPlayer(Susuario, playerSource,reason)
                    outputChatBox("#ffffffUn miembro del staff kickeo a #ffff38"..id..". #ffffffMotivo: #fd3939"..reason..".", root,255,255,255,true)
			
		else
		             outputChatBox("#ff3d3dJugador no encontrado", playerSource,255,255,255,true)
		end
   
   else
    
           outputChatBox("#ff3d3dNo tienes permisos para usar este comando", playerSource,255,255,255,true)
   end
   
   end
addCommandHandler("kick", KickarJogador)

-----------------------------------------------

function DarDinheiro(playerSource, commandName, id, quantidade)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) and quantidade and tonumber(quantidade) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    givePlayerMoney(player, tonumber(quantidade))
                    outputChatBox("[Servidor] Você deu $"..quantidade.." para o jogador com ID "..id..".", playerSource)
                    outputChatBox("[Servidor] Você recebeu $"..quantidade.." do jogador "..getPlayerName(playerSource)..".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /dardinheiro [ID do jogador] [quantidade]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("dardinheiro", DarDinheiro)

-----------------------------------------------

function RetirarDinheiro(playerSource, commandName, id, quantidade)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) and quantidade and tonumber(quantidade) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    local playerMoney = getPlayerMoney(player)
                    if playerMoney < tonumber(quantidade) then
                        outputChatBox("[Servidor] O jogador com ID "..id.." não possui dinheiro suficiente para retirar.", playerSource)
                        return
                    else
                        takePlayerMoney(player, tonumber(quantidade))
                        outputChatBox("[Servidor] Você retirou $"..quantidade.." do jogador com ID "..id..".", playerSource)
                        outputChatBox("$"..quantidade.." foram retiradas do seu dinheiro pelo jogador "..getPlayerName(playerSource)..".")
                        return
                    end
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /retirardinheiro [ID do jogador] [quantidade]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("retirardinheiro", RetirarDinheiro)

-----------------------------------------------

function tuneCar(player)
 local group = isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), aclGetGroup ("Moderator"))
 if not group then
 outputChatBox("[Servidor] Você não tem permissão para adicionar nitro a veículos.", player, 255, 0, 0)
 return
 end
 local vehicle = getPedOccupiedVehicle(player)
 if not vehicle then
 outputChatBox("[Servidor] Você precisa estar dentro de um veículo para adicionar nitro.", player, 255, 0, 0)
 return
 end
 if getVehicleType(vehicle) ~= "Automobile" and getVehicleType(vehicle) ~= "Bike" then
 outputChatBox("[Servidor] Este tipo de veículo não pode receber nitro.", player, 255, 0, 0)
 return
 end
 addVehicleUpgrade(vehicle, 1010)
 outputChatBox("[Servidor] Nitro adicionado com sucesso ao seu veículo!", player, 0, 255, 0)
end
addCommandHandler("nitro", tuneCar)

-----------------------------------------------

addCommandHandler("clima",
function(player, cmd, weather)
 local group = isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), aclGetGroup ("Moderator"))
 if not group then
 outputChatBox("[Servidor] Você não tem permissão para alterar o clima.", player, 255, 0, 0)
 return
 end
 weather = tonumber(weather)
 if not weather or weather < 0 or weather > 23 then
 outputChatBox("[Servidor] Utilize /clima [id do clima] - O id do clima deve ser um número entre 0 e 23", player, 255, 0, 0)
 return
 end
 setWeather(weather)
 outputChatBox("[Servidor] Clima alterado para "..weather.." com sucesso!", player, 0, 255, 0)
 end)

-----------------------------------------------

 addCommandHandler("tempo",
 function(player, cmd, hour, minute)
 local group = isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), aclGetGroup ("Moderator"))
 if not group then
 outputChatBox("[Servidor] Você não tem permissão para alterar o tempo.", player, 255, 0, 0)
 return
 end
 hour = tonumber(hour)
 minute = tonumber(minute)
 if not hour or hour < 0 or hour > 23 then
 outputChatBox("[Servidor] Utilize /tempo [hora] [minutos] - A hora deve ser um número entre 0 e 23", player, 255, 0, 0)
 return
 end
 if not minute or minute < 0 or minute > 59 then
 outputChatBox("[Servidor] Utilize /tempo [hora] [minutos] - Os minutos devem ser um número entre 0 e 59", player, 255, 0, 0)
 return
 end
 setTime(hour, minute)
 outputChatBox("[Servidor] Tempo alterado para "..hour..":"..minute.." com sucesso!", player, 0, 255, 0)
 end)

-----------------------------------------------

function CongelarJogador(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    setElementFrozen(player, true)
                    setElementData(player, "frozen", true)
                    outputChatBox("[Servidor] Você congelou o jogador com ID "..id..".", playerSource)
                    outputChatBox("[Servidor] Você foi congelado pelo jogador "..getPlayerName(playerSource)..".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /congelar [ID do jogador]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("congelar", CongelarJogador)

-----------------------------------------------

function DescongelarJogador(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
			if getElementData(player, "ID") == tonumber(id) then
setElementFrozen(player, false)
setElementData(player, "frozen", false)
outputChatBox("[Servidor] Você descongelou o jogador com ID "..id..".", playerSource)
outputChatBox("[Servidor] Você foi descongelado pelo jogador "..getPlayerName(playerSource)..".", player)
return
end
end
outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
else
outputChatBox("[Servidor] Uso correto: /descongelar [ID do jogador]", playerSource)
end
else
outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
end
end
addCommandHandler("descongelar", DescongelarJogador)

-----------------------------------------------

function DarArma(playerSource, commandName, id, weapon, ammo)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) and weapon and tonumber(weapon) and ammo and tonumber(ammo) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    giveWeapon(player, tonumber(weapon), tonumber(ammo), true)
                    outputChatBox("[Servidor] Você deu a arma "..getWeaponNameFromID(tonumber(weapon)).." com "..ammo.." balas para o ID:  "..id..".", playerSource)
                    outputChatBox("[Servidor] Você recebeu a arma "..getWeaponNameFromID(tonumber(weapon)).." com "..ammo.." balas do jogador "..getPlayerName(playerSource)..".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /dararma [ID do jogador] [ID da arma] [quantidade de munição]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("dararma", DarArma)

-----------------------------------------------

function removeArmas(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    takeAllWeapons(player)
                    outputChatBox("[Servidor] Você removeu todas as armas do jogador com ID:  "..id..".", playerSource)
                    outputChatBox("[Servidor] Todas as suas armas foram removidas pelo administrador "..getPlayerName(playerSource)..".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /removearmas [ID do jogador]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("removerarmas", removeArmas)

-----------------------------------------------

function MutarJogador(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    setPlayerMuted(player, true)
                    setElementData(player, "muted", true)
                    outputChatBox("[Servidor] Você mutou o jogador com ID "..id..".", playerSource)
                    outputChatBox("[Servidor] Você foi mutado pelo jogador "..getPlayerName(playerSource)..".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /mutar [ID do jogador]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("mutar", MutarJogador)

-----------------------------------------------

function DesmutarJogador(playerSource, commandName, id)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    setPlayerMuted(player, false)
                    setElementData(player, "muted", false)
                    outputChatBox("[Servidor] Você desmutou o jogador com ID "..id..".", playerSource)
outputChatBox("[Servidor] Você foi desmutado pelo jogador "..getPlayerName(playerSource)..".", player)
return
end
end
outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
else
outputChatBox("[Servidor] Uso correto: /desmutarjogador [ID do jogador]", playerSource)
end
else
outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
end
end
addCommandHandler("desmutar", DesmutarJogador)

-----------------------------------------------

local hasJetpack = {}
function toggleJetpack(player)
    local group = isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), aclGetGroup ("Moderator")) 
    if not group then
        outputChatBox("[Servidor] Você não tem permissão para usar esse comando.", player, 255, 0, 0)
        return
    end
    if hasJetpack[player] then
        setPedWearingJetpack(player, false)
        hasJetpack[player] = false
        outputChatBox("[Servidor] Jetpack removido com sucesso!", player, 0, 255, 0)
    else
        setPedWearingJetpack(player, true)
        hasJetpack[player] = true
        outputChatBox("[Servidor] Jetpack adicionado com sucesso!", player, 0, 255, 0)
    end
end
addCommandHandler("jetpack", toggleJetpack)

-----------------------------------------------

function upgradeAll(player)
    local group = isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), aclGetGroup ("Moderator")) 
    if not group then
        outputChatBox("[Servidor] Você não tem permissão para usar esse comando.", player, 255, 0, 0)
        return
    end
    local vehicle = getPedOccupiedVehicle(player)
    if not vehicle then
        outputChatBox("[Servidor] Você precisa estar dentro de um veículo para fazer upgrades.", player, 255, 0, 0)
        return
    end
    -- list of all upgrades
    local upgrades = {
        1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 1037, 1038, 1039, 1040, 1041, 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050
    }
    for i, upgrade in ipairs(upgrades) do
        addVehicleUpgrade(vehicle, upgrade)
    end
    -- adicionando suspenção ao carro
    addVehicleUpgrade(vehicle, 1087)
    -- adicionando painjob ao carro
    setVehiclePaintjob(vehicle, 2)
    outputChatBox("[Servidor] Seu carro foi tunado com sucesso!", player, 0, 255, 0)
end
addCommandHandler("tunar", upgradeAll)

-----------------------------------------------
 
function addHydraulics(player)
    local group = isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), aclGetGroup ("Moderator")) 
    if not group then
        outputChatBox("[Servidor] Você não tem permissão para usar esse comando.", player, 255, 0, 0)
        return
    end
    local vehicle = getPedOccupiedVehicle(player)
    if not vehicle then
        outputChatBox("[Servidor] Você precisa estar dentro de um veículo para adicionar hidráulica.", player, 255, 0, 0)
        return
    end
    -- setando o valor da suspenção para um número menor
    setVehicleHandling(vehicle, "suspensionLowerLimit", 0.1)
    outputChatBox("[Servidor] veículo rebaixado com sucesso!", player, 0, 255, 0)
end
addCommandHandler("rebaixar", addHydraulics)

-----------------------------------------------
 
function teleportToCity(player, command, city)
    local x, y, z
    if city == "ls" then
        x, y, z = 1478.436, -1722.107, 13.547
    elseif city == "lv" then
        x, y, z = 2066.467, 851.733, 6.727
    elseif city == "sf" then
        x, y, z = -1508.348, 847.664, 7.188
    else
        outputChatBox("[Servidor] Cidade inválida. As opções são 'ls', 'lv' e 'sf'", player, 255, 0, 0)
        return
    end
    local vehicle = getPedOccupiedVehicle(player) -- obtém a referência do veículo
    if vehicle then -- se o jogador estiver dentro de um veículo
setElementPosition(vehicle, x, y, z) -- coloque o veículo na posição de destino
end
setElementPosition(player, x, y, z) -- coloque o jogador na posição de destino
outputChatBox("[Servidor] Teleportado para " .. city, player, 0, 255, 0)
end
addCommandHandler("teleport", teleportToCity)

-----------------------------------------------
 
function changePlate(player, command, newPlate)
    if not newPlate then -- verifica se o novo texto da placa foi fornecido
        outputChatBox("[Servidor] Exemplo de uso: /placa ABC123", player, 0, 255, 0) -- envia uma mensagem de exemplo
        return
    end
    local vehicle = getPedOccupiedVehicle(player) -- obtém a referência do veículo
    if not vehicle then -- se o jogador não estiver dentro de um veículo
        outputChatBox("[Servidor] Você precisa estar dentro de um veículo para mudar a placa.", player, 255, 0, 0)
        return
    end
    setVehiclePlateText(vehicle, newPlate) -- muda a placa do veículo
    outputChatBox("[Servidor] Placa do seu veículo mudou para: " .. newPlate, player, 0, 255, 0)
end
addCommandHandler("placa", changePlate)

-----------------------------------------------
 
function flipVehicle(player)
    local group = isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(player)), aclGetGroup ("Moderator")) 
    if not group then
        outputChatBox("[Servidor] Você não tem permissão para usar esse comando.", player, 255, 0, 0)
        return
    end
    local vehicle = getPedOccupiedVehicle(player) -- obtém a referência do veículo
    if not vehicle then -- se o jogador não estiver dentro de um veículo
        outputChatBox("[Servidor] Você precisa estar dentro de um veículo para desvirá-lo.", player, 255, 0, 0)
        return
    end
    fixVehicle(vehicle) -- fixa o veículo
    setElementRotation(vehicle, 0, 0, 180) -- gira o veículo
    setElementVelocity(vehicle, 0, 0, 0) -- define a velocidade como 0
    outputChatBox("[Servidor] Veículo desvirado com sucesso!", player, 0, 255, 0)
end
addCommandHandler("desvirar", flipVehicle)

-----------------------------------------------

function lockVehicle(player)
    local vehicle = getPedOccupiedVehicle(player)
    if not vehicle then 
        outputChatBox("[Servidor] Você precisa estar dentro de um veículo para trancá-lo.", player, 255, 0, 0)
        return
    end
    if isVehicleLocked(vehicle) then
        outputChatBox("[Servidor] Veículo já está trancado", player, 255, 0, 0)
    else
        setVehicleLocked(vehicle, true)
        outputChatBox("[Servidor] Veículo trancado com sucesso!", player, 0, 255, 0)
    end
end
addCommandHandler("trancar", lockVehicle)

function getNearestVehicle(player)
    local x, y, z = getElementPosition(player)
    local nearestVehicle, nearestDistance
    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        local distance = getDistanceBetweenPoints3D(x, y, z, getElementPosition(vehicle))
        if not nearestVehicle or distance < nearestDistance then
            nearestVehicle = vehicle
            nearestDistance = distance
        end
    end
    return nearestVehicle
end

-----------------------------------------------

function unlockVehicle(player)
    local vehicle = getNearestVehicle(player)
    if not vehicle then 
        outputChatBox("[Servidor] Não há veículo próximo para destrancar.", player, 255, 0, 0)
        return
    end
    if isVehicleLocked(vehicle) then 
        setVehicleLocked(vehicle, false) 
        outputChatBox("[Servidor] Veículo destrancado com sucesso!", player, 0, 255, 0)
    else
        outputChatBox("[Servidor] Veículo já está destrancado", player, 255, 0, 0) 
    end
end
addCommandHandler("destrancar", unlockVehicle)

-----------------------------------------------

local ModeratorGroup = "Moderator"

function spawnCar(player, command, carID)
    local group = isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup(ModeratorGroup))
    if not group then
        outputChatBox("[Servidor] Você não tem permissão para usar este comando!", player)
        return
    end

    if not carID then
        outputChatBox("[Servidor] Uso correto: /veh [ID]", player)
        return
    end

    local playerVehicle = getPedOccupiedVehicle(player)
    if playerVehicle then
        destroyElement(playerVehicle)
    end

    local x, y, z = getElementPosition(player)
    local rx, ry, rz = getElementRotation(player)
    local vehicle = createVehicle(tonumber(carID), x, y, z, rx, ry, rz)
    if vehicle then
        warpPedIntoVehicle(player, vehicle)
        outputChatBox("[Servidor] veículo criado com sucesso!", player)
    else
        outputChatBox("[Servidor] Invalid vehicle ID!", player)
    end
end
addCommandHandler("veh", spawnCar)

-----------------------------------------------

function MudarCorVeiculo(playerSource, commandName, r, g, b)
    local vehicle = getPedOccupiedVehicle(playerSource)
    if not vehicle then
        outputChatBox("[Servidor] Você precisa estar dentro de um veículo para usar esse comando.", playerSource, 255, 0, 0)
        return
    end
    if not tonumber(r) or not tonumber(g) or not tonumber(b) then
        outputChatBox("[Servidor] Uso correto: /mudarcorveiculo [r] [g] [b]", playerSource)
        return
    end
    setVehicleColor(vehicle, r, g, b)
    outputChatBox("[Servidor] Cor do veículo alterada para: RGB("..r..", "..g..", "..b..")", playerSource)
end
addCommandHandler("mudarcor", MudarCorVeiculo)

-----------------------------------------------

local ModeratorGroup = "Moderator"

function ModeratorMessage(player, command, ...)
    local group = isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup(ModeratorGroup))
    if not group then
        outputChatBox("[Servidor] Você não tem permissão para usar este comando!", player)
        return
    end

    local message = table.concat({...}, " ")
    if not message or message:gsub("%s+", "") == "" then
        outputChatBox("[Servidor] Uso: /av [mensagem]", player)
        return
    end

    local playerName = getPlayerName(player)
    outputChatBox("[Servidor] [Moderator] " .. playerName .. ": #FF0000" .. message, root, 255, 0, 0, true)
end
addCommandHandler("av", ModeratorMessage)

-----------------------------------------------
 
function DestruirVeiculos(playerSource, commandName)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        local timer = setTimer(DestruirVeiculosReal, 60000, 1, playerSource) -- temporizador de 1 minuto
        outputChatBox("[Servidor] Todos os veículos serão destruídos em 1 minuto!")
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando!")
    end
end

function DestruirVeiculosReal(playerSource)
    local veiculos = getElementsByType("vehicle")
    for _, veiculo in pairs(veiculos) do
        destroyElement(veiculo)
    end
    local playerName = getPlayerName(playerSource)
    if playerName then
        outputChatBox("[Servidor] Todos os veículos foram destruídos por "..playerName.."!")
    else
        outputChatBox("[Servidor] Todos os veículos foram destruídos por um jogador desconhecido!")
    end
end
addCommandHandler("destruirveiculos", DestruirVeiculos)

-----------------------------------------------

 -- Cria a função de chat admin
function adminChat(playerSource, commandName, ...)
    -- Verifica se o jogador que executou o comando está na ACL Moderator
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        -- Recupera a mensagem digitada pelo jogador
        local message = table.concat({...}, " ")
        -- Envia a mensagem para todos os jogadores na ACL Moderator
        for _, player in pairs(getElementsByType("player")) do
            if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Moderator")) then
                outputChatBox("[Servidor] (Admin Chat) " .. getPlayerName(playerSource) .. ": " .. message, player, 255, 0, 0)
            end
        end
    else
        -- Envia uma mensagem de erro para o jogador que não está na ACL Moderator
        outputChatBox("[Servidor] Você não tem permissão para usar este comando!", playerSource, 255, 0, 0)
    end
end
addCommandHandler("a", adminChat)

-----------------------------------------------
 
local playerPositions = {} -- Armazena as posições de cada jogador

function getNearestVehicle(player)
    local x, y, z = getElementPosition(player)
    local nearestVehicle, nearestDistance
    for _, vehicle in ipairs(getElementsByType("vehicle")) do
        local distance = getDistanceBetweenPoints3D(x, y, z, getElementPosition(vehicle))
        if not nearestVehicle or distance < nearestDistance then
            nearestVehicle = vehicle
            nearestDistance = distance
        end
    end
    return nearestVehicle
end

-- Comando para definir a posição atual do jogador
addCommandHandler("setarposicao", function(player)
    -- Verifica se o jogador está na ACL Moderator
    if isObjectInACLGroup("user." .. getPlayerName(player), aclGetGroup("Moderator")) then
        outputChatBox("[Servidor] Você não tem permissão para usar este comando!", player, 255, 0, 0)
        return
    end

    -- Obtém a posição do jogador
    local x, y, z = getElementPosition(player)
    playerPositions[player] = {x = x, y = y, z = z}
    outputChatBox("[Servidor] Posição definida com sucesso!", player, 0, 255, 0)
end)


-----------------------------------------------

addCommandHandler("puxarveiculo", function(player)
    -- Verifica se o jogador está na ACL Moderator
    if isObjectInACLGroup("user." .. getPlayerName(player), aclGetGroup("Moderator")) then
        outputChatBox("[Servidor] Você não tem permissão para usar este comando!", player, 255, 0, 0)
        return
    end

    -- Verifica se a posição foi definida
    if not playerPositions[player] then
        outputChatBox("[Servidor] Você deve definir sua posição antes de usar este comando!", player, 255, 0, 0)
        return
    end

    -- Obtém o veículo mais próximo
    local vehicle = getNearestVehicle(player, 30)

    if not vehicle then
        outputChatBox("[Servidor] Nenhum veículo foi encontrado perto da sua posição!", player, 255, 0, 0)
        return
    end

    -- Puxa o veículo até a posição
    setElementPosition(vehicle, playerPositions[player].x, playerPositions[player].y, playerPositions[player].z)
    outputChatBox("[Servidor] Veículo puxado com sucesso!", player, 0, 255, 0)
end)


-----------------------------------------------
 
function kickAllPlayers(playerSource, commandName)
    -- Verifica se o jogador tem permissão para usar o comando
    if not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource, 255, 0, 0)
        return
    end
    -- Kicka todos os jogadores do servidor, exceto administradores
    local playersKicked = 0
    for _, player in ipairs(getElementsByType("player")) do
        if isElement(player) and not isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Moderator")) then
            local playerName = getPlayerName(player)
            kickPlayer(player, "Todos os jogadores foram kickados pelo administrador.")
            playersKicked = playersKicked + 1
        end
    end
    if playersKicked > 0 then
        outputChatBox(playersKicked .. " jogadores foram kickados com sucesso!", playerSource, 0, 255, 0)
    else
        outputChatBox("[Servidor] Nenhum jogador foi kickado, pois todos os jogadores são administradores.", playerSource, 255, 0, 0)
    end
end

addCommandHandler("kickall", kickAllPlayers)

-----------------------------------------------

local aclGroup = "Moderator"

function createBlipCommand(player, command, blipType)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup(aclGroup)) then
        if blipType then
            local x, y, z = getElementPosition(player)
            local blip = createBlip(x, y, z, tonumber(blipType))
            outputChatBox("[Servidor] Administrador "..getPlayerName(player).." criou um blip no mapa do tipo "..blipType, root, 0, 255, 0)
        else
            outputChatBox("[Servidor] Uso correto: /criarblip [tipo do blip]", player, 255, 0, 0)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", player, 255, 0, 0)
    end
end
addCommandHandler("criarblip", createBlipCommand)

-----------------------------------------------

function removeBlipCommand(player, command)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup(aclGroup)) then
        local blips = getElementsByType("blip")
        for i, blip in ipairs(blips) do
            if getElementDimension(blip) == getElementDimension(player) then
                destroyElement(blip)
                outputChatBox("[Servidor] Administrador "..getPlayerName(player).." removeu o blip", root, 255, 0, 0)
                return
            end
        end
        outputChatBox("[Servidor] Nenhum blip foi encontrado na sua dimensão.", player, 255, 0, 0)
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", player, 255, 0, 0)
    end
end
addCommandHandler("removerblip", removeBlipCommand)

-----------------------------------------------

function freezeAllCommand(player, command)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup(aclGroup)) then
        for _, targetPlayer in ipairs(getElementsByType("player")) do
            setElementFrozen(targetPlayer, true)
        end
        outputChatBox("[Servidor] Todos os jogadores foram congelados pelo administrador "..getPlayerName(player), root, 255, 0, 0)
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", player, 255, 0, 0)
    end
end
addCommandHandler("congelartodos", freezeAllCommand)

function unfreezeAllCommand(player, command)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup(aclGroup)) then
        for _, targetPlayer in ipairs(getElementsByType("player")) do
            setElementFrozen(targetPlayer, false)
        end
        outputChatBox("[Servidor] Todos os jogadores foram descongelados pelo administrador "..getPlayerName(player), root, 255, 0, 0)
		    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", player, 255, 0, 0)
    end
end
addCommandHandler("descongelartodos", unfreezeAllCommand)

-----------------------------------------------

function ExplodirJogador(playerSource, commandName, id)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            local targetPlayer = nil
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    targetPlayer = player
                    break
                end
            end
            if targetPlayer then
                local x, y, z = getElementPosition(targetPlayer)
                createExplosion(x, y, z, 5)
                outputChatBox("[Servidor] Jogador com ID " .. id .. " foi explodido com sucesso!", playerSource, 0, 255, 0)
                outputChatBox("[Servidor] Você foi explodido pelo administrador " .. getPlayerName(playerSource) .. "!", targetPlayer, 255, 0, 0)
            else
                outputChatBox("[Servidor] Jogador com ID ".. id .." não encontrado.", playerSource, 255, 0, 0)
            end
        else
            outputChatBox("[Servidor] Uso correto: /explodir [ID do jogador]", playerSource, 255, 0, 0)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource, 255, 0, 0)
end
end
addCommandHandler("explodir", ExplodirJogador)

-----------------------------------------------

addCommandHandler("desbugar",
    function(player, cmd, id)
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Moderator")) then
            if id and tonumber(id) then
                for _, targetPlayer in pairs(getElementsByType("player")) do
                    if getElementData(targetPlayer, "ID") == tonumber(id) then
                        setElementPosition(targetPlayer, 1512.465, -1677.293, 14.047)
                        setElementRotation(targetPlayer, -0, 0, 270.31)
                        setElementInterior(targetPlayer, 0)
                        setElementDimension(targetPlayer, 0)
                        setElementHealth(targetPlayer, 100)
						toggleAllControls(player, true)
                        setElementFrozen(targetPlayer, false)
                        outputChatBox("[Servidor] Jogador "..getPlayerName(targetPlayer).." foi desbugado com sucesso!", player)
                        outputChatBox("[Servidor] Você foi desbugado pelo administrador "..getPlayerName(player), targetPlayer)
                        return
                    end
                end
                outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", player)
            else
                outputChatBox("[Servidor] Uso correto: /desbugar [ID do jogador]", player)
            end
        else
            outputChatBox("[Servidor] Você não tem permissão para usar este comando.", player)
        end
    end
)

-----------------------------------------------

function LimparChat(playerSource, commandName)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        for i = 1, 100 do
            outputChatBox(" ")
        end
        outputChatBox("[Servidor] Chat limpo pelo Moderator " .. getPlayerName(playerSource), root, 0, 255, 0)
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource, 255, 0, 0)
    end
end
addCommandHandler("limparchat", LimparChat)

------------------------------------------------

local wantedLevels = {}

function addWantedLevel(playerSource, commandName, id, wantedLevel)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) and wantedLevel and tonumber(wantedLevel) then
            if tonumber(wantedLevel) > 6 then 
                wantedLevel = 6 
            end
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    wantedLevels[player] = tonumber(wantedLevel)
                    setPlayerWantedLevel(player, tonumber(wantedLevel))
                    outputChatBox("[Servidor] Você adicionou " .. wantedLevel .. " níveis de procurado ao jogador " .. getPlayerName(player) .. ".", playerSource)
                    outputChatBox("[Servidor] Você foi adicionado " .. wantedLevel .. " níveis de procurado pelo administrador " .. getPlayerName(playerSource) .. ".", player)
                end
            end
        else
            outputChatBox("[Servidor] Uso correto: /addwanted [ID do jogador] [níveis de procurado (1-6)]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("darprocurado", addWantedLevel)

------------------------------------------------

function getPlayerPos(playerSource, commandName)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        local x, y, z = getElementPosition(playerSource)
        outputChatBox("[Servidor] Sua posição atual é X: "..x..", Y: "..y..", Z: "..z, playerSource)
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("getpos", getPlayerPos)



------------------------------------------------

function ejectPlayer(thePlayer, commandName, id)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup("Moderator")) then
        if id and tonumber(id) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    local vehicle = getPedOccupiedVehicle(player)
                    if not vehicle then
                        outputChatBox("[Servidor] Este jogador não está em um veículo!", thePlayer, 255, 0, 0)
                        return
                    end
                    outputChatBox("[Servidor] Você ejetou o jogador com ID: " .. id .. " do veículo", thePlayer)
                    outputChatBox("[Servidor] Você foi ejetado do veículo pelo administrador " .. getPlayerName(thePlayer), player)
                    removePedFromVehicle(player)
                end
            end
        else
            outputChatBox("[Servidor] Uso correto: /ejetar [ID do jogador]", thePlayer)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", thePlayer)
    end
end
addCommandHandler("ejetar", ejectPlayer)

------------------------------------------------

function setInt(playerSource, commandName, id, int)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
        if id and tonumber(id) and int and tonumber(int) then
            for _, player in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(id) then
                    setElementInterior(player, tonumber(int))
                    outputChatBox("[Servidor] Você setou o interior ".. int .. " para o jogador de ID: ".. id .. ".", playerSource)
                    outputChatBox("[Servidor] Você foi movido para o interior ".. int .. " pelo administrador ".. getPlayerName(playerSource) .. ".", player)
                    return
                end
            end
            outputChatBox("[Servidor] Nenhum jogador com ID "..id.." foi encontrado.", playerSource)
        else
            outputChatBox("[Servidor] Uso correto: /setint [ID do jogador] [ID do interior]", playerSource)
        end
    else
        outputChatBox("[Servidor] Você não tem permissão para usar este comando.", playerSource)
    end
end
addCommandHandler("setint", setInt)

------------------------------------------------






 local commandDescriptions = {
["/mudarcor"] = "Muda a cor de um veículo.",
["/darcolete"] = "Define o colete de um jogador pelo ID.",
["/ir"] = "Teleporta até um jogador.",
["/puxar"] = "Puxa um jogador para até sua localização.",
["/banir"] = "Bane um jogador.",
["/desbanir"] = "Desbane um jogador.",
["/Kickar"] = "Kicka um jogador.",
["/dardinheiro"] = "Dá dinheiro a um jogador.",
["/retirardinheiro"] = "Tira dinheiro de um jogador.",
["/dararma"] = "Dá uma arma a um jogador.",
["/mutar"] = "Muta um jogador.",
["/desmutar"] = "Desmuta um jogador.",
["/jetpack"] = "Ativa o jetpack.",
["/tunar"] = "Tuna um veículo.",
["/rebaixar"] = "Rebaixa um veículo.",
["/teleport"] = "Teleporta para as cidades principais",
["/placa"] = "Muda a placa de um veículo.",
["/desvirar"] = "Desvira um veículo.",
["/trancar"] = "Tranca um veículo.",
["/destrancar"] = "Destranca um veículo.",
["/veh"] = "Cria um veículo específico.",
["/nitro"] = "Dá um boost de nitro a um veículo.",
["/clima"] = "Define o clima para um tipo específico.",
["/tempo"] = "Define a hora para uma hora específica.",
["/congelar"] = "Congela um jogador.",
["/descongelar"] = "Descongela um jogador.",
["/mudarskin"] = "Muda a skin de um jogador.",
["/fly"] = "Ativa o modo voo.",
["/darvida"] = "Define a vida de um jogador.",
["/reparar"] = "Repara um veículo.",
["/dv"] = "Destroi um veiculo.",
["/destruirveiculos"] = "Destroi todos os veiculos do servidor.",
["/reiniciarscripts"] = "reinicia os scripts do servidor.",
["/kickall"] = "reinicia os scripts do servidor.",
["/setarposicao"] = "reinicia os scripts do servidor.",
["/puxarveiculo"] = "reinicia os scripts do servidor.",
["/reiniciarscripts"] = "reinicia os scripts do servidor.",
["/a"] = "reinicia os scripts do servidor." 
}

function showCommands(player)
for command, description in pairs(commandDescriptions) do
outputChatBox("[Servidor] Comando: "..command.." - "..description, player)
end
end
addCommandHandler("aa", showCommands)      
  
local file = fileOpen("server_S.lua")
if (file) then
    
    outputServerLog( "Sistema de Facciones Ilegales Cargado con exito" )
	outputDebugString( "Sistema de Facciones Ilegales Cargado con exito" )
else
    outputServerLog( "No se ha podido cargar el Sistema de Facciones Ilegales " )
	outputDebugString( "No se ha podido cargar el Sistema de Facciones Ilegales" )
end


function changeName(player, command, id, newName)
    if not (id and tonumber(id) and newName) then
        outputChatBox("#ffff3d[Administracion] #ffFfffUso correcto: /cambiarnombre [ID del jugador] [Nuevo Nombre]", player, 0, 255, 0,true)
        return
    end

  --  if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(player)), aclGetGroup("Moderator")) then
        for _, targetPlayer in pairs(getElementsByType("player")) do
            local targetID = getElementData(targetPlayer, "ID")
            if targetID and tonumber(targetID) == tonumber(id) then
			    local NameOld = getPlayerName(targetPlayer)
				local NameStaff = getPlayerName(player)
                setPlayerName(targetPlayer, newName)
				
                local account = getPlayerAccount(targetPlayer)
                if account then
                    setAccountName(account, newName)
                end
                outputChatBox("#ffff3d[Administracion] #ffFfffTu nombre ha sido cambiado a: " .. newName, player, 0, 255, 0,true)
			 outputChatBox("#ffff3d[Administracion] #ffFfffEl nombre de #2ffa28"..NameOld.."#ffFFff Ha sido cambiado a #2ffa28" .. newName, getRootElement(), 0, 255, 0,true)
				
				
				
				---------------------------------
				
				    local players = getElementsByType ("player")
    local ID = getElementData ( targetPlayer, "char.ID" ) or "N/C"
    Jogador = getPlayerName ( targetPlayer )
    local dados = {
	    content = "<:farrow:1132404116535132252> El jugador, "..NameOld.." ahora es conocido como **"..newName.."**. Cambiado por "..NameStaff.." [#1 Roleplay de Texto].",
        embeds = null,
    }
    webhook = "https://canary.discord.com/api/webhooks/1194727330246041711/aWJYzr3JE1XjrkN1V3-Djj9bxMO7-MSMA7DG_ptJqXK3xXPs4shb-ZoL7KslOA92RYoV"
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end )
	-------------------------------------------------
                return
            end
        end
        outputChatBox("#ffff3d[Administracion] #ffFfffNo se encontró ningún jugador con ID " .. id, player, 255, 0, 0,true)
 -- else
    --    outputChatBox("#ffff3d[Administracion] #ffFfffNo tienes permiso para usar este comando.", player, 255, 0, 0,true)
 --end
end
addCommandHandler("cambiarnombre", changeName)



function teleportToLosSantos(player, cmd, targetPlayer)
    -- Obtener la ID del jugador que ejecutó el comando

   
    
    -- Obtener la ID del jugador objetivo (si se proporciona)
    if not targetPlayer then
        
     setElementPosition(player, 2496.4043, -1665.2539, 13.3438)
     outputChatBox("¡Te has teletransportado a Los Santos!", player, 0, 255, 0)
        
        
        else
         local OtroJugador = getPlayerFromName(targetPlayer)
         
        if OtroJugador then
     setElementPosition(OtroJugador, 2496.4043, -1665.2539, 13.3438)
     outputChatBox("¡Te has teletransportado a Los Santos!", OtroJugador, 0, 255, 0)
          outputChatBox("¡Has teletransportado a Los Santos a "..targetPlayer, player, 0, 255, 0)
        else
                  
                      

        if targetPlayer and tonumber(targetPlayer) then
            for _, player2 in pairs(getElementsByType("player")) do
                if getElementData(player, "ID") == tonumber(targetPlayer) then

          setElementPosition(player2, 2496.4043, -1665.2539, 13.3438)
          outputChatBox("¡Te has teletransportado a Los Santos!", player2, 0, 255, 0)
          outputChatBox("¡Has teletransportado a Los Santos a "..targetPlayer, player, 0, 255, 0)
                end
            end
end


        end
end
end
addCommandHandler("ls", teleportToLosSantos)


