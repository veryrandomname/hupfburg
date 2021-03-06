local burg = require 'burg'
local swagline = require 'swagline'
local bomb = require 'bomb'

local bombs = {}

local function getBombedAway(x,y)
  return function(f)
    local x2,y2 = f:getBody():getPosition()
    local dx,dy = x2-x,y2-y
    local l = math.sqrt( math.pow(dx,2) + math.pow(dy,2) )
    dx,dy = dx/l, dy/l
    f:getBody():applyLinearImpulse(dx*10000,dy*10000)
    return false
  end
end

function love.load()
  local font = love.graphics.newFont( "HappyFox-Condensed.otf", 80 )
  love.graphics.setFont(font);

  local music = love.audio.newSource("Grossman_Ewell_Grainger_-_03_-_Bozza_Duettino_for_Two_Bassoons.mp3")
  music:setLooping(true)
  music:play()

  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  world:setCallbacks( beginContact)
  burg.load(0,-100)

  swag = swagline.new(50,450,100,300)
  bomb1 = love.graphics.newImage("bomb1.png")
  bubble1 = love.graphics.newImage("bubble1.png")
  love.graphics.setBackgroundColor(27, 178, 228)

end

function love.update(dt)
  world:update(dt)
  burg.update(dt)
  swagline.update(swag,dt)

  for i,v in ipairs(bombs) do
    v.age = v.age + dt
    if v.age > 5 then
      if v.explodes then
        local x,y = v.body:getX(), v.body:getY()
        world:queryBoundingBox( x-100, y-100, x+100, y+100, getBombedAway(x,y)) 
      end
      v.fixture:destroy()
      v.body:destroy()
      table.remove(bombs,i)
    end
  end

end

function love.draw()
  local mx,my = swag[math.floor(#swag/2)].body:getPosition()

  local w,h = love.graphics.getDimensions()
  love.graphics.scale(w/800,h/600)
  love.graphics.translate( mx - 400, my - 300 )

  love.graphics.setColor(255,255,255)
  love.graphics.print(burgen[1].points .. " Points", 50, 20)
  love.graphics.print(burgen[2].points .. " Points", 600, 20 )
  if winner then
    love.graphics.print("Winner!", 50 + 550*(winner-1), 90 )
  end

  burg.draw()

  swagline.draw(swag)

  for i,v in ipairs(bombs) do
    bomb.draw(v)
  end

end

function beginContact(a, b, coll)
  for i,v in ipairs(burgen) do
    if (a == v.coll.f or b == v.coll.f) and not (b:getCategory() == 3 or a:getCategory() == 3) then
      if a == burgen[i].coll.f or b == burgen[i].coll.f then
        burgen[i].points = burgen[i].points + 1

        -- win condition
        if burgen[i].points >= 20 and not winner then
          winner = i
        end

        for k, w in ipairs(bombs) do
          if b == w.fixture or a == w.fixture then
            --destroy fixture and body
            w.fixture:destroy()
            w.body:destroy()
            table.remove(bombs, k)
          end
        end
      end
    end
  end  
end

function love.keypressed(key)
  --swagline.keypressed(swag,key)
  if key == "q" then
    local b = bomb.new(100,250,10)
    b.body:setMass(0.5)
    b.body:applyLinearImpulse(200,50)
    table.insert(bombs,b)
  elseif key == "o" then
    local b = bomb.new(700,250,10)
    b.body:setMass(0.5)
    b.body:applyLinearImpulse(-200,50)
    table.insert(bombs,b)
  elseif key == "e" then
    local b = bomb.new(100,250,10)
    b.body:setMass(0.5)
    b.body:applyLinearImpulse(200,50)
    b.explodes = true
    table.insert(bombs,b)
  elseif key == "u" then
    local b = bomb.new(700,250,10)
    b.body:setMass(0.5)
    b.body:applyLinearImpulse(-200,50)
    b.explodes = true
    table.insert(bombs,b)
  elseif key == "w" then
    local b = bomb.new(100,250,20)
    b.body:setMass(1)
    b.body:applyLinearImpulse(200,50)
    table.insert(bombs,b)
  elseif key == "i" then
    local b = bomb.new(700,250,20)
    b.body:setMass(1)
    b.body:applyLinearImpulse(-200,50)
    table.insert(bombs,b)
  elseif key == "escape" then
    love.event.quit()
  elseif key == "f" then
    if not love.window.getFullscreen() then
      local w,h = love.window.getDesktopDimensions()
      love.window.setMode( w, h, {fullscreen = true} )
    else
      love.window.setMode( 800,600 )
    end
  end
end

