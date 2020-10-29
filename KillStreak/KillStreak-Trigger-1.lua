-- COMBAT_LOG_EVENT_UNFILTERED

function(event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName = ...
    
    if subevent == "PARTY_KILL" and sourceGUID == UnitGUID("player") then
        if not UnitIsDead("player") then
            aura_env.streak = aura_env.streak + 1
        end
        
        local streak = aura_env.streak
        local now = GetTime()
        local isTimedKill = false

        -- Reset timed streak
        if now - aura_env.prev_kill_time > aura_env.max_time_between_kills then
            aura_env.streak_timed = 0
        end

        -- First kill is also a timed streak
        -- Or we continue our timed streak
        if (streak > 0 and aura_env.streak_timed == 0) or (now - aura_env.prev_kill_time < aura_env.max_time_between_kills) then
            aura_env.streak_timed = aura_env.streak_timed + 1
            isTimedKill = true
        end

        local streak_timed = aura_env.streak_timed

        -- Normal streak sound + optional timed streak sound
        if streak >= 3 then
            if streak >= 10 then
                aura_env.PlaySound(aura_env.sound_path.streak .. "\\10.mp3")
            else
                aura_env.PlaySound(aura_env.sound_path.streak .. "\\" .. streak ..".mp3")
            end

            -- Queue timed kill sound
            if isTimedKill and streak_timed >= 2 then
                local _streak = streak < 10 and streak or 10
                aura_env.next_sound_time = now + aura_env.streak_text[_streak].duration
            end

        -- Timed streak sound
        elseif streak_timed >= 2 then
            if streak_timed >= 5 then
                aura_env.PlaySound(aura_env.sound_path.timed .. "\\5.mp3")
            else
                aura_env.PlaySound(aura_env.sound_path.timed .. "\\" .. streak_timed ..".mp3")
            end
        end

        -- Set important values for next cycles
        aura_env.prev_kill_time = now

        -- Debug
        print("Killstreak:", streak, " Timed streak:", streak_timed)

        -- Determine if we show text
        return aura_env.streak >= 3 or aura_env.streak_timed >= 2
    elseif subevent == "UNIT_DIED" then
        if destGUID == UnitGUID("player") then
            aura_env.streak = 0
        end
    end

    return false
end
