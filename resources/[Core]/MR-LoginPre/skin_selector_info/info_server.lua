addEvent("Roleplay:CancelarCuenta", true)
addEventHandler("Roleplay:CancelarCuenta", root, function(user, pass)
	source:kick("Console", "Vuelve a poner los datos de tu skins. Tu cuenta es: "..user.."")
	delete("DELETE FROM save_system WHERE Cuenta=?", user)
end)

addEvent("Roleplay:SetDatos", true)
addEventHandler("Roleplay:SetDatos", root, function(nacionalidad, edad, sexo, skin)
	local maximo = query("SELECT * FROM datos_personajes where Serial = ?", source:getSerial())
	if #maximo == 10 then
		source:triggerEvent("Roleplay:ErrorSkin", source)
	else
		local cuenta = AccountName(source)
		local serial = source:getSerial()
		local f = getRealTime()
		source:setName(cuenta)
	source:spawn( 1743.3916015625, -1860.642578125, 13.57848739624, 0, 0, 0)
   --     source:setElementPosition(1743.3916015625, -1860.642578125, 13.57848739624)
		source:outputChat("oli")
		source:setModel(skin)
		source:setRotation(0,0,170)
		setCameraTarget(source, source)
		source:setData("EnEdicion", false)
		source:removeData("EnEdicion")
		source:outputChat("* Si la camara se te bugeo recuerda usar /fixcamera", 150, 0, 0, true)
		source:outputChat("* Cualquier bug o duda que tengas usa /duda", 150, 50, 0, true)
		--
		setTimer(triggerClientEvent, 1000, 1, source, "setVisibleTestRol", source)
		--
		insert("insert into `datos_personajes` VALUES (?,?,?,?,?,?,?)", nacionalidad, edad, sexo, 0, cuenta, 'No', serial)
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	if source:getData("EnEdicion") == true then
		delete("DELETE FROM save_system WHERE Cuenta=?", AccountName(source))
		source:setData("EnEdicion", false)
		source:removeData("EnEdicion")
	end
end)