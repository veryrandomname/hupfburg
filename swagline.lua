
local BLOCKSIZE = 20
local DISTANCE = BLOCKSIZE*1.3

local swagline = {}

function swagline.new(length, x, y)
  local nl = {}

  for i=1, length do
    local n = {}
   
    if i == 1 or i == length then
      n.body = love.physics.newBody(world, x + DISTANCE*i, y, "static")
    else
      n.body = love.physics.newBody(world, x + DISTANCE*i, y, "dynamic")
    end
    n.shape = love.physics.newCircleShape(BLOCKSIZE)
    n.fixture = love.physics.newFixture(n.body, n.shape)
   
    table.insert(nl,n)

    if i > 1 then
      n.joint = love.physics.newRopeJoint( nl[i-1].body, n.body, x + DISTANCE*(i-1) , y, x + DISTANCE*i , y, DISTANCE , false)
    end
  end

  return nl 
end

function swagline.draw(swg)
  local m = #swg/2
  for i,v in ipairs(swg) do
    if i > m then
      love.graphics.setColor(200,100,120)
    else
      love.graphics.setColor(100,200,120)
    end
    --love.graphics.polygon("fill", v.body:getWorldPoints(v.shape:getPoints()))
    love.graphics.circle("fill", v.body:getX(), v.body:getY(), v.shape:getRadius())
  end
end

local function keyToPosition(key,l)
  local n = tonumber(key)
  if not n then return n end
  if n == 0 then n = 10 end

  return math.floor(n*((l-2)/10))
end

function swagline.keypressed(swg,key)
  local n = keyToPosition(key,#swg) -- TODO: #swg is evil
  if n then
    swg[n].body:applyLinearImpulse( 0, -500 )
  end
end


return swagline
