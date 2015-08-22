local bomb = {}

function bomb.new(x,y,r)
  local n = {}
  n.body = love.physics.newBody(world, x, y, "dynamic")
  n.shape = love.physics.newCircleShape( r )
  n.fixture = love.physics.newFixture(n.body,n.shape)

  n.age = 0

  return n
end

function bomb.draw(b)
  love.graphics.setColor(100+b.age*20,100+b.age*20,100+b.age*20)
  love.graphics.circle("fill", b.body:getX(), b.body:getY(), b.shape:getRadius())
end

return bomb
