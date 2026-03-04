task.spawn(function()
queue_on_teleport([[
    repeat task.wait() until game:IsLoaded()
    if game.PlaceId ~= 15124180230 then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/helloautofarm/refs/heads/main/Autoexecute.lua"))()
    else
        print("Successfully rejoined.")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/helloautofarm/refs/heads/main/RealAutofarm.lua"))()
    end
]])
end)
