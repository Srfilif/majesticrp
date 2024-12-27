----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 09 Nov 2014
-- Resource: GTIhousing/housing.lua
-- Version: 1.0
----------------------------------------->>

local LABEL_OFFSET = 0.50 -- Label height about house icon

local houseIcon		-- House Icon Pickup
local panelTimer	-- Close Panel Timer

addEvent("onClientHouseEnter", true)
addEvent("onClientHouseLeave", true)

--guiSetInputMode("no_binds_when_editing")

-- Render Text
--------------->>

addEventHandler("onClientRender", root, function()
	for i,pickup in ipairs(getElementsByType("pickup", resourceRoot, true)) do
		local px, py, pz = getCameraMatrix()
		local name = getElementData(pickup, "address")
		local value = getElementData(pickup, "value")
		if (name and value) then			
			local tx, ty, tz = getElementPosition(pickup)
			tz = tz + LABEL_OFFSET
			local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
			if (dist < 15) then
				if (isLineOfSightClear(px, py, pz, tx, ty, tz, true, true, false, true, true, false, false)) then
					local x,y = getScreenFromWorldPosition(tx, ty, tz)
					if (x) then
						local tick = getTickCount()/360
						local hover = math.sin(tick) * 10
						local text = name.."\n$"..tocomma(value)
						dxDrawText(text, x+1, y+1+hover, x+1, y+1+hover, tocolor(0,0,0), 1, "default-bold", "center", "center")
						dxDrawText(text, x+1, y-1+hover, x+1, y-1+hover, tocolor(0,0,0), 1, "default-bold", "center", "center")
						dxDrawText(text, x-1, y+1+hover, x-1, y+1+hover, tocolor(0,0,0), 1, "default-bold", "center", "center")
						dxDrawText(text, x-1, y-1+hover, x-1, y-1+hover, tocolor(0,0,0), 1, "default-bold", "center", "center")
						dxDrawText(text, x, y+hover, x, y+hover, tocolor(255,255,255), 1, "default-bold", "center", "center")
					end
				end
			end
		end
	end
end)

function tocomma(number)
	while true do
		number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return number
end

-- Show Housing Panel
---------------------->>

