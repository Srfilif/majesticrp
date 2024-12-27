


------------------------
-- BATE-----------------
------------------------
addEvent("bate", true)
addEventHandler("bate",root,
function()
   local pedSlot = getPedWeaponSlot ( source )
   local weaponType = getPedWeapon ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   setPedWeaponSlot ( source,1 )
   
   if crafteando == 0 then
   if xp_armero >= 0 then
   if pedSlot == 1 then
      if weaponType == 5 then
         outputChatBox ( "#0059bf[Materiales]#ff3d3d Ya tienes este objeto, tiralo para poder craftear uno nuevo.", source, 255, 0, 0, true )
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
       
      end
   
   else
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",source)


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un bate correctamente", player, 255, 0, 0, true )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz ganado #00ff00+15 #ffffffde experiencia de Armero", player, 255, 0, 0, true )
      
         
         giveWeapon (player ,  5,1 ) 
      end, 18000, 1, source)





   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes suficiente nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
   
   
end)




addEvent("martillo", true)
addEventHandler("martillo",root,
function()
   local pedSlot = getPedWeaponSlot ( source )
   local weaponType = getPedWeapon ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   setPedWeaponSlot ( source,10 )
   
   if crafteando == 0 then
   if xp_armero >= 0 then
   if pedSlot == 10 then
      if weaponType == 10 then
         outputChatBox ( "#0059bf[Materiales]#ff3d3d Ya tienes este objeto, tiralo para poder craftear uno nuevo.", source, 255, 0, 0, true )
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
       
      end
   
   else
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",source)


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 7 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un Martillo correctamente", player, 255, 0, 0, true )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz ganado #00ff00+7 #ffffffde experiencia de Armero", player, 255, 0, 0, true )
      
         
         giveWeapon (player ,  10,1 ) 
      end, 18000, 1, source)





   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes suficiente nivel para craftear esto, Tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
   
   
end)

addEvent("9mm", true)
addEventHandler("9mm",root,
function()
local pedSlot = getPedWeaponSlot ( source )
local weaponType = getPedWeapon ( source )
local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
setPedWeaponSlot ( source,2 )

if crafteando == 0 then
if xp_armero >= 120 then
if pedSlot == 2 then
   if weaponType == 22 then
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",getRootElement())


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Ya tenias esta arma, haz crafteado 17 bala(s)", player, 255, 0, 0, true )
         giveWeapon (player ,  22,17 ) 
      end, 18000, 1, source)





	else
	outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
	 
	end

else

setPedWeaponSlot ( source,2 )
giveWeapon ( source ,  22,17 )
outputChatBox ( "#0059bf[Materiales]#ffffff Haz usado tus materiales y crafteado una 9mm correctamente", source, 255, 0, 0, true )
setPedWeaponSlot ( source,2)
setElementData ( source, "Roleplay:Materiales", materiales - 750 ) 
setElementData ( source, "Roleplay:Experiencia_Armero", xp_armero + 15 )
triggerClientEvent("Materiales:Martillo",source)


end
else
   outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes Suficiente Nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
end
else
   outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
end


end)

addEvent("desert", true)
addEventHandler("desert",root,
function()
   local pedSlot = getPedWeaponSlot ( source )
   local weaponType = getPedWeapon ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   setPedWeaponSlot ( source,2 )
   
   if crafteando == 0 then
   if xp_armero >= 120 then
   if pedSlot == 2 then
      if weaponType == 24 then
         setElementFrozen( source, true )
         setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
         outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
         setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
         triggerClientEvent("Materiales:Martillo",source)
   
   
         setTimer( function(player)
            setPedAnimation (player)
            setElementFrozen( player, false )
            setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
            setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
            setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
            outputChatBox ( "#0059bf[Materiales]#ffffff Ya tenias esta arma, haz crafteado 7 bala(s)", player, 255, 0, 0, true )
            giveWeapon (player ,  24,7 ) 
         end, 18000, 1, source)
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
       
      end
   
   else
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",source)


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 7 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un bate correctamente", player, 255, 0, 0, true )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz ganado #00ff00+7 #ffffffde experiencia de Armero", player, 255, 0, 0, true )
      
         
         giveWeapon (player ,  24,7 ) 
      end, 18000, 1, source)





   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes suficiente nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
   
   
