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
  if b.explodes then
  	love.graphics.setColor(100+b.age*20,100-b.age*20,100-b.age*20)

  	love.graphics.draw(bomb1, b.body:getX(), b.body:getY(), b.body:getAngle(), b.shape:getRadius()/bomb1:getWidth()*2, b.shape:getRadius()/bomb1:getWidth()*2, bomb1:getWidth()/2, bomb1:getHeight()/2)
  else
	  love.graphics.setColor(100+b.age*20,100+b.age*20,100+b.age*20)
	  love.graphics.draw(bubble1, b.body:getX(), b.body:getY(), b.body:getAngle(), b.shape:getRadius()/bubble1:getWidth()*2, b.shape:getRadius()/bubble1:getWidth()*2, bubble1:getWidth()/2, bubble1:getHeight()/2)
  end
  
  --love.graphics.circle("fill", b.body:getX(), b.body:getY(), b.shape:getRadius())
  


end

return bomb
