if not WeakAurasSaved['displays'][aura_env.id].saved then
    WeakAurasSaved['displays'][aura_env.id].saved = {}
end

aura_env.saved = aura_env.saved or WeakAurasSaved['displays'][aura_env.id].saved or {}

aura_env.getOddHour = function()
    local _, current_hours = GameTime_GetTime()
    local hour = current_hours % 2 == 0 and current_hours + 1 or current_hours

    return hour
end

aura_env.addSaved = function()
    local hour = aura_env.getOddHour()

    aura_env.saved[1] = hour
    WeakAurasSaved['displays'][aura_env.id].saved = aura_env.saved
end

aura_env.isSaved = function()
    local hour = aura_env.getOddHour()

    return aura_env.saved[1] == hour
end