end)

addEvent("ak47", true)
addEventHandler("ak47",root,
function()
   local pedSlot = getPedWeaponSlot ( source )
   local weaponType = getPedWeapon ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   setPedWeaponSlot ( source,5 )
   
   if crafteando == 0 then
   if xp_armero >= 700 then
   if pedSlot == 5 then
      if weaponType == 30 then
         setElementFrozen( source, true )
         setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
         outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
         setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
         triggerClientEvent("Materiales:Martillo",source)
   
   
         setTimer( function(player)
            setPedAnimation (player)
            setElementFrozen( player, false )
            setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
            setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
            setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
            outputChatBox ( "#0059bf[Materiales]#ffffff Ya tenias esta arma, haz crafteado 7 bala(s)", player, 255, 0, 0, true )
            giveWeapon (player ,  30,30 ) 
         end, 18000, 1, source)
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
       
      end
   
   else
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",source)


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 7 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un bate correctamente", player, 255, 0, 0, true )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz ganado #00ff00+7 #ffffffde experiencia de Armero", player, 255, 0, 0, true )
      
         
         giveWeapon (player ,  30,30 ) 
      end, 18000, 1, source)





   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes suficiente nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
   
   
end)

addEvent("uzi", true)
addEventHandler("uzi",root,
function()
   local pedSlot = getPedWeaponSlot ( source )
   local weaponType = getPedWeapon ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   setPedWeaponSlot ( source,4 )
   
   if crafteando == 0 then
   if xp_armero >= 240 then
   if pedSlot == 4 then
      if weaponType == 28 then
         setElementFrozen( source, true )
         setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
         outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
         setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
         triggerClientEvent("Materiales:Martillo",source)
   
   
         setTimer( function(player)
            setPedAnimation (player)
            setElementFrozen( player, false )
            setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
            setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
            setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
            outputChatBox ( "#0059bf[Materiales]#ffffff Ya tenias esta arma, haz crafteado 7 bala(s)", player, 255, 0, 0, true )
            giveWeapon (player ,  28,30 ) 
         end, 18000, 1, source)
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
       
      end
   
   else
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",source)


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 7 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un bate correctamente", player, 255, 0, 0, true )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz ganado #00ff00+7 #ffffffde experiencia de Armero", player, 255, 0, 0, true )
      
         
         giveWeapon (player ,  28,30 ) 
      end, 18000, 1, source)





   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes Suficiente Nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
   
   
end)


addEvent("tec9", true)
addEventHandler("tec9",root,
function()
   local pedSlot = getPedWeaponSlot ( source )
   local weaponType = getPedWeapon ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   setPedWeaponSlot ( source,4 )
   
   if crafteando == 0 then
   if xp_armero >= 240 then
   if pedSlot == 4 then
      if weaponType == 32 then
         setElementFrozen( source, true )
         setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
         outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
         setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
         triggerClientEvent("Materiales:Martillo",source)
   
   
         setTimer( function(player)
            setPedAnimation (player)
            setElementFrozen( player, false )
            setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
            setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
            setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
            outputChatBox ( "#0059bf[Materiales]#ffffff Ya tenias esta arma, haz crafteado 7 bala(s)", player, 255, 0, 0, true )
            giveWeapon (player ,  32,50 ) 
         end, 18000, 1, source)
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
       
      end
   
   else
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",source)


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 7 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un bate correctamente", player, 255, 0, 0, true )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz ganado #00ff00+7 #ffffffde experiencia de Armero", player, 255, 0, 0, true )
      
         
         giveWeapon (player ,  32,50 ) 
      end, 18000, 1, source)





   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes suficiente nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
   
   
end)




