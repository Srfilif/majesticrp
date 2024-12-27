addEvent("[Poplife]Payday:ticket",true) 
addEventHandler("[Poplife]Payday:ticket",getRootElement(), 
function () 
local sound = playSound("assets/sound/ticket.mp3") 
setSoundVolume(sound, 1) 
end)
addEvent("[Poplife]Payday:levelup",true) 
addEventHandler("[Poplife]Payday:levelup",getRootElement(), 
function () 
local sound = playSound("assets/sound/lvlup.mp3") 
setSoundVolume(sound, 1) 
end)
