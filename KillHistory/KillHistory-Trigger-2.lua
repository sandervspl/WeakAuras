-- UPDATE_BATTLEFIELD_SCORE

function(states, event, ...)
   for i = 1, GetNumBattlefieldScores() do
      local name, killingBlows, _, deaths, _, faction = GetBattlefieldScore(i)
      local playerFaction = UnitFactionGroup("player")

      if string.lower(playerFaction) == "alliance" then
         playerFaction = 1
      else
         playerFaction = 0
      end

      local playerStats = aura_env.stats[name]
      local newData = {
         name = name,
         killingBlows = killingBlows,
         deaths = deaths,
      }

      -- print(name, ": kb =", killingBlows, "d =", deaths)

      if not playerStats then
         aura_env.stats[name] = newData
      else
         if killingBlows ~= playerStats.killingBlows then
            print(name, "got a kill")
            table.insert(aura_env.kills, name)
         end

         if deaths ~= playerStats.deaths then
            print(name, "died")
            table.insert(aura_env.deaths, name)
         end

         for j = 1, table.getn(aura_env.kills) do
            -- local enemyColorName = aura_env.enemies[destName]

            -- if not enemyColorName then
            --    enemyColorName = destName
            -- end

            local name1 = aura_env.enemies[aura_env.kills[j]] or aura_env.kills[j]
            local name2 = aura_env.enemies[aura_env.deaths[j]] or aura_env.deaths[j]

            if aura_env.deaths[j] then
               local data = {
                  changed = true,
                  show = true,
                  name = WA_ClassColorName(aura_env.kills) .. " killed " .. enemyColorName,
              }

               table.insert(states, data)
         end

         aura_env.stats[name] = newData
      end
   end

   return true
end
