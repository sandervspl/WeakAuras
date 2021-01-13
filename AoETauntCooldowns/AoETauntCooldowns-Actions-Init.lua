aura_env.last_time = GetTime()

aura_env.spellName = "Challenging Shout"
aura_env.spellCd = 10 * 60 -- 10 min cd

aura_env.potCd = 2 * 60 -- 2 min cd

aura_env.warriors = aura_env.warriors or WeakAurasSaved["displays"][aura_env.id].warriors or {}
