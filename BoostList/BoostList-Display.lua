function()
    local listStr = "total = " .. aura_env.total .. "\n\n"
    
    for server, value in pairs(aura_env.players) do
        listStr = listStr .. server .. " = " .. value .. "\n"
    end
    
    return listStr
end