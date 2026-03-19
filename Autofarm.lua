repeat task.wait() until game:IsLoaded()
if not game:GetService("Players").LocalPlayer.Character then 
    game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
end
task.wait(1)

local Players = cloneref(game:GetService("Players"))
local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
local LogService = cloneref(game:GetService("LogService"))
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
repeat task.wait() until Player.Character
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character
local Humanoid = Character and Character:FindFirstChild("Humanoid")
local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
local Random = Random.new()
local Start = os.clock()

if game.PlaceId ~= 15124180230 then
        Player:Kick("Auto Farm V2 | This isn't supported on regular servers.")
    return
end
local Authentication
task.spawn(function()
    Authentication = loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/SkidProtector.lua"))()
    if not Authentication then
        Player:Kick("Skid Protection.")
        task.wait(1)
        while true do
            print("67 skids I love em chatgpt boii city boii")
        end
    else
        if Authentication ~= "Logan+TStudiedHyphonFor5Years" then
            Player:Kick("Skid Protection.")
            task.wait(1)
            while true do
                print("67 skids I love em chatgpt boii city boii")
            end
        end
    end
end)

-- //  IMPORTANT!!
local GoalCashSettings = {
    ["Goal Cash"] = false; -- // Enable this to enable auto kick and the settings below.
    ["Memorize Goal"] = false; -- // If you get disconnected or leave it will memorize the money made.
    ["Goal Amount"] = 100000; -- // How much cash should be made before it auto kicks you.
    ["Extra Cash"] = 0;
}

local Settings = {
    ["Deleting"] = false;
    ["Ready"] = false;
    ["Rejoined"] = true;
    ["Status"] = "[ START UP ] : Waiting for a response from the system.";
    ["Old HRP Position"] = CFrame.new(HumanoidRootPart.Position);
    ["Apartment"] = nil;

    ["Autofarm Enabled"] = false;
    ["Auto Rejoin"] = true;
    ["IsHealing"] = false;

    ["Cards Counter"] = 0;
    ["Potato Counter"] = 0;
    ["Marshmallow Counter"] = 0;

    ["Safety Counter"] = 0;

    ["Sufficient Cash"] = true;
    ["Cash Check"] = false;

    ["Purchasing Ski-Mask"] = false;
    ["Purchasing Apartment"] = false;
}

local Data = {
    ["Hourly Rate"] = 0;
    ["Run Time"] = 0;
    ["Starting Cash"] = 0;
    ["Cash Change"] = 0;
    ["Cycles"] = 0;
}

local function FormatTime(Seconds)
    local hours = math.floor(Seconds / 3600)
    local minutes = math.floor((Seconds % 3600) / 60)
    local seconds = math.floor(Seconds % 60)
    
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

local function GetCommaValue(Number)
    local Formatted = tostring(Number)
    while true do
        Formatted, Replaced = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (Replaced == 0) then
            break
        end
    end
    return Formatted
end

local ClearGoalCache = function()
    delfile("AutoFarmMemory1_" .. Player.Name .. ".txt")
    delfile("AutoFarmMemory2_" .. Player.Name .. ".txt")
    delfile("AutoFarmMemory3_" .. Player.Name .. ".txt")
    delfile("AutoFarmMemory4_" .. Player.Name .. ".txt")
end

local CreateGoalFiles = function()
    writefile("AutoFarmMemory1_" .. Player.Name .. ".txt", tostring(Data["Cash Change"]))
    writefile("AutoFarmMemory2_" .. Player.Name .. ".txt", tostring(GoalCashSettings["Goal Amount"]))
    writefile("AutoFarmMemory3_" .. Player.Name .. ".txt", tostring(GoalCashSettings["Goal Cash"]))
    writefile("AutoFarmMemory4_" .. Player.Name .. ".txt", tostring(GoalCashSettings["Memorize Goal"]))
end

local GoalAndHourlyFunction = function()
    repeat task.wait() until PlayerGui:FindFirstChild("Main")
    local Main = PlayerGui:FindFirstChild("Main")
    repeat task.wait() until Main.Enabled == true
    repeat task.wait() until Main:FindFirstChild("Money")
    local Money = Main:FindFirstChild("Money")
    repeat task.wait() until Money:FindFirstChild("Amount")
    local Amount = Money:FindFirstChild("Amount")

    local Result = string.gsub(Amount.Text, "%D+", "")
    Settings["Starting Cash"] = tonumber(Result)

    if isfile("AutoFarmMemory3_" .. Player.Name .. ".txt") and isfile("AutoFarmMemory4_" .. Player.Name .. ".txt") then
        local LastMemory3 = readfile("AutoFarmMemory3_" .. Player.Name .. ".txt")
        if tostring(LastMemory3) == "true" then
            GoalCashSettings["Goal Cash"] = true
        else
            GoalCashSettings["Goal Cash"] = false
        end
        task.wait()
        local LastMemory4 = readfile("AutoFarmMemory4_" .. Player.Name .. ".txt")
        if tostring(LastMemory4) == "true" then
            GoalCashSettings["Memorize Goal"] = true
        else
            GoalCashSettings["Memorize Goal"] = false
        end
        task.wait()
    end

    if GoalCashSettings["Goal Cash"] == true and GoalCashSettings["Memorize Goal"] then
        if isfile("AutoFarmMemory1_" .. Player.Name .. ".txt") and isfile("AutoFarmMemory2_" .. Player.Name .. ".txt") then
            local LastMemory2 = readfile("AutoFarmMemory2_" .. Player.Name .. ".txt")
            if LastMemory2 ~= "nil" then
                GoalCashSettings["Goal Amount"] = tonumber(LastMemory2)
            end
            task.wait()
            local LastMemory1 = readfile("AutoFarmMemory1_" .. Player.Name .. ".txt")
            if LastMemory1 ~= "nil" then
                task.spawn(function()
                    repeat task.wait() until Settings["Ready"] == true
                    GoalCashSettings["Extra Cash"] = tonumber(LastMemory1)
                end)
            end
        end
    end

    task.spawn(function()
        while task.wait() do
            repeat task.wait() until PlayerGui:FindFirstChild("Main")
            local Main = PlayerGui:FindFirstChild("Main")
            repeat task.wait() until Main:FindFirstChild("Money")
            local Money = Main:FindFirstChild("Money")
            repeat task.wait() until Money:FindFirstChild("Amount")
            local Amount = Money:FindFirstChild("Amount")
            Result = string.gsub(Amount.Text, "%D+", "")
            Data["Cash Change"] = tonumber(Result - (Settings["Starting Cash"] - GoalCashSettings["Extra Cash"]))
            if (tonumber(Result) >= 1750000) then
                    Player:Kick("Autofarm V2 | " .. Player.Name .. ", you have reached max cash.")
                return
            end
            if GoalCashSettings["Goal Cash"] == true then
                if (Data["Cash Change"] >= GoalCashSettings["Goal Amount"]) then
                    Settings["Deleting"] = true
                    Player:Kick("Autofarm V2 | " .. Player.Name .. ", you have reached the desired goal of $" .. tostring(GetCommaValue(GoalCashSettings["Goal Amount"])) .. " after " .. FormatTime(Data["Run Time"]))
                    repeat
                        ClearGoalCache()
                        task.wait()
                    until not isfile("AutoFarmMemory1_" .. Player.Name .. ".txt")
                    return
                end
            end
            if Settings["Autofarm Enabled"] == true then
                Data["Run Time"] = (tick() - Start)
            end
        end
    end)
