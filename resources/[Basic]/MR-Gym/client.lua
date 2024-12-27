addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local screenW, screenH = guiGetScreenSize()
        ventanaGym = guiCreateWindow((screenW - 380) / 2, (screenH - 400) / 2, 380, 400, " Mesa de Trabajo", false)
        guiWindowSetSizable(ventanaGym, false)
        guiSetVisible(ventanaGym, false)

        listaEstilos = guiCreateGridList(9, 23, 361, 305, false, ventanaGym)
        guiGridListAddColumn(listaEstilos, "Estilos", 0.6)
        guiGridListAddColumn(listaEstilos, "ID", 0.3)
        botonCambiar = guiCreateButton(10, 332, 360, 26, "Cambiar Estilo", false, ventanaGym)
        guiSetFont(botonCambiar, "default-bold-small")
        guiSetProperty(botonCambiar, "NormalTextColour", "FFAAAAAA")
        botonCerrar = guiCreateButton(10, 358, 360, 26, "Cerrar", false, ventanaGym)
        guiSetFont(botonCerrar, "default-bold-small")
        guiSetProperty(botonCerrar, "NormalTextColour", "FFAAAAAA")  

        addEventHandler("onClientGUIClick", botonCambiar, cambiarEstilo, false)
        addEventHandler("onClientGUIClick", botonCerrar, accionarGym, false) 
    end
)

function accionarGym()
    if guiGetVisible(ventanaGym) == true then
        guiSetVisible(ventanaGym, false)
        showCursor(false)
    else
        guiSetVisible(ventanaGym, true)
        showCursor(true)
    end
end
addEvent("POPLife:accionarGym", true)
addEventHandler("POPLife:accionarGym", root, accionarGym)

function cambiarEstilo()
    local id = guiGridListGetItemText(listaEstilos, guiGridListGetSelectedItem(listaEstilos), 2)
    if id ~= "" then
    	triggerServerEvent("POPLife:cambiarEstilo", getLocalPlayer(), id)
    else
    	outputChatBox("* Selecciona un estilo de la lista para continuar", 255, 200, 0)
    end
end

local tablaEstilos = {
	{"Estandar", "4"},
	{"Boxeador", "5"},
	{"Kung Fu", "6"},
	{"Rodillas en la Cabeza", "7"},
	{"Agarrar y Patear", "15"},
	{"Con los Codos", "16"},
}

function agregarEstilos()
    local row = guiGridListAddRow(listaEstilos)
    guiGridListSetItemText(listaEstilos, row, 1, "Estilos de Pelea", true, false)
    for i, k in ipairs(tablaEstilos) do
        local row = guiGridListAddRow(listaEstilos)
        guiGridListSetItemText(listaEstilos, row, 1, tostring(k[1]), false, false)
        guiGridListSetItemText(listaEstilos, row, 2, tostring(k[2]), false, false)
    end
end
addEventHandler("onClientResourceStart", resourceRoot, agregarEstilos)