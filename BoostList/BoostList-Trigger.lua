-- CHAT_MSG_WHISPER,CHAT_MSG_SYSTEM

function(event, msg, sender)
    if event == "CHAT_MSG_WHISPER" then
        -- Invalid whisper
        if string.sub(string.lower(msg), 0, 4) ~= "inv " then
            aura_env.SendInviteError(sender)
            
            return true
        end
        
        -- Format name
        local serverName = string.gsub(msg, "%W+", "")
        serverName = string.gsub(serverName, "%d+", "")
        serverName = string.lower(serverName)
        serverName = string.sub(serverName, 4)
        
        -- Invalid whisper, no server name given
        if string.len(serverName) == 0 then
            aura_env.SendInviteError(sender)
            
            return true
        end
        
        -- Invalid whisper, wrong server name
        local wrongServerName = true
        for k,v in pairs(aura_env.boosts) do
            if v == serverName then
                wrongServerName = false
            end
        end
        
        if wrongServerName then
            aura_env.SendInviteError(sender)
            
            return true
        end
        
        -- Add character and server to list
        aura_env.characters[sender] = serverName
        
        -- Invite player to group
        InviteUnit(sender)
        
    elseif event == "CHAT_MSG_SYSTEM" then
        local stringConstant = ERR_JOINED_GROUP_S
        
        if UnitInRaid("player") then
            stringConstant = ERR_RAID_MEMBER_ADDED_S
        end
        
        local pattern = gsub(stringConstant, "%%s", "(.+)")
        local characterName = strmatch(msg, pattern)
        
        if characterName and not aura_env.charactersCounted[characterName] then
            -- Add one to server amount
            local serverName = aura_env.characters[characterName]
            
            -- Sometimes names are appended with server name for some reason
            if not serverName then
                local realmName = GetRealmName()
                local characterNameWithServer = characterName .. "-" .. realmName
                
                serverName = aura_env.characters[characterNameWithServer]
            end
            
            aura_env.boosts[serverName] = aura_env.boosts[serverName] + 1
            
            -- Update total character count
            aura_env.total = aura_env.total + 1
            
            -- Save counted status of this character
            aura_env.charactersCounted[characterName] = true
        end
    end
    
    return true
end