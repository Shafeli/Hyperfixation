

Sounds = {}
function Sounds:load()

    self.playerEngine = love.audio.newSource("Assets/Sounds/PlayerShipEngine.wav", "static")
    self.lazer = love.audio.newSource("Assets/Sounds/Lazer.wav", "static")
    self.lazer:setVolume(0.1)
    self.playerEngine:setVolume(0.1)
end

function Sounds:playLazer()
  		love.audio.play( self.lazer )
  end
  
  function Sounds:playPlayerEngine()
      if not self.playerEngine:isPlaying( ) then
        love.audio.play( self.playerEngine )
      end
  end
  
    function Sounds:StopPlayerEngine()
      if self.playerEngine:isPlaying( ) then
        love.audio.stop( self.playerEngine )
      end
  end