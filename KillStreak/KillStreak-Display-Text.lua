function()
    local playerName = WA_ClassColorName("player")
    local streakText = aura_env.streak_text[aura_env.streak]
    local streakTimedText = aura_env.streak_timed_text[aura_env.streak_timed]

    if aura_env.streak > 10 then
        streakText = aura_env.streak_text[10]
    end

    if aura_env.streak_timed > 5 then
        streakTimedText = aura_env.streak_timed_text[5]
    end

    if streakText and streakTimedText then
        if aura_env.streak_timed < 4 then
            streakTimedText = "|nwith a " .. streakTimedText
        elseif aura_env.streak_timed == 4 then
            streakTimedText = "|nwith an " .. streakTimedText
        else
            streakTimedText = "|n" .. streakTimedText
        end

        return playerName .. " is " .. streakText.str .. streakTimedText
    elseif streakText and not streakTimedText then
        return playerName .. " is " .. streakText.str
    elseif not streakText and streakTimedText then
        if aura_env.streak_timed >= 5 then
            return playerName .. streakTimedText
        elseif aura_env.streak_timed == 4 then
            return playerName .. " got an " .. streakTimedText
        else
            return playerName .. " got a " .. streakTimedText
        end
    else
        return ""
    end
end
