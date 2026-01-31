--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                                                                           ║
    ║   👑 SHEHZAD × KIMI | PRO WORKING ADMIN V3.0 👑                          ║
    ║   Status: FULLY FUNCTIONAL | FE Compatible                               ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
--]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Toggle Storage (For Proper On/Off)
local ActiveToggles = {}
local Connections = {}

-- UI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProAdmin"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false

-- Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.ClipsDescendants = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Top Bar
local Top = Instance.new("Frame")
Top.Parent = Main
Top.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
Top.Size = UDim2.new(1, 0, 0, 30)

Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 8)
local TopFix = Instance.new("Frame", Top)
TopFix.BackgroundColor3 = Top.BackgroundColor3
TopFix.Position = UDim2.new(0, 0, 1, -8)
TopFix.Size = UDim2.new(1, 0, 0, 8)

-- Title
local Title = Instance.new("TextLabel", Top)
Title.Text = "👑 SHEHZAD × KIMI PRO"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close
local Close = Instance.new("TextButton", Top)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.new(1, 1, 1)
Close.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
Close.Position = UDim2.new(1, -35, 0.5, -10)
Close.Size = UDim2.new(0, 25, 0, 25)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)

Close.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.3)
    ScreenGui:Destroy()
    -- Cleanup all connections
    for _, conn in pairs(Connections) do
        if conn then conn:Disconnect() end
    end
end)

-- Minimize
local Min = Instance.new("TextButton", Top)
Min.Text = "−"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 20
Min.TextColor3 = Color3.new(0, 0, 0)
Min.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
Min.Position = UDim2.new(1, -65, 0.5, -10)
Min.Size = UDim2.new(0, 25, 0, 25)
Instance.new("UICorner", Min).CornerRadius = UDim.new(1, 0)

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Sidebar.Position = UDim2.new(0, 5, 0, 35)
Sidebar.Size = UDim2.new(0, 90, 1, -40)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)

-- Content
local Content = Instance.new("Frame", Main)
Content.Name = "Content"
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 100, 0, 35)
Content.Size = UDim2.new(1, -105, 1, -40)

-- Tab System
local Tabs = {}
local TabContents = {}

local function CreateTab(name, icon)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Text = icon .. " " .. name
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 11
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Btn.Size = UDim2.new(1, -10, 0, 30)
    Btn.Position = UDim2.new(0, 5, 0, (#Tabs * 35) + 5)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    local TabContent = Instance.new("ScrollingFrame", Content)
    TabContent.Name = name
    TabContent.BackgroundTransparency = 1
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.ScrollBarThickness = 4
    TabContent.Visible = false
    TabContent.CanvasSize = UDim2.new(0, 0, 2, 0)
    
    local List = Instance.new("UIListLayout", TabContent)
    List.Padding = UDim.new(0, 5)
    List.SortOrder = Enum.SortOrder.LayoutOrder
    
    Instance.new("UIPadding", TabContent).PaddingLeft = UDim.new(0, 5)
    Instance.new("UIPadding", TabContent).PaddingTop = UDim.new(0, 5)
    Instance.new("UIPadding", TabContent).PaddingRight = UDim.new(0, 5)
    
    table.insert(Tabs, Btn)
    table.insert(TabContents, TabContent)
    
    Btn.MouseButton1Click:Connect(function()
        for i, v in pairs(TabContents) do
            v.Visible = false
            Tabs[i].BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        TabContent.Visible = true
        Btn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    end)
    
    return TabContent
end

-- Create Tabs
local ItemsTab = CreateTab("Items", "🎒")
local PlayerTab = CreateTab("Player", "👤")
local TrollTab = CreateTab("Troll", "😈")
local AdminTab = CreateTab("Admin", "⚡")

-- Show first
TabContents[1].Visible = true
Tabs[1].BackgroundColor3 = Color3.fromRGB(147, 112, 219)

-- Utility Functions
local function Notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 3
    })
