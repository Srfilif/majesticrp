local gui_base = nil
local meterRunning = false
local lightOn = false
local isDriver = false
local taxiFare = 0
local taxiDistance = 0
local root = getRootElement()
local localPlayer = getLocalPlayer()
local driversSendSyncTimer = nil
local fontja = guiCreateFont( "files/counter.ttf", 40 )
            

function showTaximeterGui()
	if gui_base then
		destroyElement(gui_base)
		gui_base = nil
	end
	
	local screenX, screenY = guiGetScreenSize()
	local width, height = 447, 177
	local x, y
	local speedowidth = 280
 	x = screenX-speedowidth-526
	y = screenY-height-60
	
	if isDriver then
		gui_base = guiCreateStaticImage(x,y,width,height,"files/taximeter.png",false,nil)
	else
		gui_base = guiCreateStaticImage(x,y,width,height,"files/taximeter.png",false,nil)
	end
	
	local ertekem = tostring(math.ceil(taxiFare*(taxiDistance/700)))*4
	if ertekem > -1 and 10 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"0000000".. ertekem .."",false,gui_base)
	elseif ertekem > 9 and 100 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"000000".. ertekem .."",false,gui_base)
	elseif ertekem > 99 and 1000 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"00000".. ertekem .."",false,gui_base)
	elseif ertekem > 999 and 10000 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"0000".. ertekem .."",false,gui_base)
	elseif ertekem > 9999 and 100000 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"000".. ertekem .."",false,gui_base)
	elseif ertekem > 99999 and 1000000 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"00".. ertekem .."",false,gui_base)
	elseif ertekem > 999999 and 10000000 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"0".. ertekem .."",false,gui_base)
	elseif ertekem > 9999999 and 100000000 > ertekem then
	gui_label_totalFare = guiCreateLabel(320, 100, 119, 55,"".. ertekem .."",false,gui_base)
	end
	
		guiLabelSetHorizontalAlign(gui_label_totalFare, "right", false)
		guiLabelSetVerticalAlign(gui_label_totalFare, "center")
		guiSetFont(gui_label_totalFare, fontja)
		
	if isDriver then
		gui_btn1 = guiCreateStaticImage(320, 146, 50, 25,"files/stopped.png",false,gui_base) ---- iniciar corrida
		
		    addEventHandler("onClientGUIClick", gui_btn1, taxibuttonhang, false)
		
            addEventHandler("onClientGUIClick", gui_btn1, toggleMeter)
			if meterRunning then
				guiStaticImageLoadImage(gui_btn1, "files/started.png")
			end
		
		gui_btn2 = guiCreateStaticImage(385, 146, 50, 25,"files/stopped.png",false,gui_base) ----- zerar taximetro
			addEventHandler("onClientGUIClick", gui_btn2, resetMeter)
			addEventHandler("onClientGUIClick", gui_btn2, taxibuttonhang, false)
		--gui_btn3 = guiCreateStaticImage(132, 134, 23, 18,"files/stopped.png",false,gui_base)
			addEventHandler("onClientGUIClick", gui_btn3, taxibuttonhang, false)
		---gui_btn4 = guiCreateStaticImage(180, 134, 23, 18,"files/stopped.png",false,gui_base)
		    addEventHandler("onClientGUIClick", gui_btn4, taxibuttonhang, false)
			
			addEventHandler("onClientGUIClick", gui_btn4, toggleLight)
			if lightOn then
				guiStaticImageLoadImage(gui_btn4, "files/started.png")
			end		
	else
		if meterRunning then
		--	gui_label_pax_running = guiCreateLabel(244, 115, 119, 29,"Taksometr włączony",false,gui_base)
			guiLabelSetColor(gui_label_pax_running,0,255,0)
		else
		--	gui_label_pax_running = guiCreateLabel(244, 115, 119, 29,"Taksometr wyłączony",false,gui_base)
			guiLabelSetColor(gui_label_pax_running,255,0,0)
		end
	end
	
end

function hideTaximeterGui()
	if gui_base then
		destroyElement(gui_base)
		gui_base = nil
	end
	taxiFare = 0
	taxiDistance = 0
	meterRunning = false
	lightOn = false
	isDriver = false
end

function toggleMeter()
	if(source == gui_btn1) then
		if isDriver then
			if meterRunning then
				meterRunning = false
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				
				if driversSendSyncTimer then
					killTimer(driversSendSyncTimer)
					driversSendSyncTimer = nil
				end
				
				removeEventHandler("onClientRender",root,monitoring)
				sendTaximeterSync()
				
				guiStaticImageLoadImage(gui_btn1, "files/stopped.png")
			else
				meterRunning = true
				local theVehicle = getPedOccupiedVehicle(localPlayer)
				
				if driversSendSyncTimer then
					killTimer(driversSendSyncTimer)
					driversSendSyncTimer = nil
				end
				
				sendTaximeterSync()
				driversSendSyncTimer = setTimer(sendTaximeterSync, syncInterval, 0)
				addEventHandler("onClientRender",root,monitoring)
				guiStaticImageLoadImage(gui_btn1, "files/started.png")
			end
		end
	end
end

function resetMeter()
	if(source == gui_btn2) then
		taxiDistance = 0
		guiSetText(gui_label_totalFare, "00000000")
		triggerServerEvent("taximeter:resetMeter", localPlayer)
	end
end

