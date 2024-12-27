function notAllowedToUse(daPlayah)
    exports.GTIhud:dm("You need to be working as a farmer in order to use the spawner", daPlayah, 255, 255, 0)
end
addEvent("farmerVehicleMessage", true)
addEventHandler("farmerVehicleMessage", root, notAllowedToUse)

function notAllowedToUse2(daPlayah)
    exports.GTIhud:dm("Nesecesitas trabajar de Granjero para poder comprar semillas", daPlayah, 255, 255, 0)
end
addEvent("farmerSeedMessage", true)
addEventHandler("farmerSeedMessage", root, notAllowedToUse2)

local fcarsTrailer = { }
local fcarsTrucks = { }
local timer1 = { }
local timer2 = { }


function attach(thePlayer, elem, em)
    if not isElement(em) then
        if isTimer(timer1[thePlayer]) then
            killTimer(timer1[thePlayer])
        end
        if isTimer(timer2[thePlayer]) then
            killTimer(timer2[thePlayer])
        end
    else
        if not isElement(elem) then
            killTimer(timer1[thePlayer])
            killTimer(timer2[thePlayer])
            destroyElement(em)
        else
            attachTrailerToVehicle(elem, em)
        end
    end
end

addEventHandler ("onVehicleEnter", root,
    function (thePlayer, seat, jacked)
    local x, y, z = getElementPosition (thePlayer )
    local job = getElementData(thePlayer, "job")
    local theVehicle = getElementModel(source)
    if (job == "Granjero" ) then
        if theVehicle == 531 then
            if isElement(fcarsTrailer[thePlayer]) then
                destroyElement(fcarsTrailer[thePlayer])
            end
            fcarsTrailer [ thePlayer ] = createVehicle(610, x, y, z+1 )
            setElementFrozen(fcarsTrailer [ thePlayer ],false)
            setElementData(fcarsTrailer [ thePlayer ], 'Motor', 'encendido', false)
            setElementData(fcarsTrailer [ thePlayer ], "Fuel", 100)
            attachTrailerToVehicle(source, fcarsTrailer [ thePlayer ])
            setTimer(attachTrailerToVehicle, 100, 1, source, fcarsTrailer[thePlayer])
            timer1[thePlayer] = setTimer(attach, 1500, 0, thePlayer, source, fcarsTrailer [ thePlayer ])
            timer2[thePlayer] = setTimer(triggerClientEvent, 1500, 0, root, "noTrailerCollide", root, fcarsTrailer[thePlayer], source)
            triggerClientEvent(thePlayer, "getFarmTrailer", thePlayer, fcarsTrailer[thePlayer])
        else
            if isTimer(timer1[thePlayer]) then
                killTimer(timer1[thePlayer])
                killTimer(timer2[thePlayer])
            end
        end
    end
    if theVehicle == 532 then
        local planted = getElementData(thePlayer, "planted")
        if planted == true then
            if planted == false then
	   	  exports.GTIrentals:destroyRental(thePlayer)
            end
        else
	    exports.GTIrentals:destroyRental(thePlayer)
            if isTimer(timer1[thePlayer]) then
                killTimer(timer1[thePlayer])
                killTimer(timer2[thePlayer])
            end
            exports.GTIhud:dm("Your crops aren't ready for harvesting", thePlayer, 255, 0, 0)
        end
    end
end
)

addEventHandler("onVehicleStartEnter", root, 
function ( player, seat )
	if ( seat == 0 and getElementModel ( source ) == 532 and exports.GTIemployment:getPlayerJob( player, true ) == "Granjero" ) then
		if getElementData ( player, "planted" ) then
			return
		else
			cancelEvent()
			exports.GTIhud:dm("Tu cosecha todavia no esta lista para ser recolectada", player, 255, 0, 0)
		end
	end
end
)

addEvent ("plantedSeeds", true )
addEventHandler ("plantedSeeds", root,
    function(player, chk)
        if chk == true then
            setElementData(player, "planted", true)
            exports.GTIhud:dm("Tu cosecha esta lista para ser plantada", player, 0, 255, 0)
        elseif chk == false then
            setElementData(player, "planted", false)
        end
    end
)

