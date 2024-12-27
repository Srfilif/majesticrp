----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/manage_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Manage Buttons
------------------>>

local manage_tab = {
	{"Bloquear Casa", "Esta casa esa desbloqueada. Bloquear?"},
}

for i,v in ipairs(manage_tab) do
	-- Buttons
	housingGUI.button[i+5] = guiCreateButton(3, 8+(35*(i-1)), 115, 20, v[1], false, housingGUI.scrollpane[1])
	-- Labels
	housingGUI.label[i+19] = guiCreateLabel(125, 0+(35*(i-1)), 222, 30, v[2], false, housingGUI.scrollpane[1])
	guiLabelSetHorizontalAlign(housingGUI.label[i+19], "left", true)
	guiLabelSetVerticalAlign(housingGUI.label[i+19], "center")
end


-- Storage Warning
------------------->>

storwarn2GUI = {button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 322, 129
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 642, 333, 322, 129
storwarn2GUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "HOUSE STORAGE LOSS WARNING", false)
guiWindowSetSizable(storwarn2GUI.window[1], false)
guiSetAlpha(storwarn2GUI.window[1], 1)
guiSetVisible(storwarn2GUI.window[1], false)
-- Label
storwarn2GUI.label[1] = guiCreateLabel(14, 31, 291, 46, "You will lose everything in your housing storage if you continue! Are you sure you want to transfer your house with items in your house storage?", false, storwarn2GUI.window[1])
guiLabelSetHorizontalAlign(storwarn2GUI.label[1], "center", true)
-- Buttons
storwarn2GUI.button[1] = guiCreateButton(90, 87, 62, 25, "Yes", false, storwarn2GUI.window[1])
storwarn2GUI.button[2] = guiCreateButton(165, 87, 62, 25, "No", false, storwarn2GUI.window[1])
