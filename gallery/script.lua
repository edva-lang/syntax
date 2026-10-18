-- Lua 5.4 Object-Oriented Vector and Particle Simulation

local Vector = {}
Vector.__index = Vector

function Vector.new(x, y)
    local self = setmetatable({}, Vector)
    self.x = x or 0
    self.y = y or 0
    return self
end

function Vector:add(other)
    return Vector.new(self.x + other.x, self.y + other.y)
end

function Vector:length()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function Vector:tostring()
    return string.format("Vector(%.2f, %.2f)", self.x, self.y)
end

-- Simulate particles
local v1 = Vector.new(3, 4)
local v2 = Vector.new(1, 2)
local v3 = v1:add(v2)

print("Result: " .. v3:tostring() .. ", magnitude: " .. v3:length())
