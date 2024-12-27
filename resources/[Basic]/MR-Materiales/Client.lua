
--This is The Gui of the Script
function Ventana()
        materiales = guiCreateWindow(0.38, 0.30, 0.24, 0.40, "Panel del Materiales", true)
        guiWindowSetSizable(materiales, false)

        combobox = guiCreateComboBox(9, 26, 139, 267, "Micro-Uzi", false, materiales)
        guiComboBoxAddItem(combobox, "Bate")
        guiComboBoxAddItem(combobox, "Martillo")
        guiComboBoxAddItem(combobox, "Colt 45 - 9mm")
        guiComboBoxAddItem(combobox, "Desert Eagle 50c")
        guiComboBoxAddItem(combobox, "AK-47")
        guiComboBoxAddItem(combobox, "Micro-Uzi")
        guiComboBoxAddItem(combobox, "Tec-9")
        guiComboBoxAddItem(combobox, "MP5")
        guiComboBoxAddItem(combobox, "Chaleco Antibalas")
        crear = guiCreateButton(180, 27, 133, 20, "Crear", false, materiales)
        destruir1 = guiCreateButton(180, 58, 133, 20, "Destruir", false, materiales)
        salir = guiCreateButton(180, 278, 133, 20, "Salir", false, materiales)
        label1 = guiCreateLabel(15, 64, 138, 48, "------------------------------\nPOR CONSTRUIR\n------------------------------", false, materiales)
        info1 = guiCreateLabel(15, 108, 138, 68, "\nChatarra necesaria: 750\nNivel necesario: 0\nExp a ganar: 1", false, materiales)
        info2 = guiCreateLabel(15, 225, 138, 68, "\nChatarra a ganar: 250\nNivel necesario: 0\nExp a ganar: 1", false, materiales)
        label1 = guiCreateLabel(15, 181, 138, 48, "------------------------------\nPOR DESTRUIR\n------------------------------", false, materiales)
        img2 = guiCreateStaticImage(0.55, 0.34, 0.41, 0.40, "data/5.png", true, materiales)   
        showCursor(true)
		    addEventHandler("onClientGUIClick",salir,cerrar,false)
	      addEventHandler("onClientGUIClick",crear,craft,false)
	      addEventHandler("onClientGUIClick",destruir1,destruir,false)
	      addEventHandler("onClientGUIClick",combobox,combo,false)
		
		
		
end
addCommandHandler("usarmateriales",Ventana)

