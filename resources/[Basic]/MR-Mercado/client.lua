addEventHandler("onClientResourceStart", resourceRoot,
    function()
        local screenW, screenH = guiGetScreenSize()
        ventanaMercado = guiCreateWindow((screenW - 380) / 2, (screenH - 400) / 2, 380, 400, " Mercado Negro", false)
        guiWindowSetSizable(ventanaMercado, false)
        guiSetVisible(ventanaMercado, false)

        listaMercado = guiCreateGridList(9, 23, 361, 305, false, ventanaMercado)
        guiGridListAddColumn(listaMercado, "Item", 0.6)
        guiGridListAddColumn(listaMercado, "ID", 0.1)
        guiGridListAddColumn(listaMercado, "Costo", 0.2)
        boton1 = guiCreateButton(10, 332, 360, 26, "Comprar / Vender", false, ventanaMercado)
        guiSetFont(boton1, "default-bold-small")
        guiSetProperty(boton1, "NormalTextColour", "FFAAAAAA")
        boton2 = guiCreateButton(10, 358, 360, 26, "Cerrar", false, ventanaMercado)
        guiSetFont(boton2, "default-bold-small")
        guiSetProperty(boton2, "NormalTextColour", "FFAAAAAA")  

        addEventHandler("onClientGUIClick", boton1, comprarItem, false)
        addEventHandler("onClientGUIClick", boton2, accionesVentana, false) 
    end
)

function accionesVentana()
    if guiGetVisible(ventanaMercado) == true then
        guiSetVisible(ventanaMercado, false)
        showCursor(false)
    else
        guiSetVisible(ventanaMercado, true)
        showCursor(true)
    end
end
addEvent("POPLife:accionarMercadoNegro", true)
addEventHandler("POPLife:accionarMercadoNegro", root, accionesVentana)

function comprarItem()
	local item = guiGridListGetItemText(listaMercado, guiGridListGetSelectedItem(listaMercado), 1)
    local id = guiGridListGetItemText(listaMercado, guiGridListGetSelectedItem(listaMercado), 2)
    local costo = guiGridListGetItemText(listaMercado, guiGridListGetSelectedItem(listaMercado), 3)
    triggerServerEvent("POPLife:usarTienda", getLocalPlayer(), item, id, costo)
end

local tablaCompra = {
    {"Ojos", "1", "5500"},
    {"Corazon", "2", "25000"},
    {"Estomago", "3", "18500"},
    --{"Maria", "4", "0"},
    --{"Nieve", "5", "0"},
}

local tablaVenta = {
	--{"Semillas Ilegales", "1", "1000"},
    {"Medicamentos", "1", "1000"},
    {"Ganzuas", "2", "5000"},
    {"Chaleco AntiBalas", "3", "7000"},
    {"Bisturi", "4", "50000"},
}

local tablaArmas = {
    {"Deagle", "1", "115000"},
    {"MP5", "2", "798500"},
    {"M4", "3", "1500000"},
}

function colocarItems()
    local row = guiGridListAddRow(listaMercado)
    guiGridListSetItemText(listaMercado, row, 1, "Compra", true, false)
    for i, k in ipairs(tablaCompra) do
        local row = guiGridListAddRow(listaMercado)
        guiGridListSetItemText(listaMercado, row, 1, tostring(k[1]), false, false)
        guiGridListSetItemText(listaMercado, row, 2, tostring(k[2]), false, false)
        guiGridListSetItemText(listaMercado, row, 3, tostring(k[3]), false, false)
    end
    local row = guiGridListAddRow(listaMercado)
    guiGridListSetItemText(listaMercado, row, 1, "Venta", true, false)
    for i, k in ipairs(tablaVenta) do
        local row = guiGridListAddRow(listaMercado)
        guiGridListSetItemText(listaMercado, row, 1, tostring(k[1]), false, false)
        guiGridListSetItemText(listaMercado, row, 2, tostring(k[2]), false, false)
        guiGridListSetItemText(listaMercado, row, 3, tostring(k[3]), false, false)
    end
    local row = guiGridListAddRow(listaMercado)
    guiGridListSetItemText(listaMercado, row, 1, "Armas no Registradas", true, false)
    for i, k in ipairs(tablaArmas) do
        local row = guiGridListAddRow(listaMercado)
        guiGridListSetItemText(listaMercado, row, 1, tostring(k[1]), false, false)
        guiGridListSetItemText(listaMercado, row, 2, tostring(k[2]), false, false)
        guiGridListSetItemText(listaMercado, row, 3, tostring(k[3]), false, false)
    end
end
addEventHandler("onClientResourceStart", resourceRoot, colocarItems)