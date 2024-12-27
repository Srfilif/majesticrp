local screenWidth, screenHeight = guiGetScreenSize()

function createSkinWindow()
	windowWidth, windowHeight = 335, 414
	windowX, windowY = (screenWidth / 1) - (windowWidth / 1), (screenHeight / 2) - (windowHeight / 2)
	skinWindow = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, " Tienda de Skins", false)
	guiSetAlpha(skinWindow, 1)
	skinGridlist = guiCreateGridList(9, 25, 317, 325, false, skinWindow)
	skinTitleColumn = guiGridListAddColumn(skinGridlist, "Nombre", 0.45)
	skinIDColumn = guiGridListAddColumn(skinGridlist, "ID", 0.2)
	skinBuyButton = guiCreateButton(9, 371, 132, 33, "Comprar Skin\n$500", false, skinWindow)
	skinExitButton = guiCreateButton(194, 371, 132, 33, "Cerrar", false, skinWindow)
	guiSetVisible(skinWindow, false)

	--Events
	addEventHandler("onClientGUIClick", skinExitButton, function () guiSetVisible(skinWindow, false) showCursor(false) setPlayerHudComponentVisible("all", true) setElementModel(localPlayer, model) setElementFrozen(localPlayer, false) end, false)
	addEventHandler("onClientGUIClick", skinBuyButton, buySkin, false)
	addEventHandler("onClientGUIClick", skinGridlist, previewSkin, false)
end
addEventHandler("onClientResourceStart", resourceRoot, createSkinWindow)

function showSkin(skinsTable, category)
    guiGridListClear(skinGridlist)
    setElementFrozen(localPlayer, true)
    if not category then
        return
    end
    for id, name in pairs(skinsTable) do
        local row = guiGridListAddRow(skinGridlist)
        guiGridListSetItemText(skinGridlist, row, 1, name, false, false)
        guiGridListSetItemText(skinGridlist, row, 2, id, false, false)
    end
    guiSetVisible(skinWindow, true)
    showCursor(true)
    model = getElementModel(localPlayer)
end

addEvent("CSTclothes.showSkin", true)
addEventHandler("CSTclothes.showSkin", root, showSkin)

function previewSkin()
	local row = guiGridListGetSelectedItem(skinGridlist)
	if (not row or row == -1) then return end
	local id = guiGridListGetItemText(skinGridlist, row, 2)
	id = tonumber(id)
	if (not id) then return end
	setElementModel(localPlayer, id)
end

function buySkin()
	if (getPlayerMoney() <= 500) then
		exports.CSTtexts:output("You can not afford to buy this skin", 255, 0, 0)
		return
	end
	local row = guiGridListGetSelectedItem(skinGridlist)
	if (not row or row == -1) then return end
	local id = guiGridListGetItemText(skinGridlist, row, 2)
	id = tonumber(id)
	if (not id) then return end
	setElementModel(localPlayer, model)
	setElementFrozen(localPlayer, false)
	guiSetVisible(skinWindow, false)
	showCursor(false)
	triggerServerEvent("CSTclothes.buySkin", root, id)
end