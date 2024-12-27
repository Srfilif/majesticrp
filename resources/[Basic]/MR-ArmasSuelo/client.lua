-----------------------------------------------------------
--  ___     ___ _ _ _  __   ___             __   ____    --
-- / __|_ _| __(_) (_)/ _| |   \ _____ __  / /  / /\ \   --
-- \__ \ '_| _|| | | |  _| | |) / -_) V / < <  / /  > >  --
-- |___/_| |_| |_|_|_|_|   |___/\___|\_/   \_\/_/  /_/   --
-----------------------------------------------------------                                                   
-- SrFilif Dev © 2023 | All rights reserved copyright 2023


local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution
local currentGround = nil
local elementgg = {}
local bannedTeamsEnabled = true
local bannedTeams = { -- Useful if you got an RPG server and want to prevent abuse with weapon-spawning classes, then use above variable to toggle using below table and add your server's team names that wont be able to use drop gun
    ["Official Squads"] = true,
    ["Staff"] = true,
}

weaponmarkercolors = {
	[0] = {36, 36, 36},
	[1] = {36, 36, 36},
	[2] = {36, 36, 36},
	[3] = {36, 36, 36},
	[4] = {36, 36, 36},
	[5] = {36, 36, 36},
	[6] = {36, 36, 36},
	[7] = {36, 36, 36},
	[8] = {36, 36, 36},
	[9] = {36, 36, 36},
	[10] = {36, 36, 36},
	[11] = {36, 36, 36},
	[12] = {36, 36, 36}
}

weaponsIDS = {
	--0
	[1] = 331,
	--1
	[2] = 333,
	[3] = 334,
	[4] = 335,
	[5] = 336,
	[6] = 337,
	[7] = 338,
	[8] = 339,
	[9] = 341,
	--2
	[22] = 346,
	[23] = 347,
	[24] = 348,
	--3
	[25] = 349,
	[26] = 350,
	[27] = 351,
	--4
	[28] = 352,
	[29] = 353,
	[32] = 372,
	--5
	[30] = 355,
	[31] = 356,
	--6
	[33] = 357,
	[34] = 358,
	--7
	[35] = 359,
	[36] = 360,
	[37] = 361,
	[38] = 362,
	--8
	[16] = 342,
	[17] = 343,
	[18] = 344,
	[39] = 363,
	--9
	[41] = 365,
	[42] = 366,
	[43] = 367,
	--10
	[10] = 321,
	[11] = 322,
	[12] = 323,
	[13] = 324,
	[14] = 325,
	[15] = 326,
	--11
	[44] = 368,
	[45] = 369,
	[46] = 371,
	--12
	[40] = 364
}

colshapes = {}

