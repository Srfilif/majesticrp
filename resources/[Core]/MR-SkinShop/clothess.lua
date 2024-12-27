skinsTable = {}
skinsTable.all = {}
skinsTable.categories = {}
shops = {
	{ x = 207.5732421875, y = -100.71484375, z = 1005.2578125, dim = 0, int = 15},
}
function loadSkins()
	local xml = xmlLoadFile("files/skins.xml")
	for index, category in pairs(xmlNodeGetChildren(xml)) do
		local cName = xmlNodeGetAttribute(category, "name")
		skinsTable.categories[cName] = {}
		for index, skin in pairs(xmlNodeGetChildren(category)) do
			local id, name = xmlNodeGetAttribute(skin, "model"), xmlNodeGetAttribute(skin, "name")
			skinsTable.categories[cName][id] = name
			skinsTable.all[id] = name
		end
	end
	xmlUnloadFile(xml)
	alivePlayers = getAlivePlayers ()
	for ind,plr in ipairs (alivePlayers) do
		if getBoughtSkin(plr) == 139 then
			buySkin2(plr,0)	
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, loadSkins)

function fix (_,theCurrentAccount)
	if getBoughtSkin(source) == 139 then
		buySkin2(source,0)	
	end
end
addEventHandler("onPlayerLogin", root,fix)

function getSkinsTable(category)
	if not category then
		return  skinsTable.categories or false
	elseif category == "all" then
		return skinsTable.all or false
	else
		return skinsTable[category] or false
	end
	return false
end

function createSkinShops()
	for index, shop in pairs(shops) do
		local x, y, z, int, dim = shop.x, shop.y, shop.z, shop.int, shop.dim
		marker = createMarker(x, y, z-1, "cylinder", 1.5, 255, 255, 0, 170)
		setElementInterior(marker, int)
		setElementDimension(marker, dim)
		addEventHandler("onMarkerHit", marker, enteredShop)
	end
end
addEventHandler("onResourceStart", resourceRoot, createSkinShops)

function enteredShop(player, matchingDim)
    if player and getElementType(player) == "player" and matchingDim then
        local probability = math.random(1, 2)
        local category
        if probability == 1 then
            category = "femeninas"
        else
            category = "masculinas"
        end
        local skins = getSkinsTable(category)
        triggerClientEvent(player, "CSTclothes.showSkin", player, skins, category)
    end
end



function buySkin(model)
	if (getPlayerMoney(client) >= 500) then
		takePlayerMoney(client, 500)
		outputChatBox("Cambiaste tu skin correctamente", client, 0, 255, 0)
		setAccountData(getPlayerAccount(client), "skin", model)
		setElementModel(client, model)
	end
end
addEvent("CSTclothes.buySkin", true)
addEventHandler("CSTclothes.buySkin", root, buySkin)

function getBoughtSkin(player)
	if (not isElement(player)) then return end
	return tonumber(getAccountData(getPlayerAccount(player), "skin")) or 0
end

function buySkin2(plr,model)
if (getPlayerMoney(plr) >= 500) then
	takePlayerMoney(plr, 500)
	outputChatBox("Cambiaste tu skin correctamente", plr, 0, 255, 0)
	setAccountData(getPlayerAccount(plr), "skin", model)
	setElementModel(plr, model)
	end
end