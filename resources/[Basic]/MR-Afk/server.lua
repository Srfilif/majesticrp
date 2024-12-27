Majestic_CMD = {}
Majestic_Time = 60000
TeamAFK = getTeamFromName("AFK")

function toggleAfkMode(thePlayer, playerSource)
    if getElementData(thePlayer, "AfkOFF") then
        outputChatBox("#ff3d3d[AFK] #ffFFffEntrando en modo afk, por favor espera #00ff0015 #ffFFffsegundos.", thePlayer, 244, 189, 56, true)
        setElementFrozen(thePlayer, true)
    end

    if getElementData(thePlayer, "AfkON") then
        outputChatBox("#ff3d3d[AFK] #ffFFffSaliendo en modo afk, por favor espera #00ff0015 #ffFFffsegundos.", thePlayer, 244, 189, 56, true)
    end

    setTimer(function()
        if getElementData(thePlayer, "AfkMode") then
            setElementData(thePlayer, "AfkMode", false)
            setElementData(thePlayer, "AfkOFF", true)
            setElementData(thePlayer, "AfkON", false)
            setElementAlpha(thePlayer, 255)
            toggleControl(thePlayer, "fire", true)
            toggleControl(thePlayer, "next_weapon", true)
            toggleControl(thePlayer, "previous_weapon", true)
            toggleControl(thePlayer, "aim_weapon", true)
            toggleAllControls(thePlayer, true)
            setPlayerTeam(thePlayer, TeamAFK1)
            setElementFrozen(thePlayer, false)
            outputChatBox("#ff3d3d[AFK] #ffFFffEl modo AFK ha sido#ff0000 Desactivado #ffFFffcorrectamente.", thePlayer, 244, 189, 56, true)
        else
            if (Majestic_CMD[playerSource]) then
                 outputChatBox("#ff3d3d[AFK] #ffFFffComando en CoolDown, Espera al menos 1 Hora para usar el comando nuevamente.", thePlayer, 244, 56, 56, true)
                             setElementFrozen(thePlayer, false)

				return           
		   end

            setElementData(thePlayer, "AfkMode", true)
            setElementData(thePlayer, "AfkOFF", false)
            setElementData(thePlayer, "AfkON", true)
            toggleAllControls(thePlayer, false)
            setElementAlpha(thePlayer, 127)
            toggleControl(thePlayer, "chatbox", true)
            toggleControl(thePlayer, "screenshot ", true)
            setPlayerTeam(thePlayer, TeamAFK)
            setElementFrozen(thePlayer, true)
            outputChatBox("#ff3d3d[AFK] #ffFFffEl modo AFK ha sido#00ff00 Activado #ffFFffcorrectamente.", thePlayer, 244, 189, 56, true)

            Majestic_CMD[playerSource] = true
            setTimer(function()
                Majestic_CMD[playerSource] = false
            end, Majestic_Time, 1)
        end
    end, 15000, 1)
end

addCommandHandler("afk", toggleAfkMode)

function login_AFKOFF(thePlayer)
    setElementData(thePlayer, "AfkOFF", true)
end
addEventHandler("onPlayerLogin", root, login_AFKOFF)

function logout_AFKOFF(thePlayer)
    setElementData(thePlayer, "AfkOFF", true)
end
addEventHandler("onPlayerLogout", root, logout_AFKOFF)

function join_AFKOFF(thePlayer)
    setElementData(thePlayer, "AfkOFF", true)
end
addEventHandler("onPlayerJoin", root, join_AFKOFF)
