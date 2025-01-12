sx, sy = guiGetScreenSize();

local zoom = 1
if sx < 1920 then
    zoom = math.min(1, 1920 / sx)
end

--/ Позиция маркеров 
mrkShop = {
    {234.9560546875, -48.8173828125, 1.4296875},
    {1326.62890625, 328.7353515625, 21.257175445557},
    {-1694.9986572266,951.60577392578,24.8},
}

for k,v in pairs(mrkShop) do
    local markerWtr = createMarker(v[1],v[2],v[3]-1, "cylinder", 1, 0, 172, 230, 0)
    createPickup ( v[1], v[2], v[3], 3, 1318, 1 )
    setElementData(markerWtr, "markerIdleShop", true)
    blipshop = createBlipAttachedTo ( markerWtr, 45 )
    setBlipVisibleDistance(blipshop, 250)
end

--/ Таблица мужских скинов и их стоимость 
local manSkins = { 
    [1]  = 2,  
    [2]  = 7,    
    [3]  = 9,  
    [4]  = 11,  
    [5]  = 12,   
    [6]  = 28,    
    [7]  = 29,    
    [8]  = 30,    
    [9]  = 31,
    [10] = 32,   
    [11] = 33,   
    [12] = 35,    
    [13] = 36,
    [14] = 37,   
    [15] = 38,  
    [16] = 39,  
    [17] = 40,    
    [18] = 41,  
    [19] = 43,  
    [20] = 44,   
    [21] = 45,    
    [22] = 46,    
    [23] = 47,  
    [24] = 53,
    [25] = 55,    
    [26] = 78,    
    [27] = 79,  
    [28] = 48,     
    [29] = 159,   
    [30] = 66,     
    [31] = 297,     
    [32] = 296,    
    [33] = 295,     
    [34] = 160,     
    [35] = 161,  
    [36] = 299, 
    [37] = 34,      
    [38] = 17,    
    [39] = 21,
    [40] = 14,      
    [41] = 25,    
    [42] = 308,    
    [43] = 57,  
}; 

local manSkinMoney = { 
    [1]  = 43000,
    [2]  = 45000,    
    [3]  = 55000,    
    [4]  = 62000,  
    [5]  = 63000,     
    [6]  = 78000,   
    [7]  = 99000,     
    [8]  = 101000,     
    [9]  = 120000,    
    [10] = 135000,     
    [11] = 199000,    
    [12] = 205000,     
    [13] = 320000,  
    [14] = 322000, 
    [15] = 400000,      
    [16] = 420000,  
    [17] = 420000,    
    [18] = 420000,  
    [19] = 420000,  
    [20] = 440000,   
    [21] = 440000,    
    [22] = 440000,    
    [23] = 440000, 
    [24]  = 489000,
    [25]  = 489000,    
    [26]  = 489000,    
    [27]  = 520000,  
    [28]  = 520000,     
    [29]  = 570000,   
    [30]  = 580200,     
    [31]  = 600000,     
    [32]  = 600000,    
    [33] = 600000,      
    [34] = 653000,     
    [35] = 665000,  
    [36] = 666000, 
    [37] = 680000,      
    [38] = 700000, 
    [39] = 32000,  
    [40] = 24000,   
    [41] = 12000,
    [42] = 53000,
    [43] = 65000,	
}; 

--/ Таблица женских скинов и их стоимость 
local womanSkins = { 
    [1]  = 57,  
    [2]  = 63,    
    [3]  = 64,   
    [4]  = 58,   
    [5]  = 59,    
    [6]  = 60,    
    [7]  = 61, 
    [8]  = 62, 
    [9]  = 75, 
    [10] = 73, 
    [11] = 80, 
    [12] = 13, 
    [13] = 298, 
    [14] = 257, 
    [15] = 54, 
    [16] = 56, 
    [17] = 10,
    [18] = 69,      
    [19] = 310, 
    [20] = 305, 
    [21] = 304,	
}; 

