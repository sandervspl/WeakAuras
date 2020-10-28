aura_env.streak = 0
aura_env.streak_timed = 0
aura_env.sound_id = -1
aura_env.prev_kill_time = GetTime()
aura_env.sound_path = {
    streak = "Interface\\AddOns\\KillingStreaks\\Dota",
    timed = "Interface\\AddOns\\KillingStreaks\\DotaTimed",
}
aura_env.StopSound = function()
    if aura_env.sound_id >= 0 then
        StopSound(aura_env.sound_id)
    end
end