addEvent("GTIhousing.showHousingPanel", true)
addEventHandler("GTIhousing.showHousingPanel", root, function(house, icon)
	-- Home Panel Functions -->>
	guiSetText(housingGUI.window[1], " Casas ~ "..house["address"])
	guiSetText(housingGUI.label[2], "Interior "..house["interior"].." | ID: "..house["id"])
	guiSetText(housingGUI.label[3], house["address"])
	guiSetText(housingGUI.label[5], house["owner"])
	guiSetText(housingGUI.label[7], "$"..tocomma(house["value"]))
	
	-- Tab Access Functions -->>
	if (house["isOwner"]) then
		guiSetEnabled(housingGUI.tab[2], true)	-- Storage
		guiSetEnabled(housingGUI.tab[3], true)	-- Manage
		
		guiSetEnabled(housingGUI.button[2], true)
	else
		guiSetEnabled(housingGUI.tab[2], false)	-- Storage
		guiSetEnabled(housingGUI.tab[3], false)	-- Manage
		
		guiSetEnabled(housingGUI.button[2], false)
	end
	
	-- House For Sale? -->>
	if (house["forSale"]) then
		if (not house["isOwner"]) then
			guiSetText(housingGUI.button[2], "Comprar")
			guiSetText(housingGUI.label[8], "Esta casa esta a la venta!, Usa 'Comprar' para adquirirla")
		else
			guiSetText(housingGUI.button[2], "Cancelar Venta")
			guiSetText(housingGUI.label[8], "Esta casa esta a la venta! Usa 'Cancelar' para dejar de venderla")
		end
		guiLabelSetColor(housingGUI.label[8], 25, 255, 25)
		
		guiSetEnabled(housingGUI.button[2], true)
		guiSetEnabled(housingGUI.tab[2], false)	-- Storage
		guiSetEnabled(housingGUI.tab[3], false)	-- Manage
		
		guiSetText(housingGUI.label[14], "Sale Price:")
		guiSetText(housingGUI.label[15], "$"..tocomma(house["saleCost"]))
	else
		guiSetText(housingGUI.button[2], "Vender")
		guiSetText(housingGUI.label[8], "Esta casa no esta a la venta")
		guiLabelSetColor(housingGUI.label[8], 30, 160, 115)
		guiSetText(housingGUI.label[14], "Bought For:")
		guiSetText(housingGUI.label[15], "$"..tocomma(house["boughtFor"]))
	end
		
	-- Is House Actively Rented? -->>
	if (house["renter"]) then
		guiSetText(housingGUI.label[12], house["renter"])
		guiSetText(housingGUI.label[13], "$"..tocomma(house["rent"]).."/week")
		for i=10,13 do
			guiSetVisible(housingGUI.label[i], true)
		end
		guiSetVisible(housingGUI.staticimage[1], false)
	else
		for i=10,13 do
			guiSetVisible(housingGUI.label[i], false)
		end
		guiSetVisible(housingGUI.staticimage[1], true)
	end
	
	-- Is House Locked? -->>
	if (house["locked"]) then
		-- Set Manage Tab Text
		guiSetText(housingGUI.button[6], "Desbloquear Casa")
		guiSetText(housingGUI.label[20], "Esta casa esta bloqueada. Desbloquear?")
		-- Enter House Access -->>
		if (not house["access"]) then
			guiSetEnabled(housingGUI.button[1], false)
		else
			guiSetEnabled(housingGUI.button[1], true)
		end
	else
		-- Set Manage Tab Text
		guiSetText(housingGUI.button[6], "Bloquear Casa")
		guiSetText(housingGUI.label[20], "Esta casa esta desbloqueada. Bloquear?")
		guiSetEnabled(housingGUI.button[1], true)
	end
	
	guiSetSelectedTab(housingGUI.tabpanel[1], housingGUI.tab[1])
	
	guiSetVisible(housingGUI.window[1], true)
	showCursor(true)
	
	houseIcon = icon
	panelTimer = setTimer(houseDistanceCheck, 500, 0)
	
	-- Get Inventory
	if (house["isOwner"]) then
		triggerServerEvent("GTIhousing.getHouseStorage", resourceRoot, getHouseID())
	end
end)

-- Close Panel
--------------->>

-- Close on Event -->>
function closePanel(house)
	if (house and house ~= getHouseID()) then return end
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	for i,edit in ipairs(getElementsByType("gui-edit", resourceRoot)) do
		guiSetText(edit, "")
	end
	for i,gridlist in ipairs(getElementsByType("gui-gridlist", resourceRoot)) do
		guiGridListClear(gridlist)
	end
	showCursor(false)
	houseIcon = nil
	
	if (panelTimer and isTimer(panelTimer)) then
		killTimer(panelTimer)
		panelTimer = nil
	end
	
	triggerServerEvent("GTIhousing.closePanel", resourceRoot)
end
addEvent("GTIhousing.closePanel", true)
addEventHandler("GTIhousing.closePanel", root, closePanel)

addEventHandler("onClientGUIClick", housingGUI.label[19], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	closePanel()
end, false)

addEventHandler("onClientMouseEnter", housingGUI.label[19], function()
	guiLabelSetColor(source, 30, 160, 115)
end, false)

