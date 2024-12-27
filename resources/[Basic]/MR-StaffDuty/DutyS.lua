--THEHACKER5 AUTHOR

ComandoDuty = "staffduty"
ComandoOffDuty = "offduty"
teamStaff = getTeamFromName("Staff")

function Duty (thePlayer)
local Duty = getElementData(thePlayer,"StaffDuty") or 0
  local NombreStaff = getElementData(thePlayer,"StaffName")
   if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Ayudante")) then
   local Nombre_Apellido = getPlayerName(thePlayer)
   local SPlayer_Name = getElementData(thePlayer,"SPlayer_Name")
   if NombreStaff == "None" then
	
outputChatBox("#ff3d3d* No tienes definido un nombre de administracion, pidele a un encargado que te lo asigne",thePlayer,255,255,255,true)
return
   end
   
   if Duty == 0 then
	  setElementData(thePlayer,"SPlayer_Name",Nombre_Apellido)
	  setPlayerName (thePlayer, NombreStaff )
      local skin = getElementModel(thePlayer)
	  setElementData(thePlayer,"OriginalSkin",skin)
	  team = getPlayerTeam( thePlayer )
      setElementModel( thePlayer, 217 )
	  outputChatBox( "#ffe000[Administracion] #ffffffEl miembro del staff #ff8400"..NombreStaff.."#ffffff a entrado en servicio de staff llamalo con /payuda o si tienes alguna duda pon /duda (Texto)", root, 0, 255, 0, true )
      setElementHealth(thePlayer, 100)
	  setElementData(thePlayer,"StaffDuty",1)
      triggerClientEvent(thePlayer, "verTexto", thePlayer)
	  setPlayerTeam(thePlayer , teamStaff)   
	 else
    outputChatBox ("#ff3d3d* Ya estas en servicio, Para salir usa /offduty", thePlayer,255,0,0,true)
	 end
	else 
	outputChatBox ("#ff3d3d* No tienes permisos para usar esto", thePlayer,255,0,0,true)
  end
end
addCommandHandler( ComandoDuty, Duty )

function Offduty (thePlayer)
local Duty = getElementData(thePlayer,"StaffDuty") or 0
  local NombreStaff = getElementData(thePlayer,"StaffName") or "None"
 local SPlayer_Name = getElementData(thePlayer,"SPlayer_Name")
  if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(thePlayer)), aclGetGroup ("Ayudante")) then
     if Duty == 1 then
	 	--  setElementData(thePlayer,"SPlayer_Name",SPlayer_Name)
		  setPlayerName (thePlayer, SPlayer_Name )
		  local myskin = getElementData(thePlayer,"OriginalSkin")
   setElementModel( thePlayer, myskin )
   
	outputChatBox("#ffe000[Administracion] #ffffffEl miembro del staff #ff8400"..NombreStaff.." #ffffffa salido del servicio de staff, Ya no esta disponible.",root, 255, 0, 0, true )
	 setElementHealth(thePlayer, 100)
     triggerClientEvent(thePlayer, "noverTexto", thePlayer)
	 setPlayerTeam(thePlayer, team)
     setElementData(thePlayer,"StaffDuty",0)
	 	 else
outputChatBox ("#ff3d3d* No estas en servicio, Para entrar usa /staffduty", thePlayer,255,0,0,true)
end
	else
	outputChatBox ("#ff3d3d* No tienes permisos para usar esto", thePlayer,255,0,0,true)
  end
end	
  addCommandHandler(ComandoOffDuty, Offduty)
  
 
  -----------------------------------------------------------𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼𓀼-------------------------HOLA WAPO
  

-- Función para asignar rol de staff
function darstaff(source, commandName, playerName, typeargument)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(source)), aclGetGroup("Admin")) then
        if not playerName or not typeargument then
            outputChatBox("#ff3d3d* No has espeficicado nigun miembro o te falta su nombre administrativo", source, 255, 0, 0, true)
            return
        end

        local Staff = getPlayerFromName(playerName)
        local NombreStaff = getElementData(Staff, "StaffName") or "None"

        if NombreStaff == "None" then
            setElementData(Staff, "StaffName", typeargument)
            outputChatBox("#ffe000[Administracion] #ffffffHas designado a #ff8400" .. playerName .. " #ffffffcomo Staff. Ahora su apodo es #ff8400" .. typeargument .. "#ffffff.", source, 255, 0, 0, true)
        else
            outputChatBox("#ff3d3d* El jugador " .. playerName .. " ya tiene un nombre administrativo asignado.", source, 255, 0, 0, true)
        end
    else
        outputChatBox("#ff3d3d* No tienes permisos para realizar esta acción", source, 255, 0, 0, true)
    end
end
addCommandHandler("setstaff", darstaff)

-- Función para remover rol de staff
function quitarstaff(source, commandName, playerName)
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(source)), aclGetGroup("Admin")) then
		if not playerName then
			outputChatBox("#ff3d3d* No has espeficicado nigun miembro administrativo", source, 255, 0, 0, true)
			return
		end

        local Staff = getPlayerFromName(playerName)
        local NombreStaff = getElementData(Staff, "StaffName") or "None"

        if NombreStaff == "None" then
            outputChatBox("#ff3d3d* El jugador " .. playerName .. " no es staff", source, 255, 0, 0, true)
        else
            setElementData(Staff, "StaffName", "None")
            outputChatBox("#ffe000[Administracion] #ffffffHas removido a #ff8400" .. playerName .. " #ffffffcomo Staff.", source, 255, 0, 0, true)
        end
    else
        outputChatBox("#ff3d3d* No tienes permisos para realizar esta acción", source, 255, 0, 0, true)
    end
end
addCommandHandler("removestaff", quitarstaff)

 
 
function handlePlayerQuit()
    local Duty = getElementData(source, "StaffDuty") or 0
    local NombreStaff = getElementData(source, "StaffName") or "None"
	local myskin = getElementData(source,"OriginalSkin") or 0
    
    if Duty == 1 then
        setElementModel(source,myskin)
        outputChatBox("#ffe000[Administracion] #ffffffEl miembro del staff #ff8400" .. NombreStaff .. " #ffffffha sido desconectado y su estado de staff ha sido restaurado.", root, 255, 0, 0, true)
    end
end
addEventHandler("onPlayerQuit", root, handlePlayerQuit)

--[[=======================================================================
                            IGNORAR-SAVE DATA
=======================================================================]]--

--[[=======================================================================
                            IGNORAR-SAVE DATA
=======================================================================]]--
