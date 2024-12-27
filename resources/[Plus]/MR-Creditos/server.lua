loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')


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






function darCreditos(player, cmd, otro, cantidad)
    local jugador = getPlayerFromName(otro)
    local cantidad = tonumber(cantidad) -- Convertir la cantidad a número
    
    if not cantidad or cantidad <= 0 then
        outputChatBox("La cantidad debe ser un número positivo", player)
        return
    end
    
    if jugador then
        -- Restar créditos al jugador que usa el comando
        if getElementData(player, "Roleplay:Creditos") and getElementData(player, "Roleplay:Creditos") >= cantidad then
            setElementData(player, "Roleplay:Creditos", getElementData(player, "Roleplay:Creditos") - cantidad)
            -- Añadir créditos al otro jugador
            setElementData(jugador, "Roleplay:Creditos", (getElementData(jugador, "Roleplay:Creditos") or 0) + cantidad)
            -- Notificar a ambos jugadores
            outputChatBox("#f8ff58[CREDITOS] #ffFFffHas transferido #00ff00" .. cantidad .. "#ffFFff créditos a #F8ed04" .. otro, player,255,255,255,true)
            outputChatBox("#f8ff58[CREDITOS] #ffFFffHas recibido #00ff00" .. cantidad .. "#ffFFff créditos de #F8ed04" .. getPlayerName(player), jugadorplayer,255,255,255,true)
        else
            outputChatBox("No tienes suficientes créditos para transferir", player)
        end
    elseif tonumber(otro) then
        local targetPlayer = getPlayerFromPartialNameID(otro)
        if targetPlayer then
            -- Restar créditos al jugador que usa el comando
            if getElementData(player, "Roleplay:Creditos") and getElementData(player, "Roleplay:Creditos") >= cantidad then
                setElementData(player, "Roleplay:Creditos", getElementData(player, "Roleplay:Creditos") - cantidad)
                -- Añadir créditos al otro jugador
                setElementData(targetPlayer, "Roleplay:Creditos", (getElementData(targetPlayer, "Roleplay:Creditos") or 0) + cantidad)
                -- Notificar a ambos jugadores
                outputChatBox("#f8ff58[CREDITOS] #ffFFffHas transferido #00ff00" .. cantidad .. "#ffFFff créditos a #F8ed04" .. getPlayerName(targetPlayer), player,255,255,255,true)
                outputChatBox("#f8ff58[CREDITOS] #ffFFffHas recibido #00ff00" .. cantidad .. "#ffFFff créditos de #F8ed04" .. getPlayerName(player), targetPlayer,255,255,255,true)
            else
                outputChatBox("#ff3d3d* No tienes suficientes créditos para transferir", player,255,255,255,true)
            end
        else
            outputChatBox("#ff3d3d* ID de jugador no válida", player,255,255,255,true)
        end
    else
        outputChatBox("#ff3d3d* Ningún jugador encontrado", player,255,255,255,true)
    end
end
addCommandHandler("darcreditos", darCreditos)


function darCreditos2(player, cmd, otro, cantidad)
    -- Verificar si el jugador que ejecuta el comando es un administrador
local accName = getAccountName ( getPlayerAccount ( player ) )
     if not isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then -- Does he have access to Admin functions?
   outputChatBox("Solo los administradores pueden usar este comando", player)
          return
        
     end

    
    local jugador = getPlayerFromName(otro)
    local cantidad = tonumber(cantidad) -- Convertir la cantidad a número
    
    if not cantidad or cantidad <= 0 then
        outputChatBox("La cantidad debe ser un número positivo", player)
        return
    end
    
    if jugador then
        -- Añadir créditos al otro jugador
        setElementData(jugador, "Roleplay:Creditos", (getElementData(jugador, "Roleplay:Creditos") or 0) + cantidad)
        -- Notificar al jugador
        outputChatBox("#f8ff58[CREDITOS] #ffFFffHas recibido #00ff00" .. cantidad .. "#FFffFF créditos de un administrador", jugador,255,255,255,true)
        -- Notificar al administrador
        outputChatBox("#f8ff58[CREDITOS] #ffFFffHas otorgado #00ff00" .. cantidad .. "#ffFFff créditos a " .. getPlayerName(jugador), player,255,255,255,true)
    else
        outputChatBox("#ff3d3d* Ningún jugador encontrado", player,255,255,255,true)
    end
end

-- Agregar el comando "givecredits" y vincularlo a la función darCreditos
addCommandHandler("givecredits", darCreditos2)




function vercreditos(player,cmd)
   local miscreditos = getElementData(player, "Roleplay:Creditos")
    
        outputChatBox("#f8ff58[CREDITOS] #ffFFffTienes " .. miscreditos .. "#ffFFff créditos.", player,255,255,255,true)
   
end
addCommandHandler("miscreditos",vercreditos)
addCommandHandler("vercreditos",vercreditos)




addEventHandler("onPlayerLogin", root, 
function(_, account) 
    if not getAccountData(account, "EntroCreditos") then 
        setAccountData(account,"Roleplay:Creditos",0)
        setAccountData(account, "EntroCreditos", true) 
    end 
end) 

function CargarDatos (cuenta)
    local player = getAccountPlayer(cuenta)
    local Jobsf = getAccountData(cuenta, "Roleplay:Creditos")
     setElementData(player, "Roleplay:Creditos", Jobsf )
   end
   
   addEventHandler ( "onPlayerLogin", root,
     function ( _, acc )
       setTimer ( CargarDatos, 60, 1, acc )
     end
   )
   
   addEventHandler ( "onPlayerJoin", root,
     function ( _, acc )
       setTimer ( CargarDatos, 60, 1, acc )
     end
   )
   
   function Start_Trabajo ( res )
       if res == getThisResource ( ) then
           for i, player in ipairs(getElementsByType("player")) do
               local acc = getPlayerAccount ( player )
               if not isGuestAccount ( acc ) then
                   CargarDatos ( acc )
               end
           end
       end
   end
   addEventHandler ( "onResourceStart", getRootElement ( ), Start_Trabajo )
   
   function Stop_Trabajo ( res )
       if res == getThisResource ( ) then
           for i, player in ipairs(getElementsByType("player")) do
               local acc = getPlayerAccount ( player )
               if not isGuestAccount ( acc ) then
                   CargarDatos ( acc )
               end
           end
       end
   end 
   addEventHandler ( "onResourceStop", getRootElement(), Stop_Trabajo )
   
   function Quit_Server ( quitType )
       local acc = getPlayerAccount(source)
       if not isGuestAccount ( acc ) then
           if acc then
               CargarDatos ( acc )
           end
       end
   end
   addEventHandler ( "onPlayerQuit", getRootElement(), Quit_Server )
