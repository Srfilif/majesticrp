--local casi1 = createObject(2007,1581.03515625, -1688.7138671875, 15.1953125,0,0,180)
--local casi12 = createObject(2167,1579.5048828125, -1689.2724609375, 15.232040405273,0,0,180)
--local casi13 = createObject(2167,1580.5048828125, -1689.2724609375, 15.232040405273,0,0,180)
local casi13 = createObject(2167,1581.4448828125, -1689.2724609375, 15.232040405273,0,0,180)
local casi13 = createObject(2167,1580.5048828125, -1689.2724609375, 15.232040405273,0,0,180)
local casi13 = createObject(2167,1579.5648828125, -1689.2724609375, 15.232040405273,0,0,180)
local casi13 = createObject(2167,1578.6648828125, -1689.2724609375, 15.232040405273,0,0,180)
local casi13 = createObject(2167,1577.7248828125, -1689.2724609375, 15.232040405273,0,0,180)
local casi13 = createObject(2167,1576.7848828125, -1689.2724609375, 15.232040405273,0,0,180)


local casi13 = createObject(2509,1581.4448828125, -1689.3384, 17.232040405273,0,0,180)

local casi13 = createObject(2509,1580.5048828125, -1689.3384, 17.232040405273,0,0,180)

local casi13 = createObject(2509,1579.5648828125, -1689.3384, 17.232040405273,0,0,180)

local casi13 = createObject(2509,1578.6648828125, -1689.3384, 17.232040405273,0,0,180)
local casi13 = createObject(2509,1577.7248828125, -1689.3384, 17.232040405273,0,0,180)
local casi13 = createObject(2509,1576.7848828125, -1689.3384, 17.232040405273,0,0,180)
local casi13 = createObject(2509,1576.7848828125, -1689.3384, 16.232040405273,0,0,180)


local casi13 = createObject(356,1578.6648828125, -1689.2724609375, 16.932040405273,0,0,180)
local casi13 = createObject(356,1578.6648828125, -1689.2724609375, 17.232040405273,0,0,180)
local casi13 = createObject(356,1578.6648828125, -1689.2724609375, 17.532040405273,0,0,180)
local casi13 = createObject(356,1578.6648828125, -1689.2724609375, 17.832040405273,0,0,180)



local casi13 = createObject(349,1579.9648828125, -1689.2724609375, 16.932040405273,0,0,180)
local casi13 = createObject(349,1579.9648828125, -1689.2724609375, 17.232040405273,0,0,180)
local casi13 = createObject(349,1579.9648828125, -1689.2724609375, 17.532040405273,0,0,180)
local casi13 = createObject(349,1579.9648828125, -1689.2724609375, 17.832040405273,0,0,180)



local casi13 = createObject(353,1580.9648828125, -1689.2724609375, 16.932040405273,0,0,180)
local casi13 = createObject(353,1580.9648828125, -1689.2724609375, 17.232040405273,0,0,180)
local casi13 = createObject(353,1580.9648828125, -1689.2724609375, 17.532040405273,0,0,180)
local casi13 = createObject(353,1580.9648828125, -1689.2724609375, 17.832040405273,0,0,180)

local casi13 = createObject(348,1581.5648828125, -1689.2724609375, 16.932040405273,0,0,180)
local casi13 = createObject(348,1581.5648828125, -1689.2724609375, 17.232040405273,0,0,180)
local casi13 = createObject(348,1581.5648828125, -1689.2724609375, 17.532040405273,0,0,180)
local casi13 = createObject(348,1581.5648828125, -1689.2724609375, 17.832040405273,0,0,180)

local casi13 = createObject(347,1577.5648828125, -1689.2724609375, 16.932040405273,0,0,180)
local casi13 = createObject(347,1577.5648828125, -1689.2724609375, 17.232040405273,0,0,180)
local casi13 = createObject(347,1577.5648828125, -1689.2724609375, 17.532040405273,0,0,180)
local casi13 = createObject(347,1577.5648828125, -1689.2724609375, 17.832040405273,0,0,180)

addEvent('VestuarioPoli', true)
addEventHandler('VestuarioPoli',root,
	function(type, id)
		if type == 'Colocar' then
			source:setModel(tonumber(id))
		elseif type == 'Guardar' then
			setAccountData( source.account, 'mySkin:saved', id..'' )
		elseif type == 'Tomar' then
			source:setModel(tonumber(id))
		end
	end
)

addEventHandler( "onPlayerLogin", getRootElement(), 
	function(_,new)
		if new then
			local IDs = new:getData('mySkin:saved') or false
			if IDs then
				source:triggerEvent('refresh:MySkin',source, tonumber(IDs))
			end
		end
	end
)

addEventHandler( "onResourceStart", getResourceRootElement( ), 
	function()
		setTimer(function()
			for _,player in ipairs(Element.getAllByType('player')) do
				if player.account then
					local IDs = player.account:getData('mySkin:saved') or false
					if IDs then
						player:triggerEvent('refresh:MySkin',player, tonumber(IDs))
					end
				end
			end
		end,2000,1)
	end
)


function giveArma(player,id,balas,precio)
    giveWeapon(player,id,balas)
    takePlayerMoney(player,precio)
end
addEvent("[Vestuarios]darArma",true)
addEventHandler("[Vestuarios]darArma",getRootElement(),giveArma)