end
task.spawn(GoalAndHourlyFunction)

local AfkAndLeaverHandler = function()
    Player.Idled:Connect(function()
        if Settings["Autofarm Enabled"] == true then
            local VirtualUser = cloneref(game:GetService("VirtualUser"))
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
    Players.PlayerRemoving:Connect(function(plr)
        if (plr == Player) then
            if (GoalCashSettings["Goal Cash"] == true and GoalCashSettings["Memorize Goal"] == true) then
                task.wait()
                task.wait()
                if Settings["Deleting"] ~= true then
                    CreateGoalFiles()
                end
            end
        end
    end)
    while task.wait() do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, nil)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, nil)
        if Settings["Autofarm Enabled"] ~= true then
            Settings["Status"] = "[ START UP ] : Autofarm is currently yielding."
        end
    end
end
task.spawn(AfkAndLeaverHandler)

RunService.RenderStepped:Connect(function()
    if Humanoid.Health <= 80 or PlayerGui:WaitForChild("Main"):WaitForChild("CombatFrame").Visible == true then
        Settings["IsHealing"] = true
        Settings["Status"] = "[ ANTI-DEATH ] : Waiting until health is above 80."
        HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
    else
        Settings["IsHealing"] = false
        if Settings["Status"] == "[ ANTI-DEATH ] : Waiting until health is above 80." then
            Settings["Status"] = "[ START UP ] : Waiting for a response from the system."
        end
    end
    if HumanoidRootPart.Position.Y <= -10 or HumanoidRootPart.Position.Y >= 50 then
        for Index = 1,10 do
            HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
        end
    end
end)

task.spawn(function()
    Humanoid.Died:Connect(function()
        if Settings["Auto Rejoin"] == true then
            CreateGoalFiles()
            task.wait()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EzkieMalia/Autofarm/refs/heads/main/Teleporter.lua"))()
        end
    end)
end)

local function FindAvailableHomeless()
    Settings["Old HRP Position"] = CFrame.new(HumanoidRootPart.Position)
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ POTATO CHIPS ] : Looking for available homeless people."
    repeat
        HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
        task.wait()
    until #workspace:WaitForChild("Folders"):FindFirstChild("HomelessPeople"):GetChildren() == 0
    HumanoidRootPart.CFrame = CFrame.new(899, 4, -284)
    task.wait(.25)
    HumanoidRootPart.CFrame = CFrame.new(518, 4, -295)
    task.wait(.25)
    HumanoidRootPart.CFrame = CFrame.new(135, 8, -322)
    task.wait(.25)
    HumanoidRootPart.CFrame = CFrame.new(1102, 4, 529)
    task.wait(.25)
    repeat
        HumanoidRootPart.CFrame = CFrame.new(-769, 6, 654)
        task.wait()
    until #workspace:WaitForChild("Folders"):FindFirstChild("HomelessPeople"):GetChildren() == 0

    local Homeless = ReplicatedStorage:WaitForChild("Workspace").Homeless
    local AvailableHomeless = {}

    for Index, Object in next, Homeless:GetChildren() do
        if Object:IsA("Model") and tostring(Object) ~= "Six" then
            local UpperTorso = Object:FindFirstChild("UpperTorso")
            if UpperTorso.Position.Y < 2.35 and math.floor(UpperTorso.Position.Y) ~= 4 or math.floor(UpperTorso.Position.Y) ~= 3 then
                table.insert(AvailableHomeless, Object)
            end
        elseif tostring(Object) == "Six" and Object:IsA("Model") then
            local UpperTorso = Object:FindFirstChild("UpperTorso")
            if UpperTorso.Position.Y < -9 then
                table.insert(AvailableHomeless, Object)
            end
        end
    end
    return AvailableHomeless
end

local function FindAvailableApartments()
    local Available = {}
    local Owned = {}
    local Apartments = {"WH1"; "BH3"; "BH2"; "BH4"; "BH1"; "LT1";}
    local CasinoApartments = {"Home 1"; "Home 2"; "Home 3"; "Home 4"}
    for Index, Object in next, workspace:WaitForChild("Map").APTS:GetChildren() do
        if (Object:IsA("Model")) then 
            if table.find(Apartments, tostring(Object)) then
                local Board = Object:FindFirstChild("Board", Model)
                if Board.name.SurfaceGui.TextLabel.Text == "VACANT" then
                    table.insert(Available, workspace:WaitForChild("Map").Houses[tostring(Object)])
                elseif Board.name.SurfaceGui.TextLabel.Text == Player.Name then
                    table.insert(Owned, workspace:WaitForChild("Map").Houses[tostring(Object)])
                end
            elseif table.find(CasinoApartments, tostring(Object)) then
                local Board = Object:FindFirstChild("Board", Model)
                if Board.name.SurfaceGui.TextLabel.Text == "VACANT" then
                    table.insert(Available, workspace:WaitForChild("Map").Locations.Apartments[tostring(Object)])
                elseif Board.name.SurfaceGui.TextLabel.Text == Player.Name then
                    table.insert(Owned, workspace:WaitForChild("Map").Locations.Apartments[tostring(Object)])
                end
            end
        end
    end
    if #Owned >= 1 then return Owned, "Owned" end
    return Available, "Not Owned"
end

local function FindAvailableATMs()
    local ATMs = workspace:WaitForChild("Map").ATMS
    local AvailableATM
    for Index, ATM in next, ATMs:GetChildren() do
        if ATM:FindFirstChild("ATMScreen").Transparency == 0 then
            AvailableATM = ATM
        end
    end
    return AvailableATM
end

