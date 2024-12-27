local PuntosRolepaly = 0
local PuntosTotal = 0
local PasosRoleplay = 1
local RoleplayPreguntas = {
-- Pregunta número 1
{
{Pregunta="¿De que se trata este modo de juego?"},
{Repuesta={"A)El modo de juego es Roleplay,Un tipo de juego que simula la vida real lo más posible.", "B)Un servidor RPG en el cual hay jobs y armas,el objeto es conseguir mucho dinero ", "C)El modo de juego es Roleplay, Un tipo de juego donde se puede trollear."}}
},
-- Pregunta número 2
{
{Pregunta="¿Qué es DM?"},
{Repuesta={"A)Es cuando un personaje mata a otro,No importa sus motivos", "B)Es cuando daña o mata a otro personaje sin motivos IC", "C)Es cuando se daña o mata a un miembro de policia"}}
},
-- Pregunta número 3
{
{Pregunta="¿A que se refiere la regla MegaGaming (MG)?"},
{Repuesta={"A)Esta regla es inventada y no existe", "B)Sirve para identificar a los que usan la radio", "C)Usar informacion OCC para Beneficio IC"}}
},
--
{
{Pregunta="Seleciona el /do usando correctamente"},
{Repuesta={"A) /do debido a la hora, no habria nadie en la cochera de Carlos", "B) /do Andres Angel esta inconciente", "C) Los dos /yo estan bien usados"}}
},
-- Pregunta número 4
{
{Pregunta="Seleciona el /me usado correctamente"},
{Repuesta={"A)/me se cae de un cuarto piso, este sobrevive gracia a el poder de dios", "B) /me se rasca la nuca", "C) /me le pega a Sofia y esta se desmaya"}}
},
-- Pregunta número 5
{
{Pregunta="¿Que es PowerGaming (PG)?"},
{Repuesta={"A)PG Es cuando tu personaje se siente cansado", "B)Es cuando haces acciones permitidas por el staff", "C)Es una situacion de rol realializada de forma forzada para ser beneficiado"}}
},
-- Pregunta número 6
{
{Pregunta="¿Que es IC(In Character) y OCC (Out Of Character)?"},
{Repuesta={"A)IC Es todo lo que ocurre dentro de el personaje y OCC es todo lo que ocurre fuera del personaje", "B)OCC es todo lo que se escucha por la radio y IC Todo lo que pasa por tu mente", "C)No son conseptos Roleplay"}}
},
-- Pregunta número 7
{
{Pregunta="¿Que es CharacterKill (CK)?"},
{Repuesta={"A)Es cuando el personaje esta muerto Totalmente", "B)CK no existe", "C)Es cuando el personaje muere pero reaparece en los santos"}}
},
-- Pregunta número 8
{
{Pregunta="¿Cual es el significado de las siglas NRC?"},
{Repuesta={"A)No Rolear Casa", "B)No rol Choque", "C)No rolear Caminando"}},
},
-- Pregunta número 9
--[[{
{Pregunta="¿Qué es NRR?"},
{Repuesta={"A) No Rolear Rotacion, Es sancionable", "B)No es un termino de Roleplay", "C)No Rolear Robo y Es sancionable"}},
},--]]
-- Pregunta número 10
{
{Pregunta="¿Que es el consepto MC?"},
{Repuesta={"A)MultiCuentas(Transpaso de Bienes/Dinero de un personaje a otro)", "B)Mala Conducta", "C)Mal uso de el celular"}},
},
}