addEvent("mp5", true)
addEventHandler("mp5",root,
function()
   local pedSlot = getPedWeaponSlot ( source )
   local weaponType = getPedWeapon ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   setPedWeaponSlot ( source,4 )
   
   if crafteando == 0 then
   if xp_armero >= 700 then
   if pedSlot == 4 then
      if weaponType == 29 then
         setElementFrozen( source, true )
         setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
         outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
         setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
         triggerClientEvent("Materiales:Martillo",source)
   
   
         setTimer( function(player)
            setPedAnimation (player)
            setElementFrozen( player, false )
            setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
            setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
            setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
            outputChatBox ( "#0059bf[Materiales]#ffffff Ya tenias esta arma, haz crafteado 7 bala(s)", player, 255, 0, 0, true )
            giveWeapon (player ,  29,30 ) 
         end, 18000, 1, source)
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un arma en este slot (2), tirala para poder craftear",source,255,255,255,true)
       
      end
   
   else
      setElementFrozen( source, true )
      setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
      outputChatBox ( "#0059bf[Materiales]#77ff77 Has empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
      triggerClientEvent("Materiales:Martillo",source)


      setTimer( function(player)
         setPedAnimation (player)
         setElementFrozen( player, false )
         setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
         setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
         setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 7 )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un bate Correctamente", player, 255, 0, 0, true )
         outputChatBox ( "#0059bf[Materiales]#ffffff Haz ganado #00ff00+7 #ffffffde experiencia de Armero", player, 255, 0, 0, true )
      
         
         giveWeapon (player ,  29,30 ) 
      end, 18000, 1, source)
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes suficiente nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
end)





addEvent("chaleco", true)
addEventHandler("chaleco",root,
function()
local armor = getPedArmor ( source )
local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0


if crafteando == 0 then
   if xp_armero >= 120 then
      if armor < 21 then
         setElementFrozen( source, true )
         setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
         outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a craftear un objeto por espera...", source, 255, 0, 0, true )
         setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
         triggerClientEvent("Materiales:Martillo",source)
   
   
         setTimer( function(player)
            setPedAnimation (player)
            setElementFrozen( player, false )
            setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
            setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
            setElementData ( player, "Roleplay:Experiencia_Armero", xp_armero + 15 )
            outputChatBox ( "#0059bf[Materiales]#ffffff Haz crafteado un Chaleco correctamente", player, 255, 0, 0, true )
            setPedArmor (player,100)
         end, 18000, 1, source)
      else
      outputChatBox("#0059bf[Materiales]#ff3d3d Ya tienes un chaleco, tiralo para craftear uno nuevo",source,255,255,255,true)
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3d No tienes suficiente nivel para craftear esto, tienes ("..xp_armero.."/120)", source, 255, 0, 0, true )
   end
   else
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas crafteando un objeto....", source, 255, 0, 0, true )
   end
end)









function darmaths(playerSource, commandName, id, cant)
   local Player = getPlayerFromName ( id ) 
   
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
 --    setElementData ( player, "Roleplay:Materiales", materiales + 100000 )
   --  outputChatBox("#0059bf[Materiales] #b2b1b1Se te añadieron #00ff00100.000 #b2b1b1materiales, ahora tienes #00ff00"..materiales.."#b2b1b1.",playerSource,255,255,255,true)


     if Player and cant and tonumber(cant) then
      local materiales =  getElementData ( Player, "Roleplay:Materiales" ) or 0
     outputChatBox("#0059bf[Materiales] #b2b1b1Se le añadieron #00ff00"..tonumber(cant).." #b2b1b1materiales a #ffff00"..id.."#b1b1b1, ahora tiene #00ff00"..tonumber(materiales + cant).."#b2b1b1.",playerSource,255,255,255,true)
     outputChatBox("#0059bf[Materiales] #b2b1b1Se te añadieron #00ff00"..tonumber(cant).." #b2b1b1materiales, ahora tienes #00ff00"..tonumber(materiales + cant).."#b2b1b1.",playerSource,255,255,255,true)
     setElementData ( Player, "Roleplay:Materiales", materiales + tonumber(cant) )
     else
      outputChatBox("#0059bf[Materiales] #ff3d3dSyntaxis Correcta: /darmateriales [Nombre_Apellido] [Cantidad]",playerSource,255,255,255,true)

     end



   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes permisos para usar esto </>",255,255,255,true)
   
   end
end
addCommandHandler("dar-materiales",darmaths)



