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
aura_env.streak_text[3] = "on a |cFF00FF41killing spree|r"
aura_env.streak_text[4] = "|cFF5F00BEdominating|r"
aura_env.streak_text[5] = "on a |cFFFF0081mega kill|r streak"
aura_env.streak_text[6] = "|cFFFF8100unstoppable|r"
aura_env.streak_text[7] = "|cFF818100wicked sick|r"
aura_env.streak_text[8] = "on a |cFFFF81FFmonster kill|r streak"
aura_env.streak_text[9] = "|cFFFF0000GODLIKE|r"
aura_env.streak_text[10] = "beyond |cFFFF8100GODLIKE someone kill them!!|r"
aura_env.streak_timed_text[2] = "double kill!"
aura_env.streak_timed_text[3] = "TRIPLE kill!"
aura_env.streak_timed_text[4] = "ULTRA KILL!"
aura_env.streak_timed_text[5] = "|cFFFF0000RAMPAGE!!!|r"
