-- PLAYER_ENTERING_BATTLEGROUND

function()
    aura_env.streak = 0
    aura_env.streak_timed = 0
    aura_env.sound_id = -1
    aura_env.prev_kill_time = GetTime()
end
