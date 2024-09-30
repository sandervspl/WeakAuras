function(allStates, event, ...)
    local tooltip = {"Your keys\n"}

    for _, key in pairs(aura_env.getGlobalKeys()) do
        local str = string.format("%s|r\n|c00FFFFFF%s (|c%s%d|r)\n", key.char_name, key.name, aura_env.getKeyColor(key.lvl), key.lvl)
        table.insert(tooltip, str)
    end

    allStates[1] = {}

    for bag = 0, NUM_BAG_SLOTS do
        local bagSlots = C_Container.GetContainerNumSlots(bag)
        for slot = 1, bagSlots do
            local itemID = C_Container.GetContainerItemID(bag, slot)
            
            if itemID == aura_env.keyId then
                local itemLink = C_Container.GetContainerItemLink(bag, slot)
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
                
                allStates[1].key_name = name
                allStates[1].key_lvl = lvl
                
                aura_env.update(name, lvl)
            end
        end
    end

    allStates[1].changed = true
    allStates[1].show = true
    allStates[1].tooltip = table.concat(tooltip, "\n")

    return true
end