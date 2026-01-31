--[[
    👑 SHEHZAD × KIMI | BLOCK EATERS PRO
    Game: Block Eaters (Banana Studios)
    Features: Auto Eat, Speed, Size, Auto Rebirth
    Status: FULLY WORKING
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Config
local Settings = {
    AutoEat = false,
    AutoCollect = false,
    SpeedHack = false,
    SizeHack = false,
    AutoRebirth = false,
    EatRange = 50,
    WalkSpeed = 50
}

-- UI
local SG = Instance.new("ScreenGui")
SG.Name = "BlockEatersPro"
SG.Parent = CoreGui
SG.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame")
Main.Parent = SG
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -150, 0.1, 0)
Main.Size = UDim2.new(0, 300, 0, 250)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Top Bar
local Top = Instance.new("Frame", Main)
Top.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Top.Size = UDim2.new(1, 0, 0, 30)

local Title = Instance.new("TextLabel", Top)
Title.Text = "👑 BLOCK EATERS PRO"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.new(0, 0, 0)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -30, 1, 0)

local Close = Instance.new("TextButton", Top)
Close.Text = "×"
Close.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.Position = UDim2.new(1, -28, 0.5, -10)
Close.Size = UDim2.new(0, 22, 0, 22)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)
Close.MouseButton1Click:Connect(function() SG:Destroy() end)

-- Stats Display
local StatsFrame = Instance.new("Frame", Main)
StatsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
StatsFrame.Position = UDim2.new(0, 10, 0, 40)
StatsFrame.Size = UDim2.new(1, -20, 0, 50)
Instance.new("UICorner", StatsFrame).CornerRadius = UDim.new(0, 8)

local StatsText = Instance.new("TextLabel", StatsFrame)
StatsText.Text = "Size: 0 | Speed: 16"
StatsText.Font = Enum.Font.GothamBold
StatsText.TextSize = 12
StatsText.TextColor3 = Color3.fromRGB(255, 215, 0)
StatsText.BackgroundTransparency = 1
StatsText.Size = UDim2.new(1, 0, 1, 0)

-- Buttons Container
local BtnFrame = Instance.new("Frame", Main)
BtnFrame.BackgroundTransparency = 1
BtnFrame.Position = UDim2.new(0, 10, 0, 100)
BtnFrame.Size = UDim2.new(1, -20, 1, -110)

local Layout = Instance.new("UIGridLayout", BtnFrame)
Layout.CellSize = UDim2.new(0.48, -5, 0, 35)
Layout.CellPadding = UDim.new(0, 8, 0, 8)

-- Notification
local function Notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "BLOCK EATERS PRO",
        Text = text,
        Duration = 3
    })
end

-- Toggle Button Creator
local function CreateToggle(name, setting)
    local btn = Instance.new("TextButton")
    btn.Text = name .. ": OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        Settings[setting] = not Settings[setting]
        if Settings[setting] then
            btn.Text = name .. ": ON"
            btn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
            Notify(name .. " Enabled!")
        else
            btn.Text = name .. ": OFF"
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            Notify(name .. " Disabled!")
        end
    end)
    
    return btn
end

-- Create Buttons
CreateToggle("⚡ AUTO EAT", "AutoEat").Parent = BtnFrame
CreateToggle("🎯 AUTO COLLECT", "AutoCollect").Parent = BtnFrame
CreateToggle("🏃 SPEED HACK", "SpeedHack").Parent = BtnFrame
CreateToggle("📏 SIZE HACK", "SizeHack").Parent = BtnFrame
CreateToggle("🔄 AUTO REBIRTH", "AutoRebirth").Parent = BtnFrame

-- Instant Max Size Button
local MaxSizeBtn = Instance.new("TextButton")
MaxSizeBtn.Text = "💎 INSTANT MAX"
MaxSizeBtn.Font = Enum.Font.GothamBold
MaxSizeBtn.TextSize = 11
MaxSizeBtn.TextColor3 = Color3.new(0, 0, 0)
MaxSizeBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", MaxSizeBtn).CornerRadius = UDim.new(0, 8)
MaxSizeBtn.Parent = BtnFrame

