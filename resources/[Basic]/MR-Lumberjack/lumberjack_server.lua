local treesToCut = { 
	{38.562614, 790, 0, -759.001953125, -196.521484375, 67.26953125},
	{63.015308, 791, 785, -1984.9375, -2507.8516, 29.96094},
	{63.015308, 791, 785, -1934.3437, -2401.9297, 26.5},
	{38.562614, 790, 0, -2035.7266, -2432.6562, 34.75781},
	{31.324816, 698, 0, -2057.4375, -2417.0859, 34.8125},
	{38.562614, 790, 0, -2069.9297, -2401.0469, 34.75781},
	{31.324816, 698, 0, -2041.8281, -2448.4062, 34.8125},
	{38.562614, 790, 0, -2028.1875, -2480.0234, 34.75781},
	{38.562614, 790, 0, -2051.2812, -2316.875, 34.75781},
	{31.324816, 698, 0, -2051.9687, -2293.1172, 34.8125},
	{38.562614, 790, 0, -1979.7187, -2371.9062, 34.75781},
	--{radius, modelid, lodid, x, y, z},
}
local transportLocations = {
	{197.7158203125, 117.158203125, 3.8842129707336-1},
	--{-1708.959, -2749.267, 45.074},
}
local treesToPut ={
	{615,-759.001953125, -196.521484375, 67.26953125-1,0.0000000,0.0000000,0.0000000},
	{615,-761.3310546875, -204.9912109375, 65.968818664551-1,0.0000000,0.0000000,0.0000000},
	{615,-773.595703125, -200.9853515625, 66.898162841797-1,0.0000000,0.0000000,0.0000000},
	{615,-782.658203125, -209.8173828125, 65.078346252441-1,0.0000000,0.0000000,0.0000000},
	{615,-795.65625, -199.6513671875, 66.655578613281-1,0.0000000,0.0000000,0.0000000},
	{615,-801.580078125, -212.8095703125, 64.534683227539-1,0.0000000,0.0000000,0.0000000},
	{615,-801.8896484375, -204.396484375, 65.754196166992-1,0.0000000,0.0000000,0.0000000},
	{615,-811.794921875, -211.19140625, 64.652526855469-1,0.0000000,0.0000000,0.0000000},
	{615,-821.7939453125, -196.466796875, 66.735824584961-1,0.0000000,0.0000000,0.0000000},
	{615,-829.6826171875, -188.9091796875, 66.598251342773-1,0.0000000,0.0000000,0.0000000},
	{615,-833.0703125, -198.5341796875, 66.36930847168-1,0.0000000,0.0000000,0.0000000},
	{615,-828.6787109375, -207.3056640625, 65.135131835938-1,0.0000000,0.0000000,0.0000000},
	{615,-821.7919921875, -213.5869140625, 64.272064208984-1,0.0000000,0.0000000,0.0000000},
	{615,-816.892578125, -204.0517578125, 65.70735168457-1,0.0000000,0.0000000,0.0000000},
	{615,-792.4921875, -209.755859375, 65.254898071289-1,0.0000000,0.0000000,0.0000000},
	{615,-771.5625, -215.4443359375, 64.176216125488-1,0.0000000,0.0000000,0.0000000},
	{615,-786.09375, -197.638671875, 67.268455505371-1,0.0000000,0.0000000,0.0000000},
	{615,-836.1083984375, -212.5791015625, 64.199157714844-1,0.0000000,0.0000000,0.0000000},
	{615,-840.0791015625, -203.3046875, 65.558403015137-1,0.0000000,0.0000000,0.0000000},
	{615,-842.4365234375, -195.970703125, 66.440803527832-1,0.0000000,0.0000000,0.0000000},
	{615,-839.796875, -186.50390625, 66.468307495117-1,0.0000000,0.0000000,0.0000000},
	{615,-854.533203125, -178.1591796875, 66.264602661133-1,0.0000000,0.0000000,0.0000000},
	{615,-848.3486328125, -164.712890625, 65.834091186523-1,0.0000000,0.0000000,0.0000000},
	{615,-841.8115234375, -170.974609375, 66.425079345703-1,0.0000000,0.0000000,0.0000000},
	{615,-845.53125, -178.833984375, 66.380996704102-1,0.0000000,0.0000000,0.0000000},
	{615,-850.9072265625, -191.4404296875, 66.318473815918-1,0.0000000,0.0000000,0.0000000},
	{615,-760, -214.439453125, 64.587036132812-1,0.0000000,0.0000000,0.0000000},
	{615,-744.7373046875, -193.7978515625, 67.581436157227-1,0.0000000,0.0000000,0.0000000},
	{615,-743.673828125, -206.7763671875, 67.120544433594-1,0.0000000,0.0000000,0.0000000},
	{615,-742.658203125, -189.7509765625, 67.693908691406-1,0.0000000,0.0000000,0.0000000},
	{615,-737.029296875, -203.9130859375, 66.789237976074-1,0.0000000,0.0000000,0.0000000},
}