local function PurchaseSkiMask()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    repeat task.wait() until Settings["Sufficient Cash"] == true
    Settings["Purchasing Ski-Mask"] = true
    Settings["Cash Check"] = true
    Settings["Status"] = "[ MASK ] : Attempting to purchase and wear Ski-Mask."
    Humanoid:UnequipTools()
    task.wait(.05)
    if not Player:WaitForChild("Backpack"):FindFirstChild("SkiMask") then
        HumanoidRootPart.CFrame = CFrame.new(-363, 4, -321)
        task.wait(.5)
        repeat
            game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("StorePurchase"):FireServer("SkiMask")
            task.wait(.5)
        until (Player:WaitForChild("Backpack"):FindFirstChild("SkiMask"))
        repeat task.wait(); Humanoid:UnequipTools() until Player:WaitForChild("Backpack"):FindFirstChild("SkiMask")
    end
    if not Character:FindFirstChild("SkiMask") :: Accessory then
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("SkiMask"))
        task.wait(.05)
        local Args = {
        	buffer.fromstring("\005"),
            Character:WaitForChild("SkiMask")
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RPC"):FireServer(unpack(Args))
        task.wait(.05)
        Humanoid:UnequipTools()
    end
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    HumanoidRootPart.CFrame = Settings["Old HRP Position"]
    Settings["Status"] = "[ MASK ] : Successfully purchased Ski-Mask."
    Settings["Purchasing Ski-Mask"] = false
    return true
end

local function StartMarshmallowFarm()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    repeat task.wait() until Settings["Sufficient Cash"] == true
    repeat task.wait() until Settings["Purchasing Ski-Mask"] ~= true
    Settings["Status"] = "[ APARTMENTS ] : Attempting to purchase an available apartment."
    Settings["Purchasing Apartment"] = true
    local Apartment, Owned = FindAvailableApartments()
    if #Apartment ~= 0 then
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        Settings["Status"] = "[ APARTMENTS ] : Attempting to purchase an available apartment."
        if Owned == "Owned" then
            Apartment = Apartment[1]
            Settings["Apartment"] = Apartment
        else
            Apartment = Apartment[Random:NextInteger(1, #Apartment)]
            Settings["Apartment"] = Apartment
        end
        if Owned == "Not Owned" then
            if Settings["Autofarm Enabled"] ~= true then return end
            local apt = workspace:WaitForChild("Map").APTS:FindFirstChild(tostring(Apartment))
            local Board = apt:FindFirstChild("Board")
            local Prompt = Board.backboard.ProximityPrompt
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(Board.backboard.Position)
            Settings["Status"] = "[ APARTMENTS ] : Attempting to purchase an available apartment."
            task.wait(.5)
            repeat
                fireproximityprompt(Prompt)
                task.wait(.25)
            until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or Board.name.SurfaceGui.TextLabel.Text == tostring(Player)
            if PlayerGui:WaitForChild("Main").BasicNotification.Text == "This apartment is already occupied!" then
                task.spawn(StartMarshmallowFarm)
                return false
            end
        end

        local Lock = workspace:WaitForChild("Map").APTS:FindFirstChild(tostring(Apartment)).Door.DoorLock
        local Knob = workspace:WaitForChild("Map").APTS:FindFirstChild(tostring(Apartment)).Door.Knob
        local KnobPrompt = Knob.Parent.Interact.Attachment.ProximityPrompt

        if Lock.Part.Rotation.Y ~= 0 and Lock.Part.Rotation.Y ~= 90 then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
            Settings["Status"] = "[ APARTMENTS ] : Closing apartment door."
            task.wait(.5)
            for Index = 1,5 do
                HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
                fireproximityprompt(KnobPrompt)
                task.wait()
            end
            task.wait(.75)
        end
        if Lock.Part.Rotation.X ~= 90 then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
            Settings["Status"] = "[ APARTMENTS ] : Locking apartment door."
            task.wait(.25)
            repeat
                HumanoidRootPart.CFrame = CFrame.new(Lock.Part.Position)
                fireproximityprompt(Lock.Part.ProximityPrompt)
                task.wait(.25)
            until Lock.Part.Rotation.X == 90 or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have permission to interact with this."
            if PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 then
                task.spawn(StartMarshmallowFarm)
                return
            end
        end
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        Settings["Status"] = "[ APARTMENTS ] : Successfully purchased an apartment."
        HumanoidRootPart.CFrame = Settings["Old HRP Position"]
        Settings["Purchasing Apartment"] = false
        return true
    else
        Settings["Status"] = "[ APARTMENTS ] : No apartment available, yielding."
        return false
    end
end

local function ScavengeInventory()
    Humanoid:UnequipTools()
    task.wait(.05)
    local Potato = 0
    local Flour = 0
    local Water = 0
    local Gelatin = 0
    local SugarBlockBag = 0
    for Index, Object in next, Player:WaitForChild("Backpack"):GetChildren() do
        if (Object.Name == "Potato") then
            Potato += 1
        end
        if (Object.Name == "Flour") then
            Flour += 1
        end
        if (Object.Name == "Water") then
            Water += 1
        end
        if (Object.Name == "Gelatin") then
            Gelatin += 1
        end
        if (Object.Name == "Sugar Block Bag") then
            SugarBlockBag += 1
        end
    end
    return Potato, Flour, Water, Gelatin, SugarBlockBag
end
local Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()

local EmulateMovements = function()
    Settings["Status"] = "[ EMULATION 67 ] : Emulating movements."
    VirtualInputManager:SendKeyEvent(true, "W", false, nil)
    task.wait(1.25)
    VirtualInputManager:SendKeyEvent(false, "W", false, nil)
    VirtualInputManager:SendKeyEvent(true, "A", false, nil)
    task.wait(1.25)
    VirtualInputManager:SendKeyEvent(false, "A", false, nil)
    VirtualInputManager:SendKeyEvent(true, "S", false, nil)
    task.wait(1.25)
    VirtualInputManager:SendKeyEvent(false, "S", false, nil)
    VirtualInputManager:SendKeyEvent(true, "D", false, nil)
    task.wait(1.25)
    VirtualInputManager:SendKeyEvent(false, "D", false, nil)
end

local FarmBoxJob = function(Iterations)
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    if Settings["Farming Starter Cash"] == true then return end
    Settings["Farming Starter Cash"] = true

    local StartBoxJob = function()
        local Box = workspace:WaitForChild("PlaceHere")
        local BoxPrompt = Box.Attachment.ProximityPrompt
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(-551, 8, -89)
        Settings["Status"] = "[ BOX JOB ] : Attempting to grab crate."
        repeat
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(-551, 8, -89)
            Settings["Status"] = "[ BOX JOB ] : Attempting to grab crate."
            fireproximityprompt(BoxPrompt)
            task.wait()
        until Player:WaitForChild("Backpack"):FindFirstChild("Crate") or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have an active job session!"
        if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have an active job session!" then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(-580, 8, -74)
            Settings["Status"] = "[ BOX JOB ] Status: Claiming j*b."
            task.wait(.75)
            local Remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RPC")
            local Arg1 = buffer.fromstring("\015")
            local Arg2 = "Crates"
            Remote:FireServer(Arg1, Arg2)
            return false
        else
            return true
        end
    end
    local Start = StartBoxJob()
    if (Start == false) then
        repeat
            Start = StartBoxJob()
            task.wait()
        until Start == true
    end
    for Index = 1, Iterations do
        StartBoxJob()
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(-401, 8, -72)
        Settings["Status"] = "[ BOX JOB ] : Delivering crate."
        repeat
            local Truck = workspace:WaitForChild("cratetruck2")
            local TruckPrompt = Truck:FindFirstChild("Model").ClickBox.Attachment.ProximityPrompt
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(-401, 8, -72)
            Settings["Status"] = "[ BOX JOB ] : Delivering crate."
            Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Crate"))
            task.wait(.5)
            fireproximityprompt(TruckPrompt)
            task.wait(.1)
            Humanoid:UnequipTools()
            task.wait(.05)
        until not Player:WaitForChild("Backpack"):FindFirstChild("Crate")
        EmulateMovements()
    end

    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    HumanoidRootPart.CFrame = CFrame.new(-580, 8, -74)
    Settings["Status"] = "[ BOX JOB ] Status: Claiming j*b reward."
    task.wait(.75)
    local Remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RPC")
    local Arg1 = buffer.fromstring("\015")
    local Arg2 = "Crates"
    Remote:FireServer(Arg1, Arg2)
end

local PurchaseMarshmallowIngredients = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
    if (Water < 1 or Gelatin < 1 or SugarBlockBag < 1) then
        local Remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase")
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
        Settings["Status"] = "[ MARSHMALLOW ] : Purchasing Marshmallow ingredients."
        task.wait(.5)
        if (Water < 1) then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            Settings["Status"] = "[ MARSHMALLOW ] : Purchasing Marshmallow ingredients."
            local Argument = "Water"
            Remote:FireServer(Argument)
            task.wait(.5)
        end
        if (Gelatin < 1) then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            Settings["Status"] = "[ MARSHMALLOW ] : Purchasing Marshmallow ingredients."
            local Argument = "Gelatin"
            Remote:FireServer(Argument)
            task.wait(.5)
        end
        if (SugarBlockBag < 1) then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            Settings["Status"] = "[ MARSHMALLOW ] : Purchasing Marshmallow ingredients."
            local Argument = "Sugar Block Bag"
            Remote:FireServer(Argument)
            task.wait(.5)
        end
        return false
    else
        Settings["Status"] = "[ MARSHMALLOW ] : Successfully purchased Marshmallow ingredients."
        return true
    end
end

local Stove
local CookPrompt
local StoveTimer

local Labatory = workspace.Map.Locations["The Laboratory"]

local AvailablePot
local PotPrompt
local PotTimer

local PourWater = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    if tostring(Settings["Apartment"]):find("Home") then
        Stove = Settings["Apartment"]:FindFirstChild("Cooking Pot")
        CookPrompt = Stove:FindFirstChild("Attachment").ProximityPrompt
        StoveTimer = Stove:FindFirstChild("Timer").TextLabel
    else
        Stove = Settings["Apartment"]:WaitForChild("Interior"):FindFirstChild("Cooking Pot")
        CookPrompt = Stove:FindFirstChild("Attachment").ProximityPrompt
        StoveTimer = Stove:FindFirstChild("Timer").TextLabel
    end
    HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
    Settings["Status"] = "[ MARSHMALLOW ] : Pouring water into the pot."
    task.wait(.5)
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Water"))
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        task.wait(.2)
        fireproximityprompt(CookPrompt)
        task.wait(1)
        Humanoid:UnequipTools()
        task.wait(.1)
        Settings["Safety Counter"] += 1
    until not Player:WaitForChild("Backpack"):FindFirstChild("Water") or PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or Settings["Safety Counter"] >= 10
    Settings["Safety Counter"] = 0
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You do not have permission to cook in this apartment." then
        return false
    end
    return true
end

local AddSugarAndGelatin = function()
        if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
    Settings["Status"] = "[ MARSHMALLOW ] : Pouring Sugar into the pot."
    task.wait(.5)
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Sugar Block Bag"))
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        task.wait(.2)
        fireproximityprompt(CookPrompt)
        task.wait(1.25)
        Humanoid:UnequipTools()
        task.wait(.1)
        Settings["Safety Counter"] += 1
    until not Player:WaitForChild("Backpack"):FindFirstChild("Sugar Block Bag") or Settings["Safety Counter"] >= 5
    Settings["Safety Counter"] = 0

    Settings["Status"] = "[ MARSHMALLOW ] : Pouring Gelatin into the pot."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Gelatin"))
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        task.wait(.2)
        fireproximityprompt(CookPrompt)
        task.wait(1.25)
        Humanoid:UnequipTools()
        task.wait(.1)
        Settings["Safety Counter"] += 1
    until not Player:WaitForChild("Backpack"):FindFirstChild("Gelatin") or PlayerGui:WaitForChild("Main").TaskUpdate.TextLabel.Text:match("Let") or Settings["Safety Counter"] >= 5
    Settings["Safety Counter"] = 0
end

local BagMarshmallowAndSell = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ MARSHMALLOW ] : Bagging cooked Marshmallow."
    repeat
        HumanoidRootPart.CFrame = CFrame.new(Stove.Position)
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Empty Bag"))
        task.wait(.75)
        fireproximityprompt(CookPrompt)
        task.wait(.25)
        local oldhealth = Humanoid.Health
        Humanoid.Health = 70
        Humanoid:UnequipTools()
        task.wait(.25)
        Humanoid.Health = oldhealth
    until Player:WaitForChild("Backpack"):FindFirstChild("Small Marshmallow Bag") or Player:WaitForChild("Backpack"):FindFirstChild("Medium Marshmallow Bag") or Player:WaitForChild("Backpack"):FindFirstChild("Large Marshmallow Bag")
    repeat 
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
        task.wait() 
    until workspace:WaitForChild("Folders").NPCs:FindFirstChild("Lamont Bell")
    Settings["Status"] = "[ MARSHMALLOW ] : Selling cooked Marshmallow."
    local LamontBell = workspace:WaitForChild("Folders").NPCs:FindFirstChild("Lamont Bell")
    local LamontPrompt = LamontBell.UpperTorso.ProximityPrompt
    Humanoid:UnequipTools()
    task.wait(.1)
    for Index, Object in next, Player:WaitForChild("Backpack"):GetChildren() do
        if tostring(Object):find("Marshmallow") then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(510, 4, 595)
            Settings["Status"] = "[ MARSHMALLOW ] : Selling cooked Marshmallow."
            Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild(tostring(Object)))
            task.wait(.35)
            fireproximityprompt(LamontPrompt)
            task.wait(.25)
        end
    end
    Settings["Marshmallow Counter"] += 1
end

local PurchasePotatoIngredients = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Potato, Flour, Water, Gelatin, SugarBlockBag = ScavengeInventory()
    if (Potato < 1 or Flour < 1) then
        local Remote = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("StorePurchase")
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(-766, 4, -197)
        Settings["Status"] = "[ POTATO CHIP ] : Purchasing Potato Chips ingredients."
        task.wait(.5)
        if (Flour < 1) then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(-766, 4, -197)
            Settings["Status"] = "[ POTATO CHIP ] : Purchasing Potato Chips ingredients."
            local Argument = "Flour"
            Remote:FireServer(Argument)
            task.wait(.5)
        end
        if (Potato < 1) then
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            HumanoidRootPart.CFrame = CFrame.new(-766, 4, -197)
            Settings["Status"] = "[ POTATO CHIPS ] : Purchasing Potato Chips ingredients."
            local Argument = "Potato"
            Remote:FireServer(Argument)
            task.wait(.5)
        end
        return false
    else
        Settings["Status"] = "[ POTATO CHIP ] : Successfully purchased Potato Chips ingredients."
        return true
    end
end

local StartPotatoJob = function()
    local Clipboard = Labatory.Prompts.Clipboard
    local ClipboardPrompt = Labatory.Prompts.Clipboard.ProximityPrompt
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    HumanoidRootPart.CFrame = CFrame.new(Clipboard.Position)
    Settings["Status"] = "[ POTATO CHIPS ] : Claiming task."
    task.wait(.5)
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(Clipboard.Position)
        fireproximityprompt(ClipboardPrompt)
        task.wait()
    until PlayerGui:WaitForChild("Main").TaskUpdate.TextLabel.Text:match("Task:") or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You have already began your task."
end

local CutPotato = function()
    local PotatoCutter = Labatory["Cutting Boards"]:FindFirstChild("Potato Cutter").Model.Union
    local CutterPrompt = PotatoCutter.Attachment.ProximityPrompt
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ POTATO CHIPS ] : Cutting Potato Chips."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(PotatoCutter.Position)
        Settings["Status"] = "[ POTATO CHIPS ] : Cutting Potato Chips."
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Potato"))
        task.wait(.25)
        fireproximityprompt(CutterPrompt)
        task.wait(.5)
        Humanoid:UnequipTools()
        task.wait(.25)
        Settings["Safety Counter"] += 1
    until not Player:WaitForChild("Backpack"):FindFirstChild("Potato") or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are at the wrong step." or Settings["Safety Counter"] >= 20
    Settings["Safety Counter"] = 0
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are at the wrong step." then
        Humanoid.Health = 0
        return false
    end
