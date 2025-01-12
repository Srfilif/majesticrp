--== Script feito por:
--== ● [M]atheus ●

--===================================================
--== BMV RP NO TOPO.
--===================================================



function msg(webhook, message)
    sendOptions = {
        queueName = 'dcq',
        connectionAttempts = 3,
        connectTimeout = 5000,
        formFields = {
            content = ''..message..''
        },
    }
    fetchRemote(webhook, sendOptions, callback)
end
addEvent('sendLog', true)
addEventHandler('sendLog', root, msg)

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

--===================================================
--== /vanish.
--===================================================
addCommandHandler('v', function(sourcePlayer)
if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
		if invisivel then
			invisivel = false
			triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Ativou/Desativou seu modo invisivel\nInformações: '..formattedTime..'```')
		else
			invisivel = true
			triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Ativou/Desativou seu modo invisivel\nInformações: '..formattedTime..'```')
		end
	end
end)

--===================================================
--== /fly.
--===================================================

addCommandHandler('fly', function(sourcePlayer) 
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
	  if flyingState then
	       flyingState = false
		   triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Ativou/Desativou seu modo voar\nInformações: '..formattedTime..'```')
	   else
		   flyingState = true
	       triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Ativou/Desativou seu modo voar\nInformações: '..formattedTime..'```')
		end
	end
end)

--===================================================
--== /tp.
--===================================================
addCommandHandler("tp", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
       if goto then
	       goto = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' deu tp no id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')	   
	   else	
	       gotoo = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' deu tp no id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
		end
	end
end)

--===================================================
--== /fix.
--===================================================

addCommandHandler("fix", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if fixveh then
	       fixveh = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' reparou o veículo do id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       fixveh = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' reparou o veículo do id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)

--===================================================
--== /dv.
--===================================================

addCommandHandler("dv", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if respawn then
	       respawn = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' destruiu o carro do id'..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       respawn = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' destruiu o carro do id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)

--===================================================
--== /vida.
--===================================================

addCommandHandler("vida", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if sethp then
	       sethp = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou vida para o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       sethp = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou vida para o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)

--===================================================
--== /colete.
--===================================================

addCommandHandler("colete", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if setarmor then
	       setarmor = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou colete para o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       setarmor = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou colete para o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)

--===================================================
--== /puxar.
--===================================================

addCommandHandler("puxar", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if puxar then
	       puxar = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Puxou o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       puxar = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Puxou o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)

--===================================================
--== /pro.
--===================================================

addCommandHandler("pro", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if gotoveh then
	       gotoveh = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' ficou imortal '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       gotoveh = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' ficou imortal '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)

--===================================================
--== /ss.
--===================================================

addCommandHandler("cambiarskin", function(sourcePlayer, commandName, targetPlayer)
    if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
        if getveh then
            getveh = false
            triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Cambió de skin en el ID '..(targetPlayer)..'\nInformación: '..formattedTime..'```')
        else
            getveh = true
            triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Cambió de skin en el ID '..(targetPlayer)..'\nInformación: '..formattedTime..'```')
        end
    end
end)


--===================================================
--== /setfome.
--===================================================

addCommandHandler("setfome", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if repararv then
	       repararv = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou fome para o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       repararv = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou fome para o id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)

--===================================================
--== /setgas.
--===================================================

addCommandHandler("setgas", function(sourcePlayer, commandName, targetPlayer)
	if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(sourcePlayer)), aclGetGroup('Everyone')) then
   	  if virarv then
	       virarv = false
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou o gas no id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   else	
	       virarv = true	   
		triggerEvent('sendLog', sourcePlayer, configLogs.webhooks, '```'..getPlayerName(sourcePlayer)..' Setou o gas no id '..(targetPlayer)..'\nInformações: '..formattedTime..'```')
	   end
	end
end)
