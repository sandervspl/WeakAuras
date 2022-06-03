function ()
  local output = ""
  
  if aura_env.config["buffs"] == true then
      local buffCount = aura_env.aurasTotal or 0
      
      local buffString = "BUFFS " .. buffCount
      
      if (buffCount > 30) then
          buffString = "|cffff2222" .. buffString .. "|r"
      end
      
      output = output .. buffString .. "   "
  end
  
  if aura_env.config["hit"] == true then
      local hit = (GetCombatRatingBonus(CR_HIT_MELEE) or 0) + (GetHitModifier() or 0)
      
      output = output .. "HIT " .. string.format("%.2f", hit) .. "%   "
  end
  
  if aura_env.config["spellHit"] == true then
      local spellHit = GetSpellHitModifier()
      
      output = output .. "SPELLHIT " .. spellHit .. "%   "
  end
  
  if aura_env.config["crit"] == true then
      local crit = GetCritChance()
      
      output = output .. "CRIT " .. string.format("%.2f", crit) .. "%   "
  end
  
  if aura_env.config["spellCrit"] == true then
      local MAX_SPELL_SCHOOLS = 7;
      
      -- Start at 2 to skip physical damage
      local maxSpellCrit = 0;
      for i = 2, MAX_SPELL_SCHOOLS do
          local bonusCrit = GetSpellCritChance(i);
          maxSpellCrit = max(maxSpellCrit, bonusCrit);
      end
      
      output = output .. "SPELLCRIT " .. string.format("%.2f", maxSpellCrit) .. "%   "
  end

  if aura_env.config["expertise"] == true then
    local mh, oh = GetExpertisePercent();
    
    output = output .. "EXPERTISE [" .. mh .. "% / " .. oh .. "%]   "
  end
  
  if aura_env.config["ap"] == true then
      local base, posBuff, negBuff = UnitAttackPower("player");
      local ap = base + posBuff + negBuff;
      
      output = output .. "AP " .. ap .. "   "
  end
  
  if aura_env.config["rap"] == true then
      local base, posBuff, negBuff = UnitRangedAttackPower("player");
      local rap = base + posBuff + negBuff;
      
      output = output .. "RAP " .. rap .. "   "
  end
  
  if aura_env.config["sp"] == true then
      local MAX_SPELL_SCHOOLS = 7;
      
      -- Start at 2 to skip physical damage
      local maxSpellDmg = 0;
      for i = 2, MAX_SPELL_SCHOOLS do
          local bonusDamage = GetSpellBonusDamage(i);
          maxSpellDmg = max(maxSpellDmg, bonusDamage);
      end
      
      output = output .. "SP " .. maxSpellDmg .. "   "
  end
  
  if aura_env.config["heal"] == true then
      local heal = GetSpellBonusHealing()
      
      output = output .. "+HEAL " .. heal .. "   "
  end
  
  if aura_env.config["mp2"] and UnitPowerType("player") == Enum.PowerType.Mana then
      local mp2 = math.floor(GetManaPer(2) + 0.5)
      
      
      output = output .. "MP2 " .. mp2 .. "   "
  end
  
  if aura_env.config["mp5"] and UnitPowerType("player") == Enum.PowerType.Mana then
      local mp5 = math.floor(GetManaPer(5) + 0.5)
      
      output = output .. "MP5 " .. mp5 .. "   "
  end
  
  if aura_env.config["dmg"] == true then
      local _, _, _, _, _, _, percentmod = UnitDamage("player");
      local dmg = math.ceil(percentmod * 100)
      
      output = output .. "DMG " .. dmg .. "%   "
  end

  if aura_env.config["wspeed"] == true then
    local mh, oh = UnitAttackSpeed("player");
    
    if (mh ~= nil and oh ~= nil) then
        output = output .. "WEAPONS [" .. string.format("%.1f", mh) .. "s / " .. string.format("%.1f", oh) .. "s]   "
    end
  end
  
  if aura_env.config["arpen"] == true then
    local arpen = GetArmorPenetration();
    
    if (arpen ~= nil) then
        output = output .. "ARMOR PEN " .. arpen .. "   "
    end
  end
  
  if aura_env.config["armor"] == true then
      local _, total, _, _ = UnitResistance("player", 0)
      
      output = output .. "ARMOR " .. total .. "   "
  end
  
  if aura_env.config["defense"] == true then
      local numSkills = GetNumSkillLines();
      local skillIndex = 0;
      local currentHeader = nil;
      
      for i = 1, numSkills do
          local skillName = select(1, GetSkillLineInfo(i));
          local isHeader = select(2, GetSkillLineInfo(i));
          
          if isHeader ~= nil and isHeader then
              currentHeader = skillName;
          else
              if (currentHeader == "Weapon Skills" and skillName == DEFENSE) then
                  skillIndex = i;
                  break;
              end
          end
      end
      
      local skillRank, skillModifier;
      if (skillIndex > 0) then
          skillRank = select(4, GetSkillLineInfo(skillIndex));
          skillModifier = select(6, GetSkillLineInfo(skillIndex));
      else
          -- Use this as a backup, just in case something goes wrong
          skillRank, skillModifier = UnitDefense(unit); --Not working properly
      end
      
      local def = max(0, skillRank + skillModifier);
      
      output = output .. "DEF " .. def .. "   "
  end
  
  if aura_env.config["dodge"] == true then
      local dodge = GetDodgeChance()
      
      output = output .. "DODGE " .. string.format("%.2f", dodge) .. "%   "
  end
  
  if aura_env.config["parry"] == true then
      local parry = GetParryChance()
      
      output = output .. "PARRY " .. string.format("%.2f", parry) .. "%   "
  end
  
  if aura_env.config["block"] == true then
      local blockChance = GetBlockChance()
      
      local scanTooltip = CreateFrame("GameTooltip", "scanTooltip", nil, "GameTooltipTemplate");
      scanTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
      
      local blockFromShield = 0;
      local offHandIndex = 17;
      
      local hasItem = scanTooltip:SetInventoryItem("player", offHandIndex);
      if hasItem then
          local maxLines = scanTooltip:NumLines();
          for line = 1, maxLines do
              local leftText = getglobal("scanTooltipTextLeft" .. line);
              if leftText:GetText() then
                  local valueTxt = string.match(leftText:GetText(), "%d+ " .. ITEM_MOD_BLOCK_RATING_SHORT);
                  if valueTxt then
                      valueTxt = string.match(valueTxt, "%d+");
                      if valueTxt then
                          local numValue = tonumber(valueTxt);
                          if numValue then
                              blockFromShield = numValue;
                              break;
                          end
                      end
                  end
              end
          end
      end
      
      local strStatIndex = 1;
      local strength = select(2, UnitStat("player", strStatIndex));
      local blockValue = blockFromShield + (strength / 20);
      
      output = output .. "BLOCK " .. string.format("%.2f", blockChance) .. "% (" .. blockValue .. ")   "
  end
  
  if aura_env.config["arcaneRes"] == true then
      local _, total, _, _ = UnitResistance("player", 6)
      
      output = output .. "ARCANE RES " .. total .. "   "
  end
  
  if aura_env.config["fireRes"] == true then
      local _, total, _, _ = UnitResistance("player", 2)
      
      output = output .. "FIRE RES " .. total .. "   "
  end
  
  if aura_env.config["natureRes"] == true then
      local _, total, _, _ = UnitResistance("player", 3)
      
      output = output .. "NATURE RES " .. total .. "   "
  end
  
  if aura_env.config["frostRes"] == true then
      local _, total, _, _ = UnitResistance("player", 4)
      
      output = output .. "FROST RES " .. total .. "   "
  end
  
  if aura_env.config["shadowRes"] == true then
      local _, total, _, _ = UnitResistance("player", 5)
      
      output = output .. "SHADOW RES " .. total .. "   "
  end
  
  if aura_env.config["speed"] == true then
      local cur, run, flight, swim = GetUnitSpeed("Player")
      local relevantSpeed = run;

      if (IsSwimming("player")) then
          relevantSpeed = swim;
      elseif (IsFlying("player")) then
          relevantSpeed = flight;
      end

      local speed = string.format("%d", (relevantSpeed / 7) * 100);
      
      output = output .. "SPEED " .. string.format("%.2f", speed) .. "%   "
  end
  
  return output
end