end

local BagPotato = function()
    local PlasticBag = Labatory.Prompts["Plastic Bag"]
    local BagPrompt = PlasticBag.Attachment.ProximityPrompt
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ POTATO CHIPS ] : Bagging Potato Chips."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(PlasticBag.Position)
        Settings["Status"] = "[ POTATO CHIPS ] : Bagging Potato Chips."
        fireproximityprompt(BagPrompt)
        task.wait()
    until PlayerGui:WaitForChild("Main").TaskUpdate.TextLabel.Text:match("Head")
end

local MixFlourAndPotato = function()
    local Bowl = Labatory.Bowls:FindFirstChildOfClass("UnionOperation")
    local BowlPrompt = Bowl.ProximityPrompt
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ POTATO CHIPS ] : Mixing Flour and Potato Chips."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(Bowl.Position)
        Settings["Status"] = "[ POTATO CHIPS ] : Mixing Flour and Potato Chips."
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Flour"))
        task.wait(.25)
        fireproximityprompt(BowlPrompt)
        task.wait(.5)
        Humanoid:UnequipTools()
        task.wait(.05)
        Settings["Safety Counter"] += 1
    until not Player:WaitForChild("Backpack"):FindFirstChild("Flour") or Settings["Safety Counter"] >= 20
    Settings["Safety Counter"] = 0
    task.wait(3.5)
