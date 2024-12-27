local screenWidth, screenHeight = guiGetScreenSize()

-- 'Textures'
local speedometerBG = "textures/speedometerBG.png"
local speedometerBG2 = "textures/speedometerBG2.png"
local speedometerNeedleWhite = "textures/speedometerNeedleWhite.png"
local speedometerNeedleRed = "textures/speedometerNeedleRed.png"
local speedometerOverlay = "textures/speedometerOverlay.png"
local speedometerGlass = "textures/speedometerGlass.png"
local carState = "textures/carState.png"
local nitroState ="textures/nitroState.png"

-- 'fonts'
fontPrototype10 = dxCreateFont("fonts/Prototype.ttf", 10)
fontPrototype40 = dxCreateFont("fonts/Prototype.ttf", 40)
fontLCD22 = dxCreateFont("fonts/lcd.ttf", 22)


function speedoMeterGUI() 
    if (vehicle) then 
        local rpm1, rpm2, rpm3, rpm4 = getFormattedRpmRotation()
        -- 'Speedometer'
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerBG)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerNeedleRed, rpm4)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerNeedleWhite, rpm3)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerNeedleWhite, rpm2)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerNeedleWhite, rpm1)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerBG2)
        dxDrawText(getFormattedVehicleGear(), screenWidth - 160, screenHeight - 170, screenWidth - 160, screenHeight - 170, tocolor(255, 255, 255, 255), 1, fontPrototype40, "left", "top", false, false, false)
        dxDrawText("OOO", screenWidth - 160, screenHeight - 115, screenWidth - 160, screenHeight - 115, tocolor(25, 25, 25, 255), 1, fontLCD22, "left", "top", false, false, false)
        dxDrawText("***", screenWidth - 160, screenHeight - 115, screenWidth - 160, screenHeight - 115, tocolor(25, 25, 25, 255), 1, fontLCD22, "left", "top", false, false, false)
        dxDrawText(getVehicleSpeedString(), screenWidth - 160, screenHeight - 115, screenWidth - 160, screenHeight - 115, tocolor(255, 255, 255, 255), 1, fontLCD22, "left", "top", false, false, false)
        dxDrawText("km/h", screenWidth - 110, screenHeight - 95, screenWidth - 110, screenHeight - 95, tocolor(255, 255, 255, 255), 1, fontPrototype10, "left", "top", false, false, false)
        local nsr, nsg, nsb = getNitroStateColor()
        dxDrawImage(screenWidth - 108, screenHeight - 155, 24, 24, nitroState, 0, 0, 0, tocolor(nsr, nsg, nsb, 255), true)
        local csr, csg, csb = getCarStateColor()
        dxDrawImage(screenWidth - 108, screenHeight - 125, 24, 24, carState, 0, 0, 0, tocolor(csr, csg, csb , 255), true)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerOverlay)
        dxDrawImage(roundValue(screenWidth - 270), roundValue(screenHeight - 270), 200, 200, speedometerGlass)
    end
end
addEventHandler("onClientRender", root, speedoMeterGUI)