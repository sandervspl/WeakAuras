function(event, msg, sender)
    if event == "CHAT_MSG_WHISPER" then
        local characterName = sender:match("(.+)-")
        local faction = UnitFactionGroup("player")
        local lang = faction == "Horde" and "orcish" or "common"

        function SendWhisper(str)
            SendChatMessage(str, "WHISPER", lang, sender)
        end

        function SendInviteError()
            SendWhisper("Error: Please add your server name (fire, gehe, mogr, luci, gole) to your whisper. Example: 'inv fire'")
        end

        -- Invalid whisper
        if string.sub(string.lower(msg), 0, 4) ~= "inv " then
            SendInviteError()
            
            return false
        end

        -- Format name
        local serverName = string.gsub(msg, "%W+", "")
        serverName = string.gsub(serverName, "%d+", "")
        serverName = string.lower(serverName)
        serverName = string.sub(serverName, 4)

        -- Invalid whisper, no server name given
        if string.len(serverName) == 0 then
            SendInviteError()

            return false
        end

        -- Invalid whisper, wrong server name
        local wrongServerName = true
        for _,v in pairs({"fire", "gehe", "mogr", "luci", "gole"}) do
            if v == serverName then
                wrongServerName = false
            end
        end

        if wrongServerName then
            SendInviteError()

            return false
        end

        -- Add character and server to list
        aura_env.characters[characterName] = serverName

        -- Invite player to group
        InviteUnit(sender)

        return true
    
    elseif event == "CHAT_MSG_SYSTEM" then
        local pattern = gsub(ERR_JOINED_GROUP_S, "%%s", "(.+)")
        local characterName = strmatch(msg, pattern)

        if aura_env.charactersCounted[characterName] ~= nil then
            return true
        end

        if characterName then
            -- Add one to server amount
            local serverName = aura_env.characters[characterName]
            aura_env.boosts[serverName] = aura_env.boosts[serverName] + 1

            -- Update total character count
            aura_env.total = aura_env.total + 1

            -- Save counted status of this character
            aura_env.charactersCounted[characterName] = true

            -- Sort list by characters amount
            -- function sortByAmountAndName(a, b)
            --     if (a[aura_env.constants.AMOUNT] == b[aura_env.constants.AMOUNT]) then
            --         return a[aura_env.constants.NAME] < b[aura_env.constants.NAME]
            --     else
            --         return a[aura_env.constants.AMOUNT] > b[aura_env.constants.AMOUNT]
            --     end
            -- end

            -- table.sort(aura_env.boosts, sortByAmountAndName)

            return true
       end
    end

    return false
end
