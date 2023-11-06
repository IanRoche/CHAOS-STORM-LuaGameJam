local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Allahakbar = require "src.Enemies.AllahAkbar"
local Enemy = require "src.Enemies.Enemy"
local Enemies = Object:extend()
local Spawner = require "src.Enemies.Spawner"


EnemyList={}

-- Tabla para llevar un seguimiento de qué enemigos deben aparecer
 enemyVisibility = {
    Allahakbar = false,  -- Por defecto, aparece
    Enemy = false,      -- Por defecto, aparece
}

function Enemies:new()
    
    Allahakbar:new()
    Enemy:new()
    Spawner:new()
end

function Enemies:update(dt)
    Spawner:update(dt)

    for _, enemy in ipairs(EnemyList) do
        enemy:update(dt)
    end

   
    if enemyVisibility.Allahakbar then
        Allahakbar:update(dt)
    end
    if enemyVisibility.Enemy then
        Enemy:update(dt)
    end
end

function Enemies:draw()

    for _, enemy in ipairs(EnemyList) do
        enemy:draw()
    end


    if enemyVisibility.Allahakbar then
        Allahakbar:draw()
    end
    if enemyVisibility.Enemy then
        Enemy:draw()
    end
end

-- Método para cambiar el estado de cualquier enemigo
function Enemies:toggleEnemy(enemyName, value)
    if enemyVisibility[enemyName] ~= nil then
        enemyVisibility[enemyName] = value
    end
    print(enemyName, value)
end

return Enemies
