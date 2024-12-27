loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local Puertas_s = {}
Puertas_s.__index = Puertas_s


function Puertas_s:constructor(array)

	local ob = setmetatable({},self);

	ob.Puerta = createObject(array.ID, array.Pos[1],array.Pos[2],array.Pos[3], array.Rot[1],array.Rot[2],array.Rot[3])
	ob.Col = createColCircle( array.Pos[1],array.Pos[2], 1 )
	ob.Mov = array.Mov
	ob.Pos = array.Pos
	ob.Equipo = array.Equipo

	setElementDimension( ob.Puerta, array.Dim )
	setElementDimension( ob.Col, array.Dim )

	setElementInterior(ob.Puerta, array.Int)
	setElementInterior(ob.Col, array.Int)

	ob.F_openClose = bind(Puertas_s.openClose, ob)

	for _,player in ipairs(Element.getAllByType('player')) do
		bindKey(player,"X","down", ob.F_openClose )
	end

	ob.F_EnterPlayer = bind(Puertas_s.EnterPlayer, ob)
	addEventHandler( "onPlayerJoin", getRootElement(), ob.F_EnterPlayer )
end

function Puertas_s:EnterPlayer()
	bindKey(source,"X","down", self.F_openClose )
end

local ChatBoxSpam = {}

function Puertas_s:openClose(p)
	if p:getData("Roleplay:faccion") == tostring( self.Equipo ) or p:getName() == "Frank_Orion" then
		if p:isWithinColShape( self.Col ) then
			if not isObjectMoved(self.Puerta,self.Pos[1],self.Pos[2],self.Pos[3],self.Mov[1],self.Mov[2],self.Mov[3]) then
				if not isTimer(self.Timer) then
					local tick = getTickCount()
					if (ChatBoxSpam[p] and ChatBoxSpam[p][1] and tick - ChatBoxSpam[p][1] < 3000) then
						return
					end
					MensajeRoleplay(p, "Abrio la puerta con el codigo", 215, 122, 8)
					if (not ChatBoxSpam[p]) then
						ChatBoxSpam[p] = {}
					end
					ChatBoxSpam[p][1] = getTickCount()
					--p:setAnimation("VENDING", "VEND_Use",false,false,false,true)
					--setTimer(setPedAnimation, 3000, 1, p)
					self.Puerta:move(2500, self.Mov[1],self.Mov[2],self.Mov[3])
					self.Timer = setTimer(function()
						self.Puerta:move(2500, self.Pos[1],self.Pos[2],self.Pos[3])
					end,3000,1)
				end
			end
		end
	end
end

function isObjectMoved(object,x,y,z,mx,my,mz)
	local pos = object.position
	if (math.floor(pos.x) == math.floor(x) or math.floor(pos.x) == math.floor(mx)) and (math.floor(pos.y) == math.floor(y) or math.floor(pos.y) == math.floor(my)) and (math.floor(pos.z) == math.floor(z) or math.floor(pos.z) == math.floor(mz)) then
		return false
	end
	return true
end

