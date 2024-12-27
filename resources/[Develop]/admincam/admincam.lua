function toggleAdminCam ( player, commandName )
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName,aclGetGroup("Admin")) or isObjectInACLGroup ("user."..accName,aclGetGroup("Moderador")) or isObjectInACLGroup("user."..accName,aclGetGroup("SuperMod")) then 
		if not isPedInVehicle( player ) then
			if isPlayerFreecamEnabled( player ) then
				setPlayerFreecamDisabled( player )
			elseif isElementAttached( player ) then
				outputChatBox( "You can't use this function.", player, 255, 0, 0 )
			else
				setPlayerFreecamEnabled( player )
			end
		else
			outputChatBox( "You can't use this in a vehicle.", player, 255, 0, 0 )
		end
	end
end
addCommandHandler("admincam",toggleAdminCam)

function stopAdminCam ( )
	if isPlayerFreecamEnabled( source ) then
		setPlayerFreecamDisabled( source )
	end
end
addEventHandler( "onPlayerLogout", root, stopAdminCam)
addEventHandler( "onResourceStop", resourceRoot, stopAdminCam)

