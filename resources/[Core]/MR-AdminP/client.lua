local errorString = "#FEFEFE[#FF0000Staff#FEFEFE] Primero selecciona a un jugador de la lista!"
local errorStringValue = "#FEFEFE[#FF0000Staff#FEFEFE] Tienes que introducir una cantidad!"
local errorStringModel = "#FEFEFE[#FF0000Staff#FEFEFE] Tienes que introducir un modelo!"
local errorStringRazon = "#FEFEFE[#FF0000Staff#FEFEFE] Tienes que colocar una razon primero!"
local errorStringTiempo = "#FEFEFE[#FF0000Staff#FEFEFE] Tienes que colocar el tiempo del castigo primero!"

addEventHandler("onClientResourceStart", resourceRoot,
	function()
        local screenW, screenH = guiGetScreenSize()
        adminWindow = guiCreateWindow((screenW - 386) / 2, (screenH - 545) / 2, 386, 545, " Panel Administrativo ~ 2.0", false)
        guiWindowSetSizable(adminWindow, false)
        guiSetVisible(adminWindow, false)

        mainTab = guiCreateTabPanel(9, 19, 368, 517, false, adminWindow)

        Tab1 = guiCreateTab("Main", mainTab)

        --buttonPunish = guiCreateButton(221, 3, 140, 27, "Punish", false, Tab1)
        --guiSetFont(buttonPunish, "default-bold-small")
        --guiSetProperty(buttonPunish, "NormalTextColour", "FFAAAAAA")
        buttonWarp = guiCreateButton(221, 40, 140, 27, "Warp to Player", false, Tab1)
        guiSetFont(buttonWarp, "default-bold-small")
        guiSetProperty(buttonWarp, "NormalTextColour", "FFAAAAAA")
        buttonWarpTo = guiCreateButton(221, 77, 140, 26, "Warp player to Me", false, Tab1)
        guiSetFont(buttonWarpTo, "default-bold-small")
        guiSetProperty(buttonWarpTo, "NormalTextColour", "FFAAAAAA")
        buttonRename = guiCreateButton(221, 113, 68, 26, "Rename", false, Tab1)
        guiSetFont(buttonRename, "default-bold-small")
        guiSetProperty(buttonRename, "NormalTextColour", "FFAAAAAA")
        buttonFreeze = guiCreateButton(293, 113, 68, 26, "Freeze", false, Tab1)
        guiSetFont(buttonFreeze, "default-bold-small")
        guiSetProperty(buttonFreeze, "NormalTextColour", "FFAAAAAA")
        buttonGetAmmo = guiCreateButton(221, 143, 68, 26, "Get ammo", false, Tab1)
        guiSetFont(buttonGetAmmo, "default-bold-small")
        guiSetProperty(buttonGetAmmo, "NormalTextColour", "FFAAAAAA")
        buttonSpectate = guiCreateButton(293, 143, 68, 26, "Spectate", false, Tab1)
        guiSetFont(buttonSpectate, "default-bold-small")
        guiSetProperty(buttonSpectate, "NormalTextColour", "FFAAAAAA")
        buttonKillPlayer = guiCreateButton(221, 174, 68, 26, "Kill Player", false, Tab1)
        guiSetFont(buttonKillPlayer, "default-bold-small")
        guiSetProperty(buttonKillPlayer, "NormalTextColour", "FFAAAAAA")
        buttonFreezeVeh = guiCreateButton(221, 206, 68, 26, "Freeze veh", false, Tab1)
        guiSetFont(buttonFreezeVeh, "default-bold-small")
        guiSetProperty(buttonFreezeVeh, "NormalTextColour", "FFAAAAAA")
        buttonFixVeh = guiCreateButton(293, 174, 68, 26, "Fix veh", false, Tab1)
        guiSetFont(buttonFixVeh, "default-bold-small")
        guiSetProperty(buttonFixVeh, "NormalTextColour", "FFAAAAAA")
        buttonDestroyVeh = guiCreateButton(293, 206, 68, 26, "Destroy veh", false, Tab1)
        guiSetFont(buttonDestroyVeh, "default-bold-small")
        guiSetProperty(buttonDestroyVeh, "NormalTextColour", "FFAAAAAA")
        variableVehicle = guiCreateEdit(221, 331, 68, 27, "", false, Tab1)
        buttonGiveVehicle = guiCreateButton(293, 332, 68, 26, "Vehicle", false, Tab1)
        guiSetFont(buttonGiveVehicle, "default-bold-small")
        guiSetProperty(buttonGiveVehicle, "NormalTextColour", "FFAAAAAA")
        variableSkin = guiCreateEdit(221, 300, 68, 27, "", false, Tab1)
        guiEditSetMaxLength(variableSkin, 3)
        buttonSkin = guiCreateButton(293, 300, 68, 26, "Set skin", false, Tab1)
        guiSetFont(buttonSkin, "default-bold-small")
        guiSetProperty(buttonSkin, "NormalTextColour", "FFAAAAAA")
        buttonArmor = guiCreateButton(293, 238, 68, 26, "Give Armor", false, Tab1)
        guiSetFont(buttonArmor, "default-bold-small")
        guiSetProperty(buttonArmor, "NormalTextColour", "FFAAAAAA")
        buttonHealth = guiCreateButton(221, 238, 68, 26, "Give Health", false, Tab1)
        guiSetFont(buttonHealth, "default-bold-small")
        guiSetProperty(buttonHealth, "NormalTextColour", "FFAAAAAA")
        gridListPlayers = guiCreateGridList(2, 3, 214, 489, false, Tab1)
        gridListColumnPlayers = guiGridListAddColumn(gridListPlayers, "Jugadores", 0.9)
        buttonGasolina = guiCreateButton(221, 269, 68, 26, "Sin Funcion", false, Tab1)
        guiSetFont(buttonGasolina, "default-bold-small")
        guiSetProperty(buttonGasolina, "NormalTextColour", "FFAAAAAA")
        buttonDesactivado = guiCreateButton(293, 269, 68, 26, "Sin Funcion", false, Tab1)
        guiSetFont(buttonDesactivado, "default-bold-small")
        --guiSetProperty(buttonDesactivado, "Disabled", "True")
        guiSetProperty(buttonDesactivado, "NormalTextColour", "FFAAAAAA")    

        local screenW, screenH = guiGetScreenSize()
        ventanaCastigos = guiCreateWindow((screenW - 671) / 2, (screenH - 124) / 2, 671, 124, "PoP Life ~ Panel de Castigos", false)
        guiWindowSetSizable(ventanaCastigos, false)
        guiSetVisible(ventanaCastigos, false)

        razonPropia = guiCreateEdit(10, 36, 327, 29, "", false, ventanaCastigos)
        Tiempo = guiCreateEdit(10, 84, 327, 29, "", false, ventanaCastigos)
        --buttonMute = guiCreateButton(341, 35, 100, 30, "Mute", false, ventanaCastigos) 341, 35, 100, 30
        --guiSetFont(buttonMute, "default-bold-small")
        --guiSetProperty(buttonMute, "NormalTextColour", "FFAAAAAA")
        buttonKick = guiCreateButton(341, 35, 100, 30, "Kick", false, ventanaCastigos)
        guiSetFont(buttonKick, "default-bold-small")
        guiSetProperty(buttonKick, "NormalTextColour", "FFAAAAAA")
        buttonJail = guiCreateButton(451, 34, 100, 30, "Jail", false, ventanaCastigos)
        guiSetFont(buttonJail, "default-bold-small")
        guiSetProperty(buttonJail, "NormalTextColour", "FFAAAAAA")
        buttonBan = guiCreateButton(561, 34, 100, 30, "Ban", false, ventanaCastigos)
        guiSetFont(buttonBan, "default-bold-small")
        guiSetProperty(buttonBan, "NormalTextColour", "FFAAAAAA")
        buttonReconnect = guiCreateButton(341, 83, 100, 30, "Reconnect", false, ventanaCastigos)
        guiSetFont(buttonReconnect, "default-bold-small")
        guiSetProperty(buttonReconnect, "NormalTextColour", "FFAAAAAA")
        --buttonRemoveAccount = guiCreateButton(561, 83, 100, 30, "Remove Account", false, ventanaCastigos)
        --guiSetFont(buttonRemoveAccount, "default-bold-small")
        --guiSetProperty(buttonRemoveAccount, "NormalTextColour", "FFAAAAAA")
        guiLabel1 = guiCreateLabel(11, 19, 326, 17, "Razon:", false, ventanaCastigos)
        guiSetFont(guiLabel1, "default-bold-small")
        guiLabel2 = guiCreateLabel(11, 67, 326, 17, "Tiempo:", false, ventanaCastigos)
        guiSetFont(guiLabel2, "default-bold-small")
        guiLabel3 = guiCreateLabel(337, 19, 326, 17, "Tiempo son Minutos, No poner decimales solo enteros", false, ventanaCastigos)
        guiSetFont(guiLabel3, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel3, "center", false)

		--addEventHandler("onClientGUIClick", buttonPunish, openPunishInterface, false)
		--addEventHandler("onClientGUIClick", ventanaCastigos, openPunishInterface, false)
		addEventHandler("onClientGUIClick", buttonWarp, warpToPlayer, false)
		addEventHandler("onClientGUIClick", buttonWarpTo, warpPlayerToMe, false)
		addEventHandler("onClientGUIClick", buttonFreeze, freezePlayer, false)
		addEventHandler("onClientGUIClick", buttonGetAmmo, viewWeapons, false)
		--addEventHandler("onClientGUIClick", buttonSpectate, spectearJugador, false)
		--addEventHandler("onClientGUIClick", buttonSlap, slapPlayer, false)
		addEventHandler("onClientGUIClick", buttonKillPlayer, matarJugador, false)
		addEventHandler("onClientGUIClick", buttonFreezeVeh, congelarVehiculo, false)
		addEventHandler("onClientGUIClick", buttonFixVeh, repararVehiculo, false)
		addEventHandler("onClientGUIClick", buttonDestroyVeh, destruirVehiculo, false)
		--addEventHandler("onClientGUIClick", buttonBlowVeh, explotarVehiculo, false)
		addEventHandler("onClientGUIClick", buttonGiveVehicle, giveVehicle, false)
		addEventHandler("onClientGUIClick", buttonSkin, setSkin, false)    
		--addEventHandler("onClientGUIClick", buttonCash, giveMoney, false)
		addEventHandler("onClientGUIClick", buttonHealth, darVida, false)
		addEventHandler("onClientGUIClick", buttonArmor, darChaleco, false)
		--addEventHandler("onClientGUIClick", buttonBurn, prenderFuego, false)
		--addEventHandler("onClientGUIClick", buttonBanLog, openBanLog, false)
		--addEventHandler("onClientGUIClick", buttonWarpPoint, warpsPoints, false)  
		--addEventHandler("onClientGUIClick", buttonTools, adminTools, false)
		--addEventHandler("onClientGUIClick", buttonDesactivado, destruirTodosLosVehiculos, false)    
		addEventHandler("onClientGUIClick", buttonGasolina, repararTodosLosVehiculos, false)

		--addEventHandler("onClientGUIClick", buttonMute, mutearJugador, false)
		addEventHandler("onClientGUIClick", buttonKick, kickearJugador, false)
		addEventHandler("onClientGUIClick", buttonJail, jailearJugador, false)    
		addEventHandler("onClientGUIClick", buttonBan, banearJugador, false)
		addEventHandler("onClientGUIClick", buttonReconnect, reconectarJugador, false)
		--addEventHandler("onClientGUIClick", buttonRemoveAccount, removerCuenta, false)
	end
)

