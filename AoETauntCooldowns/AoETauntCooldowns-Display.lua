-- Every Frame

function()
    local now = GetTime()
    local str = ""

    if aura_env.state.expirationTimeSpell ~= nil and aura_env.state.expirationTimeSpell > now then
        local delta = aura_env.state.expirationTimeSpell - now
        local noSeconds = delta > 60
        local time = SecondsToTime(delta, noSeconds)

        str = time
    else
        str = "|cFF03fc03Ready|r"
    end

    if aura_env.state.expirationTimePot ~= nil and aura_env.state.expirationTimePot > now then
        local delta = aura_env.state.expirationTimePot - now
        local noSeconds = delta > 60
        local time = SecondsToTime(delta, noSeconds)

        str = str .. " / |cFFeaf522" .. time .. "|r"
    else
        str = str .. " / |cFFeaf522Ready|r"
    end

    if (aura_env.state.expirationTimeSpell == nil or aura_env.state.expirationTimePot == nil) or now > aura_env.state.expirationTimeSpell and now > aura_env.state.expirationTimePot then
        str = "|cFF03fc03Ready|r / |cFFeaf522Ready|r"
    end

    return str
end
