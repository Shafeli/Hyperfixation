
--------------------------------------------------------------------------------------------------------------------------------------
Game = {}
Game.PlayerLazers = {}
Game.Enemys = {}
Game.EnemyLazers = {}
--------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------
  require("titleScreen")
  require("EndScreen")
  require("player")
  require("Enemy")
  require("Music")
  require("Sounds")
  require("MouseIcon")
  require("GameBackground")
  require("UI")
  require("Asteroid")

  
--------------------------------------------------------------------------------------------------------------------------------------
  
love.mouse.setVisible( false )
moveFromTitle = false
moveFromEnd = true
enemyCount = 1
--------------------------------------------------------------------------------------------------------------------------------------
-- Load data 
--------------------------------------------------------------------------------------------------------------------------------------
function Game:load()

  love.graphics.setDefaultFilter('nearest', 'nearest')
    math.randomseed(os.clock())
    
  titleScreen:load()
  
  particles = {}
  
  --love.mouse.setVisible(false)
  love.mouse.getPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  print('Initializing Project: Hyperfixation')
  Player:load()
  Enemy:load()
  Music:load()
  Sounds:load()
  MouseIcon:load()
  GameBackground:load()
  Asteroid:load()
  UI:load()
  EndScreen:load()
  Game.Player = GetPlayer()
  Game.LazerSprite = love.graphics.newImage('Assets/Images/Bullet.png')
  Game.LevelCount = 0
  ParticleHitImage = love.graphics.newImage('Assets/Images/Hit_Particle.png')
  ParticleImage = love.graphics.newImage('Assets/Images/Smoke_Particle (2).jpeg')
  if Game.LazerSprite == nil then
    print('Error loading Bullet.png')
  end
  Game.LazerWidth, Game.LazerHeight = Game.LazerSprite:getDimensions()
  
  for i = 0, 1, 1 
    do 
      table.insert( Game.Enemys, Enemy:SpawnEnemy(  10 ,  math.random( 50, love.graphics.getWidth() - 200 ), i) )
  end
end
function createParticle()
     local newParticle = {}
     return newParticle
end
function createSmokeParticle(x, y, count)
  for i = 1, count do
       local part = createParticle()
       part.x = x
       part.y = y
       part.image = ParticleImage
       part.scale = randomFloatRange(0.01, 0.2)
        part.directionX = randomFloatRange(-1.0, 0.707)
       part.directionY = randomFloatRange(-1.0, 0.707)
       part.speed = randomFloatRange(20.0, 100.0)                     
       part.lifetime = randomFloatRange(0.2, 1.0)
       
       local greyscale = math.random()
       part.color = { math.random(), 0, 255, 0.2 }
       table.insert(particles, part)
     end
end

function createHitParticle(x, y, count)
  for i = 2, count do
       local part = createParticle()
       part.x = x
       part.y = y
       part.image = ParticleHitImage
       part.scale = randomFloatRange(0.01, 0.2)
       part.directionX = randomFloatRange(-1.0, 0.707)
       part.directionY = randomFloatRange(-1.0, 0.707)                   
       part.speed = randomFloatRange(20.0, 100.0)                     
       part.lifetime = randomFloatRange(0.2, 0.5)
       
       local greyscale = math.random()
       part.color = { 255, 255, 0, 1 }
       table.insert(particles, part)
     end
end

function drawParticle(particle)
   love.graphics.setColor(particle.color)
   love.graphics.draw(particle.image, particle.x, particle.y, 0, particle.scale, particle.scale)
     love.graphics.setColor(255,255,255)  -- Reset color 
end
--------------------------------------------------------------------------------------------------------------------------------------
-- Returns true if overlaps happens -- 
--------------------------------------------------------------------------------------------------------------------------------------
function overlaps(colliderA, colliderB)
     local tooFarLeft = (colliderB.x + colliderB.w < colliderA.x)
     local tooFarRight = (colliderB.x > colliderA.x + colliderA.w)
     local tooFarUp = (colliderB.y + colliderB.h < colliderA.y)
     local tooFarDown = (colliderB.y > colliderA.y + colliderA.h)
     local overlapping = not (tooFarLeft or tooFarRight or tooFarUp or tooFarDown)

   return overlapping
