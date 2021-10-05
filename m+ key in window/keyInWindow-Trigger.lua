function(allStates, event, ...)
    for bag = 0, NUM_BAG_SLOTS do
        local bagSlots = GetContainerNumSlots(bag)
        for slot = 1, bagSlots do
            local itemLink, _, _, itemID = select(7, GetContainerItemInfo(bag, slot))
            
            if itemID == aura_env.keyId then
                local startIdx = string.find(itemLink, "%: ")
                local endIdx = string.find(itemLink, " %(")
                local name = ""
                local lvl = 0
                
                if startIdx and endIdx then
                    name = string.sub(itemLink, startIdx + 1, endIdx - 1)
                end
                
                local numStartIdx = string.find(itemLink, "%(")
                local numEndIdx = string.find(itemLink, "%)")
                
                if numStartIdx and numEndIdx then
                    lvl = string.sub(itemLink, numStartIdx + 1, numEndIdx - 1)
                end

                local tooltip = {"Your keys\n"}

                for guid, key in pairs(aura_env.keys) do
                    local str = string.format("%s|r\n|c00FFFFFF%s (|c%s%d|r)\n", key.char_name, key.name, aura_env.getKeyColor(key.lvl), key.lvl)
                    table.insert(tooltip, str)
                end
                
                allStates[1] = {
                    changed = true,
                    show = true,
                    key_name = name,
                    key_lvl = lvl,
                    tooltip = table.concat(tooltip, "\n"),
                }
                
                aura_env.update(name, lvl)
            end
        end
    end

    return true
end