addEventHandler ( 'onClientPlayerDamage', root, 
	function ()
		if (isElement(source )) then
			if (getElementModel(source) == 217 or getElementModel(source) == 211 or getElementModel(source) == 311 or getElementModel(source) == 301) then
				cancelEvent()
			end
		end
	end 
)

addEventHandler("onClientResourceStart", root,
	function()
		guiSetInputMode("no_binds_when_editing")
	end
)

function openAdminPanel()
    if guiGetVisible(adminWindow) == true then
        guiSetVisible(adminWindow, false)
        guiSetVisible(banMain, false)
        guiSetVisible(ventanaCastigos, false)
        showCursor(false)
    else
        guiSetVisible(adminWindow, true)
        showCursor(true)
    end
end
addEvent("PoPLife:openAdmin", true)
addEventHandler("PoPLife:openAdmin", root, openAdminPanel)

function openBanLog()
    if guiGetVisible(banMain) == true then
        guiSetVisible(banMain, false)
        guiBringToFront(adminWindow)
        showCursor(false)
    else
        guiSetVisible(banMain, true)
        guiBringToFront(banMain)
        showCursor(true)
    end
end

function refreshPlayers()
	for id, player in ipairs (getElementsByType("player")) do
		guiGridListSetItemText(gridListPlayers, guiGridListAddRow(gridListPlayers), gridListColumnPlayers, getPlayerName(player), false, false)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, refreshPlayers)

