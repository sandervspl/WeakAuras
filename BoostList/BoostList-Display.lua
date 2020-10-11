function()
    local listStr = "total = " .. aura_env.total .. "\n\n"
    
    for server, value in pairs(aura_env.boosts) do
        listStr = listStr .. server:sub(1, 1):upper() .. server:sub(2) .. " = " .. value .. "\n"
    end
    
    return listStr
end