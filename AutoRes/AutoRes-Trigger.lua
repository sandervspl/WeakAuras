function(event)
    print(event)
    if event == "CONFIRM_XP_LOSS" then
        AcceptXPLoss()
    end
    
    if event == "DIALOG_SHOW" then
        SelectGossipOption(1)
    end
    
    if event == "PLAYER_DEAD" then
        RepopMe()
    end
end

