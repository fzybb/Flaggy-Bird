PipeUpward = Class{}

function PipeUpward:init(x, y)
    self.x = x
    self.y = y
    self.width = pipeUp:getWidth()
    self.height = pipeUp:getHeight()
    self.speed = 70
end

function PipeUpward:update(dt)
    self.x = self.x - self.speed * dt
end


function PipeUpward:render()
    love.graphics.draw(pipeUp, self.x, self.y)
    love.graphics.setColor(1,1,1)
end

