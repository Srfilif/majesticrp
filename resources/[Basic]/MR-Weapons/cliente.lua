local inCol = false

addEventHandler( "onClientColShapeHit", root, 
	function(element)
		if element and element.type == 'player' then
			if source:getData('weapon_data') then	
				inCol = source
			end
		end
	end
)

addEventHandler( "onClientColShapeLeave", root, 
	function(element)
		if element and element.type == 'player' then
			if source:getData('weapon_data') then
				inCol = false
			end
		end
	end
)

addEventHandler( "onClientRender", getRootElement(), 
	function()
		if inCol and inCol ~= nil and inCol ~= false then
			if isElement(inCol) then
				if localPlayer:isWithinColShape(inCol) then
							local weaponid = colshapes[currentGround].weaponid
			local ammo = colshapes[currentGround].ammo
					local sx,sy = getScreenFromWorldPosition(inCol.position.x,inCol.position.y,inCol.position.z+.6)
					local w = dxGetTextWidth( 'Pulsa K para recoger esta arma', 1, 'default-bold')
					 dxDrawRectangle(501, 535, 365, 103, tocolor(0, 0, 0, 209), false)
        dxDrawText("Alejate para hacer \n desaparecer este cartel", 712, 577, 856, 612, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText("Toca la \"K\" para\n recoger el arma", 511, 572, 627, 612, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawRectangle(501, 535, 365, 4, tocolor(255, 255, 255, 255), false)
        dxDrawText(""..tostring(ammo).." bala(s)", 642, 615, 707, 638, tocolor(255, 255, 255, 255), 1.00, "default", "center", "top", false, false, false, false, false)
        dxDrawImage(642, 552, 65, 60, "img/" .. weaponid .. ".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				end
			end
		end
	end
)
--setElementRotation(inCol:getData('weapon_data')[1], 90,y,z)
addEventHandler( "onClientKey", getRootElement(), 
	function(key,press)
		if inCol and inCol ~= nil and inCol ~= false then
			if isElement(inCol) then
				if inCol and localPlayer:isWithinColShape(inCol) then
					if #getElementsWithinColShape(inCol,'player') == 1 then
						if (key == 'k') and (press) then
							triggerLatentServerEvent('onGiveWeapon',5000,false,resourceRoot,inCol:getData('weapon_data'))
							inCol = false
						end
					end
				end
			end
		end
	end
)

Timer(function()
	for k,v in pairs(getElementsByType('player')) do
		if v.health <=30 then
			setPedFootBloodEnabled(v, true)
		else
			setPedFootBloodEnabled(v, false)
		end
	end
end,100,0)

