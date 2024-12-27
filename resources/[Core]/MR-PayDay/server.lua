loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

--- setTimers
local globalMoney = 38
local enTrabajoMoney = 70
local faccionMoney = 2350

local rangosMoney = {
	["Policia"]={
		["Comandante"]=55000,
		["Teniente"]=32000,
		["General"]=27000,
		["Sargento II"]=23000,
		["Sargento I"]=19000,
		["Oficial III"]=16500,
		["Oficial II"]=12000,
		["Oficial I"]=9000,
		["Cadete"]=7500,
	},
	--
	["Medico"]={
		["Director"]=55000,
		["Sub Director"]=25000,
		["Sargento"]=15000,
		["Medico"]=9000,
		["Paramedico"]=7000,
		["Aspirante"]=5500,
	},
	--
	["Mecanico"]={
		["Dueño"]=25000,
		["Junior"]=7000,
		["Mecanico"]=4000,
		["Aprendiz"]=2000,
	},
	["Gobierno"]={
		["Juez Supremo"]=90000,
		["Fiscal"]=75000,
		["Maestro de Derecho"]=15000,
		["Abogado Estatal"]=10000,
		["Abogado Privado"]=150,
		["Asistente"]=3000,
		["Encargado de Seguridad"]=5000,
		["Guardia"]=1000,
		["Guarura"]=7500,
	}
	--
}

