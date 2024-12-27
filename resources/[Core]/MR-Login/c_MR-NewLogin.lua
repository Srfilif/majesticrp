function login()
    local screenW, screenH = guiGetScreenSize()
    login_panel =
        guiCreateWindow((screenW - 264) / 2, (screenH - 299) / 2, 264, 299, "Majestic Roleplay - Login", false)
    guiWindowSetSizable(login_panel, false)

    login_label1 = guiCreateLabel(24, 24, 214, 30,
        "¡Bienvenido a Majestic Roleplay!\nIntroducce tus datos de acceso abajo", false, login_panel)
    guiLabelSetHorizontalAlign(login_label1, "center", false)
    login_label2 = guiCreateLabel(24, 64, 214, 18, "Usuario:", false, login_panel)
    guiSetFont(login_label2, "default-bold-small")
    guiLabelSetHorizontalAlign(login_label2, "center", false)
    login_usuario = guiCreateEdit(46, 82, 177, 17, "", false, login_panel)
    login_label3 = guiCreateLabel(24, 109, 214, 18, "Contraseña:", false, login_panel)
    guiSetFont(login_label3, "default-bold-small")
    guiLabelSetHorizontalAlign(login_label3, "center", false)
    login_pass = guiCreateEdit(43, 127, 177, 17, "", false, login_panel)
    login_action_login = guiCreateButton(63, 154, 143, 38, "INGRESAR", false, login_panel)
    guiSetFont(login_action_login, "default-bold-small")
    guiSetProperty(login_action_login, "NormalTextColour", "FFFFFEFE")
    login_action_register = guiCreateButton(63, 202, 143, 38, "REGISTRARTE", false, login_panel)
    guiSetFont(login_action_register, "default-bold-small")
    guiSetProperty(login_action_register, "NormalTextColour", "FFFFFEFE")
    login_label4 = guiCreateLabel(24, 250, 214, 30, "¿No tienes cuenta?\n¡Registratate aca!", false, login_panel)
    guiLabelSetHorizontalAlign(login_label4, "center", false)

    addEventHandler("onClientGUIClick", login_action_login, login_action_login_click, false)
    addEventHandler("onClientGUIClick", login_action_register, function()
        guiSetVisible(login_panel, false)
        showCursor(false)
        triggerEvent("onShowRegisterPanel", localPlayer) -- Muestra el panel de login (implementa este evento)
    end, false)

end

function login_action_login_click()
    local user = guiGetText(login_usuario)
    local pass = guiGetText(login_pass)

    if user == "" or pass == "" then
        outputChatBox("Por favor, completa todos los campos.", 255, 0, 0)
        exports["MR-InfoBox"]:addNotification("Por favor rellena todos los campos.", "error")

        return
    end

    -- Enviar datos al servidor
    triggerServerEvent("onPlayerAttemptLogin", localPlayer, user, pass)

end

function login_action_register_click()
    outputChatBox("Función de registro aún no implementada.", 255, 255, 0)
end

addEvent("onLoginResponse", true)
addEventHandler("onLoginResponse", root, function(success, message)
    outputChatBox(message, 255, 255, 255)
    if success then
        guiSetVisible(login_panel, false)
        showCursor(false)
    end
end)

--[[
addEvent("onReceiveCharacters", true)
addEventHandler("onReceiveCharacters", root, 
    function(characters)
        if #characters > 0 then
            outputChatBox("Personajes disponibles:")
            for _, character in ipairs(characters) do
                outputChatBox(character.nombre_apellido .. " - Nivel: " .. character.nivel)
            end
        else
            outputChatBox("No tienes personajes asociados a esta cuenta.")
        end
    end
)
]]

addEvent("onShowLoginPanel", true)
addEventHandler("onShowLoginPanel", root, function()
    login()
    guiSetVisible(login_panel, true)
    showCursor(true)
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
    -- Posición y rotación de la cámara
    local posX, posY, posZ = 2084.5732421875, -1746.6220703125, 24.357080459595
    local rotX, rotY, rotZ = 2087.857421875, -1807.5068359375, 13.546875

    -- Configurar la cámara en la posición aérea
    setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)

    fadeCamera(true, 2) -- Fades in the camera over 1 second

    -- Mostrar el panel de inicio de sesión
    triggerEvent("onShowLoginPanel", localPlayer)
    triggerEvent("removeHudPlayer", localPlayer)
    setPlayerHudComponentVisible("radar", false)
    setPlayerHudComponentVisible("all", false)
    showChat(false)

end)

