local burg = require 'burg'
local swagline = require 'swagline'
local bomb = require 'bomb'

local bombs = {}

function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  burg.load(0,-100)

  swag = swagline.new(50,450,100,300)
end

function love.update(dt)
  world:update(dt)
  burg.update(dt)
end

function love.draw()
  burg.draw()

  swagline.draw(swag)

  for i,v in ipairs(bombs) do
    bomb.draw(v)
  end
end

function love.keypressed(key)
  swagline.keypressed(swag,key)
  if key == " " then
    table.insert(bombs,bomb.new(300,100,30))
  end
end
