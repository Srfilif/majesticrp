_AutosCreados = {}
local Concesionario = {}
Concesionario.__index = Concesionario
Concesionario['vDatos'] = {}

local bikes = {
    [581] = true,
    [462] = true,
    [521] = true,
    [463] = true,
    [522] = true,
    [461] = true,
    [448] = true,
    [468] = true,
    [586] = true,
    [523] = true,
    [471] = true
}

bicicletas = {
    [510] = true,
    [481] = true,
    [509] = true
}
-- abrirp

permisos = {

    ["Desarrollador"] = true,
    ["Administrador.General"] = true,
    ["Admin"] = true,
    ["Sup.Staff"] = true,
    ["SuperModerador"] = true,
    ["Moderador"] = true,
    ["Moderador A Pruebas"] = true

}

vShopCol = {}
spawnAnnul = {}
markerVehic = {}
afText = {}
myTextItem = {}

function guiStart()
    local node = xmlLoadFile("data\\carshops.xml")
    local vNum2 = 0
    while (xmlFindChild(node, "carshop", vNum2) ~= false) do
        local vNum3 = 0
        local shop = xmlFindChild(node, "carshop", vNum2)
        while (xmlFindChild(shop, "carshopcol", vNum3) ~= false) do
            local shopCol = xmlFindChild(shop, "carshopcol", vNum3)
            local shopName = xmlNodeGetAttribute(shopCol, "name")
            local pX = xmlNodeGetAttribute(shopCol, "posX")
            local pY = xmlNodeGetAttribute(shopCol, "posY")
            local pZ = xmlNodeGetAttribute(shopCol, "posZ")
            local m1 = xmlNodeGetAttribute(shopCol, "M1")
            local spawnPX = xmlNodeGetAttribute(shopCol, "spawnPX")
            local spawnPY = xmlNodeGetAttribute(shopCol, "spawnPY")
            local spawnPZ = xmlNodeGetAttribute(shopCol, "spawnPZ")
            local spawnRZ = xmlNodeGetAttribute(shopCol, "spawnRZ")
            IspawnCol = createColSphere(spawnPX, spawnPY, spawnPZ, 2.4)
            vShopCol1 = createColSphere(pX, pY, pZ, 1)
            setElementData(IspawnCol, "SpawnPointName", "" .. shopName .. "")
            setElementData(IspawnCol, "sRz", "" .. spawnRZ .. "")
            setElementData(vShopCol1, "tList", "" .. m1 .. "")
            setElementData(vShopCol1, "SpawnShopName", "" .. shopName .. "")
            createMarker(pX, pY, pZ, "cylinder", 1, 0, 0, 255, 0)
            addEventHandler("onColShapeHit", IspawnCol, spawnColCol)
            -- addEventHandler( "onColShapeHit", vShopCol1, conCol )
            addEventHandler("onColShapeLeave", IspawnCol, setDataCol1)
            local vNum4 = 0
            while (xmlFindChild(shopCol, "model", vNum4) ~= false) do
                local modelE = xmlFindChild(shopCol, "model", vNum4)
                local pX1 = xmlNodeGetAttribute(modelE, "posX")
                local pY1 = xmlNodeGetAttribute(modelE, "posY")
                local pZ1 = xmlNodeGetAttribute(modelE, "posZ")
                local rZ = xmlNodeGetAttribute(modelE, "rot")
                local id = xmlNodeGetAttribute(modelE, "name")
                local vehicle = createVehicle(id, pX1, pY1, pZ1, 0, 0, rZ)
                setTimer(setElementFrozen, 1000, 1, vehicle, true)
                setVehicleLocked(vehicle, true)
                vehicle:setData('Locked', 'Cerrado')
                setVehicleDamageProof(vehicle, true)
                vNum4 = vNum4 + 1
            end
            vNum3 = vNum3 + 1
        end
        vNum2 = vNum2 + 1
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), guiStart)

function spawnColCol(element)
    if getElementType(element) == "vehicle" then
        setElementData(source, "etatPlace", "OQP")
    end
end

