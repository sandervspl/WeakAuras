-- CLEU:SPELL_DAMAGE, CLEU:SPELL_AURA_APPLIED , CLEU:SPELL_AURA_REMOVED,WA_DELAYED_PLAYER_ENTERING_WORLD,UNIT_AURA

function(allstates, event, _, subevent, _, sourceGUID, sourceName, sourceFlags, _, destGUID, destName, destFlags, _, spellId)    
    function updateCount()
        aura_env.count = 0
        for _ in pairs(allstates) do aura_env.count = aura_env.count + 1 end
    end
    
    updateCount()
    
    if (spellId == 100780 or spellId == 100784 or spellId == 185099 or spellId == 261947 or spellId == 228287) then
        if sourceGUID == WeakAuras.myGUID and (subevent == "SPELL_DAMAGE" or subevent == "SPELL_AURA_APPLIED" or event == "UNIT_AURA") then
            if allstates[destGUID] ~= nil then
                allstates[destGUID].timer:Cancel()
            end

            allstates[destGUID] = {
                show = true,
                changed = true,
                progressType = "timed",
                duration = 20,
                autoHide = true,
                timer = C_Timer.NewTimer(20, updateCount),
            }

            updateCount()
        end
    end

    return true
end
