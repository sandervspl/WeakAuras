function()
    local _, current_hours, current_minutes = GameTime_GetTime()

    if aura_env.isSaved() then
        return false
    end

    if (current_hours % 2 == 1 and current_minutes >= 60 - aura_env.config.warn_min) or (current_hours % 2 == 0 and current_minutes < 5)
    then
        aura_env.addSaved()
        return true
    end
end
