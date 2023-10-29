local Object = Object or require "lib.classic"

local ICanBeDestroyedInterface = Object:extend()

function ICanBeDestroyedInterface:destroy()
end

function ICanBeDestroyedInterface:checkCollisionWithBar(bar)
end

return ICanBeDestroyedInterface
