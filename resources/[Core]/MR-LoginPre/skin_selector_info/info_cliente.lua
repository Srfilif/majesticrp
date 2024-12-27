local WindowSkin = false
local SelectedEditWin = nil
local nacionalidadLabel = "Nacionalidad"
local edadLabel = "Edad"
local sexoLabel = "Sexo"
local r_nacionalidad, g_nacionalidad, b_nacionalidad = 50, 0, 0
local r_edad, g_edad, b_edad = 50, 0, 0
local r_sexo, g_sexo, b_sexo = 50, 0, 0
local skins = getValidPedModels ( )
local count = 0 

local SkinsBloqueados = {
	--Normales
	[217]=true,
	[211]=true,
	--Medicos
	[70]=true,
	[274]=true,
	[275]=true,
	[276]=true,
	[277]=true,
	[278]=true,
	[279]=true,
	--Policias
	[196]=true,
	[71]=true,
	[280]=true,
	[281]=true,
	[282]=true,
	[283]=true,
	[284]=true,
	[285]=true,
	[286]=true,
	[287]=true,
	[288]=true,
	--
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local screenW, screenH = guiGetScreenSize()
        mainVentanaCreacion = guiCreateWindow(screenW - 319 - 10, (screenH - 543) / 2, 319, 543, " Creacion de Personaje", false)
        guiWindowSetSizable(mainVentanaCreacion, false)
        guiSetVisible(mainVentanaCreacion, false)

        guiLabel1 = guiCreateLabel(10, 27, 299, 154, "- Rellena los datos de la Nacionalidad, Edad, Sexo\n- Recuerda que al cancelar la cuenta se eliminara automaticamente\n- Respeta las normas del servidor o serás sancionado\n- Recuerda poner la edad de mayor de 17 a menor 50\n- Cualquier tipo de nacionalidad menos anti rol\n- Sexo: Masculino o Femenino\nSaludos.", false, mainVentanaCreacion)
        guiSetFont(guiLabel1, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel1, "center", true)
        guiLabel2 = guiCreateLabel(10, 181, 299, 25, "Nacionalidad", false, mainVentanaCreacion)
        guiSetFont(guiLabel2, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel2, "center", true)
        editNacionalidad = guiCreateEdit(10, 206, 299, 36, "", false, mainVentanaCreacion)
        guiLabel3 = guiCreateLabel(10, 252, 299, 25, "Edad", false, mainVentanaCreacion)
        guiSetFont(guiLabel3, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel3, "center", true)
        editEdad = guiCreateEdit(10, 277, 299, 36, "", false, mainVentanaCreacion)
        guiLabel4 = guiCreateLabel(10, 323, 299, 25, "Sexo", false, mainVentanaCreacion)
        guiSetFont(guiLabel4, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel4, "center", true)
        editGenero = guiCreateEdit(10, 348, 299, 36, "", false, mainVentanaCreacion)
        guiLabel5 = guiCreateLabel(10, 390, 299, 25, "Modelo", false, mainVentanaCreacion)
        guiSetFont(guiLabel5, "default-bold-small")
        guiLabelSetHorizontalAlign(guiLabel5, "center", true)
        buttonAtras = guiCreateButton(10, 415, 126, 33, "<<", false, mainVentanaCreacion)
        guiSetFont(buttonAtras, "default-bold-small")
        buttonAdelante = guiCreateButton(183, 415, 126, 33, ">>", false, mainVentanaCreacion)
        guiSetFont(buttonAdelante, "default-bold-small")
        buttonCrear = guiCreateButton(10, 458, 299, 32, "Crear Personaje", false, mainVentanaCreacion)
        guiSetFont(buttonCrear, "default-bold-small")
        buttonCancelar = guiCreateButton(10, 494, 299, 32, "Cancelar Personaje", false, mainVentanaCreacion)
        guiSetFont(buttonCancelar, "default-bold-small")

        addEventHandler("onClientGUIClick", buttonCrear, crearPersonaje, false)
        addEventHandler("onClientGUIClick", buttonCancelar, cancelarCreacion, false)
        addEventHandler("onClientGUIClick", buttonAtras, skinAnterior, false)
        addEventHandler("onClientGUIClick", buttonAdelante, skinPosterior, false)     
    end
)

function crearPersonaje()
	labelNacionalidad = guiGetText(editNacionalidad)
	labelEdad = guiGetText(editEdad)
	labelGenero = guiGetText(editGenero)
	edadMinima, edadMaxima = 17, 50
	if labelNacionalidad ~= "" then
		if (tonumber(labelEdad) or 0) >= tonumber(edadMinima) and (tonumber(labelEdad) or 0) <= tonumber(edadMaxima) then
			if labelGenero:find("Masculino") or labelGenero:find("masculino") or labelGenero:find("femenino") or labelGenero:find("Femenino") then
				triggerServerEvent("Roleplay:SetDatos", localPlayer, labelNacionalidad, labelEdad, labelGenero, localPlayer:getModel())
				setWindowSkin(false)
			else
				triggerEvent("callNotification", localPlayer, "error", "Tienes que elejir un genero - Masculino o Femenino", true)
			end
		else
			triggerEvent("callNotification", localPlayer, "error", "Tienes que tener entre 17 - 50 Años", true)
		end
	else
		triggerEvent("callNotification", localPlayer, "error", "Tienes que ingresar una Nacionalidad", true)
	end
end

function cancelarCreacion()
	triggerServerEvent("Roleplay:CancelarCuenta", localPlayer, getElementData(localPlayer, "Cuenta"), passLabel)
end

function skinAnterior()
	if count ~= 1 then
		count = count - 1
		if skins then
			if not SkinsBloqueados[skins[count]] then
				setElementModel(localPlayer, skins[count])
			end
		end
	end
end

function skinPosterior()
	if count ~= #skins then
		count = count + 1
		if skins then
			if not SkinsBloqueados[skins[count]] then
				setElementModel(localPlayer, skins[count])
			end
		end
	end
end

addEvent("Roleplay:ErrorSkin", true)
addEventHandler("Roleplay:ErrorSkin", root, function()
	r_nacionalidad, g_nacionalidad, b_nacionalidad = 50, 0, 0
	r_edad, g_edad, b_edad = 50, 0, 0
	r_sexo, g_sexo, b_sexo = 50, 0, 0
end)

function setWindowSkin(var)
	tickCount = getTickCount()
	if var == true then
		showChat(false)
		--guiSetInputMode(true)
		showCursor(true)
		guiSetVisible(mainVentanaCreacion, true)
	else
		showChat(true)
		--guiSetInputMode(false)
		showCursor(false)
		guiSetVisible(mainVentanaCreacion, false)
	end
end
addEvent("setWindowSkin", true)
addEventHandler("setWindowSkin", root, setWindowSkin)