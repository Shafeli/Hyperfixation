

require("player")
UI={}


function UI:load()
  
  UI.front = love.graphics.newFont('Assets/Fonts/ARCADE.ttf', 35)
  
end

function UI:update(dt)
  
  
end

function UI:draw(playerScore, LevelCount,PlayerHealth)
  love.graphics.setFont(UI.front)
  

  love.graphics.print(string.format("Score: %d", playerScore), 50, 20)
  
  love.graphics.print(string.format("Level: %d", LevelCount), love.graphics.getWidth() / 2, 20)
  
  love.graphics.print(string.format("Health: %d ", PlayerHealth), 50, 725)
  love.graphics.print("Space: thrust\nLeft Mouse button: shoot\nAim: Mouse Cursor ", love.graphics.getWidth() - 425, 620)
    
end

