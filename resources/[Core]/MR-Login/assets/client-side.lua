local screen = {guiGetScreenSize()}
local open = false

local login_edit = guiCreateEdit(0, 0, 0, 0, "", false)
guiEditSetMaxLength(login_edit, 18)
guiSetVisible(login_edit, false)
local login_focus = false

local password_edit = guiCreateEdit(0, 0, 0, 0, "", false)
guiEditSetMaxLength(password_edit, 18)
guiSetVisible(password_edit, false)
local password_focus = false

local login_edit_2 = guiCreateEdit(0, 0, 0, 0, "", false)
guiEditSetMaxLength(login_edit_2, 18)
guiSetVisible(login_edit_2, false)
local login_focus_2 = false

local password_edit_2 = guiCreateEdit(0, 0, 0, 0, "", false)
guiEditSetMaxLength(password_edit_2, 18)
guiSetVisible(password_edit_2, false)
local password_focus_2 = false

local re_password_edit = guiCreateEdit(0, 0, 0, 0, "", false)
guiEditSetMaxLength(re_password_edit, 18)
guiSetVisible(re_password_edit, false)
local re_password_focus = false

local atual_infos = 1
local size_infos = 0
local fade = {false, 255, false}
local remember_me_color = {149, 165, 165}
local _remember_me_color = remember_me_color
local changing = {remember_me_color, remember_me_color}
local remember_pos = {
    atual = 0,
    next = 0
}
local remember_me = false