local restoreTrees = {}
local groundPosition

function onRequestCutTree(x , y, z, id, lodid, hitElement)
	if hitElement ~= nil then
		local elementModel = getElementModel(hitElement)
		local x, y, z = getElementPosition(hitElement)
		setTimer(function()
			createObject(elementModel, x, y, z)
		end, 180000, 1)
		destroyElement(hitElement)
		for i=1, #treesToPut do
			if math.ceil(treesToPut[i][2]) == math.ceil(x) and math.ceil(treesToPut[i][3]) == math.ceil(y) then
				local fakeCutTree = createObject(848, x, y, treesToPut[i][4])
				setElementDoubleSided ( fakeCutTree, true )
				setTimer(function()
					destroyElement(fakeCutTree)
				end, 180000, 1)
			end
		end
	else
		removeWorldModel ( id, 3, x , y, z)
		removeWorldModel ( lodid, 3, x , y, z) 
		table.insert(restoreTrees, {x, y, z, id, lodid})
		setTimer(function()
			for i=1, #restoreTrees do
				if restoreTrees[i][1] == x and restoreTrees[i][2] == y and restoreTrees[i][3] == y and restoreTrees[i][5] == lodid then
					restoreTrees[i] = nil
				end
			end
			restoreWorldModel ( id, 3, x, y, z)
			restoreWorldModel ( lodid, 3, x, y, z)
		end, 180000, 1)
		local fakeCutTree
		triggerClientEvent("GTIlumberjack.getGroundPosition", getResourceRootElement(getThisResource()), x, y, z)
		setTimer(function()
			fakeCutTree = createObject(848, x, y, groundPosition+1.2)
			setElementDoubleSided ( fakeCutTree, true )
		end, 1000, 1)
		setTimer(function()
			destroyElement(fakeCutTree)
		end, 180000, 1)
	end
	if not getElementData(source,"GTIlumberjack.cuttenTrees") == false then
		setElementData(source, "GTIlumberjack.cuttenTrees", getElementData(source, "GTIlumberjack.cuttenTrees")+1)
	else
		setElementData(source, "GTIlumberjack.cuttenTrees", 1)
	end
end
addEvent( "GTIlumberjack.onRequestCutTree", true )
addEventHandler( "GTIlumberjack.onRequestCutTree", root, onRequestCutTree )

function recieveGroundPosition(newZ)
	groundPosition = newZ
end
addEvent("GTIlumberjack.recieveGroundPosition", true )
addEventHandler("GTIlumberjack.recieveGroundPosition", root, recieveGroundPosition)

