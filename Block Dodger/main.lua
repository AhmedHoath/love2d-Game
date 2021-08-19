Object = require 'classic'

require 'Player'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    listOfRectangles = {}
    spawnTimer = 0
    timer = math.random(0.3, 0.6)
    score = 0
    gameState = 'start'

    startFont = love.graphics.newFont('pixel.ttf', 30)
    scoreFont = love.graphics.newFont('pixel.ttf', 30)

    music = love.audio.newSource("music-loop.wav", "static")
    gameOver = love.audio.newSource("gameover.mp3", "static")

    ground = {
        x = 1,
        y = 740,
        width = 1000,
        height = 10
    }

    p1 = Player()
end




function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'f5' then
        love.event.quit('restart')
    end
end




function love.update(dt)
    p1.update(p1, dt)

if spawnTimer > 0.3 then
    createRect()
    respawn()
    spawnTimer = 0
elseif love.keyboard.isDown('space') then
    gameState = 'play'
    score = 0
elseif gameState == 'start' then
    love.audio.play(music)
else
end

 for i,v in ipairs(listOfRectangles) do
if checkCollision(p1, v) then
    gameState = 'end'
elseif checkCollision(ground, v) then
    score = score + 10
elseif gameState == 'end' then
    table.remove(listOfRectangles)
    table.remove(rect1)
    love.audio.play(gameOver)
elseif love.audio.stop(music) then
    love.audio.play(music)
    end
end

  if gameState == 'play' then
    for i,v in ipairs(listOfRectangles) do
        v.y = v.y + 20
    end
    spawnTimer  = spawnTimer + dt
    love.audio.stop(music)
end
  if score > 5 then
    for i,v in ipairs(listOfRectangles) do
    v.y = v.y + 0.012 * score
end
  end
end




function love.draw()

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('fill', ground.x, ground.y, ground.width, ground.height)

    love.graphics.setColor(1, 1, 1)
    if gameState == 'start' then
        love.graphics.setFont(startFont)
        love.graphics.print('press SPACE to start', 350, 440, 0, 1, 1)
        love.graphics.setColor(0.92941176470588,0.10980392156863,0.14117647058824)
        love.graphics.print('BLOCK', 380, 250, 0, 2.8, 2.8)
        love.graphics.setColor(0,0.4,0.70196078431373)
        love.graphics.print('DODGER', 360, 320, 0, 2.8, 2.8)
    elseif gameState == 'play' then
        love.graphics.setColor(1, 1, 1)
        love.graphics.setFont(scoreFont)
        love.graphics.print(score, 5, 5, 0, 1.5, 1.5)
        p1.draw(p1)
    elseif gameState == 'end' then
        love.graphics.setColor(0.92941176470588,0.10980392156863,0.14117647058824)
        love.graphics.print('GAME OVER', 350, 310, 0, 2, 2)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print('score: '..score, 420, 360, 0, 1, 1)
    end

    love.graphics.setColor(0.92941176470588,0.10980392156863,0.14117647058824)
    for i,v in ipairs(listOfRectangles) do
        love.graphics.rectangle('fill', v.x, v.y, v.width, v.height)
    end
end




function createRect()
    rect1 = {
    x = 450,
    y = 20,
    width = 50,
    height = 50
}

    table.insert(listOfRectangles, rect1)
end




function respawn()
    rect1.y = math.random(0, 5)
    rect1.x = math.random(5, 950)
end

function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y 
    local b_bottom = b.y + b.height

    if a_right > b_left
    and a_left < b_right
    and a_bottom > b_top
    and a_top < b_bottom then

        return true
    else
        return false

    end
end