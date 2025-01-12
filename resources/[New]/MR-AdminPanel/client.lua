local sx, sy = guiGetScreenSize()

function kiWindow ()
	kill_window1 = guiCreateWindow ( (sx-300)/2, (sy-150)/2, 400, 170, "Salida de la cárcel", false)
	kill_label = guiCreateLabel(5, 20, 390, 60, "Seleccione el lugar de reaparición.", false, kill_window1 )
    guiSetFont(kill_label, "default-bold-small")
    guiLabelSetHorizontalAlign(kill_label, "center", false)
	sf_button1 = guiCreateButton(0, 40, 390, 35, "Comisaría de San Fierro", false, kill_window1 )
    lv_button1 = guiCreateButton(0, 80, 390, 35, "Comisaría de Las Venturas", false, kill_window1 )
    ls_button1 = guiCreateButton(0, 120, 390, 35, "Comisaría de Los Santos", false, kill_window1 )
end

function killWindow1 ()
	if isElement(kill_window1) then
		destroyElement(kill_window1)
		showCursor(false)
	else
		kiWindow()
		showCursor(true)
	end
end
addEvent ("killWindow1", true)
addEventHandler ("killWindow1", getRootElement(), killWindow1)

addEventHandler ( "onClientGUIClick", getRootElement(), function()
	if isElement(kill_window1) then
		if source == sf_button1 then
			destroyElement(kill_window1)
			showCursor(false)
            triggerServerEvent("kill_Sf", getLocalPlayer())
        elseif source == lv_button1 then
			destroyElement(kill_window1)
			showCursor(false)
            triggerServerEvent("kill_Lv", getLocalPlayer())
        elseif source == ls_button1 then
			destroyElement(kill_window1)
			showCursor(false)
            triggerServerEvent("kill_Ls", getLocalPlayer())
        end
	end
end)
--------------------------------------------------------------------

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

--------------------------------------------------------------------

wndBan = guiCreateWindow(0,0,410,165,"Banear Usuario",false)
centerWindow(wndBan)
guiSetVisible(wndBan,false)
ban = guiCreateLabel(5,20,405,30,"Especifique el motivo de la prohibición (No más de 15 caracteres)",false,wndBan)
guiSetFont(ban,"default-bold-small")
guiLabelSetHorizontalAlign(ban, "center", false)
editBan = guiCreateEdit(5,40,405,30,"",false,wndBan)
give_wndBan = guiCreateButton(5,80,405,35,"Asunto",false,wndBan)
close_wndBan = guiCreateButton(5,120,405,35,"Cancelar",false,wndBan)

--------------------------------------------------------------------

wndfollow = guiCreateWindow(480,670,410,70,"Seguimiento de jugadores",false)
guiSetVisible(wndfollow,false)
close_wndfollow = guiCreateButton(5,25,405,35,"Finalizar la sesión",false,wndfollow)

--------------------------------------------------------------------

wndSkin = guiCreateWindow(0,0,410,165,"Distribución de la piel",false)
centerWindow(wndSkin)
guiSetVisible(wndSkin,false)
idSkin = guiCreateLabel(5,20,405,30,"Introduzca el ID:",false,wndSkin)
guiSetFont(idSkin,"default-bold-small")
guiLabelSetHorizontalAlign(idSkin, "center", false)
editSkin = guiCreateEdit(5,40,405,30,"",false,wndSkin)
give_wndSkin = guiCreateButton(5,80,405,35,"Asunto",false,wndSkin)
close_wndSkin = guiCreateButton(5,120,405,35,"Cancelar",false,wndSkin)

--------------------------------------------------------------------

wndDimen = guiCreateWindow(0,0,410,165,"Medición",false)
centerWindow(wndDimen)
guiSetVisible(wndDimen,false)
dim = guiCreateLabel(5,20,405,30,"Ingrese el ID de medición (0 a 65535)",false,wndDimen)
guiSetFont(dim,"default-bold-small")
guiLabelSetHorizontalAlign(dim, "center", false)
editDimen = guiCreateEdit(5,40,405,30,"",false,wndDimen)
give_wndDimen = guiCreateButton(5,80,405,35,"Instalar",false,wndDimen)
close_wndDimen = guiCreateButton(5,120,405,35,"Cancelar",false,wndDimen)

--------------------------------------------------------------------

wndInt = guiCreateWindow(0,0,410,325,"Interior",false)
centerWindow(wndInt)
guiSetVisible(wndInt,false)
int = guiCreateLabel(5,20,405,30,"Seleccione un interior de la lista:",false,wndInt)
guiSetFont(int,"default-bold-small")
guiLabelSetHorizontalAlign(int, "center", false)
gridInt = guiCreateGridList(5,40,405,190,false,wndInt)
guiGridListSetSelectionMode(gridInt,1)
columnInt1 = guiGridListAddColumn(gridInt,"ID",0.2)
columnInt2 = guiGridListAddColumn(gridInt,"Interior",0.2)
columnInt3 = guiGridListAddColumn(gridInt,"posX",0.3)
columnInt4 = guiGridListAddColumn(gridInt,"posY",0.3)
columnInt5 = guiGridListAddColumn(gridInt,"posZ",0.3)
columnInt6 = guiGridListAddColumn(gridInt,"rot",0.2)
local node = xmlLoadFile ( "conf\\interiors.xml" )
if ( node ) then
    local interiors = 0
    while ( xmlFindChild ( node, "interior", interiors ) ~= false ) do
        local interior = xmlFindChild ( node, "interior", interiors )
        local row = guiGridListAddRow(gridInt)
        guiGridListSetItemText(gridInt, row, columnInt1, xmlNodeGetAttribute(interior, "world" ), false, true )
        guiGridListSetItemText(gridInt, row, columnInt2, xmlNodeGetAttribute(interior, "id" ), false, false )
        guiGridListSetItemText(gridInt, row, columnInt3, xmlNodeGetAttribute(interior, "posX" ), false, false )
        guiGridListSetItemText(gridInt, row, columnInt4, xmlNodeGetAttribute(interior, "posY" ), false, false )
        guiGridListSetItemText(gridInt, row, columnInt5, xmlNodeGetAttribute(interior, "posZ" ), false, false )
        guiGridListSetItemText(gridInt, row, columnInt6, xmlNodeGetAttribute(interior, "rot" ), false, false )
        interiors = interiors + 1
    end
    xmlUnloadFile(node)