function updatePlayerList(old, new)
	if (eventName == "onClientPlayerJoin") then
		guiGridListSetItemText(gridListPlayers, guiGridListAddRow(gridListPlayers), gridListColumnPlayers, getPlayerName(source), false, false)
	elseif (eventName == "onClientPlayerQuit") then
		for row = 0, guiGridListGetRowCount(gridListPlayers) do
			if (guiGridListGetItemText(gridListPlayers, row, gridListColumnPlayers) == getPlayerName(source)) then
				guiGridListRemoveRow(gridListPlayers, row)
				break
			end
		end
	elseif (eventName == "onClientPlayerChangeNick") then
		for row = 0, guiGridListGetRowCount(gridListPlayers) do
			if (guiGridListGetItemText(gridListPlayers, row, gridListColumnPlayers) == old) then
				guiGridListSetItemText(gridListPlayers, row, gridListColumnPlayers, new, false, false)
				break
			end
		end
	end
end
addEventHandler("onClientPlayerJoin", root, updatePlayerList)
addEventHandler("onClientPlayerQuit", root, updatePlayerList)
addEventHandler("onClientPlayerChangeNick", root, updatePlayerList)

function openPunishInterface()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if  guiGetVisible ( ventanaCastigos ) == false then
		guiSetVisible(ventanaCastigos, true)
		guiBringToFront(ventanaCastigos)
	else
		guiSetVisible(ventanaCastigos, false)
		guiBringToFront(adminWindow)
	end
