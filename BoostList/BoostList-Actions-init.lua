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

aura_env.SendWhisper = function(str, recipient)
    SendChatMessage(str, "WHISPER", nil, recipient)
end

aura_env.SendInviteError = function(recipient)
    aura_env.SendWhisper("Please add your server name (fire, gehe, mogr, luci, gole) to your whisper. Example: 'inv fire'", recipient)
end