end
give_wndInt = guiCreateButton(5,240,405,35,"Instalar",false,wndInt)
close_wndInt = guiCreateButton(5,280,405,35,"Cerrar",false,wndInt)

--------------------------------------------------------------------

wndMoney = guiCreateWindow(0,0,410,165,"Dar dinero",false)
centerWindow(wndMoney)
guiSetVisible(wndMoney,false)
mon = guiCreateLabel(5,20,405,30,"Introduzca el importe:",false,wndMoney)
guiSetFont(mon,"default-bold-small")
guiLabelSetHorizontalAlign(mon, "center", false)
editMoney = guiCreateEdit(5,40,405,30,"",false,wndMoney)
give_wndMoney = guiCreateButton(5,80,405,35,"Asunto",false,wndMoney)
close_wndMoney = guiCreateButton(5,120,405,35,"Cancelar",false,wndMoney)

--------------------------------------------------------------------

wanted = guiCreateWindow(0,0,410,365,"Seleccione una opción",false)
centerWindow(wanted)
guiSetVisible(wanted,false)
wan = guiCreateLabel(5,20,405,30,"Seleccione el número de estrellas que desea asignar al jugador:",false,wanted)
guiSetFont(wan,"default-bold-small")
guiLabelSetHorizontalAlign(wan, "center", false)
wan1 = guiCreateButton(5,40,405,35,"1 estrella",false,wanted)
wan2 = guiCreateButton(5,80,405,35,"2 estrellas",false,wanted)
wan3 = guiCreateButton(5,120,405,35,"3 estrellas",false,wanted)
wan4 = guiCreateButton(5,160,405,35,"4 estrellas",false,wanted)
wan5 = guiCreateButton(5,200,405,35,"5 estrellas",false,wanted)
wan6 = guiCreateButton(5,240,405,35,"6 estrellas",false,wanted)
wan7 = guiCreateButton(5,280,405,35,"Eliminar estrellas",false,wanted)
close_wanted = guiCreateButton(5,320,405,35,"Cerrar",false,wanted)

addEventHandler("onClientGUIClick", root, function()
    if ( source == close_wanted ) then
        guiSetVisible(wanted,false)
        showCursor(false)
    end
end)

--------------------------------------------------------------------

wndTp = guiCreateWindow(0,0,410,165,"Teletransporte",false)
centerWindow(wndTp)
guiSetVisible(wndTp,false)
wan = guiCreateLabel(5,20,405,30,"Seleccione una acción:",false,wndTp)
guiSetFont(wan,"default-bold-small")
guiLabelSetHorizontalAlign(wan, "center", false)
tp1 = guiCreateButton(5,40,405,35,"Teletransportarse al jugador seleccionado",false,wndTp)
tp2 = guiCreateButton(5,80,405,35,"Teletransportar al jugador seleccionado hacia ti",false,wndTp)
close_Tp = guiCreateButton(5,120,405,35,"Cancelar",false,wndTp)

--------------------------------------------------------------------

wndTpMap = guiCreateWindow(0,0,700,700,"Teletransporte por mapa",false)
centerWindow(wndTpMap)
guiSetVisible(wndTpMap,false)
mapBlip = guiCreateStaticImage(40, 30, 610, 610, 'conf/map.png', false, wndTpMap)
close_TpMap = guiCreateButton(5,655,680,35,"Cancelar",false,wndTpMap)

--------------------------------------------------------------------

wndVeh = guiCreateWindow(0,0,410,325,"Asignar vehículo",false)
centerWindow(wndVeh)
guiSetVisible(wndVeh,false)
veh = guiCreateLabel(5,20,405,30,"Seleccione un vehículo de la lista:",false,wndVeh)
guiSetFont(veh,"default-bold-small")
guiLabelSetHorizontalAlign(veh, "center", false)
gridVeh = guiCreateGridList(5,40,405,190,false,wndVeh)
guiGridListSetSelectionMode(gridVeh,1)
columnVeh1 = guiGridListAddColumn(gridVeh,"ID",0.2)
columnVeh2 = guiGridListAddColumn(gridVeh,"Vehículo",0.7)
local vehicleNames = {}
for i = 400, 611 do
    if (getVehicleNameFromModel(i) ~= "") then
        table.insert(vehicleNames, {model = i, name = getVehicleNameFromModel(i)})
    end
end
table.sort(vehicleNames, function(a, b) return a.name < b.name end)
for _,info in ipairs(vehicleNames) do
    local row = guiGridListAddRow(gridVeh)
    guiGridListSetItemText(gridVeh, row, columnVeh1, info.model, false, false)
    guiGridListSetItemText(gridVeh, row, columnVeh2, info.name, false, false)
    guiGridListSetItemData(gridVeh, row, columnVeh2, tostring(info.model))
end
give_wndVeh = guiCreateButton(5,240,405,35,"Asignar",false,wndVeh)
close_wndVeh = guiCreateButton(5,280,405,35,"Cerrar",false,wndVeh)

--------------------------------------------------------------------

wndWeap = guiCreateWindow(0,0,410,325,"Asignar arma",false)
centerWindow(wndWeap)
guiSetVisible(wndWeap,false)
weap = guiCreateLabel(5,20,405,30,"Seleccione un arma de la lista:",false,wndWeap)
guiSetFont(weap,"default-bold-small")
guiLabelSetHorizontalAlign(weap, "center", false)
gridWeap = guiCreateGridList(5,40,405,190,false,wndWeap)
guiGridListSetSelectionMode(gridWeap,1)
columnWeap1 = guiGridListAddColumn(gridWeap,"ID",0.2)
columnWeap2 = guiGridListAddColumn(gridWeap,"Arma",0.7)
for i = 1, 46 do
    if (getWeaponNameFromID(i) ~= false) then
        local row = guiGridListAddRow(gridWeap)
        guiGridListSetItemText(gridWeap, row, columnWeap1, i, false, false)
        guiGridListSetItemText(gridWeap, row, columnWeap2, getWeaponNameFromID(i), false, false)
    end
