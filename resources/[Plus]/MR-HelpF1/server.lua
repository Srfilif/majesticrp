noreporte = 0
addEvent("MajesticF1:SalirServidor", true)
addEventHandler("MajesticF1:SalirServidor", root, function(reason)
    -- Asegúrate de que el evento sea llamado por un jugador
    if client then
        -- Kickea al jugador con el motivo especificado
        kickPlayer(client, "Has sido salido de Majestic Roleplay, Vuelve pronto :3")
    end
end)



------------
local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second

local monthday = time.monthday
local month = time.month
local year = time.year

local formattedTime = string.format('%02d/%02d/%02d - %02d:%02d:%02d', monthday, month + 1, year + 1900, hours, minutes, seconds)




function msg(webhook, message,Nombre)
        local Jugador = getPlayerFromName(Nombre)
		 x, y, z = getElementPosition(Jugador) 
	     local PosiJugador = getZoneName(x, y, z)
		 local money = getPlayerMoney(Jugador)               
		  local ping = getPlayerPing(Jugador)  
		   local version = getPlayerVersion ( Jugador )
		   local playerHealth = getElementHealth ( Jugador )

   message_staffs(Jugador,message)

noreporte = noreporte + 1
        local dados = {
        embeds = {
            { -- embed 1
            title = "Reportes Bugs - Majestic Roleplay",
            color = 16734296,
            description = "",
            fields = {
                {
                    name = "El jugador, "..Nombre.." ha enviado un nuevo reporte de BUG\n",
                    value = "\n**Reporte N°:** #00"..noreporte.."",
					
                },
	
				{
                    name = "",
                    value = "",
                },
				{
                    name = "\n Descripcion del Reporte:",
                    value = '```'..message..'```',
                },
				{
                    name = "\n Detalles del jugador:",
                    value = "Ubicacion: `"..PosiJugador.."`\nPosicion: `"..x..", "..y..","..z.."`\nPing: `"..ping.."`\nDinero: `"..money.."`\nVersion: `"..version.."`\nHealth: `"..playerHealth.."`",
                },
				
            },
            thumbnail = {
                url = "https://media.discordapp.net/attachments/1162875391443218583/1190440728812326962/majesticrp.webp?ex=65ab09d3&is=659894d3&hm=6974fb2aa3817bf6ee867fb0cc76cc888a1bec1a8d71a0234899c11c2e5c9973&=&format=webp",
            },
			footer = {
                text = "Sistema de Reportes - Majestic Roleplay | Developed by SrFilif </> | "..formattedTime.."",
			},
			
        },
    }
    }
  
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    sendOptions = {
        queueName = 'dcq',
        connectionAttempts = 3,
        connectTimeout = 5000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote(webhook, sendOptions, callback)
end
addEvent('MajesticF1:SendReport', true)
addEventHandler('MajesticF1:SendReport', root, msg)

function callback()
end

local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second

local monthday = time.monthday
local month = time.month
local year = time.year

local formattedTime = string.format('%02d/%02d/%02d - %02d:%02d:%02d', monthday, month + 1, year + 1900, hours, minutes, seconds)



-- Archivo: resource.lua
local xmlFile = "extra.xml"

function loadNoReporteFromXML()
    local xml = xmlLoadFile(xmlFile)
    if xml then
        local countNode = xmlFindChild(xml, "count", 0)
        if countNode then
            noreporte = tonumber(xmlNodeGetValue(countNode)) or 0
        end
        xmlUnloadFile(xml)
    end
end


function saveNoReporteToXML()
    local xml = xmlCreateFile(xmlFile, "noreportes")
    local countNode = xmlCreateChild(xml, "count")
    xmlNodeSetValue(countNode, tostring(noreporte))
    xmlSaveFile(xml)
    xmlUnloadFile(xml)
end

-- Resto del código...

-- Resto del código...

-- Carga el total de reclamaciones al iniciar el recurso
addEventHandler("onResourceStart", resourceRoot, function()
    loadNoReporteFromXML()
    outputServerLog("Total de reclamaciones cargado: " .. noreporte)
   
end)

-- Guarda el total de reclamaciones al detener el recurso
addEventHandler("onResourceStop", resourceRoot, function()
    saveNoReporteToXML()
    outputServerLog("Total de reclamaciones guardado: " .. noreporte)
     
end)



function msgUsu(webhook, message,Nombre)
        local Jugador = getPlayerFromName(Nombre)
		 x, y, z = getElementPosition(Jugador) 
	     local PosiJugador = getZoneName(x, y, z)
		 local money = getPlayerMoney(Jugador)               
		  local ping = getPlayerPing(Jugador)  
		   local version = getPlayerVersion ( Jugador )
		   local playerHealth = getElementHealth ( Jugador )

   message_staffs(Jugador,message)
noreporte = noreporte + 1
        local dados = {
        embeds = {
            { -- embed 1
            title = "Reportes Jugadores - Majestic Roleplay",
            color = 5832596,
            description = "",
            fields = {
                {
                    name = "El jugador, "..Nombre.." ha enviado un nuevo reporte de Usuario\n",
                    value = "\n**Reporte N°:** #00"..noreporte.."",
					
                },
	
				{
                    name = "",
                    value = "",
                },
				{
                    name = "\n Descripcion del Reporte:",
                    value = '```'..message..'```',
                },
				{
                    name = "\n Detalles del jugador:",
                    value = "Ubicacion: `"..PosiJugador.."`\nPosicion: `"..x..", "..y..","..z.."`\nPing: `"..ping.."`\nDinero: `"..money.."`\nVersion: `"..version.."`\nHealth: `"..playerHealth.."`",
                },
				
            },
            thumbnail = {
                url = "https://media.discordapp.net/attachments/1162875391443218583/1190440728812326962/majesticrp.webp?ex=65ab09d3&is=659894d3&hm=6974fb2aa3817bf6ee867fb0cc76cc888a1bec1a8d71a0234899c11c2e5c9973&=&format=webp",
            },
			footer = {
                text = "Sistema de Reportes - Majestic Roleplay | Developed by SrFilif </> | "..formattedTime.."",
			},
			
        },
    }
    }
  
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    sendOptions = {
        queueName = 'dcq',
        connectionAttempts = 3,
        connectTimeout = 5000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote(webhook, sendOptions, callback)
end
addEvent('MajesticF1:SendReportUsu', true)
addEventHandler('MajesticF1:SendReportUsu', root, msgUsu)




function message_staffs(player,message)
	if isElement(player) then
		for i, v in ipairs(getElementsByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) then
				v:outputChat("#3ec9f0[REPORTES]#ffFFffEl  jugador #ffe458*["..player:getData("ID").."]"..getPlayerName(player).." #ffFFffA enviado un nuevo reporte:", 255, 255, 255, true)
v:outputChat("#3ec9f0[REPORTES]#ffe458*["..player:getData("ID").."]"..getPlayerName(player)..": #ffFFff"..message..".", 255, 255, 255, true)
				v:outputChat("#3ec9f0[REPORTES] #ffFFff¡Usa /ir [Nombre_Apellido o ID] para ir donde el!", 255, 255, 255, true)
			end
		end
	end
	return false
end
