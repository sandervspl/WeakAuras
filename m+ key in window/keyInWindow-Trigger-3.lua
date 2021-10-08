function()
    local found = false
    for bag = 0, NUM_BAG_SLOTS do
        local bagSlots = GetContainerNumSlots(bag)
        for slot = 1, bagSlots do
            local itemLink, _, _, itemID = select(7, GetContainerItemInfo(bag, slot))
            
            if itemID == aura_env.keyId then
                found = true
            end
        end
    end

    local charKey = aura_env.savedKey()
    local curWeekNum = aura_env.getWeekNum()
    if not found and charKey then
        if charKey.weeknum < curWeekNum or charKey.weeknum > curWeekNum then
            aura_env.reset()
        end
    end
end
