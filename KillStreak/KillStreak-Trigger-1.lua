function(event, ...)
    if event == "PLAYER_ENTERING_BATTLEGROUND" then
        aura_env.streak = 0
        aura_env.streak_timed = 0
        aura_env.sound_id = -1
        aura_env.prev_kill_time = GetTime()
    else
        local timestamp, subevent, _, sourceGUID, _, _, _, destGUID = ...
        
        if subevent == "PARTY_KILL" and sourceGUID == UnitGUID("player") then
            aura_env.streak = aura_env.streak + 1
            
            local streak = aura_env.streak
            local now = GetTime()
            
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

            print("killstreak:", aura_env.streak)
        elseif subevent == "UNIT_DIED" then
            if destGUID == UnitGUID("player") then
                aura_env.streak = 0
            end
        end
    end
end
