--[[
This demo is nearly identical to the basic example, except that it has a basic
cursor rendering implementation.

To render the cursor, we split the text to the parts before and after the
cursor, using the LOVE built-in 'Font:getWidth()' method to measure how much
text is before the cursor. This doesn't take into account text wrapping or other
formatting.
]]
return function(textbox)
	local context = textbox.InputContext("Cursor Demo")
	local font = love.graphics.newFont(20)
	love.graphics.setFont(font)

	function love.draw()
		local x, y = 10, 10
		local min, max = context:getSelectionBounds()
		local beforeCursor = context.value:sub(1, context.cursor)
		local cursorOffset = font:getWidth(beforeCursor)

		if (max - min > 0) then
			local beforeMin = context.value:sub(1, min)
			local minPos = x + font:getWidth(beforeMin)
			local selectedWidth = font:getWidth(context:getSelectedText())

			love.graphics.setColor(64, 64, 200)
			love.graphics.rectangle("fill",
				minPos, y,
				selectedWidth, font:getHeight()
			)
		end

		love.graphics.setColor(255, 255, 255)
		love.graphics.print(context.value, x, y)
		love.graphics.line(x + cursorOffset, y, x + cursorOffset, y + font:getHeight())
	end

	function love.keypressed(key)
		if (key == "escape") then
			love.event.push("quit")
			return
		end

		context:keypressed(key)
	end

	function love.textinput(text)
		context:textinput(text)
	end
end