local allNewTrees = {}
function onResourceStopRestoreTrees(res)
	if res == getThisResource() then
		for i=1, #restoreTrees do
			restoreWorldModel(restoreTrees[i][4], 3, restoreTrees[i][1], restoreTrees[i][2], restoreTrees[i][3])
			restoreWorldModel(restoreTrees[i][5], 3, restoreTrees[i][1], restoreTrees[i][2], restoreTrees[i][3])
		end
		--
		for i=1, #treesToCut do
			restoreWorldModel(treesToCut[i][2], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
			restoreWorldModel(treesToCut[i][3], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
		end
	end
end
addEventHandler("onResourceStop", root, onResourceStopRestoreTrees)

function onResourceStartCutTrees(res) -- Cut the unnecessary trees near Sawmill, Angel Pine
	if res == getThisResource() then
		for i=1, #treesToCut do
			removeWorldModel(treesToCut[i][2], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
			removeWorldModel(treesToCut[i][3], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
		end
		--
		for i=1, #treesToPut do
			local newTree = createObject(treesToPut[i][1], treesToPut[i][2], treesToPut[i][3], treesToPut[i][4])
		end
	end
end
addEventHandler("onResourceStart", root, onResourceStartCutTrees)

local woodAttached = {}
local rewardMarker = {}
local rewardBlip = {}
function onPlayerEnterDFT(vehicle, seat)
	if seat == 0 then
		if exports.GTIemployment:getPlayerJob(source, true) and exports.GTIemployment:getPlayerJob(source) == "Leñador" then 
			if getElementModel(vehicle) == 578 and getElementData(source, "GTIlumberjack.cuttenTrees") and getElementData(source, "GTIlumberjack.cuttenTrees") > 0 then
				woodAttached[source] = createObject ( 18609, 0, 0, 0 )
				attachElements ( woodAttached[source], vehicle, 0, -5, 0.98)
				rewardMarker[source] = {}
				rewardBlip[source] = {}
				for i=1, #transportLocations do
					rewardMarker[source][i] = createMarker(transportLocations[i][1], transportLocations[i][2], transportLocations[i][3], "cylinder", 4, 255, 255, 0, 255, source)
					rewardBlip[source][i] = createBlip(transportLocations[i][1], transportLocations[i][2], transportLocations[i][3], 19, 2, 255, 0, 0, 255, 0, 99999.0, source)
					setElementData(rewardMarker[source][i], "GTIlumberjack.accName", getAccountName(getPlayerAccount(source)))
					addEventHandler("onMarkerHit", rewardMarker[source][i], onMarkerHitGiveReward)
				end
				exports.GTIhud:dm("Transporta la madera hasta el punto de entrega", source, 255, 255, 0)
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", root, onPlayerEnterDFT)

function onMarkerHitGiveReward(hitElement, matchingDimension)
	if matchingDimension and getElementType(hitElement) == "vehicle" then
		if getElementModel(hitElement) == 578 then
			local player = getVehicleOccupant(hitElement)
			if getElementData(source, "GTIlumberjack.accName") == getAccountName(getPlayerAccount(player)) then
				if exports.GTIemployment:getPlayerJob(player, true) and exports.GTIemployment:getPlayerJob(player) == "Leñador" then
					exports.GTIhud:drawProgressBar("GTIlumberjack.waitTimeToReward", " ", player, 255, 255, 0, 5000)
					setElementFrozen(hitElement, true)
					setTimer(function() 
						if isElement(woodAttached[player]) then
							destroyElement(woodAttached[player])
							for i=1, #transportLocations do
								destroyElement(rewardMarker[player][i])
								destroyElement(rewardBlip[player][i])
							end
						end
						woodAttached[player] = nil
						rewardMarker[player] = nil
						rewardBlip[player] = nil
						setElementFrozen(hitElement, false)
						
						local payOffset = exports.GTIemployment:getPlayerJobPayment(player, "Leñador")
						local hrPay = exports.GTIemployment:getPlayerHourlyPay(player)
						local hrExp = exports.GTIemployment:getHourlyExperience()
						
						local progress = getElementData(player, "GTIlumberjack.cuttenTrees")
						local pay = math.ceil(progress*payOffset)
						local Exp = math.ceil((pay/hrPay)*hrExp)
						local pagaTotal = pay / 2
						
						exports.GTIemployment:givePlayerJobMoney(player, "Leñador", pagaTotal)
						exports.GTIemployment:modifyPlayerJobProgress(player, "Leñador", progress)
						exports.GTIemployment:modifyPlayerEmploymentExp(player, Exp,  "Leñador")
						
						setElementData(player, "GTIlumberjack.cuttenTrees", 0)
					end, 5000, 1)
				end
			end
		end
	end
end

function destroyAttachedWood()
	if getElementType(source) == "vehicle" then
		if getElementModel(source) == 578 then
			local player = getVehicleOccupant (source)
			local allAttachedElements = getAttachedElements ( source )
			for k, object in ipairs(allAttachedElements) do
				if getElementModel(object) == 18609 then
					--destroyElement(object)
					cancelTransportMission(player)
				end
			end
		end
	end
end
addEventHandler("onElementDestroy", root, destroyAttachedWood)

function cancelTransportMission(player)
	--if getElementModel(vehicle) == 578 and seat == 0 then
		--if exports.GTIemployment:getPlayerJob(source, true) and exports.GTIemployment:getPlayerJob(source) == "Leñador" then
			if rewardMarker[player] or rewardBlip[player] then -- or woodAttached[player]
				destroyElement(woodAttached[player])
				for i=1, #transportLocations do
					destroyElement(rewardMarker[player][i])
					destroyElement(rewardBlip[player][i])
				end
				woodAttached[player] = nil
				rewardMarker[player] = nil
				rewardBlip[player] = nil
			end
			--end
			--end
		end

		addEventHandler("onPlayerVehicleExit", root, function(vehicle, seat)
			if getElementModel(vehicle) == 578 and seat == 0 then
				if exports.GTIemployment:getPlayerJob(source, true) and exports.GTIemployment:getPlayerJob(source) == "Leñador" then
					cancelTransportMission(source)
				end
			end
		end
		)