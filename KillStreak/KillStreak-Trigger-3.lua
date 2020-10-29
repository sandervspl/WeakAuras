function()
    local now = GetTime()

    if aura_env.next_sound_time ~= nil and now >= aura_env.next_sound_time then
        if aura_env.streak_timed >= 5 then
            aura_env.PlaySound(aura_env.sound_path.timed .. "\\5.mp3")
        else
            aura_env.PlaySound(aura_env.sound_path.timed .. "\\" .. aura_env.streak_timed ..".mp3")
        end

        aura_env.next_sound_time = nil
    end
end
