-- Definición del webhook global

local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second

local monthday = time.monthday
local month = time.month
local year = time.year

local formattedTime = string.format("%02d/%02d/%02d - %02d:%02d:%02d", monthday, month + 1, year + 1900, hours, minutes, seconds)

function sendDiscordWebhook(data)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = toJSON(data):sub(2, -2)
    }
    fetchRemote(WEBHOOK_URL, opt, function() end)
end

function onJoinquitWasted(ammo, killer, killerWeapon, bodypart)
    local data
    if killer and getElementType(killer) == "player" then
        if bodypart == 9 then -- Headshot
            data = {
                embeds = {{
                    title = "Registro - Greenwood Roleplay",
                    color = 16711680,
                    description = "",
                    footer = { text = FOOTER },
                    fields = {{
                        name = "" .. getPlayerName(killer) .. " Acaba de asesinar a ```" .. getPlayerName(source) ..
                            "``` Con " .. getWeaponNameFromID(killerWeapon) .. ". \n\n",
                        value = "\n \n **\nSucedio:** `" .. formattedTime .. "`"
                    }},
                    thumbnail = {
                        url = "https://cdn.discordapp.com/icons/1263682982338891779/71ee81d50a9e1eb9d2a0c1e208a24699.webp"
                    }
                }}
            }
        end
    else
        data = {
            embeds = {{
                title = "Registro - Greenwood Roleplay",
                color = 16711680,
                description = "",
                footer = { text = FOOTER },
                fields = {{
                    name = "El jugador ```" .. getPlayerName(source) .. "``` Se ha suicidado\n",
                    value = "\n\n**Sucedio:** `" .. formattedTime .. "`"
                }},
                thumbnail = {
                    url = "https://cdn.discordapp.com/icons/1263682982338891779/71ee81d50a9e1eb9d2a0c1e208a24699.webp"
                }
            }}
        }
    end
    sendDiscordWebhook(data)
end
addEventHandler("onPlayerWasted", root, onJoinquitWasted)

addEventHandler("onPlayerQuit", root, function(quitType)
    local players = getElementsByType("player")
    local Jogador = getPlayerName(source)
    local data = {
        embeds = {{
            title = "Salidas - Greenwood Roleplay",
            color = 16711680,
            description = "",
            fields = {{
                name = "El jugador, `" .. Jogador .. "` salio del servidor",
                value = "**Jugadores:** `" .. tostring(#players) .. "/200`\n\n **IP:** `" .. getPlayerIP(source) ..
                    "`.  \n**Serial:** `" .. getPlayerSerial(source) .. "`."
            }},
            thumbnail = {
                url = "https://cdn.discordapp.com/icons/1263682982338891779/71ee81d50a9e1eb9d2a0c1e208a24699.webp"
            },
            footer = { text = FOOTER }
        }}
    }
    sendDiscordWebhook(data)
end)

addEventHandler("onPlayerJoin", root, function()
    local players = getElementsByType("player")
    local Jogador = getPlayerName(source)
    local data = {
        embeds = {{
            title = "Entradas - Greenwood Roleplay",
            color = 1376000,
            description = "",
            fields = {{
                name = "El jugador, `" .. Jogador .. "` ingreso a el servidor\n",
                value = "**Jugadores:** `" .. tostring(#players) .. "/200`\n\n **IP:** `" .. getPlayerIP(source) ..
                    "`.  \n**Serial:** `" .. getPlayerSerial(source) .. "`."
            }},
            thumbnail = {
                url = "https://cdn.discordapp.com/icons/1263682982338891779/71ee81d50a9e1eb9d2a0c1e208a24699.webp"
            },
            footer = { text = FOOTER }
        }}
    }
    sendDiscordWebhook(data)
end)
