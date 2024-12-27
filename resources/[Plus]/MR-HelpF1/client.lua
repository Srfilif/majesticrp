local Pri_Window, Priv_Exit, Pri_Config, Pri_Creditos, Pri_Inv, Pri_Return, Pri_Support
local So_Gui, So_Back, So_HPanel, So_Norm, So_Dis, So_ReBug, So_For, So_ReUser
local screenW, screenH = guiGetScreenSize()

local Pri_WindowVisible = true

local function toggleMainMenu()
    if isElement(So_Gui) and guiGetVisible(So_Gui) then
        guiSetVisible(So_Gui, false)
        showCursor(false)
    else
        Pri_WindowVisible = not Pri_WindowVisible
        guiSetVisible(Pri_Window, Pri_WindowVisible)
        showCursor(Pri_WindowVisible)
    end
end

local function toggleSupportWindow()
soporteGUI()
    guiSetVisible(So_Gui, true)
    showCursor(guiGetVisible(So_Gui))
    Pri_WindowVisible = not guiGetVisible(So_Gui)
    guiSetVisible(Pri_Window,false)
end

function createGUI()
    Pri_Window = guiCreateWindow((screenW - 280) / 2, (screenH - 276) / 2, 280, 276, "Menu Principal (F1)", false)
    guiWindowSetSizable(Pri_Window, false)
    guiSetAlpha(Pri_Window, 0.90)
    Priv_Exit = guiCreateButton(29, 245, 225, 18, "Salir del servidor...", false, Pri_Window)
    guiSetFont(Priv_Exit, "default-bold-small")
    Pri_Config = guiCreateButton(29, 96, 221, 17, "Configuración", false, Pri_Window)
    Pri_Creditos = guiCreateButton(29, 123, 221, 18, "Créditos", false, Pri_Window)
    guiSetFont(Pri_Creditos, "default-bold-small")
    guiSetProperty(Pri_Creditos, "NormalTextColour", "FFF5D609")
    Pri_Inv = guiCreateButton(29, 151, 221, 17, "Inventario", false, Pri_Window)
    Pri_Return = guiCreateButton(29, 36, 221, 17, "Volver al juego", false, Pri_Window)
    Pri_Support = guiCreateButton(29, 178, 221, 17, "Soporte", false, Pri_Window)
    guiSetProperty(Pri_Support, "NormalTextColour", "FF00FF00")
        guiSetVisible(Pri_Window, false)
    
    


addEventHandler("onClientGUIClick", Pri_Config, function()
    outputChatBox("#ff3d3d* Esta característica está en mantenimiento...", 255, 0, 0, true)   
        end,false)
addEventHandler("onClientGUIClick", Pri_Creditos, function()
    outputChatBox("#ff3d3d* Esta característica está en mantenimiento...", 255, 0, 0, true)   
        end,false)
addEventHandler("onClientGUIClick", Pri_Inv, function()
    outputChatBox("#ff3d3d* Esta característica está en mantenimiento...", 255, 0, 0, true)   
        end,false)
  
    addEventHandler("onClientGUIClick", Pri_Support, toggleSupportWindow, false)
        addEventHandler("onClientGUIClick", Pri_Return, function ()
            guiSetVisible(So_Gui, false)
            guiSetVisible(Pri_Window, false)
             showCursor(false)
        end,false)
addEventHandler("onClientGUIClick", Priv_Exit, function ()
    -- Muestra el mensaje
    outputChatBox("#ff3d3d* En 5 Segundos seras expulsado de Majestic Roleplay", 255, 0, 0,true)

    -- Crea un temporizador para ejecutar la acción después de 5 segundos
    setTimer(function()
        -- Oculta la interfaz actual

        -- Kickea al jugador con el motivo especificado
        triggerServerEvent("MajesticF1:SalirServidor", localPlayer, "Has Salido de Majestic Roleplay")
    end, 5000, 1)
end,false)
end

bindKey("F1", "down", toggleMainMenu)

createGUI()

