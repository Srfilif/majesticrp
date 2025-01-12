-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
    if not notIsGuest(source) then
        -- Licencia de conducir
        local conducir = t:getData("Roleplay:Licencia_Conducir")
        if (conducir) then
            local va = t:getData("Roleplay:Licencia_Conducir")
            source:setData("Roleplay:Licencia_Conducir", va)
        else
            source:setData("Roleplay:Licencia_Conducir", 0)
        end
        -- Licencia de navegar
        local navegar = t:getData("Roleplay:Licencia_Navegar")
        if (navegar) then
            local x = t:getData("Roleplay:Licencia_Navegar")
            source:setData("Roleplay:Licencia_Navegar", x)
        else
            source:setData("Roleplay:Licencia_Navegar", 0)
        end
        -- Licencia de piloto
        local piloto = t:getData("Roleplay:Licencia_Piloto")
        if (piloto) then
            local s = t:getData("Roleplay:Licencia_Piloto")
            source:setData("Roleplay:Licencia_Piloto", s)
        else
            source:setData("Roleplay:Licencia_Piloto", 0)
        end
        -- Licencia de pesca
        local pesca = t:getData("Roleplay:Licencia_Pesca")
        if (pesca) then
            local x = t:getData("Roleplay:Licencia_Pesca")
            source:setData("Roleplay:Licencia_Pesca", x)
        else
            source:setData("Roleplay:Licencia_Pesca", 0)
        end
        -- Licencia de arma
       

        -- Guardar OriginalSkin
        local skinoriginal = t:getData("OriginalSkin")
        if (skinoriginal) then
            source:setData("OriginalSkin", skinoriginal)
        else
            source:setData("OriginalSkin", 0)
        end
        
        -- Guardar StaffName
        local staffName = t:getData("StaffName")
        if (staffName) then
            source:setData("StaffName", staffName)
        else
            source:setData("StaffName", "None")
        end
    end
end)

-- Guardar licencias y StaffName al salir del servidor
function quitSaveLicencias(q, r, e)
    if not notIsGuest(source) then
        local account = source:getAccount()
        if (account) then
            -- Guardar licencias
            local va = source:getData("Roleplay:Licencia_Conducir")
            account:setData("Roleplay:Licencia_Conducir", va)
            local x = source:getData("Roleplay:Licencia_Navegar")
            account:setData("Roleplay:Licencia_Navegar", x)
            local s = source:getData("Roleplay:Licencia_Piloto")
            account:setData("Roleplay:Licencia_Piloto", s)
            local d = source:getData("Roleplay:Licencia_Pesca")
            account:setData("Roleplay:Licencia_Pesca", d)


            -- Guardar OriginalSkin
            local skinoriginal = source:getData("OriginalSkin")
            account:setData("OriginalSkin", skinoriginal)

            -- Guardar StaffName
            local staffName = source:getData("StaffName")
            account:setData("StaffName", staffName)
        end
    end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitSaveLicencias)
addEventHandler("onStopResource", getRootElement(), quitSaveLicencias)

-- Detener recurso
function stopX()
    for i, v in ipairs(Element.getAllByType("player")) do
        if not notIsGuest(v) then
            triggerEvent("onStopResource", v)
        end
    end
end
addEventHandler("onResourceStop", resourceRoot, stopX)