function destroyVehicle()
    if isTimer(timer1[thePlayer]) then
        killTimer(timer1[thePlayer])
        killTimer(timer2[thePlayer])
    end
    if (isElement(fcarsTrailer[source])) then
        destroyElement(fcarsTrailer[source])
    elseif (isElement(fcarsTrucks[source])) then
        destroyElement(fcarsTrucks[source])
    end
end
addEventHandler("onPlayerWasted", root, destroyVehicle)
addEventHandler("onPlayerLogout", root, destroyVehicle)
addEventHandler("onPlayerQuit", root, destroyVehicle)

function getRidOfFCar(daPlayah)
    if isTimer(timer1[thePlayer]) then
        killTimer(timer1[thePlayer])
        killTimer(timer2[thePlayer])
    end
    if (isElement(fcarsTrailer[daPlayah])) then
        destroyElement (fcarsTrailer[daPlayah])
    elseif (isElement(fcarsTrucks[daPlayah])) then
        destroyElement(fcarsTrucks[daPlayah])
    end
end
addEvent("destroyTheFCar", true)
addEventHandler("destroyTheFCar", root, getRidOfFCar)

addEventHandler("onVehicleExit", root,
    function(player)
        local job = getElementData(player, "job")
        local theVehicle = getElementModel(source)
        if job == "Granjero" then
            if theVehicle == 531 then
                if isElement(fcarsTrailer[player]) then
                    destroyElement(fcarsTrailer[player])
                end
            end
        end
    end
)

addEventHandler("onPlayerCommand", root,
    function(cmd)
        if cmd == "hide" then
            local theVehicle = getPedOccupiedVehicle (source )
            if (theVehicle) then
                local vehId = getVehicleModelFromName (getVehicleName(theVehicle))
            end
            --if (vehId == 532 or vehId == 478) then return end
            if getElementData(source, "job") == "Granjero" then
                if (isElement(fcarsTrailer[source])) then
                    if isElement(fcarsTrailer[source]) then
                        speedx, speedy, speedz = getElementVelocity(fcarsTrailer[source])
                    end

					if isTimer(timer1[thePlayer]) or isTimer(timer2[thePlayer]) then
						killTimer(timer1[thePlayer])
						killTimer(timer2[thePlayer])
					end
					destroyElement(fcarsTrailer[source])
                end
            end
        end
    end
)

----------------------------------------------------------------------------------------------------------------------------

addEvent("checkFarmer", true)
addEventHandler("checkFarmer", root,
function(elem, state)
    if (elem) then
        if (state == "Yes") then
            local occ = getElementData(elem, "job")
            if occ == "Granjero" then
                triggerClientEvent(elem, "showSeedsView", elem)
            end
        elseif (state == "No") then
            triggerClientEvent(elem, "hideSeedsView", elem)
        end
    end
end
)

addEvent("checkFarmerSeeds", true)
addEventHandler("checkFarmerSeeds", root,
function(player)
    if (player) then
        local account = getPlayerAccount(player)
        if (account) then
            local seeds = tonumber(seeds)
            triggerClientEvent(player, "placeSeeds", player, seeds)
        end
    end
end
)

addEventHandler("onPlayerLogin", root,
    function()
        --setTimer(farmerFixLogin, 1000, 1, source)
		farmerFixLogin( source)
    end
)

addEventHandler("onResourceStart", resourceRoot,
    function()
        for i, player in pairs (getElementsByType("player")) do
            if exports.GTIemployment:getPlayerJob(player) == "Granjero" then
                setTimer(farmerFixLogin, 1000, 1, player)
            end
        end
    end
)

function makePlayerFarmer(jobName, newJob)
    setTimer(farmerFixLogin, 250, 1, source)
end
addEventHandler("onPlayerGetJob", root, makePlayerFarmer)

function removeFarmer(jobName, resignJob)
    setTimer(farmerFixLogin, 250, 1, source)
end
addEventHandler("onPlayerQuitJob", root, removeFarmer)

function farmerFixLogin(theElement)
    triggerClientEvent(theElement, "fixFarmerLogin", theElement)
    if getElementData(theElement, "job") == "Granjero" then
        local account = getPlayerAccount(theElement)
        local seeds = getAccountData(account, "farmer.seeds") or 0
        local division = exports.GTIemployment:getPlayerJobDivision(theElement)
        local seeds = tonumber(seeds)
        triggerClientEvent(theElement, "placeSeeds", theElement, seeds)
        triggerClientEvent(theElement, "setDivisionObject", theElement, tostring(division))
    end