function pagarJugadores()
	for index, player in ipairs(Element.getAllByType("player")) do
		if not notIsGuest( player ) then
			--
			if player:getData("AFK") == false then
				local vehs = exports.MySQL:query("SELECT * FROM vehicles WHERE Owner=?", getAccountName(getPlayerAccount(player)))
				local faccion = player:getData("Roleplay:faccion") or ""
				local rango = player:getData("Roleplay:faccion_rango") or ""
				local reputacion = player:getData("Roleplay:reputacion") or 0
				player:outputChat("#FF0033", 255, 255, 255, true)
				player:outputChat("#eff542=== DIA DE PAGA ===", 255, 255, 255, true)
				player:outputChat("#FF0033", 255, 255, 255, true)
				player:outputChat("#ffFFffAlcaldia: #2f9c14+ $1.000", 255, 255, 255, true)
				--playSoundFrontEnd (player, 7)
				if player:getData("Roleplay:faccion") ~="" then
					player:outputChat("#ffFFffFacción: #2f9c14+ $"..convertNumber(rangosMoney[tostring(faccion)][tostring(rango)]), 255, 255, 255, true)
				end
			--	player:outputChat("#ffFFffHacienda: #2f9c14- $"..(#vehs * 30).." #FFFFFF(#2f9c14"..#vehs.." Vehículo(s)#FFFFFF)", 255, 255, 255, true)
				if player:getData("Roleplay:faccion") ~="" then
					player:outputChat("#F8ed04Total: #2f9c14$"..convertNumber(28 + (math.random(100,500) * 30) + rangosMoney[tostring(faccion)][tostring(rango)]), 255, 255, 255, true)
					player:outputChat("#FF0033==================", 255, 255, 255, true)
					player:giveMoney(tonumber(math.ceil(1000 + (math.random(100,500) * 30) + rangosMoney[tostring(faccion)][tostring(rango)])))
					player:setData("Roleplay:reputacion",reputacion+1)
					triggerClientEvent("[Poplife]Payday:ticket",player)
				else
					player:outputChat("#F8ed04Total: #2f9c14$"..convertNumber(28 + (math.random(100,500) * 30)), 255, 255, 255, true)
					player:outputChat("#FF0033==================", 255, 255, 255, true)
					local dineroTotal = tonumber(math.ceil(1000 + (math.random(100,500) * 30)))
					player:giveMoney(dineroTotal)
					player:setData("Roleplay:reputacion",reputacion+1)
					triggerClientEvent("[Poplife]Payday:ticket",player) 
				end
			end
		end
	end
end
setTimer(pagarJugadores, 3600000, 0)

addCommandHandler("gpayday",pagarJugadores)


function nivel()
    for index, player in ipairs(Element.getAllByType("player")) do
        local reputacion = player:getData("Roleplay:reputacion") or 0
        local nivel = player:getData("Nivel") or 0

        if nivel <= 9 and reputacion > 8 then
            player:setData("Roleplay:reputacion", reputacion - 8)
            player:setData("Nivel", nivel + 1)
			player:setData("ScoreBoard_Level", "Nivel "..nivel + 1)
            player:outputChat("#ffff00[LevelUP] #ffffff¡Felicidades! Has subido al nivel#00ff00 " .. (nivel + 1),255,255,255,true)
			triggerClientEvent("[Poplife]Payday:levelup",player) 
        elseif nivel > 9 and reputacion > 15 then
            player:setData("Roleplay:reputacion", reputacion - 15)
            player:setData("Nivel", nivel + 1)
			player:setData("ScoreBoard_Level", "Nivel "..nivel + 1)
            player:outputChat("#ffff00[LevelUP] #ffffff¡Felicidades! Has subido al nivel #00ff00" .. (nivel + 1),255,255,255,true)
			triggerClientEvent("[Poplife]Payday:levelup",player) 
        end
    end
end

local refreshTimer1 = setTimer(nivel, 1000, 0)

function nivel1()
    for index, player in ipairs(Element.getAllByType("player")) do
        local nivel = player:getData("Nivel") or 0
        player:setData("ScoreBoard_Level", "Nivel " .. nivel)
    end
end

local refreshTimer12 = setTimer(nivel1, 1000, 0)



function verrep()
for index, player in ipairs(Element.getAllByType("player")) do
local reputacion = player:getData("Roleplay:reputacion")  or 0
local nivel = player:getData("Nivel")  or 0

if nivel <= 9 then
player:outputChat("#fcba03[NIVEL] #ffffffActalmente tienes #00ff00("..reputacion.."/8) #ffffffReputacion para el siguiente nivel.",255,255,255,true)
end
if nivel >= 10 then
player:outputChat("#fcba03[NIVEL] #ffffffActalmente tienes #00ff00("..reputacion.."/15) #ffffffReputacion para el siguiente nivel.",255,255,255,true)
end
end
end
addCommandHandler("reputacion",verrep)


function vernivel()
for index, player in ipairs(Element.getAllByType("player")) do
local reputacion = player:getData("Roleplay:reputacion")  or 0
local nivel = player:getData("Nivel")  or 0
player:outputChat("#fcba03[Nivel] #ffffffActalmente eres Nivel #00ff00"..nivel.."",255,255,255,true)
end
end
addCommandHandler("nivel",vernivel)



--[[=======================================================================
                            IGNORAR-SAVE DATA
=======================================================================]]--
function salvardados(conta)
	if conta then
	local source = getAccountPlayer(conta)
	local ObterGalao = getElementData ( source, "Nivel" ) or 0
	local ObterGalao1 = getElementData ( source, "Roleplay:reputacion" ) or 0
	setAccountData ( conta, "Nivel", ObterGalao )
	setAccountData ( conta, "Roleplay:reputacion", ObterGalao1 )
	end	
end

function dardados(conta)
	if not (isGuestAccount (conta)) then
		if (conta) then	
			local source = getAccountPlayer(conta)	
			local ObterGalao = getAccountData ( conta, "Nivel" ) or 0
			local ObterGalao1 = getAccountData ( conta, "Nivel" ) or 0
			setElementData ( source, "Nivel", ObterGalao )
			setElementData ( source, "Roleplay:reputacion", ObterGalao1 )
		end
	end	
end

addEventHandler("onPlayerLogin", root,
  function( _, acc )
	setTimer(dardados,50,1,acc)
  end
)

function startScript ( res )
	if res == getThisResource() then
		for i, player in ipairs(getElementsByType("player")) do
			local acc = getPlayerAccount(player)
			if not isGuestAccount(acc) then
				dardados(acc)
			end
		end
	end
end
addEventHandler ( "onResourceStart", getRootElement(), startScript )

function stopScript( res )
    if res == getThisResource() then
		for i, player in ipairs(getElementsByType("player")) do
			local acc = getPlayerAccount(player)
			if not isGuestAccount(acc) then
				salvardados(acc)
			end
		end
	end
end 
addEventHandler ( "onResourceStop", getRootElement(), stopScript )

function sair ( quitType )
	local acc = getPlayerAccount(source)
	if not (isGuestAccount (acc)) then
		if acc then
			salvardados(acc)
		end
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), sair )


--[[=======================================================================
                        LICENCIA DE ARMAS
                                                  -No borrar los creditos :3
                        BY: Thehacker5#0777                       
=======================================================================]]--