function setDataCol1(element)
    if getElementType(element) == "vehicle" then
        local player = getVehicleOccupant(element, 0)
        setElementData(source, "etatPlace", "libre")
        if (spawnAnnul[player]) ~= nil then
            killTimer(spawnAnnul[player])
            spawnAnnul[player] = nil
        end
    end
end
local conceMoto = createColSphere(2475.7973632813, -1750.6513671875, 12.6, 1.3)

function creandoelpanel(player)
    if isElementWithinColShape(player, conceMoto) then
        setElementData(player, "tList", "Bike")
        atList, atList1 = getElementData(player, "tList")
        local shopName = getElementData(player, "SpawnShopName")
        setElementData(player, "shopName", "BikesScoots")
        triggerClientEvent(player, "guiStart", getRootElement(), atList, atList1)
    end
end
addCommandHandler("vehiculos", creandoelpanel)
--------------------------------------------------------------------------------------
local conceJeff = createColSphere(2131.7060546875, -1150.5327148438, 23.5, 1.3)

function creandoelpanel2(player)
    if isElementWithinColShape(player, conceJeff) then
        setElementData(player, "tList", "CochesPobres")
        atList, atList1 = getElementData(player, "tList")
        local shopName = getElementData(player, "SpawnShopName")
        setElementData(player, "shopName", "carshop jefferson")
        triggerClientEvent(player, "guiStart", getRootElement(), atList, atList1)
    end
end
addCommandHandler("vehiculos", creandoelpanel2)
----------------------------------------------------------------------------------------
local conceCara = createColSphere(542.10986328125, -1292.8754882812, 17.2421875, 1.3)

function creandoelpanel3(player)
    if isElementWithinColShape(player, conceCara) then
        setElementData(player, "tList", "CochesCaros")
        atList, atList1 = getElementData(player, "tList")
        local shopName = getElementData(player, "SpawnShopName")
        setElementData(player, "shopName", "car shop mulholland")
        triggerClientEvent(player, "guiStart", getRootElement(), atList, atList1)
    end
end
addCommandHandler("vehiculos", creandoelpanel3)
---------------------------------------------------------------------------------------
local conceCamioneta = createColSphere(1097.763671875, -1370.8673095703, 14, 1.3)

function creandoelpanel4(player)
    if isElementWithinColShape(player, conceCamioneta) then
        setElementData(player, "tList", "CamionetasC")
        atList, atList1 = getElementData(player, "tList")
        local shopName = getElementData(player, "SpawnShopName")
        setElementData(player, "shopName", "Camionetas")
        triggerClientEvent(player, "guiStart", getRootElement(), atList, atList1)
    end
end
addCommandHandler("vehiculos", creandoelpanel4)
----------------------------------------------------------------------------------------
local conceAvion = createColSphere(1897.4875488281, -2345.3630371094, 13.546875, 1.3)

function creandoelpanel5(player)
    if isElementWithinColShape(player, conceAvion) then
        setElementData(player, "tList", "Plane")
        atList, atList1 = getElementData(player, "tList")
        local shopName = getElementData(player, "SpawnShopName")
        setElementData(player, "shopName", "los Santos International")
        triggerClientEvent(player, "guiStart", getRootElement(), atList, atList1)
    end
end
addCommandHandler("vehiculos", creandoelpanel5)
---------------------------------------------------------------------------------------
local conceBarocs = createColSphere(723.11, -1494.55, 1.93, 1.3)

function creandoelpanel6(player)
    if isElementWithinColShape(player, conceBarocs) then
        setElementData(player, "tList", "Boat")
        atList, atList1 = getElementData(player, "tList")
        local shopName = getElementData(player, "SpawnShopName")
        setElementData(player, "shopName", "BoatShop marina")
        triggerClientEvent(player, "guiStart", getRootElement(), atList, atList1)
    end
end
addCommandHandler("vehiculos", creandoelpanel6)
---------------------------------------------------------------------------------------
local conceMont = createColSphere(1399.150390625, 456.26892089844, 20.172252655029, 1.3)

