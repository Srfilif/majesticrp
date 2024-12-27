--[[
    https://discord.com/developers/applications <- LINK DISCORD DEVELOPERS PAGE
    CREATE APPLICATION (WITH YOUR SERVER NAME)
    INSERT YOUR SERVER LOGO
    COPY THIS APPLICATION ID
--]]
local application = {
    id = "1190439447133696070", -- Application ID
    state = "Jugadores Online",
    max_slots = tonumber(getServerConfigSetting("maxplayers")),
    logo = "https://t.ly/9rP2Y",
    logo_name = "Majestic Roleplay.",
    details = "#1 Roleplay Texto",
	

    buttons = {
        [1] = {
            use = true,
            name = "Discord",
            link = "https://discord.gg/WeUfQchCrU"
        },

        [2] = {
            use = true,
            name = "Conectar",
            link = "mtasa://0.0.0.0:22003"
        }
    }
};

addEventHandler("onPlayerResourceStart", root,
    function(theResource)
        if (theResource == resource) then
		
            triggerClientEvent(source, "addPlayerRichPresence", source, application);
        end
    end
);



addEventHandler("onPlayerLogin", root,
  function()
    outputChatBox(getPlayerName(source).." has logged in!", root)
	triggerClientEvent(source, "addPlayerRichPresence2", source, application);
  end
)