function darMaterialesATodos(playerSource, commandName, cant)
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
       local cantMateriales = tonumber(cant)
       
       if cantMateriales then
           for _, player in ipairs(getElementsByType("player")) do
               local materiales = getElementData(player, "Roleplay:Materiales") or 0
               setElementData(player, "Roleplay:Materiales", materiales + cantMateriales)
               outputChatBox("#0059bf[Materiales] #b2b1b1Se te añadieron #00ff00" .. cantMateriales .. " #b2b1b1materiales, ahora tienes #00ff00" .. (materiales + cantMateriales) .. "#b2b1b1.", player, 255, 255, 255, true)
           end
           outputChatBox("#0059bf[Materiales] #b2b1b1Se añadieron #00ff00" .. cantMateriales .. " #b2b1b1materiales a todos los jugadores.", playerSource, 255, 255, 255, true)
       else
           outputChatBox("#0059bf[Materiales] #ff3d3dSintaxis Correcta: /darmaterialesatodos [Cantidad]", playerSource, 255, 255, 255, true)
       end
   else
       outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes permisos para usar esto</>", 255, 255, 255, true)
   end
end

addCommandHandler("dar-materialesatodos", darMaterialesATodos)

function pagarMateriales(playerSource, commandName, id, cant)
   local jugadorEmisor = playerSource
   if not id or not cant then
      outputChatBox("#0059bf[Materiales] #ff3d3dSintaxis Correcta: /pagarmateriales [Nombre_Apellido] [Cantidad]", jugadorEmisor, 255, 255, 255, true)
      return
  end
   local jugadorReceptor = getPlayerFromName(id)

   if not jugadorReceptor then
       outputChatBox("#0059bf[Materiales] #ff3d3dEl jugador '" .. id .. "' no está en línea.", jugadorEmisor, 255, 255, 255, true)
       return
   end
   if jugadorEmisor == jugadorReceptor then
      outputChatBox("#0059bf[Materiales] #ff3d3dNo puedes transferir materiales a ti mismo.", jugadorEmisor, 255, 255, 255, true)
      return
  end

   
   local cantMateriales = tonumber(cant)
   
   if not cantMateriales or cantMateriales <= 0 then
       outputChatBox("#0059bf[Materiales] #ff3d3dPor favor, ingresa una cantidad válida de materiales.", jugadorEmisor, 255, 255, 255, true)
       return
   end
   
   local materialesEmisor = getElementData(jugadorEmisor, "Roleplay:Materiales") or 0
   
   if materialesEmisor >= cantMateriales then
       local materialesReceptor = getElementData(jugadorReceptor, "Roleplay:Materiales") or 0
       
       setElementData(jugadorEmisor, "Roleplay:Materiales", materialesEmisor - cantMateriales)
       setElementData(jugadorReceptor, "Roleplay:Materiales", materialesReceptor + cantMateriales)
       
       outputChatBox("#0059bf[Materiales] #b2b1b1Haz transferido #00ff00" .. cantMateriales .. " #b2b1b1materiales a " .. id .. ".", jugadorEmisor, 255, 255, 255, true)
       outputChatBox("#0059bf[Materiales] #b2b1b1Haz recibido #00ff00" .. cantMateriales .. " #b2b1b1materiales de " .. getPlayerName(jugadorEmisor) .. ".", jugadorReceptor, 255, 255, 255, true)
   else
       outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales para realizar esta transferencia.", jugadorEmisor, 255, 255, 255, true)
   end
end

addCommandHandler("pagarmateriales", pagarMateriales)
addCommandHandler("darmateriales", pagarMateriales)