function creandoelpanel7(player)
    if isElementWithinColShape(player, conceMont) then
        setElementData(player, "tList", "Mont")
        atList, atList1 = getElementData(player, "tList")
        local shopName = getElementData(player, "SpawnShopName")
        setElementData(player, "shopName", "MontgomeryRaro")
        triggerClientEvent(player, "guiStart", getRootElement(), atList, atList1)
    end
end
addCommandHandler("vehiculos", creandoelpanel7)
---------------------------------------------------------------------------------------

function vehicleCreat(player, cost, vId, x, y, z, nPlayer, male, sRz, r, g, b, r2, g2, b2)
    removeElementData(player, "shopName")

    if getPlayerMoney(player) >= math.abs(cost) then

        local id = getLastID(player)

        if (not getPlayerVIP(player) and id - 1 < 2) or (getPlayerVIP(player) == "VIPNormal" and id - 1 < 3) or
            (getPlayerVIP(player) == "VIPPro" and id - 1 < 5) then

            local maletero = {
                Slots = male,
                Items = {}
            }
            local account = AccountName(player)
            for pi = 1, male do
                maletero.Items[tostring(pi)] = {'Vacio'}
            end
            _AutosCreados[account] = _AutosCreados[account] or {}
            _AutosCreados[account][id] = createVehicle(vId, x, y, z, 0, 0, sRz)
            _AutosCreados[account][id]:setColor(r, g, b, r2, g2, b2)
            setVehicleDamageProof(_AutosCreados[account][id], true)
            _AutosCreados[account][id]:setData('Maletero', maletero)
            _AutosCreados[account][id]:setData("Fuel", 100)
            _AutosCreados[account][id]:setEngineState(false)
            _AutosCreados[account][id]:setData('ID', id)
            _AutosCreados[account][id]:setData('Owner', account)
            takePlayerMoney(player, math.abs(cost))

            local placa = _AutosCreados[account][id]:getPlateText()

            insertDat(player, id, vId, cost, X, Y, Z, sRz, r, g, b, r2, g2, b2, placa, toJSON(maletero), 100)

            if (_AutosCreados[account][id]) then
                toggleVehicleRespawn(_AutosCreados[account][id], false)
            end
            spawnAnnul[player] = setTimer(delayedSpawn, 5000, 1, "15", _AutosCreados[account][id], player, cost)
            player:outputChat("#B200FF[CONCE] #ffffffEste vehículo cuesta #228E00$" .. cost, 178, 140, 214, true)
            player:outputChat("#B200FF[CONCE] #ffffffSi quieres quedartelo subete a él.", 178, 140, 214, true)
            player:outputChat("#B200FF[CONCE] #ffffffDe lo contrario, espera #FF3E3E15 segundos.", 178, 140, 214, true)
        else
            player:outputChat(
                "#ffffffYa no tienes mas slots para comprar #FF8700vehiculos#ffffff, si quieres adquirir mas usa #3EFF00/ayuda vip",
                178, 140, 214, true)
        end
    else
        player:outputChat("#B200FF[CONCESIONARIO] #ffffffNo tienes dinero suficiente para comprar este vehiculo.", 178,
            140, 214, true)
    end
end
addEvent("but_applyVehicle", true)
addEventHandler("but_applyVehicle", getRootElement(), vehicleCreat)
function delayedSpawn(curTime, vehicle, player, cost)
    if curTime ~= 0 then
        curTime = curTime - 1
        spawnAnnul[player] = setTimer(delayedSpawn, 1000, 1, curTime, vehicle, player, cost)
        -- warnText ( ""..curTime.."", player )
    else
        local id = vehicle:getData('ID')
        local account = AccountName(player)
        -- warnText ( "Vehicule repaid !", player )
        player:outputChat("#B200FF[CONCE] #FF3E3EDecidiste no tomar el vehiculo. #ffffffTe devolvimos #228E00$" .. cost,
            178, 140, 214, true)
        givePlayerMoney(player, math.abs(cost))
        triggerClientEvent(getRootElement(), "destroyvehicles", getRootElement(), vehicle)
        databaseUpdate("Delete from Info_Vehicles WHERE Cuenta='" .. account .. "' AND ID ='" .. id .. "'")
        if (markerVehic[player]) then
            destroyElement(markerVehic[player])
        end
        setTimer(destroyElement, 100, 1, vehicle)
    end
