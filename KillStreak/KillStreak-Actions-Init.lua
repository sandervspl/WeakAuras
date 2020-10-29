aura_env.streak = 0
aura_env.streak_timed = 0
aura_env.sound_id = -1
aura_env.prev_kill_time = GetTime()
aura_env.next_sound_time = nil
aura_env.max_time_between_kills = 20
aura_env.sound_path = {
    streak = "Interface\\AddOns\\KillingStreaks\\Dota",
    timed = "Interface\\AddOns\\KillingStreaks\\DotaTimed",
}
aura_env.PlaySound = function(path)
    if aura_env.sound_id and aura_env.sound_id >= 0 then
        StopSound(aura_env.sound_id)
        aura_env.sound_id = -1
    end

    _, sound_id = PlaySoundFile(path, "master")
    aura_env.sound_id = sound_id
end
aura_env.streak_text = {}
aura_env.streak_text[3] = { str = "on a |cFF00FF41killing spree|r", duration = 2 }
aura_env.streak_text[4] = { str = "|cFF5F00BEdominating|r", duration = 2 }
aura_env.streak_text[5] = { str = "on a |cFFFF0081mega kill|r streak", duration = 2 }
aura_env.streak_text[6] = { str = "|cFFFF8100unstoppable|r", duration = 2 }
aura_env.streak_text[7] = { str = "|cFF818100wicked sick|r", duration = 2 }
aura_env.streak_text[8] = { str = "on a |cFFFF81FFmonster kill|r streak", duration = 2 }
aura_env.streak_text[9] = { str = "|cFFFF0000GODLIKE|r", duration = 2 }
aura_env.streak_text[10] = { str = "beyond |cFFFF8100GODLIKE someone kill them!!|r", duration = 2 }
aura_env.streak_timed_text = {}
aura_env.streak_timed_text[2] = "double kill!"
aura_env.streak_timed_text[3] = "TRIPLE kill!"
aura_env.streak_timed_text[4] = "ULTRA KILL!"
aura_env.streak_timed_text[5] = "|cFFFF0000RAMPAGE!!!|r"