function registro()
    local screenW, screenH = guiGetScreenSize()
    registro_panel = guiCreateWindow((screenW - 264) / 2, (screenH - 393) / 2, 264, 393, "Majestic Roleplay - Registro",
        false)
    guiWindowSetSizable(registro_panel, false)

    local label1 = guiCreateLabel(24, 24, 214, 30,
        "¡Bienvenido a Majestic Roleplay!\nIntroduce tus datos de acceso abajo", false, registro_panel)
    guiLabelSetHorizontalAlign(label1, "center", false)

    local label2 = guiCreateLabel(24, 64, 214, 18, "Usuario:", false, registro_panel)
    guiSetFont(label2, "default-bold-small")
    guiLabelSetHorizontalAlign(label2, "center", false)
    local usuario = guiCreateEdit(46, 82, 177, 17, "", false, registro_panel)

    local label3 = guiCreateLabel(24, 109, 214, 18, "Contraseña:", false, registro_panel)
    guiSetFont(label3, "default-bold-small")
    guiLabelSetHorizontalAlign(label3, "center", false)
    local contrasena = guiCreateEdit(43, 127, 177, 17, "", false, registro_panel)
    guiEditSetMasked(contrasena, true)

    local label5 = guiCreateLabel(24, 154, 214, 18, "Repetir Contraseña:", false, registro_panel)
    guiSetFont(label5, "default-bold-small")
    guiLabelSetHorizontalAlign(label5, "center", false)
    local repetir_contrasena = guiCreateEdit(43, 177, 177, 17, "", false, registro_panel)
    guiEditSetMasked(repetir_contrasena, true)

    local label6 = guiCreateLabel(24, 204, 214, 18, "E-Mail:", false, registro_panel)
    guiSetFont(label6, "default-bold-small")
    guiLabelSetHorizontalAlign(label6, "center", false)
    local email = guiCreateEdit(43, 227, 177, 17, "", false, registro_panel)

    local btn_registro = guiCreateButton(63, 254, 143, 34, "TERMINAR REGISTRO", false, registro_panel)
    guiSetFont(btn_registro, "default-bold-small")
    guiSetProperty(btn_registro, "NormalTextColour", "FFFFFEFE")

    local btn_ingresar = guiCreateButton(63, 298, 143, 38, "INGRESAR", false, registro_panel)
    guiSetFont(btn_ingresar, "default-bold-small")
    guiSetProperty(btn_ingresar, "NormalTextColour", "FFFFFEFE")

    local label4 = guiCreateLabel(24, 346, 214, 30, "¿Ya tienes una cuenta?\n¡Ingresa acá!", false, registro_panel)
    guiLabelSetHorizontalAlign(label4, "center", false)

    addEventHandler("onClientGUIClick", btn_registro, function()
        local user = guiGetText(usuario)
        local pass = guiGetText(contrasena)
        local pass_repeat = guiGetText(repetir_contrasena)
        local mail = guiGetText(email)

        if user == "" or pass == "" or pass_repeat == "" or mail == "" then
            outputChatBox("Por favor, completa todos los campos.", 255, 0, 0)
            exports["MR-InfoBox"]:addNotification("Por favor rellena todos los campos.", "info")

            return
        end

        if pass ~= pass_repeat then
            outputChatBox("Las contraseñas no coinciden.", 255, 0, 0)
            exports["MR-InfoBox"]:addNotification("Las contraseñas no coinciden.", "error")

            return
        end

        triggerServerEvent("onPlayerRegister", localPlayer, user, pass, mail)
    end, false)

    addEventHandler("onClientGUIClick", btn_ingresar, function()
        guiSetVisible(registro_panel, false)
        showCursor(false)
        triggerEvent("onShowLoginPanel", localPlayer) -- Muestra el panel de login (implementa este evento)
    end, false)

end
addCommandHandler("registro", registro)
addEvent("onShowRegisterPanel", true)
addEventHandler("onShowRegisterPanel", root, function()
    registro()
    guiSetVisible(registro_panel, true)
    showCursor(true)
end)

addEvent("onRegisterResponse", true)
addEventHandler("onRegisterResponse", root, function(success, message)
    outputChatBox(message, 255, 255, 255)
    if success then
        guiSetVisible(registro_panel, false)
        showCursor(false)
        triggerEvent("onShowLoginPanel", localPlayer) -- Muestra el panel de login
    end
end)

GUIEditor = {
    button = {},
    window = {},
    label = {},
    edit = {}
}

