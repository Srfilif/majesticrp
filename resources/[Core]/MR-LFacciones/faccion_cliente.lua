local blip = {}

addEvent("Police:create_blip", true)
function create_blip(p)
	local pos = Vector3(p:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	blip[p] = Blip.createAttachedTo(p, 0, 3, 20, 80, 100, 500)
end
addEventHandler("Police:create_blip", root, create_blip)

addEvent("Police:destroy_blip", true)
function destroy_blip(p)
	if isElement(blip[p]) then
		destroyElement(blip[p])
	end
end
addEventHandler("Police:destroy_blip", root, destroy_blip)

addEvent("playSo", true)
addEventHandler("playSo", root, function()
	playSound("files/dee5cc340eb4d.mp3")
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	EngineTXD("files/taser.txd"):import(347)
	EngineDFF("files/taser.dff"):replace(347)
end)

--
function fireTaserSound(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
	if (weapon == 23) then
		Sound3D("files/Fire.wav", startX, startY, startZ)
		local s = Sound3D("files/Fire.wav", hitX, hitY, hitZ)
		s:setMaxDistance(50)
		for i=1, 5, 1 do
			Effect.addPunchImpact(hitX, hitY, hitZ, 0, 0, 0)
			Effect.addSparks(hitX, hitY, hitZ, 0, 0, 0, 8, 1, 0, 0, 0, true, 3, 1)
		end
		Effect.addPunchImpact(startX, startY, startZ, 0, 0, -3)
		if (source == localPlayer) then
			toggleControl("fire", false)
			setTimer(function()
				toggleControl("fire", true)
			end, 350, 1)
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", getRootElement(), fireTaserSound)
--
function AnimacionTaser(attacker, weapon, bodypart, loss)
	if (weapon == 23) then
		--if (bodypart == 9) then
		triggerServerEvent("setAnimAndCable", attacker, source)
		cancelEvent()
		--end
	end
end
addEventHandler("onClientPlayerDamage", getRootElement(), AnimacionTaser)

addEventHandler ("onClientPlayerDamage", root, 
function (attacker, weapon)
	if source == localPlayer then
		if localPlayer:getData("NoDamageKill") == true then
			cancelEvent()
		end
	end
end
)

pickups_infos = {
    { info = "/crafteo", -552.986328125, -181.369140625, 78.40625, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
    { info = "/fundir", 2162.9443359375, -104.2353515625, 2.75, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
    { info = "/operar 'Jugador', 'Organo', (Ojos, Estomago, Corazon)", -232.171875, 1403.51953125, 69.9375, int = 3, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
    { info = "/mercado", -395.470703125, 1259.4697265625, 7.0730743408203, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
    { info = "/obtenerdni", 362.1533203125, 173.7119140625, 1008.3828125, int = 3, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
    { info = "/obtenertarjeta", 358.236328125, 180.740234375, 1008.3828125, int = 3, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
    { info = "/garajem", -334.4853515625, 1048.361328125, 19.7421875, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
    { info = "/garajep", 620.1826171875, -608.3037109375, 17.233013153076, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
	{ info = "/pala", 1266.072265625, -1269.009765625, 13.478275299072, int = 0, dim = 0, r = 255, g = 255, b = 255, font = "default-bold"  },
}

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(pickups_infos) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 10 then
				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 
			end
		end
	end
end)



function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end