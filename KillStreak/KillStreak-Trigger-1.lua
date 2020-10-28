-- COMBAT_LOG_EVENT_UNFILTERED

function(event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName = ...
    
    if subevent == "PARTY_KILL" and sourceGUID == UnitGUID("player") and not UnitIsUnit(destName, "pet") then
        if not UnitIsDead("player") then
            aura_env.streak = aura_env.streak + 1
        end
        
        local streak = aura_env.streak
        local now = GetTime()

        if streak > 0 and aura_env.streak_timed == 0 then
            aura_env.streak_timed = aura_env.streak_timed + 1
        end
        
        if now - aura_env.prev_kill_time < 10 then
            aura_env.streak_timed = aura_env.streak_timed + 1
            local streak_timed = aura_env.streak_timed

            if streak_timed >= 2 then
                if streak_timed >= 5 then
                    _, sound_id = PlaySoundFile(aura_env.sound_path.timed .. "\\5.mp3", "master")
                    aura_env.StopSound()
                else
                    _, sound_id = PlaySoundFile(aura_env.sound_path.timed .. "\\" .. streak_timed ..".mp3", "master")
                    aura_env.StopSound()
                end
            end
        elseif streak >= 3 then
            aura_env.streak_timed = 0

            if streak >= 10 then
                _, sound_id = PlaySoundFile(aura_env.sound_path.streak .. "\\10.mp3", "master")
                aura_env.StopSound()
            else
                _, sound_id = PlaySoundFile(aura_env.sound_path.streak .. "\\" .. streak ..".mp3", "master")
                aura_env.StopSound()
            end
        end

        aura_env.prev_kill_time = now
        aura_env.sound_id = sound_id

        print("Killstreak:", aura_env.streak)

        return aura_env.streak >= 3 or aura_env.streak_timed >= 2
    elseif subevent == "UNIT_DIED" then
        if destGUID == UnitGUID("player") then
            aura_env.streak = 0
        end
    end

    return false
end
