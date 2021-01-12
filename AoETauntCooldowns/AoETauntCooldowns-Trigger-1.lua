-- COMBAT_LOG_EVENT_UNFILTERED,GROUP_ROSTER_UPDATE,PLAYER_ENTERING_WORLD

function(states, event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId_BROKEN_ALWAYS_ZERO, spellName = ...

    if subevent == "SPELL_CAST_SUCCESS" then
        if spellName == aura_env.spellName then
            states[sourceGUID].changed = true
            states[sourceGUID].expirationTimeSpell = GetTime() + aura_env.spellCd

            local shoutExpirationTime = GetTime() + aura_env.spellCd

            if not states[sourceGUID].expirationTime or (states[sourceGUID].expirationTime and shoutExpirationTime > states[sourceGUID].expirationTime) then
                states[sourceGUID].duration = aura_env.spellCd
                states[sourceGUID].expirationTime = shoutExpirationTime
            end
        elseif strfind(spellName, " Potion") then
            states[sourceGUID].changed = true
            states[sourceGUID].expirationTimePot = GetTime() + aura_env.potCd

            local potExpirationTime = GetTime() + aura_env.potCd

            if not states[sourceGUID].expirationTime or (states[sourceGUID].expirationTime and potExpirationTime > states[sourceGUID].expirationTime) then
                states[sourceGUID].duration = aura_env.potCd
                states[sourceGUID].expirationTime = potExpirationTime
            end

        end
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
                        name = UnitName(unit),
                        expirationTimeSpell = GetTime(),
                        expirationTimePot = GetTime(),
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
