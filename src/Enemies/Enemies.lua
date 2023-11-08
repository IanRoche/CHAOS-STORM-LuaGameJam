local Object = Object or require "lib.classic"
local ICanBeDestroyedInterface = require "src.ICabBeDestroyed"
local Allahakbar = require "src.Enemies.AllahAkbar"
local Enemy = require "src.Enemies.Enemy"
local Bouncy = require "src.Enemies.Bouncy"

local Enemies = Object:extend()
local Spawner = require "src.Enemies.Spawner"


EnemyList={}

-- Tabla para llevar un seguimiento de qué enemigos deben aparecer
 enemyVisibility = {
    Allahakbar = false,  -- Por defecto, aparece
    Enemy = false, 
    Bouncy=false,     -- Por defecto, aparece
}

function Enemies:new()
    
    Allahakbar:new()
    Enemy:new()
    Spawner:new()


    self.bouncyEnemy=nil
end

function Enemies:update(dt)
    Spawner:update(dt)

    local updatedAllahakbar = false  -- Bandera para controlar si se ha actualizado "Allahakbar"

    for _, enemy in ipairs(EnemyList) do
        enemy:update(dt)
        
        if enemy.type == "Allahakbar" then
            updatedAllahakbar = true
        end
    end

    if enemyVisibility.Allahakbar and not updatedAllahakbar then
        Allahakbar:update(dt)
    end

    if enemyVisibility.Enemy then
        Enemy:update(dt)
    end

    


    --BOUNCY
     -- Crear un "Bouncy" si es necesario
     if enemyVisibility.Bouncy and self.bouncyEnemy == nil then
        --print("new".. GetPlayerPosition())
        self.bouncyEnemy = Bouncy(GetPlayerPosition())  -- Ejemplo de posición inicial
    end

    -- Actualizar el "Bouncy" si existe
    if self.bouncyEnemy then
        self.bouncyEnemy:update(dt,GetPlayerPosition())
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
    print(enemyName, value)
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
    print(entityName, value)
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
