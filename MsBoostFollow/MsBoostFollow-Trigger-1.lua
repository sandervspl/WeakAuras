-- PLAYER_ENTERING_WORLD,PARTY_INVITE_REQUEST,GROUP_JOINED

function(event, ...)
    if event == "PLAYER_ENTERING_WORLD" and UnitName("player") == "Msone" then
        InviteUnit("Mstwo")
        InviteUnit("Msthree")
    end
    
    -- Accept party invite
    if event == "PARTY_INVITE_REQUEST" and UnitName("player") ~= "Msone" then
        AcceptGroup()
        StaticPopup_Hide("PARTY_INVITE")
    end
    
    if event == "GROUP_JOINED" then
        for i = 1,3 do
            local unit = "party" .. i
            
            if UnitIsGroupLeader(unit) then
                FollowUnit(unit)
                
                if IsInGroup() and not UnitIsGroupLeader("player") then
                    LeaveParty()
                end
            end
        end
    end
end
