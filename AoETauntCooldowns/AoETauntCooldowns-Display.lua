-- Every Frame

function()
    if aura_env.state.expirationTime ~= nil and aura_env.state.expirationTime > GetTime() then
        local delta = aura_env.state.expirationTime - GetTime() + 1
        local time = SecondsToTime(delta)

        if delta < 4 then
            time = "|cFFfc8803" .. time .. "|r"
        end

        return time
    else
        return "|cFF03fc03Ready|r"
    end
end
