

-- Variables globales
local stateDrawShop = false
local currentSkinIndex = 1
local originalSkin
local player = getLocalPlayer()
local filteredSkins = {}
local sx, sy = guiGetScreenSize()
local zoom = math.min(1, 1920 / sx)
local NombreTienda = "Tienda Ropa"
-- Fuentes y texturas
local font_bold_define = dxCreateFont("files/calibri_bold.ttf", 34 / zoom)
local font_default_14 = dxCreateFont("files/calibri_default.ttf", 14 / zoom)
local bArrowLeft = dxCreateTexture("files/left.png", "argb", true, "clamp")
local bArrowRight = dxCreateTexture("files/right.png", "argb", true, "clamp")

-- Función para filtrar skins por género
function filterSkinsByGender(gender)
    local result = {}
    for _, skin in ipairs(skins) do
        if skin.gender == gender then
            table.insert(result, skin)
        end
    end
    return result
end

-- Crear la tienda de skins

function AbrirV(nombre)
    if Panel then
        stateDrawShop = false
        showCursor(false)
    else
        createSkinShop()
        stateDrawShop = true
        NombreTienda = nombre

        showCursor(true)
    end
end
addEvent("[LS]Tiendas:Ropa", true)
addEventHandler("[LS]Tiendas:Ropa", root, AbrirV)

function createSkinShop()
    stateDrawShop = true
    startVignette(true)
    triggerEvent("removeHudPlayer", localPlayer)
    setPlayerHudComponentVisible("radar", false)
    setPlayerHudComponentVisible("all", false)
    originalSkin = getElementModel(localPlayer)

    -- Filtrar skins por género
    local playerGender = getElementData(localPlayer, "Sexo") or "Masculino" -- 0 = Masculino, 1 = Femenino

  if playerGender == "Masculino" then
    playerGender = 0
  else
    playerGender = 1

  end
    filteredSkins = filterSkinsByGender(playerGender)

    if #filteredSkins == 0 then
        outputChatBox("No hay skins disponibles para tu género.", 255, 0, 0)
        stateDrawShop = false
        return
    end

    showCursor(true)
    showChat(false)

    -- Encontrar índice del skin más cercano al actual
    currentSkinIndex = 1
    for index, skin in ipairs(filteredSkins) do
        if skin.id == originalSkin then
            currentSkinIndex = index
            break
        end
    end
end


-- Función para cambiar la skin
function changeSkin(direction)
    if not stateDrawShop then return end
    currentSkinIndex = (currentSkinIndex + direction - 1) % #filteredSkins + 1
    setElementModel(player, filteredSkins[currentSkinIndex].id)
end

-- Función para comprar la skin
function buySkin()
    if not stateDrawShop then return end
    local skin = filteredSkins[currentSkinIndex]
    local playerMoney = getPlayerMoney(player)

    if playerMoney >= skin.price then
      --  takePlayerMoney(player, skin.price)
      --  outputChatBox("Has comprado la skin por $" .. skin.price, 0, 255, 0)
        triggerServerEvent( "TiendaRopa:DarSkin", localPlayer, skin.id, skin.price)
        closeSkinShop()
        originalSkin = skin.id
    stateDrawShop = false
       showCursor(false)
       showChat(true)


    else
        exports["MR-Notify"]:addNotification("No tienes suficiente dinero para comprar esta skin.", "error")

    end
end

-- Función para cerrar la tienda
function closeSkinShop()
    if not stateDrawShop then return end
    setElementModel(player, originalSkin)
    stateDrawShop = false
    showCursor(false)
    showChat(true)
    startVignette(false)

    triggerEvent("addhudPlayer", localPlayer)


end

