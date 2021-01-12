function(event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName = ...

    if (subevent == "UNIT_DIED") then
        local unitDiedName = string.lower(destName)

        for i,unit in ipairs(aura_env.config.units) do
            if unit.enabled then
                if strfind(unit.name, "/") then
                    local names = aura_env.split(unit.name, "/")

                    for j,name in ipairs(names) do
                        if unitDiedName == name and aura_env.unitKills[unit.name] < unit.amount then
                            aura_env.unitKills[unit.name] = aura_env.unitKills[unit.name] + 1
                        end
                    end
                else
                    if unitDiedName == unit.name and aura_env.unitKills[unit.name] < unit.amount then
                        aura_env.unitKills[unit.name] = aura_env.unitKills[unit.name] + 1
                    end
                end
            end
        end
    end

    return true
end
