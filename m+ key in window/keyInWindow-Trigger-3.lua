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

    -- If we find no key in bags, but we have recorded data from last week then reset list
    if not found then
        local guid = UnitGUID("player")

        if aura_env.keys[guid] then
            aura_env.reset()
        end
    end
end
