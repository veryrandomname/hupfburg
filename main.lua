local burg = require 'burg'
local swagline = require 'swagline'
local bomb = require 'bomb'

local bombs = {}

function love.load()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  world:setCallbacks( beginContact)
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
  love.graphics.print("Player 2:" .. " " .. burgen[2].points, 20, 20, 0, 2, 2 )
  love.graphics.print("Player 1:" .. " " .. burgen[1].points, love.graphics.getWidth()/2, 20, 0, 2, 2 )
end

function beginContact(a, b, coll)
  for i,v in ipairs(burgen) do
    if (a == v.coll.f or b == v.coll.f) and not (b:getCategory() == 3 or a:getCategory() == 3) then
      if a == burgen[i].coll.f or b == burgen[i].coll.f then
        burgen[i].points = burgen[i].points - 1.0
        for k, w in ipairs(bombs) do
          if b == w.fixture or a == w.fixture then
            --destroy fixture and body
            w.fixture:destroy()
            w.body:destroy()
            table.remove(bombs, k)
          end
        end
      end
      print("Points:")
      print("Player 1:" .. " " .. burgen[1].points .. " " .."Player 2:" .. " " .. burgen[2].points)
    end
  end  
end

function love.keypressed(key)
  swagline.keypressed(swag,key)
  if key == " " then
    table.insert(bombs,bomb.new(300,100,30))
  end
end
