-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------

require("player")
Enemy = {}

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------
function degree2radian(degree)
     return degree * (math.pi / 180)
end

function Enemy:load()
  
  self.sprite = love.graphics.newImage('Assets/Images/Enemy.png')
      if self.sprite == nil then
            print('Error loading Player.png')
      end
      
  self.id = -1
  self.x = love.graphics.getWidth() / 2
  self.y = 0
  self.speed = 70
  self.rot = math.atan2((love.mouse.getY() - self.y), (love.mouse.getX() - self.x)) -- getting the Inverse Tangent
  self.width, self.height = self.sprite:getDimensions()
  self.lastX = 0
  self.lastY = 0
  self.alive = true
  self.fireTime = math.random(1, 10)
  self.health = 100
  self.Collider = 
  {
    x = self.x,
    y = self.y,
    w = 24,
    h = 24
  }
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:update(dt, enemyToUpdate)
  
  local lastX = enemyToUpdate.x
  local lastY = enemyToUpdate.y
  
  enemyToUpdate.lastX = lastX
  enemyToUpdate.lastY = lastY
  
  Target = {}
  Target.x, Target.y = Player:getPosition()
  

  enemyToUpdate.rot = math.atan2((Target.y - enemyToUpdate.y), (Target.x - enemyToUpdate.x)) -- getting the Inverse Tangent

  angle = math.atan2(enemyToUpdate.y-Target.y, enemyToUpdate.x-Target.x)
  enemyToUpdate.x = enemyToUpdate.x - math.cos(angle) * enemyToUpdate.speed * dt
  enemyToUpdate.y = enemyToUpdate.y - math.sin(angle) * enemyToUpdate.speed * dt
  
  enemyToUpdate.Collider.x = enemyToUpdate.x - 12
  enemyToUpdate.Collider.y = enemyToUpdate.y - 12
  
  enemyToUpdate.fireTime = enemyToUpdate.fireTime - dt
  
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:Fire(enemyFired)
      enemyFired.fireTime = math.random(1, 10)
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:draw(enemyToDraw)
  
  love.graphics.rectangle('line', enemyToDraw.Collider.x, enemyToDraw.Collider.y, enemyToDraw.Collider.w, enemyToDraw.Collider.h)
  love.graphics.draw(enemyToDraw.sprite, enemyToDraw.x, enemyToDraw.y, enemyToDraw.rot, 0.05, 0.05, enemyToDraw.width / 2, enemyToDraw.height / 2)

end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--this return a copy of the object -- I believe this is a deep copy for LUA not really sure?
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:SpawnEnemy( x, y, id )
  local copy = { }
  
  for i, value in pairs(Enemy) do 
    copy[i] = value 
  end
  
  copy.alive = true
  copy.fireTime = math.random(1, 10)
  copy.health = 100
  copy.x = x
  copy.y = y
  copy.id = id
  copy.lastX = 0
  copy.lastY = 0
  copy.Collider = 
  {
    x = x,
    y = y,
    w = 24,
    h = 24
  }
  return setmetatable(copy, getmetatable(Enemy))
  --return copy
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:IsEnemyAlive(enemy)
    if enemy.health < 0 then 
      return false
    end
    return true
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:Hit(enemy)
  enemy.health = enemy.health - 25
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--Get the collider of the enemy passed to function
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:GetCollider(enemyIn)  
  return enemyIn.Collider
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:CheckForSelf(enemyInSelf, enemyInToCheck)
  
    if enemyInSelf.id == enemyInToCheck then 
      return true
    end
  return false
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:overlaps(colliderA, colliderB, colliderAID, colliderBID)
  
    if colliderAID == colliderBID then 
      return
    end
  
     local tooFarLeft = (colliderB.x + colliderB.w < colliderA.x)
     local tooFarRight = (colliderB.x > colliderA.x + colliderA.w)
     local tooFarUp = (colliderB.y + colliderB.h < colliderA.y)
     local tooFarDown = (colliderB.y > colliderA.y + colliderA.h)
     local overlapping = not (tooFarLeft or tooFarRight or tooFarUp or tooFarDown)

   return overlapping
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--Reset to the last x and y
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:ResetXY(enemyToReset)
  
  local lastX = enemyToReset.lastX
  local lastY = enemyToReset.lastY
  
  enemyToReset.x = lastX
  enemyToReset.y = lastY
  
  enemyToReset.Collider.x = enemyToReset.x - 12
  enemyToReset.Collider.y = enemyToReset.y - 12
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function Enemy:GetPosition(enemy)
    return enemy.x, enemy.y
end










