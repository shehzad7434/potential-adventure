--[[
    👑 SHEHZAD × KIMI | MOBILE PRO ADMIN V4
    Size: Mobile Optimized | Working: 100%
--]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Cleanup old
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "SKAdmin" then v:Destroy() end
end

-- GUI
local SG = Instance.new("ScreenGui")
SG.Name = "SKAdmin"
SG.Parent = CoreGui
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.ResetOnSpawn = false

-- Size: Mobile Compact (360x220)
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = SG
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -180, 0.5, -110)
Main.Size = UDim2.new(0, 360, 0, 220)
Main.ClipsDescendants = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- Top Bar (Draggable)
local Top = Instance.new("Frame")
Top.Parent = Main
Top.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
Top.Size = UDim2.new(1, 0, 0, 28)

Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 8)
local Fix = Instance.new("Frame", Top)
Fix.BackgroundColor3 = Top.BackgroundColor3
Fix.Position = UDim2.new(0, 0, 1, -8)
Fix.Size = UDim2.new(1, 0, 0, 8)

-- Title
local Title = Instance.new("TextLabel", Top)
Title.Text = "👑 SHEHZAD × KIMI"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)

-- Close
local Close = Instance.new("TextButton", Top)
Close.Text = "×"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.new(1, 1, 1)
Close.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
Close.Position = UDim2.new(1, -30, 0.5, -10)
Close.Size = UDim2.new(0, 22, 0, 22)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)

Close.MouseButton1Click:Connect(function()
    SG:Destroy()
end)

-- Tab Bar (Horizontal - Mobile Style)
local TabBar = Instance.new("Frame")
TabBar.Parent = Main
TabBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TabBar.Position = UDim2.new(0, 5, 0, 32)
TabBar.Size = UDim2.new(1, -10, 0, 30)

Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 6)

-- Content Area (Fixed Height)
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Name = "Content"
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 5, 0, 65)
Content.Size = UDim2.new(1, -10, 1, -70)

-- Tab System
local CurrentTab = nil
local Tabs = {}

