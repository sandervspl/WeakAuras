-- PLAYER_PVP_KILLS_CHANGED

function(event, ...)
    local hk = GetPVPSessionStats()
    hk = hk or 0

    aura_env.stacks = hk

    local subzone = string.lower(GetSubZoneText())
    local killzone = string.lower(aura_env.trim(aura_env.config.kill_location))

    if subzone == killzone then
        local playSoundKills = tonumber(aura_env.config.playSoundKills)

        if playSoundKills ~= nil and hk == playSoundKills then
            PlaySoundFile("Interface\\AddOns\\WeakAuras\\Media\\Sounds\\BikeHorn.ogg")
        end

        if hk >= 15 then
            if IsInGroup() and not UnitIsGroupLeader("player") then
                LeaveParty()
            end
        end

        return true
    end

    return false
end