function soporteGUI(player, cmd)
    if isElement(So_Gui) and guiGetVisible(So_Gui) then
        -- Si la ventana está visible, la ocultamos
        guiSetVisible(So_Gui, false)
        showCursor(false)
        if cmd then
            guiSetVisible(Pri_Window, Pri_WindowVisible)
            showCursor(Pri_WindowVisible)
        end
    else
        -- Si la ventana no está visible, la mostramos
        So_Gui = guiCreateWindow((screenW - 280) / 2, (screenH - 276) / 2, 280, 276, "Soporte (F1)", false)
        guiWindowSetSizable(So_Gui, false)
        guiSetAlpha(So_Gui, 0.90)

        So_Back = guiCreateButton(29, 245, 225, 18, "Volver atrás..", false, So_Gui)
        guiSetFont(So_Back, "default-bold-small")
        So_HPanel = guiCreateButton(29, 112, 221, 17, "Panel de Ayuda", false, So_Gui)
        guiSetFont(So_HPanel, "clear-normal")
        So_Norm = guiCreateButton(29, 139, 221, 18, "Normativa General", false, So_Gui)
        guiSetFont(So_Norm, "clear-normal")
        guiSetProperty(So_Norm, "NormalTextColour", "C8FFFFFF")
        So_Dis = guiCreateButton(29, 167, 221, 17, "Copiar URL de discord", false, So_Gui)
        So_ReBug = guiCreateButton(29, 36, 221, 17, "Reportar un Bug", false, So_Gui)
        So_For = guiCreateButton(29, 194, 221, 17, "Copiar URL de Foro", false, So_Gui)
        So_ReUser = guiCreateButton(29, 63, 221, 17, "Reportar a un Usuario", false, So_Gui)

        guiSetVisible(So_Gui, true)
        guiSetVisible(Pri_Window, false)
        showCursor(true)

        addEventHandler("onClientGUIClick", So_Back, function ()
            guiSetVisible(So_Gui, false)
            guiSetVisible(Pri_Window, true)
        end)
        
        addEventHandler("onClientGUIClick", So_Back, function ()
            guiSetVisible(So_Gui, false)
            guiSetVisible(Pri_Window, true)
        end)
        addEventHandler("onClientGUIClick", So_Back, function ()
            guiSetVisible(So_Gui, false)
            guiSetVisible(Pri_Window, true)
        end)
        addEventHandler("onClientGUIClick", So_Back, function ()
            guiSetVisible(So_Gui, false)
            guiSetVisible(Pri_Window, true)
        end)
        
    end
end

addCommandHandler("soporte", soporteGUI)

local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second

local monthday = time.monthday
local month = time.month
local year = time.year
local EnMeno = false
local formattedTime = string.format('%02d/%02d/%02d - %02d:%02d:%02d', monthday, month + 1, year + 1900, hours, minutes, seconds)
local ReBug_Window = nil -- Declarar la ventana como una variable global para que pueda ser accedida desde cualquier parte del código

local antiSpamBug  = {} 
function rebug()
local Jugador = getLocalPlayer()
    		local tick = getTickCount()

		if (antiSpamBug[Jugador] and antiSpamBug[Jugador][1] and tick - antiSpamBug[Jugador][1] < 60000) then

			outputChatBox("#FFff3d* Espera un poco antes de usar de nuevo este comando.", 150, 0, 0,true)

			return

		end
if ReBug_Window and isElement(ReBug_Window) then -- Verificar si la ventana ya está abierta
    local isVisible = guiGetVisible(ReBug_Window)
    guiSetVisible(ReBug_Window, not isVisible) -- Alternar la visibilidad de la ventana
    if isVisible then
        showCursor(false) -- Ocultar el cursor si la ventana se cierra
    else
        showCursor(true) -- Mostrar el cursor si la ventana se abre
    end
    return -- Salir de la función si la ventana ya está abierta
end
local screenW, screenH = guiGetScreenSize()
ReBug_Window = guiCreateWindow((screenW - 525) / 2, (screenH - 497) / 2, 525, 497, "Reportar un Bug", false)
guiWindowSetSizable(ReBug_Window, false)
guiSetAlpha(ReBug_Window, 0.90)

ReBug_LAbel = guiCreateLabel(10, 24, 505, 165, "Este panel sirve para reportar bugs a los desarrolladores del servidor. No reportes pérdida de bienes, cuentas, personajes ni tampoco bugs del motor de juego.\n\nCon este panel puedes informar a los desarrolladores que hay un bug con un sistema o funcionalidad del servidor. Por ejemplo, puedes reportar que un botón no está funcionando como se debe, que hay una forma de duplicar bienes, que ciertos elementos del HUD no se están viendo correctamente, un bajón de FPS desde la última actualización o cualquier otra cosa relacionada con el desarrollo del servidor.\n\nSi sabes una forma de replicar el bug, por favor, haznoslo saber y trata de explicar el bug de la forma más sencilla posible para que podamos solucionarlo pronto. Muchas gracias", false, ReBug_Window)
guiLabelSetHorizontalAlign(ReBug_LAbel, "center", true)
ReBug_Memo = guiCreateMemo(10, 199, 505, 255, "Escribe aquí explicando tu reporte. Trata de colocar una lista de pasos para replicarlo (volverlo a hacer y así poder arreglarlo).", false, ReBug_Window)
ReBug_Cancel = guiCreateButton(20, 466, 147, 21, "Cancelar", false, ReBug_Window)
ReBug_Send = guiCreateButton(358, 466, 147, 21, "Enviar reporte", false, ReBug_Window)
   showCursor(true)

        addEventHandler("onClientGUIClick", ReBug_Cancel, function ()
            guiSetVisible(ReBug_Window, false)
 EnMeno = false
   showCursor(false)
          
        end,false)
        addEventHandler("onClientGUIClick", ReBug_Memo, function ()
            if EnMeno == false then
                
           guiSetText ( ReBug_Memo, "" )
          EnMeno = true
  end        
        end,false)
                 
                 addEventHandler("onClientGUIClick", ReBug_Send, function()
        local contenidoReporte = guiGetText(ReBug_Memo)
            local Nombre = getPlayerName(localPlayer)
    if string.len(contenidoReporte) < 50 then
        outputChatBox("#ff3d3d* El contenido de reporte no puede ser tan pequeño (Mi)", 255, 255, 255, true)
        return -- Salir de la función si el reporte no tiene al menos 50 caracteres
    end
        triggerServerEvent('MajesticF1:SendReport', localPlayer, "https://discord.com/api/webhooks/1203785941286649996/Wtie-4TcbbVnrHwJSpGUY0zT5sLSpZ-Mlo71dRscwSrxT5yWlnJLR94PevVL2Kek3oMi", '```'..contenidoReporte..'```',Nombre,formattedTime)
    outputChatBox("#3ec9f0[REPORTES] #ffFFffHas enviado un reporte a nuestro equipo de #76f03eDesarollo #ffFFfflo revisaremos lo antes posible", 255, 0, 0, true)   

   EnMeno = false
    end, false)
