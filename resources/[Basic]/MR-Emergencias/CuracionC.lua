local screenW, screenH = guiGetScreenSize()
dxCuras = false    
	
function curacionDx ()
    dxDrawText("Estás siendo trasladado...", screenW * 0.3836, screenH * 0.4267, screenW * 0.6727, screenH * 0.5767, tocolor(255, 255, 255, 255), 1.10, "pricedown", "center", "center", false, false, false, false, false)
end

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
			tx, ty, tz = xp, yp, zp
			local px, py, pz = getElementPosition(localPlayer)
			dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			if dist < 8 then
				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
					local sx, sy, sz = xp, yp, zp-0.5
					local x, y = getScreenFromWorldPosition( sx, sy, sz)
					if x and y then
					--	dxDrawBorderedText ( "#F1F1F1Usa #69E51E/curarse #F1F1F1si tienes menos del #F6414150% #F1F1F1de vida", x-80, y-120, 200 + x-80, 40 + y-120, tocolor ( 255, 255, 255, 255 ),1.1, "default-bold","center", "center" )
				        dxDrawBorderedText ( "#ffFFffUsa #ebde34/emergencias #ffFFffo pulsa #ebde34H #ffFFffPara entrar a #fa5c23emergencias", x-80, y-120, 200 + x-80, 40 + y-120, tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
					    
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


