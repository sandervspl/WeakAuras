local function GetSpellName(id)
    return string.lower(GetSpellInfo(id))
end

aura_env.spells = {}
-- For localization
aura_env.rogueSpells = {
    evasion = GetSpellName(26669),
    sprint = GetSpellName(11305),
    vanish = GetSpellName(26889),
    shadowstep = GetSpellName(36554),
    coldblood = GetSpellName(14177),
    premeditation = GetSpellName(14183),
}
-- For localization
aura_env.spellInteractions = {
    preparation = GetSpellName(14185),
    coldSnap = GetSpellName(12472),
}
aura_env.nameplates = {}
aura_env.guids = {}
aura_env.temp = {}
aura_env.prefix = "SCON-Ms"

-- Dashes fuck up something in find/match JUST LUA THINGS
-- Don't use this as an index, only to compare
aura_env.fixGUID = function(guid)
    return string.gsub(guid, "-", "")
end

C_ChatInfo.RegisterAddonMessagePrefix(aura_env.prefix)

for i, spell in ipairs(aura_env.config.spells) do
    if spell.spellID > 0 then
        -- For localization
        local name, _, icon = GetSpellInfo(spell.spellID)
        
        if (name) then
            aura_env.spells[string.lower(name)] = {
                icon = tonumber(spell.icon) or icon,
                cooldown = spell.cooldown,
                active = spell.active,
            }
        end
    end
end