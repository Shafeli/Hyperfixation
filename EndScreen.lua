

EndScreen = {}

function EndScreen:load()
   yPos = 0
  yPosStartBotton = 550
    background = love.graphics.newImage('Assets/Images/Background.jpg')
      -- Error checking is good
      if background == nil then
            print('Error loading Background.jpg')
      end
        player = love.graphics.newImage('Assets/Images/Player.png')
      if player == nil then
            print('Error loading Player.png')
      end

    titleFont = love.graphics.newFont('Assets/Fonts/ARCADE.ttf', 150)
    scoreFont = love.graphics.newFont('Assets/Fonts/ARCADE.ttf', 60)
end

function EndScreen:update(dt)

end

function EndScreen:draw(playerScore)
  love.graphics.draw(background, 0, 0)
  
  love.graphics.draw(player, 400, 550, 0, 0.1, 0.1)

  
  love.graphics.setFont(titleFont)
  love.graphics.print("Game Over", 100, 0)
  
  love.graphics.setFont(scoreFont)
  love.graphics.print(string.format("Score: %d", playerScore), (love.graphics.getWidth() / 2) / 2 , 200)
  
  love.graphics.setFont(scoreFont)
  
  love.graphics.print("Press anykey To retry", (love.graphics.getWidth() / 2) / 2,(love.graphics.getHeight() / 2) + ((love.graphics.getHeight() / 2) / 2) - 100)
  
end