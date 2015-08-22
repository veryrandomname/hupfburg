burg = require 'burg'
function love.load()
  world = love.physics.newWorld(0, 9.81*64, true)
  burg.load()


end
function love.update(dt)
  world:update(dt)
  burg.update(dt)
end
function love.draw()
  burg.draw()
end
