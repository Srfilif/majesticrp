addEvent("AdminPanel",true)
addEventHandler("AdminPanel", root, function()
    if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(source)),aclGetGroup("Admin")) then
        triggerClientEvent(source,"openWindow",source)
    end
end)

function onLoginPlayer()
    setElementData(source, "p:login", getAccountName(getPlayerAccount(source)))
    setElementData(source, "p:IP", getPlayerIP(source))
    setElementData(source, "p:Version", getPlayerVersion(source))
    
    local playeraccount = getPlayerAccount(source)
    setElementData(source, "p:Money", getAccountData(playeraccount, "schetBank2"))
end
addEventHandler("onPlayerLogin", getRootElement(), onLoginPlayer)

function report (src, cmd)
    triggerClientEvent("reportOn",src)
end
addCommandHandler ("rep", report)

function mutePlayer1(player)
    setPlayerMuted(getPlayerFromName(player), true)
    setTimer(function() setPlayerMuted(getPlayerFromName(player), false) end, 120000, 1)
    outputChatBox("#FFD700[Информация] #FFFFFFВам был выдан мут за мат в чате на #FF00002 #FFFFFFмин.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("mutePlayer1", true)
addEventHandler("mutePlayer1", resourceRoot, mutePlayer1)

function mutePlayer2(player)
    setPlayerMuted(getPlayerFromName(player), true)
    setTimer(function() setPlayerMuted(getPlayerFromName(player), false) end, 300000, 1)
    outputChatBox("#FFD700[Информация] #FFFFFFВам был выдан мут за мат в чате на #FF00005 #FFFFFFмин.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("mutePlayer2", true)
addEventHandler("mutePlayer2", resourceRoot, mutePlayer2)

function mutePlayer3(player)
    setPlayerMuted(getPlayerFromName(player), true)
    setTimer(function() setPlayerMuted(getPlayerFromName(player), false) end, 600000, 1)
    outputChatBox("#FFD700[Информация] #FFFFFFВам был выдан мут за мат в чате на #FF000010 #FFFFFFмин.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("mutePlayer3", true)
addEventHandler("mutePlayer3", resourceRoot, mutePlayer3)

function mutePlayer4(player)
    setPlayerMuted(getPlayerFromName(player), true)
    setTimer(function() setPlayerMuted(getPlayerFromName(player), false) end, 1800000, 1)
    outputChatBox("#FFD700[Информация] #FFFFFFВам был выдан мут за мат в чате на #FF000030 #FFFFFFмин.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("mutePlayer4", true)
addEventHandler("mutePlayer4", resourceRoot, mutePlayer4)

function mutePlayer5(player)
    setPlayerMuted(getPlayerFromName(player), true)
    setTimer(function() setPlayerMuted(getPlayerFromName(player), false) end, 3600000, 1)
    outputChatBox("#FFD700[Информация] #FFFFFFВам был выдан мут за мат в чате на #FF00001 #FFFFFFчас.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("mutePlayer5", true)
addEventHandler("mutePlayer5", resourceRoot, mutePlayer5)

function mutePlayer6(player)
    setPlayerMuted(getPlayerFromName(player), true)
    outputChatBox("#FFD700[Информация] #FFFFFFВам был выдан мут за мат в чате.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("mutePlayer6", true)
addEventHandler("mutePlayer6", resourceRoot, mutePlayer6)

function giveSkinAdmin(player,text)
    setElementModel(getPlayerFromName(player), text)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор выдал вам скин. ID: #00FF00"..text, getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("giveSkinAdmin", true)
addEventHandler("giveSkinAdmin", resourceRoot, giveSkinAdmin)

function giveDimensionAdmin(player,text)
    setElementDimension(getPlayerFromName(player), text)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор установил вам #00FF00"..text.." #FFFFFFизмерение.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("giveDimensionAdmin", true)
addEventHandler("giveDimensionAdmin", resourceRoot, giveDimensionAdmin)

function giveMoneyAdmin(player,text)
    givePlayerMoney(getPlayerFromName(player), text)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор выдал вам #00FF00"..text.." #FFFFFFруб.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("giveMoneyAdmin", true)
addEventHandler("giveMoneyAdmin", resourceRoot, giveMoneyAdmin)

function giveVehicleAdmin(player,giveVeh,nameVeh)
    local x,y,z = getElementPosition(getPlayerFromName(player))
    local veh = createVehicle(giveVeh, x, y, z, 0, 0, 0)
    warpPedIntoVehicle(getPlayerFromName(player), veh)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор выдал вам автомобиль #00FF00"..nameVeh.."", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("giveVehicleAdmin", true)
addEventHandler("giveVehicleAdmin", resourceRoot, giveVehicleAdmin)

function giveWeaponAdmin(player,giveWeap,nameWeap)
    giveWeapon(getPlayerFromName(player),giveWeap, 90)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор выдал вам #00FF00"..nameWeap.."", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("giveWeaponAdmin", true)
addEventHandler("giveWeaponAdmin", resourceRoot, giveWeaponAdmin)

function giveInteriorAdmin(player,giveInt,x, y, z,rot)
    local vehicle = getPedOccupiedVehicle(getPlayerFromName(player))
    if ( vehicle ) then 
        setElementInterior(vehicle, giveInt)
        setElementPosition(vehicle, x, y, z + 0.2 )
    else
        setElementInterior(getPlayerFromName(player), giveInt)
        setElementPosition(getPlayerFromName(player), x, y, z + 0.2)
        setPedRotation(getPlayerFromName(player), rot)
    end
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор установил вам #00FF00"..giveInt.." #FFFFFFинтерьер.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("giveInteriorAdmin", true)
addEventHandler("giveInteriorAdmin", resourceRoot, giveInteriorAdmin)

function banPlayerAdmin(player,text)
    banPlayer(getPlayerFromName(player), player, text)
    outputChatBox("#FFD700[Информация] #FFFFFFИгрок "..getPlayerFromName(player).." забанен. Причина: "..text, source, 255, 255, 255, true)
end
addEvent("banPlayerAdmin", true)
addEventHandler("banPlayerAdmin", resourceRoot, banPlayerAdmin)

function kickPlayerAdmin(player)
    kickPlayer(getPlayerFromName(player), "Кикнуты админом.")
end
addEvent("kickPlayerAdmin", true)
addEventHandler("kickPlayerAdmin", resourceRoot, kickPlayerAdmin)

function freezePlayer(player)
    setElementFrozen(getPlayerFromName(player), true)
    outputChatBox("#FFD700[Информация] #FFFFFFВас заморозил администратор.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("freezePlayer", true)
addEventHandler("freezePlayer", resourceRoot, freezePlayer)

function anFreezePlayer(player)
    setElementFrozen(getPlayerFromName(player), false)
    outputChatBox("#FFD700[Информация] #FFFFFFВас разморозил администратор.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("anFreezePlayer", true)
addEventHandler("anFreezePlayer", resourceRoot, anFreezePlayer)

function healthPlayer(player)
    setElementHealth(getPlayerFromName(player), 100)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор пополнил вам здоровье на 100 %.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("healthPlayer", true)
addEventHandler("healthPlayer", resourceRoot, healthPlayer)

function armorPlayer(player)
    setPedArmor(getPlayerFromName(player), 100)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор пополнил вам броню на 100 %.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("armorPlayer", true)
addEventHandler("armorPlayer", resourceRoot, armorPlayer)

function jetpackPlayer(player)
    setPedWearingJetpack ( getPlayerFromName(player), not isPedWearingJetpack ( getPlayerFromName(player) ) )
end
addEvent("jetpackPlayer", true)
addEventHandler("jetpackPlayer", resourceRoot, jetpackPlayer)

function commSuicide(player)
    killPed(getPlayerFromName(player))
end
addEvent("commSuicide", true)
addEventHandler("commSuicide", getRootElement(), commSuicide)

function anHealthPlayer(player)
    setElementHealth(getPlayerFromName(player), getElementHealth(getPlayerFromName(player)) - 20)
    outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор отнял вам здоровье на 20 %.", getPlayerFromName(player), 255, 255, 255, true)
end
addEvent("anHealthPlayer", true)
addEventHandler("anHealthPlayer", resourceRoot, anHealthPlayer)

function onPrava(player)
    local data_1 = getElementData(getPlayerFromName(player),"license:auto")
    if data_1 then
        setElementData(getPlayerFromName(player),"license:auto",false)
        local vehicle = getPedOccupiedVehicle(getPlayerFromName(player))
        removePedFromVehicle(getPlayerFromName(player))
        if isElement(vehicle) then destroyElement(vehicle) end
        outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор забрал ваши права.",getPlayerFromName(player),255,255,255,true)
    end
end
addEvent("onPrava", true)
addEventHandler("onPrava", resourceRoot, onPrava)

function wantedLevel1 ( player )
	outputChatBox("#FFD700[Информация] #FFFFFFВам выдана 1 звезда розыска.",getPlayerFromName(player),255,255,255,true)
    setPlayerWantedLevel(getPlayerFromName(player), math.min(6, getPlayerWantedLevel(getPlayerFromName(player)) + 1))
end
addEvent("wantedLevel1", true)
addEventHandler("wantedLevel1", resourceRoot, wantedLevel1)

function wantedLevel2 ( player )
	outputChatBox("#FFD700[Информация] #FFFFFFВам выдано 2 звезды розыска.",getPlayerFromName(player),255,255,255,true)
    setPlayerWantedLevel(getPlayerFromName(player), math.min(6, getPlayerWantedLevel(getPlayerFromName(player)) + 2))
end
addEvent("wantedLevel2", true)
addEventHandler("wantedLevel2", resourceRoot, wantedLevel2)

function wantedLevel3 ( player )
	outputChatBox("#FFD700[Информация] #FFFFFFВам выдано 3 звезды розыска.",getPlayerFromName(player),255,255,255,true)
    setPlayerWantedLevel(getPlayerFromName(player), math.min(6, getPlayerWantedLevel(getPlayerFromName(player)) + 3))
end
addEvent("wantedLevel3", true)
addEventHandler("wantedLevel3", resourceRoot, wantedLevel3)

function wantedLevel4 ( player )
	outputChatBox("#FFD700[Информация] #FFFFFFВам выдано 4 звезды розыска.",getPlayerFromName(player),255,255,255,true)
    setPlayerWantedLevel(getPlayerFromName(player), math.min(6, getPlayerWantedLevel(getPlayerFromName(player)) + 4))
end
addEvent("wantedLevel4", true)
addEventHandler("wantedLevel4", resourceRoot, wantedLevel4)

function wantedLevel5 ( player )
	outputChatBox("#FFD700[Информация] #FFFFFFВам выдано 5 звезд розыска.",getPlayerFromName(player),255,255,255,true)
    setPlayerWantedLevel(getPlayerFromName(player), math.min(6, getPlayerWantedLevel(getPlayerFromName(player)) + 5))
end
addEvent("wantedLevel5", true)
addEventHandler("wantedLevel5", resourceRoot, wantedLevel5)

function wantedLevel6 ( player )
	outputChatBox("#FFD700[Информация] #FFFFFFВам выдано 6 звезд розыска.",getPlayerFromName(player),255,255,255,true)
    setPlayerWantedLevel(getPlayerFromName(player), math.min(6, getPlayerWantedLevel(getPlayerFromName(player)) + 6))
end
addEvent("wantedLevel6", true)
addEventHandler("wantedLevel6", resourceRoot, wantedLevel6)

function wantedLevel7 ( player )
	outputChatBox("#FFD700[Информация] #FFFFFFС вас сняты все звезды розыска.",getPlayerFromName(player),255,255,255,true)
    setPlayerWantedLevel(getPlayerFromName(player), 0)
end
addEvent("wantedLevel7", true)
addEventHandler("wantedLevel7", resourceRoot, wantedLevel7)

function fixVeh(player)
    local veh = getPedOccupiedVehicle(getPlayerFromName(player))
    if veh then
        fixVehicle(veh)
        outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор починил ваш автомобиль.",getPlayerFromName(player),255,255,255,true)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно починили Т/С игрока "..player,source,255,255,255,true)
    else
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFИгрок не в автомобиле.",source,255,255,255,true)
    end
end
addEvent("fixVeh",true)
addEventHandler("fixVeh",root,fixVeh)

function destroyVeh(player)
    local veh = getPedOccupiedVehicle(getPlayerFromName(player))
    if veh then
        if isElement(veh) then destroyElement(veh) end
        outputChatBox("#FFD700[Информация] #FFFFFFАдминистратор забрал у вас автомобиль.",getPlayerFromName(player),255,255,255,true)
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFВы успешно забрали Т/С у игрока "..player,source,255,255,255,true)
    else
        outputChatBox("#1E90FF[Админ-панель] #FFFFFFИгрок не в автомобиле.",source,255,255,255,true)
    end
end
addEvent("destroyVeh",true)
addEventHandler("destroyVeh",root,destroyVeh)

function giveTPAdmin1(driver, player)
    local x, y, z = getElementPosition(getPlayerFromName(player))
    setElementPosition(driver, x, y, z + 0.5)
end
addEvent("giveTPAdmin1", true)
addEventHandler("giveTPAdmin1", resourceRoot, giveTPAdmin1)

function giveTPAdmin2(driver, player)
    local x, y, z = getElementPosition(driver)
    setElementPosition(getPlayerFromName(player), x, y, z + 0.5)
end
addEvent("giveTPAdmin2", true)
addEventHandler("giveTPAdmin2", resourceRoot, giveTPAdmin2)

-------------------------------------------------------

local x,y,z = -2269, 3439, 34
local players = { }

function hitTheOs(killer, src)
    if ( getPlayerFromName(killer) ) then
        if getElementType ( getPlayerFromName(killer) ) == "player" then
            if ( source ~= getPlayerFromName(killer) ) then
                if not players [ getPlayerFromName(killer) ] then
                    players [ getPlayerFromName(killer) ] = { getElementPosition ( getPlayerFromName(killer) ) }
                    setElementPosition(getPlayerFromName(killer), x, y, z)
                    setElementData(getPlayerFromName(killer), "skin:player", getElementModel(getPlayerFromName(killer)))
                    setElementModel(getPlayerFromName(killer), 284)
                    outputChatBox("#FFD700[Информация] #FFFFFFОставшееся время нахождения на острове: #FF000010 #FFFFFFмин.",getPlayerFromName(killer),255,255,255,true)
                    outputChatBox("#FFD700[Информация] #FFFFFFВы были отправлены в тюрьму *Алькатрас* сотрудником полиции.",getPlayerFromName(killer),255,255,255,true)
                    toggleControl ( getPlayerFromName(killer), "fire", false )
                    setTimer(function()
                        triggerClientEvent(getPlayerFromName(killer), "killWindow1", getPlayerFromName(killer))
                    end, 600000, 1)
                end
            end
        elseif getElementType ( getPlayerFromName(killer) ) == "vehicle" then
            killer = getVehicleOccupant ( getPlayerFromName(killer) )
            if ( getPlayerFromName(killer) ) then
                if not players [ getPlayerFromName(killer) ] then
                    players [ getPlayerFromName(killer) ] = { getElementPosition ( getPlayerFromName(killer) ) }
                    local vehicle = getPedOccupiedVehicle(getPlayerFromName(killer))
                    removePedFromVehicle(getPlayerFromName(killer))
                    if isElement(vehicle) then destroyElement(vehicle) end
                    setElementPosition(getPlayerFromName(killer), x, y, z)
                    setElementData(getPlayerFromName(killer), "skin:player", getElementModel(getPlayerFromName(killer)))
                    setElementModel(getPlayerFromName(killer), 284)
                    outputChatBox("#FFD700[Информация] #FFFFFFОставшееся время нахождения на острове: #FF000010 #FFFFFFмин.",getPlayerFromName(killer),255,255,255,true)
                    outputChatBox("#FFD700[Информация] #FFFFFFВы были отправлены в тюрьму *Алькатрас* сотрудником полиции.",getPlayerFromName(killer),255,255,255,true)
                    toggleControl ( getPlayerFromName(killer), "fire", false )
                    setTimer(function()
                        triggerClientEvent(getPlayerFromName(killer), "killWindow1", getPlayerFromName(killer))
                    end, 600000, 1)
                end
            end
        end
    end
end
addEvent("hitTheOs",true)
addEventHandler("hitTheOs",root,hitTheOs)

function kill_Sf1()
    setElementPosition(source, -1975.8571777344,-89.937370300293,110.41878509521)
    setElementModel(source, getElementData(source, "skin:player"))
    outputChatBox("#FFD700[Информация] #FFFFFFВас отправили в полицейский участок Сан-Фиерро.",source,255,255,255,true)
    toggleControl ( source, "fire", true )
    players [ source ] = nil
end
addEvent("kill_Sf1", true)
addEventHandler("kill_Sf1", getRootElement (), kill_Sf1)

function kill_Lv1()
    setElementPosition(source, -1620.6359863281,-198.31228637695,109.63124847412)
    setElementModel(source, getElementData(source, "skin:player"))
    outputChatBox("#FFD700[Информация] #FFFFFFВас отправили в полицейский участок Лас-Вентурас.",source,255,255,255,true)
    toggleControl ( source, "fire", true )
    players [ source ] = nil
end
addEvent("kill_Lv1", true)
addEventHandler("kill_Lv1", getRootElement (), kill_Lv1)

function kill_Ls1()
    setElementPosition(source, -1960.7445068359,-2704.337890625,114.71294403076)
    setElementModel(source, getElementData(source, "skin:player"))
    outputChatBox("#FFD700[Информация] #FFFFFFВас отправили в полицейский участок Лос-Сантос.",source,255,255,255,true)
    toggleControl ( source, "fire", true )
    players [ source ] = nil
end
addEvent("kill_Ls1", true)
addEventHandler("kill_Ls1", getRootElement (), kill_Ls1)

addEventHandler ( "onPlayerSpawn", root,
	function ( )
		if players [ source ] then
			setElementPosition(source, x, y, z)
		end
	end
)

addEventHandler ( "onPlayerQuit", root,
	function ( )
		if players [ source ] then
			players [ source ] = nil
		end
	end
)