end

local CookPotatoChips = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ POTATO CHIPS ] : Attempting to cook Potato Chips."
    for Index, Object in next, Labatory.Pots:GetChildren() do
        if (Object:IsA("UnionOperation")) then
            repeat
                if Settings["Autofarm Enabled"] ~= true then
                    repeat task.wait() until Settings["Autofarm Enabled"] == true
                end
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] ~= true
                end
                HumanoidRootPart.CFrame = CFrame.new(Object.Position)
                fireproximityprompt(Object.ProximityPrompt)
                task.wait(.05)
                Settings["Safety Counter"] += 1
            until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or Settings["Safety Counter"] >= 80
            Settings["Safety Counter"] = 0
            if PlayerGui:WaitForChild("Main").BasicNotification.Text == "This pot is in use." then
                repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 1
            else
                AvailablePot = Object
                PotTimer = Object.Timer.TextLabel
                PotPrompt = Object.ProximityPrompt
                break
            end
        end
    end
    if not AvailablePot then
        return false
    else
        return true
    end
end

local ClaimPotatoChipsAndSell = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ POTATO CHIPS ] : Grabbing cooked Potato Chips."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(AvailablePot.Position)
        fireproximityprompt(PotPrompt)
        task.wait(.1)
    until Player:WaitForChild("Backpack"):FindFirstChild("Potato Chips")
    Settings["Status"] = "[ POTATO CHIPS ] : Turning Potato Chips into Hot Chips."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(-36, 4, -24)
        task.wait()
    until workspace:WaitForChild("Folders").NPCs:FindFirstChild("Poor Guy")
    local PoorGuy = workspace:WaitForChild("Folders").NPCs:FindFirstChild("Poor Guy")
    local PoorGuyPrompt = PoorGuy.UpperTorso.ProximityPrompt
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(-36, 4, -24)
        Settings["Status"] = "[ POTATO CHIPS ] : Turning Potato Chips into Hot Chips."
        fireproximityprompt(PoorGuyPrompt)
        Humanoid:UnequipTools()
        task.wait()
    until Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips")
    Settings["Status"] = "[ POTATO CHIPS ] : Avoiding server kick, yielding."
    task.wait(4)
    Settings["Status"] = "[ POTATO CHIPS ] : Giving Hot Chips to homeless people."
    local AvailableHomeless = FindAvailableHomeless()
    if #AvailableHomeless ~= 0 then
        repeat
            if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
            end
            if Settings["IsHealing"] == true then
                repeat task.wait() until Settings["IsHealing"] ~= true
            end
            Settings["Status"] = "[ POTATO CHIPS ] : Giving Hot Chips to homeless people."
            AvailableHomeless = AvailableHomeless[Random:NextInteger(1, #AvailableHomeless)]
            local UpperTorsoPos = AvailableHomeless:FindFirstChild("UpperTorso").Position
            repeat
                HumanoidRootPart.CFrame = CFrame.new(UpperTorsoPos)
                task.wait()
            until workspace:WaitForChild("Folders").HomelessPeople:FindFirstChild(tostring(AvailableHomeless))
            AvailableHomeless = workspace:WaitForChild("Folders").HomelessPeople:FindFirstChild(tostring(AvailableHomeless))
            local UpperTorso = AvailableHomeless:FindFirstChild("UpperTorso")
            local HomelessPrompt = UpperTorso.ProximityPrompt
            for Index = 1,5 do
                Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips"))
                HumanoidRootPart.CFrame = CFrame.new(UpperTorso.Position)
                fireproximityprompt(HomelessPrompt)
                task.wait(.1)
            end
            Humanoid:UnequipTools()
            task.wait(.05)
            if Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips") then
                AvailableHomeless = FindAvailableHomeless()
            else
                AvailableHomeless = {}
            end
            task.wait()
            Settings["Safety Counter"] += 1
        until #AvailableHomeless == 0 or not Player:WaitForChild("Backpack"):FindFirstChild("Hot Chips") or Settings["Safety Counter"] >= 8
        Settings["Potato Counter"] += 1
        Settings["Safety Counter"] = 0
        return true
    else
        return false
    end
end

local PurchaseFakeID = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ CARDS ] : Attempting to purchase a Fake ID."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(215, 6, -332)
        task.wait()
    until workspace:WaitForChild("Folders").NPCs:FindFirstChild("FakeIDSeller")
    local FakeIDSeller = workspace:WaitForChild("Folders").NPCs:FindFirstChild("FakeIDSeller")
    local BuyIDPrompt = FakeIDSeller.UpperTorso.Attachment.ProximityPrompt
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        repeat
            HumanoidRootPart.CFrame = CFrame.new(215, 6, -332)
            task.wait()
        until workspace:WaitForChild("Folders").NPCs:FindFirstChild("FakeIDSeller")
        FakeIDSeller = workspace:WaitForChild("Folders").NPCs:FindFirstChild("FakeIDSeller")
        BuyIDPrompt = FakeIDSeller.UpperTorso.Attachment.ProximityPrompt
        HumanoidRootPart.CFrame = CFrame.new(215, 6, -332)
        fireproximityprompt(BuyIDPrompt)
        task.wait()
        Humanoid:UnequipTools()
    until Player:WaitForChild("Backpack"):FindFirstChild("Fake ID")
    task.wait(4.25)
end

local ApplyForCard = function()
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ CARDS ] : Attempting to apply for a credit card."
    repeat
        HumanoidRootPart.CFrame = CFrame.new(-48, 4, -315)
        task.wait()
    until workspace:WaitForChild("Folders").NPCs:FindFirstChild("Bank Teller")
    local BankTeller = workspace:WaitForChild("Folders").NPCs:FindFirstChild("Bank Teller")
    local BankPrompt = BankTeller.UpperTorso.Attachment.ProximityPrompt
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(-48, 4, -315)
        Settings["Status"] = "[ CARDS ] : Attempting to apply for a credit card."
        Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Fake ID"))
        task.wait(.75)
        fireproximityprompt(BankPrompt)
        task.wait(.5)
        local oldhealth = Humanoid.Health
        Humanoid.Health = 70
        Humanoid:UnequipTools()
        task.wait(.25)
        Humanoid.Health = oldhealth
        Settings["Safety Counter"] += 1
    until not Player:WaitForChild("Backpack"):FindFirstChild("Fake ID") or Settings["Safety Counter"] >= 15
    if Settings["Safety Counter"] >= 15 then
        local Card = workspace:WaitForChild("CardPickup")
        local CardPrompt = Card.Attachment.ProximityPrompt
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        Settings["Status"] = "[ CARDS ] : Attempting to claim credit card."
        for Index = 1, 10 do
            HumanoidRootPart.CFrame = CFrame.new(Card.Position)
            fireproximityprompt(CardPrompt)
            task.wait(.05)
            Humanoid:UnequipTools()
        end
    end
    Settings["Safety Counter"] = 0
