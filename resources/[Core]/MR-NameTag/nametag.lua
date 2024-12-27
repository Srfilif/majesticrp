local nametag = {}
local nametags = {}

function nametag.create(p)
	nametags[p] = true
end

function nametag.destroy(p)
	nametags[p] = nil
end

setDevelopmentMode(true)

addEventHandler("onClientRender", getRootElement(), function()
	for _, player in ipairs(Element.getAllByType("player")) do
		if isElement(player) then
			if player ~= localPlayer then
				player:setNametagShowing(false)
				if not nametags[player] then
					nametag.create(player)
				end
			end
		end
	end
end)

addEventHandler("onClientRender", root,
	function()
		local px, py, pz = getCameraMatrix( )
		for k, thePlayer in ipairs(getElementsByType("player")) do
			if thePlayer ~= localPlayer then
				tx, ty, tz = getElementPosition(thePlayer)
				dist = math.sqrt((px - tx)^2 + (py - ty)^2 + (pz-tz)^2)
				if dist < 10 then
					if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
						local sx, sy, sz = getPedBonePosition(thePlayer, 3)
						local x, y = getScreenFromWorldPosition(sx, sy, sz)
						local id = getElementData(thePlayer, "ID")
						if id and x and y then
							dxDrawText("["..id.."] "..thePlayer:getName(), x+1, y+1, x+1, y+1, tocolor(0,0,0,255), 1, "default-bold", "center", nil, false, false, false, true, false)
							dxDrawText("#898282["..id.."] #FFFFFF"..thePlayer:getName(), x, y, x, y, tocolor(255, 200, 0, 255), 1, "default-bold", "center", nil, false, false, false, true, false)
						end
					end
				end
			end
		end
	end
)

--
function removeColorCoding ( name )
	return type(name)=='string' and string.gsub ( name, '#%x%x%x%x%x%x', '' ) or name
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, player in ipairs(Element.getAllByType("player")) do
		if player ~= localPlayer then
			nametag.create(player)
		end
	end
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	for _, player in ipairs(Element.getAllByType("player")) do
		nametag.destroy(player)
		player:setNametagShowing(true)
	end
end)

addEventHandler("onClientPlayerJoin", getRootElement(), function()
	if source == localPlayer then return end
	source:setNametagShowing(false)
	nametag.create ( source )
end)

addEventHandler("onClientPlayerQuit", getRootElement(), function()
	nametag.destroy(source)
end)