-- COMBAT_LOG_EVENT_UNFILTERED,GROUP_ROSTER_UPDATE,PLAYER_ENTERING_WORLD

function(states, event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId_BROKEN_ALWAYS_ZERO, spellName = ...

    if subevent == "SPELL_CAST_SUCCESS" then
        if spellName == aura_env.spellName then
            local expirationTimeSpell = GetTime() + aura_env.spellCd
            states[sourceGUID].expirationTimeSpell = expirationTimeSpell

            if not states[sourceGUID].expirationTime or (states[sourceGUID].expirationTime and expirationTimeSpell > states[sourceGUID].expirationTime) then
                states[sourceGUID].changed = true
                states[sourceGUID].duration = aura_env.spellCd
                states[sourceGUID].expirationTime = expirationTimeSpell
            end
        elseif strfind(spellName, " Potion") then
            local expirationTimePot = GetTime() + aura_env.potCd
            states[sourceGUID].expirationTimePot = expirationTimePot

            if not states[sourceGUID].expirationTime or (states[sourceGUID].expirationTime and expirationTimePot > states[sourceGUID].expirationTime) then
                states[sourceGUID].changed = true
                states[sourceGUID].duration = aura_env.potCd
                states[sourceGUID].expirationTime = expirationTimePot
            end
        end

        aura_env.warriors[sourceGUID].name = sourceName
        aura_env.warriors[sourceGUID] = states[sourceGUID]
        WeakAurasSaved["displays"][aura_env.id].warriors = aura_env.warriors
    else
        local warGuids = {}

        for unit in WA_IterateGroupMembers() do
            local _,_,classId = UnitClass(unit)
            local guid = UnitGUID(unit)

            -- Add/remove warrior
            if classId == 1 then
                table.insert(warGuids, guid)

                -- Add to list
                if states[guid] == nil then
                    states[guid] = {
                        guid = guid,
                        changed = true,
                        show = true,
                        autoHide = false,
                        progressType = "timed",
                        name = aura_env.warriors[guid] and aura_env.warriors[guid].name or UnitName(unit),
                        expirationTimeSpell = aura_env.warriors[guid] and aura_env.warriors[guid].expirationTimeSpell or GetTime(),
                        expirationTimePot = aura_env.warriors[guid] and aura_env.warriors[guid].expirationTimePot or GetTime(),
                        expirationTime = aura_env.warriors[guid] and aura_env.warriors[guid].expirationTime or nil,
                        duration = aura_env.warriors[guid] and aura_env.warriors[guid].duration or nil,
                        isShout = false,
                        isPot = false,
                    }
                end
            end
        end

        -- Remove warriors not in group
        for key,state in pairs(states) do
            local found = false

            for _,guid in ipairs(warGuids) do
                if guid == state.guid then
                    found = true
                end
            end

            if not found then
                state.changed = true
                state.show = false
            end
        end
    end

    return true
end
