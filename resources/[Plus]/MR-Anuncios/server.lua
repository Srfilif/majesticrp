loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

--loadstring(exports["[LC]NewData"]:getMyCode())()
--import('*'):init('[LC]NewData')


local Pickup = Pickup(824.4736328125, 3.2841796875, 1004.1796875, 3, 1239,0,0,0)
setElementInterior(Pickup, 3)
setElementDimension(Pickup, 0)

local Marcador = Marker(824.4736328125, 3.2841796875, 1004.1796875-1, "cylinder", 1.3, 100, 100, 100, 0)
setElementInterior(Marcador, 3)
setElementDimension(Marcador, 0)

function anunci(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			if isElementWithinMarker(player,Marcador) then
				player:triggerEvent("openanun", player)
			end
		end
	end
end

addCommandHandler("anuncio",anunci)
addCommandHandler("ad",anunci)

function anun(ano,text,msg)
	local numero2 = source:getData("Roleplay:NumeroTelefono") or ""
	if source:getMoney() >= 200 then
		if ano then
			numero = ""
		else
			numero = " | "..numero2
		end
			local h = getRootElement()
			local a = getPlayerName(source)
			outputChatBox("#FF4800["..text..""..numero.."] #FFFFFF"..msg,h,0,255,0,true)
			outputDebugString("["..text..""..numero.."] "..a.." "..msg.."",0,231,19,251)
			takePlayerMoney(source,200)
    	exports["Administracion"]:message_admins("#00FF00"..a.." #FFFFFFmandó el anuncio.", 255, 255, 255, true)
	else
		source:outputChat("No tienes suficiente dinero",255,0,0,true)
	end
end
addEvent("anuncioen",true)
addEventHandler("anuncioen",root,anun)


function taxi(source,cmd,... )
	local h = getRootElement()
	local msg = table.concat({...}, " ")
	local g = getPlayerName(source)
	if getElementData(source,"Roleplay:trabajo") == "Taxista" then
		if msg ~="" and msg ~=" " then
		outputChatBox("#EDE01E[TAXI] [555]: #FFFFFF"..msg.."",h,0,0,0,true)
	exports["Administracion"]:message_admins("#00FF00"..g.." #FFFFFFmandó el anuncio.", 255, 255, 255, true)
		end
		else
		outputChatBox("Tu no eres taxista",source,255,255,255,true)
	end
end
addCommandHandler("ta", taxi)

