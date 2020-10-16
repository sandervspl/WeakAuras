aura_env.boosts = {}
aura_env.charLinkList = {}
aura_env.total = 0

aura_env.SendWhisper = function(str, recipient)
    SendChatMessage(str, "WHISPER", nil, recipient)
end

aura_env.SendInviteError = function(recipient)
    aura_env.SendWhisper("Please add your server name (gehe, mogr, luci, gole) or your character name (if you are from Firemaw) to the whisper. Example: 'inv gehe' or 'inv Ms'", recipient)
end
