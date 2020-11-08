function(states, event, ...)
    local now = GetTime()

    if event == "NAME_PLATE_UNIT_ADDED" then
        local unit = ...

        if unit and UnitIsPlayer(unit) and UnitIsEnemy(unit, "player") then
            local guid = UnitGUID(unit)

            aura_env.nameplates[unit] = guid
            aura_env.guids[guid] = unit

            for k, state in pairs(aura_env.temp) do
                -- Show
                if state.guid == guid and state.expirationTime > now then
                    state.unit = unit
                    state.show = true
                    state.changed = true
                    states[k] = state
                    
                    -- Remove
                elseif state.expirationTime < now then
                    state.changed = true
                    state.show = false
                    aura_env.temp[k] = nil
                end
            end
        end

    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        local unit = ...

        if unit then
            local guid = UnitGUID(unit)
            
            if guid then
                aura_env.nameplates[unit] = nil
                aura_env.guids[guid] = nil
                
                for k, state in pairs(states) do
                    if state.guid == guid then
                        aura_env.temp[k] = state
                        state.show = false
                        state.changed = true
                    end
                end
            end
        end

        -- Received data from party member, add it to states
    elseif event == "CHAT_MSG_ADDON" then
        local prefix, text, _, sender = ...
        
        if not prefix or prefix ~= aura_env.prefix then
            return true
        end
        
        local playerName = UnitName("player")
        sender = string.match(sender, "(.+)-")
        
        if not sender or sender == playerName then
            return true
        end
        
        local key, duration, expirationTime, progressType, icon, guid, unit, spellSchool, spellName = strsplit("|", text)
        expirationTime = tonumber(expirationTime)
        duration = tonumber(duration)
        icon = (spell.icon and type(tonumber(spell.icon)) == "number") and tonumber(spell.icon) or tonumber(icon)
        spellSchool = tonumber(spellSchool)

        -- Older versions did not send spellName
        if not spellName then
            spellName = key:gsub("-", ""):gsub("Player", ""):gsub("%d", ""):gsub("%u", "")
        end

        -- Current version sends spellName
        if aura_env.spells[spellName] and not aura_env.spells[spellName].active then
            return true
        end

        if not states[key] or (
            states[key]
            and states[key].expirationTime
            and now > states[key].expirationTime
        ) then
            states[key] = {
                changed = true,
                show = true,
                progressType = progressType,
                autoHide = true,
                duration = duration,
                expirationTime = now + duration,
                icon = icon,
                guid = guid,
                unit = aura_env.guids[guid],
                spellSchool = spellSchool,
            }

            -- print("new data received from", sender)
        end
        
    else
        local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId_BROKEN_ALWAYS_ZERO, spellName, spellSchool = ...
        local spell

        if subevent == "SPELL_CAST_SUCCESS" then
            -- Get spell from options
            spellName = string.lower(spellName)

            if sourceGUID then
                spell = aura_env.spells[spellName]
            end

            if not spell then
                return true
            end

            if spell.cooldown and spell.cooldown > 0 then
                -- SPELL INTERACTIONS --
                -- Do these first so we don't remove the spell after their interaction
                if spellName == aura_env.spellInteractions.preparation then
                    -- Reset all rogue spells
                    for key2, state in pairs(states) do
                        local compareKey = aura_env.fixGUID(key2)

                        if string.find(compareKey, sourceGUID) then
                            local isRogueSpell = false

                            for k, rogueSpell in pairs(aura_env.rogueSpells) do
                                if string.find(key2, rogueSpell) then
                                    isRogueSpell = true
                                end
                            end

                            if isRogueSpell then
                                state.show = false
                                state.changed = true
                                aura_env.temp[key2] = nil
                            end
                        end
                    end
                end

                if spellName == aura_env.spellInteractions.coldSnap then
                    -- Reset all frost spells
                    for key2, state in pairs(states) do
                        local compareKey = aura_env.fixGUID(key2)

                        if string.find(compareKey, sourceGUID) and state.spellSchool == 16 then
                            state.show = false
                            state.changed = true
                            aura_env.temp[key2] = nil
                        end
                    end
                end

                -- Add spell to state
                local key = sourceGUID..spellName
                local data = {
                    changed = true,
                    show = true,
                    duration = spell.cooldown,
                    expirationTime = now + spell.cooldown,
                    icon = (spell.icon and type(tonumber(spell.icon)) == "number") and tonumber(spell.icon) or spell.icon,
                    progressType = "timed",
                    autoHide = true,
                    guid = sourceGUID,
                    unit = aura_env.guids[sourceGUID],
                    spellSchool = spellSchool,
                }

                if spell.active then
                    if aura_env.guids[sourceGUID] then
                        states[key] = data
                    else
                        aura_env.temp[key] = data
                    end
                end

                -- Share data to party or raid members
                if GetNumGroupMembers() > 0 then
                    local dataStr = key.."|"..data.duration.."|"..data.expirationTime.."|"..data.progressType.."|"..data.icon.."|"..data.guid.."|"..data.spellSchool.."|"..spellName
                    local channel = "PARTY"
                    
                    if UnitInRaid("player") then
                        channel = "RAID"
                    end

                    if UnitInBattleground("player") > 0 then
                        channel = "INSTANCE_CHAT"
                    end

                    C_ChatInfo.SendAddonMessage(aura_env.prefix, dataStr, channel)
                end
            else
                print("Error: Something wrong with Spell:", spellName, "cooldown:", spell.cooldown)
            end
        end
    end
    
    return true
end

