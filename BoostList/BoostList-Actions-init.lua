aura_env.boosts = {}
aura_env.charLinkList = {}
aura_env.total = 0

aura_env.SendWhisper = function(str, recipient)
    SendChatMessage(str, "WHISPER", nil, recipient)
end

aura_env.SendInviteError = function(recipient)
    aura_env.SendWhisper("Please add your server name (or your character name if you are from this server) to the whisper. Example: 'inv bonescythe' or 'inv Verycoolguy'", recipient)
end