end
give_wndWeap = guiCreateButton(5,240,405,35,"Asignar",false,wndWeap)
close_wndWeap = guiCreateButton(5,280,405,35,"Cerrar",false,wndWeap)

--------------------------------------------------------------------

weather = guiCreateWindow(300, 165, 285, 390,"Clima y hora",false)
centerWindow(weather)
guiSetVisible(weather,false)

weath = guiCreateLabel(10,25,275,19,"Clima:",false, weather)
guiSetFont(weath,"default-bold-small")
guiLabelSetHorizontalAlign(weath, "center", false)

rain = guiCreateButton(10,45,270,30,"Lluvia",false, weather)
bluesky = guiCreateButton(10,80,270,30,"Cielo azul", false, weather)
sand = guiCreateButton(10,115,270,30,"Tormenta de arena", false, weather)
Dull = guiCreateButton(10,150,270,30,"Antes de la lluvia", false, weather)

timeW = guiCreateLabel(10,190,275,19,"Hora:",false, weather)
guiSetFont(timeW,"default-bold-small")
guiLabelSetHorizontalAlign(timeW, "center", false)

morning = guiCreateButton(10,210,270,30, "06:00", false, weather)
day = guiCreateButton(10,245,270,30, "12:00", false, weather)
beforenight = guiCreateButton(10,280,270,30, "18:00", false, weather)
minuit = guiCreateButton(10,315,270,30, "00:00", false, weather)
close_weather = guiCreateButton(10,350,270,30,"Cerrar",false,weather)

function weatherClick()
    if (source == rain) then
        setWeather ( 16 )
    elseif (source == bluesky) then
        setWeather (10)
    elseif (source == sand) then
        setWeather (19)
    elseif (source == Dull) then
        setWeather (12)
    elseif (source == morning) then
        setTime( 06, 0 )
    elseif (source == day) then
        setTime( 12, 0 )
    elseif (source == beforenight) then
        setTime (18, 0)
    elseif (source == minuit) then
        setTime (00,0)
    end
end
addEventHandler ("onClientGUIClick", getRootElement(), weatherClick)

addEventHandler("onClientGUIClick", root, function()
    if ( source == close_weather ) then
        guiSetVisible(weather,false)
        showCursor(false)
    end
end)

--------------------------------------------------------------------

mute = guiCreateWindow(300, 165, 285, 300, "Asignar silencio",false)
centerWindow(mute)
guiSetVisible(mute,false)

weath = guiCreateLabel(10,25,275,19,"Seleccione la duración del silencio:",false, mute)
guiSetFont(weath,"default-bold-small")
guiLabelSetHorizontalAlign(weath, "center", false)

mute1 = guiCreateButton(10,45,270,30, "2 min.", false, mute)
mute2 = guiCreateButton(10,80,270,30, "5 min.", false, mute)
mute3 = guiCreateButton(10,115,270,30, "10 min.", false, mute)
mute4 = guiCreateButton(10,150,270,30, "30 min.", false, mute)
mute5 = guiCreateButton(10,185,270,30, "1 hora", false, mute)
mute6 = guiCreateButton(10,220,270,30, "Hasta reconectar", false, mute)
close_mute = guiCreateButton(10,255,270,30,"Cerrar",false,mute)

--------------------------------------------------------------------

GUIEditor_Button = {}
GUIEditor_Label = {}
local wnd = guiCreateWindow(15,175,800,530,"Panel Administrativo - GreenWood Roleplay",false)
guiSetVisible(wnd,false)
centerWindow(wnd)

local tabPanel = guiCreateTabPanel(0, 0.04, 1, 1, true, wnd)
local tab1 = guiCreateTab("Jugadores", tabPanel)
local tab2 = guiCreateTab("Gestión de recursos", tabPanel)
local tab3 = guiCreateTab("Chat de administradores", tabPanel)
local tab4 = guiCreateTab("Reportes", tabPanel)
local tab5 = guiCreateTab("Lista de baneos", tabPanel)

local grid = guiCreateGridList(9,45,200,420,false,tab1)
guiGridListSetSelectionMode(grid,1)
local column = guiGridListAddColumn(grid,"Jugadores",0.9)

edit = guiCreateEdit(9,15,200,25,"",false,tab1)

GUIEditor_Button[1] = guiCreateButton(395,15,180,30,"Dar mute",false,tab1)
GUIEditor_Button[2] = guiCreateButton(590,15,180,30,"Dar ban",false,tab1)

GUIEditor_Button[3] = guiCreateButton(395,50,180,30,"Expulsar",false,tab1)
GUIEditor_Button[4] = guiCreateButton(590,50,180,30,"Congelar",false,tab1)

GUIEditor_Button[5] = guiCreateButton(395,85,180,30,"Dar vida (100%)",false,tab1)
GUIEditor_Button[6] = guiCreateButton(590,85,180,30,"Dar armadura (100%)",false,tab1)

GUIEditor_Button[7] = guiCreateButton(395,120,180,30,"Dar skin",false,tab1)
GUIEditor_Button[8] = guiCreateButton(590,120,180,30,"Dar jetpack",false,tab1)

GUIEditor_Button[9] = guiCreateButton(395,155,180,30,"Establecer dimensión",false,tab1)
GUIEditor_Button[10] = guiCreateButton(590,155,180,30,"Establecer interior",false,tab1)

GUIEditor_Button[11] = guiCreateButton(395,190,180,30,"Dar dinero",false,tab1)
GUIEditor_Button[12] = guiCreateButton(590,190,180,30,"Dar nivel de búsqueda",false,tab1)
GUIEditor_Button[13] = guiCreateButton(395,225,180,30,"Dar vehículo",false,tab1)
GUIEditor_Button[14] = guiCreateButton(590,225,180,30,"Dar arma",false,tab1)