function quitarMateriales(playerSource, commandName, id, cant)
   if not id or not cant then
      outputChatBox("#0059bf[Materiales] #ff3d3dSintaxis Correcta: /quitarmateriales [Nombre_Apellido] [Cantidad]", jugadorEmisor, 255, 255, 255, true)
      return
  end
   if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(playerSource)), aclGetGroup("Moderator")) then
       local jugador = getPlayerFromName(id)

       if not jugador then
           outputChatBox("#0059bf[Materiales] #ff3d3dEl jugador '" .. id .. "' no está en línea.", playerSource, 255, 255, 255, true)
           return
       end
       
       local cantMateriales = tonumber(cant)
       
       if not cantMateriales or cantMateriales <= 0 then
           outputChatBox("#0059bf[Materiales] #ff3d3dPor favor, ingresa una cantidad válida de materiales.", playerSource, 255, 255, 255, true)
           return
       end
       
       local materialesJugador = getElementData(jugador, "Roleplay:Materiales") or 0
       
       if materialesJugador >= cantMateriales then
           setElementData(jugador, "Roleplay:Materiales", materialesJugador - cantMateriales)
           outputChatBox("#0059bf[Materiales] #b2b1b1Has quitado #00ff00" .. cantMateriales .. " #b2b1b1materiales a " .. id .. ".", playerSource, 255, 255, 255, true)
       else
           outputChatBox("#0059bf[Materiales] #ff3d3dEl jugador no tiene suficientes materiales para quitar.", playerSource, 255, 255, 255, true)
       end
   else
       outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes permisos para usar este comando.", playerSource, 255, 255, 255, true)
   end
end

addCommandHandler("quitarmateriales", quitarMateriales)



function onDestruiItem(itemData)

   local itemName = itemData.name
   local itemCost = itemData.cost
   local carga = itemData.carga
   local xpWin = itemData.xp
   local ItemID = itemData.id
   local xpRequired = itemData.exp

   local Weapon = getPedWeapon(source)
   local Ammo = getPedTotalAmmo(source)
   local Slot = getPedWeaponSlot ( source )
   local materiales =  getElementData ( source, "Roleplay:Materiales" ) or 0
   local xp_armero =  getElementData ( source, "Roleplay:Experiencia_Armero" ) or 0
   local crafteando =  getElementData ( source, "Roleplay:Armero_Crafteando" ) or 0
   if crafteando == 1 then 
      outputChatBox ( "#0059bf[Materiales]#ff3d3dYa estas destruyendo un objeto....", source, 255, 0, 0, true )
    return
   end
   if itemName == "bate" then
      if Slot == 1 then
         if Weapon == ItemID then
            if Ammo >= carga then
               if xp_armero >= xpRequired then

                  setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
                  takeWeapon(source, ItemID)
                  EMPDestruir(source)
                  ActionDestruction(source)
                  setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

                  setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
               else 
                  outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
               end
            else
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
      end
   elseif itemName == "martillo" then
      if Slot == 10 then
         if Weapon == ItemID then
            if Ammo >= carga then
               if xp_armero >= xpRequired then

                  setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
                  takeWeapon(source, ItemID)
                  EMPDestruir(source)
                  ActionDestruction(source)
                  setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

                  setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
               else 
                  outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
               end
            else
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
      end
   elseif itemName == "9mm" then
      if Slot == 2 then
         if Weapon == ItemID then
            if Ammo >= carga then
               if xp_armero >= xpRequired then

                  setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
                  takeWeapon(source, ItemID, carga)
                  EMPDestruir(source)
                  ActionDestruction(source)
                  setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

                  setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
               else 
                  outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
               end
            else
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
      end
--
elseif itemName == "desert" then
   if Slot == 2 then
      if Weapon == ItemID then
         if Ammo >= carga then
            if xp_armero >= xpRequired then

               setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
               takeWeapon(source, ItemID, carga)
               EMPDestruir(source)
               ActionDestruction(source)
               setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

               setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
            else 
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
      end
   else
      outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
   end
   --
elseif itemName == "ak47" then
   if Slot == 5 then
      if Weapon == ItemID then
         if Ammo >= carga then
            if xp_armero >= xpRequired then

               setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
               takeWeapon(source, ItemID, carga)
               EMPDestruir(source)
               ActionDestruction(source)
               setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

               setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
            else 
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
      end
   else
      outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
   end
   --
elseif itemName == "uzi" then
   if Slot == 4 then
      if Weapon == ItemID then
         if Ammo >= carga then
            if xp_armero >= xpRequired then

               setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
               takeWeapon(source, ItemID, carga)
               EMPDestruir(source)
               ActionDestruction(source)
               setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

               setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
            else 
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
      end
   else
      outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
   end
   --
