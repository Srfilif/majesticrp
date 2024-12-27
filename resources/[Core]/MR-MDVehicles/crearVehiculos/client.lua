local vehiculosPatrullaje = {
    {"Ambulance", "416"},
    {"Rancher", "490"},
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local screenW, screenH = guiGetScreenSize()
        ventanaMedico = guiCreateWindow((screenW - 380) / 2, (screenH - 400) / 2, 380, 400, "Garage medico", false)
        guiWindowSetSizable(ventanaMedico, false)
        guiSetVisible(ventanaMedico, false)

        gridListMedico = guiCreateGridList(9, 23, 361, 305, false, ventanaMedico)
        guiGridListAddColumn(gridListMedico, "Arma", 0.6)
        guiGridListAddColumn(gridListMedico, "ID", 0.3)
        buttonObtener = guiCreateButton(10, 332, 360, 26, "Comprar", false, ventanaMedico)
        guiSetFont(buttonObtener, "default-bold-small")
        guiSetProperty(buttonObtener, "NormalTextColour", "FFAAAAAA")
        buttonCerrar = guiCreateButton(10, 358, 360, 26, "Cerrar", false, ventanaMedico)
        guiSetFont(buttonCerrar, "default-bold-small")
        guiSetProperty(buttonCerrar, "NormalTextColour", "FFAAAAAA")   
    end
)

function abrirVehiculosMedico()
    if guiGetVisible(ventanaMedico) == true then
        guiSetVisible(ventanaMedico, false)
        showCursor(false)
    else
        guiSetVisible(ventanaMedico, true)
        showCursor(true)
    end
end
addEvent("PoPLife:abrirVehiculosMedico", true)
addEventHandler("PoPLife:abrirVehiculosMedico", root, abrirVehiculosMedico)

function agregarVehiculos()
    local row = guiGridListAddRow(gridListMedico)
    guiGridListSetItemText(gridListMedico, row, 1, "Servicio", true, false)
    for i, k in ipairs(vehiculosPatrullaje) do
        local row = guiGridListAddRow(gridListMedico)
        guiGridListSetItemText(gridListMedico, row, 1, tostring(k[1]), false, false)
        guiGridListSetItemText(gridListMedico, row, 2, tostring(k[2]), false, false)
    end
end
addEventHandler("onClientResourceStart", resourceRoot, agregarVehiculos)

addEventHandler("onClientGUIClick", guiRoot,
	function()
		if source == buttonObtener then
			local itemElejido = guiGridListGetSelectedItem(gridListMedico)
			if itemElejido ~= -1 then
             abrirVehiculosMedico()
             local id = guiGridListGetItemText(gridListMedico, guiGridListGetSelectedItem(gridListMedico), 2)
             triggerServerEvent("POPLife:sacarAutoMedico", localPlayer, id, price)
         end
     elseif source == buttonCerrar then
      abrirVehiculosMedico()
    end
end
)