function combo()
local combobox = guiComboBoxGetSelected(combobox)
if combobox == 0 then
		 
  guiSetText ( info1, "\nChatarra necesaria: 750\nNivel necesario: 0\nExp a ganar: 9" )
  guiSetText ( info2, "\nChatarra a ganar: 250\nNivel necesario: 0\nExp a ganar: 3" )
  setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/5.png" )
  setPedWeaponSlot ( localPlayer,1 )
 end
 if combobox == 1 then
  
   guiSetText ( info1, "\nChatarra necesaria: 1000\nNivel necesario: 0\nExp a ganar: 7" )
   guiSetText ( info2, "\nChatarra a ganar: 450\nNivel necesario: 0\nExp a ganar: 4" )
   setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/10.png" )
   setPedWeaponSlot ( localPlayer,1 )
 end
 if combobox == 2 then
  
  guiSetText ( info1, "\nChatarra necesaria: 2400\nNivel necesario: 1\nExp a ganar: 15" )
  guiSetText ( info2, "\nChatarra a ganar: 1500\nNivel necesario: 1\nExp a ganar: 7" )
  setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/22.png" )
  setPedWeaponSlot ( localPlayer,2 )
  end

  if combobox == 3 then
		 
    guiSetText ( info1, "\nChatarra necesaria: 3000\nNivel necesario: 1\nExp a ganar: 13" )
    guiSetText ( info2, "\nChatarra a ganar: 2400\nNivel necesario: 0\nExp a ganar: 9" )
    setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/24.png" )
   end
   if combobox == 4 then
    
     guiSetText ( info1, "\nChatarra necesaria: 53000\nNivel necesario: 4\nExp a ganar: 35" )
     guiSetText ( info2, "\nChatarra a ganar: 33000\nNivel necesario: 4\nExp a ganar: 20" )
     setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/30.png" )
   end
   if combobox == 5 then
    
    guiSetText ( info1, "\nChatarra necesaria: 12400\nNivel necesario: 2\nExp a ganar: 15" )
    guiSetText ( info2, "\nChatarra a ganar: 5600\nNivel necesario: 2\nExp a ganar: 12" )
    setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/28.png" )
    end
    if combobox == 6 then
		 
      guiSetText ( info1, "\nChatarra necesaria: 15200\nNivel necesario: 3\nExp a ganar: 20" )
      guiSetText ( info2, "\nChatarra a ganar: 7500\nNivel necesario: 3\nExp a ganar: 16" )
      setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/32.png" )
     end
     if combobox == 7 then
      
       guiSetText ( info1, "\nChatarra necesaria: 25000\nNivel necesario: 4\nExp a ganar: 25" )
       guiSetText ( info2, "\nChatarra a ganar: 17000\nNivel necesario: 4\nExp a ganar: 17" )
       setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/29.png" )
     end
     if combobox == 8 then
      
      guiSetText ( info1, "\nChatarra necesaria: 2500\nNivel necesario: 1\nExp a ganar: 10" )
      guiSetText ( info2, "\nChatarra a ganar: 1000\nNivel necesario: 1\nExp a ganar: 5" )
      setTimer( guiStaticImageLoadImage, 100, 1, img2, "data/chaleco.png" )
      end
end


function cerrar()
   guiSetVisible(materiales,false)
   showCursor(false)
end

function craft()
local combobox = guiComboBoxGetSelected(combobox)
local player = localPlayer
local materiales =  getElementData ( player, "Roleplay:Materiales" ) or 0
local xp_armero =  getElementData ( player, "Roleplay:Experiencia_Armero" ) or 0


if combobox == 0 then
 if materiales >= 750 then
     setPedWeaponSlot ( localPlayer,1 )
     triggerServerEvent("bate",getLocalPlayer()) 
     setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
 
