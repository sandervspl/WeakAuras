-- UPDATE_BATTLEFIELD_SCORE

function(event, ...)
    local playerFaction = UnitFactionGroup("player")

    if string.lower(playerFaction) == "alliance" then
        playerFaction = 1
    else
        playerFaction = 0
    end

    for i = 1, GetNumBattlefieldScores() do
        local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange, preMatchMMR, mmrChange, talentSpec = GetBattlefieldScore(i)
        local r, g, b, hex = GetClassColor(string.upper(classToken))

        if name ~= nil and name ~= "Unknown" and type(name) == "string" and string.len(name) > 1 and playerFaction ~= faction and not aura_env.enemies[name] and hex then
            aura_env.enemies[name] = "|c" .. hex .. name .. "|r"
        end
    end
end
