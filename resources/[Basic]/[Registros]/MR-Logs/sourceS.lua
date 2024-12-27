local time = getRealTime()
local hours = time.hour
local minutes = time.minute
local seconds = time.second

local monthday = time.monthday
local month = time.month
local year = time.year

local formattedTime = string.format("%02d/%02d/%02d - %02d:%02d:%02d", monthday, month + 1, year + 1900, hours, minutes, seconds)

local link = "https://canary.discord.com/api/webhooks/1199429480888926288/x2Dl8Fw0oiHmQCgWFp-l6_SsN8afO8VK92rIhcvNwQAiOtjnDyBQrnJGizBAZaJR8Whc"


function onJoinquitWasted(ammo, killer, killerWeapon, bodypart)
		if (killer) and (getElementType(killer) == "player") then
	if bodypart == 9 then  -- Headshot
    local players = getElementsByType ("player")
    local ID = getElementData ( source, "char.ID" ) or "N/C"
    Jogador = getPlayerName ( source )
    local dados = {
        embeds = {
            { -- embed 1
            title = "Registro - Majestic Roleplay",
            color = 16711680,
            description = message,
			--timestamp = ""...."",
			footer = {
                   text = "Sistema de Registros - Majestic Roleplay",
				   },
            description = message,
            fields = {
                {
                    name = ""..getPlayerName(killer).." Acaba de asesinar a ```"..getPlayerName(source).."``` Con "..getWeaponNameFromID(killerWeapon)..". \n\n",
                    value = "\n \n **\nSucedio:** `"..formattedTime.."`",
                },
            },
            thumbnail = {
                url = "https://media.discordapp.net/attachments/1162875391443218583/1190440728812326962/majesticrp.webp?ex=65ab09d3&is=659894d3&hm=6974fb2aa3817bf6ee867fb0cc76cc888a1bec1a8d71a0234899c11c2e5c9973&=&format=webp",
            },
        },
    }
    }
    webhook = "https://canary.discord.com/api/webhooks/1199429480888926288/x2Dl8Fw0oiHmQCgWFp-l6_SsN8afO8VK92rIhcvNwQAiOtjnDyBQrnJGizBAZaJR8Whc"
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end)
end
	else
    local players = getElementsByType ("player")
    local ID = getElementData ( source, "char.ID" ) or "N/C"
    Jogador = getPlayerName ( source )
         local dados = {
		        embeds = {
            { -- embed 1
            title = "Registro - Majestic Roleplay",
            color = 16711680,
            description = message,
			--timestamp = ""...."",
			footer = {
                   text = "Sistema de Registros - Majestic Roleplay",
				   },
            fields = {
                {
                    name = "El jugador ```"..getPlayerName(source).. "``` Se ha suicidado\n",
                    value = "\n\n**Sucedio:** `"..formattedTime.."`",
                },
            },
            thumbnail = {
                url = "https://media.discordapp.net/attachments/1162875391443218583/1190440728812326962/majesticrp.webp?ex=65ab09d3&is=659894d3&hm=6974fb2aa3817bf6ee867fb0cc76cc888a1bec1a8d71a0234899c11c2e5c9973&=&format=webp",
            },
        },
    },
    }
    webhook = "https://canary.discord.com/api/webhooks/1199429480888926288/x2Dl8Fw0oiHmQCgWFp-l6_SsN8afO8VK92rIhcvNwQAiOtjnDyBQrnJGizBAZaJR8Whc"
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end)
end
end
addEventHandler("onPlayerWasted", root, onJoinquitWasted)





	addEventHandler("onPlayerQuit", root, function(quitType)
    local players = getElementsByType ("player")
    local ID = getElementData ( source, "char.ID" ) or "N/C"
    Jogador = getPlayerName ( source )
    local dados = {
        embeds = {
            { -- embed 1
            title = "Salidas - Majestic Roleplay",
            color = 16711680,
            description = message,
            fields = {
                {
                    name = "El jugador, `"..Jogador.."` salio del servidor",
                    value = "**Jugadores:** `"..tostring ( #players).."/200`\n\n **IP:** `"..getPlayerIP(source).."`.  \n**Serial:** `"..getPlayerSerial(source).."`.",
                },
            },
            thumbnail = {
                url = "https://media.discordapp.net/attachments/1162875391443218583/1190440728812326962/majesticrp.webp?ex=65ab09d3&is=659894d3&hm=6974fb2aa3817bf6ee867fb0cc76cc888a1bec1a8d71a0234899c11c2e5c9973&=&format=webp",
            },
			footer = {
                text = "Sistema de Registros - Majestic Roleplay",
			},
			
        },
    }
    }
    webhook = "https://canary.discord.com/api/webhooks/1199424032991346719/8RDaa-mvYguLJyjwWN1Q7U5mpRBgkZaBHIbtroXWXoY7I9-VZshmq70pfbs0d_6jNhKH"
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end )
end)

addEventHandler("onPlayerJoin", root, function()
    local players = getElementsByType ("player")
    local ID = getElementData ( source, "char.ID" ) or "N/C"
    Jogador = getPlayerName ( source )
    local dados = {
        embeds = {
            { -- embed 1
            title = "Entradas - Majestic Roleplay",
            color = 1376000,
            description = message,
            fields = {
                {
                    name = "El jugador, `"..Jogador.."` ingreso a el servidor\n",
                    value = "**Jugadores:** `"..tostring ( #players).."/200`\n\n **IP:** `"..getPlayerIP(source).."`.  \n**Serial:** `"..getPlayerSerial(source).."`.",
                },
            },
            thumbnail = {
                url = "https://media.discordapp.net/attachments/1162875391443218583/1190440728812326962/majesticrp.webp?ex=65ab09d3&is=659894d3&hm=6974fb2aa3817bf6ee867fb0cc76cc888a1bec1a8d71a0234899c11c2e5c9973&=&format=webp",
            },	
			footer = {
                text = "Sistema de Registros - Majestic Roleplay",
			},
        },
    }
    }
    webhook = "https://canary.discord.com/api/webhooks/1199424032991346719/8RDaa-mvYguLJyjwWN1Q7U5mpRBgkZaBHIbtroXWXoY7I9-VZshmq70pfbs0d_6jNhKH"
    dados = toJSON(dados)
    dados = dados:sub(2, -2)
    local opt = {
        connectionAttempts = 5,
        connectTimeout = 7000,
        headers = {
            ["Content-Type"] = "application/json"
        },
        postData = dados
    }
    fetchRemote ( webhook, opt, function() 
    end )
end)