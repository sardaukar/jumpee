--Libraries
require('lovelyMoon/stateManager')
require('lovelyMoon/lovelyMoon')
require('AnAL')

--GameStates
require('lovelyMoon/states/menuState')
require('lovelyMoon/states/playState')
require('lovelyMoon/states/pauseState')

function love.load()
	addState(MenuState, 'menu')
	addState(PlayState, 'play')
  addState(PauseState, 'pause')

	enableState('menu')
end

function love.update(dt)
	lovelyMoon.update(dt)
end

function love.draw()
	lovelyMoon.draw()
end

function love.keypressed(key, unicode)
	lovelyMoon.keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
	lovelyMoon.keyreleased(key, unicode)
end

function love.mousepressed(x, y, button)
	lovelyMoon.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
	lovelyMoon.mousereleased(x, y, button)
end