end
--------------------------------------------------------------------------------------------------------------------------------------
--Update behavior
--------------------------------------------------------------------------------------------------------------------------------------
function Game:update(dt)
  if Game.Player.health <= 0 then
    Game.Player.alive = false
  end
  
  if Game.Player.alive == false then
    moveFromTitle = true
    moveFromEnd = false
    end
  
  if next(Game.Enemys) == nil then
    enemyCount = enemyCount + 1
    Game.LevelCount = Game.LevelCount + 1
     for i = 0, enemyCount, 1 
    do 
      local spawnRand = math.random(1, 4)
      
      if spawnRand == 1 then 
        table.insert( Game.Enemys, Enemy:SpawnEnemy(  0 ,  math.random(1, love.graphics.getWidth()), i) )
      end
      
      if spawnRand == 2 then 
                  table.insert( Game.Enemys, Enemy:SpawnEnemy(  math.random(1, love.graphics.getHeight() ,  love.graphics.getWidth()), i) )
      end
      
      if spawnRand == 3 then 
        table.insert( Game.Enemys, Enemy:SpawnEnemy(  love.graphics.getHeight() ,  math.random(1, love.graphics.getWidth()), i) )
      end
      
      if spawnRand == 4 then 
        table.insert( Game.Enemys, Enemy:SpawnEnemy(  math.random(1, love.graphics.getHeight() ,  0), i) )
      end
  end
end
  
  Music:update(dt)
  MouseIcon:update(dt)
    
    if moveFromTitle == true then
      GameBackground:update(dt)
      Player:update(dt)
      
      if Game.Player.alive == true then 
    --------------------------------------------------------------------------------------------------------------------------------------
    --Enemy update calls
    --------------------------------------------------------------------------------------------------------------------------------------
      if  next(Game.Enemys) ~= nil then
        for index, oppent in ipairs(Game.Enemys) do
          Enemy:update(dt, oppent)
            if oppent.fireTime < 0 then  
                table.insert( Game.EnemyLazers, Game:createProjectile(oppent.x, oppent.y, oppent.rot) ) 
                Enemy:Fire(oppent)
                Sounds:playLazer()
            end
        end
      end
      
      UI:update(dt)
      Asteroid:update(dt)
     --------------------------------------------------------------------------------------------------------------------------------------
     -- Player Laser update calls   
     --------------------------------------------------------------------------------------------------------------------------------------
        if  next(Game.PlayerLazers) ~= nil then
          for index, proj in ipairs(Game.PlayerLazers) do
            Game:updateProjectile(dt, proj, proj.rot)
          end
        end
      end
      --------------------------------------------------------------------------------------------------------------------------------------
     -- Enemy Laser update calls   
     --------------------------------------------------------------------------------------------------------------------------------------
        if  next(Game.EnemyLazers) ~= nil then
          for index, proj in ipairs(Game.EnemyLazers) do
            Game:updateProjectile(dt, proj, proj.rot)
          end
        end
      
      if  next(particles) ~= nil then
          for index, part in ipairs(particles) do
              updateParticle(part, dt)
          end
        end
    if  next(Game.Enemys) ~= nil then
  --------------------------------------------------------------------------------------------------------------------------------------
  --Collision 
  --------------------------------------------------------------------------------------------------------------------------------------
      for index, enemy in ipairs(Game.Enemys) do
            -- For every bullet...
      for index, proj in ipairs(Game.PlayerLazers) do
          -- Check overlap
          if overlaps(proj.Collider, Enemy:GetCollider(enemy)) then
                      proj.alive = false
                      Enemy:Hit(enemy)
                      createHitParticle(enemy.x,enemy.y, 100)
                 end
            end
       end
    end
    
      for index, proj in ipairs(Game.EnemyLazers) do
          -- Check overlap
          if overlaps(proj.Collider, Game.Player.Collider) then
                      proj.alive = false
                      Player:Hit()
                 end
            end

    for index, proj in ipairs(Game.EnemyLazers) do
      if proj.alive == false then
        table.remove(Game.EnemyLazers, index)
      end
    end
    
    for index, proj in ipairs(Game.PlayerLazers) do
      if proj.alive == false then
        table.remove(Game.PlayerLazers, index)
      end
    end
    
    for index, enemy in ipairs(Game.Enemys) do
      if Enemy:IsEnemyAlive(enemy) == false then
        createSmokeParticle(enemy.x, enemy.y, 120)
        table.remove(Game.Enemys, index)
        Game.Player.score = (Game.Player.score + enemyCount) * 2
      end
    end
    
    --TODO: if enemy overlap reset previous x, y 
      for index, enemyA in ipairs(Game.Enemys) do
        for index, enemyB in ipairs(Game.Enemys) do
          if Enemy:overlaps(Enemy:GetCollider(enemyA),Enemy:GetCollider(enemyB),enemyA.id,enemyB.id) then
              Enemy:ResetXY(enemyA)
          end
        end
      end  
    end
    
        for index = #particles, 1, -1 do
        local part = particles[index]
        local isDead = updateParticle(part, dt)

        if isDead == true then
            table.remove(particles, index)
        end
    end
