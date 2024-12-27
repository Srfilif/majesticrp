----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 18 Dec 2013
-- Resource: GTIemployment/progressGUI.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

progressGUI = {tab = {}, scrollpane = {}, tabpanel = {}, label = {}, button = {}, window = {}, gridlist = {}, memo = {}, radiobutton = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 564, 405
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 396, 195, 564, 405
progressGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "POPLife ~ Trabajos - Sistema de Estadisticas y Detalles", false)
guiWindowSetSizable(progressGUI.window[1], false)
guiSetAlpha(progressGUI.window[1], 0.95)
-- Tab Panel
progressGUI.tabpanel[1] = guiCreateTabPanel(9, 24, 546, 372, false, progressGUI.window[1])

-- Current Job Tab
------------------->>

-- Tab
progressGUI.tab[1] = guiCreateTab("Trabajo Actual", progressGUI.tabpanel[1])
-- Scrollpane
progressGUI.scrollpane[1] = guiCreateScrollPane(314, 30, 226, 270, false, progressGUI.tab[1])
	-- Labels (Dynamic)
	progressGUI.label[38] = guiCreateLabel(3, 2, 211, 15, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", false, progressGUI.scrollpane[1])
	guiLabelSetHorizontalAlign(progressGUI.label[38], "left", true)
-- Labels (Static)
progressGUI.label[1] = guiCreateLabel(10, 17, 85, 15, "Trabajo Actual:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[1], "default-bold-small")
guiLabelSetColor(progressGUI.label[1], 255, 200, 0)
progressGUI.label[3] = guiCreateLabel(381, 9, 135, 15, "Descripcion del Trabajo", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[3], "default-bold-small")
guiLabelSetColor(progressGUI.label[3], 255, 200, 0)
progressGUI.label[5] = guiCreateLabel(314, 291, 226, 15, "____________________________________", false, progressGUI.tab[1])
progressGUI.label[6] = guiCreateLabel(7, 36, 287+6, 15, "_____________________________________________", false, progressGUI.tab[1])
progressGUI.label[8] = guiCreateLabel(10, 81, 80, 15, "Rango Actual:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[8], "default-bold-small")
guiLabelSetColor(progressGUI.label[8], 255, 200, 0)
progressGUI.label[10] = guiCreateLabel(10, 128, 120, 15, "Requistos Prox Nivel:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[10], "default-bold-small")
guiLabelSetColor(progressGUI.label[10], 255, 200, 0)
progressGUI.label[11] = guiCreateLabel(10, 104, 120, 15, "Progreso Actual:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[11], "default-bold-small")
guiLabelSetColor(progressGUI.label[11], 255, 200, 0)
progressGUI.label[51] = guiCreateLabel(10, 151, 102, 15, "Horas Trabajadas:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[51], "default-bold-small")
guiLabelSetColor(progressGUI.label[51], 255, 200, 0)
progressGUI.label[14] = guiCreateLabel(7, 168, 287+6, 15, "_____________________________________________", false, progressGUI.tab[1])
progressGUI.label[15] = guiCreateLabel(10, 198, 120, 15, "Experiencia Ganada:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[15], "default-bold-small")
guiLabelSetColor(progressGUI.label[15], 255, 200, 0)
progressGUI.label[16] = guiCreateLabel(10, 230, 102, 15, "Dinero Ganado:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[16], "default-bold-small")
guiLabelSetColor(progressGUI.label[16], 255, 200, 0)
progressGUI.label[19] = guiCreateLabel(7, 250, 287+6, 15, "_____________________________________________", false, progressGUI.tab[1])
progressGUI.label[20] = guiCreateLabel(11, 277, 165, 15, "Dinero Ganado(Ultima Hora):", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[20], "default-bold-small")
guiLabelSetColor(progressGUI.label[20], 255, 200, 0)
progressGUI.label[51] = guiCreateLabel(11, 314, 160, 15, "Exp Ganada(Ultima Hora):", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[51], "default-bold-small")
guiLabelSetColor(progressGUI.label[51], 255, 200, 0)

--[[progressGUI.label[22] = guiCreateLabel(13, 301, 282, 30, "Your account balance is automatically transferred to your bank account either every hour, when you resign, or when you go offline", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[22], "default-small")
guiLabelSetHorizontalAlign(progressGUI.label[22], "center", true)]]
-- Labels (Dynamic)
progressGUI.label[2] = guiCreateLabel(105, 17, 203, 15, "<Job Name>", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[2], "clear-normal")
progressGUI.label[7] = guiCreateLabel(10, 56, 50, 15, "Level XX", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[7], "default-bold-small")
guiLabelSetColor(progressGUI.label[7], 255, 200, 0)
progressGUI.label[9] = guiCreateLabel(150, 81, 191+6, 15, "<Rank Name>", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[9], "clear-normal")
progressGUI.label[12] = guiCreateLabel(150, 128, 164+6, 15, "XXX,XXX Units of Unit", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[12], "clear-normal")
progressGUI.label[13] = guiCreateLabel(150, 104, 191+6, 15, "XXX,XXX Units of Unit", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[13], "clear-normal")
progressGUI.label[17] = guiCreateLabel(150, 198, 172+6, 15, "XXX,XXX Exp. Points", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[17], "clear-normal")
progressGUI.label[52] = guiCreateLabel(150, 151, 164, 15, "XXXX hours", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[52], "clear-normal")
progressGUI.label[18] = guiCreateLabel(150, 231, 172+6, 15, "$XXX,XXX", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[18], "clear-normal")
progressGUI.label[50] = guiCreateLabel(180, 277, 161, 15, "$1,234,567", false, progressGUI.tab[1])
guiLabelSetColor(progressGUI.label[50], 25, 200, 25)
progressGUI.label[55] = guiCreateLabel(180, 314, 172+6, 15, "XXX Exp. Points", false, progressGUI.tab[1])
guiLabelSetColor(progressGUI.label[55], 25, 200, 25)
-- Buttons
progressGUI.button[1] = guiCreateButton(316, 313, 106, 25, "Terminar Trabajo", false, progressGUI.tab[1])
guiSetProperty(progressGUI.button[1], "NormalTextColour", "FFAAAAAA")
progressGUI.button[2] = guiCreateButton(431, 313, 106, 25, "Renunciar", false, progressGUI.tab[1])
guiSetProperty(progressGUI.button[2], "NormalTextColour", "FFAAAAAA")

-- All Jobs Tab
---------------->>

-- Tab
progressGUI.tab[2] = guiCreateTab("Todos los Trabajos", progressGUI.tabpanel[1])
-- Labels (Static)
progressGUI.label[21] = guiCreateLabel(10, 23-15, 70, 15+30, "Mi Nivel:", false, progressGUI.tab[2])
guiLabelSetHorizontalAlign(progressGUI.label[21], "center", true)
guiLabelSetVerticalAlign(progressGUI.label[21], "center")
progressGUI.label[23] = guiCreateLabel(198, 23, 64, 15, "Experiencia:", false, progressGUI.tab[2])
progressGUI.label[25] = guiCreateLabel(7, 46, 534, 15, "_______________________________________________________________________________________", false, progressGUI.tab[2])
progressGUI.label[26] = guiCreateLabel(70-50, 115, 104+100, 15, "Trabajos del Servidor", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[26], "clear-normal")
progressGUI.label[27] = guiCreateLabel(7, 93, 534, 15, "_______________________________________________________________________________________", false, progressGUI.tab[2])
progressGUI.label[31] = guiCreateLabel(251, 139, 79, 15, "Rango Actual:", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[31], "default-bold-small")
guiLabelSetColor(progressGUI.label[31], 255, 200, 0)
progressGUI.label[32] = guiCreateLabel(251, 170, 99, 15, "Progreso Actual:", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[32], "default-bold-small")
guiLabelSetColor(progressGUI.label[32], 255, 200, 0)
progressGUI.label[33] = guiCreateLabel(251, 201, 114, 15, "Progress for Promo:", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[33], "default-bold-small")
guiLabelSetColor(progressGUI.label[33], 255, 200, 0)
progressGUI.label[37] = guiCreateLabel(348, 231, 150, 15, "Descripcion del Trabajo", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[37], "default-bold-small")
guiLabelSetColor(progressGUI.label[37], 255, 200, 0)
-- Labels (Dynamic)
progressGUI.label[29] = guiCreateLabel(488, 115, 50, 15, "Level XX", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[29], "default-bold-small")
guiLabelSetColor(progressGUI.label[29], 255, 200, 0)
progressGUI.label[34] = guiCreateLabel(340, 139, 196, 15, "<Insert Rank Name Here>", false, progressGUI.tab[2])
progressGUI.label[35] = guiCreateLabel(378, 201, 160, 15, "<Insert Prog. 4 Promo Here>", false, progressGUI.tab[2])
progressGUI.label[36] = guiCreateLabel(362, 170, 177, 15, "<Insert Current Progress Here>", false, progressGUI.tab[2])
-- Gridlist
progressGUI.gridlist[1] = guiCreateGridList(7, 135, 220, 205, false, progressGUI.tab[2])
guiGridListAddColumn(progressGUI.gridlist[1], "Employment Jobs List", 0.9)
guiGridListSetSortingEnabled(progressGUI.gridlist[1], false)
-- Memo
progressGUI.memo[1] = guiCreateMemo(251, 250, 289, 90, "", false, progressGUI.tab[2])
guiMemoSetReadOnly(progressGUI.memo[1], true)

-- Other Settings
guiSetVisible(progressGUI.window[1], false)