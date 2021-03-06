function(event, ...)
    if not ... then return false end

    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName = ...

    if subevent == "SPELL_CAST_SUCCESS" and sourceGUID == UnitGUID("player") and aura_env.isMonkDamageSpell(spellId) then
        aura_env.prevSpellId = spellId
    end

    return true
end