-- Función para crear el selector de personajes
function showCharacterSelector(characters)
    local screenW, screenH = guiGetScreenSize()

    -- Crear ventanas para cada personaje
    for i, character in ipairs(characters) do
        local xPos = 0.10 + (i - 1) * 0.30 -- Posición X para cada ventana (izquierda, centro, derecha)
        GUIEditor.window[i] = guiCreateWindow(xPos, 0.30, 0.15, 0.40, "Personaje " .. i, true)
        guiWindowSetSizable(GUIEditor.window[i], false)
        guiWindowSetMovable(GUIEditor.window[i], false)
       

       
        local imagenpj = guiCreateStaticImage(19, 27, 255, 255, "images/skins/"..character.Skin..".png", false,
            GUIEditor.window[i])
        local labelName = guiCreateLabel(19, 282, 255, 26,
            character.nombre_apellido .. " (Nivel " .. character.nivel .. ")", false, GUIEditor.window[i])
        guiSetFont(labelName, "default-bold-small")
        guiLabelSetColor(labelName, 244, 208, 10)
        guiLabelSetHorizontalAlign(labelName, "center", false)
        guiLabelSetVerticalAlign(labelName, "center")

        local labelMoney = guiCreateLabel(19, 308, 255, 60, "Salud: 50%\nChaleco: 100%\nJail OCC: NO\nPrision: NO",
            false, GUIEditor.window[i])
        guiLabelSetHorizontalAlign(labelMoney, "center", false)
        guiLabelSetVerticalAlign(labelMoney, "center")
        local selectButton = guiCreateButton(65, 385, 155, 34, "INGRESAR", false, GUIEditor.window[i])
        guiSetFont(selectButton, "default-bold-small")

        local title = guiCreateLabel(0.05, 0.05, 0.90, 0.10, "Selecciona tu personaje para continuar", true,
            GUIEditor.window[i])
        guiSetFont(title, "default-bold-small")
        guiLabelSetHorizontalAlign(title, "center", false)

        -- Mostrar información del personaje

        -- Botón para seleccionar el personaje

        -- Manejar clic en el botón de ingreso
        addEventHandler("onClientGUIClick", selectButton, function()
            triggerServerEvent("onPlayerSelectCharacter", localPlayer, character.id)
        end, false)
    end

    -- Crear botón para nuevo personaje si hay menos de 4 personajes
    if #characters <= 3 then
        GUIEditor.window[4] = guiCreateWindow(0.10 + (#characters * 0.30), 0.30, 0.15, 0.40, "Nuevo Personaje", true)
        guiWindowSetSizable(GUIEditor.window[4], false)

        local createLabel = guiCreateLabel(0.05, 0.05, 0.90, 0.10, "Crear Nuevo Personaje", true, GUIEditor.window[4])
        guiSetFont(createLabel, "default-bold-small")
        guiLabelSetHorizontalAlign(createLabel, "center", false)

        local crearpjb = guiCreateButton(0.10, 0.80, 0.80, 0.10, "Crear Personaje", true, GUIEditor.window[4])
        -- Manejar el evento de clic del botón
        addEventHandler("onClientGUIClick", crearpjb, crearpj, false)
    end

    -- Mensaje si no hay personajes
    if #characters == 0 then
        local noCharacterLabel = guiCreateLabel(0.05, 0.50, 0.90, 0.10, "No tienes personajes creados.", true,
            GUIEditor.window[1])
        guiLabelSetHorizontalAlign(noCharacterLabel, "center", false)
        return
    end
    
end
local newCharacterWindow -- Variable para almacenar la ventana de creación de personajes
local currentSkinIndex = 2 -- Índice del skin actual
local skins = {
    0,   1,  2,    3,   4,   5,   6,  7,    8,   9,
   10,  11,  12,  13,  14,  15,  16,  17,  18,  19,
   20,  21,  22,  23,  24,  25,  26,  27,  28,  29,
   30,  31,  32,  33,  34,  35,  36,  37,  38,  39,
   40,  41,  42,  43,  44,  45,  46,  47,  48,  49,
   50,  51,  52,  53,  54,  55,  56,  57,  58,  59,
   60,  61,  62,  63,  64,  65,  66,  67,  68,  69,
   70,  71,  72,  73,       75,  76,  77,  78,  79,     
   80,  81,  82,  83,  84,  85,  86,  87,  88,  89,
   90,  91,  92,  93,  94,  95,  96,  97,  98,  99,
  100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
  110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
  120, 121, 122, 123, 124, 125, 126, 127, 128, 129,
  130, 131, 132, 133, 134, 135, 136, 137, 138, 139,
  140, 141, 142, 143, 144, 145, 146, 147, 148,     
  150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
  160, 161, 162, 163, 164, 165, 166, 167, 168, 169,
  170, 171, 172, 173, 174, 175, 176, 177, 178, 179,
  180, 181, 182, 183, 184, 185, 186, 187, 188, 189,
  190, 191, 192, 193, 194, 195, 196, 197, 198, 199,
  200, 201, 202, 203, 204, 205, 206, 207,      209,
  210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
  220, 221, 222, 223, 224, 225, 226, 227, 228, 229,
  230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
  240, 241, 242, 243, 244, 245, 246, 247, 248, 249,
  250, 251, 252, 253, 254, 255, 256, 257, 258, 259, 
  260, 261, 262, 263, 264, 265, 266, 267, 268, 269,
  270, 271, 272, 273, 274, 275, 276, 277, 278, 279,
  280, 281, 282, 283, 284, 285, 286, 287, 288, 289,
  290, 291, 292, 293, 294, 295, 296, 297, 298, 299,
  300, 301, 302, 303, 304, 305, 306, 307, 308, 309,
  310, 311, 312
}
local ped -- Variable para almacenar el ped





function crearpj()
    -- Cerrar el selector de personajes si está abierto
    triggerEvent("onCharacterSelectionSuccess", localPlayer)

    -- Verificar si la ventana de creación de personajes ya está abierta
    if newCharacterWindow then
        outputChatBox("Ya tienes una ventana de creación de personaje abierta.", 255, 0, 0)
        return
    end

    -- Crear una ventana para ingresar datos del nuevo personaje
    crearpj_panel = guiCreateWindow(70, 367, 270, 347, "Creación de Personaje", false)
    guiWindowSetSizable(crearpj_panel, false)

    -- Etiquetas y campos de entrada
    GUIEditor.label[1] = guiCreateLabel(3, 25, 257, 23, "¡A continuación crearás tu personaje!", false, crearpj_panel)
    guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)

    GUIEditor.label[2] = guiCreateLabel(3, 48, 151, 23, "Nombre:", false, crearpj_panel)
    guiSetFont(GUIEditor.label[2], "default-bold-small")
    guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
    GUIEditor.edit[1] = guiCreateEdit(13, 75, 131, 26, "", false, crearpj_panel)

    GUIEditor.label[3] = guiCreateLabel(3, 107, 257, 23, "Nacionalidad:", false, crearpj_panel)
    guiSetFont(GUIEditor.label[3], "default-bold-small")
    guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
    GUIEditor.edit[2] = guiCreateEdit(13, 130, 237, 26, "", false, crearpj_panel)

    GUIEditor.label[4] = guiCreateLabel(3, 160, 257, 23, "Sexo:", false, crearpj_panel)
    guiSetFont(GUIEditor.label[4], "default-bold-small")
    guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
    radiom = guiCreateRadioButton(33, 183, 96, 26, "Masculino", false, crearpj_panel)
    radiof = guiCreateRadioButton(149, 183, 111, 26, "Femenino", false, crearpj_panel)
    guiRadioButtonSetSelected(radiof, true) -- Por defecto, masculino

    GUIEditor.label[5] = guiCreateLabel(154, 48, 106, 23, "Edad:", false, crearpj_panel)
    guiSetFont(GUIEditor.label[5], "default-bold-small")
    guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
    GUIEditor.edit[3] = guiCreateEdit(155, 75, 105, 26, "", false, crearpj_panel)

    GUIEditor.label[6] = guiCreateLabel(3, 209, 257, 23, "==========================", false, crearpj_panel)
    guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)

    GUIEditor.label[7] = guiCreateLabel(3, 232, 151, 23, "Contraseña:", false, crearpj_panel)
    guiSetFont(GUIEditor.label[7], "default-bold-small")
    guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
    GUIEditor.edit[4] = guiCreateEdit(13, 255, 131, 26, "", false, crearpj_panel)
    guiEditSetMasked(GUIEditor.edit[4], true) -- Enmascarar entrada de contraseña

    GUIEditor.label[8] = guiCreateLabel(154, 232, 106, 23, "Repetir Contraseña:", false, crearpj_panel)
    guiSetFont(GUIEditor.label[8], "default-bold-small")
    guiLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
    GUIEditor.edit[5] = guiCreateEdit(154, 255, 105, 26, "", false, crearpj_panel)
    guiEditSetMasked(GUIEditor.edit[5], true) -- Enmascarar entrada de confirmación de contraseña

    -- Botón para crear personaje
    GUIEditor.button[1] = guiCreateButton(76, 296, 123, 39, "CREAR PERSONAJE", false, crearpj_panel)
    guiSetFont(GUIEditor.button[1], "default-bold-small")
    guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFFFFFF")
     leftArrow = guiCreateButton(0.42, 0.89, 0.02, 0.04, "<", true)
     rightArrow = guiCreateButton(0.56, 0.89, 0.02, 0.04, ">", true)
    cancelButton = guiCreateButton(0.01, 0.01, 0.07, 0.03, "<-- REGRESAR", true)
    guiSetFont(cancelButton, "default-bold-small")
    guiSetProperty(cancelButton, "NormalTextColour", "FFFF0000")    
    showCursor(true)

    setElementInterior(localPlayer, 1) -- Establecer el interior del jugador a 3

    -- Mover la cámara a las coordenadas especificadas
    setCameraMatrix ( 224.318359375, 1286.47265625, 1083.7380371094,224.193359375, 1292.947265625, 1082.140625)
     
    fadeCamera(true, 2) -- Fades in the camera over 1 second
    ped = createPed(skins[currentSkinIndex], 224.193359375, 1292.947265625, 1082.140625) -- Crear el ped en la posición deseada
    setElementInterior(ped, 1) -- Establecer el interior del ped a 3
    setElementRotation(ped, 0, 0, 180) -- Rotar el ped hacia la izquierda (270 grados en el eje Z)

    
    addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
        local name = guiGetText(GUIEditor.edit[1])
        local nationality = guiGetText(GUIEditor.edit[2])
        local age = tonumber(guiGetText(GUIEditor.edit[3]))
        local password = guiGetText(GUIEditor.edit[4])
        local confirmPassword = guiGetText(GUIEditor.edit[5])
        local genderd = guiRadioButtonGetSelected(radiof)
        
        if  guiRadioButtonGetSelected(radiof) then
             genderc = "Femenino"
            
        else
           genderc = "Masculino"

        end

        -- Validaciones
        if name == "" or nationality == "" or not age or password == "" then
            outputChatBox("Por favor, completa todos los campos correctamente.", 255, 0, 0)
            return
        end

        if password ~= confirmPassword then
            outputChatBox("Las contraseñas no coinciden.", 255, 0, 0)
            return
        end
        if not name:match("(%u%l*_%u%l*)") then
            outputChatBox("Formato de nombre erroneo.", 255, 0, 0)
        
            return
        end
 
        -- Enviar datos al servidor para crear el personaje
        triggerServerEvent("onCreateCharacter", localPlayer, name, age, genderc, nationality,currentSkinIndex , password)

        


    end, false)

    -- Manejar evento de cancelar
    addEventHandler("onClientGUIClick", cancelButton, function()
           triggerEvent("onCharacterCreationFinished",client)

    end, false)



     -- Manejar evento de flecha izquierda
     addEventHandler("onClientGUIClick", leftArrow, function()
         currentSkinIndex = currentSkinIndex - 1
         if currentSkinIndex < 1 then
             currentSkinIndex = #skins -- Volver al último skin
         end
         setElementModel(ped, skins[currentSkinIndex]) -- Cambiar el modelo del ped
     end, false)
     addEventHandler("onClientGUIClick", rightArrow, function()
        currentSkinIndex = currentSkinIndex + 1
        if currentSkinIndex > 312 then
            currentSkinIndex = 1-- Volver al último skin
        end
        setElementModel(ped, skins[currentSkinIndex]) -- Cambiar el modelo del ped
    end, false)
