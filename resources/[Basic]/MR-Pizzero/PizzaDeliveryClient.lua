payammount = 0
Pizzas = 0

local PizzaslocLS = {
	{1302.603515625, 305.607421875, 19.5546875},
	{1386.4521484375, 293.3046875, 19.54688835144},
	{1317.7021484375, 224.4541015625, 19.56298828125},
	{1264.44921875, 285.1943359375, 19.5546875},
	{1242.4033203125, 211.4267578125, 19.5546875},
	{1229.853515625, 145.3662109375, 20.4609375},
	{1393.8544921875, 400.97265625, 19.824905395508},
	{807.6552734375, 372.3125, 19.352712631226},
	{705.2978515625, 292.0380859375, 20.421875},
	{340.083984375, 33.583984375, 6.4074425697327},
	{178.263671875, -120.234375, 1.5490375757217},
	{279.77734375, -221.4873046875, 1.578125},
	{271.5869140625, -48.751953125, 2.7772088050842},
	{-5.57421875, 67.8896484375, 3.1171875},
	{-242.3388671875, -236.5029296875, 2.4296875},
	{260.5908203125, -302.998046875, 1.9183698892593},
	{687.2119140625, -445.6435546875, 16.3359375},
	{672.0634765625, -646.7041015625, 16.3359375},
	{768.3251953125, -503.482421875, 18.012926101685},
	{854.6826171875, -605.2060546875, 18.421875},
	{2203.908203125, 106.0234375, 28.44164276123},
	{2551.22265625, 57.208984375, 27.675645828247},
	{2245.4208984375, -122.291015625, 28.153547286987},
	{2443.3154296875, 61.728515625, 28.44164276123},
	{2245.43359375, -1.6611328125, 28.153551101685},
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

local colLS = createColRectangle (-800.81671, -2990.10657, 5100, 3330)
local colLV = createColRectangle (-810, 350, 5000, 3000)

lastCity = "LS"

function getPlayerCity(player)
	if (isElementWithinColShape(player, colLS)) then
		result = "LS"
		lastCity = "LS"
	elseif (isElementWithinColShape(player, colLV)) then
		result = "LV"
		lastCity = "LV"
	else
		result = lastCity
	end
	return result
end

local pizzas = {}
function randomh()
	if getPlayerCity(localPlayer) == "LS" then
		return unpack( PizzaslocLS [math.random (#PizzaslocLS)] )
	end
end

function onIntchange()
	if (exports.GTIemployment:getPlayerJob(true) == "Pizzero") then
		local new = getElementInterior(localPlayer)
		if isElement(Pizzabox) then setElementInterior(Pizzabox,new) end
		local newD = getElementDimension(localPlayer)
		if isElement(Pizzabox) then setElementDimension(Pizzabox,newD) end
		for i,v in pairs(pizzas) do
			if isElement(v) then
				setElementInterior(v,new)
				setElementDimension(v,newD) 
			end
		end
	end
end
addEvent("onClientPlayerChangeInterior",true)
addEventHandler("onClientPlayerChangeInterior", root, onIntchange)

addEvent("GTIPizzaDelivery.onPizzaBoyEnter", true)
addEventHandler("GTIPizzaDelivery.onPizzaBoyEnter", root, function()
	if (exports.GTIemployment:getPlayerJob(true) == "Pizzero") then 
		exports.GTIhud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
		if not isElement(Pizzabox) and not isElement(blip) and not isElement(refblip) then
			if ( Pizzas == 0 ) then
				refmarker = createMarker(376.5791015625, -113.9169921875, 1001.4921875-1, "cylinder", 0.8, 255, 25, 0, 170 )
				--refblip = createBlip(-1721.899, 1354.198, 6.179,41)
				setElementInterior(refmarker,5)
				setElementDimension(refmarker,0)
				exports.GTIhud:dm("Estas sin pizzas, Vuelve a la pizzeria a hornear mas", 255, 0, 0)
				reload = false
			else
				mission()
			end
		end
	end
end)

addEvent("GTIPizzaDelivery.marker", true)
addEventHandler("GTIPizzaDelivery.marker", root, function(theVeh)
	local mx,my,mz = getElementPosition(theVeh)
	refillmarker = createMarker(mx, my, mz, "cylinder", 0.8, 255, 25, 0, 170 )
	attachElements(refillmarker,theVeh,0,-1.3,-0.5,1,0,0)
end )

function findRotation(x1,y1,x2,y2)
	local X = math.abs( x2 - x1 )
	local Y = math.abs( y2 - y1 )
	Rotm = math.deg( math.atan2( Y , X ) )
	if ( x2 >= x1 ) and ( y2 > y1 ) then    -- north-east
		Rotm = 90 - Rotm
	elseif ( x2 <= x1 ) and ( y2 > y1 ) then    -- north-west
		Rotm = 270 + Rotm
	elseif ( x2 >= x1 ) and ( y2 <= y1 ) then   -- south-east
		Rotm = 90 + Rotm
	elseif ( x2 < x1 ) and ( y2 <= y1 ) then    -- south-west
		Rotm = 270 - Rotm
	end
	return (630-Rotm)
end

function mission()
	local x, y, z = randomh()
	local zx, zy, zz = getElementPosition(localPlayer)
	local distance = getDistanceBetweenPoints3D(x, y, z, zx, zy, zz)
	marker = createMarker(x, y, z-1, "cylinder", 1, 255, 255, 50, 170)
	blip = createBlipAttachedTo(marker, 41)
	exports.GTIhud:dm("CENTRAL: "..exports.GTIutil:getGenericName().." Ordeno una pizza en "..getZoneName(x, y, z).."!", 255, 255, 0)
	payammount = distance
	print("Distancia: "..math.ceil(distance).." Paga: "..math.ceil(payammount).." Pos:"..x..", "..y..", "..z.." Trabajando: "..getPlayerName(localPlayer).."")
end

function ArrowRender()
	if localPlayer then
		if not isElement(localPlayer) then cancelRender() return end
		lx,ly,lz = getElementPosition(localPlayer)
	end
	if getPedOccupiedVehicle(localPlayer) then
		tx,ty,tz = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local roty,rotz = findRotation(tx,ty,tz,lx,ly,lz)
		setElementPosition(Arrow, tx, ty, tz+1.5)
		setElementRotation(Arrow, 0, roty, rotz)
	end
end

		function cancelRender()
			removeEventHandler("onClientPreRender", getRootElement(), ArrowRender)
			if isElement(Arrow) then destroyElement(Arrow) end
			lx,ly,lz = nil
		end

function Pizzaexit(thePlayer)
	if ( getElementModel ( source ) == 448 ) and ( thePlayer == localPlayer )and (exports.GTIemployment:getPlayerJob(true) == "Pizzero") then
		if ( Pizzas > 0 ) then
			local p1x, p1y, p1z = getElementPosition ( marker )
			local p2x, p2y, p2z = getElementPosition ( localPlayer )
			local dist = getDistanceBetweenPoints3D(p1x,p1y,p1z,p2x,p2y,p2z)
			if ( dist < 40 ) then
				triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,true)
				setElementFrozen(localPlayer,true)
				toggleAllControls(false,true,false)
				setTimer( function()
					setElementFrozen(localPlayer,false)
					toggleAllControls(true)
					toggleControl("crouch", false)
					triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,1,2)
					pizza = true
					setPedWeaponSlot(localPlayer,0)
				end, 950, 1 )
			end
		end
	end
end
addEventHandler ( "onClientVehicleExit", root, Pizzaexit )

function refill(theElement)
	if ( source == refillmarker ) and ( theElement == localPlayer) and reload then
		destroyElement(refillmarker)
		exports.GTIhud:drawProgressBar("PizzaPro", "Cargando Pizzas...", 255, 200, 0, 7500)
		toggleAllControls(false,true,false) 
		pTimer1 = setTimer(refillDone, 7500, 1)
		refTimer1 = setTimer(function()
			local i = table.maxn(pizzas)
			if isElement(pizzas[i]) then
				destroyElement(pizzas[i])
				table.remove(pizzas,i)
			end
		end,1450,5)
	end
end
addEventHandler ( "onClientMarkerHit", root, refill)

function refillDone()
	Pizzas = 5
	setPedAnimation(localPlayer, "VENDING", "VEND_Use", 7, true, false, false, false)
	toggleAllControls(true)
	exports.GTIhud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
	exports.GTIhud:dm("Las pizzas fueron cargadas en tu Pizza Boy", 255, 0, 0)
	for i,v in ipairs(ctrls) do
		toggleControl(v, true)
	end
	triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,false)
	reload = false
end

function getPizzas()
	triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,1)
	local x,y,z = getElementPosition(localPlayer)
	att = 0.39
	for i = 1,5 do 
		local Pizzaboxtemp = createObject(1582, x, y, z)
		setObjectScale(Pizzaboxtemp,0.75)
		local int = getElementInterior(localPlayer)
		local dim = getElementDimension(localPlayer)
		if dim == 0 then
			setElementInterior(Pizzaboxtemp,int)
			setElementDimension(Pizzaboxtemp,dim) 
		end
		attachElements(Pizzaboxtemp,localPlayer,0,0.45,att,1,0,0)
		att = att + 0.06
		setElementCollisionsEnabled(Pizzaboxtemp,false)
		table.insert(pizzas,Pizzaboxtemp)
	end
	exports.GTIhud:dm("Ahora que horneaste las pizzas tienes que cargarlas en la Pizza Boy", 255, 204, 0)
	reload = true
	stopSound(bakingsound)
	triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,true)
	triggerServerEvent("GTIPizzaDelivery.getTheVeh", resourceRoot)