end

function vExplode()
    if getElementData(source, "Owner") ~= false then
        toggleVehicleRespawn(source, false)
        setTimer(destroyElement, 5000, 1, source)
    end
end
addEventHandler("onVehicleExplode", getResourceRootElement(getThisResource()), vExplode)

function warnText(aWText, player)
    if (myTextItem[player]) then
        textDestroyTextItem(myTextItem[player])
    end
    afText[player] = textCreateDisplay()
    textDisplayAddObserver(afText[player], player)
    myTextItem[player] = textCreateTextItem(aWText, 0.22, 0.8, 2, 255, 0, 0, 255, 3)
    textDisplayAddText(afText[player], myTextItem[player])
    --	outputChatBox ( textA, player )
    setTimer(textDestroyTextItem, 5000, 1, myTextItem[player], player)
end

addEventHandler("onResourceStart", resourceRoot, function()
    for i, player in ipairs(Element.getAllByType('player')) do
        crearVehiculosJugador(player)
    end
end)

addEventHandler("onResourceStop", getResourceRootElement(), function()
    for i, player in ipairs(Element.getAllByType('player')) do
        guardarVehiculosJugador(player)
    end
end)
addEventHandler("onPlayerLogin", getRootElement(), function()
    crearVehiculosJugador(source)
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    guardarVehiculosJugador(source)
end)

local antiSpamCommnd = {}

