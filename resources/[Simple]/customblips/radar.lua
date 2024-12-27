local pCreados = false
local pVisibles = false
local bSur = false
local bEste = false
local bOeste = false
-- { x = 1184.21, y = -6454.42, z = 83.5, stop = true },
-- { x = 4384.96, y = -1593.35, z = 61.33, stop = true },
-- { x = -4410.96, y = -1667.97, z = -133.79, stop = true },

function showCardinalPoints()
	if pCreados == true then
		pVisibles = true
		setCustomBlipVisible(bSur, true)
		setCustomBlipVisible(bEste, true)
		setCustomBlipVisible(bOeste, true)
	else
		--bSur = exports.customblips:createCustomBlip ( , 16, 16, "sur.png", 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 )
		--bEste = exports.customblips:createCustomBlip ( 5943.2, -1587.28, 16, 16, "este.png", 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 )
	--	bOeste = exports.customblips:createCustomBlip ( , 16, 16, "oeste.png", 99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 )
		--createBlip ( -10943.2, -1587.28,0, 51, 1, 2500000,source  )
		--createBlip ( -5943.2, -1587.28,0, 51, 1, 2500000,source  )
		createBlip ( 1976.63, -16999.63,0, 34, 1, 25000000,source  )
		createBlip ( -12999.63, -1587.28,0, 11, 1, 25000000,source  )
		createBlip ( 12999.63, -1587.28,0, 36, 1, 25000000,source  )
		
		pCreados = true
		pVisibles = true
	end
end
addEvent("onMostrarPuntosCardinales", true)
addEventHandler ( "onMostrarPuntosCardinales", getRootElement(), showCardinalPoints)

function toggleCardinalPoints()
	if pVisibles == true then
		hideCardinalPoints()
	else
		showCardinalPoints()
	end
end
addCommandHandler("hud", toggleCardinalPoints)