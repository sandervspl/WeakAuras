aura_env.isMonkDamageSpell = function(spellId)
    local spells = {
        100780,
        100784,
        107428,
        261947,
        101546,
        152175,
        113656,
        123986,
        122470,
        123904,
        322101,
        117952,
        115098,
        116847,
    }

    for key,id in pairs(spells) do
        if id == spellId then
            return true
        end
    end

    return false
end
