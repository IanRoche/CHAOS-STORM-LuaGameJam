local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Enemy_AllahAkbar=Object:extend()

function Enemy_AllahAkbar:new()
    print("Building")
end
function Enemy_AllahAkbar:update(dt)
end
function Enemy_AllahAkbar:draw()
end

return Enemy_AllahAkbar