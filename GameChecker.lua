queue_on_teleport([[
if game.PlaceId ~= then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/Teleporter.lua"))()
else
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/Autofarm.lua"))()
end
]])