end

function destroyPizzas()
	for i,v in pairs(pizzas) do
		if isElement(v) then destroyElement(v) end
		table.remove(pizzas,i)
	end
end

function startprogress(thePlayer)
	if ( source == refmarker ) and ( thePlayer == localPlayer) and not ( isPedInVehicle ( thePlayer ) ) then
		for i,v in ipairs(ctrls) do
			toggleControl(v, false)
		end
		triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,2)
		setPedWeaponSlot(localPlayer,0)
		destroyElement(refmarker)
		destroyElement(refblip)
		bakingsound = playSFX("genrl", 45, 0, true)
		exports.GTIhud:drawProgressBar("PizzaPro", "Horneando Pizzas...", 255, 200, 0, 10000)
		pTimer = setTimer(getPizzas, 9900, 1)
	end
end
addEventHandler("onClientMarkerHit",getRootElement(),startprogress)

function pay(thePlayer)
	if ( thePlayer == localPlayer ) and ( source == marker ) and not ( isPedInVehicle ( thePlayer ) ) then
		if (pizza == true) then
			toggleAllControls(false,true,false) 
			destroyElement(marker)
			destroyElement(blip)
			playSound("walking.mp3", false)
			setTimer(function()
				playSFX("spc_fa", 17, math.random(5,11), false)
				Pizzas = Pizzas - 1
				pizza = false
				exports.GTIhud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
				toggleAllControls(true,true,false) 
				triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,false)
				triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,3,0)
				triggerServerEvent("GTIPizzaDelivery.getpaid", resourceRoot, payammount)
			end, 7500,1 )
		end
	end 
