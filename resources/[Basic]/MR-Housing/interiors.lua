----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 07 Nov 2014
-- Resource: GTIhousing/housing.slua
-- Version: 1.0
----------------------------------------->>

local house_interiors = {
	-- Safe Houses
	--------------->>
	
		-- $$: Johnson House (2 floors, 3 rooms: br, kt, lv) [LS]
	[1] = {2495.944, -1692.495, 1014.742, 180, 3},
		-- $: Safe House 3 (2 room: br/bt, lv/kt) [Rural]
	[2] = {2333.110, -1077.100, 1049.023, 0, 6},
		-- $$$: Safe House 5 (6 rooms: 3 br, bt, lv, kt) [All]
	[3] = {2196.852, -1204.260, 1049.023, 90, 6},
		-- $$: Safe House 6 (1 room: lv/kt) [Urban]
	[4] = {2308.790, -1212.880, 1049.023, 0, 6},
		-- $$$: Hashbury Safe house (4 rooms: br, bt, lv, kt) [SF]
	[5] = {2269.883, -1210.548, 1047.563, 90, 10},
		-- $$$: Madd Dogg's Mansion (2 floors, 16 rooms: 6 br, bar, theater, gym, pool, game, library, kt, office, dining, studio) [All]
	[6] = {1299.082, -796.762, 1084.008, 0, 5},
		-- $$%: Modern Safe House (2 floors, 4 rooms: 2 br, lv, kt) [All]
	[7] = {2324.354, -1149.102, 1050.710, 0, 12},
		-- $: Safe House (3 rooms: br, kt, bt)
	[34] = {2282.963, -1139.593, 1050.898, 0, 11},
	
	
	-- Burglary Houses
	------------------->>
	
		-- $$: Burglary House 1 (4 rooms: br, bt, kt, lv) [LS]
	[8] = {223.040, 1287.260, 1082.141, 0, 1}, 
		-- $$: Burglary House 2 (3 rooms: lv, kt, br)
	[9] = {226.901, 1239.824, 1082.942, 90, 2},
		-- $$: Burglary House 3 (5 rooms: 2 br, bt, kt, lv)
	[10] = {447.036, 1397.600, 1084.305, 0, 2},
		-- $$: Burglary House 4 (2 floors, 6 rooms: 3 br, bt, kt, lv)
	[11] = {491.227, 1398.246, 1081.016, 0, 2},
		-- $$: Burglary House 5 (2 floors, 6 rooms: 3 br, bt, kt, lv)
	[12] = {235.296, 1187.134, 1080.258, 0, 3},
		-- $$: Burglary House 6 (2 floors, 3 rooms: br, kt, lv)
	[13] = {-260.600, 1456.620, 1084.367, 0, 4},
		-- $$: Burglary House 7 (3 rooms: br, kt, lv)
	[14] = {221.856, 1140.510, 1082.609, 0, 4},
		-- $$: Burglary House 8 (4 rooms: br, bt, kt, lv)
	[15] = {261.183, 1284.296, 1080.258, 0, 4},
		-- $$: Burglary House 9 (5 rooms: 2 br, kt, lv)
	[16] = {22.829, 1403.676, 1084.430, 0, 5},
		-- $$: Burglary House 10 (7 rooms: 4 br, bt, kt, lv)
	[17] = {226.649, 1114.359, 1080.995, 270, 5},
		-- $$: Burglary House 11 (2 floors, 4 br, lv, dining)
	[18] = {140.180, 1366.580, 1083.859, 0, 5},
		-- $$: Burglary House 15 (7 rooms: 4 br, bt, lv, kt)
	[19] = {234.117, 1063.869, 1084.212, 0, 6},
		-- $$: Burglary House 16 (3 rooms: bt, lv, kt)
	[20] = {-68.463, 1352.098, 1080.211, 0, 6},
		-- $$: Burglary House 22 (3 rooms: kt, lv, bt)
	[21] = {-42.580, 1405.610, 1084.430, 0, 8},
		-- $$: Burglary House 12 (6 rooms: 2 br, lv, dr, kt)
	[22] = {82.950, 1322.440, 1083.866, 0, 9},
		-- $$: Burglary House 13 (4 rooms: br, bt, lv, kt)
	[23] = {260.746, 1237.463, 1084.258, 0, 9},
		-- $$: Burglary House 14 (4 rooms; br, bt, lv, kt)
	[24] = {23.873, 1340.280, 1084.375, 0, 10},
		-- $$: Burglary House 17 (2 floors, 4 rooms: br, bt, lv, kt)
	[25] = {-283.550, 1470.980, 1084.375, 90, 15},
		-- $$: Burglary House 18 (4 rooms: br, bt, lv, kt)
	[26] = {327.910, 1477.916, 1084.438, 0, 15},
		-- $$: Burglary House 19 (4 rooms: 2 br, lv, kt)
	[27] = {376.704, 1417.262, 1081.328, 90, 15},
		-- $$: Burglary House 20 (3 rooms: br, lv, kt)
	[28] = {386.824, 1471.668, 1080.195, 90, 15},
		-- $$: Burglary House 21 (5 rooms: 2 br, br, lv, kt)
	[29] = {294.935, 1472.324, 1080.258, 0, 15},
	
	-- Special Houses
	------------------>>
	
		-- $: Ryder's House (3 rooms: lv, kt, bt)
	[30] = {2468.599, -1698.334, 1013.508, 90, 2},
		-- $$: Colonel Fuhrberger's House (3 rooms: br, lv, kt)
	[31] = {2807.620, -1174.100, 1025.570, 0, 8},
	
	-- Hotels/Apartments
	--------------------->>
	
		-- $$$: Safe House 4 (1 room: br [hotel])
	[32] = {2217.540, -1076.290, 1050.484, 90, 1},
		-- $$: Vank Hoff Hotel (hotel, 1 room: br)
	[33] = {2233.747, -1115.108, 1050.883, 0, 5},
}

