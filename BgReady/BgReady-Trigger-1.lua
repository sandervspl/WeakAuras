-- CHAT_MSG_BG_SYSTEM_NEUTRAL

function(evt, msg)
    -- 30 second until start
    if string.match(msg, "30 seconds") and not aura_env.started_30 then
        aura_env.started_30 = true
        aura_env.start_time = GetTime()
    end
    
    -- start of bg
    if string.match(msg, "begun") then
        aura_env.reset()
    end
    
    return false
end