function Render.dxGridList( element, parent, offX, offY)
	
	local self = Cache[element]
	if self then

		if not self.isVisible then
			return
		end
 
		local x, y, x2, y2 = self.x, self.y, self.x, self.y
		if isElement(parent) then

			x, y = self.offsetX, self.offsetY
			--
			if x2 ~= (Cache[parent].x + x) or y2 ~= (Cache[parent].y + y) then
                x2, y2 = Cache[parent].x + x, Cache[parent].y + y
                self.x, self.y = x2, y2
            end
		end

		x, y = x + (offX or 0), y + (offY or 0)
		x2, y2 = x2 + (offX or 0), y2 + (offY or 0)

		if isCursorOver(x2, y2, self.w, self.h) then
			if getKeyState( 'mouse1' ) and not self.click then
				self.update = true
			end
			if mouseOnElement ~= element then
				mouseOnElement = element
			end
		else
			if mouseOnElement == element then
				mouseOnElement = nil
			end
		end

		dxDrawRectangle(x, y, self.w, self.h, self.colorbackground, false)

		--print(self.w, oX, restX)
		local scrollH_current = Cache[self.scrollH].current
		local scrollV_current = Cache[self.scrollV].current

		if self.scrollH_current ~= scrollH_current or self.scrollV_current ~= scrollV_current then
			self.update = true
		end

		local mw = Cache[self.scrollV].isVisible and 17*sh or 0
		local mh = Cache[self.scrollH].isVisible and self.fontH*2 or self.fontH

		if self.scrollV_current ~= scrollV_current or (isCursorOver(x2, y2+self.fontH, self.w-mw, self.h-mh) and (getKeyState( 'mouse1' ) and not self.click)) then
			self.update2 = true
		end

		if self.update or CLIENT_RESTORE then

			if isElement( self.rendertarget ) then
				--self.rendertarget:destroy()
			end

			if not isElement( self.rendertarget ) then
				self.rendertarget = DxRenderTarget( math.round(self.w-mw), self.fontH, true )
			end

			self.rendertarget:setAsTarget(true)
			dxSetBlendMode( 'modulate_add' )
 
				local oX = 10*sw
				local restX = 0
				if #self.columns > 0 then
					if not self.updatecolumn or self.scrollH_current ~= scrollH_current then

						for ic = 1, #self.columns do

							local c = self.columns[ic]
							local w = dxGetTextWidth(c[1], 1, self.font ) * (1+c[2])
							local alingX = c[3]

							--dxDrawRectangle( (0+oX)-(self.scrollX*Cache[self.scrollH].current), 0, w, self.fontH, tocolor(255,50 * (1+c[2]), 0) )
							--dxDrawText( c[1], (0*+oX)-(self.scrollX*Cache[self.scrollH].current), 0, ((0+oX)-(self.scrollX*Cache[self.scrollH].current))+w, 0+self.fontH, self.colortext, 1, self.font, alingX, 'center', true, false, false, false)
							dxDrawText2( c[1], (oX)-(self.scrollX*Cache[self.scrollH].current), 0, w, self.fontH, self.colortext, 1, self.font, alingX, 'center', true, false, false, false)

							oX = oX + w
							if oX > (self.w-mw) then
								restX = oX - (self.w-mw)
							end

						end

						self.scrollX = restX

						if restX > 0 then
							if not Cache[self.scrollH].isVisible then
								Cache[self.scrollH].isVisible = true
							end
						else
							if Cache[self.scrollH].isVisible then
								Cache[self.scrollH].isVisible = false
							end
						end

					end
				end

			dxSetBlendMode("blend")
			if isElement(parent) then
				dxSetRenderTarget(Cache[parent].rendertarget)
			else
				dxSetRenderTarget()
			end

			self.update = nil
			self.update2 = true
		end

		if isElement( self.rendertarget ) then
			dxSetBlendMode("add")
				dxDrawImage(math.round(x), math.round(y), math.round(self.w-mw), self.fontH, self.rendertarget, 0, 0, 0, tocolor( 255, 255, 255, 255 ), false)
			dxSetBlendMode("blend")
		end

		if self.update2 then

			if isElement( self.rendertarget2 ) then
				--self.rendertarget2:destroy()
			end

			if not isElement( self.rendertarget2 ) then
				self.rendertarget2 = DxRenderTarget( math.round(self.w-mw), math.round(self.h-mh), true )
			end

			self.rendertarget2:setAsTarget(true)
			dxSetBlendMode( 'modulate_add' )

				local notUpdate
				dxDrawLine( 5*sw, 1, (self.w-mw)-5*sw, 1, tocolor(35, 35, 45, 255), 1, false)
				
				local lY = 0
				if #self.items > 0 then

					local oY = 0
					local restY = 0
					for it = 1, #self.items do

						local item = self.items[it]
						local color = self.colorItems[it]
						local oX = 10*sw

						if self.selected == it then
							dxDrawRectangle( 0, oY-(self.scrollY*Cache[self.scrollV].current), (self.w-mw), self.fontH, self.colorselected, false )
						end

						if isCursorOver(x2, y2+self.fontH, math.round(self.w-mw), math.round(self.h-mh)) and (isCursorOver(x2, self.fontH+y2+oY-(self.scrollY*Cache[self.scrollV].current), (self.w-mw), self.fontH) and (getKeyState( 'mouse1' ) and not self.click)) then
							if self.selected == it then
								self.selected = -1
							else
								self.selected = it
							end
							notUpdate = true
						end

						for ic = 1, #self.columns do

							local c = self.columns[ic]
							local w = dxGetTextWidth(c[1], 1, self.font ) * (1+c[2])
							local alingX = c[3]


							--dxDrawText( tostring(item[ic] or ''), (0+oX)-(self.scrollX*Cache[self.scrollH].current), (lY+oY)-(self.scrollY*Cache[self.scrollV].current), ((0+oX)-(self.scrollX*Cache[self.scrollH].current))+w, lY+oY+self.fontH-(self.scrollY*Cache[self.scrollV].current), self.colortext, 1, self.font, alingX 'center', false, false, false, false)
							--dxDrawRectangle((oX), (lY+oY), w, self.fontH, tocolor(math.random(255),math.random(255),math.random(255)))
							dxDrawText2( tostring(item[ic] or ''), (oX)-(self.scrollX*Cache[self.scrollH].current), (lY+oY)-(self.scrollY*Cache[self.scrollV].current), w, self.fontH, tocolor(color[1], color[2], color[3]), 1, self.font, alingX, 'center', false, false, false, false)

							oX = oX + w
						end

						oY = oY + self.fontH
						if oY > self.h-mh-2.5*sh then
							restY = oY - (self.h-mh-2.5*sh)
						end

					end

					self.scrollY = restY

					if restY > 0 then
						if not Cache[self.scrollV].isVisible then
							Cache[self.scrollV].isVisible = true
						end
					else
						if Cache[self.scrollV].isVisible then
							Cache[self.scrollV].isVisible = false
						end
					end


				end

			dxSetBlendMode("blend")
			if isElement(parent) then
				dxSetRenderTarget(Cache[parent].rendertarget)
			else
				dxSetRenderTarget()
			end

			self.update2 = notUpdate
		end

		if isElement( self.rendertarget2 ) then
			dxSetBlendMode("add")
				dxDrawImage(math.round(x), math.round(y+self.fontH), math.round(self.w-mw), math.round(self.h-mh), self.rendertarget2, 0, 0, 0, tocolor( 255, 255, 255, 255 ), false)
			dxSetBlendMode("blend")
		end


		if isCursorOver(x2, y2, self.w, self.h) and getKeyState( 'mouse1' ) and not self.click then
			if not self.isDisabled then
				triggerEvent('onClick', element)
			end
		end

		self.click = getKeyState( 'mouse1' )
		self.arrow_u = getKeyState( 'arrow_u' )
		self.arrow_d = getKeyState( 'arrow_d' )

		self.scrollH_current = scrollH_current
		self.scrollV_current = scrollV_current

	end

end
