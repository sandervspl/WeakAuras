function(states, event, ...)
    local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName = ...
    local plrGUID = UnitGUID("player")

    if subevent == "SPELL_CAST_SUCCESS" then
      if (spellId == 24751 and destGUID == plrGUID) then
        states[destGUID] = states[destGUID] or {}
        states[destGUID].changed = true
        states[destGUID].show = true
        states[destGUID].autoHide = false
        states[destGUID].progressType = "timed"
        states[destGUID].name = destName
        states[destGUID].expirationTime = GetTime() + 3600
        states[destGUID].duration = 3600

        -- Save to DB
        aura_env..chars[destGUID] = states[destGUID]
        WeakAurasSaved["displays"][aura_env.id]..chars = aura_env..chars
      end
    else
      local curDebuffExpirationTime = 0

      for i=1,36 do
        local name, icon, count, dispelType, duration, expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod = UnitAura("player", i, "HARMFUL")
        
        -- Check if player has Trick or Treat debuff
        if spellId == 24755 then
          curDebuffExpirationTime = expirationTime
        end
      end

      -- Setup state for all characters
      for guid, obj in pairs(aura_env..chars) do
        local expTime = obj.expirationTime
        
        -- Set expiration time for Trick or Treat debuff if it's still active
        if guid == plrGUID and curDebuffExpirationTime > GetTime() then
          expTime = curDebuffExpirationTime
        end

        states[guid] = {
          guid = guid,
          changed = true,
          show = true,
          autoHide = false,
          progressType = "timed",
          name = obj.name,
          expirationTime = expTime,
          duration = obj.duration,
        }
      end
    end

    return true
end
