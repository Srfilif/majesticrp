local screenWidth, screenHeight = guiGetScreenSize()
local compassWidth = 200  -- Ancho del compass
local compassHeight = 40   -- Alto del compass
local compassX = (screenWidth - compassWidth) / 2
local compassY = 20

local compassData = {
    {0, "N"},
    {5},
    {10},
    {15},
    {20},
    {25},
    {30},
    {35},
    {40},
    {45},
    {50},
    {55},
    {60},
    {65},
    {70},
    {75},
    {80},
    {85},
    {90, "E"},
    {95},
    {100},
    {105},
    {110},
    {115},
    {120},
    {125},
    {130},
    {135},
    {140},
    {145},
    {150},
    {155},
    {160},
    {165},
    {170},
    {175},
    {180, "S"},
    {185},
    {190},
    {195},
    {200},
    {205},
    {210},
    {215},
    {220},
    {225},
    {230},
    {235},
    {240},
    {245},
    {250},
    {255},
    {260},
    {265},
    {270, "O"},
    {275},
    {280},
    {285},
    {290},
    {295},
    {300},
    {305},
    {310},
    {315},
    {320},
    {325},
    {330},
    {335},
    {340},
    {345},
    {350},
    {360},
}
function drawCompass()
    local show = 15
    local center = math.ceil(show / 2) - 1
    local camX, camY, camZ, lookX, lookY, lookZ = getCameraMatrix()
    local camRotation = (180 / math.pi) * -math.atan2(lookX - camX, lookY - camY)
    local pos = math.floor(camRotation / 5)
    local slotwidth = 15
    local smooth = (camRotation - (pos * 5)) / 5 * slotwidth
    local left = (screenWidth - show * slotwidth) / 2
    local bgHeight = 30  -- Reducido la altura del fondo negro

    -- Dibuja el fondo negro detrás de la brújula
    dxDrawRectangle(left, compassY, (show + 2) * slotwidth, bgHeight, tocolor(0, 0, 0, 160))

    for i = 1, show do
        local id = i + pos - center
        if id > #compassData then
            id = id - #compassData
        end
        if id <= 0 then
            id = #compassData - math.abs(id)
        end
        if compassData[id] then
            local alpha = (tonumber(compassData[id][2]) or 0) > 0 and 175 or 255
            if i < center then
                alpha = alpha * (i / center)
            end
            if i > center then
                alpha = alpha * ((show - i) / center)
            end

            if compassData[id][1] == 0 or compassData[id][1] == 90 or compassData[id][1] == 180 or compassData[id][1] == 270 then
                -- Dibuja solo el texto para los ángulos específicos
                dxDrawText(compassData[id][2], left + slotwidth * i - smooth, compassY-5, left + slotwidth * (i + 1) - smooth, compassY + 40, tocolor(0, 0, 0, alpha * 0.5), 1.5, "default-bold", "center", "center")
                dxDrawText(compassData[id][2], left + slotwidth * i - smooth, compassY-5 , left + slotwidth * (i + 1) - smooth, compassY + 40, tocolor(255, 255, 255, alpha), 1.5, "default-bold", "center", "center")
            else if compassData[id][1] == 45 or compassData[id][1] == 135 or compassData[id][1] == 225 or compassData[id][1] == 315 then
                   -- Dibuja líneas más largas para los ángulos específicos
                   dxDrawRectangle(left + slotwidth * i - smooth + (slotwidth / 2 - 2) + 1, compassY + 10 + 1, 2, 12, tocolor(0, 0, 0, alpha * 0.5))
                   dxDrawRectangle(left + slotwidth * i - smooth + (slotwidth / 2 - 2), compassY + 10, 2, 12, tocolor(255, 0, 0, alpha))
            else
                dxDrawRectangle(left + slotwidth * i - smooth + (slotwidth / 2 - 1) + 1, compassY + 10 + 1, 2, 10, tocolor(0, 0, 0, alpha * 0.5))
                dxDrawRectangle(left + slotwidth * i - smooth + (slotwidth / 2 - 1), compassY + 10, 2, 10, tocolor(255, 255, 255, alpha))
            end

        end
        end
    end

    -- Resto del código
end
addEventHandler("onClientRender", root, drawCompass)