end

addEvent("giveTheSeeds", true)
addEventHandler("giveTheSeeds", root,
function(seeds, cost)
    if (seeds) then
        local account = getPlayerAccount(client)
        local accountName = getAccountName(account)
        if (account) then
            local tseeds = getAccountData(account, "farmer.seeds") or 0
            local tseeds = tonumber(tseeds)
            if tseeds+seeds >= 10000 then
                newSeedCount = 10000
            else
                newSeedCount = tseeds+seeds
            end
            takePlayerMoney(client, cost, "Farmer: Bought "..tostring(amount).." seeds.")
            setAccountData(account, "farmer.seeds", newSeedCount)
            triggerClientEvent(client, "placeSeeds", client, newSeedCount)
            --exports.GTIhud:dm("You bought "..seeds.." seeds", client, 255, 255, 0)
        end
    end
end
)

addEvent("takeTheSeeds", true)
addEventHandler("takeTheSeeds", root,
    function(seeds)
        if (seeds) then
            local account = getPlayerAccount(client)
            if (account) then
                local tseeds = getAccountData(account, "farmer.seeds") or 0
                local tseeds = tonumber(tseeds)
                local cseeds = tseeds-seeds
                if cseeds < 0 then return false end
                setAccountData(account, "farmer.seeds", tseeds-seeds)
                triggerClientEvent(client, "placeSeeds", client, tseeds-seeds)
            end
        end
    end
)

local jobCash = {}
function setsJobCash(bails)
    local payOffset = exports.GTIemployment:getPlayerJobPayment(client, "Granjero")
    local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
    local hrExp = exports.GTIemployment:getHourlyExperience()
    local pay = math.ceil( (bails)*payOffset)
    local Exp = math.ceil( (pay/hrPay)*hrExp )
	
	setPlayerHemp ( client, getPlayerHemp ( client ) + 50 )
	exports.GTIhud:drawNote("HempAmount", "+ Hemp 50 ", client, 0, 255, 0, 7500)
    exports.GTIemployment:modifyPlayerJobProgress(client, "Granjero", 10)
    exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Granjero")
	exports.GTIemployment:givePlayerJobMoney(client, "Granjero", pay)

    local account = getPlayerAccount(client)
end
addEvent("setsJobCash", true)
addEventHandler("setsJobCash", root, setsJobCash)

function getPlayerHemp ( player )
    local acc = getPlayerAccount ( player )
    local hemp = tonumber ( getAccountData ( acc, "hemp" ) ) or 0
    return hemp
end

function setPlayerHemp ( player, amount )
    local acc = getPlayerAccount ( player )
    setAccountData ( acc, "hemp", tostring ( amount ) )
    triggerClientEvent ( player, "onHempLoad", player, amount )
    return true
end

function loadHemp ( irrelevant, account)
    triggerClientEvent ( source, "onHempLoad", source, getPlayerHemp ( source ) )
end
addEventHandler ("onPlayerLogin", root, loadHemp )

function restoreControl(thePlayer)
    for k, v in ipairs({"accelerate", "enter_exit", "handbrake"}) do
        toggleControl(thePlayer, v, true)
    end
    local vehicle = getPedOccupiedVehicle (thePlayer )
    if (vehicle ) then
        setElementFrozen (vehicle, false )
    end
    setControlState(thePlayer, "handbrake", false)
    fadeCamera(thePlayer, true)
end

function sendCancelledMessage(thePlayer, reason)
    if not reason then
        exports.GTIhud:dm("Your delivery was cancelled", thePlayer, 255, 255, 0)
    else

        if reason and type(reason) == "string" then
            exports.GTIhud:dm("Your delivery was cancelled because "..reason, thePlayer, 255, 255, 0)
        else
            exports.GTIhud:dm("Your delivery was cancelled", thePlayer, 255, 255, 0)
        end
    end
end
addEvent("farmerCancel", true)
addEventHandler("farmerCancel", root, sendCancelledMessage)
