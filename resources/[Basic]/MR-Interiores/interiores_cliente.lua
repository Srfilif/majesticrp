addEvent("onClientInteriorEnter", true)
addEvent("onClientInteriorExit", true)

addEventHandler("onClientRender", getRootElement(), function()
	for k, v in ipairs(getElementsByType("pickup")) do
		local pick = v:getData("pickup.interior")
		if pick == true then
			tx, ty, tz = getElementPosition( v )
			local px, py, pz = getElementPosition(localPlayer)
			dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
			if dist < 8 then
				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false, localPlayer ) then
					local sx, sy, sz = getElementPosition( v )
					local x, y = getScreenFromWorldPosition( sx, sy, sz)
					if x and y then
						local ubicacion = v:getData("pickup.info") or ""
						dxDrawText("Pulsa la tecla 'F' para interactuar\n"..ubicacion, x+1, y-60+1, x+1, y-60+1, tocolor(0,0,0,255), 1, "default-bold", "center", nil, false, false, false, true, false)
						dxDrawText("Pulsa la tecla 'F' para interactuar\n#FDCE61"..ubicacion, x, y-60, x, y-60, tocolor(255, 255, 255, 255), 1, "default-bold", "center", nil, false, false, false, true, false)
					end
				end
			end
		end
	end
end)