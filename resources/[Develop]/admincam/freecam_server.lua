local p = { }

function setPlayerFreecamEnabled(player, x, y, z, dontChangeFixedMode)
	if not isPlayerFreecamEnabled( player ) then
		p[ player ] = true
		setElementData(player, "collisionless", true)
		return triggerClientEvent(player,"doSetFreecamEnabled", getRootElement(), x, y, z, dontChangeFixedMode)
	end
	return false
end


function setPlayerFreecamDisabled(player, dontChangeFixedMode)
	if isPlayerFreecamEnabled( player ) then
		p[ player ] = nil
		removeElementData(player, "collisionless")
		return triggerClientEvent(player,"doSetFreecamDisabled", getRootElement(), dontChangeFixedMode)
	end
	return false
end


function setPlayerFreecamOption(player, theOption, value)
	return triggerClientEvent(player,"doSetFreecamOption", getRootElement(), theOption, value)
end


function isPlayerFreecamEnabled(player)
	return p[ player ]
end

addEventHandler( "onPlayerQuit", root,
	function( )
		p[ source ] = nil
	end
)

addEventHandler( "onResourceStop", resourceRoot,
	function( )
		for player in pairs( p ) do
			removeElementData(player, "collisionless")
		end
	end
)
