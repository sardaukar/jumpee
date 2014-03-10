PlayState = {}

--New
function PlayState:new()
	local gs = {}

	gs = setmetatable(gs, self)
	self.__index = self
	_gs = gs

	return gs
end

--Load
function PlayState:load()
	background_color = {39, 77, 126}

  looking = 'right'

  initialize_floor()
  initialize_player()
  initialize_hamster()

  jump_height = 600
  gravity = 400
  score = 0
  time = 5

	font = love.graphics.newFont('font/PressStart2P.ttf', 18)
  love.graphics.setFont(font)

  local img = love.graphics.newImage('gfx/boom.png')
  anim = newAnimation(img, 96, 96, 0.1, 0)
  anim:setMode('once')
end

--Close
function PlayState:close()
end

--Enable
function PlayState:enable()
end

--Disable
function PlayState:disable()
end

--Update
function PlayState:update(dt)
	time = time - dt

  if time <= 0 then
    --
  end

  if check_collision() then
    score = score + 1
    time = 5
    anim.x, anim.y = hamster.x, hamster.y
    anim:reset()
    anim:play()
    hamster.x, hamster.y = random_hamster_position()
  end

  anim:update(dt)

  if love.keyboard.isDown('left') then
    if looking == 'right' then
      looking = 'left'
      player.x = player.x + player.width
    else
      player.x = player.x - 2
    end
  end

  if love.keyboard.isDown('right') then
    if looking == 'left' then
      looking = 'right'
      player.x = player.x - player.width
    else
      player.x = player.x + 2
    end
  end

  if love.keyboard.isDown(' ') then
    if player.y_vel == 0 then
      player.y_vel = jump_height
    end
  end

  if player.x <= 0 + player.width then
    player.x = player.width
  end

  if player.x >= screen_width - player.width then
    player.x = screen_width - player.width
  end

  if player.y_vel ~= 0 then
    player.y = player.y - player.y_vel * dt
    player.y_vel = player.y_vel - gravity * dt
    if player.y >= floor_y - player.height then
      player.y_vel = 0
      player.y = floor_y - player.height
    end
  end
end

--Draw
function PlayState:draw()
	set_background()
  draw_floor()

  draw_player()
  draw_hamster()

  anim:draw(anim.x, anim.y)

  love.graphics.print("Score: " .. score, 100, 50)
  love.graphics.print("Time : " .. math.floor(time),  100, 90)

end

--KeyPressed
function PlayState:keypressed(key, unicode)
	if key == 'q' or key == 'escape' then
    love.event.quit()
  elseif key == 'p' then
  	enableState('pause')
  	disableState('play')
  end
end

--KeyRelease
function PlayState:keyrelease(key, unicode)
end

--MousePressed
function PlayState:mousepressed(x, y, button)
end

--MouseReleased
function PlayState:mousereleased(x, y, button)
end

function check_collision()
  return  player.x < hamster.x + hamster.width and
          hamster.x < player.x + player.width and
          player.y < hamster.y + hamster.height and
          hamster.y < player.y + player.height
end

function initialize_floor()
  floor_y = 550
  floor_color = {240, 125, 64}
end

function initialize_player()
  player = {
    height = 54,
    width = 26,
    x = screen_width / 2,
    y = floor_y - 54,
    y_vel = 0,
    image = love.graphics.newImage('gfx/hero.png')
  }
end

function random_hamster_position()
  baseline_y = floor_y - player.height

  x_pos = math.random(hamster.width, screen_width - hamster.width)
  y_pos = math.random(baseline_y - 100, baseline_y - 300)

  return x_pos, y_pos
end

function initialize_hamster()
  hamster = {
    height = 82,
    width = 82,
    x = 0,
    y = 0,
    image = love.graphics.newImage('gfx/hamster.png')
  }

  hamster.x, hamster.y = random_hamster_position()
end

function set_background()
  love.graphics.setBackgroundColor(background_color)
end

function draw_floor()
  love.graphics.setColor(floor_color)
  love.graphics.rectangle('fill', 0, floor_y, screen_width, (screen_height - floor_y) )
end

function draw_hamster()
  love.graphics.draw(hamster.image, hamster.x, hamster.y, 0, .5,.5)
end

function draw_player()
  sx = 1
  if looking == 'left' then
    sx = -1
  end

  love.graphics.draw(player.image, player.x, player.y, 0, sx, 1)
end

function draw_gameover_msg()
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, screen_width, screen_height)

  love.graphics.print("You dead, brah! Press SPACE to try again!", 10, 300)
end