end

local ClaimAndUseCard = function()
    local Card = workspace:WaitForChild("CardPickup")
    local CardPrompt = Card.Attachment.ProximityPrompt
    if Settings["Autofarm Enabled"] ~= true then
        repeat task.wait() until Settings["Autofarm Enabled"] == true
    end
    if Settings["IsHealing"] == true then
        repeat task.wait() until Settings["IsHealing"] ~= true
    end
    Settings["Status"] = "[ CARDS ] : Attempting to claim credit card."
    repeat
        if Settings["Autofarm Enabled"] ~= true then
            repeat task.wait() until Settings["Autofarm Enabled"] == true
        end
        if Settings["IsHealing"] == true then
            repeat task.wait() until Settings["IsHealing"] ~= true
        end
        HumanoidRootPart.CFrame = CFrame.new(Card.Position)
        CardPrompt = Card.Attachment.ProximityPrompt
        fireproximityprompt(CardPrompt)
        task.wait(.05)
        Settings["Safety Counter"] += 1
    until Player:WaitForChild("Backpack"):FindFirstChild("Card") or PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are not on the wait list for a card." or Settings["Safety Counter"] >= 200
    Settings["Safety Counter"] = 0
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "You are not on the wait list for a card." and not Player:WaitForChild("Backpack"):FindFirstChild("Card") then
        return false
    else
        repeat
            local AvailableATM = FindAvailableATMs()
            if (AvailableATM) then
                local ATMPrompt = AvailableATM.Attachment.ProximityPrompt
                if Settings["Autofarm Enabled"] ~= true then
                repeat task.wait() until Settings["Autofarm Enabled"] == true
                end
                if Settings["IsHealing"] == true then
                    repeat task.wait() until Settings["IsHealing"] ~= true
                end
                task.wait(1.5)
                Settings["Status"] = "[ CARDS ] : Attempting to use credit card on ATM."
                if (PlayerGui:FindFirstChild("ATM")) then
                    PlayerGui:FindFirstChild("ATM"):Destroy()
                end
                repeat
                    if Settings["Autofarm Enabled"] ~= true then
                        repeat task.wait() until Settings["Autofarm Enabled"] == true
                    end
                    if Settings["IsHealing"] == true then
                        repeat task.wait() until Settings["IsHealing"] ~= true
                    end
                    HumanoidRootPart.CFrame = CFrame.new(AvailableATM.Position)
                    Settings["Status"] = "[ CARDS ] : Attempting to use credit card on ATM."
                    fireproximityprompt(ATMPrompt)
                    task.wait()
                until PlayerGui:FindFirstChild("ATM")
                Humanoid:EquipTool(Player:WaitForChild("Backpack"):FindFirstChild("Card"))
                task.wait(.25)
                replicatesignal(PlayerGui:WaitForChild("ATM").Frame.Swipe.MouseButton1Click, Player)
                Settings["Status"] = "[ CARDS ] : Swiping credit card."
                task.wait(.15)
                Humanoid:UnequipTools()
                task.wait(.1)
            else
                return false
            end
            task.wait()
        until not Player:WaitForChild("Backpack"):FindFirstChild("Card")
        Settings["Cards Counter"] += 1
    end
