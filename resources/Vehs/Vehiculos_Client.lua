local screenW, screenH = guiGetScreenSize()
local concewin = false
local vehcreado 
local pos
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        Comprar = guiCreateButton(0.84, 0.74, 0.10, 0.05, "Comprar", true)
        guiSetFont(Comprar, "default-bold-small")
        guiSetProperty(Comprar, "NormalTextColour", "FFFEFEFE")


        ComprarAC = guiCreateButton(0.72, 0.74, 0.10, 0.05, "Comprar A Cuotas", true)
        guiSetFont(ComprarAC, "default-bold-small")
        guiSetProperty(ComprarAC, "NormalTextColour", "FFFEFEFE")


        cerrarconce = guiCreateButton(0.68, 0.74, 0.02, 0.05, "X", true)
        guiSetFont(cerrarconce, "default-bold-small")
        guiSetProperty(cerrarconce, "NormalTextColour", "FFFE0101")


        listaveh = guiCreateGridList(0.6825, 0.33, 0.30, 0.39, true)
        guiGridListAddColumn(listaveh, "ID", 0.1)
        guiGridListAddColumn(listaveh, "Vehiculo", 0.3)
        guiGridListAddColumn(listaveh, "Maletero", 0.3)
        guiGridListAddColumn(listaveh, "Precio", 0.2)   

        guiSetVisible(Comprar,false) 
        guiSetVisible(ComprarAC,false) 
        guiSetVisible(cerrarconce,false) 
        guiSetVisible(listaveh,false) 
    end
)

addEventHandler("onClientRender", root,
    function()
    	if concewin == true then
	        dxDrawRectangle(screenW * 0.6758, screenH * 0.2694, screenW * 0.3133, screenH * 0.5417, tocolor(49, 49, 49, 255), false)
	        dxDrawText("Concesionaria de Vehiculos", screenW * 0.6852, screenH * 0.2778, screenW * 0.9812, screenH * 0.3181, tocolor(255, 255, 255, 255), 2.00, "default-bold", "center", "center", false, false, false, false, false)
    	end
    end
)

local posici = {
	--
{2119.5977, -1149.1484375, 24.247255325317,  2119.814453125, -1157.7412109375, 24.196813583374,352.58685302734},
{1987.084, -1988.0820312, 13.546875,1986.896484375, -1983.931640625, 13.546875,180.44496154785},
{543.08984, -1282.71875, 17.2421875, 543.9052734375, -1288.6611328125, 17.2421875,359.85443115234},
}

local posveh

addEventHandler("onClientGUIClick", resourceRoot, function()
	local modelo = guiGridListGetItemData ( listaveh, guiGridListGetSelectedItem ( listaveh ), 1 )
	local costo = guiGridListGetItemData( listaveh, guiGridListGetSelectedItem ( listaveh ), 4 )
	local male = guiGridListGetItemData( listaveh, guiGridListGetSelectedItem ( listaveh ), 3 )
	if source == cerrarconce then
		guiSetVisible(Comprar,false) 
        guiSetVisible(ComprarAC,false) 
        guiSetVisible(cerrarconce,false) 
        guiSetVisible(listaveh,false) 
        showCursor(false)
        concewin = false
        setCameraTarget(localPlayer)
        if isElement(vehiclee) then destroyElement(vehiclee) end
	elseif source == Comprar then
		setEnabled(Comprar, 2000)
		if modelo ~= 0 then
			local r, g, b, r2, g2, b2 = vehiclee:getColor(true)
			triggerServerEvent("BuyCars", localPlayer, r, g, b, r2, g2, b2, modelo, costo, male,posveh)
		end
	elseif source == listaveh then
	local row = guiGridListGetSelectedItem(listaveh)
	if (not row or row == -1) then return end
		local id = guiGridListGetItemText(listaveh, row, 1)
		id = tonumber(id)
	if (not id) then return end
		for index, v in ipairs( posici ) do
			if v[1] == pos then
				if isElement(vehiclee) then destroyElement(vehiclee) end
				vehiclee = createVehicle ( id, v[4],v[5],v[6],0,0,v[7])
			end
   		 end
	end
end)

local coches = {
	--
	{401,"Bravura",8500,6},
	{602,"Alpha",49000,6},
	{565,"Flash",60000,6},
	{566,"Tahoma",33000,6},
	{547,"Primo",30000,6},
	{410,"Manana",5000,6},
	{585,"Emperor",15000,6},
	{426,"Premier",40000,6},
	{558,"Uranus",60000,6},
	{445,"Admiral",15000,8},
	{567,"Savanna",46000,6},
	{562,"Elegy",200000,6},
	{507,"Elegant",15000,8},
	{542,"Clover",8000,8},
	--motos
	{509,"Bike",700,6},
	{510,"Mount Bike",3000,6},
	{481,"BMX",1000,6},
	{462,"Faggio",6000,6},
	{463,"Freeway",36000,6},
	{586,"Wayfarer",36100,6},
	{521,"FCR-900",57000,6},
	{461,"PCJ-600",28000,6},
	{468,"Sanchez",24000,6},
	{581,"BF-400",27000,6},
	{522,"NRG-500",720000,6},
	--conce Cara 

	{579,"Huntley",300000,8},
	{402,"Buffalo",240000,6},
	{603,"Phoenix",245000,6},
	{429,"Banshee",800000,6},
	{415,"Cheetah",745000,6},
	{480,"Comet",650000,6},
	{411,"Infernus",920000,6},
	{451,"Turismo",920000,6},
	{555,"Windsor",215000,6},
	{560,"Sultan",510000,6},
	{477,"ZR-350",610000,6},

}

