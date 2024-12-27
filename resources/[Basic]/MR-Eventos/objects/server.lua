------------------------------------------->>
-- CST-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: CSTevents
-- Type: Client Side
-- Author: ChicoCST & RedBand
----------------------------------------->>

roadblocks = {}
local port = getServerPort()

function spawnRoadblock(id, x, y, z, rx, ry, rz, dim, int)
	local accName = getAccountName(getPlayerAccount(client)) 
	if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
		if (not id) then return end
		if (id == 1225 and dim == 0) then
			outputChatBox("Explosive barrels can not be placed in main dimension", client, 255, 0, 0)
			return
		end
		if (id == 978) then
			z = z-1
		end
		local accName = getAccountName(getPlayerAccount(client))
		local object = createObject(tonumber(id), x, y, z, rx, ry, rz)
		setElementDoubleSided(object, true)
		setElementFrozen(object, true)
		setElementData(object, "creator", accName, false)
		roadblocks[object] = {object, getAccountName(getPlayerAccount(client))}
		if (tonumber(dim) ~= 0) then
			setElementDimension(object, dim)
		end
		if (tonumber(int) ~= 0) then
			setElementInterior(object, int)
		end
		if (id ~= 1225) then
			triggerClientEvent(client, "nobreak", client, object)
		end
	end
end
addEvent("CSTevents.RB.AddRoadblock", true)
addEventHandler("CSTevents.RB.AddRoadblock", root, spawnRoadblock)

function spawnRBVehicle(id, x, y, z, rx, ry, rz, dim, int, color)
    local adminlevel = getElementData(client, "admin.number")
    if ((adminlevel >= 2) or exports.CSTcem:isPlayerCm(client)) then
        local accName = getAccountName(getPlayerAccount(client))
        createEventVehicle(id, x, y, z, rx, ry, rz, dim, int, accName, color)
    end
end
addEvent("CSTevents.RB.SpawnVeh", true)
addEventHandler("CSTevents.RB.SpawnVeh", root, spawnRBVehicle)

function command_rbc(player)
    local adminlevel = getElementData(client, "admin.number")
    if ((adminlevel >= 2) or exports.CSTcem:isPlayerCm(client)) then
        local count = 0
        for k,v in pairs(roadblocks) do
            if (isElement(v[1])) then
                count = count + 1
            end
        end
        outputChatBox("Total roadblocks: "..count, player)
    end
end
addCommandHandler("rbc", command_rbc)

function destroyRoadblocks()
    for k, v in pairs(roadblocks) do
        if (v[2] == getAccountName(getPlayerAccount(client))) then
            if (isElement(v[1])) then
                destroyElement(v[1])
                v = nil
            end
        end
    end
    exports.CSTtexts:output("Your roadblocks have been deleted", client, 255, 0, 0, 2000)
end
addEvent("CSTevents.RB.DestroyRoadblocks", true)
addEventHandler("CSTevents.RB.DestroyRoadblocks", root, destroyRoadblocks)

function destroyRoadblock(rb)
    local creator, x, y, z, dim, int, id
    for k, v in pairs(roadblocks) do
        if (v[1] == rb) then
            x, y, z = getElementPosition(v[1])
            dim = getElementDimension(v[1])
            int = getElementInterior(v[1])
            id = getElementModel(v[1])
            destroyElement(v[1])
            creator = v[2]
            v[1] = nil
        end
    end
    if (client) then
        exports.CSTtexts:output("Roadblock deleted", client, 255, 0, 0, 2000)  
        if (creator) then
        end
    end
end
addEvent("CSTevents.RB.DestroyRoadblock", true)
addEventHandler("CSTevents.RB.DestroyRoadblock", root, destroyRoadblock)

function destroyALLRoadblocks()
    for k, v in pairs(roadblocks) do
        destroyElement(v[1])
    end
    roadblocks = {}
    exports.CSTtexts:output("All roadblocks have been deleted", client, 255, 0, 0, 2000)
end
addEvent("CSTevents.RB.DestroyALLRoadblocks", true)
addEventHandler("CSTevents.RB.DestroyALLRoadblocks", root, destroyALLRoadblocks)

function roadblockDestroyed()
    if (roadblocks[source]) then roadblocks[source] = nil end
end
addEventHandler("onElementDestroy", root, roadblockDestroyed)

function checkLVL()
	local accName = getAccountName(getPlayerAccount(client)) 
	if (isElement(client) and getElementType(client) == "player") then 
		if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
			triggerClientEvent(client, "showRB", client)
		else
			outputChatBox("[ERROR] No eres Event Manager", client, 255, 0, 0)
		end
	end
end
addEvent("CSTevents.RB.CheckAdminLevel", true)
addEventHandler("CSTevents.RB.CheckAdminLevel", root, checkLVL)

function destroyVehViaRB(vehicle)
    local adminlevel = getElementData(client, "admin.number")
    if ((adminlevel >= 2) or exports.CSTcem:isPlayerCm(client)) then
        if (isElement(vehicle)) then
            destroyElement(vehicle)
        end
    end
end
addEvent("CSTevents.RB.DestroyVeh", true)
addEventHandler("CSTevents.RB.DestroyVeh", root, destroyVehViaRB)