-- COMBAT_LOG_EVENT_UNFILTERED,GROUP_ROSTER_UPDATE,PLAYER_ENTERING_WORLD,RAID_INSTANCE_WELCOME

function(states, event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId_BROKEN_ALWAYS_ZERO, spellName = ...

    if event == "RAID_INSTANCE_WELCOME" then
        -- Reset data
        WeakAurasSaved["displays"][aura_env.id].warriors = {}
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        if subevent == "SPELL_CAST_SUCCESS" then
            if spellName == aura_env.spellName then
                local expirationTimeSpell = GetTime() + aura_env.spellCd

                states[sourceGUID].changed = true
                states[sourceGUID].expirationTimeSpell = expirationTimeSpell

                -- Check if we need to update the bar duration
                if not states[sourceGUID].expirationTime or (states[sourceGUID].expirationTime and expirationTimeSpell > states[sourceGUID].expirationTime) then
                    states[sourceGUID].duration = aura_env.spellCd
                    states[sourceGUID].expirationTime = expirationTimeSpell
                end

                -- Save to db
                if not aura_env.warriors[sourceGUID] then
                    aura_env.warriors[sourceGUID] = {}
                    aura_env.warriors[sourceGUID].name = sourceName
                end
                aura_env.warriors[sourceGUID] = states[sourceGUID]

                WeakAurasSaved["displays"][aura_env.id].warriors = aura_env.warriors
            elseif aura_env.spellIsPot(spellName) then
                local expirationTimePot = GetTime() + aura_env.potCd

                states[sourceGUID].changed = true
                states[sourceGUID].expirationTimePot = expirationTimePot

                -- Check if we need to update the bar duration
                if not states[sourceGUID].expirationTime or (states[sourceGUID].expirationTime and expirationTimePot > states[sourceGUID].expirationTime) then
                    states[sourceGUID].duration = aura_env.potCd
                    states[sourceGUID].expirationTime = expirationTimePot
                end

                -- Save to db
                if not aura_env.warriors[sourceGUID] then
                    aura_env.warriors[sourceGUID] = {}
                    aura_env.warriors[sourceGUID].name = sourceName
                end
                aura_env.warriors[sourceGUID] = states[sourceGUID]

                WeakAurasSaved["displays"][aura_env.id].warriors = aura_env.warriors
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
