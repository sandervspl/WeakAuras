-- RESET_NAXXRAMAS_CHECKLIST

function(event, ...)
    -- Prevent WA from triggering this
    if ... then
        for i,unit in ipairs(aura_env.config.units) do
            aura_env.unitKills[unit.name] = 0
            WeakAurasSaved["displays"][aura_env.id].unitKills[unit.name] = 0
        end
    end
end