end

local function MainAutofarmController()
    repeat task.wait() until Settings["Ready"] == true
    local CardWaitTime = 1
    local Animation = Instance.new('Animation')
    Animation.AnimationId = "rbxassetid://126995783634131"
    local Track = game.Players.LocalPlayer.Character:FindFirstChild('Humanoid'):FindFirstChild('Animator'):LoadAnimation(Animation)
    Track.Priority = Enum.AnimationPriority.Action4
    Track:Play()
    repeat task.wait() until Settings["Sufficient Cash"] == true
    repeat task.wait() until Settings["Purchasing Ski-Mask"] == false
    task.wait(.1)
    repeat task.wait() until Settings["Purchasing Apartment"] == false

    PurchaseSkiMask()
    StartMarshmallowFarm()

    local MarshIngredients = PurchaseMarshmallowIngredients()
    if (MarshIngredients == false) then
        MarshIngredients = PurchaseMarshmallowIngredients()
        if (MarshIngredients == false) then
            repeat
                task.wait(15)
                MarshIngredients = PurchaseMarshmallowIngredients()
            until MarshIngredients == true
        end
    end

    local WaterStep = PourWater()
    if (WaterStep == false) then
        repeat
            StartMarshmallowFarm()
            WaterStep = PourWater()
        until WaterStep == true
    end

    local PotatoIngredients = PurchasePotatoIngredients()
    if (PotatoIngredients == false) then
        PotatoIngredients = PurchasePotatoIngredients()
        if (MarshIngredients == false) then
            repeat
                task.wait(15)
                PotatoIngredients = PurchasePotatoIngredients()
            until PotatoIngredients == true
        end
    end

    StartPotatoJob()
    PurchaseFakeID()
    CutPotato()
    BagPotato()
    MixFlourAndPotato()
    local PotSuccessful = CookPotatoChips()
    ApplyForCard()
    AddSugarAndGelatin()

    Settings["Status"] = "[ CARDS ] : Waiting on application status."
    repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was successful. Please allow 30 seconds for the bank to prepare your card." or PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was unsuccessful." or PlayerGui:WaitForChild("Main").TaskUpdate.TextLabel.Text:match("Bag")
    if PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was unsuccessful." then
        PurchaseFakeID()
        ApplyForCard()
        Settings["Status"] = "[ CARDS ] : Waiting on application status."
        repeat task.wait() until PlayerGui:WaitForChild("Main").BasicNotification.TextTransparency == 0 or PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was successful. Please allow 30 seconds for the bank to prepare your card." or PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was unsuccessful." or PlayerGui:WaitForChild("Main").TaskUpdate.TextLabel.Text:match("Bag")
        if PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was unsuccessful." then
        elseif PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was successful. Please allow 30 seconds for the bank to prepare your card." then
            Settings["Status"] = "[ CARDS ] : Application was successful, waiting for Marshmallow to finish cooking."
            CardWaitTime = 2
        end
    elseif PlayerGui:WaitForChild("Main").BasicNotification.Text == "Your application was successful. Please allow 30 seconds for the bank to prepare your card." then
        CardWaitTime = 0
    end

    if (CardWaitTime == 0) then
        Settings["Status"] = "[ CARDS ] : Application was successful, waiting for card to be ready."
        task.wait(28)
        local DoCardJ_B = ClaimAndUseCard()
        if DoCardJ_B == false then
            Settings["Status"] = "[ CARDS ] : ATM not available, skipping cards."
        end
        Settings["Status"] = "[ MARSHMALLOW ] : Waiting for Marshmallow to finish cooking."
        repeat task.wait() until StoveTimer.Text == "0"
        BagMarshmallowAndSell()
        Settings["Status"] = "[ POTATO CHIPS ] : Waiting for Potato Chips to finish cooking."
        repeat task.wait() until PotTimer.Text == "0"
        local PotatoSellAttempt = ClaimPotatoChipsAndSell()
        if (PotatoSellAttempt == false) then
            Settings["Status"] = "[ POTATO CHIPS ] : POTATO ERROR, skipping Potato Chips."
        end
    elseif (CardWaitTime == 2) then
        Settings["Status"] = "[ MARSHMALLOW ] : Waiting for Marshmallow to finish cooking."
        repeat task.wait() until StoveTimer.Text == "0"
        BagMarshmallowAndSell()
        Settings["Status"] = "[ POTATO CHIPS ] : Waiting for Potato Chips to finish cooking."
        repeat task.wait() until PotTimer.Text == "0"
        local PotatoSellAttempt = ClaimPotatoChipsAndSell()
        if (PotatoSellAttempt == false) then
            Settings["Status"] = "[ POTATO CHIPS ] : POTATO ERROR, skipping Potato Chips."
        end
        ClaimAndUseCard()
    else
        Settings["Status"] = "[ MARSHMALLOW ] : Waiting for Marshmallow to finish cooking."
        repeat task.wait() until StoveTimer.Text == "0"
        BagMarshmallowAndSell()
        Settings["Status"] = "[ POTATO CHIPS ] : Waiting for Potato Chips to finish cooking."
        repeat task.wait() until PotTimer.Text == "0"
        local PotatoSellAttempt = ClaimPotatoChipsAndSell()
        if (PotatoSellAttempt == false) then
            Settings["Status"] = "[ POTATO CHIPS ] : POTATO ERROR, skipping Potato Chips."
        end
    end
    Data["Cycles"] += 1
    MainAutofarmController()
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Auto Farm V2",
   Icon = 0, 
   LoadingTitle = "Auto Farm V2",
   LoadingSubtitle = "by T and Logan",
   ShowText = "South Bronx", 
   Theme = "Default", 

   ToggleUIKeybind = "Z",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "SBAutofarmV2"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true, 
      GrabKeyFromSite = false, 
      Key = {"Hello"}
   }
})