local INT_OFFSET = 1000	-- Amount to add to House ID for Dimension

local interiors = {}	-- House ID by Interior
local int_col = {}		-- Interior Cols by Dimension
local players_int = {}	-- Players in Interior by House ID

addEvent("onHouseEnter", true)
addEvent("onHouseLeave", true)

-- Create Interior
------------------->>

function createHouseInterior(house_id, int_id)
	if (not house_id or not int_id) then return false end
	local x,y,z,rot,int = unpack(house_interiors[int_id])
	local exitPoint = createColSphere(x, y, z, 1)
	setElementInterior(exitPoint, int)
	setElementDimension(exitPoint, house_id+INT_OFFSET)
	interiors[exitPoint] = house_id
	int_col[house_id+INT_OFFSET] = exitPoint
	return true
end

-- Warp Between Interiors
-------------------------->>

function warpIntoHouseInterior(player, int, dim)
	if (not dim or not int) then return false end
	local x,y,z,rot,int = unpack(house_interiors[int])
	
	setElementPosition(player, x, y, z)
	setElementRotation(player, 0, 0, rot)
	setElementInterior(player, int)
	setElementDimension(player, dim+INT_OFFSET)
	
	-- Add to Interior
	if (not players_int[dim]) then players_int[dim] = {} end
	for i,plr in ipairs(players_int[dim]) do
		if (plr == player) then
			table.remove(players_int[dim], i)
			break
		end
	end
	table.insert(players_int[dim], player)
	
	triggerEvent("onHouseEnter", getHouseFromID(dim), player, int_col[dim+INT_OFFSET])
	triggerClientEvent(player, "onClientHouseEnter", getHouseFromID(dim), player, int_col[dim+INT_OFFSET])
	return true
end

function removeFromHouseInterior(player, house, col)
	if (not isElement(player) or not house) then return false end
	local x,y,z,int,dim = getHousePosition(house)
	setElementPosition(player, x, y, z)
	setElementInterior(player, int)
	setElementDimension(player, dim)
	
	if not players_int[house] then return false end
	
	for i,plr in ipairs(players_int[house]) do
		if (plr == player) then
			table.remove(players_int[house], i)
			break
		end
	end
	
	triggerEvent("onHouseLeave", col, player, getHouseFromID(house))
	triggerEvent("onClientHouseLeave", col, player, getHouseFromID(house))
	return true
end

-- Players in Interior
----------------------->>

function getPlayersInHouseInterior(house)
	if (not house or type(house) ~= "number") then return false end
	return players_int[house] or {}
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i,player in ipairs(getElementsByType("player")) do
		local dim = getElementDimension(player)
		if (dim > INT_OFFSET) then
			local dim = dim - INT_OFFSET
			if (not players_int[dim]) then players_int[dim] = {} end
			table.insert(players_int[dim], player)
		end	
	end
end)

-- Exit House
-------------->>

addEventHandler("onColShapeHit", resourceRoot, function(player, dim)
	if (getElementType(player) ~= "player" or isPedInVehicle(player) or not dim) then return end
	exports.GTIhud:drawNote("HouseMsg", "Presiona 'Z' para salir", player, 30, 160, 115, 5000)
	bindKey(player, "z", "up", exitHouse, source)
end)

addEventHandler("onColShapeLeave", resourceRoot, function(player, dim)
	if (getElementType(player) ~= "player" or isPedInVehicle(player) or not dim) then return end
	exports.GTIhud:drawNote("HouseMsg", "", player)
	unbindKey(player, "z", "up", exitHouse)
end)

addEventHandler("onPlayerWasted", root, function()
	if (not isKeyBound(source, "z", "up", exitHouse)) then return end
	exports.GTIhud:drawNote("HouseMsg", nil, source)
	unbindKey(source, "z", "up", exitHouse)
end)

function exitHouse(player, _, _, col)
	unbindKey(player, "z", "up", showHousingPanel)
	exports.GTIhud:drawNote("HouseMsg", "", player)
	removeFromHouseInterior(player, interiors[col], col)
end