addEventHandler("onClientResourceStart", resourceRoot, function()
  if setDiscordApplicationID("1327032165413683220") then 
    local playerName = getPlayerName(localPlayer)
    local playerID = getElementData(localPlayer, "ID") or "0"
    local isLoggedIn = getElementData(localPlayer, "character_id") or false
    local playerLevel = getElementData(localPlayer, "level") or "1" -- Nivel del jugador
    local playerCount = #getElementsByType("player")

    setDiscordRichPresenceAsset("GreenWood Roleplay", "GreenWood Roleplay")
    setDiscordRichPresenceSmallAsset("https://acortar.link/wedLKQ", "MTA San Andreas")
    setDiscordRichPresenceButton(1, "Conectarse", "mtasa://51.81.166.66:32715")
    setDiscordRichPresenceButton(2, "Discord", "https://discord.gg/zXvwDuesq8")
    
    -- Inicialmente muestra "Logeando..."
    setDiscordRichPresenceState("Logeando...")

    -- Espera a que el jugador esté logueado para actualizar el estado
    addEventHandler("onClientPlayerLogin", localPlayer, function()
      updateRPC()
    end)
  
    updateRPC()
  end
end)

function updateRPC()
  local name = getPlayerName(localPlayer)
  local playerLevel = getElementData(localPlayer, "Nivel")
  
  if playerLevel then
  -- Una vez logueado, actualiza el estado con el nombre y nivel del jugador
  setDiscordRichPresenceState(name.." | Nivel: "..playerLevel)
  setDiscordRichPresenceDetails("#1 Roleplay Texto ("..#getElementsByType("player").."/100) ")
end
end

setTimer(updateRPC, 5000, 0)
