function(event, ...)
    local killzone = string.lower(aura_env.trim(aura_env.config.kill_location))
    
    if string.lower(GetSubZoneText()) == killzone or string.lower(GetZoneText()) == killzone then
        return true
    end
    
    return false
end
