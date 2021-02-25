aura_env.last_time = GetTime()

aura_env.spellName = "Challenging Shout"
aura_env.spellCd = 10 * 60 -- 10 min cd

aura_env.potCd = 2 * 60 -- 2 min cd

aura_env.spellIsPot = function(spellName)
    local pots = {
        "Living Free Action",
        "Purification",
        "Stoneshield",
        "Greater Stoneshield",
        "Healing Potion",
        "Mighty Rage",
        "Invulnerability",
        "Invisibility",
        "Lesser Invisibility",
        "Speed",
        "Restoration",
        "Great Rage",
        "Free Action",
        "Rage",
        "Resistance",
    }

    -- Spell Protection potions
    if strfind(spellName, "Protection") then
        return true
    end

    for _,name in pairs(pots) do
        if spellName == name then
            return true
        end
    end

    return false
end

aura_env.reset = function()
    for i,warrior in ipairs(aura_env.warriors) do
        aura_env.warriors[warrior] = {}
        WeakAurasSaved["displays"][aura_env.id].warriors[warrior] = {}
    end
end

aura_env.warriors = aura_env.warriors or WeakAurasSaved["displays"][aura_env.id].warriors or {}
