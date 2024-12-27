------------------------------------------
-- Author: Llanos FloW					--
-- Editado Por: Llanos Flow             --
-- Name: Panel De Sonido      			--
-- Copyright 2016 ( C )             	--
-- YouTube : www.youtube.com/channel/UCvds3YRxUmlLDznD1aHeO6w             	--
------------------------------
-- Variables				--
------------------------------
local subTrackOnSoundDown = 0.1	-- The volume that goes down, when the player clicks "Volume -"
local subTrackOnSoundUp = 0.1	-- The volume that goes up, when the player clicks "Volume +"


function print ( message, r, g, b )
	outputChatBox ( message, r, g, b,true )
end

------------------------------
-- The GUI					--
------------------------------
local rx, ry = guiGetScreenSize ( )
button = { }
window = guiCreateWindow( ( rx - 295 ), ( ry / 2 - 253 / 2 ), 293, 253, "Parlante - Majestic Roleplay", false)
guiWindowSetSizable(window, false)
guiSetVisible ( window, false )
CurrentSpeaker = guiCreateLabel(8, 33, 254, 17, "Parlante creado: No", false, window)
volume = guiCreateLabel(10, 50, 252, 17, "Volumen: 100%", false, window)
pos = guiCreateLabel(10, 66, 252, 15, "Usar Link De Youtube", false, window)
guiCreateLabel(11, 81, 251, 15, "URL:", false, window)
--url = guiCreateEdit(11, 96, 272, 23, "", false, window)  
url = guiCreateEdit(11, 96, 272, 23, "", false, window)  
button["place"] = guiCreateButton(9, 129, 274, 20, "Crear Parlante", false, window)
button["remove"] = guiCreateButton(9, 159, 274, 20, "Quitar Parlante", false, window)
button["v-"] = guiCreateButton(9, 189, 128, 20, "Volumen -", false, window)
button["v+"] = guiCreateButton(155, 189, 128, 20, "Volumen +", false, window)
button["close"] = guiCreateButton(9, 219, 274, 20, "Salir", false, window)  

--------------------------
-- My sweet codes		--
--------------------------
local isSound = false
addEvent ( "onPlayerViewSpeakerManagment", true )
addEventHandler ( "onPlayerViewSpeakerManagment", root, function ( current )
	local toState = not guiGetVisible ( window ) 
	guiSetVisible ( window, toState )
	showCursor ( toState ) 
	if ( toState == true ) then
		guiSetInputMode ( "no_binds_when_editing" )
		local x, y, z = getElementPosition ( localPlayer )
		if ( current ) then guiSetText ( CurrentSpeaker, "Parlante creado: Si" ) isSound = true
		else guiSetText ( CurrentSpeaker, "Parlante creado: No" ) end
	end
end )

addEventHandler ( "onClientGUIClick", root, function ( )
	if ( source == button["close"] ) then
		guiSetVisible ( window, false ) 
		showCursor ( false )
	elseif ( source == button["place"] ) then
		if ( isURL ( ) ) then
			triggerServerEvent ( "onPlayerPlaceSpeakerBox", localPlayer, guiGetText ( url ), isPedInVehicle ( localPlayer ) )
			guiSetText ( CurrentSpeaker, "Parlante creado: Si" )
			isSound = true
			guiSetText ( volume, "Volumen: 100%" )
		else
			print ( "#57f7b7[PARLANTE] #ffFFffIngresa una URL", 255, 0, 0 ,true)
		end
	elseif ( source == button["remove"] ) then
		triggerServerEvent ( "onPlayerDestroySpeakerBox", localPlayer )
		guiSetText ( CurrentSpeaker, "Parlante creado: No" )
		isSound = false
		guiSetText ( volume, "Volumen: 100%" )
	elseif ( source == button["v-"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) - subTrackOnSoundDown, 2 )
			if ( toVol > 0.0 ) then
				print ( "#57f7b7[PARLANTE] #ffFFffVolumen Seteado a "..math.floor ( toVol * 100 ).."%!", 0, 255, 0,true )
				triggerServerEvent ( "onPlayerChangeSpeakerBoxVolume", localPlayer, toVol )
				guiSetText ( volume, "Volumen: "..math.floor ( toVol * 100 ).."%" )
			else
				print ( "#57f7b7[PARLANTE] #ffFFffEste es el volumen minimo", 255, 0, 0,true )
			end
		end
	elseif ( source == button["v+"] ) then
		if ( isSound ) then
			local toVol = math.round ( getSoundVolume ( speakerSound [ localPlayer ] ) + subTrackOnSoundUp, 2 )
			if ( toVol < 1.1 ) then
				print ( "#57f7b7[PARLANTE] #ffFFffVolumen Seteado a "..math.floor ( toVol * 100 ).."%!", 0, 255, 0,true )
				triggerServerEvent ( "onPlayerChangeSpeakerBoxVolume", localPlayer, toVol )
				guiSetText ( volume, "Volumen: "..math.floor ( toVol * 100 ).."%" )
			else
				print ( "#57f7b7[PARLANTE] #ffFFffEste es el volumen maximo", 255, 0, 0,true )
			end
		end
	end
end )

speakerSound = { }
addEvent ( "onPlayerStartSpeakerBoxSound", true )
addEventHandler ( "onPlayerStartSpeakerBoxSound", root, function ( who, url, isCar )
	if ( isElement ( speakerSound [ who ] ) ) then destroyElement ( speakerSound [ who ] ) end
	local x, y, z = getElementPosition ( who )
	speakerSound [ who ] = playSound3D ( url, x, y, z, true )
	
	setSoundVolume ( speakerSound [ who ], 1 )
	setSoundMinDistance ( speakerSound [ who ], 15 )
	setSoundMaxDistance ( speakerSound [ who ], 20 )
	if ( isCar ) then
		local car = getPedOccupiedVehicle ( who )
		attachElements ( speakerSound [ who ], car, 0, 5, 1 )
	end
end )

addEvent ( "onPlayerDestroySpeakerBox", true )
addEventHandler ( "onPlayerDestroySpeakerBox", root, function ( who ) 
	if ( isElement ( speakerSound [ who ] ) ) then 
		destroyElement ( speakerSound [ who ] ) 
	end
end )

--------------------------
-- Volume				--
--------------------------
addEvent ( "onPlayerChangeSpeakerBoxVolumeC", true )
addEventHandler ( "onPlayerChangeSpeakerBoxVolumeC", root, function ( who, vol ) 
	if ( isElement ( speakerSound [ who ] ) ) then
		setSoundVolume ( speakerSound [ who ], tonumber ( vol ) )
	end
end )

function isURL ( )
	if ( guiGetText ( url ) ~= "" ) then
		return true
	else
		return false
	end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end
