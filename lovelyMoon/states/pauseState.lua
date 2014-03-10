PauseState = {}

--New
function PauseState:new()
  local gs = {}

  gs = setmetatable(gs, self)
  self.__index = self
  _gs = gs

  return gs
end

--Load
function PauseState:load()
end

--Close
function PauseState:close()
end

--Enable
function PauseState:enable()
end

--Disable
function PauseState:disable()
end

--Update
function PauseState:update(dt)
end

--Draw
function PauseState:draw()
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, screen_width, screen_height)
  love.graphics.print("Press the Space Bar to return to the Game!", 14, 14)
end

--KeyPressed
function PauseState:keypressed(key, unicode)
  if key == ' ' then
    enableState('play')
    disableState('pause')
  end
end

--KeyRelease
function PauseState:keyrelease(key, unicode)
end

--MousePressed
function PauseState:mousepressed(x, y, button)
end

--MouseReleased
function PauseState:mousereleased(x, y, button)
end

