local dimensiones = 5
local tiempoTotal = 40
local screenW, screenH = guiGetScreenSize()

local Robos_c = {}
local ganancias = 0 
local roboActivo = false 
                               setTimer(function()
    ganancias = ganancias + math.random(80, 150)
                           end, 2000, 0)
addEventHandler( 'onClientRender', getRootElement(),
function()
        for dim in pairs(Ints) do
            local shop = getElementByID('ShopID_'..dim)
            if isElement(shop) then
                if Robos_c[shop] and Robos_c[shop].count then
                    if (getElementDimension(localPlayer) == dim) and roboActivo then
                           


                            dxDrawText("Tiempo : "..Robos_c[shop].count.." seg ", (screenW * 0.4170)- 1, (screenH * 0.6953)-1, (screenW * 0.5830)-1, (screenH * 0.7227)-1, tocolor(20, 85, 233, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
                            dxDrawText("Tiempo : "..Robos_c[shop].count.." seg ", (screenW * 0.4170)+ 1, (screenH * 0.6953)-1, (screenW * 0.5830)+1, (screenH * 0.7227)-1, tocolor(20, 85, 233, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
                            dxDrawText("Tiempo : "..Robos_c[shop].count.." seg ", (screenW * 0.4170)- 1, (screenH * 0.6953)+1, (screenW * 0.5830)-1, (screenH * 0.7227)+1, tocolor(20, 85, 233, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
                            dxDrawText("Tiempo : "..Robos_c[shop].count.." seg ", (screenW * 0.4170)+ 1, (screenH * 0.6953)+1, (screenW * 0.5830)+1, (screenH * 0.7227)+1, tocolor(20, 85, 233, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
                            dxDrawText("Tiempo : "..Robos_c[shop].count.." seg ", screenW * 0.4170, screenH * 0.6953, screenW * 0.5830, screenH * 0.7227, tocolor(255, 255, 255, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)

							
							
							dxDrawText("Ganancias : $"..ganancias, (screenW * 0.4050) - 1, (screenH * 0.7253) - 1, (screenW * 0.5830) - 1, (screenH * 0.7227) - 1, tocolor(0, 173, 0, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
dxDrawText("Ganancias : $"..ganancias, (screenW * 0.4050) + 1, (screenH * 0.7253) - 1, (screenW * 0.5830) + 1, (screenH * 0.7227) - 1, tocolor(0, 173, 0, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
dxDrawText("Ganancias : $"..ganancias, (screenW * 0.4050) - 1, (screenH * 0.7253) + 1, (screenW * 0.5830) - 1, (screenH * 0.7227) + 1, tocolor(0, 173, 0, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
dxDrawText("Ganancias : $"..ganancias, (screenW * 0.4050) + 1, (screenH * 0.7253) + 1, (screenW * 0.5830) + 1, (screenH * 0.7227) + 1, tocolor(0, 173, 0, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)
dxDrawText("Ganancias : $"..ganancias, screenW * 0.4050, screenH * 0.7253, screenW * 0.5830, screenH * 0.7227, tocolor(255, 255, 255, 255), 1, "bankgothic", "left", "top", false, false, false, false, false)

                        
		dxDrawText("¡Estas robando!", (screenW * 0.2618) - 1, (screenH * 0.0000) - 1, (screenW * 0.7390) - 1, (screenH * 0.0430) - 1, tocolor(20, 85, 233, 255), 1.00, "bankgothic", "center", "top", false, false, false, true, false)
        dxDrawText("¡Estas robando!", (screenW * 0.2618) + 1, (screenH * 0.0000) - 1, (screenW * 0.7390) + 1, (screenH * 0.0430) - 1, tocolor(20, 85, 233, 255), 1.00, "bankgothic", "center", "top", false, false, false, true, false)
        dxDrawText("¡Estas robando!", (screenW * 0.2618) - 1, (screenH * 0.0000) + 1, (screenW * 0.7390) - 1, (screenH * 0.0430) + 1, tocolor(20, 85, 233, 255), 1.00, "bankgothic", "center", "top", false, false, false, true, false)
        dxDrawText("¡Estas robando!", (screenW * 0.2618) + 1, (screenH * 0.0000) + 1, (screenW * 0.7390) + 1, (screenH * 0.0430) + 1, tocolor(20, 85, 233, 255), 1.00, "bankgothic", "center", "top", false, false, false, true, false)
        dxDrawText("¡Estas robando!", screenW * 0.2618, screenH * 0.0000, screenW * 0.7390, screenH * 0.0430, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "top", false, false, false, true, false)
       
  
	               end
                end
            end
        end
    end
)

addEvent('displayTimeRob', true)
addEventHandler('displayTimeRob', localPlayer,
    function(shop, dim)
	ganacias = 0
        local dim = dim
        Robos_c[shop] = Robos_c[shop] or {}

        Robos_c[shop].count = 40
        roboActivo = true
        Robos_c[shop].timer = Timer(
            function(shop) 

                Robos_c[shop].count = Robos_c[shop].count - 1

                if Robos_c[shop].count <= 0 then
                    triggerServerEvent('ShopRobGiveMoney', localPlayer, dim,ganancias)
					ganancias = 0
                    Robos_c[shop].count = false
                    killTimer( sourceTimer )
                end

            end,
        1000,0, shop)
    end
)



function terminarRobo()
    local myDim = localPlayer.dimension
    local shop = getElementByID('ShopID_'..myDim)

    if shop and isElement(shop) and Robos_c[shop] and Robos_c[shop].timer then
        local tiempoRestante = Robos_c[shop].count -- Obtener el tiempo restante del robo
        local tiempoTranscurrido = tiempoTotal - tiempoRestante -- Calcular el tiempo transcurrido

        if tiempoTranscurrido >= 60 then -- Verificar si han pasado al menos 60 segundos (1 minuto)
            local gananciaActual = ganancias -- Guardar la ganancia actual

            -- Cancelar el temporizador del robo
            Robos_c[shop].timer:destroy()
            Robos_c[shop].timer = nil

            -- Notificar al servidor que el robo ha terminado y enviar la cantidad de dinero acumulada
            triggerServerEvent('TerminarRobo', resourceRoot, gananciaActual, myDim)
            ganancias = 0 
            roboActivo = false
			
            outputChatBox('Has terminado el robo y has recibido el dinero acumulado.', 255, 255, 255, true)
        else
            local tiempoFaltante = 60 - tiempoTranscurrido -- Calcular el tiempo restante para completar 1 minuto
            outputChatBox('Debes esperar al menos 1 minuto para terminar el robo. Tiempo restante: ' .. tiempoFaltante .. ' segundos', 255, 255, 255, true)
        end
    else
        outputChatBox('No estás robando ninguna tienda actualmente.', 255, 255, 255, true)
    end
end

addCommandHandler('terminarrobo', terminarRobo)
