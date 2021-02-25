-- Every Frame

function()
    local now = GetTime()
    local str = ""

    if
        aura_env.state.expirationTimeSpell ~= nil
        and aura_env.state.expirationTimeSpell > now
        and aura_env.state.expirationTimeSpell - now <= aura_env.spellCd
    then
        local dt = aura_env.state.expirationTimeSpell - now
        local noSeconds = dt > 60
        local time = SecondsToTime(dt, noSeconds)

        str = time
    else
        str = "|cFF03fc03Ready|r"
    end

    if
        aura_env.state.expirationTimePot ~= nil
        and aura_env.state.expirationTimePot > now
        and aura_env.state.expirationTimePot - now <= aura_env.potCd
    then
        local dt = aura_env.state.expirationTimePot - now
        local noSeconds = dt > 60
        local time = SecondsToTime(dt, noSeconds)

        str = str .. " / |cFFeaf522" .. time .. "|r"
    else
        str = str .. " / |cFFeaf522Ready|r"
    end

    return str
end
