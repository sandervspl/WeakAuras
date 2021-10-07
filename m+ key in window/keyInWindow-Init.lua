aura_env.keyId = 180653

if not WeakAurasSaved['displays'][aura_env.id].keys then
    WeakAurasSaved['displays'][aura_env.id].keys = {}
end

aura_env.keys = aura_env.keys or WeakAurasSaved['displays'][aura_env.id].keys or {}

aura_env.update = function(name, lvl)
    local key = {
        char_name = WA_ClassColorName("player"),
        name = name,
        lvl = lvl,
    }
    local guid = WeakAuras.myGUID

    WeakAurasSaved['displays'][aura_env.id].keys[guid] = key
    aura_env.keys = WeakAurasSaved['displays'][aura_env.id].keys
end

aura_env.reset = function()
    WeakAurasSaved['displays'][aura_env.id].keys = {}
    aura_env.keys = WeakAurasSaved['displays'][aura_env.id].keys
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

if not aura_env.region.ChallengesFrameHook then
    local aura_env = aura_env
    C_Timer.After(1,
        function()
            LoadAddOn("Blizzard_ChallengesUI")
            ChallengesFrame:HookScript("OnShow", function() WeakAuras.ScanEvents("CF_SHOW", true) end)
            ChallengesFrame:HookScript("OnHide", function() WeakAuras.ScanEvents("CF_HIDE", true) end)
            aura_env.region.ChallengesFrameHook = true
        end
    )
end
