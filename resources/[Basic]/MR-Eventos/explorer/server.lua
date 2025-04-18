function getElements()
	triggerClientEvent(client, "CSTevents.SendElements", client, getElementsTable())
end
addEvent("CSTevents.GetElements", true)
addEventHandler("CSTevents.GetElements", root, getElements)

function getElementsTable()
	local elementsTable = {
		["Vehicles"] = {},
		["Objects"] = {},
		["Pickups"] = {},
	}
	for k, v in ipairs(getElementsByType("vehicle", resourceRoot)) do
		local creator = getElementData(v, "creator")
		if (creator) then
			table.insert(elementsTable["Vehicles"], {v, creator})
		end
	end
	for k, v in ipairs(getElementsByType("object", resourceRoot)) do
		if (roadblocks[v]) then
			local creator = roadblocks[v][2]
			if (creator) then
				table.insert(elementsTable["Objects"], {v, creator})
			end
		end
	end
	for k, v in ipairs(getElementsByType("pickup", resourceRoot)) do
		local creator = getElementData(v, "creator")
		if (creator) then
			table.insert(elementsTable["Pickups"], {v, IDToCName[getElementModel(v)], creator, getElementData(v, "val")})
		end
	end
	return elementsTable
end

function deleteElement(element)
	if (element and isElement(element)) then
		local eType = getElementType(element)
		if (eType == "vehicle") then
			destroyElement(element)
			exports.CSTtexts:output("Vehicle deleted", client, 0, 255, 0)
		elseif (eType == "object") then
			destroyRoadblock(element)
		elseif (eType == "pickup") then
			deletePickup(element)
			exports.CSTtexts:output("Pickup deleted", client, 0, 255, 0)
		end
		triggerClientEvent(client, "CSTevents.SendElements", client, getElementsTable())
	end
end
addEvent("CSTevents.DeleteElement", true)
addEventHandler("CSTevents.DeleteElement", root, deleteElement)

function getElementOwner(element)
	if (not isElement(element)) then return end
	return getElementData(element, "creator")
end