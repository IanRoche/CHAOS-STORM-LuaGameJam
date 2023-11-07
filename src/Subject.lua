local Subject = {}

function Subject:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.observers = {}
    return o
end

function Subject:addObserver(observer)
    table.insert(self.observers, observer)
end

function Subject:removeObserver(observer)
    for i, obs in ipairs(self.observers) do
        if obs == observer then
            table.remove(self.observers, i)
            return
        end
    end
end

function Subject:notifyObservers(value)
    for _, observer in ipairs(self.observers) do
        observer:updateValue(value)
    end
end

return Subject
