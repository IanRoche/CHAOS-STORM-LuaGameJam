local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Allahakbar=require "src.Enemies.Enemy_AllahAkbar"
local Enemies=Object:extend()


function Enemies:new()
    Allahakbar:new()
end

function Enemies:update(dt)
end

function Enemies:draw()
end

return Enemies