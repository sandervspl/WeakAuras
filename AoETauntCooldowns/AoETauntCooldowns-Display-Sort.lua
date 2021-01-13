function(a, b)
    if b.region.id == "challenging shout" then
        return false
    elseif a.region.id == "challenging shout" then
        return true
    else
        if a.region.state.expirationTime == b.region.state.expirationTime then
            return b.region.state.name >= a.region.state.name
        elseif b.region.state.expirationTime and a.region.state.expirationTime then
            return a.region.state.expirationTime >= b.region.state.expirationTime
        else
            if not a.region.state.expirationTime and b.region.state.expirationTime then
                return true
            elseif a.region.state.expirationTime and not b.region.state.expirationTime then
                return false
            end
        end
    end
end