function toggleLight()
	if(source == gui_btn4) then
		if lightOn then
			lightOn = false
			triggerServerEvent("taximeter:setLight", localPlayer, lightOn)
			guiStaticImageLoadImage(gui_btn4, "files/stopped.png")
		else
			lightOn = true
			guiStaticImageLoadImage(gui_btn4, "files/started.png")
			triggerServerEvent("taximeter:setLight", localPlayer, lightOn)
		end
	end
end


local oX, oY, oZ
function monitoring()
	if(isPedInVehicle(localPlayer)) then
		local x,y,z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local thisTime  = getDistanceBetweenPoints3D(x,y,z,oX,oY,oZ)
		taxiDistance = taxiDistance + thisTime
		oX = x
		oY = y
		oZ = z
		if gui_base then
		    local ertekem = tostring(math.ceil(taxiFare*(taxiDistance/700)))*10
			if ertekem > -1 and 10 > ertekem then
			guiSetText(gui_label_totalFare, "0000000".. ertekem .."")
			elseif ertekem > 9 and 100 > ertekem then
			guiSetText(gui_label_totalFare, "000000".. ertekem .."")
			elseif ertekem > 99 and 1000 > ertekem then
			guiSetText(gui_label_totalFare, "00000".. ertekem .."")
			elseif ertekem > 999 and 10000 > ertekem then
			guiSetText(gui_label_totalFare, "0000".. ertekem .."")
			elseif ertekem > 9999 and 100000 > ertekem then
			guiSetText(gui_label_totalFare, "000".. ertekem .."")
			elseif ertekem > 99999 and 1000000 > ertekem then
			guiSetText(gui_label_totalFare, "00".. ertekem .."")
			elseif ertekem > 999999 and 10000000 > ertekem then
			guiSetText(gui_label_totalFare, "0".. ertekem .."")
			elseif ertekem > 9999999 and 100000000 > ertekem then
			guiSetText(gui_label_totalFare, "".. ertekem .."")
			end
		end
	end
end

function incomingTaximeterSync(realDistance, realRunning, realPos)
	if not isDriver then
		if meterRunning then
			removeEventHandler("onClientRender",root,monitoring)
		end
		taxiDistance = realDistance
		oX, oY, oZ = realPos[1], realPos[2], realPos[3]
		if realRunning then
			meterRunning = true
			addEventHandler("onClientRender",root,monitoring)
			guiSetText(gui_label_pax_running, "Taksometr włączony")
			guiLabelSetColor(gui_label_pax_running,0,255,0)
		else
			meterRunning = false
			guiSetText(gui_label_pax_running, "Taksometr wyłączony")
			guiLabelSetColor(gui_label_pax_running,255,0,0)
		end
	end
end
addEvent("taximeter:sync", true)
addEventHandler("taximeter:sync", root, incomingTaximeterSync)

function incomingFareUpdate(newFare)
	taxiFare = newFare
	if gui_base then
	end
end
addEvent("taximeter:sendFare", true)
addEventHandler("taximeter:sendFare", root, incomingFareUpdate)

function incomingReset(newFare)
	taxiDistance = 0
	if gui_base then
		guiSetText(gui_label_totalFare, "00000000")
	end
end
addEvent("taximeter:resetMeter", true)
addEventHandler("taximeter:resetMeter", root, incomingReset)

function sendTaximeterSync(vehicle, ignoreCheck)
	if isDriver then
		local theVehicle
		if vehicle then
			theVehicle = vehicle
		else
			theVehicle = getPedOccupiedVehicle(localPlayer)
		end
		local x,y,z = getElementPosition(theVehicle)
		local pos = {x,y,z}
		triggerServerEvent("taximeter:sendSync", theVehicle, taxiDistance, meterRunning, pos, ignoreCheck)
	end
end

function initializeTaximeter(seat, realDistance, realRunning, realPos, realFare, taxiLight)
	local theVehicle = source
	if(seat == 0) then
		isDriver = true
	else
		isDriver = false
	end
	taxiFare = realFare
	taxiDistance = realDistance
	oX, oY, oZ = realPos[1], realPos[2], realPos[3]
	meterRunning = realRunning
	lightOn = taxiLight
	showTaximeterGui()
	if meterRunning then
		addEventHandler("onClientRender",root,monitoring)
		if isDriver then
			if driversSendSyncTimer then
				killTimer(driversSendSyncTimer)
				driversSendSyncTimer = nil
			end
			driversSendSyncTimer = setTimer(sendTaximeterSync, syncInterval, 0)
		end	
	end
end
addEvent("taximeter:initialize", true)
addEventHandler("taximeter:initialize", root, initializeTaximeter)

addEventHandler("onClientVehicleStartExit", root,
		function (player, seat, door)
			if(player == localPlayer) then
				local theVehicle = source
				if(taxiModels[getElementModel(theVehicle)]) then	
					if meterRunning then
						meterRunning = false
						removeEventHandler("onClientRender",root,monitoring)
						if isDriver and gui_base then
							guiStaticImageLoadImage(gui_btn1, "files/stopped.png")
						end
					end
					if isDriver then
						if driversSendSyncTimer then
							killTimer(driversSendSyncTimer)
							driversSendSyncTimer = nil
						end
					end
				end
			end
		end
)
addEventHandler("onClientVehicleExit", root,
		function (player, seat)
			if(player == localPlayer) then
				local theVehicle = source
				if(taxiModels[getElementModel(theVehicle)]) then
					if isDriver then
						sendTaximeterSync(theVehicle, true)
					end
					hideTaximeterGui()
				end
			end
		end
)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
		function (startedRes)
			triggerServerEvent("taximeter:clientStarted", localPlayer)
		end
)

function taxibuttonhang()
playSound("files/taxibutton.mp3")
end
