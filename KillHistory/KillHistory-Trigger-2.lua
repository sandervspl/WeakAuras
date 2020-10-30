function(states, event, ...)
    local _, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName = ...
    local enemyColorName = aura_env.enemies[destName]

    if not enemyColorName then
        enemyColorName = destName
    end

    if subevent == "PARTY_KILL" then
        local data = {
            changed = true,
            show = true,
            name = WA_ClassColorName(sourceName) .. " killed " .. enemyColorName,
        }

        -- Move state1 to state2, state2 to state3, etc.
        if table.getn(states) > 0 then
            local tempState = states[1]
            states[1] = data

            if table.getn(states) >= 5 then
               table.remove(states, 5)
            end

            local statesLen = table.getn(states)
            local max = statesLen + 1

            if statesLen >= 5 then
               statesLen = 5
            end

            for i = 2, max do
               tempState.changed = true

               if i == 5 then
                  states[i] = tempState
               else
                  local temp2state = states[i]
                  states[i] = tempState
                  tempState = temp2state
               end
            end
         else
            table.insert(states, data)
         end
    end

    return true
end