local posiciones = {
	{ID=3089, Pos={1557.4499511719, -1673.1999511719, 16.5}, Rot={0, 0, 0}, Mov={1556.1499511719, -1673.1999511719, 16.5}, Dim=0, Int=0,Equipo='Policia'},
	{ID=3089, Pos={1572.3000488281, -1682.5, 16.5}, Rot={0, 0, 0}, Mov={1573.5000488281, -1682.5, 16.5}, Dim=0, Int=0,Equipo='Policia'},
		{ID=3089, Pos={1566.3499755859, -1692.1999511719, 16.5}, Rot={0, 0, 0}, Mov={1565.1, -1692.1999511719, 16.5}, Dim=0, Int=0,Equipo='Policia'},

	{ID=3089, Pos={1567.6500244141, -1675.1999511719, 16.5}, Rot={0, 0, 0}, Mov={1568.9500244141, -1675.1999511719, 16.5}, Dim=0, Int=0,Equipo='Policia'},
	

	{ID=3089, Pos={1564.1999511719, -1687.6300048828, 16.5}, Rot={0, 0, 270}, Mov={1564.1999511719, -1686.2300048828, 16.5}, Dim=0, Int=0,Equipo='Policia'},
	
--	{ID=3089, Pos={1572.3000488281, -1682.5, 16.5}, Rot={0, 0, 0}, Mov={1573.5000488281, -1682.5, 16.5}, Dim=0, Int=0,Equipo='Policia'},
	{ID=3089, Pos={1571.3000488281, -1680.8200488281, 16.5}, Rot={0, 0, 270}, Mov={1571.3000488281, -1681.95, 16.5}, Dim=0, Int=0,Equipo='Policia'},

	{ID=3089, Pos={1574.3000488281, -1678.5, 16.5}, Rot={0, 0, 90}, Mov={1574.3000488281, -1679.8, 16.5}, Dim=0, Int=0,Equipo='Policia'},
--	{ID=3089, Pos={1572.3000488281, -1682.5, 16.5}, Rot={0, 0, 0}, Mov={1573.5000488281, -1682.5, 16.5}, Dim=0, Int=0,Equipo='Policia'},

	{ID=980, Pos={294.51171875, -235.7470703125, 1.5535440444946}, Rot={0, 0, 180}, Mov={294.51171875, -235.7470703125, -10}, Dim=0, Int=0, Equipo='Mecanico'},
	{ID=16773, Pos={272.3349609375, -221.95683288574, 3.5687500238419}, Rot={0, 0, 0}, Mov={272.3349609375, -221.95683288574, -10}, Dim=0, Int=0, Equipo='Mecanico'},
}

addEventHandler( "onResourceStart", getResourceRootElement( ), 
	function()
		for i,v in ipairs(posiciones) do
			Puertas_s:constructor(v)
		end
	end
)

function bind(func, ...)
	if not func then
		if DEBUG then
			outputConsole(debug.traceback())
			outputServerLog(debug.traceback())
		end
		error("Bad function pointer @ bind. See console for more details")
	end
	
	local boundParams = {...}
	return 
		function(...) 
			local params = {}
			local boundParamSize = select("#", unpack(boundParams))
			for i = 1, boundParamSize do
				params[i] = boundParams[i]
			end
			
			local funcParams = {...}
			for i = 1, select("#", ...) do
				params[boundParamSize + i] = funcParams[i]
			end
			return func(unpack(params)) 
		end 
end

function MensajeRoleplay( player, texto, r, g, b )
	local pos = Vector3(player:getPosition())
	local x, y, z = pos.x, pos.y, pos.z
	local chatCol = ColShape.Sphere(x, y, z, 10)
	local nearPlayers = chatCol:getElementsWithin("player")
	for index, v in ipairs(nearPlayers) do
		v:outputChat("* ".._getPlayerNameR(player).." "..(texto or ""), (r or 255), (g or 255), (b or 255))
	end
	if isElement(chatCol) then
		destroyElement(chatCol)
	end
end

--Puertas_s
addEventHandler( "onResourceStart", getResourceRootElement( ),
	function()
		garageLSPD = createColCuboid ( 1583.9547119141, -1645.1680908203, 11.919442176819-1, 9, 17.5, 5 )
		porton = createObject( 3055, 1588.599609375, -1637.900390625, 14.60000038147)
		--porton:setID( 'Cerrado' )

		col_fuera = createColCuboid (1530.9406738281, -1631.9364013672, 11, 22, 9, 5 )
		porton_fuera = createObject( 971, 1539.599609375, -1627.7998046875, 15.89999961853, 0, 0, 271.25)

	end
)

--

addCommandHandler('abrirp',
	function(p)
		if p:getData('Roleplay:faccion') == 'Policia' then
			if p:isWithinColShape( garageLSPD ) then
				porton:move(2500, 1588.599609375, -1637.900390625, 18.3)
				Timer(
					function()
						porton:move(2500, 1588.599609375, -1637.900390625, 14.60000038147)
					end,
				10500,1)
			elseif p:isWithinColShape(col_fuera) then
				porton_fuera:move(2500, 1539.599609375, -1627.7998046875-8, 15.89999961853)
				Timer(
					function()
						porton_fuera:move(2500, 1539.599609375, -1627.7998046875, 15.89999961853)
					end,
				9000,1)
			end
		end
	end
)

