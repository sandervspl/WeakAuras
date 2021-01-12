function()
    local listStr = ""
    local wingStrList = {}
    
    for i, unit in ipairs(aura_env.config.units) do
        local line = "  " .. unit.name .. " " .. aura_env.unitKills[unit.name] .. " / " .. unit.amount .. "\n"
        local wingName = aura_env.wings[unit.wing]

        if aura_env.unitKills[unit.name] == unit.amount then
            line = "|cFFB0B0B0" .. line .. "|r"
        end

        if wingStrList[unit.wing] then
            wingStrList[unit.wing] = wingStrList[unit.wing] .. line
        else
            wingStrList[unit.wing] = "\n" .. wingName .. "\n" .. line
        end
    end

    for i, wingLines in ipairs(wingStrList) do
        listStr = listStr .. wingLines
    end
    
    return listStr
end
