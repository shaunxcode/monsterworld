function love.load()
	require 'lib/MessageInABottle.lua'

	love.mouse.setVisible(false)
	
	love.graphics.setBackgroundColor(40, 40, 40)

	screen = {
		width = 800, 
		height = 600,
		scrollTolerance = 20,
		scrollSize = 10
	}
	
	scrollZones = {
		n = 0 + screen.scrollTolerance,
		s = screen.height - screen.scrollTolerance,
		e = screen.width - screen.scrollTolerance,
		w = 0 + screen.scrollTolerance
	}
	
	world = {
		x = 300,
		y = 400,
		dt = 0,
		lockMovement = true
	}

	camera = require "hump.camera"
	vector = require "hump.vector"
	
	cam = camera(vector(200, 200), 1)
	
	ocean = Ocean:new()


	tileSize = 32
	block_width = tileSize
	block_height = tileSize
	block_depth = block_height / 2
		
	grid_x = 0
	grid_y = 0
	grid_size = 20
	grid_levels = 7
	
	grid = {}
	for z = 0, grid_levels do
		grid[z] = {}
		for x = 1, grid_size do
			grid[z][x] = {}
			for y = 1, grid_size do
				grid[z][x][y] = -1
			end
		end
	end
		
	tilesetImage = love.graphics.newImage("img/tiles.png")
	tilesetImage:setFilter("nearest", "linear")


	tileQuads = {}
	-- grass
	tileQuads[0] = love.graphics.newQuad(0 * tileSize,  0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())
	--left ramp
	tileQuads[1] = love.graphics.newQuad(1 * tileSize,  0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())
	--right ramp
	tileQuads[2] = love.graphics.newQuad(2 * tileSize,  0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())

	tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, grid_size * grid_size)

	grid[0][20][1] = 1
	grid[0][19][2] = 0
	grid[0][19][3] = 0
	grid[0][20][2] = 1
	grid[1][19][1] = 1
	grid[2][18][1] = 1
	updateTileSetBatch()
	
	modal_message("Welcome to Summer Galaxies")
end

function modal_message(msg)
	world.lockMovement = true
	local bottle = StayBottle:new(nil, msg)
	bottle:setX(266)
	bottle:setVolume(1)
	bottle:setExitCallback(function() world.lockMovement = false end)
	ocean:addBottle(bottle)
end

function updateTileSetBatch() 
	tilesetBatch:clear()

	for z = 0, grid_levels do
		for x = 1, grid_size do
			for y = 1, grid_size do
				tile = grid[z][x + grid_x][y + grid_y]
				if tile > -1 then
					tilesetBatch:addq(
						tileQuads[tile], 
						(grid_x + ((y-x) * (block_width / 2))),
						(grid_y + ((x+y) * (block_depth / 2)) - (block_depth * (grid_size / 2))) - (block_depth * z))
				end
		   end
		end
	end
end

function love.focus(f)
	if not f then
		world.lockMovement = true
	else
		world.lockMovement = false
	end
end

function draw_world()
  	love.graphics.draw(tilesetBatch, 150, 150)	
end

function draw_hud()
	love.graphics.print(love.mouse.getX() .. " | " .. love.mouse.getY(), 100, 100)
	love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 5)
	ocean:draw()
	
end

function love.draw()
	cam:draw(draw_world)
	draw_hud()
end

function love.mousereleased(x, y, button)
	if button == 'l' then 
		cam.zoom = cam.zoom + 0.1
	else 
		cam.zoom = cam.zoom - 0.1
	end
end

function love.keypressed(k)
	if k == 'escape' then
		modal_message("This will be the game menu")
	end

   if k == 'lctrl' then
      debug.debug()
   end	
end

function love.update(dt)
	ocean:update(dt)
	
	local scrollX = 0
	local scrollY = 0
	local curY = love.mouse.getY()
	local curX = love.mouse.getX()
	
	if curY < scrollZones.n then 
		scrollY = -10
	end
	
	if curY > scrollZones.s then
		scrollY = 10
	end
	
	if curX > scrollZones.e then 
		scrollX = 10
	end
	
	if curX < scrollZones.w then 
		scrollX = -10
	end
	
	if not world.lockMovement then 
		cam:translate(vector(scrollX, scrollY))	
	end
end