if combobox == 1 then
 if materiales >= 750 then
     triggerServerEvent("martillo",getLocalPlayer()) 
     setElementData ( player, "Roleplay:Materiales", materiales - 750 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
 
 if combobox == 2 then
 if materiales >= 1250 then
  if xp_armero >= 1 then
     triggerServerEvent("9mm",getLocalPlayer()) 
    -- setElementData ( player, "Roleplay:Materiales", materiales - 1250 ) 
  else
    outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes experiencia suficiente para Craftear esto...",255,255,255,true)
  end
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
  if combobox == 3 then
 if materiales >= 1500 then
     triggerServerEvent("desert",getLocalPlayer()) 
     setElementData ( player, "Roleplay:Materiales", materiales - 1500 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
 
   if combobox == 4 then
 if materiales >= 5000 then
     triggerServerEvent("ak47",getLocalPlayer()) 
     setElementData ( player, "Roleplay:Materiales", materiales - 5000 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
 
 
    if combobox == 5 then
 if materiales >= 3500 then
     triggerServerEvent("uzi",getLocalPlayer()) 
     setElementData ( player, "Roleplay:Materiales", materiales - 3500 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
 
    if combobox == 6 then
 if materiales >= 3000 then
     triggerServerEvent("tec9",getLocalPlayer()) 
     setElementData ( player, "Roleplay:Materiales", materiales - 3000 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
 
    if combobox == 7 then
 if materiales >= 4500 then
     triggerServerEvent("mp5",getLocalPlayer()) 
     setElementData ( player, "materiales", materiales - 4500 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
 
    if combobox == 8 then
 if materiales >= 500 then
     triggerServerEvent("chaleco",getLocalPlayer()) 
     setElementData ( player, "materiales", materiales - 500 ) 
   else
     outputChatBox("#0059bf[Materiales] #ff3d3dNo tienes suficientes materiales",255,255,255,true)
   end
 end
end


function destruir()
  local combobox = guiComboBoxGetSelected(combobox)
  local player = localPlayer
  local materiales = getElementData(player, "Roleplay:Materiales") or 0
  local xp_armero = getElementData(player, "Roleplay:Experiencia_Armero") or 0

  if combobox >= 0 then
      local items = {
          [0] = {name = "bate", cost = 750, carga = 1, xp = 3, id = 5, exp = 0},
          [1] = {name = "martillo", cost = 750, carga = 1, xp = 4, id = 10, exp = 0},
          [2] = {name = "9mm", cost = 1250, carga = 17, xp = 7, id = 22, exp = 120},
          [3] = {name = "desert", cost = 1500, carga = 7, xp = 9, id = 24, exp = 120},
          [4] = {name = "ak47", cost = 5000, carga = 30, xp = 20, id = 30, exp = 700},
          [5] = {name = "uzi", cost = 3500, carga = 50, xp = 12, id = 28, exp = 200},
          [6] = {name = "tec9", cost = 3000, carga = 42, xp = 16, id = 32, exp = 500},
          [7] = {name = "mp5", cost = 4500, carga = 30, xp = 17, id = 29, exp = 700},
          [8] = {name = "chaleco", cost = 500, carga = 100, xp = 5, id = 100, exp = 120}
      }

      local selectedItem = items[combobox]

      if selectedItem then
          local itemName = selectedItem.name
          local itemCost = selectedItem.cost
          local carga = selectedItem.carga
          local xpRequired = selectedItem.xp
          local ItemID = selectedItem.id
          local ItemEXP = selectedItem.exp

     
            triggerServerEvent("destroyEvent", getLocalPlayer(), selectedItem)
           --   setElementData(player, "Roleplay:Materiales", materiales - itemCost)
             -- setElementData(player, "Roleplay:Experiencia_Armero", xp_armero + xpRequired)

             -- outputChatBox("#0059bf[Materiales] #b2b1b1Has destruido un(a) " .. itemName .. ".", 255, 255, 255, true)

      end
  end
end









------------------------------------------------------
--                                                   -
--                                                   -
-- ACA EMPIEZA LOS SITEMAS DE DAR VARIABLES          -
--                                                   -
--                                                   -
-- ACA EMPIEZA LOS SITEMAS DE DAR VARIABLES          -
--                                                   -
-----------------------------------------------------


function maths()
local player = localPlayer
local materiales =  getElementData ( player, "Roleplay:Materiales" ) or 0

outputChatBox("#0059bf[Materiales] #b2b1b1Actualmente tienes #00ff00"..materiales.."#b2b1b1 Materiales.",255,255,255,true)
 -- setElementData ( player, "materiales", 1000 )
end
addCommandHandler("materiales",maths)





function xp_armero()
  local player = localPlayer
  local materiales =  getElementData ( player, "Roleplay:Experiencia_Armero" ) or 0
  
  outputChatBox("#0059bf[Materiales] #b2b1b1Actualmente tienes #00ff00"..materiales.."#b2b1b1 XP.",255,255,255,true)
   -- setElementData ( player, "materiales", 1000 )
  end
  addCommandHandler("armxp",xp_armero)
  


addEvent("Materiales:Martillo",true) 
addEventHandler("Materiales:Martillo",localPlayer, 
function () 
local sound = playSound("data/martillo.mp3") 
setSoundVolume(sound, 1) 
end)


function qxp()
  local player = localPlayer
  local materiales =  getElementData ( player, "Roleplay:Experiencia_Armero" ) or 0
  
    setElementData ( player, "Roleplay:Experiencia_Armero", 10000 )
    outputChatBox("#0059bf[Materiales] #b2b1b1Se te añadieron #00ff00100.000 #b2b1b1materiales, ahora tienes #00ff00"..materiales.."#b2b1b1.",255,255,255,true)
  end
  addCommandHandler("qxp",qxp)