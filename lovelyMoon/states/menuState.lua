MenuState = {}

--New
function MenuState:new()
  local gs = {}

  gs = setmetatable(gs, self)
  self.__index = self
  _gs = gs

  return gs
end

--Load
function MenuState:load()
  screen_width = 800
  screen_height = 600

  love.window.setTitle('JUMPEE!')
  love.window.setMode(screen_width, screen_height)
end

--Close
function MenuState:close()
end

--Enable
function MenuState:enable()
end

--Disable
function MenuState:disable()
end

--Update
function MenuState:update(dt)
end

--Draw
function MenuState:draw()
  love.graphics.print("HI, press the Space Bar to go to the Game!", 14, 14)
end

--KeyPressed
function MenuState:keypressed(key, unicode)
  if key == " " then
    enableState('play')
    disableState('menu')
  end
end

--KeyRelease
function MenuState:keyrelease(key, unicode)
end

--MousePressed
function MenuState:mousepressed(x, y, button)
end

--MouseReleased
function MenuState:mousereleased(x, y, button)
end

