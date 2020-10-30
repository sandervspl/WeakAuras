-- ZONE_CHANGED,ZONE_CHANGED_NEW_AREA,PLAYER_ENTERING_WORLD,GROUP_JOINED,GROUP_LEFT

function(event, ...)
    local subzone = string.lower(GetSubZoneText())
    local zone = string.lower(GetZoneText())
    local killzone = aura_env.zones[2]
    local isInKillZone = subzone == killzone or zone == killzone
    local useSay = aura_env.config.messageChannel == 2
    
    local msgPrefix = useSay and "/say " or "/whisper " .. aura_env.config.leader .. " "
    aura_env.invButtonFrame:SetAttribute("macrotext1", msgPrefix .. aura_env.trim(aura_env.config.msg))
    
    return not IsInGroup() and isInKillZone and (useSay or not aura_env.config.autoSendWhisper)
end