end

-- Evento para ocultar el panel al seleccionar un personaje
addEvent("onCharacterCreationFinished", true)
addEventHandler("onCharacterCreationFinished", root, function()
    destroyElement(newCharacterWindow)
        newCharacterWindow = nil -- Reiniciar la variable
        triggerServerEvent("onCharacterCreation",localPlayer,localPlayer)
         -- Cerrar la ventana
         destroyElement(crearpj_panel)
         destroyElement(leftArrow)
         destroyElement(rightArrow)
         destroyElement(cancelButton)
         destroyElement(ped)
          triggerServerEvent("onCharacterCreation",localPlayer,localPlayer)
          setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
          setElementInterior(localPlayer, 0) -- Establecer el interior del ped a 3
 
          fadeCamera(true, 3) -- Fades in the camera over 1 second
end)



-- Evento para mostrar el selector de personajes
addEvent("onShowCharacterSelector", true)
addEventHandler("onShowCharacterSelector", root, function(characters)
    showCharacterSelector(characters)
    showCursor(true)
end)

-- Evento para ocultar el panel al seleccionar un personaje
addEvent("onCharacterSelectionSuccess", true)
addEventHandler("onCharacterSelectionSuccess", root, function()
    guiSetVisible(GUIEditor.window[1], false)
    guiSetVisible(GUIEditor.window[2], false)
    guiSetVisible(GUIEditor.window[3], false)
    guiSetVisible(GUIEditor.window[4], false)

    showCursor(false)
end)
