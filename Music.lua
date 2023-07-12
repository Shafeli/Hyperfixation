

Music = {}

function Music:load()
    Music.tileMusic = love.audio.newSource("Assets/Music/TitleMusic.wav", "stream")
    Music.tileMusic:setVolume(0.1)
  
  
end

function Music:update(dt)
  if not Music.tileMusic:isPlaying( ) then
		love.audio.play( Music.tileMusic )
    
  end
end