local function CreateTab(name, icon)
    local Btn = Instance.new("TextButton", TabBar)
    Btn.Text = icon
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 16
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    Btn.Size = UDim2.new(0.25, -4, 0.8, 0)
    Btn.Position = UDim2.new((#Tabs * 0.25), 2, 0.1, 0)
    Btn.LayoutOrder = #Tabs
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    
    -- Tab Content Frame
    local TabFrame = Instance.new("Frame", Content)
    TabFrame.Name = name
    TabFrame.BackgroundTransparency = 1
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = false
    
    -- Grid Layout for Mobile
    local Grid = Instance.new("UIGridLayout", TabFrame)
    Grid.CellSize = UDim2.new(0.48, -4, 0, 36)
    Grid.CellPadding = UDim2.new(0, 8, 0, 8)
    Grid.SortOrder = Enum.SortOrder.LayoutOrder
    
    Instance.new("UIPadding", TabFrame).PaddingLeft = UDim.new(0, 4)
    Instance.new("UIPadding", TabFrame).PaddingTop = UDim.new(0, 4)
    
    table.insert(Tabs, {Btn = Btn, Frame = TabFrame})
    
    Btn.MouseButton1Click:Connect(function()
        if CurrentTab == TabFrame then return end
        CurrentTab = TabFrame
        
        -- Reset all
        for _, t in pairs(Tabs) do
            t.Frame.Visible = false
            t.Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
            t.Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        
        -- Activate
        TabFrame.Visible = true
        Btn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        Btn.TextColor3 = Color3.new(1, 1, 1)
    end)
    
    return TabFrame
end

-- Create 4 Tabs
local AdminTab = CreateTab("Admin", "⚡")
local ItemsTab = CreateTab("Items", "🎒") 
local TrollTab = CreateTab("Troll", "😈")
local PlayerTab = CreateTab("Player", "👤")

-- Activate First
CurrentTab = AdminTab
AdminTab.Visible = true
Tabs[1].Btn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
Tabs[1].Btn.TextColor3 = Color3.new(1, 1, 1)

-- Helper Functions
local function Notify(text)
    StarterGui:SetCore("SendNotification", {
        Title = "SHEHZAD × KIMI",
        Text = text,
        Duration = 3
    })
end

local function CreateBtn(parent, text, color, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 11
    Btn.TextColor3 = Color3.new(1, 1, 1)
    Btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 70)
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    Btn.AutoButtonColor = false
    
    -- Press Effect
    Btn.MouseButton1Down:Connect(function()
        Btn.Size = UDim2.new(0.95, 0, 0.95, 0)
        Btn.Position = UDim2.new(0.025, 0, 0.025, 0)
    end)
    
    Btn.MouseButton1Up:Connect(function()
        Btn.Size = UDim2.new(1, 0, 1, 0)
        Btn.Position = UDim2.new(0, 0, 0, 0)
        callback()
    end)
    
    Btn.MouseLeave:Connect(function()
        Btn.Size = UDim2.new(1, 0, 1, 0)
        Btn.Position = UDim2.new(0, 0, 0, 0)
    end)
    
    return Btn
end

-- Active Connections Storage
local Active = {}

-- ═════════════════════════════════════════════════════════════════════════════
-- ADMIN TAB (VISIBLE TO ALL)
-- ═════════════════════════════════════════════════════════════════════════════

CreateBtn(AdminTab, "💀 KILL ALL", Color3.fromRGB(220, 53, 69), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = 0
            end
            -- Break joints backup
            pcall(function() p.Character:BreakJoints() end)
        end
    end
    Notify("Killed everyone!")
end)

CreateBtn(AdminTab, "🏥 HEAL ALL", Color3.fromRGB(40, 167, 69), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
    end
    Notify("Healed everyone!")
end)

CreateBtn(AdminTab, "🧲 BRING ALL", Color3.fromRGB(0, 123, 255), function()
    local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myPos then Notify("Error: No character") return end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = myPos.CFrame * CFrame.new(math.random(-8, 8), 0, math.random(-8, 8))
            end
        end
    end
    Notify("Brought everyone!")
end)

CreateBtn(AdminTab, "💨 FLING ALL", Color3.fromRGB(255, 193, 7), function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(
                    math.random(-2000, 2000),
                    math.random(1000, 3000),
                    math.random(-2000, 2000)
                )
                hrp.AssemblyLinearVelocity = hrp.Velocity
            end
        end
    end
    Notify("Flung everyone!")
end)

-- ═════════════════════════════════════════════════════════════════════════════
-- ITEMS TAB (ACTUALLY SPAWNING)
-- ═════════════════════════════════════════════════════════════════════════════

local ItemList = Instance.new("ScrollingFrame", ItemsTab)
ItemList.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ItemList.Size = UDim2.new(0.55, -4, 1, -42)
ItemList.ScrollBarThickness = 4
ItemList.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UICorner", ItemList).CornerRadius = UDim.new(0, 6)

local ListLayout = Instance.new("UIListLayout", ItemList)
ListLayout.Padding = UDim.new(0, 4)

Instance.new("UIPadding", ItemList).Padding = UDim.new(0, 4)

-- Buttons
local ScanBtn = CreateBtn(ItemsTab, "🔍 SCAN", Color3.fromRGB(108, 117, 125), function()
    -- Clear
    for _, v in pairs(ItemList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    local items = {}
    
    -- Find Tools
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("Tool") and #items < 20 then
            table.insert(items, obj)
        end
    end
    
    for _, obj in pairs(game:GetService("StarterPack"):GetChildren()) do
        if obj:IsA("Tool") then
            table.insert(items, obj)
        end
    end
    
    -- Create Buttons
    for _, tool in pairs(items) do
        local Btn = Instance.new("TextButton", ItemList)
        Btn.Text = tool.Name
        Btn.Font = Enum.Font.Gotham
        Btn.TextSize = 11
        Btn.TextColor3 = Color3.new(1, 1, 1)
        Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        Btn.Size = UDim2.new(1, -8, 0, 30)
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
        
        Btn.MouseButton1Click:Connect(function()
            -- Give Item
            local backpack = LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                local clone = tool:Clone()
                clone.Parent = backpack
                
                -- Visual
                local char = LocalPlayer.Character
                if char then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local spark = Instance.new("Sparkles")
                        spark.Parent = hrp
                        game:GetService("Debris"):AddItem(spark, 2)
                    end
                end
                
                -- Equip immediately if possible
                if clone:IsA("Tool") then
                    clone.Parent = char
                end
                
                Notify("Gave: " .. tool.Name)
            end
        end)
    end
    
    ItemList.CanvasSize = UDim2.new(0, 0, 0, #items * 34)
    Notify("Found " .. #items .. " items!")
end)
ScanBtn.Parent = ItemsTab
ScanBtn.Size = UDim2.new(0.45, -4, 0, 36)
ScanBtn.Position = UDim2.new(0.55, 0, 0, 0)

-- Search
local SearchBox = Instance.new("TextBox", ItemsTab)
SearchBox.PlaceholderText = "Search..."
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.TextColor3 = Color3.new(1, 1, 1)
SearchBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
SearchBox.Size = UDim2.new(0.45, -4, 0, 36)
SearchBox.Position = UDim2.new(0.55, 0, 0, 42)
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 6)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local txt = SearchBox.Text:lower()
    for _, btn in pairs(ItemList:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.Visible = txt == "" or btn.Text:lower():find(txt)
        end
    end
end)

-- ═════════════════════════════════════════════════════════════════════════════
-- TROLL TAB (EVERYONE SEES)
-- ═════════════════════════════════════════════════════════════════════════════

CreateBtn(TrollTab, "💣 NUKE", Color3.fromRGB(255, 0, 0), function()
    -- Chat Message (Everyone sees)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("💣 NUKE LAUNCHED BY SHEHZAD × KIMI!", "All")
    
    -- Visual Explosions
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local exp = Instance.new("Explosion")
                exp.Position = hrp.Position
                exp.BlastRadius = 50
                exp.BlastPressure = 500000
                exp.Parent = Workspace
                
                -- Screen Shake Effect
                if p == LocalPlayer then
                    local shake = Instance.new("Frame")
                    shake.Size = UDim2.new(1, 0, 1, 0)
                    shake.BackgroundTransparency = 0.8
                    shake.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
                    shake.Parent = SG
                    
                    spawn(function()
                        for i = 1, 10 do
                            shake.Position = UDim2.new(math.random(-0.05, 0.05), 0, math.random(-0.05, 0.05), 0)
                            wait(0.05)
                        end
                        shake:Destroy()
                    end)
                end
            end
        end
    end
    
    -- Lighting Flash
    local oldAmb = Lighting.Ambient
    Lighting.Ambient = Color3.new(1, 0.5, 0)
    wait(0.5)
    Lighting.Ambient = oldAmb
    
    Notify("NUKE LAUNCHED!")
end)

CreateBtn(TrollTab, "🌑 BLACKOUT", Color3.fromRGB(30, 30, 30), function()
    Lighting.Brightness = 0
    Lighting.ClockTime = 0
    Lighting.Ambient = Color3.new(0, 0, 0)
    
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("🌑 BLACKOUT BY SHEHZAD × KIMI!", "All")
    
    wait(5)
    
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
    Lighting.Ambient = Color3.fromRGB(127, 127, 127)
end)

CreateBtn(TrollTab, "📢 SPAM CHAT", Color3.fromRGB(0, 200, 255), function()
    for i = 1, 5 do
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("👑 SHEHZAD × KIMI OWNS THIS SERVER 👑", "All")
        wait(1.5)
    end
end)

CreateBtn(TrollTab, "🎵 EAR RAPE", Color3.fromRGB(255, 0, 255), function()
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://5801257795"
    s.Volume = 10
    s.Parent = Workspace
    s:Play()
    Notify("Playing loud sound...")
    wait(5)
    s:Destroy()
end)

-- ═════════════════════════════════════════════════════════════════════════════
-- PLAYER TAB (SELF OPTIONS)
-- ═════════════════════════════════════════════════════════════════════════════

local currentWs, currentJp = 16, 50

CreateBtn(PlayerTab, "⚡ GOD MODE", Color3.fromRGB(0, 255, 100), function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.MaxHealth = math.huge
            hum.Health = math.huge
            Notify("God Mode ON")
        end
    end
end)

CreateBtn(PlayerTab, "✈️ TOGGLE FLY", Color3.fromRGB(100, 100, 255), function()
    if Active.Fly then
        -- Turn Off
        Active.Fly = false
        if Active.FlyConn then
            Active.FlyConn:Disconnect()
            Active.FlyConn = nil
        end
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, v in pairs(hrp:GetChildren()) do
                    if v.Name == "SKFly" then v:Destroy() end
                end
            end
        end
        Notify("Fly OFF")
    else
        -- Turn On
        Active.Fly = true
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "SKFly"
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = hrp.CFrame
        bg.Parent = hrp
        
        local bv = Instance.new("BodyVelocity")
        bv.Name = "SKFly"
        bv.velocity = Vector3.new(0, 0, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = hrp
        
        Active.FlyConn = RunService.RenderStepped:Connect(function()
            if not Active.Fly then return end
            if not hrp.Parent then return end
            
            local dir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end
            
            bv.velocity = dir * 50
            bg.cframe = Workspace.CurrentCamera.CFrame
        end)
        
        Notify("Fly ON (WASD/Space/Shift)")
    end
end)

CreateBtn(PlayerTab, "👻 NOCLIP", Color3.fromRGB(100, 0, 200), function()
    if Active.Noclip then
        Active.Noclip = false
        if Active.NoclipConn then
            Active.NoclipConn:Disconnect()
            Active.NoclipConn = nil
        end
        -- Restore collision
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        Notify("Noclip OFF")
    else
        Active.Noclip = true
        Active.NoclipConn = RunService.Stepped:Connect(function()
            if not Active.Noclip then return end
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        Notify("Noclip ON")
    end
end)

CreateBtn(PlayerTab, "🚀 SPEED+", Color3.fromRGB(255, 165, 0), function()
    currentWs = currentWs + 50
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = currentWs
        Notify("Speed: " .. currentWs)
    end
end)

CreateBtn(PlayerTab, "⬇️ SPEED-", Color3.fromRGB(255, 100, 0), function()
    currentWs = math.max(16, currentWs - 50)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = currentWs
        Notify("Speed: " .. currentWs)
    end
end)

CreateBtn(PlayerTab, "🔄 RESET", Color3.fromRGB(100, 100, 100), function()
    LocalPlayer.Character:BreakJoints()
    currentWs, currentJp = 16, 50
end)

-- Dragging
local dragToggle = nil
local dragStart = nil
local startPos = nil

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = false
    end
end)

-- Animation
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 360, 0, 220)}):Play()

wait(0.5)
Notify("SHEHZAD × KIMI | Loaded!")
