addEventHandler ( "onClientResourceStart", root,
function ( )
	local objects = getElementsByType( 'object' ) 
	for i=1, #objects do
		local v = objects[ i ]
		local model = getElementModel( v )
		--engineSetModelLODDistance ( v, 220 )
		--setFarClipDistance( 4000 )
		setOcclusionsEnabled ( false )
	end
end
)

local FPSLimit, lastTick, framesRendered, FPS = 61, getTickCount(), 0, 0
local sx_, sy_ = guiGetScreenSize()
local sx, sy = sx_/1360, sy_/768

local components = {"money", "area_name", "radio", "vehicle_name", "clock"}



addEventHandler("onClientRender", getRootElement(), function()
	if not isPlayerMapVisible() then
		local currentTick = getTickCount()
		local elapsedTime = currentTick - lastTick
		
		if elapsedTime >= 1000 then
			FPS = framesRendered
			lastTick = currentTick
			framesRendered = 0
		else
			framesRendered = framesRendered + 1
		end
		
		if FPS > FPSLimit then
			FPS = FPSLimit
		end
		localPlayer:setData("FPS", ""..tonumber(FPS).." FPS")
--		dxDrawText("/yo : ["..(localPlayer:getData("yo")[1]).."]", 10*sx, 730*sy, 0*sx, 314*sy, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	--	dxDrawText(""..localPlayer:getPing().." ms - "..(localPlayer:getData("FPS") or 0).."", 10*sx, 750*sy, 0*sx, 314*sy, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
	end
end)


local fps = false
function getCurrentFPS() --Función útil ( https://wiki.multitheftauto.com/wiki/GetCurrentFPS )
    return fps
end

local function updateFPS(msSinceLastFrame)
    fps = (1 / msSinceLastFrame) * 1000
end
addEventHandler("onClientPreRender", root, updateFPS)


addEventHandler ( "onClientResourceStart", root,

function ( )



	local objects = getElementsByType( 'object' ) 



	for i=1, #objects do



		local v = objects[ i ]



		local model = getElementModel( v )



		--engineSetModelLODDistance ( v, 220 )



		--setFarClipDistance( 4000 )



		setOcclusionsEnabled ( false )



	end



end



)



local time = getRealTime ()



local FPSLimit, lastTick, framesRendered, FPS = 150, getTickCount(), 0, 0



local sx_, sy_ = guiGetScreenSize()



local sx, sy = sx_/1360, sy_/768







local hudPlayer = false



local loadingSprint = false





function addhudPlayer()
    print(333)

    if hudPlayer == false then
        hudPlayer = true
		setPlayerHudComponentVisible("radar", true)
		setPlayerHudComponentVisible("all", true)
        showChat(true) -- Mostrar el chat
    end
end

addEvent("addhudPlayer", true)
addEventHandler("addhudPlayer", root, addhudPlayer)

function removeHudPlayer()
    if hudPlayer == true then
        print(222)
        hudPlayer = false
		setPlayerHudComponentVisible("radar", false)
		setPlayerHudComponentVisible("all", false)

        showChat(false) -- Ocultar el chat
    end
end

addEvent("removeHudPlayer", true)
addEventHandler("removeHudPlayer", root, removeHudPlayer)







meses = {



[1]={"Enero"},



[2]={"Febrero"},



[3]={"Marzo"},



[4]={"Abril"},



[5]={"Mayo"},



[6]={"Junio"},



[7]={"Julio"},



[8]={"Agosto"},



[9]={"Septiembre"},



[10]={"Octubre"},



[11]={"Noviembre"},



[12]={"Diciembre"},



}







local components = {"money", "area_name", "radio", "vehicle_name", "clock","armour"}







tamanoletras = (sx/sy)*2.8



local screenW, screenH = guiGetScreenSize()



if screenW <= 1366 and screenH <= 768 then



	tamanoletras = (sx/sy)*2.5



end




addEventHandler("onClientPreRender", root, function(time)



	if hudPlayer == true then



		local stamina = localPlayer:getData("Roleplay:stamina") or 100



		local state = getPedMoveState(localPlayer)



		if stamina >= 100 then



			loadingSprint = false



		end



		if ( state == "sprint" ) then



			if ( stamina >= 0 ) then



				stamina = stamina-(0.002*time)



			end



		else



			if ( stamina <= 100 ) then



				if ( state == "stand" ) then -- si el jugador esta quieto aumenta un poco mas rapido



					stamina = stamina+(0.002*time)



					loadingSprint = true



				else



					stamina = stamina+(0.0013*time)



					loadingSprint = true



				end



			end



		end



		if ( state == "jump" ) then



			if ( stamina >= 0 ) then



				stamina = stamina-(0.008*time)



			end



		end



		if ( stamina <= 5 ) then



			toggleControl( "sprint", false )



			toggleControl( "jump", false )



		end



		if ( stamina >= 50 ) then



			toggleControl( "sprint", true )



			toggleControl( "jump", true )



		end



		localPlayer:setData("Roleplay:stamina", stamina)



	end



end)





addEventHandler("onClientRender", getRootElement(), function()



	if not isPlayerMapVisible() then



		local currentTick = getTickCount()



		local elapsedTime = currentTick - lastTick



		



		if elapsedTime >= 1000 then



			FPS = framesRendered



			lastTick = currentTick



			framesRendered = 0



		else



			framesRendered = framesRendered + 1



		end




		localPlayer:setData("FPS", ""..tonumber(FPS).." FPS")



		dxDrawText("Majestic Roleplay", 395*sx, 741*sy, 1358*sx, 314*sy, tocolor(255, 255, 255, 120), 1.00, "default", "right", "top", false, false, false, false, false)



		if hudPlayer == true then



			time = getRealTime ()



			day = time.monthday



			mes = time.month 	



			ano = time.year + 1900



			hour = time.hour



			mins = time.minute



			if day <= 9 then



				dia = "0"..day..""



			else



				dia = day



			end



			if hour <= 9 then



				hora = "0"..hour..""



			else



				hora = hour



			end



			if mins <= 9 then



				minutos = "0"..mins..""



			else



				minutos = mins



			end



			
			dxDrawText("/yo : ["..tostring(localPlayer:getData("yo")[1]).."]", 10*sx, 730*sy, 0*sx, 314*sy, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)



			dxDrawText(" "..dia.." / ".. meses[(mes+1)][1].." / "..ano.." | "..hora.." : "..minutos.." (GMT) | "..localPlayer:getPing().." ms | "..(localPlayer:getData("FPS") or 0).." | "..localPlayer:getName().." [ ID:"..(localPlayer:getData("ID") or 0).." ] ", 10*sx, 750*sy, 0*sx, 314*sy, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, false, false, false)



		



			for _, component in ipairs( components ) do



				setPlayerHudComponentVisible( component, false )



			end

			local component2 = {"crosshair","weapon","ammo","health","radar"}

			for _, component2 in ipairs( component2 ) do 

				setPlayerHudComponentVisible( component2, true )

			end
			
			local component3 = {"area_name", "vehicle_name"}

			for _, component3 in ipairs( component3 ) do 

				setPlayerHudComponentVisible( component3, false )

			end

			dxSetAspectRatioAdjustmentEnabled( true )



			local money = ("%08d"):format(getPlayerMoney())



			if money <= "0" then



				dxDrawBorderedText("$"..money.."", 1090*sx, 130*sy, 200*sx + 1090*sx, 40*sy + 130*sy, tocolor(150, 0, 0, 255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)



			else



				dxDrawBorderedText("$"..money.."", 1090*sx, 130*sy, 200*sx + 1090*sx, 40*sy + 130*sy, tocolor(13, 108, 1, 255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)



			end
			
			local x, y, z = getElementPosition(localPlayer)



			if getZoneName(x, y, z) == "Unknown" then



				zone = "En Interior"



			else



				zone = getZoneName(x, y, z)



			end



			dxDrawBorderedText2(""..(zone or "En Interior"), 1155*sx, 1*sy, 200*sx + 1155*sx, 40*sy + 1*sy, tocolor(110, 110, 110, 255), tamanoletras, "default-bold", "center", "center")
			



			local state = getPedMoveState(localPlayer)


			if ( state == "sprint" or state == "jump" or loadingSprint == true ) then



				local stamina = localPlayer:getData("Roleplay:stamina") or 100



				if stamina then



					dxDrawRectangle( 1161*sx, 37*sy, 131*sx, 15*sy, tocolor(0, 0, 0, 255), false )



					dxDrawRectangle( 1165*sx, 40*sy, 123*sx, 9*sy, tocolor(25,110,25,255), false )



					dxDrawRectangle( 1165*sx, 40*sy, 122*sx*(stamina/100), 9*sy, tocolor(50,225,50,255), false )


				end



			end

			--Chaleco 

				local armad = localPlayer:getArmor()

				if armad  > 0 then

					dxDrawRectangle( 1161*sx, 97*sy, 131*sx, 15*sy, tocolor(0, 0, 0, 255), false )



					dxDrawRectangle( 1165*sx, 100*sy, 123*sx, 9*sy, tocolor(255, 255, 255, 100), false )



					dxDrawRectangle( 1165*sx, 100*sy, 122*sx*(armad/100), 9*sy, tocolor(255, 255, 255, 255), false )

				end

			--Agua

			--	local water = localPlayer:getData("need.thirsty") or 100

			---	dxDrawRectangle( 1161*sx, 77*sy, 131*sx, 15*sy, tocolor(0, 0, 0, 255), false )


				---dxDrawRectangle( 1165*sx, 80*sy, 123*sx, 9*sy, tocolor(0, 100, 255, 100), false )


			---	dxDrawRectangle( 1165*sx, 80*sy, 122*sx*(water/100), 9*sy, tocolor(0, 100, 255, 255), false )

			--Comida

				--local eat = localPlayer:getData("need.hungry") or 100

			--	dxDrawRectangle( 1161*sx, 57*sy, 131*sx, 15*sy, tocolor(0, 0, 0, 255), false )


			--	dxDrawRectangle( 1165*sx, 60*sy, 123*sx, 9*sy, tocolor(255, 107, 0, 100), false )


			--	dxDrawRectangle( 1165*sx, 60*sy, 122*sx*(eat/100), 9*sy, tocolor(255, 107, 0, 255), false )

			-- Dinero en Banco



			local bankmoney = ("%08d"):format((localPlayer:getData("Roleplay:bank_balance") or 0))



			if bankmoney <= "0" then



				dxDrawBorderedText("$"..bankmoney, 1090*sx, 140*sy, 200*sx + 1090*sx, 40*sy + 170*sy, tocolor(106, 159, 106, 255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)



			else



				dxDrawBorderedText("$"..bankmoney, 1090*sx, 140*sy, 200*sx + 1090*sx, 40*sy + 170*sy, tocolor(103, 156, 97, 255), tamanoletras, "pricedown", "right", "center", false, false, false, false, false)



			end



		end



	end



end)









function dxDrawBorderedText2( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end


function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y - 2, w - 2, h - 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y - 2, w + 2, h - 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y + 2, w - 2, h + 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y + 2, w + 2, h + 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x - 2, y, w - 2, h, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x + 2, y, w + 2, h, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y - 2, w, h - 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text:gsub('#%x%x%x%x%x%x', ''), x, y + 2, w, h + 2, tocolor ( 0, 0, 0, v4 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )
end






addEventHandler("onClientResourceStart", getRootElement(), function()
setAmbientSoundEnabled( "general", false )
setAmbientSoundEnabled( "gunfire", false )
end)