-- Renderizado de la tienda
addEventHandler("onClientRender", root, function()
    if not stateDrawShop then return end

    -- Título y estadísticas del jugador
    dxDrawText(NombreTienda, 35 / zoom, 25 / zoom, 250 / zoom, 25 / zoom, tocolor(255, 255, 255, 200), 1, font_bold_define, "left", "top")
    dxDrawText("GreenWood Roleplay", 37/zoom, 80/zoom, 250/zoom, 25/zoom, tocolor ( 255, 255, 255, 200 ), 1, font_default_14, "left", "top", false, false, false, true);
    dxDrawText("__________________________", 37/zoom, 90/zoom, 250/zoom, 25/zoom, tocolor ( 255, 255, 255, 50 ), 1, font_default_14, "left", "top", false, false, false, true);
    dxDrawText("Dinero: $" .. convertNumber(getPlayerMoney(player)), 37 / zoom, 114 / zoom, 250 / zoom, 25 / zoom, tocolor(255, 255, 255, 200), 1, font_default_14, "left", "top")
    if dxDrawCursor(sx-125/zoom, 40/zoom, 70/zoom, 70/zoom) then
        dxDrawText("X", sx-125/zoom, 40/zoom, sx-125/zoom+70/zoom, 40/zoom+70/zoom, tocolor ( 90, 150, 255, 150 ), 1, font_bold_define, "center", "center", false, false, false, true);
    else
        dxDrawText("X", sx-125/zoom, 40/zoom, sx-125/zoom+70/zoom, 40/zoom+70/zoom, tocolor ( 255, 255, 255, 100 ), 1, font_bold_define, "center", "center", false, false, false, true);
    end 
    -- Dibujar flechas de navegación
    dxDrawArrow((sx - 450 / zoom) / 2, sy - 100 / zoom, 50 / zoom, 57 / zoom, "<")
    dxDrawArrow((sx + 345 / zoom) / 2, sy - 100 / zoom, 50 / zoom, 57 / zoom, ">")

    -- Botón de compra
    local skin = filteredSkins[currentSkinIndex]
    dxDrawButton((sx - 250 / zoom) / 2, sy - 100 / zoom, 250 / zoom, 52 / zoom, "ADQUIRIR POR\n$" .. convertNumber(skin.price), font_default_14)
end)

-- Funciones auxiliares para renderizado
function dxDrawArrow(x, y, w, h, type)
    local texture = type == "<" and bArrowLeft or bArrowRight
    dxDrawImage(x, y, w, h, texture, 0, 0, 0, tocolor(255, 255, 255, 200), false)
    if dxDrawCursor(x, y, w, h) then
        dxDrawImage(x-2/zoom, y-2/zoom, w+4/zoom, h+4/zoom, texture, 0, 0, 0, tocolor(255, 255, 255, 235), false) 
    else
        dxDrawImage(x, y, w, h, texture, 0, 0, 0, tocolor(255, 255, 255, 200), false)
    end
end

function dxDrawButton(x, y, w, h, text, font)
    local isHover = dxDrawCursor(x, y, w, h)
    local color = isHover and tocolor(90, 150, 255, 180) or tocolor(90, 150, 255, 150)

    dxDrawRectangle(x, y, w, h, color, false)
    dxDrawText(text, x, y, x + w, y + h, tocolor(255, 255, 255, 235), 1, font, "center", "center", false, false, false, true)
end

function convertNumber(number)
    local formatted = tostring(number):reverse():gsub("(%d%d%d)", "%1 "):reverse()
    return formatted:gsub("^ ", "")
end

function dxDrawCursor(x, y, w, h)
    local cx, cy = getCursorPosition()
    if cx and cy then
        local px, py = cx * sx, cy * sy
        return px >= x and px <= x + w and py >= y and py <= y + h
    end
    return false
end


addEventHandler("onClientClick", root, function(button, state, cursorX, cursorY)
    if state == "down" and button == "left" and stateDrawShop then
        -- Detectar clic en flecha izquierda
        if dxDrawCursor((sx - 450/zoom) / 2, sy - 100/zoom, 50/zoom, 57/zoom) then
            changeSkin(-1)
        end

        -- Detectar clic en flecha derecha
        if dxDrawCursor((sx + 345/zoom) / 2, sy - 100/zoom, 50/zoom, 57/zoom) then
            changeSkin(1)
        end
        if dxDrawCursor(sx - 125 / zoom, 40 / zoom, 70 / zoom, 70 / zoom) then
            -- Aquí puedes cerrar la GUI o cambiar el estado de visibilidad
            closeSkinShop()
                end

        -- Detectar clic en botón de compra
        if dxDrawCursor((sx - 250/zoom) / 2, sy - 100/zoom, 250/zoom, 52/zoom) then
            buySkin()
        end
    end
end)



function dxDrawCursor(x, y, w, h)
    local cursorX, cursorY = getCursorPosition()
    if cursorX and cursorY then
        cursorX, cursorY = cursorX * sx, cursorY * sy
        return cursorX >= x and cursorX <= x + w and cursorY >= y and cursorY <= y + h
    end
    return false
end