local raw = string.format([[
    <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <mask id='path_inside' fill='#FFFFFF' >
            <rect width='%s' height='%s' rx='%s' />
        </mask>
        <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' mask='url(#path_inside)'/>
    </svg>
]], 812, 8, 812, 8, 4, 812, 8, 4)
local infos_bar = svgCreate(812, 8, raw)
local tab = 1

local sound = false

function renderPanel()
    if open then
        cx, cy = 0, 0
        if isCursorShowing() then
            cx, cy = getCursorPosition()
            cx, cy = cx * screen[1], cy * screen[2]
        end
        exports["blur"]:dxDrawBluredRectangle(0, 0, screen[1], screen[2])
        -- dxDrawImage(0, 0, screen[1], screen[2], "assets/images/background.png", 0, 0, 0, tocolor(255, 255, 255))
        drawRect("rect1", screen[1] - 812 - 94, (screen[2] - 430) / 2, 812, 430, 12, tocolor(36, 36, 36))
        dxDrawImage(screen[1] - 812 - 94, (screen[2] - 430) / 2, 812, 430, "assets/images/"..settings["Infos"][atual_infos].icon..".png", 0, 0, 0, tocolor(255, 255, 255, fade[2]))
        drawRect("rect2", screen[1] - 812 - 94, (screen[2] - 430) / 2 + 430 + 3, 812, 8, 4, tocolor(36, 36, 36))
        dxDrawImageSection(screen[1] - 812 - 94, (screen[2] - 430) / 2 + 430 + 3, size_infos, 8, 0, 0, size_infos, 8, infos_bar, 0, 0, 0, tocolor(255, 255, 255))
        dxDrawText(settings["Infos"][atual_infos].title, screen[1] - 812 - 94 + 13, (screen[2] - 430) / 2 + 325, 275, 29, tocolor(248, 239, 239, fade[2]), 1, createFont("Roboto-Black", 21), "left", "center")
        dxDrawText(settings["Infos"][atual_infos].text, screen[1] - 812 - 94 + 13, (screen[2] - 430) / 2 + 368, 812 - 13 - 13, 29, tocolor(248, 239, 239, fade[2]), 1, createFont("Roboto-Regular", 8), "left", "top", false, true)
        drawRect("rect3", 77, (screen[2] - 369) / 2, 355, 369, 12, tocolor(36, 36, 36))
        dxDrawImage(77 + 134, (screen[2] - 369) / 2, 86, 86, "assets/images/logo.png", 0, 0, 0, tocolor(255, 255, 255))
        
        if tab == 1 then
            drawRect("rect4", 77 + 56, (screen[2] - 369) / 2 + 96.5, 241, 46, 12, tocolor(51, 51, 51))
            dxDrawImage(77 + 56 + 12, (screen[2] - 369) / 2 + 96 + 12, 20, 20, "assets/images/user.png", 0, 0, 0, tocolor(255, 255, 255))
            dxDrawText((login_focus or #guiGetText(login_edit) > 0) and guiGetText(login_edit) or "Usuario", 77 + 56 + 12 + 20 + 8, (screen[2] - 369) / 2 + 96 + 16, 110, 13, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 12), "left", "center")
            
            drawRect("rect5", 77 + 56, (screen[2] - 369) / 2 + 151.5, 241, 46, 12, tocolor(51, 51, 51))
            dxDrawImage(77 + 56 + 12, (screen[2] - 369) / 2 + 151 + 12, 20, 20, "assets/images/password.png", 0, 0, 0, tocolor(255, 255, 255))
            dxDrawText((password_focus or #guiGetText(password_edit) > 0) and string.rep("*", #guiGetText(password_edit)) or "Contaseña", 77 + 56 + 12 + 20 + 8, (screen[2] - 369) / 2 + 151 + 16, 110, 13, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 12), "left", "center")
            
            drawRect("rect6", 77 + 56, (screen[2] - 369) / 2 + 209.5, 36, 18, 9, tocolor(unpack(changing[1])))
            drawRect("rect7", 77 + 56 + remember_pos.atual, (screen[2] - 369) / 2 + 209.5, 18, 18, 10, tocolor(236, 240, 240))
            dxDrawText("Recordar contraseña", 77 + 56 + 36 + 11, (screen[2] - 369) / 2 + 211.5, 110, 13, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 10), "left", "center")
            
            drawRect("rect8", 77 + 56, (screen[2] - 369) / 2 + 239.5, 241, 33, 12, tocolor(0, 255, 60))
            dxDrawText("LOGIN", 77 + 56, (screen[2] - 369) / 2 + 239.5, 241, 33, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 11), "center", "center")
            
            dxDrawText("No tienes cuenta?\n#56689ARegistrate#ffffff Aca", 77 + 56, (screen[2] - 369) / 2 + 276.5, 241, 33, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 8), "left", "top", false, false, false, true)
        elseif tab == 2 then
            drawRect("rect9", 77 + 56, (screen[2] - 369) / 2 + 96.5, 241, 46, 12, tocolor(51, 51, 51))
            dxDrawImage(77 + 56 + 12, (screen[2] - 369) / 2 + 96 + 12, 20, 20, "assets/images/user.png", 0, 0, 0, tocolor(255, 255, 255))
            dxDrawText((login_focus_2 or #guiGetText(login_edit_2) > 0) and guiGetText(login_edit_2) or "Usuario", 77 + 56 + 12 + 20 + 8, (screen[2] - 369) / 2 + 96 + 16, 110, 13, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 12), "left", "center")
            
            drawRect("rect10", 77 + 56, (screen[2] - 369) / 2 + 151.5, 241, 46, 12, tocolor(51, 51, 51))
            dxDrawImage(77 + 56 + 12, (screen[2] - 369) / 2 + 151 + 12, 20, 20, "assets/images/password.png", 0, 0, 0, tocolor(255, 255, 255))
            dxDrawText((password_focus_2 or #guiGetText(password_edit_2) > 0) and string.rep("*", #guiGetText(password_edit_2)) or "Contraseña", 77 + 56 + 12 + 20 + 8, (screen[2] - 369) / 2 + 151 + 16, 110, 13, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 12), "left", "center")

            drawRect("rect11", 77 + 56, (screen[2] - 369) / 2 + 205.5, 241, 46, 12, tocolor(51, 51, 51))
            dxDrawImage(77 + 56 + 12, (screen[2] - 369) / 2 + 205 + 12, 20, 20, "assets/images/password.png", 0, 0, 0, tocolor(255, 255, 255))
            dxDrawText((re_password_focus_2 or #guiGetText(re_password_edit) > 0) and string.rep("*", #guiGetText(re_password_edit)) or "Contraseña", 77 + 56 + 12 + 20 + 8, (screen[2] - 369) / 2 + 205 + 16, 110, 13, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 12), "left", "center")
            
            drawRect("rect12", 77 + 56, (screen[2] - 369) / 2 + 260.5, 241, 33, 12, tocolor(0, 255, 60))
            dxDrawText("REGISTRAR", 77 + 56, (screen[2] - 369) / 2 + 260.5, 241, 33, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 11), "center", "center")
            
            dxDrawText("Ya tienes cuenta?\n#56689AIngresa#ffffff Aca", 77 + 56, (screen[2] - 369) / 2 + 297, 241, 33, tocolor(255, 255, 255), 1, createFont("Roboto-Black", 8), "left", "top", false, false, false, true)
        end

        if remember_me_color[1] ~= _remember_me_color[1] or remember_me_color[2] ~= _remember_me_color[2] or remember_me_color[3] ~= _remember_me_color[3] then
            changing = {_remember_me_color, remember_me_color}
            _remember_me_color = remember_me_color
        end

        local r, g, b = interpolateBetween(changing[1][1], changing[1][2], changing[1][3], changing[2][1], changing[2][2], changing[2][3], (getTickCount() - (remember_tick or 0)) / 500, "Linear")
        local pos = interpolateBetween(remember_pos.atual, 0, 0, remember_pos.next, 0, 0, (getTickCount() - (remember_tick or 0)) / 500, "Linear")
        remember_pos.atual = pos
        changing[1] = {r, g, b}
        
        if not fade[1] then
            if size_infos >= 812 then
                size_infos = 0
                fade[1] = true
            else
                size_infos = size_infos + 0.8
            end
        else
            if fade[2] > 0 and not fade[3] then
                fade[2] = math.max(fade[2] - 8, 0)
                if fade[2] == 0 then
                    fade[3] = true
                    atual_infos = atual_infos + 1
                    if atual_infos > #settings["Infos"] then
                        atual_infos = 1
                    end
                end
            end
            if fade[3] then
                fade[2] = math.min(fade[2] + 8, 255)
                if fade[2] == 255 then
                    fade[1] = false
                    fade[3] = false
                end
            end
        end
    end
end
setTimer(renderPanel, 0, 0)

addEventHandler("onClientClick", root, function(button, state)
    if open then
        if button == "left" and state == "up" then
            if tab == 1 then
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 96, 241, 46) then
                    login_focus = true
                    guiFocus(login_edit)
                else
                    login_focus = false
                end
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 151, 241, 46) then
                    password_focus = true
                    guiFocus(password_edit)
                else
                    password_focus = false
                end
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 209.5, 36, 18) then
                    remember_me = not remember_me
                    remember_tick = getTickCount()
                    if remember_me then
                        remember_me_color = {48, 214, 55}
                        remember_pos.next = 18
                    else
                        remember_me_color = {149, 165, 165}
                        remember_pos.next = 0
                    end
                end
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 293, 40, 12) then
                    tab = 2
                end

                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 239.5, 241, 33) then
                    if  guiGetText(login_edit) == "" or guiGetText(password_edit) == "" then
                        outputChatBox("Por favor, completa todos los campos.", 255, 0, 0)
                        exports["MR-Notify"]:addNotification("Por favor rellena todos los campos.", "error")
                
                        return
                    end
                    triggerServerEvent("onPlayerAttemptLogin", localPlayer, guiGetText(login_edit), guiGetText(password_edit))

                end
            elseif tab == 2 then
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 96, 241, 46) then
                    login_focus_2 = true
                    guiFocus(login_edit_2)
                else
                    login_focus_2 = false
                end
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 151, 241, 46) then
                    password_focus_2 = true
                    guiFocus(password_edit_2)
                else
                    password_focus_2 = false
                end
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 205, 241, 46) then
                    re_password_focus_2 = true
                    guiFocus(re_password_edit)
                else
                    re_password_focus_2 = false
                end
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 313, 31, 12) then
                    tab = 1
                end
                if isCursorInPosition(77 + 56, (screen[2] - 369) / 2 + 260.5, 241, 33) then
                    if guiGetText(login_edit_2) == "" or guiGetText(password_edit_2) == "" or guiGetText(re_password_edit) == "" then
                        outputChatBox("Por favor, completa todos los campos.", 255, 0, 0)
                    exports["MR-Notify"]:addNotification("Por favor rellena todos los campos.", "info")
            
            
                        return
                    end
            
                    if guiGetText(password_edit_2) ~=  guiGetText(re_password_edit) then
                        outputChatBox("Las contraseñas no coinciden.", 255, 0, 0)
                        exports["MR-Notify"]:addNotification("Las contraseñas no coinciden.", "error")
            
                        return
                    end
                    triggerServerEvent("onPlayerRegister", localPlayer, guiGetText(login_edit_2), guiGetText(password_edit_2), guiGetText(re_password_edit))
                end
            end
        end
    end
