
GameBackground = {}

function GameBackground:load()
  
      self.background = love.graphics.newImage('Assets/Images/GameBackGround.jpg')
      -- Error checking is good
      if self.background == nil then
            print('Error loading Background.jpg')
      end
      
      self.background = love.graphics.newImage('Assets/Images/GameBackGround.jpg')
      -- Error checking is good
      if self.background == nil then
            print('Error loading GameBackGround.jpg')
      end
end

function GameBackground:update(dt)
  
  
end

function GameBackground:draw()
  
    love.graphics.draw(self.background, 0, 0)
    
end

