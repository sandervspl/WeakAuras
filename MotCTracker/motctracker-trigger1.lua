-- UNIT_AURA,CLEU:SPELL_DAMAGE,CLEU:SPELL_AURA_APPLIED

function(allStates, event, _, subevent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId)
    function updateCount()
        aura_env.count = 0
    
        for _ in pairs(allStates) do
            aura_env.count = aura_env.count + 1
        end
    end
    
    updateCount()

    local isMotCSpell = spellId == 100784 or spellId == 100780 or spellId == 228287 or spellId == 261947 or spellId == 185099
    local isAuraEvent = subevent == "SPELL_DAMAGE" or subevent == "SPELL_AURA_APPLIED" or event == "UNIT_AURA"
    
    if isMotCSpell and sourceGUID == WeakAuras.myGUID and isAuraEvent then
        if allStates[destGUID] ~= nil then
            allStates[destGUID].timer:Cancel()
        end

        allStates[destGUID] = {
            show = true,
            changed = true,
            progressType = "timed",
            duration = 20,
            autoHide = true,
            timer = C_Timer.NewTimer(20, updateCount),
        }

        updateCount()
    end

    return true
end