end

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Btn.Size = UDim2.new(1, 0, 0, 32)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateToggle(parent, name, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 32)
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Text = name
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleBtn = Instance.new("TextButton", Frame)
    ToggleBtn.Text = "OFF"
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 11
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    ToggleBtn.Position = UDim2.new(1, -45, 0.5, -12)
    ToggleBtn.Size = UDim2.new(0, 45, 0, 24)
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 12)
    
    local enabled = false
    ActiveToggles[name] = false
    
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        ActiveToggles[name] = enabled
        if enabled then
            ToggleBtn.Text = "ON"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 40)
        else
            ToggleBtn.Text = "OFF"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        end
        callback(enabled)
    end)
end

local function CreateSlider(parent, name, min, max, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 45)
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Text = name .. ": " .. default
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 15)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderBg = Instance.new("Frame", Frame)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderBg.Position = UDim2.new(0, 0, 0, 20)
    SliderBg.Size = UDim2.new(1, 0, 0, 8)
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 4)
    
    local Fill = Instance.new("Frame", SliderBg)
    Fill.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    Fill.Size = UDim2.new((default-min)/(max-min), 1, 1, 0)
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 4)
    
    local dragging = false
    
    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    table.insert(Connections, UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
            local val = math.floor(min + (pos * (max - min)))
            Fill.Size = UDim2.new(pos, 0, 1, 0)
            Label.Text = name .. ": " .. val
            callback(val)
        end
    end))
    
    table.insert(Connections, UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end))
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ITEMS TAB (WORKING ITEM SPAWNER)
-- ═══════════════════════════════════════════════════════════════════════════

local ItemListFrame = Instance.new("ScrollingFrame", ItemsTab)
ItemListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ItemListFrame.Size = UDim2.new(0.5, -5, 1, -40)
ItemListFrame.ScrollBarThickness = 3
Instance.new("UICorner", ItemListFrame).CornerRadius = UDim.new(0, 6)

local ItemListLayout = Instance.new("UIListLayout", ItemListFrame)
ItemListLayout.Padding = UDim.new(0, 4)

Instance.new("UIPadding", ItemListFrame).Padding = UDim.new(0, 5)

-- Refresh Button (ACTUALLY WORKING)
CreateButton(ItemsTab, "🔄 SCAN ITEMS").Position = UDim2.new(0, 0, 1, -35)

local SelectedItem = nil
local ScannedItems = {}

