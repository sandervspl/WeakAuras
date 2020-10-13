-- ZONE_CHANGED,ZONE_CHANGED_NEW_AREA,PLAYER_ENTERING_WORLD,PARTY_INVITE_REQUEST,PLAY_MOVIE,CINEMATIC_START

function(event, ...)
    if event == "PLAY_MOVIE" then
        MovieFrame:Hide()
    end
    
    if event == "CINEMATIC_START" then
        if CinematicFrame.isRealCinematic then
            StopCinematic()
        elseif CanCancelScene() then
            CancelScene()
        end
    end
    
    local subzone = string.lower(GetSubZoneText())
    local zone = string.lower(GetZoneText())
    
    local charRace = aura_env.config.char_race
    local triggerzone = aura_env.zones[1]
    local killzone = aura_env.zones[2]
    local isInTriggerZone = subzone == triggerzone or zone == triggerzone
    local isInKillZone = subzone == killzone or zone == killzone
    
    if isInTriggerZone or isInKillZone then
        if isInKillZone then
            -- Turn on PvP Flag
            SetPVP(1)
        end
        
        -- Send invite message
        if not aura_env.sentMsg and aura_env.config.leader ~= "" and not IsInGroup() then
            local useWhisper = aura_env.config.messageChannel == 1
            
            if (isInTriggerZone or isInKillZone) and useWhisper then
                SendChatMessage(aura_env.trim(aura_env.config.msg), "WHISPER", nil, aura_env.trim(aura_env.config.leader))
                
                aura_env.sentMsg = true
            end
        end
        
        -- Delete Hearthstone
        if aura_env.config.delete_hs then
            for i = 1,36 do
                local n = GetContainerItemLink(0, i)
                
                if n and string.find(n, "Hearthstone") then
                    PickupContainerItem(0, i)
                    DeleteCursorItem()
                end
            end
        end
        
        -- Accept party invite
        if event == "PARTY_INVITE_REQUEST" then
            AcceptGroup()
            StaticPopup_Hide("PARTY_INVITE")
        end
        
        return true
    end
    
    return false
end



