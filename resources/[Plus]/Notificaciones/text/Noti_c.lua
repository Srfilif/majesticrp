local srcW,srcH = guiGetScreenSize(  )
local sW,sH = srcW/960,srcH/600
local notificaciones = {}
local logs = {}

function setTextNoti(text, r,g,b)
	local color = '#'..string.format("%02X%02X%02X", (r or 255), (g or 255), (b or 255))
	notificaciones[#notificaciones + 1] = {color..text, 255}
	logs[#logs + 1] = text
end


addEventHandler( "onClientRender", getRootElement(),
	function()
		if #notificaciones == 0 then return end

		local Y = 0

		for i=8,1,-1 do
			local v = notificaciones[i] or false
			if v then
				--dxDrawText(v[1]:gsub('#%x%x%x%x%x%x',''), (sW*10)-1, (sH*381-Y)-1, (sW*192)+1, (sH*399)+1, tocolor(0, 0, 0, v[2]), 1, "default-bold", "left", "top", false, false, false, false, false)
				--dxDrawText(v[1]:gsub('#%x%x%x%x%x%x',''), (sW*10)+1, (sH*381-Y)+1, (sW*192)-1, (sH*399)-1, tocolor(0, 0, 0, v[2]), 1, "default-bold", "left", "top", false, false, false, false, false)
				dxDrawText(v[1], sW*10, sH*381-Y, sW*192, sH*399, tocolor(255, 255, 255, v[2]), 1, "default-bold", "left", "top", false, false, false, true, false)
				
				v[2] = v[2] - 0.65
				Y = Y + dxGetFontHeight( 1, "default-bold" ) + 0.4

				if v[2] <= 0 then
					table.remove(notificaciones, i)
				elseif v[2] > 0 and #notificaciones >= 8 and notificaciones[1][1] == v[1] then
					table.remove(notificaciones, 1)	
				end
			end
		end
	end
)


addEvent('addTextNoti',true)
addEventHandler('addTextNoti',localPlayer,
	function(text)
		notificaciones[#notificaciones + 1] = {text, 255}
		logs[#logs + 1] = text
	end
)

panelLogs = guiCreateWindow(0.35, 0.16, 0.35, 0.50, "Registro de Notificaciones", true)
guiWindowSetSizable(panelLogs, false)
guiSetVisible(panelLogs,false)
labelLogs = guiCreateLabel( 0.83, 0.005, 0.15, 0.05, 'Cerrar', true,panelLogs)
guiSetFont(labelLogs, "default-bold-small")
guiSetProperty(labelLogs, "ClippedByParent", "False")
guiSetProperty(labelLogs, "AlwaysOnTop", "True")
guiSetProperty(labelLogs, "RiseOnClick", "False")
memoLogs = guiCreateMemo(0.05, 0.09, 0.90, 0.85, "", true, panelLogs)    
guiMemoSetReadOnly( memoLogs, true )

addEventHandler( "onClientGUIClick", labelLogs,
	function(b,s)
		if b == 'left' and s == 'up' then
			guiSetVisible(panelLogs,false)
			showCursor(false)
		end
	end
,false)

addCommandHandler('verlogs',
	function()
		guiSetVisible(panelLogs,true)
		showCursor(true)
		guiSetText( memoLogs, '')
		for _,texto in ipairs(logs) do
			guiSetText( memoLogs, (guiGetText( memoLogs )..'INFO: '..texto:gsub('#%x%x%x%x%x%x','')) )
		end
	end
)

