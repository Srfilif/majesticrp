function spawnRBVehicle(id, x, y, z, rx, ry, rz, dim, int, color)
        local accName = getAccountName(getPlayerAccount(client))
        createEventVehicle(id, x, y, z, rx, ry, rz, dim, int, accName, color, client)
    end
addEvent("CSTevents.spawnCar", true)
addEventHandler("CSTevents.spawnCar", root, spawnRBVehicle)

function speakercommand(thePlayer)
    triggerClientEvent ( thePlayer, "openGUI", thePlayer )
end 
addCommandHandler ("placeveh", speakercommand)