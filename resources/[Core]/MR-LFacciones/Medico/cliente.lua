local screenW, screenH = guiGetScreenSize()
dxCuras = false    
	

function togCurasDx()
	if dxCuras == true then
		removeEventHandler("onClientRender",getRootElement(),curacionDx)
		dxCuras = false
		else
		addEventHandler("onClientRender",getRootElement(), curacionDx)
		dxCuras = true
	end
end
addEvent("mostrarCura", true)
addEventHandler("mostrarCura",getRootElement(),togCurasDx)
addEventHandler("onClientRender", getRootElement(), function()
			tx, ty, tz = 2036.8720703125, -1438.275390625, 16.568519592285
			local px, py, pz = getElementPosition(localPlayer)
			dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			if dist < 8 then
				if isLineOfSightClear( px, py, pz, 2036.8720703125, -1438.275390625, 16.568519592285, true, false, false, true, false, false, false,localPlayer ) then
					local sx, sy, sz = 2036.8720703125, -1438.275390625, 16.568519592285 -0.5
					local x, y = getScreenFromWorldPosition( 2036.8720703125, -1438.275390625, 16.568519592285)
					if x and y then
					--	dxDrawBorderedText ( "#F1F1F1Usa #69E51E/curarse #F1F1F1si tienes menos del #F6414150% #F1F1F1de vida", x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 255, 255, 255, 255 ),1.1, "default-bold","center", "center" )
				        dxDrawBorderedText ( "#ffFFffUsa #ebde34/garaje #ffFFffo pulsa #ebde34H #ffFFffPara entrar a el #fa5c23garaje", x-80, y-120, 200 + x-80, 40 + y-120, tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
					    
					end
				end
			end
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

---


addEventHandler("onClientRender", getRootElement(), function()
			tx, ty, tz = 1402.61328125, 3.0185546875, 1001.0598144531
			local px, py, pz = getElementPosition(localPlayer)
			dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			if dist < 8 then
				if isLineOfSightClear( px, py, pz, 1402.61328125, 3.0185546875, 1001.0598144531, true, false, false, true, false, false, false,localPlayer ) then
					local sx, sy, sz = 1402.61328125, 3.0185546875, 1001.0598144531 -0.5
					local x, y = getScreenFromWorldPosition( 1402.61328125, 3.0185546875, 1001.0598144531)
					if x and y then
					--	dxDrawBorderedText ( "#F1F1F1Usa #69E51E/curarse #F1F1F1si tienes menos del #F6414150% #F1F1F1de vida", x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 255, 255, 255, 255 ),1.1, "default-bold","center", "center" )
				        dxDrawBorderedText ( "#ffFFffUsa #ebde34/garaje #ffFFffo pulsa #ebde34H #ffFFffPara entrar a el #fa5c23garaje", x-80, y-120, 200 + x-80, 40 + y-120, tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
					    
					end
				end
			end
end)