GUIEditor_Button[15] = guiCreateButton(395,260,180,30,"Matar jugador",false,tab1)
GUIEditor_Button[16] = guiCreateButton(590,260,180,30,"Enviar a prisión",false,tab1)

GUIEditor_Button[17] = guiCreateButton(395,295,180,30,"Localizar jugador en el mapa",false,tab1)
GUIEditor_Button[18] = guiCreateButton(590,295,180,30,"Revocar licencia de conducir",false,tab1)

GUIEditor_Button[19] = guiCreateButton(395,330,180,30,"Quitar vida (20%)",false,tab1)
GUIEditor_Button[20] = guiCreateButton(590,330,180,30,"Establecer hora y clima",false,tab1)

GUIEditor_Button[21] = guiCreateButton(395,400,180,30,"Teletransportar en el mapa",false,tab1)
GUIEditor_Button[22] = guiCreateButton(590,400,180,30,"Teletransportar a/de jugador",false,tab1)

GUIEditor_Button[23] = guiCreateButton(395,365,180,30,"Reparar vehículo",false,tab1)
GUIEditor_Button[24] = guiCreateButton(590,365,180,30,"Eliminar vehículo",false,tab1)

GUIEditor_Button[25] = guiCreateButton(395,435,180,30,"Observar jugador",false,tab1)
GUIEditor_Button[26] = guiCreateButton(590,435,180,30,"Hacer jugador invisible",false,tab1)

GUIEditor_Label[1] = guiCreateLabel(220,15,180,20,"Nombre: N/A",false,tab1)
GUIEditor_Label[2] = guiCreateLabel(220,35,180,20,"Usuario: N/A",false,tab1)
GUIEditor_Label[3] = guiCreateLabel(220,55,180,20,"IP: N/A",false,tab1)
GUIEditor_Label[4] = guiCreateLabel(220,75,180,20,"Versión MTA: N/A",false,tab1)
GUIEditor_Label[5] = guiCreateLabel(220,95,180,20,"País: N/A",false,tab1)
GUIEditor_Label[6] = guiCreateLabel(220,115,180,20,"Skin: N/A",false,tab1)
GUIEditor_Label[7] = guiCreateLabel(220,135,180,20,"Vida: 0%",false,tab1)
GUIEditor_Label[8] = guiCreateLabel(220,155,180,20,"Armadura: 0%",false,tab1)
GUIEditor_Label[9] = guiCreateLabel(220,175,180,20,"FPS: 0",false,tab1)

GUIEditor_Label[10] = guiCreateLabel(220,195,180,20,"Ping: 0",false,tab1)
GUIEditor_Label[11] = guiCreateLabel(220,215,180,20,"Dinero en efectivo: 0",false,tab1)
GUIEditor_Label[12] = guiCreateLabel(220,235,180,20,"Dinero en banco: 0",false,tab1)
GUIEditor_Label[13] = guiCreateLabel(220,255,180,20,"Nivel de búsqueda: 0",false,tab1)
GUIEditor_Label[14] = guiCreateLabel(220,275,180,20,"Dimensión: 0",false,tab1)
GUIEditor_Label[15] = guiCreateLabel(220,295,180,20,"Interior: 0",false,tab1)
GUIEditor_Label[16] = guiCreateLabel(220,315,180,20,"Ubicación: N/A",false,tab1)
GUIEditor_Label[17] = guiCreateLabel(220,335,180,20,"Pos X: 0",false,tab1)
GUIEditor_Label[18] = guiCreateLabel(220,355,180,20,"Pos Y: 0",false,tab1)
GUIEditor_Label[19] = guiCreateLabel(220,375,180,20,"Pos Z: 0",false,tab1)

GUIEditor_Label[20] = guiCreateLabel(220,430,180,20,"Vehículo: N/A",false,tab1)
GUIEditor_Label[21] = guiCreateLabel(220,450,180,20,"Vida del vehículo: 0%",false,tab1)
guiSetVisible(wnd,false)


--------------------------------------------------------------------

memoChat = guiCreateMemo(10,15,760,410,"",false,tab3)
guiSetProperty(memoChat, "ReadOnly", "true" )

editChat = guiCreateEdit(10,435,375,35,"",false,tab3)

GUIEditor_Button[27] = guiCreateButton(395,435,375,35,"Enviar mensaje",false,tab3)

function aClientGUIAccepted ( element )
	if ( element == editChat ) then
		local message = guiGetText(editChat)
        if ( ( message ) and ( message ~= "" ) ) then
            if ( gettok ( message, 1, 32 ) == "/clear" ) then
                guiSetText ( memoChat, "" )
            else
                guiSetText(memoChat, guiGetText(memoChat)..""..getPlayerName ( localPlayer )..": "..message )
                guiSetProperty(memoChat, "CaratIndex", tostring ( string.len ( guiGetText (memoChat) ) ) )
            end
            guiSetText (editChat, "" )
        end
	end
end
addEventHandler("onClientGUIAccepted", tab3, aClientGUIAccepted)

--------------------------------------------------------------------

local gridRes = guiCreateGridList(10,50,760,340,false,tab2)
guiGridListSetSelectionMode(gridRes,1)
local columnRes1 = guiGridListAddColumn(gridRes,"Recursos",0.2)
local columnRes2 = guiGridListAddColumn(gridRes,"",0.2)
local columnRes3 = guiGridListAddColumn(gridRes,"State",0.2)
local columnRes4 = guiGridListAddColumn(gridRes,"Nombre",0.2)
local columnRes5 = guiGridListAddColumn(gridRes,"Autor",0.2)
local columnRes6 = guiGridListAddColumn(gridRes,"Versión",0.2)

aResources = {}
for id, resource in ipairs(aResources) do
        local row = guiGridListAddRow(gridRes)
        guiGridListSetItemText(gridRes, row, 1, resource["name"], false, false )
        guiGridListSetItemText(gridRes, row, 2, resource["numsettings"] > 0 and tostring(resource["numsettings"]) or "", false, false )
        guiGridListSetItemText(gridRes, row, 3, resource["state"], false, false )
        guiGridListSetItemText(gridRes, row, 4, resource["fullName"], false, false )
        guiGridListSetItemText(gridRes, row, 5, resource["author"], false, false )
        guiGridListSetItemText(gridRes, row, 6, resource["version"], false, false )
