loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local colsShapes = {}
local antiSpamComando = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getTableATM()) do
		if v[4] == true then
			Blip( v[1], v[2], v[3], 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		end
		colsShapes[i] = ColShape.Sphere(v[1], v[2], v[3], 2)
	end
end)

addEventHandler("onResourceStart", resourceRoot, function()
	Blip( 2305.2294921875, -16.1240234375, 26.7421875, 52, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
	Blip( 2110.630859375, -1116.0498046875, 25.267585754395, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
	Blip( 2479.435546875, -1757.9423828125, 13.546875, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
	Blip( 2068.6826171875, -1770.1826171875, 13.562158584595, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
    Blip( 1073.8115234375, -1861.892578125, 13.546875, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
    Blip( 2103.943359375, -1359.525390625, 23.984375, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
    Blip( 1639.978515625, -1171.9267578125, 24.078125, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
    Blip( 1036.2060546875, -983.9853515625, 42.796875, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
    Blip( 1186.1806640625, -1380.3037109375, 13.571049690247, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
    Blip( 1419.185546875, -1619.68359375, 13.546875, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
    Blip( 361.4423828125, -1730.2568359375, 6.7318344116211, 12, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
end)

addCommandHandler("depositar", function(p, cmd, monto)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			local tick = getTickCount()
			if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 1000) then
				p:outputChat("Debes esperar 1 segundo después de ser utilizado.", 150, 0, 0)
				return
			end
			for i, v in ipairs(colsShapes) do
				if p:isWithinColShape(v) then
					local s = p:getData("Roleplay:tarjeta_credito")
					if s == 1 then
						if monto and tonumber(monto) then
							if string.find(monto, "-") then return end
							if p:getMoney() >= tonumber(monto) then
								if p:getMoney() >= 1 then
									local account = p:getAccount()
									local money = p:getData("Roleplay:bank_balance")
									local total = tonumber(money)+monto
									p:setData ( "Roleplay:bank_balance", tonumber(total) )
									account:setData( "Roleplay:bank_balance", tonumber(total) )
									--
									p:takeMoney(tonumber(monto))
									outputDebugString("* "..p:getName().." ha depositado: $"..convertNumber(monto).." ", 0, 0, 150, 0)
									p:outputChat("* Has depositado la cantidad: #004500$"..convertNumber(monto).." dólares.", 0, 150, 0, true)
									--
									local f = getRealTime()
									insert("insert into `BancoLog` VALUES (?,?,?,?)", convertNumber(monto), "Deposito", f.monthday.."/"..f.month+1 .."/"..f.year-100, AccountName(p))
								else
									p:outputChat("* No tienes dinero para depositar", 150, 0, 0)
								end
							else
								p:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para depositar", 150, 0, 0)
							end
						end
					else
						p:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
					end
				end
			end
			if (not antiSpamComando[p]) then
				antiSpamComando[p] = {}
			end
			antiSpamComando[p][1] = getTickCount()
		end
	end
end)

addCommandHandler("retirar", function(p, cmd, monto)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			local tick = getTickCount()
			if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 1000) then
				p:outputChat("Debes esperar 1 segundo después de ser utilizado.", 150, 0, 0)
				return
			end
			for i, v in ipairs(colsShapes) do
				if p:isWithinColShape(v) then
					local s = p:getData("Roleplay:tarjeta_credito")
					if s == 1 then
						if monto and tonumber(monto) then
							if string.find(monto, "-") then return end
							local money = p:getData("Roleplay:bank_balance")
							if tonumber(money) >= tonumber(monto) then
								local account = p:getAccount()
								local total = tonumber(money)-monto
								p:setData ( "Roleplay:bank_balance", tonumber(total) )
								account:setData( "Roleplay:bank_balance", tonumber(total) )
								p:giveMoney (monto)
								outputDebugString("* "..p:getName().." ha retirado: $"..convertNumber(monto).." ", 0, 150, 0, 0)
								p:outputChat("* Has retirado la cantidad: #004500$"..convertNumber(monto).." dólares.", 150, 0, 0, true)
								--
									local f = getRealTime()
								insert("insert into `BancoLog` VALUES (?,?,?,?)", convertNumber(monto), "Retiro", f.monthday.."/"..f.month+1 .."/"..f.year-100, AccountName(p))
							else
								p:outputChat("* No tienes la cantidad: "..convertNumber(monto).." para retirar", 150, 0, 0)
							end
						end
					else
						p:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
					end
				end
			end
			if (not antiSpamComando[p]) then
				antiSpamComando[p] = {}
			end
			antiSpamComando[p][1] = getTickCount()
		end
	end
end)

addCommandHandler("fondo", function(p, cmd)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			local tick = getTickCount()
			if (antiSpamComando[p] and antiSpamComando[p][1] and tick - antiSpamComando[p][1] < 1000) then
				p:outputChat("Debes esperar 1 segundo después de ser utilizado.", 150, 0, 0)
				return
			end
			for i, v in ipairs(colsShapes) do
				if p:isWithinColShape(v) then
					local s = p:getData("Roleplay:tarjeta_credito")
					if s == 1 then
						local fondo = p:getData ( "Roleplay:bank_balance", tonumber(total) )
						p:outputChat("#00ff00Balance: $"..convertNumber(fondo).." dolares",255,255,255,true)
					else
						p:outputChat("No tienes una tarjeta de crédito ve al ayuntamiento a sacar una.", 150, 50, 50, true)
					end
				end
			end
			if (not antiSpamComando[p]) then
				antiSpamComando[p] = {}
			end
			antiSpamComando[p][1] = getTickCount()
		end
	end
end)