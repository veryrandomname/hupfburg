local burg = require 'burg'
local swagline = require 'swagline'
local bomb = require 'bomb'

function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  burg.load(0,-200)

  swag = swagline.new(20,100,300)
  testbomb = bomb.new(300,100,50)
end

function love.update(dt)
  world:update(dt)
  burg.update(dt)
end

function love.draw()
  burg.draw()

  swagline.draw(swag)

  bomb.draw(testbomb)
end

function love.keypressed(key)
  swagline.keypressed(swag,key)
end
