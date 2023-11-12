local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Allahakbar = require "src.Enemies.AllahAkbar"
local EnemyFollow = require "src.Enemies.EnemyFollow"
local Bouncy = require "src.Enemies.Bouncy"
local Spawner = require "src.Enemies.Spawner"

local Enemies = Object:extend()
EnemyList = {}

-- Tabla para llevar un seguimiento de qué enemigos deben aparecer
enemyVisibility = {
    Allahakbar = false,
    EnemyFollow = false,
    Bouncy = false,
}

function Enemies:new()
    Allahakbar:new()
    EnemyFollow:new()
    Spawner:new()

    self.bouncyEnemy = nil
end

function Enemies:update(dt)
    Spawner:update(dt)
    self:updateEnemies(dt)
    self:updateBouncyEnemy(dt)
end

function Enemies:draw()
    self:drawEnemies()
    self:drawAllahakbar()
    self:drawBouncyEnemy()
end

function Enemies:updateEnemies(dt)
    local updatedAllahakbar = false

    for _, enemy in ipairs(EnemyList) do
        enemy:update(dt)

        if enemy.type == "Allahakbar" then
            updatedAllahakbar = true
        end
    end

    if enemyVisibility.Allahakbar and not updatedAllahakbar then
        Allahakbar:update(dt)
    end
end

function Enemies:drawEnemies()
    for _, enemy in ipairs(EnemyList) do
        enemy:draw()
    end

    if enemyVisibility.Enemy then
        EnemyFollow:draw()
    end
end

function Enemies:drawAllahakbar()
    if enemyVisibility.Allahakbar then
        Allahakbar:draw()
    end
end

function Enemies:updateBouncyEnemy(dt)
    if enemyVisibility.Bouncy and self.bouncyEnemy == nil then
        self.bouncyEnemy = Bouncy(GetPlayerPosition())
    end

    if self.bouncyEnemy then
        self.bouncyEnemy:update(dt, GetPlayerPosition())
    end
end

function Enemies:drawBouncyEnemy()
    if self.bouncyEnemy then
        self.bouncyEnemy:draw()
    end
end

-- Método para cambiar el estado de cualquier enemigo
function Enemies:toggleEnemy(enemyName, value)
    if enemyVisibility[enemyName] ~= nil then
        enemyVisibility[enemyName] = value

        -- Si se establece el valor en falso, destruir todos los enemigos de ese tipo
        if not value then
            DestroyEnemy(enemyName)
        end
    end
end

function Enemies:toggleEntity(entityName, isEnemy, value)
    local visibilityTable = isEnemy and enemyVisibility or PowerUpsVisibility
    local entityList = isEnemy and EnemyList or PowerUpsList

    if visibilityTable[entityName] ~= nil then
        visibilityTable[entityName] = value

        -- Si se establece el valor en falso, destruir todos los enemigos o power-ups de ese tipo
        if not value then
            DestroyEntity(entityName, entityList)
        end
    end
end

function DestroyEntity(entityType, entityList)
    for i, entity in ipairs(entityList) do
        if entity.type == entityType then
            table.remove(entityList, i)
        end
    end
end

function DestroyEnemy(enemyType)
    for i, enemy in ipairs(EnemyList) do
        if enemy.type == enemyType then
            table.remove(EnemyList, i)
            break
        end
    end
end

return Enemies
