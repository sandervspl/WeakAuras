-- CHAT_MSG_WHISPER,CHAT_MSG_SYSTEM,COMBAT_LOG_EVENT_UNFILTERED

function(event, msg, sender)
    if event == "CHAT_MSG_WHISPER" then
        local characterName = sender:match("(.+)-")

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
        for _,v in pairs({"fire", "gehe", "mogr", "luci", "gole"}) do
            if v == serverName then
                wrongServerName = false
            end
        end

        if wrongServerName then
            aura_env.SendInviteError(sender)

            return true
        end

        if GetNumGroupMembers() >= 40 then
            aura_env.SendWhisper("Group is currently full, please try again in a minute.", sender)

            return true
        end

        -- Add character and server to list
        aura_env.characters[characterName] = serverName

        -- Invite player to group
        InviteUnit(sender)

        return true
    
    elseif event == "CHAT_MSG_SYSTEM" then
        local stringConstant = ERR_JOINED_GROUP_S

        if UnitInRaid("player") then
            stringConstant = ERR_RAID_MEMBER_ADDED_S
        end

        local pattern = gsub(stringConstant, "%%s", "(.+)")
        local characterName = strmatch(msg, pattern)

        if characterName then
            if aura_env.charactersCounted[characterName] ~= nil then
                return true
            end

            -- Add one to server amount
            local serverName = aura_env.characters[characterName]
            aura_env.boosts[serverName] = aura_env.boosts[serverName] + 1

            -- Update total character count
            aura_env.total = aura_env.total + 1

            -- Save counted status of this character
            aura_env.charactersCounted[characterName] = true

            return true
       end
    
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local subevent = sender

        if subevent == "UNIT_DIED" then
            for i=1,GetNumSubgroupMembers(LE_PARTY_CATEGORY_HOME) do
                local member = "party"..i
                local name = UnitName(member)
                
                if UnitExists(member) then
                    if not CheckInteractDistance(member, 1) then
                        aura_env.SendWhisper("You are out of inspect range to the pusher. Please get closer to the pusher so we can inspect your honor kills.", name)
                    elseif CanInspect(member) then
                        NotifyInspect(member)
                        RequestInspectHonorData()
                        
                        local todayHK = GetInspectHonorData()

                        if todayHK == 10 then
                            aura_env.SendWhisper("You are approaching 15 kills - prepare to log the next character.", name)
                        end
                        
                        if todayHK >= 15 then
                            aura_env.SendWhisper("You now have 15 hks. Thank you for boosting and please log the next character.", name)
                        end
                    end
                end
            end
        end
    end

    return true
end
