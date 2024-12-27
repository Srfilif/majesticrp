
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Anunciadorawin = guiCreateWindow(0.33, 0.34, 0.31, 0.25, "Anunciadora-Los Santos", true)
        guiWindowSetSizable(Anunciadorawin, false)

        Listanun = guiCreateComboBox(0.04, 0.16, 0.25, 0.48, "", true, Anunciadorawin)
        guiComboBoxAddItem(Listanun, "LS-Anuncio")
        guiComboBoxAddItem(Listanun, "LS-Trabajo")
        guiComboBoxAddItem(Listanun, "LS-Venta")
        guiComboBoxAddItem(Listanun, "LS-Compra")
        anunciome = guiCreateEdit(0.03, 0.48, 0.95, 0.18, "", true, Anunciadorawin)
        enviaranun = guiCreateButton(0.31, 0.82, 0.37, 0.13, "Enviar Anuncio", true, Anunciadorawin)
        guiSetFont(enviaranun, "default-bold-small")
        guiSetProperty(enviaranun, "NormalTextColour", "FFFFFFFF")
        cerrar = guiCreateButton(0.80, 0.87, 0.15, 0.08, "Cerrar", true, Anunciadorawin)
        guiSetFont(cerrar, "default-bold-small")
        guiSetProperty(cerrar, "NormalTextColour", "FFFFFFFF")
        modoano = guiCreateRadioButton(0.02, 0.79, 0.26, 0.11, "Modo Anonimo", true, Anunciadorawin)
        costome = guiCreateLabel(0.29, 0.26, 0.62, 0.22, "El costo del anuncio es de $200 dolares\nSi no sabes las reglas podes varlas aqui ==>", true, Anunciadorawin)
        ayuda = guiCreateButton(0.90, 0.31, 0.06, 0.14, "?", true, Anunciadorawin)
        guiSetFont(ayuda, "default-bold-small")
        guiSetProperty(ayuda, "NormalTextColour", "FFFFFFFF")
		guiSetVisible(Anunciadorawin, false)
    end
)

--

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        reglaswin = guiCreateWindow(0.04, 0.33, 0.28, 0.26, "Reglas", true)
        guiWindowSetSizable(reglaswin, false)

        reglas = guiCreateMemo(0.02, 0.10, 0.95, 0.83, 
"1. No se puede publicar anuncios rebuscado con el fín de encubrir cualquier tipo de actividad ilegal, como compra/venta de articulos ilegales, sicariatio, tráfico de personas,etc\n\n2.No se puede publicar sobre manifestaciones o disturbios. Deben de buscar personas por fuera del sistema de anuncios.\n\n3.No se puede publicar la venta de vehículos especificando que tienen algún articulo ilegal como por ejemplo el oxido nitroso, si desean vender un vehículo con dicho componente no lo coloquen en el anuncio.\n\n4.No se puede publicar anuncios como si fuera una forma de hacer un noticiero informativo, todos los anuncios deben incentivar un rol aceptado si o si.\n\n5.No se puede publicar anuncios con el fín de hacer de exponer una información de una persona, a su vez tampoco si es ilegal,legal,corrupto o cualquier tipo de situación en la que se vea involucrado.\n\n6.No se puede publicar anuncios sobre eventos en mitad de vía publica, para esto deben tener un permiso de manera IC.\n\n7.No se puede publicar anuncios sobre eventos en propiedades u locales privados, para esto debes pedir permiso del dueño de manera IC.\n\n8.Los eventos o juntas de personas para cualquier fin no ilegal están completamente permitidos, sin embargo si es una junta de exposición de vehículos no, para esto deben tener un permiso de manera IC.", true, reglaswin)
guiSetVisible(reglaswin, false)   
   end
)

--

addEventHandler("onClientGUIClick", resourceRoot, function()
    if source == cerrar then
        guiSetVisible(Anunciadorawin, false)
		guiSetVisible(reglaswin, false)
	showCursor(false)
    elseif source == ayuda then
	if guiGetVisible(reglaswin) == true then
		guiSetVisible(reglaswin, false)
	else
		guiSetVisible(reglaswin, true)
	end	
	elseif source == enviaranun then
	local msg = guiGetText(anunciome)
	local text = guiGetText(Listanun)
	local ano = guiRadioButtonGetSelected(modoano)
	if msg ~= "" then
	if text ~= "" then
	triggerServerEvent("anuncioen",localPlayer,ano,text,msg)
	else
	outputChatBox("Debes poner un tema de anuncio",255,0,0,true)
	end
	else
	outputChatBox("Debes poner un algo que anunciar",255,0,0,true)
	end
    end
end)


addEvent("openanun", true)
addEventHandler("openanun", root, function()
	if guiGetVisible(Anunciadorawin) == true then
		guiSetVisible(Anunciadorawin, false)
		showCursor(false)
	else
		guiSetVisible(Anunciadorawin, true)
		showCursor(true)
	end	
end)


addEventHandler( "onClientRender", getRootElement(), 

	function()

		local x,y = getScreenFromWorldPosition(824.4736328125, 3.2841796875, 1004.1796875, 0, true )

		local dist = getDistanceBetweenPoints3D(824.4736328125, 3.2841796875, 1004.1796875, getElementPosition(localPlayer) )



		if x and dist <= 10 then

			x = x - (dxGetTextWidth( '/anuncio o /ad', 2-(dist/30)*2, "default-bold" )/2)

			

			dxDrawText('/anuncio o /ad', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/anuncio o /ad', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)

			dxDrawText('/anuncio o /ad', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)

		end

	end

)