end

addCommandHandler("rebug", rebug)


local ReUsu_GUI = nil -- Declarar la ventana como una variable global para que pueda ser accedida desde cualquier parte del código




function reusu()
local Jugador = getLocalPlayer()
    		local tick = getTickCount()

		if (antiSpamBug[Jugador] and antiSpamBug[Jugador][1] and tick - antiSpamBug[Jugador][1] < 60000) then

			outputChatBox("#FFff3d* Espera un poco antes de usar de nuevo este comando.", 150, 0, 0,true)

			return

		end
if ReUsu_GUI and isElement(ReUsu_GUI) then -- Verificar si la ventana ya está abierta
    local isVisible = guiGetVisible(ReUsu_GUI)
    guiSetVisible(ReUsu_GUI, not isVisible) -- Alternar la visibilidad de la ventana
    if isVisible then
        showCursor(false) -- Ocultar el cursor si la ventana se cierra
    else
        showCursor(true) -- Mostrar el cursor si la ventana se abre
    end
    return -- Salir de la función si la ventana ya está abierta
end


local screenW, screenH = guiGetScreenSize()
ReUsu_GUI = guiCreateWindow((screenW - 500) / 2, (screenH - 337) / 2, 500, 337, "Reporta algo a los miembros de Staff", false)
guiWindowSetSizable(ReUsu_GUI, false)

ReUsu_Label = guiCreateLabel(10, 40, 481, 191, "!¿Alguien está antiroleando en este mismo instante? ¿Están haciendo DM? ¿Crees que hay una banda realizando MG? ¿Estás bugueado en un interior y no te salva el /desbug? Entonces envía un reporte con toda la información necesaria (Nombre de los usuarios y regla incumplida). De ser válido, el staff lo tomará.\n\nProcura no enviar reportes sobre cosas que ya pasaron y que no se pueden comprobar en el momento (Estafas, DM anteriores o cosas que pasaron hace más de 5 minutos). Todos esos reportes deben ir al Discord con sus respectivas pruebas para ser validados.\n\nEsta vía de comunicación solo está abierta para cosas que están pasando AHORA MISMO. Todo lo que no esté ocurriendo ahora deberás reportarlo en nuestro Discord.", false, ReUsu_GUI)
guiLabelSetHorizontalAlign(ReUsu_Label, "center", true)
ReUsu_Edit = guiCreateEdit(10, 246, 481, 26, "Escribe aqui tu reporte...", false, ReUsu_GUI)
ReUsu_Send = guiCreateButton(263, 282, 222, 45, "Enviar reporte", false, ReUsu_GUI)
ReUsu_Cancel = guiCreateButton(18, 301, 221, 26, "Mejor en otro momento...", false, ReUsu_GUI)

   showCursor(true)

        addEventHandler("onClientGUIClick", ReUsu_Cancel, function ()
            guiSetVisible(ReUsu_GUI, false)
   showCursor(false)
          
        end,false)


                 addEventHandler("onClientGUIClick", ReUsu_Send, function()
        local contenidoReporte = guiGetText(ReUsu_Edit)
            local Nombre = getPlayerName(localPlayer)
    if string.len(contenidoReporte) < 50 then
        outputChatBox("#ff3d3d* El contenido de reporte no puede ser tan pequeño (Min.50)", 255, 255, 255, true)
        return -- Salir de la función si el reporte no tiene al menos 50 caracteres
    end
        triggerServerEvent('MajesticF1:SendReportUsu', localPlayer, "https://discord.com/api/webhooks/1204445174550503535/L3lhiTRtavGY3vzEjXn5KR2nghC93FKSzfTPgjDK32j7UAxAbj7PF7Ns1n8Cy9eVXEe-",contenidoReporte,Nombre,formattedTime)
    outputChatBox("#3ec9f0[REPORTES] #ffFFffHas enviado un reporte a nuestro equipo de #ffe458Staff #ffFFfflo revisaremos lo antes posible", 255, 0, 0, true)   
       guiSetVisible(ReUsu_GUI, false)
   showCursor(false)
   guiSetText(ReUsu_Edit,"Escribe aqui tu reporte...")

    end, false)
end

addCommandHandler("re", reusu)