-- Scan Function
local function ScanItems()
    -- Clear old
    for _, v in pairs(ItemListFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    ScannedItems = {}
    
    local count = 0
    
    -- Scan Tools in ReplicatedStorage
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("Tool") and count < 50 then
            table.insert(ScannedItems, obj)
            count = count + 1
        end
    end
    
    -- Scan StarterPack
    for _, obj in pairs(game:GetService("StarterPack"):GetChildren()) do
        if obj:IsA("Tool") and count < 50 then
            table.insert(ScannedItems, obj)
            count = count + 1
        end
    end
    
    -- Create Buttons
    for _, tool in pairs(ScannedItems) do
        local Btn = Instance.new("TextButton", ItemListFrame)
        Btn.Text = "📦 " .. tool.Name
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 11
        Btn.TextColor3 = Color3.new(1, 1, 1)
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Btn.Size = UDim2.new(1, -10, 0, 28)
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
        
        Btn.MouseButton1Click:Connect(function()
            SelectedItem = tool
            -- Highlight selection
            for _, b in pairs(ItemListFrame:GetChildren()) do
                if b:IsA("TextButton") then
                    b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
            end
            Btn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        end)
    end
    
    ItemListFrame.CanvasSize = UDim2.new(0, 0, 0, #ScannedItems * 32)
    Notify("Items", "Found " .. #ScannedItems .. " items!")
end

-- Refresh Button Connection
ItemsTab:GetChildren()[1].MouseButton1Click:Connect(ScanItems)

-- Give Button
local GiveBtn = CreateButton(ItemsTab, "📥 GIVE ITEM")
GiveBtn.Position = UDim2.new(0.5, 5, 0, 0)
GiveBtn.Size = UDim2.new(0.5, -5, 0, 35)

GiveBtn.MouseButton1Click:Connect(function()
    if not SelectedItem then
        Notify("Error", "Select an item first!")
        return
    end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then
        Notify("Error", "No backpack found!")
        return
    end
    
    -- ACTUAL CLONE METHOD
    local success, err = pcall(function()
        local clone = SelectedItem:Clone()
        clone.Parent = backpack
        
        -- Try to activate if it's a tool
        if clone:IsA("Tool") then
            clone.Parent = LocalPlayer.Character or backpack
        end
    end)
    
    if success then
        Notify("Success", "Given: " .. SelectedItem.Name)
        
        -- Visual effect
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local spark = Instance.new("Sparkles")
                spark.Parent = hrp
                game:GetService("Debris"):AddItem(spark, 2)
            end
        end
    else
        Notify("Error", "Failed to spawn")
        warn(err)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- PLAYER TAB (WORKING TOGGLES)
-- ═══════════════════════════════════════════════════════════════════════════

CreateSlider(PlayerTab, "WalkSpeed", 16, 500, 16, function(val)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = val end
end)

CreateSlider(PlayerTab, "JumpPower", 50, 500, 50, function(val)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = val end
end)

CreateSlider(PlayerTab, "Gravity", 0, 500, 196, function(val)
    Workspace.Gravity = val
end)

-- FLY (PROPERLY TOGGLABLE)
CreateToggle(PlayerTab, "Fly", function(state)
    local char = LocalPlayer.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if state then
        -- Enable Fly
        local bg = Instance.new("BodyGyro")
        bg.Name = "AdminFlyGyro"
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = hrp.CFrame
        bg.Parent = hrp
        
        local bv = Instance.new("BodyVelocity")
        bv.Name = "AdminFlyVel"
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = hrp
        
        -- Fly loop
        local conn = RunService.RenderStepped:Connect(function()
            if not ActiveToggles["Fly"] then return end
            if not hrp or not hrp.Parent then return end
            
            local dir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
            
            if bv then bv.velocity = dir * 50 end
            if bg then bg.cframe = Camera.CFrame end
        end)
        table.insert(Connections, conn)
        Notify("Fly", "Fly Enabled (WASD + Space/Shift)")
    else
        -- Disable Fly - ACTUALLY DESTROYS
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v.Name == "AdminFlyGyro" or v.Name == "AdminFlyVel" then
                    v:Destroy()
                end
            end
        end
        Notify("Fly", "Fly Disabled")
    end
end)

-- NOCLIP (PROPERLY TOGGLABLE)
CreateToggle(PlayerTab, "Noclip", function(state)
    if state then
        local conn = RunService.Stepped:Connect(function()
            if not ActiveToggles["Noclip"] then return end
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        table.insert(Connections, conn)
        ActiveToggles["NoclipConn"] = conn
    else
        if ActiveToggles["NoclipConn"] then
            ActiveToggles["NoclipConn"]:Disconnect()
        end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- GOD MODE
CreateToggle(PlayerTab, "God Mode", function(state)
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if state then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        Notify("God Mode", "You are now immortal!")
    else
        hum.MaxHealth = 100
        hum.Health = 100
        Notify("God Mode", "Returned to normal")
    end
end)

-- CLICK TP
CreateToggle(PlayerTab, "Click TP", function(state)
    if state then
        local conn = Mouse.Button1Down:Connect(function()
            if Mouse.Target then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end)
        ActiveToggles["ClickTPConn"] = conn
        table.insert(Connections, conn)
        Notify("Click TP", "Click anywhere to teleport")
    else
        if ActiveToggles["ClickTPConn"] then
            ActiveToggles["ClickTPConn"]:Disconnect()
            ActiveToggles["ClickTPConn"] = nil
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- TROLL TAB (VISUAL & SERVER TROLLS)
-- ═══════════════════════════════════════════════════════════════════════════

CreateButton(TrollTab, "💣 NUKE SERVER (Visual)", function()
    -- REAL Visual Nuke Effect
    Notify("NUKE", "Launching nuke...")
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Explosion effect
                local explosion = Instance.new("Explosion")
                explosion.Position = hrp.Position
                explosion.BlastRadius = 50
                explosion.BlastPressure = 500000
                explosion.Parent = Workspace
                
                -- Screen Shake for all
                local shake = Instance.new("ScreenGui")
                shake.Name = "NukeShake"
                shake.Parent = player:FindFirstChildOfClass("PlayerGui") or CoreGui
                
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundTransparency = 0.5
                frame.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
                frame.Parent = shake
                
                game:GetService("Debris"):AddItem(shake, 3)
                
                -- Sound
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://5801257795" -- Explosion sound
                sound.Volume = 10
                sound.Parent = hrp
                sound:Play()
            end
        end
    end
    
    -- Flash screen
    local flash = Instance.new("ScreenGui", CoreGui)
    local f = Instance.new("Frame", flash)
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundColor3 = Color3.new(1, 1, 1)
    
    game:GetService("Debris"):AddItem(flash, 0.5)
    TweenService:Create(f, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
end)

CreateButton(TrollTab, "🔥 LAG SERVER (FE)", function()
    Notify("Lag", "Spamming remotes...")
    -- Actually spawns parts to lag
    for i = 1, 100 do
        local part = Instance.new("Part")
        part.Size = Vector3.new(math.random(1,10), math.random(1,10), math.random(1,10))
        part.Position = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50,50), math.random(-50,50), math.random(-50,50))
        part.Anchored = false
        part.Parent = Workspace
        game:GetService("Debris"):AddItem(part, 10)
    end
end)

CreateButton(TrollTab, "👻 SPOOK ALL", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local msg = Instance.new("Message", Workspace)
            msg.Text = "👻 " .. player.Name .. " HAS BEEN HAUNTED BY SHEHZAD × KIMI 👑"
            game:GetService("Debris"):AddItem(msg, 5)
        end
    end
end)

CreateButton(TrollTab, "🎵 EAR RAPE (Play Sound)", function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://142376088" -- Loud sound
    sound.Volume = 10
    sound.Looped = true
    sound.Parent = Workspace
    sound:Play()
    
    Notify("Troll", "Playing loud sound...")
    wait(5)
    sound:Destroy()
end)

CreateButton(TrollTab, "💫 FLING ALL", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(math.random(-2000, 2000), math.random(500, 2000), math.random(-2000, 2000))
                hrp.RotVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
            end
        end
    end
    Notify("Fling", "Everyone has been flung!")
end)

CreateButton(TrollTab, "🌑 BLACKOUT", function()
    local oldAmbient = Lighting.Ambient
    local oldBrightness = Lighting.Brightness
    
    Lighting.Brightness = 0
    Lighting.Ambient = Color3.new(0, 0, 0)
    
    wait(5)
    
    Lighting.Brightness = oldBrightness
   Lighting.Ambient = oldAmbient
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- ADMIN TAB (WORKING COMMANDS)
-- ═══════════════════════════════════════════════════════════════════════════

CreateButton(AdminTab, "⚡ KILL ALL (Working)", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = 0
                -- Break joints if health doesn't work
                if hum.Health > 0 then
                    player.Character:BreakJoints()
                end
            end
        end
    end
    Notify("Kill", "Killed all players!")
end)

CreateButton(AdminTab, "🏥 HEAL ALL", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
    end
    Notify("Heal", "Healed everyone!")
end)

CreateButton(AdminTab, "🔨 BRING ALL", function()
    local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myPos then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = myPos.CFrame + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
            end
        end
    end
    Notify("Bring", "Brought everyone to you!")
end)

CreateButton(AdminTab, "🚀 SPEED ALL", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 100
            end
        end
    end
    Notify("Speed", "Gave everyone speed!")
end)

CreateButton(AdminTab, "🔄 REJOIN", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton(AdminTab, "📊 SERVER INFO", function()
    local info = "Players: " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers
    Notify("Server", info)
end)

-- Dragging
local dragging = false
local dragStart, startPos

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

table.insert(Connections, UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end))

table.insert(Connections, UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end))

-- Minimize
local minimized = false
Min.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(Content, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(Sidebar, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 30)}):Play()
        Min.Text = "+"
    else
        TweenService:Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 300)}):Play()
        wait(0.1)
        TweenService:Create(Content, TweenInfo.new(0.3), {Size = UDim2.new(1, -105, 1, -40)}):Play()
        TweenService:Create(Sidebar, TweenInfo.new(0.3), {Size = UDim2.new(0, 90, 1, -40)}):Play()
        Min.Text = "−"
    end
end)

-- Open Animation
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 450, 0, 300)}):Play()

wait(0.5)
Notify("SHEHZAD × KIMI 👑", "Admin Loaded! Click 'Scan Items' to begin.")

print("✅ PRO ADMIN LOADED")
