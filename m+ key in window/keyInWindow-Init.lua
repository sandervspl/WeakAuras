aura_env.keyId = 180653
aura_env.keyinwindow = aura_env.keyinwindow or {}

aura_env.getGlobalKeys = function()
    return aura_env.keyinwindow.keys
end

aura_env.setGlobalKeys = function(val)
    aura_env.keyinwindow.keys = val
end

aura_env.setKey = function(guid, key)
    aura_env.getGlobalKeys()[guid] = key
end

aura_env.getPlayerKey = function()
    return aura_env.getGlobalKeys()[WeakAuras.myGUID]
end

if not aura_env.getGlobalKeys() then
    aura_env.setGlobalKeys({})
end

aura_env.getWeekNum = function()
    local d = date("*t")
    local d1 = time({year = d.year, month = 1, day = 1})

    local numday = floor((time() - d1) / (24*60*60))
    local weeknum = ceil((d.wday + numday) / 7)

    return weeknum
end

aura_env.update = function(name, lvl)
    local key = {
        char_name = WA_ClassColorName("player"),
        name = name,
        lvl = lvl,
        weeknum = aura_env.getWeekNum(),
    }
    local guid = WeakAuras.myGUID

    aura_env.setKey(guid, key)
end

aura_env.getKeyColor = function(lvl)
    local levelColors = {
        [0] = "ffffffff",
        [1] = "ff1eff00",
        [2] = "ff0070dd",
        [3] = "ffa335ee",
        [4] = "ffff8000",
        [5] = "ffe6cc80",
        [6] = "ff00ccff"
    }

    return levelColors[min(floor(lvl / 5), 6)]
end

aura_env.init = function()
    if not aura_env.ChallengesFrameHook then
        -- I think there is a scope issue in the callback function. This fixes it.
        local aura_env = aura_env

        C_Timer.After(1, function()
            C_AddOns.LoadAddOn("Blizzard_ChallengesUI")
            
            ChallengesFrame:HookScript("OnShow", function() WeakAuras.ScanEvents("CF_SHOW", true) end)
            ChallengesFrame:HookScript("OnHide", function() WeakAuras.ScanEvents("CF_HIDE", true) end)
            aura_env.ChallengesFrameHook = true
        end)
    end
end

aura_env.init()
