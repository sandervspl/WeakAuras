function()
    local playerName = WA_ClassColorName("player")
    local streakText = aura_env.streak_text[aura_env.streak]
    local streakTimedText = aura_env.streak_timed_text[aura_env.streak_timed]

    if streakText and streakTimedText then
        if aura_env.streak_timed < 4 then
            streakTimedText = "|nwith a " .. streakTimedText
        elseif aura_env.streak_timed == 4 then
            streakTimedText = "|nwith an " .. streakTimedText
        end

        return playerName .. " is " .. streakText .. streakTimedText
    elseif streakText and not streakTimedText then
        return playerName .. " is " .. streakText
    elseif not streakText and streakTimedText then
        return playerName .. " is " .. streakTimedText
    else
        return ""
    end
end