elseif itemName == "tec9" then
   if Slot == 4 then
      if Weapon == ItemID then
         if Ammo >= carga then
            if xp_armero >= xpRequired then

               setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
               takeWeapon(source, ItemID, carga)
               EMPDestruir(source)
               ActionDestruction(source)
               setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

               setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
            else 
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
      end
   else
      outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
   end
   --
elseif itemName == "mp5" then
   if Slot == 4 then
      if Weapon == ItemID then
         if Ammo >= carga then
            if xp_armero >= xpRequired then

               setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
               takeWeapon(source, ItemID, carga)
               EMPDestruir(source)
               ActionDestruction(source)
               setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin)

               setElementData ( source, "Roleplay:Materiales", materiales + itemCost ) 
            else 
               outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente experiencia para destruir este elemento.", player, 255, 0, 0,true)
            end
         else
            outputChatBox("#0059bf[Materiales]#ff3d3d No tienes suficiente munición", player, 255, 0, 0,true)
         end
      else
         outputChatBox("#0059bf[Materiales]#ff3d3d No tienes esta arma en este slot", player, 255, 0, 0,true)
      end
   else
      outputChatBox("#0059bf[Materiales]#ff3d3d No tienes armas en este slot", player, 255, 0, 0,true)
   end
   --
elseif itemName == "chaleco" then
   local chaleco = getPedArmor(source) -- Obtiene el nivel de chaleco del jugador

   if chaleco >= 60 then
      setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
       -- El jugador tiene chaleco al 100%, quítaselo y envía un mensaje
       setPedArmor(source, 0) -- Quita el chaleco
       --outputChatBox("¡Has perdido tu chaleco!", source)
       EMPDestruir(source)
       ActionDestruction(source)
       setElementData(source, "Roleplay:Experiencia_Armero", xp_armero + xpWin) -- Envía un mensaje al jugador
   elseif chaleco > 0 then
       -- El jugador tiene chaleco, pero no al 100%
       outputChatBox("#0059bf[Materiales] #ff3d3dTu chaleco no esta en condiciones para destruirse", source, 255, 0, 0,true) -- Envía un mensaje al jugador
   else
       -- El jugador no tiene chaleco
       outputChatBox("#0059bf[Materiales] #ff3d3d Tu no tienes chaleco para destruir.", source, 255, 0, 0,true) -- Envía un mensaje al jugador
   end



   else
       -- Elemento no reconocido, puedes manejarlo de acuerdo a tus necesidades
       outputChatBox("#0059bf[Materiales] #ff3d3dElemento no reconocido: " .. itemName, player, 255, 255, 255, true)
   end
  -- outputChatBox("#0059bf[Materiales] #b2b1b1Has destruido un(a) " .. itemName .. ".", player, 255, 255, 255, true)
end
addEvent("destroyEvent", true)
addEventHandler("destroyEvent", root, onDestruiItem)


function ActionDestruction(source)
   setTimer( function(player)
      setPedAnimation (player)
      setElementFrozen( player, false )
      setElementData ( player, "Roleplay:Armero_Crafteando", 0 ) 
      outputChatBox ( "#0059bf[Materiales]#ffffff Haz destruido un objeto correctamente", player, 255, 0, 0, true )
      --setPedArmor (player,100)
   end, 18000, 1, source)

end


function EMPDestruir(source)
setElementFrozen( source, true )
setPedAnimation(source, "COLT45", "sawnoff_reload",-1, true, false, false, false)
outputChatBox ( "#0059bf[Materiales]#77ff77 Haz empezado a destruir un objeto por espera...", source, 255, 0, 0, true )
setElementData ( source, "Roleplay:Armero_Crafteando", 1 ) 
triggerClientEvent("Materiales:Martillo",source)

end 

function applyMods() 
   local skin = engineLoadTXD("gun_dildo1.txd", true) 
   engineImportTXD(skin, 10) 
   local skin = engineLoadDFF("gun_dildo1.dff", 10) 
   engineReplaceModel(skin, 10) 
end 
addEventHandler("onClientResourceStart", resourceRoot, applyMods) 