addEventHandler("onClientMouseLeave", housingGUI.label[19], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

	-- Distance Timer
function houseDistanceCheck()
	if (not houseIcon or not isElement(houseIcon)) then return end
	if (getDistanceBetweenElements3D(houseIcon, localPlayer) > 3) then
		closePanel()
	end
end

function getDistanceBetweenElements3D(element1, element2)
	if (not isElement(element1) or not isElement(element2)) then return false end
	local x1,y1,z1 = getElementPosition(element1)
	local x2,y2,z2 = getElementPosition(element2)
	return getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
end

-- Enter House
--------------->>

addEventHandler("onClientGUIClick", housingGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerServerEvent("GTIhousing.enterHouse", resourceRoot, getHouseID())
	guiSetVisible(housingGUI.window[1], false)
	showCursor(false)
end, false)

-- Buy House
------------->>

addEventHandler("onClientGUIClick", housingGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if (guiGetText(source) ~= "Comprar") then return end
	guiBringToFront(confirmGUI.window[1])
	guiSetVisible(confirmGUI.window[1], true)
	local address = guiGetText(housingGUI.label[3])
	local address = string.gsub(address, ".+\n", "")
	local cost = guiGetText(housingGUI.label[15])
	guiSetText(confirmGUI.label[1], "Estas seguro de deseas comprar \n"..address.." por "..cost.."?")
	playSoundFrontEnd(5)
end, false)

addEventHandler("onClientGUIClick", confirmGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerServerEvent("GTIhousing.buyHouse", resourceRoot, getHouseID())
end, false)

addEventHandler("onClientGUIClick", confirmGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(confirmGUI.window[1], false)
end, false)

-- Sell House
-------------->>

function openSellHousePanel(button, state, cont)
	if (button ~= "left" or state ~= "up") then return end
	if (guiGetText(housingGUI.button[2]) ~= "Vender") then return end
	
	-- Show Storage Warning
	if (guiGridListGetRowCount(housingGUI.gridlist[2]) > 0 and cont ~= true) then
		showStorageWarning()
		return
	end
	
	local address = guiGetText(housingGUI.label[3])
	local address = string.gsub(address, ".+\n", "")
	local value = string.gsub(guiGetText(housingGUI.label[7]), "%D", "")
	local value = math.floor(tonumber(value) * 0.9)
	
	guiSetText(sellHouseGUI.label[1], "Estas por vender la casa "..address)
	guiSetText(sellHouseGUI.label[3], "Vender a la alcaldia por $"..tocomma(value))
	
	guiBringToFront(sellHouseGUI.window[1])
	guiSetVisible(sellHouseGUI.window[1], true)
end
addEventHandler("onClientGUIClick", housingGUI.button[2], openSellHousePanel, false)

	-- Sell House
addEventHandler("onClientGUIClick", sellHouseGUI.window[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if (source ~= sellHouseGUI.button[1] and source ~= sellHouseGUI.button[2]) then return end
	
	local value = tonumber(guiGetText(sellHouseGUI.edit[1]))
	if (source == sellHouseGUI.button[1] and not value) then
		outputChatBox("Coloca un precio por el cual quieres vender la casa.", 255, 125, 0)
		return
	end
	
	local toPublic = source == sellHouseGUI.button[1]
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	showCursor(false)
	triggerServerEvent("GTIhousing.sellHouse", resourceRoot, getHouseID(), toPublic, value)
end)

	-- Revoke Sale
addEventHandler("onClientGUIClick", housingGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if (guiGetText(source) ~= "Cancelar Venta") then return end

	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	showCursor(false)
	triggerServerEvent("GTIhousing.revokeSale", resourceRoot, getHouseID())
end)

	-- Close Sell House Panel
addEventHandler("onClientGUIClick", sellHouseGUI.button[3], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(sellHouseGUI.window[1], false)
end, false)

	-- Block Non-number text
addEventHandler("onClientGUIChanged", sellHouseGUI.window[1], function()
	local text = guiGetText(source)
	if (string.gsub(text, "%D", "") ~= text) then
		guiSetText(source, string.gsub(text, "%D", ""))
	end
end)

-- Utilities
------------->>

function getHouseID()
	local text = guiGetText(housingGUI.label[2])
	local text = string.gsub(text, ".+|%D+", "")
	return tonumber(text)
end