end)

addEventHandler("onClientKey", root, function(button, state)
    if login_focus or password_focus or login_focus_2 or password_focus_2 or re_password_focus then
        cancelEvent()
    end
end)

addEvent("[NT]Login:saveXml", true)
addEventHandler("[NT]Login:saveXml", root, function(account, password)
    local xml_save_log_File = xmlLoadFile ("assets/xml/account.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile ("assets/xml/account.xml", "login")
    end
    if (account ~= "") then
        local usernameNode = xmlFindChild(xml_save_log_File, "account", 0)
        if not usernameNode then
            usernameNode = xmlCreateChild(xml_save_log_File, "account")
        end
        local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
        if not passwordNode then
            passwordNode = xmlCreateChild(xml_save_log_File, "password")
        end
        local remember = xmlFindChild(xml_save_log_File, "remember", 0)
        if not remember then
            remember = xmlCreateChild(xml_save_log_File, "remember")
        end
        xmlNodeSetValue(usernameNode, tostring(account))
        xmlNodeSetValue(passwordNode, tostring(password))
        xmlNodeSetValue(remember, tostring(remember_me))
    end
    xmlSaveFile(xml_save_log_File)
    xmlUnloadFile(xml_save_log_File)
end)

function loadXml()
    local xml_save_log_File = xmlLoadFile ("assets/xml/account.xml")
    if not xml_save_log_File then
        xml_save_log_File = xmlCreateFile ("assets/xml/account.xml", "login")
    end
    local usernameNode = xmlFindChild(xml_save_log_File, "account", 0)
    local passwordNode = xmlFindChild(xml_save_log_File, "password", 0)
    local remember = xmlFindChild(xml_save_log_File, "remember", 0)
    if usernameNode and passwordNode and remember then
        return {xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode), xmlNodeGetValue(remember)}
    else
        return false
    end
    xmlUnloadFile(xml_save_log_File)
