function()
    local count = aura_env.count

    if aura_env.config.show_marks_amt == 1 then
        return count >= 6 and 6 or count
    elseif aura_env.config.show_marks_amt == 2 then
        return count
    else
        return (count >= 6 and 6 or count) .. " (" .. count .. ")"
    end
end
