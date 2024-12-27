-- SAVE LICENSES
addEventHandler("onPlayerLogin", getRootElement(), function(p, t, a)
	local conducir = t:getData("Basurero:Exp")
	if (conducir) then
		local va = t:getData("Basurero:Exp")
		source:setData("Basurero:Exp", va)
	else
		source:setData("Basurero:Exp", 1)
	end
	local nivel = t:getData("Basurero:Nivel")
	if nivel then
		source:setData("Basurero:Nivel", nivel)
	else
		source:setData("Basurero:Nivel", 1)
	end
end)

function quitPizzero(q, r, e)
	local account = source:getAccount()
	if (account) then
		local va = source:getData("Basurero:Exp")
		account:setData("Basurero:Exp", va)
		local va2 = source:getData("Basurero:Nivel")
		account:setData("Basurero:Nivel",va2)
	end
end
addEvent("onStopResource", true)
addEventHandler("onPlayerQuit", getRootElement(), quitPizzero)
addEventHandler("onStopResource", getRootElement(), quitPizzero)

function stopPizzero( )
	for i, v in ipairs( Element.getAllByType("player") ) do
		if not notIsGuest( v ) then
			triggerEvent("onStopResource", v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, stopPizzero)