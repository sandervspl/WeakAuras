function()
    local name = aura_env.state.key_name
    local lvl = aura_env.state.key_lvl

    if name and lvl then
        local clr = aura_env.getKeyColor(lvl)
        local lvlClr = string.format("|c%s%s|r", clr, lvl)
        
        return name, lvlClr
    end
end
