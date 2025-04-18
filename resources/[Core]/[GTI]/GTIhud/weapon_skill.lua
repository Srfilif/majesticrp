----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 11 Sept 2014
-- Resource: GTIhud/weapon_skill.slua
-- Version: 1.0
----------------------------------------->>

local isVisible

local sX,sY = guiGetScreenSize()
local sX,sY = sX*0.05,sY*0.95

local font = "sans"

addEventHandler("onClientResourceStart", resourceRoot, function()
	font = dxCreateFont("fonts/verdana.ttf", 9)
end)

local R,G,B = 100, 180, 215

-- Weapon Stats Panel
---------------------->>

addEventHandler("onClientRender", root,	function()
	if (not isVisible or getElementData(root, "port") ~= 22013) then return end
	
	dxDrawRectangle(sX, sY-326+64, 150, 326-64, tocolor(0, 0, 0, 200))
	
	local R,G,B = getPlayerNametagColor(localPlayer)
	
	-- Pistol
	dxDrawText("Pistol", sX+8, sY-34-(32*7), sX+161, sY-19-(32*7), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*7), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*7), width(69), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*7), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*7), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*7), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*7), 3, 9, tocolor(0, 0, 0, 125))
	
	-- Taser
	--[[dxDrawText("Taser", sX+8, sY-34-(32*8), sX+161, sY-19-(32*8), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*8), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*8), width(70), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*8), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*8), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*8), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*8), 3, 9, tocolor(0, 0, 0, 125))
	--]]
	-- Desert Eagle
	dxDrawText("Desert Eagle", sX+8, sY-34-(32*6), sX+161, sY-19-(32*6), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*6), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*6), width(71), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*6), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*6), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*6), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*6), 3, 9, tocolor(0, 0, 0, 125))
	
	-- Shotgun
	dxDrawText("Shotgun", sX+8, sY-34-(32*5), sX+161, sY-19-(32*5), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*5), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*5), width(72), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
	
	-- Sawn-off Shotgun
	--[[dxDrawText("Sawn-off Shotgun", sX+8, sY-34-(32*5), sX+161, sY-19-(32*5), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*5), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*5), width(73), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*5), 3, 9, tocolor(0, 0, 0, 125))
	--]]
	-- Spaz-12
	dxDrawText("Spaz-12 Shotgun", sX+8, sY-34-(32*4), sX+161, sY-19-(32*4), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*4), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*4), width(74), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*4), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*4), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*4), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*4), 3, 9, tocolor(0, 0, 0, 125))
	
	-- Micro Uzi
	dxDrawText("Micro Uzi", sX+8, sY-34-(32*3), sX+161, sY-19-(32*3), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*3), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*3), width(75), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*3), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*3), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*3), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*3), 3, 9, tocolor(0, 0, 0, 125))
	
	-- MP5
	dxDrawText("MP5", sX+8, sY-34-(32*2), sX+161, sY-19-(32*2), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*2), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*2), width(76), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*2), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*2), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*2), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*2), 3, 9, tocolor(0, 0, 0, 125))
	
	-- AK-47
	dxDrawText("AK-47", sX+8, sY-34-(32*1), sX+161, sY-19-(32*1), tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15-(32*1), 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15-(32*1), width(77), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15-(32*1), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15-(32*1), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15-(32*1), 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15-(32*1), 3, 9, tocolor(0, 0, 0, 125))
	
	-- M4
	dxDrawText("M4", sX+8, sY-34, sX+161, sY-19, tocolor(255, 255, 255, 255), 1.00, font, "left", "top")
	dxDrawRectangle(sX+6, sY-15, 138, 9, tocolor(R/3, G/3, B/3, 200))
	dxDrawRectangle(sX+6, sY-15, width(78), 9, tocolor(R, G, B, 200))
		dxDrawRectangle(sX+6+(27.6*1)-1.5, sY-15, 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*2)-1.5, sY-15, 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*3)-1.5, sY-15, 3, 9, tocolor(0, 0, 0, 125))
		dxDrawRectangle(sX+6+(27.6*4)-1.5, sY-15, 3, 9, tocolor(0, 0, 0, 125))
end)

-- Toggle Stats
---------------->>

addEventHandler("onClientKey", root, function(key, pressed)
	if (key ~= "F4") then return end
	if (pressed) then
		isVisible = true
	else
		isVisible = nil
	end
end)

-- Utilities
------------->>

function width(skill)
	local skill = getPedStat(localPlayer, skill)
	skill = skill/1000
	return 138*skill
end