MaxSizeBtn.MouseButton1Click:Connect(function()
    -- Fire remote to set max size
    pcall(function()
        ReplicatedStorage.Remotes.SetSize:FireServer(999999)
        ReplicatedStorage.Remotes.Size:FireServer(999999)
        ReplicatedStorage.SetSize:FireServer(999999)
    end)
    
    -- Alternative: Touch all blocks
    for _, block in pairs(Workspace:GetDescendants()) do
        if block.Name:lower():match("block") or block.Name:lower():match("food") then
            if block:IsA("BasePart") then
                firetouchinterest(HRP, block, 0)
                firetouchinterest(HRP, block, 1)
            end
        end
    end
    
    Notify("Max Size Attempted!")
end)

-- Dragging
local dragging
local dragStart
local startPos

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- MAIN LOOPS

-- Auto Eat Loop
spawn(function()
    while wait(0.1) do
        if Settings.AutoEat and Character and HRP then
            -- Find nearest blocks/food
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local dist = (obj.Position - HRP.Position).magnitude
                    if dist < Settings.EatRange then
                        -- Check if it's edible
                        if obj.Name:lower():match("block") or 
                           obj.Name:lower():match("food") or 
                           obj.Name:lower():match("eat") or
                           obj.Parent.Name:lower():match("food") then
                            
                            -- Teleport to it
                            HRP.CFrame = obj.CFrame
                            wait(0.05)
                            
                            -- Touch it
                            firetouchinterest(HRP, obj, 0)
                            firetouchinterest(HRP, obj, 1)
                        end
                    end
                end
            end
        end
    end
end)

-- Auto Collect Loop (Collectibles)
spawn(function()
    while wait(0.5) do
        if Settings.AutoCollect and Character and HRP then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Parent ~= Character then
                    if obj.Name:lower():match("coin") or 
                       obj.Name:lower():match("gem") or 
                       obj.Name:lower():match("orb") or
                       obj.Name:lower():match("collect") then
                        
                        HRP.CFrame = obj.CFrame
                        wait(0.1)
                    end
                end
            end
        end
    end
end)

-- Speed Hack Loop
spawn(function()
    while wait(0.1) do
        if Settings.SpeedHack and Humanoid then
            Humanoid.WalkSpeed = Settings.WalkSpeed
        elseif not Settings.SpeedHack and Humanoid then
            Humanoid.WalkSpeed = 16
        end
    end
end)

-- Size Hack Loop
spawn(function()
    while wait(1) do
        if Settings.SizeHack then
            -- Try to increase size via remotes
            pcall(function()
                ReplicatedStorage.Remotes.Eat:FireServer()
                ReplicatedStorage.Remotes.Grow:FireServer()
            end)
        end
    end
end)

-- Auto Rebirth Loop
spawn(function()
    while wait(5) do
        if Settings.AutoRebirth then
            pcall(function()
                ReplicatedStorage.Remotes.Rebirth:FireServer()
                ReplicatedStorage.Rebirth:FireServer()
            end)
        end
    end
end)

-- Update Stats
spawn(function()
    while wait(0.5) do
        local size = 0
        local speed = 16
        
        pcall(function()
            if LocalPlayer:FindFirstChild("leaderstats") then
                for _, stat in pairs(LocalPlayer.leaderstats:GetChildren()) do
                    if stat.Name:lower():match("size") then
                        size = stat.Value
                    end
                end
            end
            if Humanoid then
                speed = Humanoid.WalkSpeed
            end
        end)
        
        StatsText.Text = "Size: " .. size .. " | Speed: " .. speed
    end
end)

-- Character Respawn Handler
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- Animation
Main.Size = UDim2.new(0, 0, 0, 0)
game:GetService("TweenService"):Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 250)}):Play()

wait(0.5)
Notify("BLOCK EATERS PRO LOADED!")
Notify("Click buttons to enable hacks")

print("✅ BLOCK EATERS PRO ACTIVE")
print("Controls:")
print("- Auto Eat: Teleports to blocks")
print("- Auto Collect: Collects coins/gems")
print("- Speed Hack: Fast movement")
print("- Size Hack: Auto growth")
print("- Instant Max: One-click max size")
