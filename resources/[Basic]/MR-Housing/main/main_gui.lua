----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 07 Nov 2014
-- Resource: GTIhousing/main_gui.lua
-- Version: 1.0
----------------------------------------->>

housingGUI = {tab = {}, scrollpane = {}, edit = {}, window = {}, tabpanel = {}, button = {}, label = {}, staticimage = {}, gridlist = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 401, 376-96
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 604, 277, 401, 376
housingGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "POPLife Casas ~ 1234 Calle Falsa", false)
guiWindowSetSizable(housingGUI.window[1], false)
guiSetAlpha(housingGUI.window[1], 0.85)
guiSetVisible(housingGUI.window[1], false)
-- Images
--housingGUI.staticimage[1] = guiCreateStaticImage(9, 25, 384, 96, "files/housing.png", false, housingGUI.window[1])
-- Tab Panel
housingGUI.tabpanel[1] = guiCreateTabPanel(9, 126-96, 383, 238, false, housingGUI.window[1])
-- Buttons 
housingGUI.label[19] = guiCreateLabel(356, 22, 37, 15, "Cerrar", false, housingGUI.window[1])

-- Home Tab -->>
housingGUI.tab[1] = guiCreateTab("Casa", housingGUI.tabpanel[1])
-- Images
housingGUI.staticimage[1] = guiCreateStaticImage(81, 120, 220, 55, "files/housing.png", false, housingGUI.tab[1])
-- Labels (Static)
housingGUI.label[1] = guiCreateLabel(8, 17, 63, 15, "Direccion:", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[1], "default-bold-small")
guiLabelSetColor(housingGUI.label[1], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[1], "right", false)
housingGUI.label[4] = guiCreateLabel(8, 45, 63, 15, "Dueño:", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[4], "default-bold-small")
guiLabelSetColor(housingGUI.label[4], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[4], "right", false)
housingGUI.label[6] = guiCreateLabel(8, 68, 63, 15, "Costo:", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[6], "default-bold-small")
guiLabelSetColor(housingGUI.label[6], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[6], "right", false)
housingGUI.label[9] = guiCreateLabel(6, 106, 372, 15, "", false, housingGUI.tab[1])
housingGUI.label[10] = guiCreateLabel(8, 124, 63, 15, "Renta:", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[10], "default-bold-small")
guiLabelSetColor(housingGUI.label[10], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[10], "right", false)
housingGUI.label[11] = guiCreateLabel(8, 147, 63, 15, "Rent Amt:", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[11], "default-bold-small")
guiLabelSetColor(housingGUI.label[11], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[11], "right", false)
housingGUI.label[14] = guiCreateLabel(192-10, 68, 63+10, 15, "Sale Price:", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[14], "default-bold-small")
guiLabelSetColor(housingGUI.label[14], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[14], "right", false)
-- Labels (Dynamic)
housingGUI.label[2] = guiCreateLabel(283, 7, 92, 15, "Interior 99 | ID 9999", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[2], "default-small")
guiLabelSetColor(housingGUI.label[2], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[2], "right", false)
housingGUI.label[3] = guiCreateLabel(77, 9, 298, 29, "House Name\n1234 Street Road", false, housingGUI.tab[1])
guiLabelSetVerticalAlign(housingGUI.label[3], "center")
housingGUI.label[5] = guiCreateLabel(77, 44, 294, 15, "[ABC]Player>123 (player123)", false, housingGUI.tab[1])
housingGUI.label[7] = guiCreateLabel(77, 68, 108, 15, "$999,999,999", false, housingGUI.tab[1])		-- Valued at
housingGUI.label[8] = guiCreateLabel(8, 91, 368, 15, "This house is not for sale", false, housingGUI.tab[1])
guiSetFont(housingGUI.label[8], "default-bold-small")
guiLabelSetColor(housingGUI.label[8], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[8], "center", false)
housingGUI.label[12] = guiCreateLabel(77, 124, 294, 15, "{DEF}Player*456", false, housingGUI.tab[1])
housingGUI.label[13] = guiCreateLabel(77, 147, 294, 15, "$999,999,999 per week", false, housingGUI.tab[1])
housingGUI.label[15] = guiCreateLabel(261, 68, 108, 15, "$999,999,999", false, housingGUI.tab[1])	-- Sale Price
-- Buttons
housingGUI.button[1] = guiCreateButton(33, 180, 97, 22, "Entrar", false, housingGUI.tab[1])
housingGUI.button[2] = guiCreateButton(245, 180, 97, 22, "Comprar", false, housingGUI.tab[1])
-- Storage -->>
housingGUI.tab[2] = guiCreateTab("Inventario", housingGUI.tabpanel[1])
-- Labels
housingGUI.label[16] = guiCreateLabel(22, 5, 117, 15, "Mi Inventario", false, housingGUI.tab[2])
guiSetFont(housingGUI.label[16], "default-bold-small")
guiLabelSetColor(housingGUI.label[16], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[16], "center", false)
housingGUI.label[17] = guiCreateLabel(12, 192, 362, 15, "Selecciona un item para guardarlo/sacarlo del Inventario de la casa", false, housingGUI.tab[2])
guiSetFont(housingGUI.label[17], "default-small")
guiLabelSetHorizontalAlign(housingGUI.label[17], "center", false)
housingGUI.label[18] = guiCreateLabel(243, 5, 117, 15, "Inventario de la Casa", false, housingGUI.tab[2])
guiSetFont(housingGUI.label[18], "default-bold-small")
guiLabelSetColor(housingGUI.label[18], 30, 160, 115)
guiLabelSetHorizontalAlign(housingGUI.label[18], "center", false)
-- Gridlists
housingGUI.gridlist[1] = guiCreateGridList(9, 24, 153, 165, false, housingGUI.tab[2])
guiGridListAddColumn(housingGUI.gridlist[1], "Arma", 0.5)
guiGridListAddColumn(housingGUI.gridlist[1], "Municion", 0.48)
guiGridListSetSortingEnabled(housingGUI.gridlist[1], false)
housingGUI.gridlist[2] = guiCreateGridList(223, 24, 153, 165, false, housingGUI.tab[2])
guiGridListAddColumn(housingGUI.gridlist[2], "Arma", 0.5)
guiGridListAddColumn(housingGUI.gridlist[2], "Municion", 0.48)
guiGridListSetSortingEnabled(housingGUI.gridlist[2], false)
-- Buttons
housingGUI.button[4] = guiCreateButton(167, 66, 51, 20, "<<<", false, housingGUI.tab[2])
housingGUI.button[5] = guiCreateButton(167, 111, 51, 20, ">>>", false, housingGUI.tab[2])
-- Edit
housingGUI.edit[1] = guiCreateEdit(167, 89, 50, 18, "", false, housingGUI.tab[2])

-- Manage -->>
housingGUI.tab[3] = guiCreateTab("Administrar", housingGUI.tabpanel[1])
-- Scrollpane
housingGUI.scrollpane[1] = guiCreateScrollPane(7, 5, 369, 201, false, housingGUI.tab[3])
