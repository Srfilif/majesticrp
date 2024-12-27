------------------------------------------
-- Author: Llanos FloW					--
-- Editado Por: Llanos Flow             --
-- Name: Panel De Sonido      			--
-- Copyright 2016 ( C )             	--
-- YouTube : www.youtube.com/channel/UCvds3YRxUmlLDznD1aHeO6w             	--

local isSpeaker = false

function print ( player, message, r, g, b )
	outputChatBox ( message, player, r, g, b )
end

speakerBox = { }
addCommandHandler ( "parlante", function ( thePlayer  )
	if ( isElement ( speakerBox [ thePlayer] ) ) then isSpeaker = true end
	triggerClientEvent ( thePlayer, "onPlayerViewSpeakerManagment", thePlayer, isSpeaker )
end )

addEvent ( "onPlayerPlaceSpeakerBox", true )
addEventHandler ( "onPlayerPlaceSpeakerBox", root, function ( url, isCar ) 
	if ( url ) then
		if ( isElement ( speakerBox [ source ] ) ) then
			local x, y, z = getElementPosition ( speakerBox [ source ] ) 
			print ( source, "Parlante Quitado.", 255, 0, 0 )
			destroyElement ( speakerBox [ source ] )
			removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		end
		local x, y, z = getElementPosition ( source )
		local rx, ry, rz = getElementRotation ( source )
		speakerBox [ source ] = createObject ( 2229, x-0.5, y+0.5, z - 1, 0, 0, rx )
		print ( source, "Parlante Creado.", 0, 255, 0 )
		addEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		triggerClientEvent ( root, "onPlayerStartSpeakerBoxSound", root, source, url, isCar )
		if ( isCar ) then
			local car = getPedOccupiedVehicle ( source )
			attachElements ( speakerBox [ source ], car, -0.7, -1.5, -0.5, 0, 90, 0 )
		end
	end
end )

addEvent ( "onPlayerDestroySpeakerBox", true )
addEventHandler ( "onPlayerDestroySpeakerBox", root, function ( )
	if ( isElement ( speakerBox [ source ] ) ) then
		destroyElement ( speakerBox [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
		removeEventHandler ( "onPlayerQuit", source, destroySpeakersOnPlayerQuit )
		print ( source, "Parlante Quitado.", 255, 0, 0 )
	else
		print ( source, "El Parlante Ya A Sido Quitado.", 255, 255, 0 )
	end
end )

addEvent ( "onPlayerChangeSpeakerBoxVolume", true ) 
addEventHandler ( "onPlayerChangeSpeakerBoxVolume", root, function ( to )
	triggerClientEvent ( root, "onPlayerChangeSpeakerBoxVolumeC", root, source, to )
end )

function destroySpeakersOnPlayerQuit ( )
	if ( isElement ( speakerBox [ source ] ) ) then
		destroyElement ( speakerBox [ source ] )
		triggerClientEvent ( root, "onPlayerDestroySpeakerBox", root, source )
	end
end