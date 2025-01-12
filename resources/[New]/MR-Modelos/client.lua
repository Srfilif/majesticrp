
                                                                      

--  ________  _________  ___      ______  ____  ___    ___  ___ 
-- / ___/ _ \/ __/ __/ |/ / | /| / / __ \/ __ \/ _ \  / _ \/ _ \
--/ (_ / , _/ _// _//    /| |/ |/ / /_/ / /_/ / // / / , _/ ___/
--\___/_/|_/___/___/_/|_/ |__/|__/\____/\____/____/ /_/|_/_/    
-- Creado por SrFilif Dev - For GreenWood Roleplay 2024                                                              

                                                                      

function cargarModelos()
    for _, modelo in ipairs(modelos) do
        local txdPath = "modelos/" .. modelo.txd
        local dffPath = "modelos/" .. modelo.dff

        local txdLoaded, dffLoaded = false, false

        -- Verificar y cargar el archivo TXD
        if fileExists(txdPath) then
            local tex = engineLoadTXD(txdPath, modelo.id)
            if tex then
                engineImportTXD(tex, modelo.id)
                txdLoaded = true
            else
                outputDebugString("Error al importar el TXD: " .. modelo.txd, 2,255,0,0)
            end
        else
            outputDebugString("Archivo TXD no encontrado: " .. txdPath, 2,255,0,0)
        end

        -- Verificar y cargar el archivo DFF
        if fileExists(dffPath) then
            local mod = engineLoadDFF(dffPath, modelo.id)
            if mod then
                engineReplaceModel(mod, modelo.id)
                dffLoaded = true
            else
                outputDebugString("Error al reemplazar el modelo DFF: " .. modelo.dff, 2,255,0,0)
            end
        else
            outputDebugString("Archivo DFF no encontrado: " .. dffPath, 2,255,0,0)
        end

        -- Mensaje final si ambos se cargaron correctamente
        if txdLoaded and dffLoaded then
            outputDebugString("[MODEL-LOADER] Modelo (ID: " .. modelo.id .. ") cargado con (" .. modelo.txd .. ") y (" .. modelo.dff .. ")", 3)
        end
    end
end

-- Vincula la función al evento de inicio del recurso
addEventHandler("onClientResourceStart", resourceRoot, cargarModelos)
