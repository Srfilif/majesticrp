loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local playerid = { }

function LoginPlayer( user, pass, checkbox )
	local acc = Account(user, pass)
	if checkbox == true then
		triggerClientEvent(source, "POPLife:saveDataToXML", getRootElement(), user, pass)
	else
		triggerClientEvent(source, "POPLife:resetSaveXML", getRootElement(), user, pass)
	end
	if acc ~= false then
		source:setName(user)
		setTimer(setPlayerName, 1000, 5, source, user)
		setTimer(logIn, 500, 1, source, acc, pass)
		local s = query("SELECT * FROM datos_personajes where Cuenta = ?", user)
		if not ( type( s ) == "table" and #s == 0 ) or not s then
			local sexo = s[1]["Sexo"]
			local test = s[1]["TestRoleplay"]
			if test == "No" then
				setTimer(triggerClientEvent, 1000, 1, source, "setVisibleTestRol", source)
			end
		else
		end
		local myskin = getElementData(source,"OriginalSkin") or 0

		setElementModel(source,myskin)
		--
		triggerClientEvent(source, "detenerTransicion", source)
		setTimer(triggerClientEvent, 500, 1, source, "Roleplay:DestroyLogin", source)
	else
		source:triggerEvent("Roleplay:ErrorLogin", source)
		source:triggerEvent("callNotification", source, "error", "Usuario o Contraseña, incorrecto(a)", true)
	end
end
addEvent("Roleplay:LoginPlayer", true)
addEventHandler("Roleplay:LoginPlayer", root, LoginPlayer)

function RegisterPlayer(user, pass)
	local maximo = query("SELECT * FROM registros where Serial = ?", source:getSerial())
	local accc = Account.add (user, pass)
	if accc then
		if #maximo == 10 then
			source:triggerEvent("callNotification", source, "error", "No puedes tener mas de 1 cuentas", true)
			setTimer(kickPlayer, 100, 1, source, "Console", "No puedes tener mas de 1 cuentas")
			cancelEvent()
		else
			local ip = source:getIP()
			local serial = source:getSerial()
			local f = getRealTime()
			insert("insert into `registros` VALUES (?,?,?,?,?)", user, pass, serial, ip, f.monthday.."/"..f.month+1 .."/"..f.year-100)
			--source:triggerEvent("callNotification", source, "info", "Acabas de ser registrado, ahora logea.", true)
		end
	else
		source:triggerEvent("Roleplay:ErrorLogin", source)
		source:triggerEvent("callNotification", source, "error", "Por favor, escriba bien sus datos.", true)
	end
end
addEvent("Roleplay:RegisterPlayer", true)
addEventHandler("Roleplay:RegisterPlayer", root, RegisterPlayer)

addCommandHandler("fixcamera", function(source)
	source:fadeCamera(true, 0.5)
	source:setCameraTarget(source)
end)

addEventHandler("onPlayerJoin", getRootElement(), function()
	newPlayerID( source )
end)

function newPlayerID( player )
	for i = 1, getMaxPlayers( ) do
		if not ( playerid[ i ] ) then
			playerid[ i ] = player
			player:setData( "ID", i )
			break
		end
	end
end

function getPlayerByID( id )
	for i = 1, getMaxPlayers( ) do
		if ( playerid[ i ] ) then
			print( getPlayerName( playerid[ i ] ) )
			return playerid[ i ]
		end
	end
end

addEventHandler( "onPlayerQuit", root,
	function( )
		for i = 1, getMaxPlayers() do
			if ( playerid[ i ] == source ) then
				playerid[ i ] = nil
				break
			end
		end
	end
)


