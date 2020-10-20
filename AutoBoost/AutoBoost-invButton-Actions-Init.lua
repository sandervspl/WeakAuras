aura_env.trim = function(s)
    return s:gsub("^%s*(.-)%s*$", "%1")
end

local _, _, raceID = UnitRace("player")

local gnomeDwarfZones = { "coldridge valley", "kharanos" }
local orcTrollZones = { "the merchant coast", "ratchet" }
local nelfZones = { "teldrassil", "dolanaar" }
local zones = {
    nil,
    orcTrollZones,
    gnomeDwarfZones,
    nelfZones,
    nil,
    nil,
    gnomeDwarfZones,
    orcTrollZones,
}
aura_env.zones = zones[raceID]

local region = WeakAuras.regions[aura_env.id].region
aura_env.invButtonFrame = CreateFrame("Button","sayInviteButton", region, "SecureActionButtonTemplate")
aura_env.invButtonFrame:SetAllPoints(region)
aura_env.invButtonFrame:SetAttribute("type1", "macro")
aura_env.invButtonFrame:RegisterForClicks("AnyDown")

if not aura_env.config.autoSendWhisper then
    print("AutoBracketBoost: Please /reload for the changes to take effect!")
end