end
addEventHandler ( "onClientMarkerHit", root, pay)

function delelem(thePlayer)
	if (exports.GTIemployment:getPlayerJob(true) == "Pizzero") then
		payammount = 0
		Pizzas = 0
		pizza = false
		if isElement(marker) then destroyElement(marker) end
		if getPedAnimation(localPlayer) then triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,0,0) end
		destroyPizzas()
		if isElement(refmarker) then destroyElement(refmarker) end
		if isElement(refillmarker) then destroyElement(refillmarker) end
		if isElement(refblip) then destroyElement(refblip) end
		if isElement(Pizzabox) then destroyElement(Pizzabox) end
		if isElement(blip) then destroyElement(blip) end
		exports.GTIhud:drawStat("PizzaID", "", "", 255, 200, 0)
		if isTimer(pTimer1) then killTimer(pTimer1) end
		if isTimer(pTimer) then killTimer(pTimer) end
		if isTimer(refTimer1) then killTimer(refTimer1) end
		toggleAllControls(true)
	end
end
addEvent("onClientRentalVehicleHide", true)
addEventHandler ("onClientRentalVehicleHide", root, delelem)
addEventHandler ("onClientPlayerWasted", localPlayer, delelem)

function onJobQuit(job)
	if ( job == "Pizzero" ) then 
		Pizzas = 0
		payammount = 0
		if isElement(marker) then destroyElement(marker) end
		if isElement(blip) then destroyElement(blip) end
		if isTimer(pTimer) then killTimer(pTimer) end
		destroyPizzas()
		toggleAllControls(true)
		if getPedAnimation(localPlayer) then triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,0,0) end
		if isTimer(pTimer1) then killTimer(pTimer1) end
		if isTimer(refTimer1) then killTimer(refTimer1) end
		if isElement(Pizzabox) then destroyElement(Pizzabox) end
		if isElement(refillmarker) then destroyElement(refillmarker) end
		if isElement(refmarker) then destroyElement(refmarker) end
		if isElement(refblip) then destroyElement(refblip) end
		exports.GTIhud:drawStat("PizzaID", "", "", 255, 200, 0)
	end
end
addEventHandler ("onClientPlayerQuitJob", root, onJobQuit)
addEventHandler ("onClientPlayerGetJob", root, onJobQuit)

addEventHandler("onClientPlayerQuit", localPlayer,
	function ()
		destroyPizzas()
	end
)