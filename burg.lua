
local burg = {}
burg.size = 100
burg.wallsize = 15
players = {}

function burg.load(x,y)
  x,y = x or 0, y or 0
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  --print(love.graphics.getWidth())

  --[[
  burgen = {burg.new(x + love.graphics.getWidth()- burg.size- burg.wallsize ,y + love.graphics.getHeight() - burg.wallsize- burg.size),
            burg.new(x, y + love.graphics.getHeight()- burg.wallsize - burg.size)}
            --]]
  burgen = {burg.new(x + 800 - burg.size- burg.wallsize ,y + 600 - burg.wallsize- burg.size),
            burg.new(x, y + 600 - burg.wallsize - burg.size)}



end
function burg.new(x,y)
  local new = {}
  new.points = 0
  new.walls = {}
  new.walls.b = {}
  new.walls.b.l = love.physics.newBody(world, x + burg.wallsize/2, y- burg.size/2) --left wall
  new.walls.b.r = love.physics.newBody(world, x + burg.size + burg.wallsize/2, y- burg.size/2) --right wall
  new.walls.b.g = love.physics.newBody(world, x + burg.size/2 + burg.wallsize/2, y) --+ burg.size) --ground

  new.walls.s = {}
  new.walls.s.l = love.physics.newRectangleShape(burg.wallsize, burg.size) 
  new.walls.s.r = love.physics.newRectangleShape(burg.wallsize, burg.size)
  new.walls.s.g = love.physics.newRectangleShape(burg.size+ burg.wallsize, burg.wallsize)

  new.walls.f = {}
  new.walls.f.l = love.physics.newFixture(new.walls.b.l, new.walls.s.l) --attach shape to body
  new.walls.f.r = love.physics.newFixture(new.walls.b.r, new.walls.s.r) --attach shape to body
  new.walls.f.g = love.physics.newFixture(new.walls.b.g, new.walls.s.g) --attach shape to body

  new.coll = {}
  new.coll.b = love.physics.newBody(world, x + burg.size/2 + burg.wallsize/2, y - burg.size/2)
  new.coll.s = love.physics.newRectangleShape(burg.size, burg.size)
  new.coll.f = love.physics.newFixture(new.coll.b, new.coll.s)
  new.coll.f:setSensor(true)
  new.coll.f:setCategory(2)
  new.coll.f:setMask(3)
  return new

end
function burg.update(dt)




end



function burg.draw()
  --print("lol")
	for i, v in pairs(burgen) do
    love.graphics.setColor(250, 150, 15)    
    love.graphics.polygon( "fill", v.walls.b.g:getWorldPoints(v.walls.s.g:getPoints()) )
    love.graphics.polygon( "fill", v.walls.b.l:getWorldPoints(v.walls.s.l:getPoints()) )
    love.graphics.polygon( "fill", v.walls.b.r:getWorldPoints(v.walls.s.r:getPoints()) )
    --love.graphics.setColor(150, 150, 15)    
    --love.graphics.polygon( "fill", v.coll.b:getWorldPoints(v.coll.s:getPoints()))
	  --love.graphics.rectangle( "fill", v.walls.b.l:getX(), v.walls.b.l:getY(), burg.wallsize, burg.size)
	  --love.graphics.rectangle( "fill", v.walls.b.r:getX(), v.walls.b.r:getY(), burg.wallsize, burg.size)
	  --love.graphics.rectangle( "fill", v.walls.b.g:getX(), v.walls.b.g:getY(), burg.size, burg.wallsize)
	end
end


return burg 