end

editRes = guiCreateEdit(10,15,760,30,"",false,tab2)

GUIEditor_Button[28] = guiCreateButton(10,395,375,35,"Comenzar",false,tab2)
GUIEditor_Button[29] = guiCreateButton(395,395,375,35,"Detener",false,tab2)
GUIEditor_Button[30] = guiCreateButton(10,435,375,35,"Reanudar",false,tab2)
GUIEditor_Button[31] = guiCreateButton(395,435,375,35,"Borrar",false,tab2)

--------------------------------------------------------------------

local gridSms = guiCreateGridList(10,15,760,410,false,tab4)
guiGridListSetSelectionMode(gridSms,1)
local column1 = guiGridListAddColumn(gridSms,"Игрок",0.2)
local column2 = guiGridListAddColumn(gridSms,"Сообщение",0.75)

GUIEditor_Button[32] = guiCreateButton(10,435,375,35,"Ответить",false,tab4)
GUIEditor_Button[33] = guiCreateButton(395,435,375,35,"Удалить",false,tab4)

function reportOn()
    wndReport = guiCreateWindow(15,175,500,180,"Репорт (Написать сообщение/задать вопрос)",false)
    centerWindow(wndReport)
    
    label_report = guiCreateLabel(10,25,490,20,"Введите сообщение, которое хотите отправить администратору:",false,wndReport)
    guiSetFont(label_report, "default-bold-small")
    guiLabelSetHorizontalAlign(label_report, "center", false)

    edit_Report = guiCreateEdit(10,50,480,35,"",false,wndReport)
    
    buy_report = guiCreateButton(10,95,480,35,"Отправить",false,wndReport)
    close_report = guiCreateButton(10,135,480,35,"Отмена",false,wndReport)
    showCursor(true)
end
addEvent("reportOn", true)
addEventHandler("reportOn",getRootElement(), reportOn)

addEventHandler("onClientGUIClick", root, function ()
    if ( source == buy_report ) then
        if guiGetText(edit_Report) ~= "" then
            reportOn()
            showCursor(false)
            outputChatBox("#1E90FF[Админ] #FFFFFFВаше сообщение успешно отправлено администратору. Ожидайте ответа.",255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ] #FFFFFFВведите сообщение. Нельзя оставить поле пустым.",255,255,255,true)
        end
    elseif ( source == close_report ) then
        reportOn()
        showCursor(false)
    end
end)

--------------------------------------------------------------------


local gridBan = guiCreateGridList(10,15,760,410,false,tab5)
guiGridListSetSelectionMode(gridBan,1)
local column1 = guiGridListAddColumn(gridBan,"Игрок",0.2)
local column2 = guiGridListAddColumn(gridBan,"Причина бана",0.75)

GUIEditor_Button[34] = guiCreateButton(10,435,760,35,"Разбанить",false,tab5)

--------------------------------------------------------------------

for i,btn in ipairs(GUIEditor_Button) do
	guiSetFont(btn,"default-bold-small")
end

for i,label in ipairs(GUIEditor_Label) do
	guiSetFont(label,"default-bold-small")
	guiLabelSetColor(label,255,255,255)
end

function open()
	triggerServerEvent("AdminPanel",localPlayer)
end
bindKey("o","down",open)

addEvent("openWindow",true)
addEventHandler("openWindow", root, function ()
    if guiGetVisible(wnd) then
        guiSetVisible(wnd,false)
        showCursor(false)
    else
        guiSetVisible(wnd,true)
        showCursor(true)
        updateGridListPol()
    end
end)

function updateGridListPol()
    if not isElement( wnd ) then
	    return
	end
	
    local rw, cl = guiGridListGetSelectedItem(grid)
    guiGridListClear(grid)
    for i,player in ipairs(getElementsByType("player")) do
        local row = guiGridListAddRow(grid)
        guiGridListSetItemText(grid, row, column, (string.gsub ( getPlayerName(player), '#%x%x%x%x%x%x', '' ) or getPlayerName(player)), false, false)
        guiGridListSetItemData(grid, row, column, getPlayerName(player))
    end
    guiGridListSetSelectedItem(grid, rw, cl)
end

addEventHandler("onClientGUIChanged", root, function()
    if ( source == edit ) then
        local text = guiGetText(edit)
        if ( text == "" ) then
            updateGridListPol()
        else
            guiGridListClear(grid)
            for i,v in ipairs(getElementsByType("player")) do
                local name = getPlayerName(v)
                if string.find(name,text) then
                    local row = guiGridListAddRow(grid)
                    guiGridListSetItemText(grid, row, column, (string.gsub ( getPlayerName(player), '#%x%x%x%x%x%x', '' ) or getPlayerName(player)), false, false)
                    guiGridListSetItemData(grid, row, column, getPlayerName(player))
                end
            end
        end
    end
end)

---------------------------------------------------------- Обновление ГридЛиста при входе/выходе игрока

function remotePlayerJoin()
	updateGridListPol()
end
addEventHandler("onClientPlayerJoin", getRootElement(), remotePlayerJoin)

function onQuitGame( reason )
    updateGridListPol()
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )

---------------------------------------------------------- onClientGUIClick

addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == GUIEditor_Button[1] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(mute,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[2] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndBan,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[3] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("kickPlayerAdmin",getRootElement(),player)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно кикнули игрока "..player,255,255,255,true)
            guiSetVisible(wnd,false)
            showCursor(false)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[4] ) then
        if player and playerWithoutColorCodes then
            if freezeOn then
                freezeOn = false
                guiSetText(GUIEditor_Button[4], "Заморозить")
                triggerServerEvent("anFreezePlayer",getRootElement(),player)
                outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно разморозили игрока "..player,255,255,255,true)
            else
                freezeOn = true
                guiSetText(GUIEditor_Button[4], "Разморозить")
                triggerServerEvent("freezePlayer",getRootElement(),player)
                outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно заморозили игрока "..player,255,255,255,true)
            end
            guiSetVisible(wnd,false)
            showCursor(false)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[5] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("healthPlayer",getRootElement(),player)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 100 % здоровья игроку "..player,255,255,255,true)
            guiSetVisible(wnd,false)
            showCursor(false)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[6] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("armorPlayer",getRootElement(),player)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 100 % брони игроку "..player,255,255,255,true)
            guiSetVisible(wnd,false)
            showCursor(false)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[7] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndSkin,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[8] ) then
        if player and playerWithoutColorCodes then
            if jetOn then
                jetOn = false
                guiSetText(GUIEditor_Button[8], "Выдать джетпак")
                triggerServerEvent("jetpackPlayer",getRootElement(),player)
                outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно отняли джетпак у  игрока "..player,255,255,255,true)
            else
                jetOn = true
                guiSetText(GUIEditor_Button[8], "Отнять джетпак")
                triggerServerEvent("jetpackPlayer",getRootElement(),player)
                outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали джетпак игроку "..player,255,255,255,true)
            end
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[9] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndDimen,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[10] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndInt,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[11] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndMoney,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[12] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wanted,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[13] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndVeh,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[14] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndWeap,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[15] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            showCursor(false)
            triggerServerEvent("commSuicide",getRootElement(),player)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[16] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("hitTheOs",getRootElement(),player)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно посадили игрока "..player.." #FF0000в тюрьму.",255,255,255,true)
            guiSetVisible(wnd,false)
            showCursor(false)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[17] ) then
        if player and playerWithoutColorCodes then
            if not getElementData(localPlayer, "blip") then
                setElementData(localPlayer, "blip", true)
                createBlipAttachedTo(getPlayerFromName(player), 41, 4, 255, 0, 0, 255, 0, 65535, localPlayer)
            else
                setElementData(localPlayer, "blip", false)
                local attached = getAttachedElements(getPlayerFromName(player))
                if (attached) then
                    for k,element in ipairs(attached) do
                        if getElementType(element) == "blip" then
                            destroyElement(element)
                        end
                    end
                end
            end
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[18] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("onPrava",getRootElement(),player)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно забрали водительское удостоверение у "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == wan1 ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("wantedLevel1",getRootElement(),player)
            guiSetVisible(wanted,false)
            showCursor(false)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 1 звезду розыска игроку "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == wan2 ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("wantedLevel2",getRootElement(),player)
            guiSetVisible(wanted,false)
            showCursor(false)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 2 звезды розыска игроку "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == wan3 ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("wantedLevel3",getRootElement(),player)
            guiSetVisible(wanted,false)
            showCursor(false)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 3 звезды розыска игроку "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == wan4 ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("wantedLevel4",getRootElement(),player)
            guiSetVisible(wanted,false)
            showCursor(false)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 4 звезды розыска игроку "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == wan5 ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("wantedLevel5",getRootElement(),player)
            guiSetVisible(wanted,false)
            showCursor(false)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 5 звезд розыска игроку "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == wan6 ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("wantedLevel6",getRootElement(),player)
            guiSetVisible(wanted,false)
            showCursor(false)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали 6 звезд розыска игроку "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == wan7 ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("wantedLevel7",getRootElement(),player)
            guiSetVisible(wanted,false)
            showCursor(false)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно сняли все звезды у игрока "..player,255,255,255,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[19] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("anHealthPlayer",getRootElement(),player)
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно отняли 20 % здоровья у игрока "..player,0,255,0,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[20] ) then
        guiSetVisible(wnd,false)
        guiSetVisible(weather,true)
    elseif ( source == GUIEditor_Button[21] ) then
        guiSetVisible(wnd,false)
        guiSetVisible(wndTpMap,true)
    elseif ( source == GUIEditor_Button[22] ) then
        if player and playerWithoutColorCodes then
            guiSetVisible(wnd,false)
            guiSetVisible(wndTp,true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[23] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("fixVeh",getRootElement(),player)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[24] ) then
        if player and playerWithoutColorCodes then
            triggerServerEvent("destroyVeh",getRootElement(),player)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[25] ) then
        if player and playerWithoutColorCodes then
            setCameraTarget(getPlayerFromName(player))
            setElementFrozen(getLocalPlayer(), true)
            guiSetVisible(wnd,false)
            guiSetVisible(wndfollow,true)
            showCursor(false)
            setElementData(getLocalPlayer(), "Cursor", true)
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == close_wndfollow ) then
        setCameraTarget(getLocalPlayer())
        setElementFrozen(getLocalPlayer(), false)
        guiSetVisible(wnd,true)
        showCursor(true)
        guiSetVisible(wndfollow,false)
        setElementData(getLocalPlayer(), "Cursor", false)
    elseif ( source == GUIEditor_Button[26] ) then
        if player and playerWithoutColorCodes then
            if getElementAlpha(getPlayerFromName(player)) == 255 then
                setElementAlpha(getPlayerFromName(player),0)
                guiSetText(GUIEditor_Button[26], "Сделать игрока видимым")
            else
                setElementAlpha(getPlayerFromName(player),255)
                guiSetText(GUIEditor_Button[26], "Сделать игрока невидимым")
            end
        else
            outputChatBox("#1E90FF[Админ-панель] #FFFFFFВыберите игрока из списка.",255,255,255,true)
        end
    elseif ( source == GUIEditor_Button[27] ) then
        local message = guiGetText(editChat)
        if ( ( message ) and ( message ~= "" ) ) then
            if ( gettok ( message, 1, 32 ) == "/clear" ) then
                guiSetText ( memoChat, "" )
            else
                guiSetText(memoChat, guiGetText(memoChat)..""..getPlayerName ( localPlayer )..": "..message )
                guiSetProperty(memoChat, "CaratIndex", tostring ( string.len ( guiGetText (memoChat) ) ) )
            end
            guiSetText (editChat, "" )
        end
    end
end)