local PuntosRepuestaTable = {
-- 1
["A)El modo de juego es Roleplay,Un tipo de juego que simula la vida real lo más posible."]= 3,
["C)Es cuando daña o mata a otro personaje sin motivos IC"]= 1,
["C)Usar informacion OCC para Beneficio IC"] = 1,
["C) Los dos /yo estan bien usados"] = 1,
["B) /me se rasca la nuca"] = 1,
["C)Es una situacion de rol realializada de forma forzada para ser beneficiado"] = 1,
["A)IC Es todo lo que ocurre dentro de el personaje y OCC es todo lo que ocurre fuera del personaje"] = 1,
["A)Es cuando el personaje esta muerto Totalmente"] = 1,
["B)No rol Choque"] = 1,
--["C)No Rolear Robo y Es sancionable"] = 1,
["A)MultiCuentas(Transpaso de Bienes/Dinero de un personaje a otro)"] = 1,
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        PanelRoleplay = guiCreateWindow(0.32, 0.34, 0.36, 0.32, "Pasos: 1/10", true)
        guiWindowSetSizable(PanelRoleplay, false)
        guiSetVisible(PanelRoleplay, false)

        LabelPregunta = guiCreateLabel(0.02, 0.11, 0.96, 0.18, "Pregunta: ¿?", true, PanelRoleplay)
        guiSetFont(LabelPregunta, "default-bold-small")
        guiLabelSetHorizontalAlign(LabelPregunta, "center", true)
        guiLabelSetVerticalAlign(LabelPregunta, "center")
        ListaRepuestas = guiCreateGridList(0.04, 0.32, 0.94, 0.47, true, PanelRoleplay)
        guiGridListAddColumn(ListaRepuestas, "Repuestas", 0.9)
        botonSiguiente = guiCreateButton(0.41, 0.83, 0.18, 0.13, "Siguiente..", true, PanelRoleplay)
        guiSetProperty(botonSiguiente, "NormalTextColour", "FFAAAAAA")    
    end
)
local PasosRoleplay2 = 0
addEventHandler("onClientGUIClick", resourceRoot, function()
	local repuesta = guiGridListGetItemText ( ListaRepuestas, guiGridListGetSelectedItem ( ListaRepuestas ), 1 )
	if source == botonSiguiente then
		if repuesta ~="" then
			if PuntosRepuestaTable[repuesta] then
				PuntosRolepaly = PuntosRolepaly + PuntosRepuestaTable[repuesta]
			end
			if PasosRoleplay >= 1 and PasosRoleplay <= 9 then
				PasosRoleplay = PasosRoleplay + 1
				PasosRoleplay2 = PasosRoleplay2 + 1
				loadPreguntas()
			elseif PasosRoleplay >= 10 then
				PuntosTotal = PuntosRolepaly
				PasosRoleplay2 = PasosRoleplay2 + 1
			end
			print(PuntosTotal)
			if PasosRoleplay2 >= 10 then
				if PuntosTotal >= 10 then
					outputChatBox("¡Muy bien pasaste el test de rol!", 50, 150, 50)
					guiSetVisible( PanelRoleplay, false )
					showCursor(false)
					triggerServerEvent("PasoElRol", localPlayer)
				else
					triggerServerEvent("kickedPlayer", localPlayer)
					guiSetVisible( PanelRoleplay, false )
					showCursor(false)
				end
			end
		else
			outputChatBox("¡Debes selecciona una repuesta antes de ir a la siguiente!", 150, 50, 50)
		end
	end
end)

addEvent("setVisibleTestRol", true)
addEventHandler("setVisibleTestRol", root, function()
	if guiGetVisible(PanelRoleplay) == true then
		guiSetVisible(PanelRoleplay, false)
		showCursor(false)
	else
		guiSetVisible(PanelRoleplay, true)
		showCursor(true)
		loadPreguntas()
	end
end)

function loadPreguntas()
	guiGridListClear(ListaRepuestas)
	for i, s in ipairs(RoleplayPreguntas) do
		if PasosRoleplay >= i and PasosRoleplay <= i then
			local valPre = s[1]
			guiSetText(PanelRoleplay, "Pasos: "..i.."/10")
			guiSetText(LabelPregunta, "Pregunta: "..valPre.Pregunta)
			local valRep = s[2]
			local r1 = math.randomDiff(1, #valRep.Repuesta)
			local r2 = math.randomDiff(1, #valRep.Repuesta, r1)
			local r3 = math.randomDiff(1, #valRep.Repuesta, r1,r2)
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r1])
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r2])
			guiGridListAddRow( ListaRepuestas,valRep.Repuesta[r3])
			guiGridListSetSortingEnabled ( ListaRepuestas, false )
			--guiGridListSetItemText(ListaRepuestas, row, 1, tostring(math.randomDiff(1, v)), false, false)
		end
	end
end

function math.randomDiff(a, b, distA, distB)
	local distA = distA or 0
	local distB = distB or 0
	local random = math.random(a,b)
	while random == distA or random == distB do
		random = math.random(a,b)
		if random ~= distA and random ~= distB then
			break;
		end
	end
	return random
end
