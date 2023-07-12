
Asteroid = {}


function Asteroid:load()
  
  Asteroid.main = love.graphics.newImage('Assets/Images/Asteroid.png')
     -- The : operator means "get the dimensions of the 'ships' Image"
     -- Also, Lua can return multiple arguments. Neato!
  Asteroid.width, Asteroid.height = Asteroid.main:getDimensions()

  Asteroid.firstQuad = love.graphics.newQuad(250, 0, 250, 250, Asteroid.width, Asteroid.height)
  Asteroid.rot = 0
  Asteroid.x = love.graphics.getWidth() / 2
  Asteroid.y = 0
  Asteroid.speed = 60
  --Asteroid.width, Asteroid.height = Asteroid.main:getDimensions()
   end
   
function Asteroid:update(dt)
  
  --Asteroid.rot = Asteroid.rot + 0.5 * dt
  Asteroid.y = Asteroid.y + Asteroid.speed * dt
end

   function Asteroid:draw()
     -- The last two arguments are scaling the ship up 4 times
     love.graphics.draw(Asteroid.main, Asteroid.firstQuad, Asteroid.x, Asteroid.y , Asteroid.rot, 0.5, 0.5)
end

--, Asteroid.width / 2, Asteroid.height / 2