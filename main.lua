function love.load()
  screen_width = 800
  screen_height = 600

  background_color = {39, 77, 126}

  state = 'play'

  looking = 'right'

  initialize_floor()
  initialize_player()

  jump_height = 300
  gravity = 400

  love.window.setTitle('JUMPEE!')
  love.window.setMode(screen_width, screen_height)
end

function love.update(dt)
  if state ~= 'play' then
    return
  end

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

function love.draw()
  set_background()
  draw_floor()

  draw_player()

  if state == 'pause' then
    draw_pause_overlay()
  end
end

function love.keypressed(key)
  if key == 'q' or key == 'escape' then
    love.event.quit()
  end

  if key == 'p' then
    if state == 'play' then
      state = 'pause'
    else
      state = 'play'
    end
  end
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

function set_background()
  love.graphics.setBackgroundColor(background_color)
end

function draw_floor()
  love.graphics.setColor(floor_color)
  love.graphics.rectangle('fill', 0, floor_y, screen_width, (screen_height - floor_y) )
end

function draw_player()
  sx = 1
  if looking == 'left' then
    sx = -1
  end

  love.graphics.draw(player.image, player.x, player.y, 0, sx, 1)
end

function draw_pause_overlay()
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, screen_width, screen_height)
end
