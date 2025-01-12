----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 07 Nov 2014
-- Resource: GTIhousing/creation_gui.lua
-- Version: 1.0
----------------------------------------->>

-- House Creation GUI
---------------------->>

creation = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 235, 264
local sX, sY, wX, wY = 10,(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 1357, 310, 235, 264
creation.window[1] = guiCreateWindow(sX, sY, wX, wY, "GreenWood ~ Creacion de Casas", false)
guiWindowSetSizable(creation.window[1], false)
guiSetAlpha(creation.window[1], 0.90)
guiSetVisible(creation.window[1], false)
-- Labels
creation.label[1] = guiCreateLabel(11, 27, 130, 15, "Direccion:", false, creation.window[1])
guiSetFont(creation.label[1], "default-bold-small")
guiLabelSetColor(creation.label[1], 50, 255, 125)
creation.label[2] = guiCreateLabel(11, 75, 130, 15, "Garaje:", false, creation.window[1])
guiSetFont(creation.label[2], "default-bold-small")
guiLabelSetColor(creation.label[2], 50, 255, 125)
creation.label[3] = guiCreateLabel(11, 146, 99, 15, "Costo:", false, creation.window[1])
guiSetFont(creation.label[3], "default-bold-small")
guiLabelSetColor(creation.label[3], 50, 255, 125)
guiLabelSetHorizontalAlign(creation.label[3], "center", false)
creation.label[4] = guiCreateLabel(123, 146, 99, 15, "Interior:", false, creation.window[1])
guiSetFont(creation.label[4], "default-bold-small")
guiLabelSetColor(creation.label[4], 50, 255, 125)
guiLabelSetHorizontalAlign(creation.label[4], "center", false)
creation.label[5] = guiCreateLabel(9, 230, 211, 24, "Presiona X para esconder el cursor. La casa se creara donde tu estas parado", false, creation.window[1])
guiSetFont(creation.label[5], "default-small")
guiLabelSetHorizontalAlign(creation.label[5], "center", true)
-- Edits
creation.edit[1] = guiCreateEdit(11, 44, 216, 25, "", false, creation.window[1])	-- Address
creation.edit[2] = guiCreateEdit(11, 94, 216, 25, "", false, creation.window[1])	-- Garage Position
creation.edit[3] = guiCreateEdit(10, 166, 101, 25, "", false, creation.window[1])	-- Cost
creation.edit[4] = guiCreateEdit(122, 166, 101, 25, "", false, creation.window[1])	-- Interior ID
-- Buttons
creation.button[1] = guiCreateButton(130, 123, 96, 18, "Mis Coordenadas", false, creation.window[1])
creation.button[2] = guiCreateButton(14, 197, 207, 27, "Crear Casas", false, creation.window[1])