local womanSkinMoney = { 
    [1]  = 25000,
    [2]  = 45000,    
    [3]  = 60000,    
    [4]  = 60000,  
    [5]  = 66000,     
    [6]  = 76000,  
    [7]  = 79000,  
    [8]  = 87000, 
    [9]  = 90000, 
    [10] = 105000, 
    [11] = 110000, 
    [12] = 125000, 
    [13] = 145000, 
    [14] = 152000, 
    [15] = 200000, 
    [16] = 213000, 
    [17] = 220000,   
    [18] = 18888,     
    [19] = 220000, 
    [20] = 18888, 
    [21] = 90000,
    [22] = 145000,    	
}; 

local font_bold_define = dxCreateFont( "files/calibri_bold.ttf", 34/zoom );
--
local font_default_16 = dxCreateFont( "files/calibri_default.ttf", 16/zoom );
local font_default_14 = dxCreateFont( "files/calibri_default.ttf", 14/zoom );
local font_default_12 = dxCreateFont( "files/calibri_default.ttf", 12/zoom );
--
local font_bold_16 = dxCreateFont( "files/calibri_bold.ttf", 16/zoom );
local font_bold_14 = dxCreateFont( "files/calibri_bold.ttf", 14/zoom );
local font_bold_12 = dxCreateFont( "files/calibri_bold.ttf", 12/zoom );

local stateDrawShop = false;

local bArrowLeft = dxCreateTexture( "files/left.png", "argb", true, "clamp" )
local bArrowRight = dxCreateTexture( "files/right.png", "argb", true, "clamp" )

--// Таблица для превью 
local listMan = 1;
local indexManList = #manSkins;

local listWoman = 1;
local indexWomanList = #womanSkins;

local count = ""

local pedPossition = {224.37321472168,-6.0603280067444,1002.2109375, 180};
local pedPrewiev = createPed( manSkins[listMan], unpack( pedPossition ));
setElementFrozen( pedPrewiev, true ); 
setElementInterior( pedPrewiev, 5 )
setElementDimension( pedPrewiev, 1 )

addEventHandler("onClientRender", root, 
	function ()
		if stateDrawShop == true then
            dxDrawText("Tienda de Ropas", 35/zoom, 25/zoom, 250/zoom, 25/zoom, tocolor ( 255, 255, 255, 200 ), 1, font_bold_define, "left", "top", false, false, false, true);
            dxDrawText("GreenWood Roleplay", 37/zoom, 80/zoom, 250/zoom, 25/zoom, tocolor ( 255, 255, 255, 200 ), 1, font_default_14, "left", "top", false, false, false, true);
            dxDrawText("__________________________", 37/zoom, 90/zoom, 250/zoom, 25/zoom, tocolor ( 255, 255, 255, 50 ), 1, font_default_14, "left", "top", false, false, false, true);
            dxDrawText("Bakiyeniz : "..convertNumber(getPlayerMoney()).."$", 37/zoom, 114/zoom, 250/zoom, 25/zoom, tocolor ( 255, 255, 255, 200 ), 1, font_default_14, "left", "top", false, false, false, true);
		    --
            dxDrawArrow((sx-450/zoom)/2, sy-100/zoom, 50/zoom, 57/zoom, "<")
			
			local sex = getElementData ( localPlayer, "Cinsiyet") or "Erkek"
			sex = tostring( sex )
			if sex ~= "Erkek" and sex ~= "Kadın" then
			    sex = "Erkek"
			end
            if sex == "Erkek" then
		        dxDrawButton((sx-250/zoom)/2, sy-100/zoom, 250/zoom, 52/zoom, "ADQUIRIR POR\n"..convertNumber(manSkinMoney[listMan]).."$", font_default_14)
		    elseif sex == "Kadın" then
		    	dxDrawButton((sx-250/zoom)/2, sy-100/zoom, 250/zoom, 52/zoom, "ADQUIRIR POR\n"..convertNumber(womanSkinMoney[listWoman]).."$", font_default_14)
		    end
		    dxDrawArrow((sx+345/zoom)/2, sy-100/zoom, 50/zoom, 57/zoom, ">")
		    --
		    if dxDrawCursor(sx-125/zoom, 40/zoom, 70/zoom, 70/zoom) then
                dxDrawText("X", sx-125/zoom, 40/zoom, sx-125/zoom+70/zoom, 40/zoom+70/zoom, tocolor ( 90, 150, 255, 150 ), 1, font_bold_define, "center", "center", false, false, false, true);
		    else
		    	dxDrawText("X", sx-125/zoom, 40/zoom, sx-125/zoom+70/zoom, 40/zoom+70/zoom, tocolor ( 255, 255, 255, 100 ), 1, font_bold_define, "center", "center", false, false, false, true);
		    end 
		end
	end
)

