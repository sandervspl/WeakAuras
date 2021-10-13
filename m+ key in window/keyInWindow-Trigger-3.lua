function()
    local found = false
    for bag = 0, NUM_BAG_SLOTS do
        local bagSlots = GetContainerNumSlots(bag)
        for slot = 1, bagSlots do
            local itemID = select(10, GetContainerItemInfo(bag, slot))
            
            if itemID == aura_env.keyId then
                found = true
            end
        end
    end
    
    local playerKey = aura_env.getPlayerKey()
    local curWeekNum = aura_env.getWeekNum()
    local d = date("*t")

    -- Very hacky and only works from Wednesday to Saturday. If you log in on a Sunday after reset this probably won't work.
    if not found and playerKey then
        if d.wday >= 4 and playerKey.weeknum < curWeekNum or playerKey.weeknum > curWeekNum then
            aura_env.setGlobalKeys({})
        end
    end
end
