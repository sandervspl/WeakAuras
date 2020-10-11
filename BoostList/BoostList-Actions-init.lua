-- Constants
aura_env.constants = {
    NAME = 1,
    AMOUNT = 2,
}

aura_env.boosts = {
    fire = 0,
    gehe = 0,
    mogr = 0,
    luci = 0,
    gole = 0,
}
aura_env.characters = {}
aura_env.charactersCounted = {}
aura_env.total = 0

aura_env.lang = UnitFactionGroup("player") == "Horde" and "orcish" or "common"

aura_env.SendWhisper = function(str, recipient)
    SendChatMessage(str, "WHISPER", aura_env.lang, recipient)
end

 aura_env.SendInviteError = function(recipient)
    aura_env.SendWhisper("Error: Please add your server name (fire, gehe, mogr, luci, gole) to your whisper. Example: 'inv fire'", recipient)
end
