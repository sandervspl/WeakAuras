local name = "AoeTauntCooldownsReset_Button"
local r = aura_env.region
local btn = _G[name] or CreateFrame("Button", name, r)
btn:SetAllPoints(r)
btn:EnableMouse()
btn:SetScript("OnMouseDown", function(self) 
        StaticPopupDialogs["RESET_AOETAUNTCD_LIST"] = {
            text = "Do you want to reset the AoE Taunt/LIP cooldown list?",
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
                WeakAuras.ScanEvents("RESET_AOETAUNTCD_LIST", true)
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
        }
        StaticPopup_Show("RESET_AOETAUNTCD_LIST")
end)
