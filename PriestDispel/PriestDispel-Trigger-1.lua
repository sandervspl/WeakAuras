function(allstates, event, ...)
    local unit = ...

    if unit == nil or UnitIsEnemy("player", unit) then
        return true
    end

    -- local unitGUID = UnitGUID(unit)

    for i = 1, 40 do
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitDebuff(unit, i)
        local ogName = name

        if not name then
            return
        end

        name = string.lower(name)

        if debuffType ~= nil and debuffType == "Magic" and aura_env.spells[name] and aura_env.spells[name].active then
            allstates[unit .. "|" .. name] = {
                show = true,
                changed = true,
                progressType = "static",
                autoHide = true,
                name = UnitName(unit) .. " (" .. ogName .. ")",
                icon = icon,
                stack = count,
            }
        end
    end

    return true
end