function abrirMyVehicle(p, cmd)
    local veh = getPlayerNearbyVehicle(p)
    if veh then
        local ID = veh:getData('ID') or false
        if ID then
            local tick = getTickCount()
            if (antiSpamCommnd[p] and antiSpamCommnd[p][1] and tick - antiSpamCommnd[p][1] < 1000) then
                return
            end
            local owner = getElementData(veh, 'Owner')
            if owner and owner == p.account.name then
				local cx,cy,cz = getElementPosition(veh)

				for i, v in ipairs(getPlayersOverArea(p, 5)) do
					v:triggerEvent('BloquearVeh', v,cx,cy,cz)
				end
                local state = getElementData(veh, 'Locked')
                if state == 'Abierto' then

                    
                    setVehicleLocked(veh, true) -- lock it

                    setVehicleDoorOpenRatio(veh, 2, 0)
                    setVehicleDoorOpenRatio(veh, 3, 0)
                    setVehicleDoorOpenRatio(veh, 4, 0)
                    setVehicleDoorOpenRatio(veh, 5, 0)
                    veh:setData('Locked', 'Cerrado')
                    p:setData("TextInfo", {"> cerro su " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
                    p:outputChat("> cerro su " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216, true)
                    setTimer(function(p)
                        p:setData("TextInfo", {"", 255, 0, 216})
                    end, 2000, 1, p)

                else

                    
                    setVehicleLocked(veh, false) -- lock it

                    veh:setData('Locked', 'Abierto')
                    p:setData("TextInfo", {"> abrio su " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
                    p:outputChat("> abrio su " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216, true)
                    setTimer(function(p)
                        p:setData("TextInfo", {"", 255, 0, 216})
                    end, 2000, 1, p)

                end
            else
                p:outputChat("#ff3d3d* No puedes abrir este vehiculo, No tienes sus llaves", 255, 0, 216, true)
            end
            if (not antiSpamCommnd[p]) then
                antiSpamCommnd[p] = {}
            end
            antiSpamCommnd[p][1] = getTickCount()
	    elseif getElementData(veh,'VehiculoPublico') and getElementData(p,'Roleplay:faccion') == getElementData(veh,'VehiculoPublico') then
			local cx,cy,cz = getElementPosition(veh)

				for i, v in ipairs(getPlayersOverArea(p, 5)) do
					v:triggerEvent('BloquearVeh', v,cx,cy,cz)
				end
			local state = getElementData(veh, 'Locked')

			if state == 'Abierto' then

				
			
				setVehicleLocked(veh, true) -- lock it

				setVehicleDoorOpenRatio(veh, 2, 0)
				setVehicleDoorOpenRatio(veh, 3, 0)
				setVehicleDoorOpenRatio(veh, 4, 0)
				setVehicleDoorOpenRatio(veh, 5, 0)
				veh:setData('Locked', 'Cerrado')
				p:setData("TextInfo", {"> cerro el " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
				p:outputChat("> cerro el " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216, true)
				setTimer(function(p)
					p:setData("TextInfo", {"", 255, 0, 216})
				end, 2000, 1, p)

			else

				
				setVehicleLocked(veh, false) -- lock it

				veh:setData('Locked', 'Abierto')
				p:setData("TextInfo", {"> abrio el " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
				p:outputChat("> abrio el " .. getVehicleNameFromModel(veh:getModel()), 255, 0, 216, true)
				setTimer(function(p)
					p:setData("TextInfo", {"", 255, 0, 216})
				end, 2000, 1, p)

			end
		else

			  
		p:outputChat("#ff3d3d* No puedes abrir este vehiculo, No tienes sus llaves", 255, 0, 216, true)
	    
        end
    end
end
addCommandHandler("abrir", abrirMyVehicle)
addCommandHandler("cerrar", abrirMyVehicle)
addCommandHandler("bloqueo", abrirMyVehicle)
-- Prevenir que los jugadores entren a vehículos bloqueados

-- Prevenir que los jugadores salgan de vehículos bloqueados
addEventHandler("onVehicleStartExit", root, function(player, seat)
    local locked = source:getData('Locked')
    if locked == 'Cerrado' then
        cancelEvent()
        player:outputChat("#ff3d3d* No puedes salir, Este vehiculo esta bloqueado.", 255, 0, 0, true)
    end
end)
function crearVehiculosJugador(player)
    local account = AccountName(player)
    local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='" .. account .. "'") or 0
    if #datos > 0 then
        for k, v in pairs(datos) do
            local color = split(v.Color, ',')
            local account = AccountName(player)
            local id = tonumber(v.ID)
            _AutosCreados[account] = _AutosCreados[account] or {}

            if type(v.X) == "number" and type(v.Y) == "number" and type(v.Z) == "number" then
                _AutosCreados[account][id] = createVehicle(tonumber(v.Modelo), v.X, v.Y, v.Z, 0, 0, v.rotZ)
                _AutosCreados[account][id]:setColor(color[1], color[2], color[3], color[4], color[5], color[6])
                _AutosCreados[account][id]:setLocked(true)
                _AutosCreados[account][id]:setEngineState(false)
                _AutosCreados[account][id]:setPlateText(tostring(v.Placa))
                _AutosCreados[account][id]:setHealth(tonumber(v.Vida))
                _AutosCreados[account][id]:setData('Owner', v.Cuenta)
                _AutosCreados[account][id]:setData('rent1', v.Rent1)
                _AutosCreados[account][id]:setData('rent2', v.Rent2)
                _AutosCreados[account][id]:setData('Maletero', fromJSON(v.Maletero))
                _AutosCreados[account][id]:setData('tiposeguro', v.tiposeguro)
                _AutosCreados[account][id]:setData('seguro', v.seguro)
                _AutosCreados[account][id]:setData('ID', tonumber(v.ID)) -- opcional
                _AutosCreados[account][id]:setData('Locked', 'Cerrado')
                _AutosCreados[account][id]:setData('Motor', 'apagado')
                _AutosCreados[account][id]:setData("Fuel", tonumber(v.Gasolina))
                _AutosCreados[account][id]:setData('Kilometraje', tonumber(v.Kilometraje))

                if v.Handling then
                    local handling = fromJSON(v.Handling)
                    for k, v in pairs(handling) do
                        setVehicleHandling(_AutosCreados[account][id], k, v)
                    end
                end

                for i, upgrade in ipairs(split(v.Upgrades, ',')) do
                    addVehicleUpgrade(_AutosCreados[account][id], upgrade)
                end
                setVehiclePaintjob(_AutosCreados[account][id], tonumber(v.Paint) or 3)
            end
        end
    end
end

function guardarVehiculosJugador(player)
    local account = AccountName(player)
    local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='" .. account .. "'")
    if #datos > 0 then
        local autos = _AutosCreados[account]
        if autos then
            for i = 1, #autos do
                local id = getElementData(autos[i], 'ID')
                local vida = autos[i]:getHealth()
                local fuel = getElementData(autos[i], "Fuel") or 0
                local x, y, z = getElementPosition(autos[i])
                local _, _, rz = getElementRotation(autos[i])
                local rent1 = getElementData(autos[i], 'rent1')
                local rent2 = getElementData(autos[i], 'rent2')
                local maletero = toJSON(getElementData(autos[i], 'Maletero'))
                local paintjob = autos[i]:getPaintjob()
                local seguro = getElementData(autos[i], "seguro")
                local tiposeguro = getElementData(autos[i], "tiposeguro")
                local r, g, b, r2, g2, b2 = autos[i]:getColor(true)

                local handlingT = toJSON(getVehicleHandling(autos[i]))

                local upgrade = ""
                for _, upgradee in ipairs(autos[i]:getUpgrades()) do
                    if upgrade == "" then
                        upgrade = upgradee
                    else
                        upgrade = upgrade .. "," .. upgradee
                    end
                end
                local account = AccountName(player)
                local s = databaseQuery(
                    "SELECT * From Info_Vehicles WHERE Cuenta='" .. account .. "' AND ID ='" .. id .. "'")
                if #s > 0 then
                    local color = r .. "," .. g .. "," .. b .. "," .. r2 .. "," .. g2 .. "," .. b2
                    databaseUpdate(
                        "UPDATE Info_Vehicles SET X=?,Y=?,Z=?,rotZ=?,Vida=?,Color=?,Maletero=?,Gasolina=?,Upgrades=?,Paint=?,Rent1=?,Rent2=?,tiposeguro=?,seguro=?,Handling=? WHERE Cuenta='" ..
                            account .. "' AND ID ='" .. id .. "'", x, y, z, rz, vida, color, maletero, fuel, upgrade,
                        paintjob, rent1, rent2, tiposeguro, seguro, handlingT)
                end
            end
            for i = 1, #autos do
                if isElement(autos[i]) then
                    autos[i]:destroy()
                end
            end
            _AutosCreados[account] = nil
        end
    end
end
function getPlayerNearbyVehicle(player)
    if isElement(player) then
        for i, veh in ipairs(Element.getAllByType('vehicle')) do
            local vx, vy, vz = getElementPosition(veh)
            local px, py, pz = getElementPosition(player)
            if getDistanceBetweenPoints3D(vx, vy, vz, px, py, pz) < 3.5 then
                return veh
            end
        end
    end
    return false
end

function insertDat(player, id, modelo, cost, x, y, z, rz, r, g, b, r2, g2, b2, placa, maletero, gasolina, upgrades,
    paintjob, vida, rent1, rent2, tiposeguro, seguro, Handling)
    if isElement(player) then
        local account = AccountName(player)
        local s = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='" .. account .. "' AND ID ='" .. id .. "'")
        if #s == 0 or not s then
            local color = r .. "," .. g .. "," .. b .. ""
            databaseInsert("INSERT INTO Info_Vehicles VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", id, account,
                modelo, gasolina, x, y, z, rz, 1000, '', '', color, placa, maletero, cost, "", "", "", "", "")
        end
    end
end

function getLastID(player)
    if isElement(player) then
        local result = databaseQuery("SELECT * FROM Info_Vehicles WHERE Cuenta=?",
            getAccountName(getPlayerAccount(player)))
        return (#result or 0) + 1
    end
end

function getPlayerVIP(player)
    if isElement(player) then
        local accName = getAccountName(getPlayerAccount(player))
        if isObjectInACLGroup("user." .. accName, aclGetGroup("VIPPro")) then
            return "VIPPro"
        elseif isObjectInACLGroup("user." .. accName, aclGetGroup("VIPNormal")) then
            return "VIPNormal"
        else
            return false
        end
    end
    return false
end

function isPedWithinRange(x, y, z, range, ped)
    for _, type in ipairs({'player', 'ped'}) do
        for k, v in pairs(getElementsWithinRange(x, y, z, range, type)) do
            if v == ped then
                return true
            end
        end
    end
    return false;
end

local Markersvender = {}
local venderveh = {}

local marcadores = {{2557.3525390625, -1126.8623046875, 64.06379699707},
                    {1372.748046875, -1892.6298828125, 13.495409965515}, {1013.5712890625, -1006.98046875, 32.1015625},
                    {1867.0068359375, -2381.333984375, 13.5546875}}

addEventHandler("onResourceStart", resourceRoot, function()
    for i, v in ipairs(marcadores) do
        Markersvender[i] = Marker(v[1], v[2], v[3] - 1, "cylinder", 4, 27, 100, 0, 100)
        addEventHandler("onMarkerLeave", Markersvender[i], function(player)
            if player and player:getType() == "player" then
                if player:isInVehicle() then
                    local veh = player:getOccupiedVehicle()
                    local seat = player:getOccupiedVehicleSeat()
                    if veh and seat == 0 then
                        player:outputChat("¡Acabas de cancelar la venta de tu auto!", 150, 50, 50)
                        venderveh[player] = nil
                    end
                end
            end
        end)
    end
end)

addCommandHandler("vendervehestado", function(source)
    for i, marker in ipairs(Markersvender) do
        if isElementWithinMarker(source, marker) then
            source:outputChat(
                "#ffffffTe recordamos que al vender el vehículo pasara a ser parte del #04FF00desguace#ffffff hasta su destrucción.",
                255, 255, 255, true)
            source:outputChat(" ", 255, 255, 255, true)
            source:outputChat("#ffffffPor está venta se te dará el #04FF0040%#ffffff del valor original.", 255, 255,
                255, true)
            source:outputChat("#ffffffSi estás seguro de esta acción coloca #04FF00/sivenderveh#ffffff", 255, 255,
                255, true)
            venderveh[source] = true
        end
    end
end)

addCommandHandler("sivenderveh", function(source)
    for i, marker in ipairs(Markersvender) do
        if isElementWithinMarker(source, marker) then
            if isElement(source) then
                local account = AccountName(source)
                local s = databaseQuery("SELECT * FROM Info_Vehicles where Cuenta = ?", account)
                if not (type(s) == "table" and #s == 0) or not s then
                    for i, v in ipairs(s) do
                        if isPedInVehicle(source) then
                            if venderveh[source] == true then
                                vehicles = getPedOccupiedVehicle(source, account)
                                local id = vehicles:getData('ID')
                                local data = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='" .. account ..
                                                               "' AND Placa='" .. v.Placa .. "' AND ID='" .. v.ID ..
                                                               "' AND Modelo='" .. v.Modelo .. "'AND Costo='" .. v.Costo ..
                                                               "'")
                                if type(data) == "table" and #data ~= 0 then
                                    if isElement(vehicles) then
                                        vehicles:destroy()
                                        source:setMoney(getPlayerMoney(source) + tonumber(v.Costo) * 40 / 100)
                                        databaseUpdate("Delete from Info_Vehicles WHERE Cuenta='" .. account ..
                                                           "' AND ID ='" .. id .. "'")
                                        -- databaseDelete("DELETE FROM Info_Vehicles WHERE Cuenta='"..account.."' AND Placa='"..v.Placa.."'AND ID='"..v.ID.."'AND Modelo='"..v.Modelo.."' AND Costo='"..v.Costo.."'")
                                        source:outputChat("Vendiste tú vehículo por #04FF00$" .. v.Costo * 40 / 100,
                                            255, 255, 255, true)
                                        venderveh[source] = nil
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
