Robos_s = {}

Robos_s.blips = {}
Robos_s.rob = {}

Robos_s.elementRobo = function()
	for dim in pairs(Ints) do
		Element('Tiendas_', 'ShopID_'..dim)
	end
end

Robos_s.elementRobo()

Robos_s.cmdRobar = function(p)
	local myDim = p.dimension
	if myDim then

		local shop = getElementByID('ShopID_'..myDim)
		if isElement(shop) then

			if (not Robos_s.rob[shop]) or (not Robos_s.rob[shop]:isValid()) then

				if (#getPlayersInFaction('Policia') >= 1) then
					
					Robos_s.rob[shop] = Timer(function(s) Robos_s.rob[s] = nil end,99000, 1, shop)

					local info = Ints[myDim]
					p:triggerEvent('displayTimeRob', p, shop, myDim)
					--p:triggerEvent('displayTimeRob1', p, shop, myDim)
					ganacias = 0
					p:outputChat('#ff322b[LADRON] #ffffffEstas Robado esta Tienda Mantente Alerta!',255,255,255,true)
                  
				  
				    local tiempopd = 1 + math.random(1,2)
					local tiempopdseg = (tiempopd * 1000)
					setTimer(function()
                    p:outputChat('#ff322b[LADRON] #ffffffLa Policia fue avisada de tu robo ase #ff3d3d '..tiempopd..' segundos. ',255,255,255,true)
                     end, tiempopdseg, 1)
				  
				    
					local Group = Element('Group-Police','LSPD')
					for i,v in ipairs(Element.getAllByType('player')) do
						if v:getData('Roleplay:faccion') == 'Policia' then
							v:outputChat('#003dff[CENTRAL] #ffFFffEstan Robando la tienda #00ff1e'..info[1]..' #ffFFff¡todas las unidades acudir al robo!', 255,255,0,true)
							v:setParent(Group)
						end
					end

					Robos_s.blips[myDim] = Blip(info[2][1], info[2][2], info[2][3], 0, 2, 255, 0, 0, 255, 0, 1000, Group)
					Robos_s.blips[myDim]:setData('My_Parent', Group, false)
					
					
				end

			elseif Robos_s.rob[shop]:isValid() then

				local ms = getTimerDetails( Robos_s.rob[shop] )
				p:outputChat('#ff322b[LADRON] #ffffffEsta tienda ya fue robada recientemente, Vuelve en un tiempo.. #777777('..formatTime(ms)..")",255,255,255,true)
			
			end

		end

	end
end
addCommandHandler('robartienda', Robos_s.cmdRobar)
-- Función para finalizar el robo y entregar el dinero acumulado








addEvent('ShopRobGiveMoney', true)
addEventHandler('ShopRobGiveMoney', root,
    function(dim,ganancias)

    	if (source.dimension == dim) then
    		source:giveMoney(ganancias)
			source:outputChat("#ffffffAcabas de obtener #004500#"..ganancias.." #ffffffde la caja",255,255,255,true)
			ganancias = 0
    	end

    	local blipParent = Robos_s.blips[dim]:getData('My_Parent')
    	if isElement(blipParent) then
    		blipParent:destroy()
    	end

    	if isElement(Robos_s.blips[dim]) then
			Robos_s.blips[dim]:destroy()
		end
	end

)


function formatTime(ms)
	if not ms or type(ms) == 'userdata' then
		return false
	end
	local seg = math.floor(math.max(0,ms / 1000))
	return ('%02d:%02d'):format(math.floor(math.max(0,seg / 60)), seg)
end

function getPlayersInFaction(faction)
	local o = {}
	for i,v in ipairs(Element.getAllByType('player')) do
		if v:getData('Roleplay:faccion') == faction then
			table.insert(o,v)
		end
	end
	return o
end
