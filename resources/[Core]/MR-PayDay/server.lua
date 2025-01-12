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
				local reputacion = player:getData("Roleplay:Reputacion") or 0
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
					player:setData("Roleplay:Reputacion",reputacion+1)
					triggerClientEvent("[Poplife]Payday:ticket",player)
				else
					player:outputChat("#F8ed04Total: #2f9c14$"..convertNumber(28 + (math.random(100,500) * 30)), 255, 255, 255, true)
					player:outputChat("#FF0033==================", 255, 255, 255, true)
					local dineroTotal = tonumber(math.ceil(1000 + (math.random(100,500) * 30)))
					player:giveMoney(dineroTotal)
					player:setData("Roleplay:Reputacion",reputacion+1)
					triggerClientEvent("[Poplife]Payday:ticket",player) 
				end
			end
		end
	end
end
setTimer(pagarJugadores, 3600000, 0)

addCommandHandler("gpayday",pagarJugadores)

function actualizarNiveles()
    for _, player in ipairs(Element.getAllByType("player")) do
        local reputacion = player:getData("Roleplay:Reputacion") or 0
        local nivel = player:getData("Nivel") or 0
        local nivelSiguiente = nivel + 1
        local reputacionRequerida = nivel <= 9 and 8 or 15

        if reputacion >= reputacionRequerida then
            player:setData("Roleplay:Reputacion", reputacion - reputacionRequerida)
            player:setData("Nivel", nivelSiguiente)
            player:setData("ScoreBoard_Level", "Nivel " .. nivelSiguiente)
            player:outputChat(
                string.format(
                    "#ffff00[Level UP] #ffffff¡Felicidades! Has alcanzado el #00ff00Nivel %d#ffffff. ¡Sigue progresando!",
                    nivelSiguiente
                ),
                255, 255, 255, true
            )
            triggerClientEvent("[Poplife]Payday:levelup", player)
        end
    end
end
local nivelTimer = setTimer(actualizarNiveles, 1000, 0)

function actualizarScoreboard()
    for _, player in ipairs(Element.getAllByType("player")) do
        local nivel = player:getData("Nivel") or 0
        player:setData("ScoreBoard_Level", "Nivel " .. nivel)
    end
end
local scoreboardTimer = setTimer(actualizarScoreboard, 1000, 0)

function mostrarReputacion()
    for _, player in ipairs(Element.getAllByType("player")) do
        local reputacion = player:getData("Roleplay:Reputacion") or 0
        local nivel = player:getData("Nivel") or 0
        local reputacionRequerida = nivel <= 9 and 8 or 15

        player:outputChat(
            string.format(
                "#ffffff* Tienes actualmente #00ff00(%d/%d) #ffffffreputación para alcanzar el siguiente nivel.",
                reputacion, reputacionRequerida
            ),
            255, 255, 255, true
        )
    end
end
addCommandHandler("reputacion", mostrarReputacion)

function mostrarNivel()
    for _, player in ipairs(Element.getAllByType("player")) do
        local nivel = player:getData("Nivel") or 0
        player:outputChat(
            string.format(
                "#ffFFff* Tu nivel actual es: #00ff00Nivel %d#ffffff.",
                nivel
            ),
            255, 255, 255, true
        )
    end
end
addCommandHandler("nivel", mostrarNivel)



