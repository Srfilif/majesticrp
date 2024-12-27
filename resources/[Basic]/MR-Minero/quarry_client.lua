local vehicles = {--max grams,throw?,atty,attz
	[573] =  {12000,true,-4.4,-1.5},--dune
	[455] = {7000,false,-5,-1.5},
	[406] = {17000,true,-6,-2},--dumper
}
local rocks = {} --Small rocks that are spawned after hitting the bigger rock
local miningRocks = {} --Big rocks
local bigRockID = 897
local collisionFixID = 2935
local centerX,centerY = 576.457, 873.753--center of the mine
local smallRockID = {905,2936,3930}

local miningAreas = { --"Big" mining rock locations
	{2558.19140625, -283.5185546875, 5.3687500953674},
	{2535.3564453125, -238.306640625, 5.3687500953674},
	{2560.6064453125, -271.392578125, 5.3687500953674},
	{2589.9853515625, -216.123046875, 1.933104634285},
	{2638.90625, -219.001953125, -1.03125},
	{2613.318359375, -276.109375, -4.6091227531433},
	{2638.9055175781, -322.22833251953, -6.6312499046326},
	{2612.2971191406, -294.23907470703, -6.6312499046326},
	{2576.490234375, -295.376953125, -11.17400932312},
	{2544.38671875, -296.1826171875, -12.231249809265},
	{2548.08203125, -316.849609375, -12.231249809265},
	{2539.62109375, -264.826171875, -15.689483642578},
	{2538.3881835938, -237.00996398926, -18.03125},
	{2551.1245117188, -218.12812805176, -18.03125},
	{2587.3505859375, -235.6806640625, -20.543743133545},
	{2637.4484863281, -219.69941711426, -23.53125},
	{2615.037109375, -268.5888671875, -26.3877048492},
	{2624.1376953125, -319.3369140625, -29.331249237061},
	{2637.1787109375, -303.4658203125, -29.331249237061},
	{2580.71484375, -313.2314453125, -33.339550018311},
	{2540.8828125, -309.98046875, -34.931251525879},
	{2556.7231445312, -262.8837890625, -38.690292358398}, 
	{2549.0581054688, -228.61660766602, -40.731250762939},
	{2571.4458007812, -233.1435546875, -40.731250762939},
	{2579.6801757812, -233.0537109375, -40.731250762939},
	{2629.3266601562, -223.57479858398, -40.731250762939},
	{2623.9692382812, -234.99472045898, -40.731250762939},
	{2587.4155273438, -270.75079345703, -40.731250762939},
	{2599.0083007812, -264.07891845703, -40.731250762939},
	{2616.7182617188, -254.25079345703, -40.731250762939},
	{2637.7026367188, -276.81231689453, -40.731250762939},
	{2640.5541992188, -238.52890014648, -40.731250762939},

}

