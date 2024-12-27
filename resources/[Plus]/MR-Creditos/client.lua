local creditosTabla = {
    {"Coche basico", "Super Vip",100},
    {"Casa basica+", "Super Vip", 150},
    {"MVP", "Super Vip",300},
    {"MVP+", "Super Vip",500},
    {"MVP++", "Super Vip",1000}
}
local CRE_Gui = nil -- Variable global para el control de la ventana

function PanelCreditos()
local screenW, screenH = guiGetScreenSize()
      if CRE_Gui and isElement(CRE_Gui) then -- Verifica si la ventana ya está abierta
        destroyElement(CRE_Gui) -- Destruye la ventana si ya está abierta
        showCursor(false)
        return
    end
    
        CRE_Gui = guiCreateWindow((screenW - 700) / 2, (screenH - 434) / 2, 700, 434, "Majestic Roleplay - Sistema de Creditos", false)
        guiWindowSetSizable(CRE_Gui, false)

        CRE_Label1 = guiCreateLabel(10, 23, 678, 42, "Bienvenid@ al sistema de creditos de Majestic Roleplay, Desde aqui podras adquirir diversos paquetes, los cuales podras usar en el servidor, ademas con cualquier compra estaras apoyando a el servidor asi contribuyendo a que este sigua activo.", false, CRE_Gui)
        local font0_cambria = guiCreateFont(":GTIhud/fonts/cambria.ttf", 10)
        guiSetFont(CRE_Label1, font0_cambria)
        guiLabelSetHorizontalAlign(CRE_Label1, "center", true)
    CRE_Gril = guiCreateGridList(219, 75, 469, 314, false, CRE_Gui)
    guiGridListAddColumn(CRE_Gril, "Nombre", 0.3)
    guiGridListAddColumn(CRE_Gril, "Detalles", 0.5)
    guiGridListAddColumn(CRE_Gril, "Creditos", 0.2)
    
    for _, credito in ipairs(creditosTabla) do
        local row = guiGridListAddRow(CRE_Gril)
        guiGridListSetItemText(CRE_Gril, row, 1, credito[1], false, false)
        guiGridListSetItemText(CRE_Gril, row, 2, credito[2] , false, false)
        guiGridListSetItemText(CRE_Gril, row, 3, tostring(credito[3]), false, false)

    end
    
        CRE_Label2 = guiCreateLabel(0, 75, 209, 41, "Creditos", false, CRE_Gui)
        guiSetFont(CRE_Label2, font0_cambria)
        guiLabelSetHorizontalAlign(CRE_Label2, "center", false)
        CRE_VIP = guiCreateButton(19, 126, 170, 34, "VIP\n100 Creditos", false, CRE_Gui)
        CRE_VIPPlus = guiCreateButton(21, 179, 170, 34, "VIP+\n150 Creditos", false, CRE_Gui)
        CRE_MVP = guiCreateButton(21, 228, 170, 34, "MVP\n300 Creditos", false, CRE_Gui)
        CRE_MVPPlus = guiCreateButton(20, 280, 170, 34, "MVP+\n500 Creditos", false, CRE_Gui)
        CRE_MPVPPlusPlus = guiCreateButton(20, 332, 170, 34, "MVP++\n1000 Creditos", false,CRE_Gui)
        CRE_BuyCre = guiCreateButton(20, 404, 171, 20, "Comprar Creditos", false, CRE_Gui)
        CRE_Label3 = guiCreateLabel(47, 388, 110, 16, "No tienes Creditos?", false, CRE_Gui)
        guiSetFont(CRE_Label3, "default-small")
        guiLabelSetHorizontalAlign(CRE_Label3, "center", false)
        CRE_Cerrar = guiCreateButton(514, 409, 171, 15, "Cerrar", false, CRE_Gui)
        CRE_BuyPack = guiCreateButton(219, 410, 171, 14, "Comprar paquete", false,CRE_Gui)   
        showCursor(true)
  
        addEventHandler("onClientGUIClick",CRE_VIP,BuyVip,false)
    end
addCommandHandler("creditos",PanelCreditos)


function BuyVip()
    local PCreditos = getElementData(localPlayer,"Roleplay:Creditos") or 0
    local VipActu = getElementData(localPlayer,"Roleplay:VIP") 
    if not VipActu then
    if PCreditos >= 100 then
        
         outputChatBox("#f8ff58[CREDITOS] #ffFFffHas comprado un #F8ed04VIP #ffFFffpor #0fff00100 #ffFFffcreditos!.",255,255,255,true)
         setElementData(localPlayer,"Roleplay:Creditos",PCreditos -250)
         setElementData(localPlayer,"Roleplay:VIP","VIP")
        
        else
        
         outputChatBox("#ff3d3d* No tienes suficientes creditos.", 255,255,255,true)
        end
    else
        
         outputChatBox("#ff3d3d* Ya tienes VIP, Espera que termine tu VIP para mejorarlo.", 255,255,255,true)
        
        end
end