addEventHandler("onClientGUIClick", resourceRoot, function()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    local jugador = player
    if (source == grid) then
        if ( guiGridListGetSelectedItem(grid) ~= -1) then
            local nombre = getPlayerName(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[1], "Nombre: "..nombre)
            
            local login = getElementData(getPlayerFromName(jugador), "p:login") or "N/A"
            guiSetText(GUIEditor_Label[2], "Login: "..login)
            
            local IP = getElementData(getPlayerFromName(jugador), "p:IP") or "N/A"
            guiSetText(GUIEditor_Label[3], "IP: "..IP)
            
            local version = getElementData(getPlayerFromName(jugador), "p:Version") or "N/A"
            guiSetText(GUIEditor_Label[4], "Versión MTA: "..version)
            
            local nombrePais = getCountryNameFromCode()
            guiSetText(GUIEditor_Label[5], "País: "..nombrePais)
        
            local skin = getElementModel(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[6], "Skin: "..skin)
        
            local salud = getElementHealth(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[7], "Salud: "..salud.." %")
        
            local armadura = getPedArmor(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[8], "Armadura: "..armadura.." %")
        
            local FPS = getElementData(getPlayerFromName(jugador), "FPS")
            guiSetText(GUIEditor_Label[9], "FPS: "..FPS)
        
            local ping = getPlayerPing(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[10], "Ping: "..ping)
        
            local dinero = getPlayerMoney(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[11], "Efectivo: "..dinero.." $")
            
            local dineroBanco = getElementData(getPlayerFromName(jugador), "p:Money")
            guiSetText(GUIEditor_Label[12], "Dinero en el banco: "..dineroBanco.." $")

            local nivelBuscado = getPlayerWantedLevel() or 0
            guiSetText(GUIEditor_Label[13], "Nivel de búsqueda: "..nivelBuscado)
        
            local dimension = getElementDimension(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[14], "Dimensión: "..dimension)
        
            local interior = getElementInterior(getPlayerFromName(jugador))
            guiSetText(GUIEditor_Label[15], "Interior: "..interior)
        
            local x, y, z = getElementPosition(getPlayerFromName(jugador))
            local area = getZoneName(x, y, z)
            guiSetText(GUIEditor_Label[16], "Ubicación: "..area)
            guiSetText(GUIEditor_Label[17], "Pos X: "..x)
            guiSetText(GUIEditor_Label[18], "Pos Y: "..y)
            guiSetText(GUIEditor_Label[19], "Pos Z: "..z)
            
            local vehiculo = getPedOccupiedVehicle(getPlayerFromName(jugador))
            if vehiculo then
                local auto = getVehicleNameFromModel(getElementModel(vehiculo))
                guiSetText(GUIEditor_Label[20], "Vehículo: "..auto)
            else
                guiSetText(GUIEditor_Label[20], "Vehículo: N/A")
            end
            
            local saludVehiculo = getPedOccupiedVehicle(getPlayerFromName(jugador))
            if saludVehiculo then
                local saludAuto = getElementHealth(saludVehiculo) or 0
                guiSetText(GUIEditor_Label[21], "Salud del vehículo: "..math.floor(saludAuto) / 10 .." %")
            else
                guiSetText(GUIEditor_Label[21], "Salud del vehículo: 0 %")
            end
        else
             guiSetText(GUIEditor_Label[1], "Nombre: N/A")
            guiSetText(GUIEditor_Label[2], "Login: N/A")
            guiSetText(GUIEditor_Label[3], "IP: N/A")
            guiSetText(GUIEditor_Label[4], "Versión MTA: N/A")
            guiSetText(GUIEditor_Label[5], "País: N/A")
            guiSetText(GUIEditor_Label[6], "Skin: N/A")
            guiSetText(GUIEditor_Label[7], "Salud: 0 %")
            guiSetText(GUIEditor_Label[8], "Armadura: 0 %")
            guiSetText(GUIEditor_Label[9], "FPS: 0")
            guiSetText(GUIEditor_Label[10], "Ping: 0")
            guiSetText(GUIEditor_Label[11], "Efectivo: 0 $")
            guiSetText(GUIEditor_Label[12], "Dinero en el banco: 0 $")
            guiSetText(GUIEditor_Label[13], "Nivel de búsqueda: 0")
            guiSetText(GUIEditor_Label[14], "Dimensión: 0")
            guiSetText(GUIEditor_Label[15], "Interior: 0")
            guiSetText(GUIEditor_Label[16], "Ubicación: N/A")
            guiSetText(GUIEditor_Label[17], "Pos X: 0")
            guiSetText(GUIEditor_Label[18], "Pos Y: 0")
            guiSetText(GUIEditor_Label[19], "Pos Z: 0")
            guiSetText(GUIEditor_Label[20], "Vehículo: N/A")
            guiSetText(GUIEditor_Label[21], "Salud del vehículo: 0 %")
        end
    end
end)
addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == mute1 ) then
        triggerServerEvent("mutePlayer1",getRootElement(),player)
        outputChatBox("#1E90FF[Panel de Admin] #FFFFFFHas silenciado con éxito al jugador por 2 minutos: "..player,255,255,255,true)
        guiSetVisible(mute,false)
        showCursor(false)
    elseif ( source == mute2 ) then
        triggerServerEvent("mutePlayer2",getRootElement(),player)
        outputChatBox("#1E90FF[Panel de Admin] #FFFFFFHas silenciado con éxito al jugador por 5 minutos: "..player,255,255,255,true)
        guiSetVisible(mute,false)
        showCursor(false)
    elseif ( source == mute3 ) then
        triggerServerEvent("mutePlayer3",getRootElement(),player)
        outputChatBox("#1E90FF[Panel de Admin] #FFFFFFHas silenciado con éxito al jugador por 10 minutos: "..player,255,255,255,true)
        guiSetVisible(mute,false)
        showCursor(false)
    elseif ( source == mute4 ) then
        triggerServerEvent("mutePlayer4",getRootElement(),player)
        outputChatBox("#1E90FF[Panel de Admin] #FFFFFFHas silenciado con éxito al jugador por 30 minutos: "..player,255,255,255,true)
        guiSetVisible(mute,false)
        showCursor(false)
    elseif ( source == mute5 ) then
        triggerServerEvent("mutePlayer5",getRootElement(),player)
        outputChatBox("#1E90FF[Panel de Admin] #FFFFFFHas silenciado con éxito al jugador por 1 hora: "..player,255,255,255,true)
        guiSetVisible(mute,false)
        showCursor(false)
    elseif ( source == mute6 ) then
        triggerServerEvent("mutePlayer6",getRootElement(),player)
        outputChatBox("#1E90FF[Panel de Admin] #FFFFFFHas silenciado con éxito al jugador hasta que vuelva a conectarse: "..player,255,255,255,true)
        guiSetVisible(mute,false)
        showCursor(false)
    elseif ( source == close_mute ) then
        guiSetVisible(mute,false)
        showCursor(false)
    end
