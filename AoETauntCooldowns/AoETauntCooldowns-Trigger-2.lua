-- RESET_AOETAUNTCD_LIST

function(event, ...)
    -- Prevent WA from triggering this
    if ... then
        aura_env.reset();
    end
end