end

function warpToPlayer()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
    if (not player) then 
    	outputChatBox(errorString, 255, 0, 0, true) 
    	return 
    end
    triggerServerEvent("PoPLife:warpToPlayer", getLocalPlayer(), player)
end

function warpPlayerToMe()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
    if (not player) then 
    	outputChatBox(errorString, 255, 0, 0, true) 
    	return 
    end
    triggerServerEvent("PoPLife:warpPlayerToMe", getLocalPlayer(), player)
end

function freezePlayer()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
    if (not player) then 
    	outputChatBox(errorString, 255, 0, 0, true) 
    	return 
    end
    triggerServerEvent("PoPLife:freezePlayer", getLocalPlayer(), player)
end

function viewWeapons()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then
		outputChatBox(errorString, 255, 0, 0, true)
		return
	end
	triggerServerEvent("PoPLife:viewWeapons", getLocalPlayer(), player)
end

function slapPlayer()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if guiGetText(variableSlap) == "" then 
		exports.Texts:output(errorStringValue, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:slapPlayer", getLocalPlayer(), player, guiGetText(variableSlap))
end

function matarJugador()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:killPlayer", getLocalPlayer(), player)
end

function congelarVehiculo()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:congelarVehiculo", getLocalPlayer(), player)
end

function repararVehiculo()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:repararVehiculo", getLocalPlayer(), player)
end

function destruirVehiculo()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:destruirVehiculo", getLocalPlayer(), player)
end

function explotarVehiculo()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:explotarVehiculo", getLocalPlayer(), player)
end

function giveVehicle()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if guiGetText(variableVehicle) == "" then 
		outputChatBox(errorStringModel, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:giveVehicle", getLocalPlayer(), player, guiGetText(variableVehicle))
end

function setSkin()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if guiGetText(variableSkin) == "" then 
		outputChatBox(errorStringModel, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:setSkin", getLocalPlayer(), player, guiGetText(variableSkin))
end

function giveMoney()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if guiGetText(variableCash) == "" then 
		outputChatBox(errorStringModel, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:giveMoney", getLocalPlayer(), player, guiGetText(variableCash))
end

function darVida()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:darVida", getLocalPlayer(), player)
end

function darChaleco()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:darChaleco", getLocalPlayer(), player)
end

function prenderFuego()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	triggerServerEvent("PoPLife:prenderFuego", getLocalPlayer(), player)
end

function destruirTodosLosVehiculos()
	triggerServerEvent("PoPLife:destruirTodosLosVehiculos", getLocalPlayer())
end

function repararTodosLosVehiculos()
	triggerServerEvent("PoPLife:repararTodosLosVehiculos", getLocalPlayer())
end

function kickearJugador()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if guiGetText(razonPropia) == "" then
		outputChatBox(errorStringRazon, 0, 0, 0, true)
		return
	end
	triggerServerEvent("PoPLife:kickearJugador", getLocalPlayer(), player, guiGetText(razonPropia))
end

function banearJugador()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if guiGetText(razonPropia) == "" then
		outputChatBox(errorStringRazon, 0, 0, 0, true)
		return
	end
	if guiGetText(Tiempo) == "" then
		outputChatBox(errorStringTiempo, 0, 0, 0, true)
		return
	end
	triggerServerEvent("PoPLife:banearJugador", getLocalPlayer(), player, guiGetText(razonPropia), guiGetText(Tiempo))
end

function reconectarJugador()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return
	end 
	triggerServerEvent("PoPLife:reconectarJugador", getLocalPlayer(), player)
end

function jailearJugador()
	local player = getPlayerFromName(guiGridListGetItemText(gridListPlayers, guiGridListGetSelectedItem(gridListPlayers), 1))
	if (not player) then 
		outputChatBox(errorString, 255, 0, 0, true) 
		return 
	end
	if guiGetText(razonPropia) == "" then
		outputChatBox(errorStringRazon, 0, 0, 0, true)
		return
	end
	if guiGetText(Tiempo) == "" then
		outputChatBox(errorStringTiempo, 0, 0, 0, true)
		return
	end
	triggerServerEvent("PoPLife:jailearJugador", getLocalPlayer(), player, guiGetText(razonPropia), guiGetText(Tiempo))
end