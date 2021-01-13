-- COMBAT_LOG_EVENT_UNFILTERED

function(event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName = ...

    if subevent == "UNIT_DIED" then
        local unitDiedName = string.lower(destName)

        for i,unit in ipairs(aura_env.config.units) do
            if unit.enabled then
                local unitName = string.lower(unit.name)

                if strfind(unitName, "/") then
                    local names = aura_env.split(unitName, "/")

                    for j,name in ipairs(names) do
                        if unitDiedName == name and aura_env.unitKills[unitName] < unit.amount then
                            aura_env.unitKills[unitName] = aura_env.unitKills[unitName] + 1
                            WeakAurasSaved["displays"][aura_env.id].unitKills[unitName] = aura_env.unitKills[unitName]
                        end
                    end
                else
                    if unitDiedName == unitName and aura_env.unitKills[unitName] < unit.amount then
                        aura_env.unitKills[unitName] = aura_env.unitKills[unitName] + 1
                        WeakAurasSaved["displays"][aura_env.id].unitKills[unitName] = aura_env.unitKills[unitName]
                    end
                end
            end
        end
    end

    return true
end
