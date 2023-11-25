Ground = Class{}

function Ground:init(x, y, width, height, color)
    self.x=x
    self.y=y
    self.width = width
    self.height = height
    self.color = color
end

function Ground:render()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
