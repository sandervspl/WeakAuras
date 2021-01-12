function()
    local now = GetTime()
    
    -- 10 seconds left
    if aura_env.started_30 and not aura_env.started_10 and now - aura_env.start_time >= 20 then
        aura_env.started_10 = true
        aura_env.started_30 = false
        aura_env.prev_count_time = now
        
        return true
    end
    
    -- count down each second
    if aura_env.countdown > 0 and aura_env.started_10 and now - aura_env.prev_count_time >= 1 then
        aura_env.prev_count_time = now
        aura_env.countdown = aura_env.countdown - 1
        
        return true
    end
    
    return false
end

