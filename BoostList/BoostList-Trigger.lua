-- CHAT_MSG_WHISPER,CHAT_MSG_SYSTEM

function(event, msg, sender)
    if event == "CHAT_MSG_WHISPER" then
        -- Invalid whisper
        if string.sub(string.lower(msg), 0, 4) ~= "inv " then
            aura_env.SendInviteError(sender)
            
            return true
        end
        
        -- Format name
        local boosterName = string.gsub(msg, "%W+", "")
        boosterName = string.gsub(boosterName, "%d+", "")
        boosterName = string.lower(boosterName)
        boosterName = string.sub(boosterName, 4)
        
        -- Invalid whisper, no booster name given
        if string.len(boosterName) == 0 then
            aura_env.SendInviteError(sender)
            
            return true
        end

        -- Link booster to char name
        aura_env.charLinkList[sender] = boosterName

        -- Invite player to group
        InviteUnit(sender)

    elseif event == "CHAT_MSG_SYSTEM" then
        local joinGroupStr = ERR_JOINED_GROUP_S
        
        if UnitInRaid("player") then
            joinGroupStr = ERR_RAID_MEMBER_ADDED_S
        end
        
        local pattern = gsub(joinGroupStr, "%%s", "(.+)")
        local charName = strmatch(msg, pattern)
        
        if charName then
            local name = charName

            -- Try get data with realm name
            if not aura_env.charLinkList[name] then
                local realmName = GetRealmName()
                name = name .. "-" .. realmName
            end

            local boosterName = aura_env.charLinkList[name]

            if boosterName then
                -- Add one to server amount
                if aura_env.boosts[boosterName] ~= nil then
                    aura_env.boosts[boosterName] = aura_env.boosts[boosterName] + 1
                else
                    aura_env.boosts[boosterName] = 1
                end
                
                -- Update total character count
                aura_env.total = aura_env.total + 1
            end
        end
    end
    
    return true
end