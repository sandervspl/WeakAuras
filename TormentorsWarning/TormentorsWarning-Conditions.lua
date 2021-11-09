function()
    local _, current_hours, current_minutes = GameTime_GetTime()
    local remainingMins = 60 - current_minutes
    
    local hours = current_hours % 2 == 1 and current_hours + 1 or current_hours
    local mins = current_hours % 2 == 1 and remainingMins + 5 or 5 - current_minutes
    
    return mins, hours
end
