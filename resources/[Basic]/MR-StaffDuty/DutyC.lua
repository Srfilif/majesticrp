local screenW, screenH = guiGetScreenSize()

function Texto()
        dxDrawText("MODO STAFF:", screenW * 0.7953, screenH * 0.8867, screenW * 0.9102, screenH * 0.9433, tocolor(254, 254, 254, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
        dxDrawText("on", screenW * 0.9102, screenH * 0.8867, screenW * 0.9492, screenH * 0.9467, tocolor(61, 236, 0, 255), 1.00, "pricedown", "left", "top", false, false, false, false, false)
end
function TextoVisible ( )
    addEventHandler("onClientRender", getRootElement(), Texto) -- 
end
addEvent("verTexto",true)
addEventHandler("verTexto", getRootElement(), TextoVisible)

function NoTexto()
  removeEventHandler("onClientRender", getRootElement(), Texto)
end
addEvent("noverTexto",true)
addEventHandler("noverTexto", getRootElement(), NoTexto)	

--THEHACKER5 AUTHOR

---- FLY ----

local flyingState = false
local keys = {}
keys.up = "up"
keys.down = "up"
keys.f = "up"
keys.b = "up"
keys.l = "up"
keys.r = "up"
keys.a = "up"
keys.s = "up"
keys.m = "up"

addEvent("onClientFlyToggle",true)
addEventHandler("onClientFlyToggle",getLocalPlayer(),function()
	flyingState = not flyingState
	
	if flyingState then
		addEventHandler("onClientRender",getRootElement(),flyingRender)
		bindKey("lshift","both",keyH)
		bindKey("rshift","both",keyH)
		bindKey("lctrl","both",keyH)
		bindKey("rctrl","both",keyH)
		
		bindKey("forwards","both",keyH)
		bindKey("backwards","both",keyH)
		bindKey("left","both",keyH)
		bindKey("right","both",keyH)
		
		bindKey("lalt","both",keyH)
		bindKey("space","both",keyH)
		bindKey("ralt","both",keyH)
		bindKey("mouse1","both",keyH)
		--setElementFrozen(getLocalPlayer(),true)
		setElementCollisionsEnabled(getLocalPlayer(),false)
	else
		removeEventHandler("onClientRender",getRootElement(),flyingRender)
		unbindKey("mouse1","both",keyH)
		unbindKey("lshift","both",keyH)
		unbindKey("rshift","both",keyH)
		unbindKey("lctrl","both",keyH)
		unbindKey("rctrl","both",keyH)
		
		unbindKey("forwards","both",keyH)
		unbindKey("backwards","both",keyH)
		unbindKey("left","both",keyH)
		unbindKey("right","both",keyH)
		
		unbindKey("space","both",keyH)
		
		keys.up = "up"
		keys.down = "up"
		keys.f = "up"
		keys.b = "up"
		keys.l = "up"
		keys.r = "up"
		keys.a = "up"
		keys.s = "up"
		--setElementFrozen(getLocalPlayer(),false)
		setElementCollisionsEnabled(getLocalPlayer(),true)
	end
end)

function flyingRender()
	local x,y,z = getElementPosition(getLocalPlayer())
	local speed = 10
	if keys.a=="down" then
		speed = 3
	elseif keys.s=="down" then
		speed = 50
	elseif keys.m=="down" then
		speed = 300
	end
	
	if keys.f=="down" then
		local a = rotFromCam(0)
		setElementRotation(getLocalPlayer(),0,0,a)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed
	elseif keys.b=="down" then
		local a = rotFromCam(180)
		setElementRotation(getLocalPlayer(),0,0,a)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed
	end
	
	if keys.l=="down" then
		local a = rotFromCam(-90)
		setElementRotation(getLocalPlayer(),0,0,a)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed
	elseif keys.r=="down" then
		local a = rotFromCam(90)
		setElementRotation(getLocalPlayer(),0,0,a)
		local ox,oy = dirMove(a)
		x = x + ox * 0.1 * speed
		y = y + oy * 0.1 * speed
	end
	
	if keys.up=="down" then
		z = z + 0.1*speed
	elseif keys.down=="down" then
		z = z - 0.1*speed
	end
	
	setElementPosition(getLocalPlayer(),x,y,z)
end

function keyH(key,state)
	if key=="lshift" or key=="rshift" then
		keys.s = state
	end	
	if key=="lctrl" or key=="rctrl" then
		keys.down = state
	end	
	if key=="forwards" then
		keys.f = state
	end	
	if key=="backwards" then
		keys.b = state
	end	
	if key=="left" then
		keys.l = state
	end	
	if key=="right" then
		keys.r = state
	end	
	if key=="lalt" or key=="ralt" then
		keys.a = state
	end	
	if key=="space" then
		keys.up = state
	end	
	if key=="mouse1" then
		keys.m = state
	end	
end

function rotFromCam(rzOffset)
	local cx,cy,_,fx,fy = getCameraMatrix(getLocalPlayer())
	local deltaY,deltaX = fy-cy,fx-cx
	local rotZ = math.deg(math.atan((deltaY)/(deltaX)))
	if deltaY >= 0 and deltaX <= 0 then
		rotZ = rotZ+180
	elseif deltaY <= 0 and deltaX <= 0 then 
		rotZ = rotZ+180
	end
	return -rotZ+90 + rzOffset
end

function dirMove(a)
	local x = math.sin(math.rad(a))
	local y = math.cos(math.rad(a))
	return x,y
end


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end