local ctrls ={
	"sprint",
	"jump",
	"enter_exit",
	"enter_passenger",
	"fire", 
	"crouch", 
	"aim_weapon",
	"next_weapon",
	"previous_weapon",
}
grams = 0
--Load new mining rocks
function loadMiningAreas()
	--First, remove any mining rocks that are currently in the system
	unloadMiningAreas()
	cleanupElementRocks()

	--Now we proceed to making new mining rocks

	tablei = {}
	for k = 1,12 do
		local i = math.random(#miningAreas)
		if not tablei[i] then
			tablei[i] = true
			local x,y,z,rx,ry,rz = miningAreas[i][1],miningAreas[i][2],miningAreas[i][3],miningAreas[i][4],miningAreas[i][5],miningAreas[i][6]
			createMiningRock(x,y,z,rx,ry,rz)
		end
	end
end
--Delete rocks that are currently spawned
function unloadMiningAreas()
	for k,v in pairs(miningRocks) do
		if isElement(v[1]) then destroyElement(v[1]) end
		if isElement(v[2]) then destroyElement(v[2]) end
		if isElement(v[4]) then destroyElement(v[4]) end
	end
end
--Delete element rocks that are currently spawned
function cleanupElementRocks()
	for k,v in pairs(rocks) do
		if isElement(v[1]) then
			destroyElement(v[1])
			destroyElement(v[2])
		end
	end
end

--Create mining rocks
function createMiningRock(x,y,z,rx,ry,rz)
	if (x) and (y) and (z) then
		local rock = createObject(bigRockID,x,y,z,rx,ry,rz)
		local collisionFixer = createObject(collisionFixID,x,y,z)
		local attx,atty = getCenter(x,y)
		attachElements(collisionFixer,rock,attx,atty,1)
		setElementAlpha(collisionFixer,0)
		setElementCollidableWith(collisionFixer,localPlayer,false)
		local blip = createBlipAttachedTo(rock,0,1.2,55,255,0,255,0,1000)
		miningRocks[rock] = {rock,blip,0,collisionFixer}
		addEventHandler("onClientObjectDamage",rock,mine)
		addEventHandler("onClientObjectDamage",collisionFixer,mine)
	end
end

function getCenter(X,Y)
	if X < centerX then
		XOFF = 3
	else
		XOFF = -3
	end
	if Y < centerY then
		YOFF = 3
	else
		YOFF = -3
	end
	return XOFF,YOFF
end
function getRemainingRocks()
	numb = 0
	for i,v in pairs(miningRocks) do
		numb = numb + 1
	end
	return numb
end

--Small elemental rocks that are spawned when the player hits the mining rocks
function createRocks(x,y,z) --Mining rocks (which some have iron in)
	if (x) and (y) and (z) then
		cleanupElementRocks()
		--X,y,z is the central of the rocks being placed, now to create random amount of rocks
		local total = math.random(5,10)
		exports.GTIhud:dm("Conseguiste de esta roca "..total.." trozos de mineral", 255, 200, 0)
		hasRock = true
		for i = 1,total do
			local _x,_y,_z = getPos(x,y,z)
			if _x then
				local scale,attZ = returnFloat()
				local ind = math.random(1,3)
				local rock = createObject(smallRockID[ind],x,y,z)
				setObjectScale(rock,scale)
				local col = createColSphere(x,y,z,1.5)
				attachElements(col,rock)
				setElementCollisionsEnabled(rock,false)
				addEventHandler("onClientColShapeHit",col,pickUp)
				rocks[col] = {col,rock,scale,attZ}
			end
		end
		setTimer(function() hasRock = false end,500,1)--prevent bugs
		playSound("misc/rockfalls.ogg")
	end
end

function returnFloat()
	local state = math.random(1,7)
	if (state == 1) then
		return 0.4,0.35
	elseif (state == 2) then
		return 0.5,0.3
	elseif (state == 3) then
		return 0.6,0.25
	elseif (state == 4) then
		return 0.7,0.15
	elseif (state == 5) then
		return 0.8,0.07
	elseif (state == 6) then
		return 0.9,0.05
	elseif (state == 7) then
		return 1,0
	end
end

function getPos(x,y,z)
	for i = 1,5 do
		local state = math.random(1,4)
		if (state == 1) then
			_x,_y = x+math.random(1,6.5),y+math.random(1,6.5)
		elseif (state == 2) then
			_x,_y = x-math.random(1,6.5),y+math.random(1,6.5)
		elseif (state == 3) then
			_x,_y = x+math.random(1,6.5),y-math.random(1,6.5)
		elseif (state == 4) then
			_x,_y = x-math.random(1,6.5),y-math.random(1,6.5)
		end
		local rz = getGroundPosition(_x,_y,z)
		if rz and z-0.4 > rz and (z-rz < 1.3) and not isLineOfSightClear(_x,_y,rz,_x,_y,rz-1) and not isLineOfSightClear(_x,_y,rz,_x,_y,rz-3) then
			return _x,_y,rz+0.5
		end
	end
end

function mine(loss,attacker)
	if ( getPedWeapon(localPlayer) and getPedWeapon(localPlayer) ~= 6 ) or not isElement(source) then return end
	local theRoc = getElementAttachedTo(source) or source
	if isElement(miningRocks[theRoc][1]) and attacker == localPlayer then
		miningRocks[theRoc][3] = miningRocks[theRoc][3] + loss
		local tx,ty,tz = getElementPosition(localPlayer)
		if miningRocks[theRoc][3] > 1000 then
			if isTimer(bombtimer) or isTimer(rocktimer) then return end
			if grams > vehicles[theVehid][1] then
				exports.GTIhud:dm("El camion esta lleno de minerales, Tienes que ir a venderlos!", 255, 0, 0) 
				return end
				local numm = math.random(1,7)
				if numm == 3 then
					exports.GTIhud:dm("Esta roca es demasiado dura para poder minarla, Hay que recurrir a los explosivos", 255, 0, 0) 
					triggerServerEvent("GTImining.anim", resourceRoot,5)
					local x, y, z = getElementPosition ( localPlayer )
					bomb = createObject ( 1654, x, y, z-0.9, -90, 0, 0, true )
					bombtimer = setTimer(function(theRoc,tz)
						local mx,my,mz = getElementPosition(miningRocks[theRoc][2])
						createExplosion(mx,my,mz,2,true,0.8,false)
						createRocks(mx,my,tz)
						destroyElement(bomb)
						destroyElement(miningRocks[theRoc][2])
						destroyElement(miningRocks[theRoc][1])
						destroyElement(miningRocks[theRoc][4])
						miningRocks[theRoc] = nil
						local num = getRemainingRocks()
						if (num <= 0) then
							hasMission = false
						end
					end,7000,1,theRoc,z)
					return
				end
				createExplosion(tx,ty,tz-15,8,false,1.3,false)
				local mx,my,mz = getElementPosition(miningRocks[theRoc][2])
				createRocks(mx,my,tz)
				rocktimer = setTimer(function(theRoc)
					destroyElement(miningRocks[theRoc][2])
					destroyElement(miningRocks[theRoc][1])
					destroyElement(miningRocks[theRoc][4])
					miningRocks[theRoc] = nil
					local num = getRemainingRocks()
					if (num <= 0) then
						hasMission = false
					end
				end,100,1,theRoc)
			end
		end
	end

	function pickUp(hitElement,dim)
		if dim and hitElement == localPlayer and rocks[source] and not hasRock and not isPedInVehicle(localPlayer) then
			if not isElement(theVeh) then exports.GTIhud:dm("Aparece un vehiculo nuevo", 255, 0, 0) return end
			local vx,vy,vz = getElementPosition(theVeh)
			local mx,my,mz = getElementPosition(localPlayer)
			if ( getDistanceBetweenPoints3D(vx,vy,vz,mx,my,mz) > 25 ) then exports.GTIhud:dm("Tu vehiculo esta muy lejos", 255, 0, 0) return end 
			hasRock = true
			toggleAllControls(false)
			setPedWeaponSlot(localPlayer,0)
			lastCol = source
			triggerServerEvent("GTImining.anim", resourceRoot,2)
			timer5 = setTimer(function(col)
				toggleAllControls(true)
				for i,v in ipairs(ctrls) do
					toggleControl(v,false)
				end
				exports.bone_attach:attachElementToBone(rocks[col][2],localPlayer,12,0.3,0.53-rocks[col][4],0.2,0,0,0)
				triggerServerEvent("GTImining.anim", resourceRoot,1)
			end,700,1,source)
			createVehMarker()
			triggerServerEvent("GTImining.freeze", resourceRoot, true)
		end
	end

	function createVehMarker()
		if isElement(marker) then return end
		if theVeh then
			local x,y,z = getElementPosition(theVeh)
			marker = createMarker(x,y,z,"cylinder",1,255,255,0)
			local ay = vehicles[theVehid][3]
			local az =  vehicles[theVehid][4]
			attachElements(marker,theVeh,0,ay,az,1,0,0)
			addEventHandler("onClientMarkerHit",marker,throwing) 
		end
	end
	function throwing(thePlayer)
		if (thePlayer == localPlayer) and (isElement(rocks[lastCol][2])) and ( exports.bone_attach:isElementAttachedToBone(rocks[lastCol][2]) == true ) then
			triggerServerEvent("GTImining.anim", resourceRoot,4)
			for i,v in ipairs(ctrls) do
				toggleControl(v,true)
			end
			setElementFrozen(localPlayer,true)
			destroyElement(rocks[lastCol][1])
			destroyElement(source)
			timer2 = setTimer(function()
				exports.bone_attach:detachElementFromBone(rocks[lastCol][2])
				if vehicles[theVehid][2] then
					local origX, origY, origZ = getElementPosition ( rocks[lastCol][2] )
					local newZ = origZ + 3
					moveObject ( rocks[lastCol][2], 500, origX, origY, newZ )
				else
					local vehx,vehy,vehz = getElementPosition(theVeh)
					local origX, origY, origZ = getElementPosition ( rocks[lastCol][2] )
					moveObject ( rocks[lastCol][2], 300, vehx, vehy, origZ+2 )
				end
			end,550,1)
			timer1 = setTimer(function()
				hasRock = false
				if vehicles[theVehid][2] then
					local sound = playSound("misc/throw.mp3", false)
					setSoundVolume(sound, rocks[lastCol][3])
				end
				destroyElement(rocks[lastCol][2])
				local gramN = math.random(100,400)*rocks[lastCol][3]
				grams = grams + math.ceil(gramN)
				setElementData(localPlayer, "miner.grams", grams)
				triggerServerEvent("GTImining.freeze", resourceRoot, false, grams,theVehid)
				exports.GTIhud:drawStat("MinerID", "Minerales", grams.." Gramos", 255, 200, 0)
				rocks[lastCol] = nil
				lastCol = nil
				setElementFrozen(localPlayer,false)
			end,1000,1)
		end
	end
	--Job detector
	function onPlayerJobSwitch()
		local jobName = exports.GTIemployment:getPlayerJob(true)
		if (jobName == "Minero") then
			if not hasMission then return end
			if grams > 0 then
				triggerServerEvent("GTImining.remaininggrams",resourceRoot,false,grams,theVehid)
			end
			unloadMiningAreas()
			cleanupElementRocks()
			if isElement(marker) then destroyElement(marker) end
			if isElement(bomb) then destroyElement(bomb) end
			if isTimer(bombtimer) then killTimer(bombtimer) end
			if isElement(craftMarker1) then destroyElement(craftMarker1) end
			if isElement(craftMarker2) then destroyElement(craftMarker2) end
			if isElement(craftblip) then destroyElement(craftblip) end
			if isTimer(rocktimer) then killTimer(rocktimer) end
			hasRock = false
			hasMission = false
			hideTradingGUI()
			toggleAllControls(true)
			exports.GTIhud:drawStat("MinerID", "", "", 255, 200, 0)
		end
	end
	addEvent("onClientRentalVehicleHide",true)
	addEventHandler ("onClientRentalVehicleHide", root, onPlayerJobSwitch)
	addEventHandler ("onClientPlayerWasted", localPlayer, onPlayerJobSwitch)
	addEventHandler ("onClientResourceStop", resourceRoot, onPlayerJobSwitch)

	function onPlayerJobQuit(jobName)
		if (jobName == "Minero") then
			engineRestoreModel(337)
			if isElement(pickaxetxd) then destroyElement(pickaxetxd) end
			if not hasMission then return end
			unloadMiningAreas()
			cleanupElementRocks()
			if isElement(marker) then destroyElement(marker) end
			if isElement(craftMarker1) then destroyElement(craftMarker1) end
			if isElement(craftMarker2) then destroyElement(craftMarker2) end
			if isElement(craftblip) then destroyElement(craftblip) end
			if isElement(bomb) then destroyElement(bomb) end
			if isTimer(bombtimer) then killTimer(bombtimer) end
			if isTimer(rocktimer) then killTimer(rocktimer) end
			hasMission = false
			hasRock = false
			hideTradingGUI()
			toggleAllControls(true)
			exports.GTIhud:drawStat("MinerID", "", "", 255, 200, 0)
		end
	end
	addEventHandler ("onClientPlayerQuitJob", root, onPlayerJobQuit)
	addEventHandler ("onClientPlayerGetJob", root, onPlayerJobQuit)

	function onTakeJob( job )
		pickaxetxd = engineLoadTXD("misc/pickaxe.txd")
		engineImportTXD(pickaxetxd, 337)
		local pickaxedff = engineLoadDFF("misc/pickaxe.dff",1)
		engineReplaceModel(pickaxedff,337)
	end
	addEventHandler ("onClientResourceStart", root, onTakeJob)

	addEvent("GTImining.setGrams",true)
	addEventHandler("GTImining.setGrams",root,function(gram)
		grams = getElementData(localPlayer, "miner.grams") or 0
		exports.GTIhud:drawStat("MinerID", "Minerales", grams.." Gramos", 255, 200, 0)
	end)


	addEvent("GTImining.triggerMission",true)
	addEventHandler("GTImining.triggerMission",root,function(veh,id)
		if not ( veh == theVeh ) then 
			theVehid = id
			theVeh = veh 
		end
		if hasMission and (getRemainingRocks() > 0) then return end
		hasMission = true
		theVeh = veh
		addEventHandler("onClientVehicleExplode", theVeh, onPlayerJobSwitch)
		loadMiningAreas()
		exports.GTIhud:drawStat("MinerID", "Minerales", grams.." Gramos", 255, 200, 0)
		triggerServerEvent("GTImining.remaininggrams",resourceRoot,true,veh,id)
		if isElement(craftMarker1) then return end
		craftMarker1 = createMarker(159.3994140625, 111.814453125, 3.8842129707336-1, "cylinder",4,255,255,0)
		addEventHandler("onClientMarkerHit",craftMarker1,showGUI) 
		craftblip = createBlipAttachedTo(craftMarker1,41)
	end)

	function getGrams()
		return grams
	end
	function noGram()
		grams = 0
		setElementData(localPlayer, "miner.grams", 0)
		local vehid = getElementModel(getPedOccupiedVehicle(localPlayer))
		triggerServerEvent("GTImining.remaininggrams",resourceRoot,false,0,vehid)
		exports.GTIhud:drawStat("MinerID", "Minerales", grams.." Gramos", 255, 200, 0)
	end 
	function showGUI(theElement)
		if getPedOccupiedVehicle(localPlayer) and (theElement == getVehicleController(getPedOccupiedVehicle(localPlayer))) and (grams > 0) then
			if getPedOccupiedVehicle(localPlayer) ~= theVeh then return end
			triggerServerEvent("GTImining.freeze", resourceRoot, true)
			toggleAllControls(false,true,false)
			showTradingGUI()
			if isElement(craftblip) then destroyElement(craftblip) end
		end
	end