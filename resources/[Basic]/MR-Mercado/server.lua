local colSphere = createColSphere(1291.078125, -985.7060546875, 32.6953125, 3)

function accionarMercadoNegro(source)
	if not isElementWithinColShape(source, colSphere) then
		outputChatBox("* Estas muy lejos del mercado negro!", source, 255, 0, 0, true)
		return
	end
	triggerClientEvent(source, "POPLife:accionarMercadoNegro", source)
end
addCommandHandler("mercado", accionarMercadoNegro)

local armasMercado = {
	["Deagle"] = true,
	["MP5"] = true,
    ["M4"] = true,
}

local organosMercado = {
    ["Ojos"] = true,
    ["Estomago"] = true,
    ["Corazon"] = true,
}

function usarTienda(item, id, costo)
	local itemActual = exports["[LS]Tiendas"]:getPlayerItem(client, item) or 0
	if getPlayerMoney(client) <= tonumber(costo) then
		outputChatBox("* No tienes suficiente dinero para crear esto", client, 255, 200, 0)
		return
	end
    if item == "Chaleco AntiBalas" then
    	setPedArmor(client, 100)
    	outputDebugString(getPlayerName(client).." Compro un(a) "..item.." en el Mercado Negro", 0, 255, 200, 0)
    	outputChatBox("* Compraste un(a) "..item.." por $"..costo.." dolares", client, 255, 200, 0)
        takePlayerMoney(client, costo)
    	return
    end
    if organosMercado[item] == true then
        local itemActual = exports["[LS]Tiendas"]:getPlayerItem(client, item) or 0
        if itemActual < 1 then
            client:outputChat("* No tienes ningun objeto de este tipo", 255, 200, 0)
            return
        end
        exports["[LS]Tiendas"]:setPlayerItem(client, item, itemActual - 1)
        givePlayerMoney(client, costo)                                                                                          
        outputDebugString(getPlayerName(client).." Vendiste un(a) "..item.." en el Mercado Negro", 0, 255, 200, 0)
        outputChatBox("* Vendiste un(a) "..item.." por $"..costo.." dolares", client, 255, 200, 0)
        return
    end
    if armasMercado[item] == true then
    	local id = getWeaponIDFromName(item)
    	giveWeapon(client, id, 30, true)
    	outputDebugString(getPlayerName(client).." Compro un(a) "..item.." en el Mercado Negro", 0, 255, 200, 0)
    	outputChatBox("* Compraste un(a) "..item.." por $"..costo.." dolares", client, 255, 200, 0)
        takePlayerMoney(client, costo)
    	return
    end
    exports["[LS]Tiendas"]:setPlayerItem(client, item, itemActual + 1)
    takePlayerMoney(client, costo)
    outputDebugString(getPlayerName(client).." Compro un(a) "..item.." en el Mercado Negro", 0, 255, 200, 0)
    outputChatBox("* Compraste un(a) "..item.." por $"..costo.." dolares", client, 255, 200, 0)
end
addEvent("POPLife:usarTienda", true)
addEventHandler("POPLife:usarTienda", root, usarTienda)