function createGroundWeapon(groundweapon,weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
	if(elementgg[groundweapon] == nil) then
		local temp = createColSphere(posX,posY,posZ +0.5, 1)
		colshapes[temp] = {}
		colshapes[temp].groundweapon = groundweapon
		colshapes[temp].weaponid = weaponid
		colshapes[temp].ammo = ammo
		colshapes[temp].clip = clip
		elementgg[groundweapon] = temp
		local slot = getSlotFromWeapon(weaponid)

		--createObject
		local object = createObject(weaponsIDS[weaponid],posX,posY,posZ,rotX,rotY,rotZ)
		setElementFrozen(object, true)
		setElementCollisionsEnabled(object, false)

		setElementInterior(object,interior)
		setElementDimension(object,dimension)
		
		colshapes[temp].object = object

		--createMarker
		local marker = createMarker(posX,posY,posZ+0.05,"corona", 0.5,weaponmarkercolors[slot][1],weaponmarkercolors[slot][2], weaponmarkercolors[slot][3], 20)
		setElementInterior(marker,interior)
		setElementDimension(marker,dimension)
			
		colshapes[temp].marker = marker

		local x,y,z = getElementPosition(localPlayer)
		if getDistanceBetweenPoints2D(x,y,posX,posY) < 0.25 then local_activate(temp, localPlayer,true) end
	end
end

function destroyGroundWeapon(groundweapon)
    local col = elementgg[groundweapon]
    local object = colshapes[col].object
    local marker = colshapes[col].marker
    colshapes[col] = nil
    if isElement(object) then destroyElement(object) end
    if isElement(marker) then destroyElement(marker) end
    if isElement(col) then destroyElement(col) end
    elementgg[groundweapon] = nil
end





function cojer(cmd,state)
if(isElement(currentGround)) then
		local weaponid = colshapes[currentGround].weaponid
		local ammo = colshapes[currentGround].ammo
		local clip = colshapes[currentGround].clip
		local slot = getPedWeaponSlot(localPlayer)
		local weaponSlot = getSlotFromWeapon ( weaponid )
		local weaponType = getPedWeapon (localPlayer)

 setPedWeaponSlot ( localPlayer, weaponSlot )
setTimer ( pickupWeapon, 60, 1, "Hello, World!" )
end
addCommandHandler("rarma",cojer)
end







function pickupWeapon(cmd,state)
	if (cmd == "pickup" or state=="down") and isTimer(spamTimer) then return end
	spamTimer=setTimer(function() end,500,1)
	if(isElement(currentGround)) then
		local weaponid = colshapes[currentGround].weaponid
		local ammo = colshapes[currentGround].ammo
		local clip = colshapes[currentGround].clip
		local slot = getPedWeaponSlot(localPlayer)
		local weaponSlot = getSlotFromWeapon ( weaponid )
		local weaponType = getPedWeapon (localPlayer)



		
 --setPedWeaponSlot ( localPlayer, slot )
--setTimer (1000 )
	--	outputChatBox(""..weaponid.."")
		--if slot == getSlotFromWeapon(weaponid) and getPedWeapon(localPlayer,slot) ~= weaponid and getPedTotalAmmo(localPlayer,slot) > 0 then dropWeapon() end
		if slot == weaponSlot then
	
	
	 	if weaponType == weaponid then
		local groundweapon = colshapes[currentGround].groundweapon
			triggerServerEvent("GroundPickups:pickupWeapon",localPlayer,groundweapon,weaponid,ammo,clip)
				 outputChatBox("nooooo")
			for i,p in ipairs(getElementsByType("colshape")) do
				if isElementWithinColShape(localPlayer, p) then
					local_activate(p, localPlayer,true)
					
					break
							
				end
end
		else
		
		

		 outputChatBox ('#0055ff[OBJETOS] #ff3b3bNo puedes recoger este objeto ya que tienes una arma en este slot ('..weaponSlot..')',255,255,255,true)
		 end
	
	
	
		else
		 

				 		if ammo then
			local groundweapon = colshapes[currentGround].groundweapon
			triggerServerEvent("GroundPickups:pickupWeapon",localPlayer,groundweapon,weaponid,ammo,clip)
			
			for i,p in ipairs(getElementsByType("colshape")) do
				if isElementWithinColShape(localPlayer, p) then
					local_activate(p, localPlayer,true)
						
					break
				end
			end

		end
		 end
	end


end


function dropWeapon(source,cmd,state)

     source = getLocalPlayer ( )
	 			setPedAnimation(source, "ped", "bom_plant")
	if (cmd == "drop" or state=="down") and isTimer(spamTimer) then return end
	spamTimer=setTimer(function() end,500,1)
	local team = getPlayerTeam(localPlayer)
	if team and bannedTeams[getTeamName(team)] and bannedTeamsEnabled then
		outputChatBox("Você não pode largar armas enquanto estiver em uma gangue / esquadrão",255,0,0)
		return
	end
	local slot = getPedWeaponSlot(localPlayer)
	if slot > 0 then
		local weaponid = getPedWeapon(localPlayer, slot)
		if weaponid ~= 0 then
			local x,y,z = getElementPosition(localPlayer)
			local hit, hitX, hitY, hitZ, as = processLineOfSight(x, y, z, x, y, -3000, true, false, false, true, false, false, false, false)
			z = hit and hitZ or z-0.95
			local player = getlocal
			setPedAnimation(source, "ped", "bom_plant")
			triggerServerEvent("GroundPickups:dropWeapon",localPlayer,weaponid, getPedTotalAmmo(localPlayer), getPedAmmoInClip(localPlayer), x,y,z, 97.3,120,math.random(0,359),getElementInterior(localPlayer),getElementDimension(localPlayer))
		end
	end
end

function local_activate(shape, element,dimension)
	local playersInCol = getElementsWithinColShape(shape,"player")
	if #playersInCol == 1 and playersInCol[1] ~= localPlayer then return end
	if element == localPlayer and #playersInCol <= 1 then
		currentGround = shape
	end
end

addEventHandler("onClientResourceStart", getRootElement(),
	function(startedRes)
		if(startedRes == getThisResource()) then
			addCommandHandler("recogerarma",cojer)
		   addCommandHandler("cogerarma",cojer)
			addCommandHandler("dejararma",dropWeapon)
		    addCommandHandler("tirararma",dropWeapon)
			bindKey("k","down","cogerarma")
			
		else
			for i,p in pairs(getElementsByType("groundweapon")) do
				createGroundWeapon(p)
			end
		end
	end
)


addEventHandler("onClientResourceStop", resourceRoot,
	function(startedRes)
		for i,p in ipairs(getElementsByType("groundweapon")) do
			destroyGroundWeapon(p)
		end
	end
)

addEventHandler("onClientRender", getRootElement(),
	function()
		if isElement(currentGround) and colshapes[currentGround] then
			local weaponid = colshapes[currentGround].weaponid
			local ammo = colshapes[currentGround].ammo

			sx,sy = screenWidth/2, screenHeight/2

			local screenW, screenH = guiGetScreenSize()
			local str = getPedWeaponSlot(localPlayer) == getSlotFromWeapon(weaponid) and "trocar armas" or "Pegar a arma"
			
		dxDrawRectangle(screenW * 0.4057, screenH * 0.8083, screenW * 0.1896, screenH * 0.0056, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(screenW * 0.4062, screenH * 0.8139, screenW * 0.1891, screenH * 0.0833, tocolor(1, 0, 0, 202), false)
        dxDrawText("Alejate para hacer \n desaparecer este cartel", screenW * 0.5198, screenH * 0.8361, screenW * 0.5938, screenH * 0.8676, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawImage(screenW * 0.4797, screenH * 0.8176, screenW * 0.0349, screenH * 0.0593, "img/" .. weaponid .. ".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Toca la \"K\" para\n recoger el arma", screenW * 0.4062, screenH * 0.8361, screenW * 0.4802, screenH * 0.8676, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
        dxDrawText(""..tostring(ammo).." bala(s)", screenW * 0.4797, screenH * 0.8815, screenW * 0.5146, screenH * 0.8954, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
			end

		end

)

addEventHandler("onClientElementDestroy", getRootElement(),
	function()
		if(getElementType(source) == "groundweapon") then
			destroyGroundWeapon(source)
		end
	end
)

addEventHandler("onClientColShapeHit", getResourceRootElement(),
	function(element,dimension)
		local_activate(source, element,dimension)
	end
)

addEventHandler("onClientColShapeLeave", getResourceRootElement(),
	function(element,dimension)
		if(element == localPlayer) then
			currentGround = nil
			for i,p in ipairs(getElementsByType("colshape")) do
				if isElementWithinColShape(localPlayer, p) then
					local_activate(p, localPlayer,true)
					break
				end
			end
		end
	end
)

addEvent("GroundPickups:createGroundWeapon", true)
addEventHandler("GroundPickups:createGroundWeapon",localPlayer,createGroundWeapon)


















