addEventHandler("onClientRender", root,
	function()
		local px, py, pz = getCameraMatrix( )
		for k, thePlayer in ipairs(getElementsByType("player")) do
			tx, ty, tz = getElementPosition(thePlayer)
			dist = math.sqrt((px - tx)^2 + (py - ty)^2 + (pz-tz)^2)
			if dist < 15.0 then
				if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
					local sx, sy, sz = getPedBonePosition(thePlayer, 3)
					local x, y = getScreenFromWorldPosition(sx, sy, sz)
					local yo = getElementData(thePlayer, "yo")
					local id = getElementData(thePlayer, "ID")
					if yo then
						if yo[1]:find("#%x%x%x%x%x%x") then
							yo[1] = string.gsub(yo[1],"#%x%x%x%x%x%x","")
						end
					end

					if yo and x and y then
						dxDrawText(""..yo[1].."", x+1, y-20+1, x+1, y-20+1, tocolor(0,0,0,255), 1, "default-bold","center",nil, false, false, false, true, false)
						dxDrawText(""..yo[1].."", x, y-20, x, y-20, tocolor(195, 0, 0, 255), 1, "default-bold","center",nil, false, false, false, true, false)
					end
				end
			end
		end
	end
)