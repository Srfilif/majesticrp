tablaPinchos = { }
tablaSphere = { }
pinchosPorColShape = {}
function colocarPinchos(source)
    local x, y, z = getElementPosition(source)
    local rx, ry, rz = getElementRotation(source)

    if isElement(tablaPinchos[source]) then
        outputChatBox("#ff3d3d* Ya tienes un pincho colocado, se eliminará para colocar uno nuevo", source, 255, 0, 0, true)
        destroyElement(tablaPinchos[source])
        if isElement(tablaSphere[source]) then
            destroyElement(tablaSphere[source])
        end
    end

    if isPedInVehicle(source) then
        outputChatBox("#ff3d3d No puedes colocar pinchos si estás en un vehículo", source, 255, 0, 0, true)
        return
    end

    if getElementData(source, "Roleplay:faccion") ~= "Policia" then 
        outputChatBox("#ff3d3d los policías pueden usar esto", source, 255, 200, 0,true)
        return
    end

    tablaPinchos[source] = createObject(2892, x, y, z-1, rx, ry, rz)
    tablaSphere[source] = createColSphere(x, y, z, 5)

    setTimer(setPedAnimation, 5000, 1, source)
    setTimer(setElementAlpha, 5000, 1, tablaPinchos[source], 255)

    setPedAnimation(source, "BOMBER", "BOM_Plant_Loop", -1, true, false, true, true)
    setElementAlpha(tablaPinchos[source], 0)
            setTimer(function()
                chatMe("Dejaría una tira de pinchos en el lugar", source)
            end, 5000, 1)
    

    addEventHandler("onColShapeHit", tablaSphere[source], pincharRuedas)
    -- Guardar la relación entre el ColShape y el objeto de pinchos
    pinchosPorColShape[tablaSphere[source]] = tablaPinchos[source]
end

addCommandHandler("pinchos", colocarPinchos)


-- Agregar el evento onElementDestroy para eliminar el ColShape cuando se destruye el objeto de los pinchos
addEventHandler("onElementDestroy", root, function ()
    if source and isElement(source) and getElementType(source) == "object" and tablaPinchos[source] then
        local pinchoObject = source
        local pinchoOwner = nil

        for k, v in pairs(tablaPinchos) do
            if v == pinchoObject then
                pinchoOwner = k
                break
            end
        end

        if pinchoOwner and isElement(tablaSphere[pinchoOwner]) then
            destroyElement(tablaSphere[pinchoOwner])
            tablaSphere[pinchoOwner] = nil
        end

        tablaPinchos[pinchoOwner] = nil
    end
end)

function removerPinchos(source)
    if isElement(tablaSphere[source]) and pinchosPorColShape[tablaSphere[source]] then
        local pinchoObjeto = pinchosPorColShape[tablaSphere[source]]
            setTimer(function()
                chatMe("Retiraría la tira de pinchos", source)
            end, 2000, 1)
    --    outputChatBox("#FEFEFE[#FF7800Sistema#FEFEFE] Pinchos removidos", source, 255, 0, 0, true)
	setTimer(setPedAnimation, 2000, 1, source)
setPedAnimation(source, "BOMBER", "BOM_Plant_Loop", -1, true, false, true, true)
        setTimer(function()
            destroyElement(pinchoObjeto)
            destroyElement(tablaSphere[source])

            


        end, 2000, 1)
        
        pinchosPorColShape[tablaSphere[source]] = nil
    else
        outputChatBox("#95ff1c[PINCHOS] #ffFFffNo tienes pinchos creados en este momento.", source, 255, 0, 0, true)
    end
end

addCommandHandler("quitarpinchos", removerPinchos)


addEventHandler("onPlayerQuit", root,
	function()
		if isElement(tablaPinchos[ source ]) then
			print("pinchos destruidos en base a salida del creador")
			destroyElement(tablaPinchos[ source ])
		end
	end
)

function pincharRuedas(hitElement, command)
    if getElementType(hitElement) == "vehicle" then
        local theVehicle = hitElement
        setVehicleWheelStates(theVehicle, 1, 1, 1, 1)

        local conductor = getVehicleOccupant(theVehicle)
        if conductor and getElementType(conductor) == "player" then
            outputChatBox("#95ff1c[PINCHOS] #ffFFffLas llantas del vehículo se han pinchado.", conductor, 255, 0, 0,true)
        end
    end
end



function chatMe(mensaje, source)
	local pos = Vector3(source:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	local nick = getPlayerName( source )
	chatCol = ColShape.Sphere(x, y, z, 20)
	nearPlayers = chatCol:getElementsWithin("player") 
	outputDebugString("* " .. mensaje .. " ((" .. nick .. "))",0, 249, 0, 255, 0)
	for _,v in ipairs(nearPlayers) do
		v:outputChat("* "..mensaje.." (("..nick.."))", 249,0,255, true)
	end
	if isElement( chatCol ) then
		destroyElement( chatCol )
	end
end