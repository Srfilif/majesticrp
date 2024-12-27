--1275

local _skins = {

	[285] = true,

	[286] = true,

	[287] = true,

	[71] = true,

	[205] = true,

	[280] = true,

	[284] = true,

	[281] = true,

	[282] = true,
	
	[214] = true,
	
	[298] = true

}



local pickup = createPickup(1578.412109375, -1684.693359375, 16.1953125, 3, 1275, 1)
local pickupgun = createPickup(1580.103515625, -1688.51953125, 16.1953125, 2,24, 1)
--setElementInterior( pickup, 10)


window = guiCreateWindow(0.36, 0.19, 0.27, 0.65, "Vestuario - Policía", true)

guiWindowSetSizable(window, false)

guiSetVisible(window,false)



cerrar = guiCreateLabel( 0.80, 0.005, 0.20, 0.04, 'Cerrar', true, window )

guiSetFont(cerrar, "default-bold-small")

guiSetProperty(cerrar, "ClippedByParent", "False")

guiSetProperty(cerrar, "AlwaysOnTop", "True")

guiSetProperty(cerrar, "RiseOnClick", "False")

GuardarAspecto = guiCreateButton(0.50, 0.12, 0.47, 0.08, "Guardar aspecto", true, window)

TomarAspectoGuardado = guiCreateButton(0.50, 0.21, 0.47, 0.08, "Tomar aspecto guardado", true, window)

Listaparaskins = guiCreateGridList(0.04, 0.31, 0.46, 0.65, true, window)

guiGridListAddColumn(Listaparaskins, "Skins", 0.84)

TomarSkin = guiCreateButton(0.55, 0.69, 0.38, 0.15, "Tomar Skin", true, window)





addCommandHandler("vestuarios",
	function ()
	--outputChatBox(""..getElementData(localPlayer, "Roleplay:faccion").."")
		if getElementData(localPlayer, "Roleplay:faccion") == "Policia" then
		
			if isPedWithinRange(1578.3232421875, -1684.7998046875, 16.1953125,1,localPlayer) then
				guiSetVisible(window,true)
				showCursor(true)
				guiGridListClear( Listaparaskins )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Cadete' ), 1, '71' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Mujer Policial' ), 1, '214' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Mujer Policial II' ), 1, '298' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Sargeto' ), 1, '280' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Motero' ), 1, '284' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Oficial l' ), 1, '281' )
				guiGridListSetItemData( Listaparaskins, guiGridListAddRow( Listaparaskins, 'Teniente' ), 1, '282' )	
			else
			
			outputChatBox("No estas en casilleros")
			end
		end
		
		--outputChatBox("no eres pd")
	end
)