local Tab = Window:CreateTab("Main", 4483362458)
local Section = Tab:CreateSection("Autofarm")
local Toggle = Tab:CreateToggle({
   Name = "Autofarming",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
    Settings["Autofarm Enabled"] = Value
   end,
})
local Toggle2 = Tab:CreateToggle({
   Name = "Auto rejoin",
   CurrentValue = true,
   Flag = "Toggle2",
   Callback = function(Value)
    Settings["Auto Rejoin"] = Value
   end,
})

local Tab2 = Window:CreateTab("Goal System", 4483362458)
local Section2 = Tab2:CreateSection("Goal System")
local Toggle3 = Tab2:CreateToggle({
   Name = "Goal Cash System",
   CurrentValue = true,
   Flag = "Toggle3",
   Callback = function(Value)
    GoalCashSettings["Goal Cash"] = Value
   end,
})
local Toggle4 = Tab2:CreateToggle({
   Name = "Goal Cash Memory",
   CurrentValue = true,
   Flag = "Toggle4",
   Callback = function(Value)
    GoalCashSettings["Memorize Goal"] = Value
   end,
})
local Slider2 = Tab2:CreateSlider({
   Name = "Target Cash",
   Range = {0, 1750000},
   Increment = 5000,
   Suffix = "Goal",
   CurrentValue = 100000,
   Flag = "Slider1",
   Callback = function(Value)
    GoalCashSettings["Goal Amount"] = Value
   end,
})
local Input = Tab2:CreateInput({
   Name = "Target Cash",
   CurrentValue = "",
   PlaceholderText = "Goal",
   RemoveTextAfterFocusLost = false,
   Flag = "Input1",
   Callback = function(Text)
    if tonumber(Text) == nil then
        Slider2:Set(100000)
    else
        if tonumber(Text) >= 0 and tonumber(Text) <= 1750000 then
            GoalCashSettings["Goal Amount"] = tonumber(Text)
            Slider2:Set(tonumber(Text))
        else
            GoalCashSettings["Goal Amount"] = 100000
            Slider2:Set(100000)
        end
    end
   end,
})

local Button = Tab2:CreateButton({
   Name = "CLEAR GOAL CACHE : Resets Goal Memory",
   Callback = function()
    ClearGoalCache()
   end,
})

local Paragraph = Tab:CreateParagraph({Title = "Status Information", Content = "[ Startup ] Status: none"})
local Paragraph2 = Tab:CreateParagraph({Title = "Runtime Information", Content = "Runtime: nil  |  Cycle: nil  |  Money Made: nil"})
local Paragraph3 = Tab:CreateParagraph({Title = "Sold Information", Content = "Potato Chips Fed: nil | Marshmallows Sold: nil | Credit Cards Used: nil"})
local Paragraph4 = Tab:CreateParagraph({Title = "Hourly Rate Information", Content = "Hourly Rate: nil"})
local Paragraph5 = Tab2:CreateParagraph({Title = "Estimated Time Information", Content = "Estimated Time: nil"})
task.spawn(function()
    if (Settings["Rejoined"] == true) then
        Settings["Autofarm Enabled"] = true
        Toggle:Set(true)
    end
    repeat task.wait() until PlayerGui:FindFirstChild("IntroUI")
    local IntroUI = PlayerGui:FindFirstChild("IntroUI")
    repeat task.wait() until IntroUI:FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("Play")
    local PlayButton = IntroUI:FindFirstChild("SurfaceGui"):FindFirstChild("Frame"):FindFirstChild("Play")
    task.wait(15)
    repeat
        getconnections(PlayButton.MouseButton1Click)[1]:Fire()
        task.wait(.25)
    until not PlayerGui:FindFirstChild("IntroUI")
    Settings["Ready"] = true
end)
repeat task.wait() until Settings["Ready"] == true
Slider2:Set(GoalCashSettings["Goal Amount"])
if GoalCashSettings["Goal Cash"] == true then
    Toggle3:Set(true)
else
    Toggle3:Set(false)
end
if GoalCashSettings["Memorize Goal"] == true then
    Toggle4:Set(true)
else
    Toggle4:Set(false)
end
task.spawn(MainAutofarmController)
task.spawn(function()
    while task.wait() do
        Data["Run Time"] = os.clock() - Start
        local Information = "Runtime: " .. tostring(FormatTime(Data["Run Time"])) .. "  |  Cycle: " .. tostring(Data["Cycles"]) .. "  |  Money Made: " .. tostring(GetCommaValue(Data["Cash Change"])) .. " Cash"
        local SellInfo = "Potato Chips Fed: " .. Settings["Potato Counter"] .. " | Marshmallows Sold: " .. Settings["Marshmallow Counter"] .. " | Credit Cards Used: " .. Settings["Cards Counter"]
        local HourlyRate = "Current Hourly Rate Estimated: " .. tostring(GetCommaValue(math.floor(3600/math.floor(Data["Run Time"]) * (Data["Cash Change"]) - GoalCashSettings["Extra Cash"]))) .. " Cash"
        local HourlyRate2 = tostring(math.floor(3600/math.floor(Data["Run Time"]) * (Data["Cash Change"] - GoalCashSettings["Extra Cash"])))
        local EstimatedTime = "Estimated Time Until Goal: " .. tostring(FormatTime(((GoalCashSettings["Goal Amount"] - tonumber(Data["Cash Change"]))/tonumber(HourlyRate2)) * 3600)) .. " Left"
        Paragraph:Set({Title = "Status Information", Content = Settings["Status"]})
        Paragraph2:Set({Title = "Runtime Information", Content = Information})
        Paragraph3:Set({Title = "Sold Information", Content = SellInfo})
        Paragraph4:Set({Title = "Hourly Rate Information", Content = HourlyRate})
        Paragraph5:Set({Title = "Estimated Time Information", Content = EstimatedTime})
    end
end)

if not Authentication then
    Player:Kick("Skid Protection.")
    task.wait(1)
    while true do
        print("67 skids I love em chatgpt boii city boii")
    end
else
    if Authentication ~= "Logan+TStudiedHyphonFor5Years" then
        Player:Kick("Skid Protection.")
        task.wait(1)
        while true do
            print("67 skids I love em chatgpt boii city boii")
        end
    end
end
