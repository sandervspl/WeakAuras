function(event, msg, sender)
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
    -- serverName = serverName:sub(1, 1):upper() .. serverName:sub(2)

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

    -- Prevent duplicate characters
    local exists = false
    for k, character in pairs(characters) do
        if characterName == character then
            exists = true
        end
    end

    if exists then return false end

    -- Add character to list
    table.insert(aura_env.characters, characterName)

    -- Add one to server amount
    aura_env.players[serverName] = aura_env.players[serverName] + 1

    -- Sort list by characters amount
    -- function sortByAmountAndName(a, b)
    --     if (a[aura_env.constants.AMOUNT] == b[aura_env.constants.AMOUNT]) then
    --         return a[aura_env.constants.NAME] < b[aura_env.constants.NAME]
    --     else
    --         return a[aura_env.constants.AMOUNT] > b[aura_env.constants.AMOUNT]
    --     end
    -- end

    -- table.sort(aura_env.players, sortByAmountAndName)

    -- Update total character count
    aura_env.total = aura_env.total + 1

    print(aura_env.total, aura_env.players[serverName])

    -- Invite player to group
    InviteUnit(sender)

    return true
end
