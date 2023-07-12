require("Sounds")
Player = {}

function degree2radian(degree)
     return degree * (math.pi / 180)
end

function Player:load()
  
  self.sprite = love.graphics.newImage('Assets/Images/Player.png')
      if self.sprite == nil then
            print('Error loading Player.png')
      end
      
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  self.speed = 160
  self.rot = math.atan2((love.mouse.getY() - self.y), (love.mouse.getX() - self.x)) -- getting the Inverse Tangent
  self.width, self.height = self.sprite:getDimensions()
  self.lazers = {}
  self.score = 0
  self.alive = true
  self.health = 100
  self.Collider = 
  {
    x = Player.x,
    y = Player.y,
    w = 45,
    h = 35
  }
  
end

function Player:update(dt)
  
  self.rot = math.atan2((love.mouse.getY() - self.y), (love.mouse.getX() - self.x)) -- getting the Inverse Tangent
    
  if moving == true then
    self.speed = self.speed + dt
      --Do the math 
    angle = math.atan2(self.y-love.mouse.getY(), self.x-love.mouse.getX())
      --Update the player with the angle and dt, speed 
    self.x = self.x - math.cos(angle) * self.speed * dt
    self.y = self.y - math.sin(angle) * self.speed * dt
      --Update the collider with the new player x, y
    self.Collider.x = self.x - 24
    self.Collider.y = self.y - 20 
      --Make a sound
    Sounds:playPlayerEngine()
  end
    
  if moving == false then 
    self.speed = self.speed - dt
    Sounds:StopPlayerEngine()
  end
end

function Player:draw()
    love.graphics.rectangle('line', self.Collider.x, self.Collider.y, self.Collider.w, self.Collider.w)
  love.graphics.draw(self.sprite, self.x, self.y, self.rot, 0.05, 0.05, self.width / 2, self.height / 2)
end

function Player:getPosition()
  return self.x, self.y
end

function Player:getAngle()
  return self.rot
end

function Player:keypressed(key)
  
    if key == 'space' then
       moving = true
       if self.speed > 200  then
          self.speed = self.speed + 5
       end
    end
    if  key == "f" then
       Sounds:playLazer()
    end
end

function Player:mousepressed(x, y, button, istouch)
  local buttonName = nil
  if button == 1 then
    Sounds:playLazer()
  end
end
function Player:Hit()
  self.health = self.health - 10
end
function Player:keyreleased(key)
  
        if key == 'space' then
          moving = false
          self.speed = 160
        end
end
function Player:Reset()
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  self.speed = 160
  self.lazers = {}
  self.score = 0
  self.alive = true
  self.health = 100
  end
function GetCollider()  
  return self.Collider
end
function GetPlayer()  
  return Player
end