addEventHandler( "onClientRender", getRootElement(),function()
	local x,y = getScreenFromWorldPosition(1578.412109375, -1684.693359375, 16.1953125, 0, true )
	local dist = getDistanceBetweenPoints3D(1578.412109375, -1684.693359375, 16.1953125, getElementPosition(localPlayer) )
	if x and dist <= 10 then
		x = x - (dxGetTextWidth( '/vestuarios', 2-(dist/30)*2, "default-bold" )/2)
		dxDrawText('/vestuarios', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		dxDrawText('/vestuarios', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		dxDrawText('/vestuarios', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
	end
end)

addEventHandler( "onClientRender", getRootElement(),function()
	local x,y = getScreenFromWorldPosition(1580.103515625, -1688.51953125, 16.1953125, 0, true )
	local dist = getDistanceBetweenPoints3D(1580.103515625, -1688.51953125, 16.1953125, getElementPosition(localPlayer) )
	if x and dist <= 10 then
		x = x - (dxGetTextWidth( '/armas', 2-(dist/30)*2, "default-bold" )/2)
		dxDrawText('/armas', x-1, y-1, x+1, y+1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		dxDrawText('/armas', x+1, y+1, x-1, y-1, tocolor(0,0,0,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
		dxDrawText('/armas', x, y, x, y, tocolor(2,172,240,255), 1.5-(dist/10), "default-bold","left","top",false,false,false,false,false)
	end
end)







addEventHandler( "onClientGUIClick", getRootElement(),function()
	if source == cerrar then

		guiSetVisible(window,false)

		showCursor(false)

	elseif source == TomarSkin then

		local id = tonumber(guiGridListGetItemData( Listaparaskins, guiGridListGetSelectedItem( Listaparaskins ), 1 )) or false

		if id then

			triggerServerEvent('VestuarioPoli',localPlayer, 'Colocar', id)

		end

	elseif source == GuardarAspecto then

		if _skins[localPlayer:getModel()] then

		else

			mySkin = localPlayer:getModel()

			triggerServerEvent('VestuarioPoli',localPlayer, 'Guardar', localPlayer:getModel())

		end

	elseif source == TomarAspectoGuardado then

		if mySkin then

			triggerServerEvent('VestuarioPoli',localPlayer, 'Tomar', mySkin)

		end

	end

end)







addEvent('refresh:MySkin', true)

addEventHandler('refresh:MySkin',localPlayer,

	function(id)

		mySkin = id

	end

)



function isPedWithinRange(x,y,z,range,ped)

	for _, type in ipairs({'player','ped'}) do

		for k,v in pairs(getElementsWithinRange(x,y,z,range, type)) do

			if v == ped then

				return true

			end

		end

	end

	return false;

end





addCommandHandler("armas",
function ()
if getElementData(localPlayer, "Roleplay:faccion") == "Policia" then
		
		if isPedWithinRange(1580.103515625, -1688.51953125, 16.1953125,1,localPlayer) then
        local screenW, screenH = guiGetScreenSize()
        Gui_Armas = guiCreateWindow((screenW - 448) / 2, (screenH - 437) / 2, 448, 437, "Armas SAPD", false)
        guiWindowSetSizable(Gui_Armas, false)

        lista = guiCreateGridList(10, 56, 428, 306, false, Gui_Armas)
        guiGridListAddColumn(lista, "ID", 0.3)
        guiGridListAddColumn(lista, "Arma", 0.3)
        guiGridListAddColumn(lista, "Rango", 0.3)
        for i = 1, 11 do
            guiGridListAddRow(lista)
        end
		guiGridListSetItemText(lista, 0, 1, "0", false, false)
        guiGridListSetItemText(lista, 0, 2, "Porra", false, false)
        guiGridListSetItemText(lista, 0, 3, "Agente en Practica", false, false)
				
        guiGridListSetItemText(lista, 1, 1, "1", false, false)
        guiGridListSetItemText(lista, 1, 2, "Taser", false, false)
        guiGridListSetItemText(lista, 1, 3, "Agente en Practica", false, false)
		
        guiGridListSetItemText(lista, 2, 1, "2", false, false)
        guiGridListSetItemText(lista, 2, 2, "Desert Eagle", false, false)
        guiGridListSetItemText(lista, 2, 3, "Cadete", false, false)
		
		
        guiGridListSetItemText(lista, 3, 1, "3", false, false)
        guiGridListSetItemText(lista, 3, 2, "Shoutgun", false, false)
        guiGridListSetItemText(lista, 3, 3, "Oficial I", false, false)

				
        guiGridListSetItemText(lista, 4, 1, "4", false, false)
        guiGridListSetItemText(lista, 4, 2, "Fucil MP5", false, false)
        guiGridListSetItemText(lista, 4, 3, "Oficial II", false, false)
		
        guiGridListSetItemText(lista, 5, 1, "5", false, false)
        guiGridListSetItemText(lista, 5, 2, "Fucil M4A1", false, false)
        guiGridListSetItemText(lista, 5, 3, "Oficial III", false, false)
		
		
		guiGridListSetItemText(lista, 6, 1, "6", false, false)
        guiGridListSetItemText(lista, 6, 2, "Chaleco Antibalas", false, false)
        guiGridListSetItemText(lista, 6, 3, "Agente en Practica", false, false)
		
		    guiSetProperty(lista, "SortSettingEnabled", "False")
        duty = guiCreateButton(10, 372, 119, 48, "Iniciar Servicio", false, Gui_Armas)
        guiSetProperty(duty, "NormalTextColour", "FF00FF00")
        takegun = guiCreateButton(165, 372, 119, 48, "Tomar Arma", false, Gui_Armas)
        guiSetProperty(takegun, "NormalTextColour", "FFFFFFFF")
        offduty = guiCreateButton(319, 372, 119, 48, "Iniciar Servicio", false, Gui_Armas)
        guiSetProperty(offduty, "NormalTextColour", "FFFF0000")
        cerrar1 = guiCreateButton(411, 23, 27, 27, "X", false, Gui_Armas)
       label = guiCreateLabel(80, 29, 289, 17, "Haz doble-click en el arma que quieras obtener", false, Gui_Armas)
        guiSetFont(label, "clear-normal")
        guiLabelSetHorizontalAlign(label, "center", false)      
		
		showCursor(true)
		addEventHandler("onClientGUIClick",cerrar1,cerrar2,false)
		addEventHandler("onClientGUIClick",duty,on,false)
		addEventHandler("onClientGUIClick",offduty,off,false)
		addEventHandler("onClientGUIClick",takegun,gun,false)
    end
end
end
)
addCommandHandler("armaspd",Armas)
function gun()
local Duty = getElementData(getLocalPlayer(), "SAPD:on") or 0

if(Duty == 1)then


 local item = guiGridListGetSelectedItem (lista) --Detecto la fila que selecciono el jugador
 
 
if item == 0 then

 triggerServerEvent ( "[Vestuarios]darArma", resourceRoot, localPlayer, 3, 1, 1) --Paso al server estos parametros
end

if item == 1 then

 triggerServerEvent ( "[Vestuarios]darArma", resourceRoot, localPlayer, 23, 5, 1) --Paso al server estos parametros
end

if item == 2 then

 triggerServerEvent ( "[Vestuarios]darArma", resourceRoot, localPlayer, 24, 7, 1) --Paso al server estos parametros
end

if item == 3 then

 triggerServerEvent ( "[Vestuarios]darArma", resourceRoot, localPlayer, 25, 20, 1) --Paso al server estos parametros
end
if item == 4 then

 triggerServerEvent ( "[Vestuarios]darArma", resourceRoot, localPlayer, 29, 30, 1) --Paso al server estos parametros
end
if item == 5 then

 triggerServerEvent ( "[Vestuarios]darArma", resourceRoot, localPlayer, 31, 30, 1) --Paso al server estos parametros
end
if item ==6 then
local armor = getPedArmor(localPlayer) or 0
if armor <51 then

   setPedArmor ( localPlayer, armor + 50 ) 
--takePlayerMoney ( 1500 )   -- S
-- triggerServerEvent ( "darArma", resourceRoot, localPlayer, 33, 10, 8150) --Paso al server estos parametros
 
 else
 --outputChatBox("#035efc[SAPD]#ffffffYa tienes Chaleco",255,255,255,true)
 outputChatBox("#035efc[SAPD]#ffffff Tu chaleco esta en buen estado para ser cambiado",255,255,255,true)
 end
end
else
outputChatBox("#035efc[SAPD]#ff3d3d No estas en servicio,Por favor entra en servicio #777777(/servicio)",255,255,255,true)
end

end

function cerrar2()


		guiSetVisible(Gui_Armas,false)

		showCursor(false)
end

function off()
local pd = getLocalPlayer()
local Duty = getElementData(pd, "SAPD:on") or 0
if Duty == 1 then
outputChatBox("#035efc[SAPD] #ffffffSaliste de servicio Activo",255,255,255,true)
setElementData (pd,"SAPD:on", 0 )
else
outputChatBox("#035efc[SAPD] #ffffffNo estas en servicio",255,255,255,true)

end
end
addCommandHandler("salirservicio",off)

function on()
local pd = getLocalPlayer()
local Duty = getElementData(pd, "SAPD:on") or 0
if Duty == 0 then
outputChatBox("#035efc[SAPD] #ffffffEntraste en servicio Activo,#FFFFFF Para salir de servicio #777777(/salirservicio)",255,255,255,true)
setElementData (pd,"SAPD:on", 1 )
else
outputChatBox("#035efc[SAPD] #ff3d3dYa estas en servicio Activo",255,255,255,true)
end
end
addCommandHandler("servicio",on)
