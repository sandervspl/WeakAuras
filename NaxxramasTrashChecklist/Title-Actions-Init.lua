local name = "WA_NaxxramasTrashChecklistReset_Button"
local r = aura_env.region
local btn = _G[name] or CreateFrame("Button", name, r)
btn:SetAllPoints(r)
btn:EnableMouse()
btn:SetScript("OnMouseDown", function(self) 
        StaticPopupDialogs["RESET_NAXXRAMAS_CHECKLIST"] = {
            text = "Do you want to reset the Naxxramas Trash Checklist?",
            button1 = "Yes",
            button2 = "No",
            OnAccept = function()
                WeakAuras.ScanEvents("RESET_NAXXRAMAS_CHECKLIST", true)
            end,
            timeout = 0,
            whileDead = true,
            hideOnEscape = true,
        }
        StaticPopup_Show("RESET_NAXXRAMAS_CHECKLIST")
end)
