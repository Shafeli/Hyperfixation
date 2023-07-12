require("Game")
love.mouse.setVisible( false )
-- Load data 
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  Game:load()
end

--Update behavior
function love.update(dt)
Game:update(dt)
end


--Render calls
function love.draw()
Game:draw()
end

function love.mousepressed(x, y, button, istouch)
  
  Game:mousepressed(x, y, button, istouch)

end

function love.mousereleased(x, y, button, istouch)
  
end

function love.keypressed(key)


  Game:keypressed(key)
  
  if key == 'escape' then
     love.event.push('quit')
   else 
     
     moveFromTitle = true
     
     if moveFromEnd == false then
       
       moveFromTitle = false
      end
      
  end
  
end

function love.keyreleased(key)
  Game:keyreleased(key)
end

function love.quit()
  
  end

