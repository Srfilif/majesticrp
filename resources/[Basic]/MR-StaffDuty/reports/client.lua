-- Evento para abrir/cerrar el panel con /re o /reportar
addCommandHandler("re",
    function(command, ...)
        local args = {...}
        local textoReporte = table.concat(args, " ")

        if panel_reporte and guiGetVisible(panel_reporte) then
            -- Si la ventana ya está abierta, se cierra
            guiSetVisible(panel_reporte, false)
            showCursor(false)
        else
            -- Si la ventana está cerrada, se abre
            if not panel_reporte then
                -- Crear el panel si no existe
                local screenW, screenH = guiGetScreenSize()
                panel_reporte = guiCreateWindow((screenW - 500) / 2, (screenH - 422) / 2, 500, 422, "GreenWood Roleplay - Sistema de Reporte", false)
                guiWindowSetSizable(panel_reporte, false)
                guiWindowSetMovable(panel_reporte, false)

                panel_reporte_label = guiCreateLabel(15, 34, 468, 197, "¿Alguien está antiroleando en este mismo instante? ¿Están haciendo DM? ¿Crees que hay una banda realizando MG? ¿Estás bugeado en un interior y no te salvó el /bug?\nEntonces envía un reporte con toda la información necesaria (nombre de los \nusuarios y qué regla incumplieron). De ser válido, un staff lo tomará.\n\nProcura no enviar reportes sobre cosas que ya pasaron y que no se pueden\ncomprobar en el momento (te estafaron, te hicieron DM hace 5 minutos, alguien hizo MG pero ya no lo está haciendo). Toda esta clase de reportes deben ser enviados\na nuestros foros con las pruebas necesarias.\n\nEsta vía de comunicación solo está abierta para cosas que están pasando AHORA MISMO. Todo lo que no esté ocurriendo ahora deberás reportarlo en\nhttps://foros.greenwoodrp.net", false, panel_reporte)
                guiLabelSetHorizontalAlign(panel_reporte_label, "center", true)

                panel_reporte_enviar = guiCreateButton(262, 364, 217, 44, "¡Enviar el reporte!", false, panel_reporte)
                guiSetFont(panel_reporte_enviar, "default-bold-small")
                guiSetProperty(panel_reporte_enviar, "NormalTextColour", "FF963200")

                panel_reporte_cerrar = guiCreateButton(20, 383, 218, 25, "Mejor en otro momento...", false, panel_reporte)
                guiSetFont(panel_reporte_cerrar, "default-bold-small")
                guiSetProperty(panel_reporte_cerrar, "NormalTextColour", "FF326400")

                panel_reporte_memo = guiCreateMemo(23, 235, 456, 115, "¡Acá tu reporte!\nRecuerda comentarnos los sucesos de los hechos, quienes fueron los implicados y qué normativa están infligiendo", false, panel_reporte)    

                -- Evento para enviar el reporte
                addEventHandler("onClientGUIClick", panel_reporte_enviar,
                    function()
                        local reporteTexto = guiGetText(panel_reporte_memo)  -- Texto del reporte
if not reporteTexto or reporteTexto:gsub("%s+", "") == "" or #reporteTexto < 25 then
    outputChatBox("#ff3d3d* El reporte es muy corto. Proporcione más detalles.", 255, 255, 255, true)
    return
end
                        if reporteTexto and reporteTexto ~= "" then
                            -- Enviar los datos al servidor
                            triggerServerEvent("guardarReporte", resourceRoot, localPlayer, reporteTexto)
                            guiSetVisible(panel_reporte, false)
                            showCursor(false)
                        else
                            outputChatBox("#ff3d3d* Por favor, ingresa un reporte válido.", 255, 255, 255, true)
                        end
                    end
                )

                -- Evento para cerrar el panel
                addEventHandler("onClientGUIClick", panel_reporte_cerrar,
                    function()
                        guiSetVisible(panel_reporte, false)
                        showCursor(false)
                    end
                )
            end

            -- Mostrar el panel
            guiSetVisible(panel_reporte, true)
            showCursor(true)

            -- Si se proporciona texto, agregarlo al memo
            if textoReporte and textoReporte ~= "" then
                guiSetText(panel_reporte_memo, textoReporte)
            else
                guiSetText(panel_reporte_memo, "") -- Limpiar el memo si no hay texto
            end
        end
    end
)

-- Alias para /reportar