end

function openLogin()
    if not open then
        -- setTimer(function()
            sound = playSound(settings["Main"]["music"], true)
            setSoundVolume(sound, settings["Main"]["musicVolume"])
            setElementFrozen(localPlayer, true)
            open = true
            showCursor(true)
            if settings["Main"]["showChat"] then
                showChat(false)
            end
            fadeCamera(true, 0)
        -- end, 300, 1)
        if loadXml()[3] == "true" then
            remember_me = true
            guiSetText(login_edit, loadXml()[1])
            guiSetText(password_edit, loadXml()[2])
            if #guiGetText(login_edit) > 0 then
                guiEditSetCaratIndex(login_edit, #guiGetText(login_edit))
            end
            if #guiGetText(password_edit) > 0 then
                guiEditSetCaratIndex(password_edit, #guiGetText(password_edit))
            end
            if remember_me then
                remember_me_color = {48, 214, 55}
                remember_pos.next = 18
            end
        end
    end
end
addEvent("[NT]Login:openLogin", true)
addEventHandler("[NT]Login:openLogin", root, openLogin)

addEventHandler("onClientResourceStart", resourceRoot, function()
    setTimer(function()
        openLogin()
    end, 500, 1)
end)

function closeLogin()
    if open then
        if isElement(sound) then
            stopSound(sound)
            sound = false
        end
        open = false
        guiSetText(login_edit, "")
        guiSetText(password_edit, "")
        guiSetText(re_password_edit, "")
        showCursor(false)
        if settings["Main"]["showChat"] then
            showChat(true)
        end
    end
end
addEvent("[NT]Login:closeLogin", true)
addEventHandler("[NT]Login:closeLogin", root, closeLogin)

addEventHandler("onClientResourceStop", resourceRoot, function()
    if settings["Main"]["showChat"] then
        showChat(true)
    end
end)

local fonts = {
    ["Roboto-Black"] = "assets/fonts/Roboto-Black.ttf",
    ["Roboto-Regular"] = "assets/fonts/Roboto-Regular.ttf"
}
local fonts_created = {}

function createFont(font, size)
    local font_loader = "default"
    if fonts[font] then
        if not fonts_created[font] then
            fonts_created[font] = {}
        end
        if not fonts_created[font][size] then
            font_loader = dxCreateFont(fonts[font], size, false)
            fonts_created[font][size] = font_loader
        else
            font_loader = fonts_created[font][size]
        end
    end
    return font_loader
end

local buttons = {}

function drawRect(index, x, y, width, height, radius, color, postGUI)
    colorStroke = tostring(colorStroke)
    sizeStroke = tostring(sizeStroke)

    if (not buttons[index]) then
        local raw = string.format([[
            <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
                <mask id='path_inside' fill='#FFFFFF' >
                    <rect width='%s' height='%s' rx='%s' />
                </mask>
                <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' mask='url(#path_inside)'/>
            </svg>
        ]], width, height, width, height, radius, width, height, radius)
        buttons[index] = svgCreate(width, height, raw)
    end
    if (buttons[index]) then
        dxDrawImage(x, y, width, height, buttons[index], 0, 0, 0, color, postGUI)
    end
end

local _dxDrawText = dxDrawText

function dxDrawText(text, x, y, w, h, ...)
    _dxDrawText(text, x, y, x + w, y + h, ...)
end

function isCursorInPosition(x, y, w, h)
    if x and y and w and h then
        if isCursorShowing() then
            if cx >= x and cx <= (x + w) and cy >= y and cy <= (y + h) then
                return true
            end
        end
    end
    return false
end

local camPos = {}
local camID = 1
local lastCamTick = 0
camPos[1] = {} 
camPos[1]["start"] = {989.42987060547, -1145.4051513672, 50.296298980713, 990.40814208984, -1145.4158935547, 50.089214324951}
camPos[1]["end"] = {1289.6910400391, -1145.3928222656, 60.02209854126, 1290.6010742188, -1145.3928222656, 59.607643127441}
camPos[1]["speed"] = 70000
camPos[1]["type"] = "Linear"


function updateCamPosition ()
	if camPos[camID] and open then
		local cTick = getTickCount ()
		local delay = cTick - lastCamTick
		local duration = camPos[camID]["speed"]
		local easing = camPos[camID]["type"]
		if duration and easing then
			local progress = delay/duration
			if progress < 1 then
				local cx,cy,cz = interpolateBetween (
					camPos[camID]["start"][1],camPos[camID]["start"][2],camPos[camID]["start"][3],
					camPos[camID]["end"][1],camPos[camID]["end"][2],camPos[camID]["end"][3],
					progress,easing
				)
				local tx,ty,tz = interpolateBetween (
					camPos[camID]["start"][4],camPos[camID]["start"][5],camPos[camID]["start"][6],
					camPos[camID]["end"][4],camPos[camID]["end"][5],camPos[camID]["end"][6],
					progress,easing
				)
				
				setCameraMatrix (cx,cy,cz,tx,ty,tz)
			else
				local nextID = false
				
				while nextID == false do
					local id = camID + 1
					if id ~= camID then
						nextID = id
					end
					if id > # camPos then 
						nextID = 1
					end
				end
				
				camFading = 2
				lastCamTick = getTickCount ()
				camID = nextID
				
				setCameraMatrix (camPos[camID]["start"][1],camPos[camID]["start"][2],camPos[camID]["start"][3],camPos[camID]["start"][4],camPos[camID]["start"][5],camPos[camID]["start"][6])
			end
		end
	end
end
setTimer(updateCamPosition, 0, 0)




   --NÃO RETIRAR CREDITOS!  NÃO RETIRAR CREDITOS!  NÃO RETIRAR CREDITOS!   
  --              https://discord.gg/KXV2GHtJtg                              


--PROCURANDO SCRIPTS, MAPAS, MODELAGENS EXCLUSIVOS?
--NOSSA COMUNIDADE ESTÁ SEMPRE A ATIVA SOLTANDO VARIOS MODS DE GRAÇA!

--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO
--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO
--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO
--MAIS DE 300 MODS GRÁTIS COM DOWNLOAD DIRETO

--LINK DE CONVITE PERMANENTE:

--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
--https://discord.gg/KXV2GHtJtg   
