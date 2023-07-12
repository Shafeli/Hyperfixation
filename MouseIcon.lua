
MouseIcon = {}

function MouseIcon:load()
  
  self.sprite = love.graphics.newImage('Assets/Images/CrossHair.png')
      if self.sprite == nil then
            print('Error loading Player.png')
      end
      
  self.x = love.mouse.getX()
  self.y = love.mouse.getY()
  self.speed = 50
  self.rot = math.atan2((love.mouse.getY() - self.y), (love.mouse.getX() - self.x)) -- getting the Inverse Tangent
  self.width, self.height = self.sprite:getDimensions()

end

function MouseIcon:update(dt)
  
  self.x = love.mouse.getX()
  self.y = love.mouse.getY()
  self.rot = self.rot + 1.0 * dt
end

function MouseIcon:draw()
  love.graphics.draw(self.sprite, self.x, self.y, self.rot, 0.1, 0.1, self.width / 2, self.height / 2)
end