addEventHandler("onClientClick", root, 
	function(button, state, x, y)
	    if stateDrawShop == true and (button == "left") and (state == "up") then
	    	--// Закрыть и выйти из магазина 
	    	if dxDrawCursor(sx-125/zoom, 40/zoom, 70/zoom, 70/zoom) then
	    		count = ""
	    		closeShop()
	    	--// SATIN AL скин и выйти из магазина 
	    	elseif dxDrawCursor((sx-250/zoom)/2, sy-100/zoom, 250/zoom, 52/zoom) then
	    		if getPlayerMoney() > manSkinMoney[listMan] then
	    		    local botPrewiev = getElementModel(pedPrewiev) 
	    		    local count = manSkinMoney[listMan]
                    triggerServerEvent( "takeMoneyForSkin", localPlayer, botPrewiev, count)
                    closeShop()
	    		else
	    			outputChatBox("Bakiyeniz yetersiz.!", 255, 51, 51, true )
	    			closeShop() 
	    		end
	    	--// { > } Листать на право  
	    	elseif dxDrawCursor((sx+345/zoom)/2, sy-100/zoom, 50/zoom, 57/zoom) then
			    local sex = getElementData ( localPlayer, "Cinsiyet") or "Erkek"
				sex = tostring( sex )
				if sex ~= "Erkek" and sex ~= "Kadın" then
				    sex = "Erkek"
				end
                
				--outputChatBox("твой пол "..tostring( sex ) )
			
	    		if sex == "Erkek" then 
	    			if ( listMan == indexManList ) then
                    	listMan = 1;
                	else
                   		listMan = listMan + 1;
                	end
               		setElementModel( pedPrewiev, manSkins[listMan] );
               		count = manSkinMoney[listMan] 
               	elseif sex == "Kadın" then 
                    if ( listWoman == indexWomanList ) then
                    	listWoman = 1;
                	else
                   		listWoman = listWoman + 1;
                	end
               		setElementModel( pedPrewiev, womanSkins[listWoman] );
               		count = womanSkinMoney[listWoman] 
               	end 
	    	--// { < } Листать на лево 
	    	elseif dxDrawCursor((sx-450/zoom)/2, sy-100/zoom, 50/zoom, 57/zoom) then
			    local sex = getElementData ( localPlayer, "Cinsiyet") or "Erkek"
				sex = tostring( sex )
				if sex ~= "Erkek" and sex ~= "Kadın" then
				    sex = "Erkek"
				end
				
				--outputChatBox("твой пол "..tostring( sex ) )
	    		if sex == "Erkek" then 
	    			if ( listMan == 1 ) then
                    	listMan = indexManList;
                	else
                    	listMan = listMan - 1;
                	end
                	setElementModel( pedPrewiev, manSkins[listMan] );
                	count = manSkinMoney[listMan]
                elseif sex == "Kadın" then
                	if ( listWoman == 1 ) then
                    	listWoman = indexWomanList;
                	else
                    	listWoman = listWoman - 1;
                	end
                	setElementModel( pedPrewiev, womanSkins[listWoman] );
                	count = womanSkinMoney[listWoman]
                end 
	    	end 
	    end
	end
)

function closeShop()
	stateDrawShop = false
    showCursor(false) 
	fadeCamera( false, 2 );
	setTimer (function ()
	    fadeCamera( true, 1 );
	    setElementInterior( localPlayer, 0 )
        setElementDimension( localPlayer, 0 )
        startVignette(false)
        showChat(true)
        setCameraTarget(localPlayer)
        setElementFrozen(localPlayer, false)
        setElementData(localPlayer, "visibleInterface", true) 
	end, 2500, 1)  
end

