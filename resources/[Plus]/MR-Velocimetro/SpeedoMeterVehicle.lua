local smoothedRPMRotation = 0
local vehicleNos = nil
local vehicleRPM = 0


-- 'main stats'
function refreshVehicle()
    vehicle = getPedOccupiedVehicle(player)
end
addEventHandler("onClientRender", root, refreshVehicle)


-- 'vehicle speed'
function getVehicleSpeed()   
    if (vehicle) then
        local vx, vy, vz = getElementVelocity(vehicle)
        
        if (vx) and (vy)and (vz) then
            return math.sqrt(vx^2 + vy^2 + vz^2) * 180 -- km/h
        else
            return 0
        end
    else
        return 0
    end
end


function getVehicleSpeedString() 
    local speedString = math.floor(getVehicleSpeed() + 0.5)
    return string.format("%03d", speedString)
end


-- 'vehicle gear'
function getVehicleGear()    
    if (vehicle) then
        local vehicleGear = getVehicleCurrentGear(vehicle)
        
        return tonumber(vehicleGear)
    else
        return 0
    end
end


function getFormattedVehicleGear()
    local gear = getVehicleGear()
    local rearString = "R"
    
    if (gear > 0) then
        return gear
    else
        return rearString
    end
end


-- 'vehicle rpm'
function getVehicleRPM() 
    if (vehicle) then   
        if (isVehicleOnGround(vehicle)) then
            isVehicleInStunt = "false"
           
            if (getVehicleEngineState(vehicle) == true) then
                if(getVehicleGear() > 0) then
                    vehicleRPM = math.floor(((getVehicleSpeed()/getVehicleGear())*180) + 0.5)
                    
                    if (vehicleRPM < 650) then
                        vehicleRPM = math.random(650, 750)
                    elseif (vehicleRPM >= 9800) then
                        vehicleRPM = 9800
                    end
                else
                    vehicleRPM = math.floor(((getVehicleSpeed()/1)*180) + 0.5)
                    
                    if (vehicleRPM < 650) then
                        vehicleRPM = math.random(650, 750)
                    elseif (vehicleRPM >= 9800) then
                        vehicleRPM = 9800
                    end
                end
            else
                vehicleRPM = 0
            end
        else
            isVehicleInStunt = "true"
            
            if (getVehicleEngineState(vehicle) == true) then
                vehicleRPM = vehicleRPM - 150
                    
                if (vehicleRPM < 650) then
                    vehicleRPM = math.random(650, 750)
                elseif (vehicleRPM >= 9800) then
                    vehicleRPM = 9800
                end
            else
                vehicleRPM = 0
            end
        end
        
        return tonumber(vehicleRPM)
    else
        return 0
    end
end


function getRPMRoation()
 
    if (getVehicleRPM()) and (getVehicleRPM() >= 0) then
    local rpmRotation = math.floor(((270/9800)* getVehicleRPM()) + 0.5)
        
        if (smoothedRPMRotation < rpmRotation) then
            smoothedRPMRotation = smoothedRPMRotation + 2
        end
        
        if (smoothedRPMRotation > rpmRotation) then
            smoothedRPMRotation = smoothedRPMRotation - 2
        end
        
        return tonumber(smoothedRPMRotation)
    else
        return 0
    end   
end


function getFormattedRpmRotation()
    local rpm = getRPMRoation()
    local rpm1 = rpm
    local rpm2 = rpm
    local rpm3 = rpm
    local rpm4 = rpm
    
    if (rpm1 >= 90) then
        rpm1 = 90
    elseif (rpm1 < 0) then
        rpm1 = 0
    end
    
    if (rpm2 >= 180) then
        rpm2 = 180
    elseif (rpm2 < 0) then
        rpm2 = 0
    end
    
    if (rpm3 >= 219) then
        rpm3 = 219
    elseif (rpm3 < 0) then
        rpm3 = 0
    end
        
    if (rpm4 >= 360) then
        rpm4 = 360
    elseif (rpm4 < 0) then
        rpm4 = 0
    end
    
    return rpm1, rpm2, rpm3, rpm4
end


function getCarStateColor()
    local fuel = getElementData(vehicle, "Fuel")

    if (fuel) then
        -- Asegúrate de que el valor de 'fuel' esté entre 0 y 100
        fuel = math.max(0, math.min(100, fuel))

        -- Calcular los colores basados en el porcentaje de combustible
        local g = (255 / 100) * fuel  -- Verde aumenta con más combustible
        local r = 255 - g             -- Rojo disminuye con más combustible
        local b = 0                  -- Azul fijo en 0 para este caso

        return r, g, b
    else
        -- Si no hay datos de combustible, retorna verde completo
        return 0, 255, 0
    end
end



function getNitroStateColor()   
    local nitro = getVehicleUpgradeOnSlot(vehicle, 8)
     
    if (nitro > 0) then
        return 0, 255, 0
    else
        return 75, 75, 75
    end
end