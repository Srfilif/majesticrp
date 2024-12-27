local application = {}


function setDiscordRichPresence()
    if not isDiscordRichPresenceConnected() then
        return
    end
outputChatBox("hola")
    resetDiscordRichPresenceData()
    local connected = setDiscordApplicationID(application.id)
    if connected then
    --    if isPlayerLogged(getLocalPlayer()) then
				if application.buttons[1].use then setDiscordRichPresenceButton(1, application.buttons[1].name, application.buttons[1].link) end
            if application.buttons[2].use then setDiscordRichPresenceButton(2, application.buttons[2].name, application.buttons[2].link) end
			  if application.details:len() > 0 then setDiscordRichPresenceDetails(application.details .. " (" .. #getElementsByType("player") .. "/" .. application.max_slots .. ")") end
            setDiscordRichPresenceAsset(application.logo, application.logo_name)
            setDiscordRichPresenceState("Connectando...")
		      outputChatBox("hola2")
		      outputChatBox("aa"..getElementData(getLocalPlayer(), "Nivel")..".")

			  setDiscordRichPresenceStartTime(1)
        Nivel = getElementData(getLocalPlayer(), "Nivel") or "None"
		
		 if Nivel then
			
outputChatBox("hola3")

            

            setDiscordRichPresenceState(getPlayerName(getLocalPlayer()) .. " (Nivel " .. getElementData(getLocalPlayer(), "Nivel") .. ")")

			
			elseif Nivel == "None" then 


            setDiscordRichPresenceState("Logeando...")

			outputChatBox("hola4")
			else
						outputChatBox("hola45")


			end
	
	


        -- setDiscordRichPresencePartySize(#getElementsByType("player"), application.max_slots)
    end
end

addEvent("addPlayerRichPresence", true)
addEventHandler("addPlayerRichPresence", localPlayer,
    function(data)
        application = data
        setDiscordRichPresence()
    end, false
)

addEventHandler("onClientPlayerJoin", root,
    function()
        setDiscordRichPresencePartySize(#getElementsByType("player"), application.max_slots)
    end
)

addEventHandler("onClientPlayerQuit", root,
    function()
        if not isDiscordRichPresenceConnected() then
            return
        end

        setDiscordRichPresencePartySize(#getElementsByType("player"), application.max_slots)
    end
)


addEvent("addPlayerRichPresence2", true)
addEventHandler("addPlayerRichPresence2", localPlayer,
    function(data)
        
		resetDiscordRichPresenceData()
	--	--if application.buttons[1].use then setDiscordRichPresenceButton(1, application.buttons[1].name, application.buttons[1].link) end
    --    if application.buttons[2].use then setDiscordRichPresenceButton(2, application.buttons[2].name, application.buttons[2].link) end
		if "#1 Roleplay Texto":len() > 0 then setDiscordRichPresenceDetails("#1 Roleplay Texto" .. " (" .. #getElementsByType("player") .. "/1") end
        setDiscordRichPresenceAsset("https://t.ly/9rP2Y", "Majestic Roleplay.")
        setDiscordRichPresenceState("Connectando...")
    end, false)