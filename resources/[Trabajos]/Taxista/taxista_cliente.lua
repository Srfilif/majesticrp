local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768



local ValoresTrabajo = {}

local PosicionAuto = {}

local MarcadoresRuta = {}

local BlipsRuta = {}

local PedsRuta = {}

local TimerK = {}

local tableN = {}






addEventHandler("onClientVehicleEnter", getRootElement(),

	function(thePlayer, seat)

		if thePlayer == getLocalPlayer() then

			if seat == 0 then

				if source:getModel() == 420 and source:getData("VehiculoPublico") == "Taxista" then

					if thePlayer:getData("Roleplay:trabajo") == "Taxista" then

						if tableN[thePlayer] == true then

        					if isTimer(TimerK[thePlayer]) then

        						killTimer(TimerK[thePlayer])

								TimerK[thePlayer] = nil;

								tableN[thePlayer] = nil;

        					end

						end

						if ValoresTrabajo[thePlayer] then else

							local random = math.random(1, 2)

							ValoresTrabajo[thePlayer] = {nil, 1, true, random}

	        				local x, y, z = getElementPosition(source)

	        				local x2, y2, z2 = getElementRotation(source)

	        				table.insert(PosicionAuto, {x, y, z, x2, y2, z2})

						end

					end

				end

			end

		end

	end

)



--
addEventHandler("onClientRender", getRootElement(), function()

	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsTaxista()) do

		local playerX, playerY, playerZ = v[1], v[2], v[3]

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 20 then

				dxDrawBorderedText3 ( v[4], sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 

			end

		end

	end

end)







function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end