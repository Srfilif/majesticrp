-- _______ ____  __  __ __  ____     __
--|__   __/ __ \|  \/  |  \/  \ \   / /
--   | | | |  | | \  / | \  / |\ \_/ / 
--   | | | |  | | |\/| | |\/| | \   /  
--   | | | |__| | |  | | |  | |  | |   
--   |_|  \____/|_|  |_|_|  |_|  |_|   

addEventHandler ( "onClientPlayerDamage",root,
function ()
    if getElementData(source,"AfkMode") then
        cancelEvent()
    end
end)
 
addEventHandler("onClientPlayerStealthKill",localPlayer,
function (targetPlayer)
    if getElementData(targetPlayer,"AfkMode") then
        cancelEvent()
    end
end)


function on(source)
	local px, py, pz, tx, ty, tz, dist
	px, py, pz = getCameraMatrix( )
	for _, v in ipairs( getElementsByType 'player' ) do

		tx, ty, tz = getElementPosition( v )
		dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
		if dist < 30.0 then
			if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
				local sx, sy, sz = getPedBonePosition( v, 5 )
				local x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3 )
				if x then
					if getElementData(v, "AfkMode") then
						dxDrawText("AFK", x, y, x, y, tocolor(255, 0, 0, 255), 1, "pricedown", "center", "center", false, false, false, colorCoded);
					end
               end
            end
		end
	end
end
addEventHandler ( "onClientRender", root, on )