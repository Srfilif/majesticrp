addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local screenW, screenH = guiGetScreenSize()
        mainVentana = guiCreateWindow((screenW - 542) / 2, (screenH - 170) / 2, 542, 170, "Flame Roleplay (BETA) - Login", false)
        guiWindowSetSizable(mainVentana, false)

        guiLabel1 = guiCreateLabel(0.01, 0.19, 0.22, 0.21, "Nombre_Apellido:", true, mainVentana)
        guiSetFont(guiLabel1, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel1, "center", true)
        guiLabelSetVerticalAlign(guiLabel1, "center")
        guiLabel2 = guiCreateLabel(0.01, 0.46, 0.22, 0.18, "Contraseña:", true, mainVentana)
        guiSetFont(guiLabel2, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel2, "center", true)
        guiLabelSetVerticalAlign(guiLabel2, "center")
        memo1 = guiCreateEdit(0.24, 0.19, 0.47, 0.21, "", true, mainVentana)
        memo2 = guiCreateEdit(0.24, 0.44, 0.47, 0.21, "", true, mainVentana)
        guiEditSetMasked(memo2, true)
        guardarDatos = guiCreateCheckBox(0.73, 0.21, 0.25, 0.19, "Recordar Datos", true, true, mainVentana)
        guiSetFont(guardarDatos, "default-bold-small")
        mostrarContrasena = guiCreateCheckBox(0.73, 0.46, 0.24, 0.18, "Ocultar Contraseña", true, true, mainVentana)
        guiSetFont(mostrarContrasena, "default-bold-small")
        buttonLogin = guiCreateButton(0.30, 0.71, 0.18, 0.22, "Loguear", true, mainVentana)
        guiSetFont(buttonLogin, "default-bold-small")
        buttonRegister = guiCreateButton(0.49, 0.71, 0.18, 0.22, "Registrarme", true, mainVentana)
        guiSetFont(buttonRegister, "default-bold-small")
        showCursor(true)
        addEventHandler("onClientGUIClick", buttonLogin, loguearJugador, false)
        addEventHandler("onClientGUIClick", buttonRegister, registrarJugador, false)    
    end
)


addEvent("Roleplay:DestroyLogin", true)
addEventHandler("Roleplay:DestroyLogin", root, function()
	guiSetVisible(mainVentana, false)
	showChat(true)
	if isElement(s) then
		stopSound(s)
	end
	showCursor(false)
	setPlayerHudComponentVisible ( "all", true )
	setPlayerHudComponentVisible ( "area_name", false )
end)

function loguearJugador()
	labelUser = guiGetText(memo1)
	labelPass = guiGetText(memo2)
	if labelUser ~= "" or labelUser ~= "Nombre_Apellido" then
		if labelPass ~= "" then
			if labelUser:match("(%u%l*_%u%l*)") then
				triggerServerEvent( "Roleplay:LoginPlayer", localPlayer, labelUser, labelPass, guiCheckBoxGetSelected(guardarDatos))
			else
				triggerEvent("callNotification", localPlayer, "error", "Por favor, la cuenta debe llevar un Nombre_Apellido", true)
			end
		else
			triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su contraseña.", true)
		end
	else
		triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su cuenta.", true)
	end
end

function registrarJugador()
	labelUser = guiGetText(memo1)
	labelPass = guiGetText(memo2)
	if labelUser ~= "" or labelUser ~= "Nombre_Apellido" then
		if labelPass ~= "" then
			if labelUser:match("(%u%l*_%u%l*)") then
				triggerServerEvent( "Roleplay:RegisterPlayer", localPlayer, labelUser, labelPass )
				triggerEvent("callNotification", localPlayer, "info", "Registrado correctamente, ahora tienes que loguear", true)
				setElementData(localPlayer, "Cuenta", labelUser)
			else
				triggerEvent("callNotification", localPlayer, "error", "Por favor, la cuenta debe llevar un Nombre_Apellido", true)
			end
		else
			triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su contraseña.", true)
		end
	else
		triggerEvent("callNotification", localPlayer, "error", "Por favor, ingrese su cuenta.", true)
	end
end

function setMasked()
    if (getElementType(source) == "gui-checkbox") then
        if (guiCheckBoxGetSelected(source)) then
            guiEditSetMasked(memo2, true)
        else
        	guiEditSetMasked(memo2, false)
        end
    end
end
addEventHandler("onClientGUIClick", root, setMasked)

function saveDatas()
	local account, password = loadLoginFromXML()
	if not ( account == "" or password == "") then
		guiCheckBoxSetSelected ( guardarDatos, true )
		guiSetText ( memo1, tostring(account))
	else
		guiCheckBoxSetSelected ( guardarDatos, false )
		guiSetText ( memo1, "")
	end
	if not ( account == "" or password == "") then
		guiCheckBoxSetSelected ( guardarDatos, true )
		guiSetText ( memo2, tostring(password))
	else
		guiCheckBoxSetSelected ( guardarDatos, false )
		guiSetText ( memo2, "")
	end
end
addEventHandler("onClientResourceStart", resourceRoot, saveDatas)

function loadLoginFromXML()
	local xml_save_log_File = xmlLoadFile ("archivos/datos.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("archivos/datos.xml", "login")
	end
	local usernameNode = xmlFindChild (xml_save_log_File, "account", 0)
	local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
	if usernameNode and passwordNode then
		return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
	else
		return "", ""
	end
	xmlUnloadFile ( xml_save_log_File )
end

function saveLoginToXML(account, password)
	local xml_save_log_File = xmlLoadFile ("archivos/datos.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("archivos/datos.xml", "login")
	end
	if (account ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "account", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "account")
		end
		xmlNodeSetValue (usernameNode, tostring(account))
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end     
		xmlNodeSetValue (passwordNode, tostring(password))
	end
	xmlSaveFile(xml_save_log_File)
	xmlUnloadFile (xml_save_log_File)
end
addEvent("POPLife:saveDataToXML", true)
addEventHandler("POPLife:saveDataToXML", getRootElement(), saveLoginToXML)

function resetSaveXML()
	local xml_save_log_File = xmlLoadFile ("archivos/datos.xml")
	if not xml_save_log_File then
		xml_save_log_File = xmlCreateFile("archivos/datos.xml", "login")
	end
	if (account ~= "") then
		local usernameNode = xmlFindChild (xml_save_log_File, "account", 0)
		if not usernameNode then
			usernameNode = xmlCreateChild(xml_save_log_File, "account")
		end
	end
	if (password ~= "") then
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if not passwordNode then
			passwordNode = xmlCreateChild(xml_save_log_File, "password")
		end     
		xmlNodeSetValue (passwordNode, "")
	end
	xmlSaveFile(xml_save_log_File)
	xmlUnloadFile (xml_save_log_File)
end
addEvent("POPLife:resetSaveXML", true)
addEventHandler("POPLife:resetSaveXML", getRootElement(), resetSaveXML)