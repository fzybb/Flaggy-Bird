function love.load()
    -- colors
    skyBlue = {.43, .77, 80}
    cream = {.87, .84, .58}
    green = {.45, .74, .18}

    -- score
    score = 0
    upcomingPipe = 1

    -- font style
    font = love.graphics.newFont('Fonts/DIMIS___.TTF', 50)

    -- images
    backgroundImage = love.graphics.newImage('Assets/gamebackground.jpg')
    birdImage = love.graphics.newImage('Assets/birddrawing.png')
    pipeDown = love.graphics.newImage('Assets/Pipe-down.png')
    pipeUp = love.graphics.newImage('Assets/Pipe-up.png')

    -- sounds and effects
    scoreSound = love.audio.newSource('Sound effects/score.wav', 'static')
    explosionSound = love.audio.newSource('Sound effects/explosion.wav', 'static')
    jumpSound = love.audio.newSource('Sound effects/jump.wav', 'static')


    WINDOW_WIDTH = love.graphics.getWidth()
    WINDOW_HEIGHT = love.graphics.getHeight()

    Class = require('Lua/class')
    bird = require('Lua/Bird')
    ground = require('Lua/Ground')
    pipeD = require('Lua/PipeDownward')
    pipeU = require('Lua/PipeUpward')


    player = Bird()
    dirt = Ground(0, 390, 315, 60, cream)
    grass = Ground(0, 375, 315, 15, green)

    function FirstPipes()
        local pipeSpaceYMin = -120
        local pipeSpaceY = love.math.random(pipeSpaceYMin, -5)
        pipe1 = PipeDownward(WINDOW_WIDTH, pipeSpaceY)
        pipe2 = PipeUpward(WINDOW_WIDTH, pipeSpaceY + 315)
    end

    FirstPipes()

    function SecondPipes()
        local pipeSpaceYMin = -120
        local pipeSpaceY = love.math.random(pipeSpaceYMin, -5)
        pipe3 = PipeDownward(490, pipeSpaceY)
        pipe4 = PipeUpward(490, pipeSpaceY + 315)
    end

    SecondPipes()
    
end

function love.update(dt)
    if pipe1.x + pipe1.width and pipe2.x + pipe2.width < 0 then
        pipe1.x = WINDOW_WIDTH
        pipe2.x = WINDOW_WIDTH
        FirstPipes()
    end

    if pipe3.x + pipe3.width and pipe4.x + pipe4.width < 0 then
        SecondPipes()
        pipe3.x = WINDOW_WIDTH
        pipe4.x = WINDOW_WIDTH
    end

    player:update(dt)
    pipe1:update(dt)
    pipe2:update(dt)
    pipe3:update(dt)
    pipe4:update(dt)

    if player:collision(pipe1) then
        love.load()
        explosionSound:play()
      elseif player:collision(pipe2) then
        love.load()
        explosionSound:play()
      elseif player:collision(pipe3) then
        love.load()
        explosionSound:play()
      elseif player:collision(pipe4) then
        love.load()
        explosionSound:play()
      elseif player:collision(grass) then
        love.load()
        explosionSound:play()
      end
    
      if upcomingPipe == 1 and player.x > (pipe1.x + pipe1.width) then
        score = score + 1
        upcomingPipe = 2
        scoreSound:play()
      end
      if upcomingPipe == 2 and player.x > (pipe3.x + pipe3.width) then
        score = score + 1
        upcomingPipe = 1
        scoreSound:play()
      end
end

function love.keypressed(key)
    player:jump()
    jumpSound:play()
end

function love.draw()
    love.graphics.draw(backgroundImage, 0, 0)
    pipe1:render()
    pipe2:render()
    pipe3:render()
    pipe4:render()

    player:render()
    dirt:render()
    grass:render()

    love.graphics.setColor(0,0,0)
    love.graphics.setFont(font)
    love.graphics.print(score, 140, 50)
    love.graphics.setColor(1,1,1)
end

