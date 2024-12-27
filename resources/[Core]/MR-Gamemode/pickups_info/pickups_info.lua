local pickups_infos = {
	{ info = "〖 Si eres nuevo en la ciudad, ve a la alcaldia para sacar tu D.N.I 〗\n〖 Si tienes una duda utiliza /duda 'Tu duda' /payuda 'Pedir ayuda al staff' F1 'Panel de Informacion General' 〗", 2251.529296875+5, -83.7509765625-2, 26.520988464355, r = 255, g = 255, b = 255, font = "arial" },
}

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i, v in pairs( pickups_infos ) do
		Pickup( v[1], v[2], v[3], 3, 1239, 0 )
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(pickups_infos) do
		local playerX, playerY, playerZ = v[1], v[2], v[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v.info, sx, sy, sx, sy , tocolor ( v.r, v.g, v.b, 255 ),1, v.font,"center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

local posxD = {
	{362.048828125, 173.5888671875, 1008.3828125, "#FFA600/obtenerdni\n#FFFFFFSaca un documento de identificación"},
	{358.236328125, 180.740234375, 1008.38281255, "#FFA600/obtenertarjeta\n#FFFFFFSaca una tarjeta de crédito para guardar tu dinero"},
}