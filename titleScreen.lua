
titleScreen = {}

function titleScreen:load()
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
        enemy = love.graphics.newImage('Assets/Images/Enemy.png')
      if enemy == nil then
            print('Error loading Enemy.png')
      end
    titleFont = love.graphics.newFont('Assets/Fonts/ARCADE.ttf', 150)
    creditFont = love.graphics.newFont('Assets/Fonts/ARCADE.ttf', 21)
end

function titleScreen:update(dt)

end

function titleScreen:draw()
  love.graphics.draw(background, 0, 0)
  
  love.graphics.draw(player, 400, 550, 0, 0.1, 0.1)

  --Millennium Falcon lazer shot
  love.graphics.setColor(0, 1, 0, 1)
  love.graphics.rectangle('fill', 400, 400, 5, 15)
  love.graphics.setColor(255,255,255)  -- Reset color 


  love.graphics.draw(enemy, 400, 150, 0, 0.1, 0.1)
  
  --Tie fighter lazer shot
  love.graphics.setColor(0, 1, 0, 1)
  love.graphics.rectangle('fill', 450, 300, 5, 15)
  love.graphics.setColor(255,255,255)  -- Reset color 
  
      love.graphics.setFont(titleFont)
  love.graphics.print("HyperFixation", 100, 0)
  
  
  love.graphics.setFont(creditFont)
  love.graphics.print("Made by: Silas Hafeli", 50, 680)
  love.graphics.print("Crosshairs by user Calinou: https://opengameart.org/content/%E2%80%9Calien%E2%80%9D-crosshairs ", 50, 720)
  love.graphics.print("Astroid from: https://www.nicepng.com/ourpic/u2e6y3o0q8i1o0u2_images-of-asteroid-sprite-png-asteroid-sprite-sheet/ ", 50, 700)
  
end