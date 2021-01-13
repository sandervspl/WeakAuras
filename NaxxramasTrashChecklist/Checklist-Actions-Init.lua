aura_env.wings = {"Abomination Wing", "Spider Wing", "Military Wing", "Plague Wing", "Outer Ring"}
aura_env.unitKills = {}

for i,unit in ipairs(aura_env.config.units) do
    aura_env.unitKills[unit.name] = 0
end

aura_env.split = function(str, delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(str, delimiter, from)

    while delim_from do
       table.insert(result, string.sub(str, from , delim_from-1))
       from = delim_to + 1
       delim_from, delim_to = string.find(str, delimiter, from)
    end

    table.insert(result, string.sub(str, from))

    return result
end
