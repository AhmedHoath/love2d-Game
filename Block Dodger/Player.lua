Player = Object.extend(Object)

function Player:new()
    self.x = 450
    self.y = 680
    self.width = 60
    self.height = 60
end

function Player:update(dt)
    if love.keyboard.isDown('left') then
        self.x = math.max(15, self.x + -50)
    elseif love.keyboard.isDown('right') then
        self.x = math.min(927, self.x + 50)
    end
end

function Player:draw()
    love.graphics.setColor(0.12941176470588,0.25098039215686,0.60392156862745)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end