end
function updateParticle(particle, dt)
     particle.x = particle.x + particle.directionX * particle.speed * dt
     particle.y = particle.y + particle.directionY * particle.speed * dt

     particle.lifetime = particle.lifetime - dt

     if particle.lifetime <= 0 then
          return true
     else
          return false
     end
end
--------------------------------------------------------------------------------------------------------------------------------------
--Render calls
--------------------------------------------------------------------------------------------------------------------------------------
function Game:draw()

  if moveFromTitle == true and moveFromEnd then

      GameBackground:draw()
      Asteroid:draw()
      Player:draw()
--------------------------------------------------------------------------------------------------------------------------------------     
--Player Laser draw calls
--------------------------------------------------------------------------------------------------------------------------------------
  love.graphics.setColor(255, 0, 0, 1)
    if  next(Game.PlayerLazers) ~= nil then
      for index, proj in ipairs(Game.PlayerLazers) do
        Game:drawProjectile(proj)
      end
  end
  love.graphics.setColor(255,255,255)  -- Reset color 
--------------------------------------------------------------------------------------------------------------------------------------
-- Enemy draw calls    
--------------------------------------------------------------------------------------------------------------------------------------
    if  next(Game.Enemys) ~= nil then
      for index, oppent in ipairs(Game.Enemys) do
            Enemy:draw(oppent)
      end
    end
--------------------------------------------------------------------------------------------------------------------------------------     
--Enemy Laser draw calls
--------------------------------------------------------------------------------------------------------------------------------------
    if  next(Game.EnemyLazers) ~= nil then
      for index, proj in ipairs(Game.EnemyLazers) do
        Game:drawProjectile(proj)
      end
    end
  -- UI layer 
      UI:draw(Game.Player.score, Game.LevelCount,Game.Player.health)
 
    else        --Else Tile Draw
      titleScreen:draw()
  end
  
  if moveFromEnd == false then   -- End Screen 
    EndScreen:draw(Game.Player.score)
  end
  
  for index, part in ipairs(particles) do
          drawParticle(part)
  end
  
    MouseIcon:draw()
end

function randomFloat(x)
     return math.random() * x
end

function randomFloatRange(min, max)
     -- Find the range of values
     local delta = max - min

     -- Add a random amount of that range to min
     return min + (delta * math.random())
end
--------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------
function Game:mousepressed(x, y, button, istouch)
  
  Player:mousepressed(x, y, button, istouch)
    local buttonName = nil
  if button == 1 then
    local newX, newY = Player:getPosition() 
        table.insert( Game.PlayerLazers, Game:createProjectile(newX, newY, Player:getAngle()) ) 
  end
end

function Game:mousereleased(x, y, button, istouch)
  -- If not needed remove -- 
end

function Game:keypressed(key)
  Player:keypressed(key)
  
  if key == 'escape' then
     love.event.push('quit')
   else 
       if Game.Player.alive == false and moveFromEnd == false then
      moveFromTitle = false
      moveFromEnd = true
      Player:Reset()
      enemyCount = 1
      Game.Enemys = {}
      Game.LevelCount = 0

    end
  end
end
--------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------
function Game:keyreleased(key)
  Player:keyreleased(key)
end
--------------------------------------------------------------------------------------------------------------------------------------
--Returns a Projectile --takes in Origin x and y and angle in radians to the target
--------------------------------------------------------------------------------------------------------------------------------------
function Game:createProjectile(newX, newY, angle)
  
  local newProjectile = {
    x = newX,
    y = newY,
    speed = 350,
    rot = angle,
    sprite = Game.LazerSprite,
    width = Game.LazerWidth,
    height = Game.LazerHeight
   }
   
   --Collider for projectile
     newProjectile.Collider = 
  {
    x = newProjectile.x,
    y = newProjectile.y,
    w = 2,
    h = 2
  }
     return newProjectile
end
--------------------------------------------------------------------------------------------------------------------------------------
--takes in DeltaTime, and a Projectile
--------------------------------------------------------------------------------------------------------------------------------------
function Game:updateProjectile(dt, projectile, angle)
  
  if projectile ~= nil then
    projectile.x = projectile.x + math.cos(angle) * projectile.speed * dt
    projectile.y = projectile.y + math.sin(angle) * projectile.speed * dt
    
    projectile.Collider.x = projectile.x
    projectile.Collider.y = projectile.y
  end
end
--------------------------------------------------------------------------------------------------------------------------------------
--takes in a Projectile
--------------------------------------------------------------------------------------------------------------------------------------
function Game:drawProjectile(proj)
  
  love.graphics.rectangle('fill', proj.Collider.x, proj.Collider.y, proj.Collider.w, proj.Collider.h)
  love.graphics.draw(proj.sprite, proj.x, proj.y, proj.rot, 0.05, 0.05, proj.width / 2, proj.height / 2)
end