addEvent("Conce:setWindow",true)
addEventHandler("Conce:setWindow",root,function(tab)
	    guiSetVisible(Comprar,true) 
        guiSetVisible(ComprarAC,true) 
        guiSetVisible(cerrarconce,true) 
        guiSetVisible(listaveh,true)
        concewin = true
        showCursor(true) 
        --
        guiGridListClear( listaveh )
    for i, v in ipairs( tab ) do
    	local row = guiGridListAddRow(listaveh)
    	for index, valor in ipairs( coches ) do
			if valor[1] == v then
				guiGridListSetItemText( listaveh, row, 1,valor[1], false, true )
				guiGridListSetItemText( listaveh, row, 2,"   "..valor[2], false, true )
				guiGridListSetItemText( listaveh, row, 3,"     "..valor[4], false, true )
				guiGridListSetItemText( listaveh, row, 4,"$"..valor[3], false, true )

				guiGridListSetItemData( listaveh, row, 1,valor[1] )
				guiGridListSetItemData( listaveh, row, 2,valor[2] )
				guiGridListSetItemData( listaveh, row, 3,valor[4] )
				guiGridListSetItemData( listaveh, row, 4,valor[3] )
			end
		end
    end
end)


addEvent("Conce:Car",true)
addEventHandler("Conce:Car",root,function(v)
	for index, valor in ipairs( posici ) do
		if valor[1] == v then
			vehpos(valor[1])
			pos = v
			setCameraMatrix(valor[1],valor[2],valor[3],valor[4],valor[5],valor[6])
		end
	end
end)

function vehpos(id)
	if id == 2119.5977 then
		posveh = "pos_A"
	elseif id == 1987.084 then
		posveh = "pos_B"
	elseif id == 543.08984 then
		posveh = "pos_C"
	end
end


function setEnabled( var, timer )
	guiSetEnabled( var, false )
	setTimer(guiSetEnabled, timer, 1, var, true)
end

--windowcar



function getPlayerNearbyVehicle(localPlayer)
	if isElement(localPlayer) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( localPlayer )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.5 then
				return veh
			end
		end
	end
	return false
end
















addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in pairs(getMarkervender()) do
		local playerX, playerY, playerZ = v.Posiciones[1], v.Posiciones[2], v.Posiciones[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
			if distance < 20 then
				dxDrawBorderedText3 ( v.textoMarker, sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end







addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	for k, v in ipairs(Vehicle_Datos) do
		local playerX, playerY, playerZ = v.Pos[1], v.Pos[2], v.Pos[3]
		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.8)
		if sx and sy then
			local cx, cy, cz = getCameraMatrix()
			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.8)
			if distance < 5 then
				dxDrawBorderedText3 ( "#FFFF00"..getVehicleNameFromModel( v.ID ).."\n#DDFFDDPrecio: #004500$"..convert(v.Costo).." dólares\n#DDFFDDEspacio de Maletero: #001F4C"..v.Slots, sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
			end
		end
	end
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

function convert ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end



-- GANSUAR


GUIEditor = {
    button = {},
    edit = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        gansuawin = guiCreateWindow(0.74, 0.35, 0.25, 0.22, "Gansuar Coche", true)
        guiWindowSetSizable(gansuawin, false)

        GUIEditor.button[1] = guiCreateButton(0.36, 0.77, 0.29, 0.18, "Gansuar", true, gansuawin)
        guiSetFont(GUIEditor.button[1], "default-bold-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")
        GUIEditor.edit[1] = guiCreateEdit(0.11, 0.53, 0.11, 0.18, "", true, gansuawin)
        GUIEditor.edit[2] = guiCreateEdit(0.34, 0.53, 0.11, 0.18, "", true, gansuawin)
        GUIEditor.edit[3] = guiCreateEdit(0.56, 0.53, 0.11, 0.18, "", true, gansuawin)
        GUIEditor.edit[4] = guiCreateEdit(0.78, 0.53, 0.11, 0.18, "", true, gansuawin)
        GUIEditor.edit[5] = guiCreateEdit(0.03, 0.29, 0.08, 0.14, "", true, gansuawin)
        guiEditSetReadOnly(GUIEditor.edit[5], true)
        GUIEditor.edit[6] = guiCreateEdit(0.14, 0.29, 0.08, 0.14, "", true, gansuawin)
        guiEditSetReadOnly(GUIEditor.edit[6], true)
        GUIEditor.label[1] = guiCreateLabel(0.03, 0.15, 0.31, 0.09, "Numeros ocultos", true, gansuawin)
        guiSetFont(GUIEditor.label[1], "default-bold-small")
        GUIEditor.label[2] = guiCreateLabel(0.31, 0.37, 0.41, 0.13, "Conbinacion secreta", true, gansuawin)
        guiSetFont(GUIEditor.label[2], "default-bold-small")
        GUIEditor.button[2] = guiCreateButton(0.87, 0.14, 0.10, 0.18, "?", true, gansuawin)
        guiSetFont(GUIEditor.button[2], "sa-header")
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFFFFFF")
        GUIEditor.button[3] = guiCreateButton(0.85, 0.78, 0.12, 0.17, "X", true, gansuawin)
        guiSetFont(GUIEditor.button[3], "default-bold-small")
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFFF0000")
		guiSetVisible(gansuawin,false)
    end
)
--windowcar
local windowcar = false
local screenW, screenH = guiGetScreenSize()
addEventHandler( "onClientRender", getRootElement(),function()

	if windowcar == true then
	    dxDrawRectangle(screenW * 0.6219, screenH * 0.6038, screenW * 0.1062-10, screenH * 0.0362-10, tocolor(55, 55, 55, 186), false)
        dxDrawRectangle(screenW * 0.6219, screenH * 0.6687, screenW * 0.1062-10, screenH * 0.0362-10, tocolor(55, 55, 55, 186), false)
		dxDrawLine(screenW * 0.6406, screenH * 0.6050, screenW * 0.6406, screenH * 0.6262, tocolor(255, 255, 255, 255), 2, false)
        dxDrawLine(screenW * 0.6406, screenH * 0.6687, screenW * 0.6406, screenH * 0.6900, tocolor(255, 255, 255, 255), 2, false)
        dxDrawText("F", screenW * 0.6211+5, screenH * 0.6025, screenW * 0.6414-10, screenH * 0.6400-10, tocolor(255, 255, 255, 255), 0.90, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("G", screenW * 0.6219+5, screenH * 0.6675, screenW * 0.6422-10, screenH * 0.7050-10, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
        dxDrawText("Conducir", screenW * 0.6430, screenH * 0.6038, screenW * 0.7281-10, screenH * 0.6388-10, tocolor(255, 255, 255, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
        dxDrawText("Pasajero", screenW * 0.6430, screenH * 0.6687, screenW * 0.7281-10, screenH * 0.7037-10, tocolor(255, 255, 255, 255), 0.50, "bankgothic", "center", "center", false, false, false, false, false)
	end
end) 
addEventHandler( "onClientRender", getRootElement(),function()
	local veh = getPlayerNearbyVehicle(localPlayer)
	if veh then
	windowcar = true
	elseif not veh then
	windowcar = false
	end
	if getPedOccupiedVehicle(localPlayer) then
	windowcar = false
	end
end)

local blipsveh = {}

local marcadores = {
{2557.3525390625, -1126.8623046875, 64.06379699707},
{2160.46484375, -1976.94140625, 13.552664756775},
{1013.5712890625, -1006.98046875, 32.1015625},
{550.8330078125, -1288.759765625, 17.248237609863},
}

addCommandHandler("dondevenderveh",function()
	outputChatBox("En el mapa se te muestran los puntos para vender el vehiculo", 227, 114, 1,true)	
	outputChatBox("Para quitar los blips pon #ee0000/nblip", 255, 255, 255,true)
	for i, v in ipairs(marcadores) do				
		blipsveh[i] = Blip(v[1], v[2], v[3], 0, 2, 255 ,255, 0, 255, 0, 99999,localPlayer)
	end
end)

addCommandHandler("nblip",function()
	for i, v in ipairs(blipsveh) do	
		if isElement( v ) then
			v:destroy()
			v = nil
		end
	end
	outputChatBox("#ee0000Blips Eliminados",255,255,255,true)
end)


function getPlayerNearbyVehicle(localPlayer)
	if isElement(localPlayer) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( localPlayer )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.5 then
				return veh
			end
		end
	end
	return false
end

local pos = false

local sx,sy = guiGetScreenSize(  )

local veryo = true

addEventHandler( "onClientRender", root,
	function( )
		if veryo == true then
			local vehs = getElementsByType( 'vehicle' )
			for i=1, #vehs do 
				local v= vehs[i]
				local x, y, z = getElementPosition( v )
				if getDistanceBetweenPoints3D( x, y, z, unpack( {getCameraMatrix(getLocalPlayer())} ) ) < 40 then
					if getVehicleType(v) == "Automobile" then
						local cx, cy, cz = getVehicleComponentPosition( v, 'wheel_rb_dummy', "world" )
						if cx and cy and cz then
							local sx, sy = getScreenFromWorldPosition( cx, cy, cz )
							local text = getElementData( v, "yo" ) or ""
							if sx and sy then
								dxDrawText( text, sx-3, sy, sx, sy, tocolor(0,0,0), 1, "default-bold", "center", "center" )
								dxDrawText( text, sx, sy, sx, sy, tocolor(255,255,255), 1, "default-bold", "center", "center" )
							end
						end
					end
				end
			end
		end
	end
)