addEventHandler("onClientMarkerHit", root, 
	function(player)
	    if getElementData(source, "markerIdleShop") == true then 
	        if player == localPlayer then
			    local sex = getElementData ( localPlayer, "Cinsiyet") or "Erkek"
				sex = tostring( sex )
				if sex ~= "Erkek" and sex ~= "Kadın" then
			        sex = "Erkek"
			    end
	        	if sex == "Erkek" then 
	        		setElementModel(pedPrewiev, manSkins[listMan])
	        	elseif sex == "Kadın" then
	        	    setElementModel(pedPrewiev, womanSkins[listWoman]) 
	        	end
	        	setElementFrozen(localPlayer, true)
	        	fadeCamera( false, 2 );
                setElementData(localPlayer, "visibleInterface", false)
	        	setTimer (function ()
	        		fadeCamera( true, 1 );
                    setCameraMatrix ( 226.37321472168,-10.0603280067444,1002.2109375, 176.92398071289,90.338027954102, 1002.1946875 );
                    setElementInterior( localPlayer, 5 )
                    setElementDimension( localPlayer, 1 )
                    startVignette(true)
                    stateDrawShop = true
                    showCursor(true) 
                    showChat(false)
                    setElementFrozen(localPlayer, true)
                end, 2500, 1)
            end
		end
	end
)

--// Шейдер 
local screenWidth, screenHeight = guiGetScreenSize()
local screenSource	= dxCreateScreenSource(screenWidth, screenHeight)
local darkness		= 0.5
local radius		= 10

function startVignette(state)
	if state == true then 
		vignetteShader = dxCreateShader("files/shader.fx")
		if not(vignetteShader) then
			return
		end
	    addEventHandler("onClientPreRender", root, renderVignette)
	else
		removeEventHandler("onClientPreRender", root, renderVignette)
    end
end

function renderVignette()
	dxUpdateScreenSource(screenSource)
	if(vignetteShader) then
		dxSetShaderValue(vignetteShader, "ScreenSource", screenSource)
		dxSetShaderValue(vignetteShader, "radius", radius)
		dxSetShaderValue(vignetteShader, "darkness", darkness)
		dxDrawImage(0, 0, screenWidth, screenHeight, vignetteShader)
	end
end

--// Полезные функции 
function convertNumber(number)  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')    
		if (k == 0) then      
			break   
		end  
	end  
	return formatted
end

function dxDrawButton(x, y, w, h, text, font)
	if dxDrawCursor(x, y, w, h) then
	    dxDrawRectangle(x, y, w, h, tocolor(90, 150, 255, 180), false) 
	    dxDrawShadowText(text, x, y, x+w, y+h, tocolor ( 255, 255, 255, 255 ), 1, font, "center", "center", false, false, false, true);
	else
		dxDrawRectangle(x, y, w, h, tocolor(90, 150, 255, 150), false) 
		dxDrawShadowText(text, x, y, x+w, y+h, tocolor ( 255, 255, 255, 235 ), 1, font, "center", "center", false, false, false, true);
	end 
end

function dxDrawCursor(x,y,w,h)
	if isCursorShowing() then
		local mx,my = getCursorPosition() 
		local cursorx,cursory = mx*sx, my*sy
		if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
			return true
		end
	end
    return false
end

function dxDrawShadowText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCode )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true )
    dxDrawText ( text:gsub( "#%x%x%x%x%x%x", "" ), x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 15 ), scale, font, alignX, alignY, clip, wordBreak, false, true)
    dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true )
end

function dxDrawArrow(x, y, w, h, type)
	if type == "<" then
		if dxDrawCursor(x, y, w, h) then
	    	dxDrawImage(x-2/zoom, y-2/zoom, w+4/zoom, h+4/zoom, bArrowLeft, 0, 0, 0, tocolor(255, 255, 255, 235), false) 
		else
            dxDrawImage(x, y, w, h, bArrowLeft, 0, 0, 0, tocolor(255, 255, 255, 225), false) 
		end
	elseif type == ">" then 
		if dxDrawCursor(x, y, w, h) then
	    	dxDrawImage(x-2/zoom, y-2/zoom, w+4/zoom, h+4/zoom, bArrowRight, 0, 0, 0, tocolor(255, 255, 255, 235), false) 
		else
            dxDrawImage(x, y, w, h, bArrowRight, 0, 0, 0, tocolor(255, 255, 255, 225), false) 
		end
	end
end



-- SparroW MTA : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İnstagram : https://www.instagram.com/sparrowmta/
-- Discord : https://discord.gg/DzgEcvy