end)


addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == give_wndMoney ) then
        local text = guiGetText(editMoney)
        triggerServerEvent("giveMoneyAdmin",getRootElement(),player,text)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали #00FF00"..text.." #FFFFFFруб. игроку "..player,255,255,255,true)
        guiSetVisible(wndMoney,false)
        showCursor(false)
    elseif ( source == close_wndMoney ) then
        guiSetVisible(wndMoney,false)
        showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == give_wndSkin ) then
        local text = guiGetText(editSkin)
        triggerServerEvent("giveSkinAdmin",getRootElement(),player,text)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали скин под ID:#00FF00"..text.." #FFFFFFигроку "..player,255,255,255,true)
        guiSetVisible(wndSkin,false)
        showCursor(false)
    elseif ( source == close_wndSkin ) then
        guiSetVisible(wndSkin,false)
        showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == give_wndDimen ) then
        local text = guiGetText(editDimen)
        triggerServerEvent("giveDimensionAdmin",getRootElement(),player,text)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно установили измерение #00FF00"..text.." #FFFFFFигроку "..player,255,255,255,true)
        guiSetVisible(wndDimen,false)
        showCursor(false)
    elseif ( source == close_wndDimen ) then
        guiSetVisible(wndDimen,false)
        showCursor(false)
    end
end)


addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == give_wndBan ) then
        local text = guiGetText(editBan)
        triggerServerEvent("banPlayerAdmin",getRootElement(),player,text)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали бан игроку "..player..", по причине: "..text,255,255,255,true)
        guiSetVisible(wndBan,false)
        showCursor(false)
    elseif ( source == close_wndBan ) then
        guiSetVisible(wndBan,false)
        showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == give_wndVeh ) then
        local row = guiGridListGetSelectedItem(gridVeh)
        triggerServerEvent("giveVehicleAdmin",getRootElement(),player,guiGridListGetItemText(gridVeh, row, 1),guiGridListGetItemText(gridVeh, row, 2))
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали автомобиль "..guiGridListGetItemText(gridVeh, row, 2)..", игроку "..player,255,255,255,true)
        guiSetVisible(wndVeh,false)
        showCursor(false)
    elseif ( source == close_wndVeh ) then
        guiSetVisible(wndVeh,false)
        showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == give_wndWeap ) then
        local row = guiGridListGetSelectedItem(gridWeap)
        triggerServerEvent("giveWeaponAdmin",getRootElement(),player,guiGridListGetItemText(gridWeap, row, 1),guiGridListGetItemText(gridWeap, row, 2))
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно выдали "..guiGridListGetItemText(gridWeap, row, 2)..", игроку "..player,255,255,255,true)
        guiSetVisible(wndWeap,false)
        showCursor(false)
    elseif ( source == close_wndWeap ) then
        guiSetVisible(wndWeap,false)
        showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == give_wndInt ) then
        local row = guiGridListGetSelectedItem(gridInt)
        triggerServerEvent("giveInteriorAdmin",getRootElement(),player,guiGridListGetItemText(gridInt, row, 1),guiGridListGetItemText(gridInt, row, 3),guiGridListGetItemText(gridInt, row, 4),guiGridListGetItemText(gridInt, row, 5),guiGridListGetItemText(gridInt, row, 6))
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно установили "..guiGridListGetItemText(gridInt, row, 1).." интерьер, игроку "..player,255,255,255,true)
        guiSetVisible(wndInt,false)
        showCursor(false)
    elseif ( source == close_wndInt ) then
        guiSetVisible(wndInt,false)
        showCursor(false)
    end
end)

addEventHandler("onClientGUIClick", root, function ()
    local selectedRow, selectedColumn = guiGridListGetSelectedItem(grid)
    local player = guiGridListGetItemData(grid, selectedRow, selectedColumn)
    local playerWithoutColorCodes = guiGridListGetItemText(grid, selectedRow, selectedColumn)
    
    if ( source == tp1 ) then
        triggerServerEvent("giveTPAdmin1",getRootElement(),localPlayer,player)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно телепортировались к игроку "..player,255,255,255,true)
        guiSetVisible(wndTp,false)
        showCursor(false)
    elseif ( source == tp2 ) then
        triggerServerEvent("giveTPAdmin2",getRootElement(),localPlayer,player)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно телепортировали игрока "..player.." к себе.",255,255,255,true)
        guiSetVisible(wndTp,false)
        showCursor(false)
    elseif ( source == close_Tp ) then
        guiSetVisible(wndTp,false)
        showCursor(false)
    end
end)

---------------------------------------------------------- FPS

local counter = 0
local starttick
local currenttick

addEventHandler("onClientRender", getRootElement(), function()
    if not starttick then
        starttick = getTickCount()
    end
    counter = counter + 1
    currenttick = getTickCount()
    if currenttick - starttick >= 1000 then
        setElementData(getLocalPlayer(),"FPS",counter)
        counter = 0
        starttick = false
    end
end)

---------------------------------------------------------- Скрытие курсора во-время слежки

kursor = true

bindKey("mouse2", "down", function()
    if getElementData(getLocalPlayer(), "Cursor") == true then
        if kursor then
            showCursor(true)
            kursor = false
        else
            showCursor(false)
            kursor = true
        end
    end
end)