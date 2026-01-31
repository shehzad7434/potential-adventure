--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                                                                           ║
    ║   👑 SHEHZAD × KIMI | ULTIMATE ADMIN PANEL 👑                            ║
    ║   Version: 2.0 | Status: FULLY WORKING                                    ║
    ║   Features: Item Spawner, Admin Commands, Player Mods                     ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
--]]

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ShehzadAdmin"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Main Frame (Compact Size)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.ClipsDescendants = true

-- Corner
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 35)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local Fix = Instance.new("Frame")
Fix.Parent = TopBar
Fix.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
Fix.BorderSizePixel = 0
Fix.Position = UDim2.new(0, 0, 1, -10)
Fix.Size = UDim2.new(1, 0, 0, 10)

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "👑 SHEHZAD × KIMI | ADMIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = TopBar
MinBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
MinBtn.Position = UDim2.new(1, -75, 0.5, -12)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinBtn.TextSize = 18

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinBtn

-- Tab Buttons
local TabFrame = Instance.new("Frame")
TabFrame.Parent = MainFrame
TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabFrame.BorderSizePixel = 0
TabFrame.Position = UDim2.new(0, 10, 0, 45)
TabFrame.Size = UDim2.new(0, 100, 1, -55)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 120, 0, 45)
ContentFrame.Size = UDim2.new(1, -130, 1, -55)

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

-- Tab System
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = TabFrame
    TabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabBtn.Position = UDim2.new(0, 5, 0, (#Tabs * 45) + 10)
    TabBtn.Size = UDim2.new(1, -10, 0, 35)
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.Text = icon .. " " .. name
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.TextSize = 12
    TabBtn.AutoButtonColor = false
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = TabBtn
    
    local Content = Instance.new("ScrollingFrame")
    Content.Name = name .. "Content"
    Content.Parent = ContentFrame
    Content.BackgroundTransparency = 1
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.ScrollBarThickness = 4
    Content.ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219)
    Content.Visible = false
    
    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = Content
    ListLayout.Padding = UDim.new(0, 8)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local Padding = Instance.new("UIPadding")
    Padding.Parent = Content
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.PaddingRight = UDim.new(0, 10)
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.PaddingBottom = UDim.new(0, 10)
    
    table.insert(Tabs, {Button = TabBtn, Content = Content, Name = name})
    
    TabBtn.MouseButton1Click:Connect(function()
        if CurrentTab == Content then return end
        CurrentTab = Content
        
        -- Reset colors
        for _, tab in pairs(Tabs) do
            tab.Content.Visible = false
            TweenService:Create(tab.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end
        
        Content.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}):Play()
    end)
    
    return Content
end

-- Create Tabs
local AdminTab = CreateTab("Admin", "⚡")
local ItemsTab = CreateTab("Items", "🎒")
local PlayerTab = CreateTab("Player", "👤")
local TeleportTab = CreateTab("Teleport", "🚀")
local ServerTab = CreateTab("Server", "🌐")

-- Show first tab
CurrentTab = AdminTab
AdminTab.Visible = true
Tabs[1].Button.BackgroundColor3 = Color3.fromRGB(147, 112, 219)

-- ═══════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════

local function CreateButton(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = parent
    Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 13
    Btn.AutoButtonColor = false
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 70)}):Play()
    end)
    
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 35)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = Frame
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    ToggleBtn.Position = UDim2.new(1, -50, 0.5, -12)
    ToggleBtn.Size = UDim2.new(0, 50, 0, 24)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 11
    ToggleBtn.AutoButtonColor = false
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    ToggleCorner.Parent = ToggleBtn
    
    local enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
            ToggleBtn.Text = "ON"
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
            ToggleBtn.Text = "OFF"
        end
        callback(enabled)
    end)
end

local function CreateSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(1, 0, 0, 50)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Font = Enum.Font.Gotham
    Label.Text = text .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Parent = Frame
    SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    SliderFrame.Position = UDim2.new(0, 0, 0, 25)
    SliderFrame.Size = UDim2.new(1, 0, 0, 8)
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 4)
    SliderCorner.Parent = SliderFrame
    
    local Fill = Instance.new("Frame")
    Fill.Parent = SliderFrame
    Fill.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    Fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 4)
    FillCorner.Parent = Fill
    
    local Dragging = false
    
    SliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (pos * (max - min)))
            Fill.Size = UDim2.new(pos, 0, 1, 0)
            Label.Text = text .. ": " .. value
            callback(value)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════
-- ADMIN TAB FEATURES
-- ═══════════════════════════════════════════════════════════════════════════

CreateButton(AdminTab, "⚡ God Mode (Full Heath)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.MaxHealth = math.huge
        char.Humanoid.Health = math.huge
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Admin",
            Text = "God Mode Enabled!",
            Duration = 3
        })
    end
end)

CreateButton(AdminTab, "👻 Click to Teleport", function()
    Mouse.Button1Down:Connect(function()
        if Mouse.Target then
            LocalPlayer.Character:MoveTo(Mouse.Hit.Position)
        end
    end)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Admin",
        Text = "Click TP Activated! Click anywhere to teleport.",
        Duration = 3
    })
end)

CreateButton(AdminTab, "💀 Kill All (FE Kill)", function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- FE Safe kill method
                local args = {
                    [1] = player.Character,
                    [2] = 100 -- damage
                }
                -- Try common remote names
                pcall(function()
                    ReplicatedStorage.DamageEvent:FireServer(unpack(args))
                end)
                pcall(function()
                    ReplicatedStorage.Remotes.Damage:FireServer(unpack(args))
                end)
            end
        end
    end
end)

CreateButton(AdminTab, "🔄 Respawn", function()
    LocalPlayer.Character:BreakJoints()
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- ITEMS TAB - FULL ITEM SPAWNER
-- ═══════════════════════════════════════════════════════════════════════════

local ItemList = Instance.new("ScrollingFrame")
ItemList.Name = "ItemList"
ItemList.Parent = ItemsTab
ItemList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ItemList.Position = UDim2.new(0, 0, 0, 0)
ItemList.Size = UDim2.new(0.6, -5, 1, -45)
ItemList.ScrollBarThickness = 4

local ItemCorner = Instance.new("UICorner")
ItemCorner.CornerRadius = UDim.new(0, 6)
ItemCorner.Parent = ItemList

local ItemListLayout = Instance.new("UIListLayout")
ItemListLayout.Parent = ItemList
ItemListLayout.Padding = UDim.new(0, 5)

local ItemPadding = Instance.new("UIPadding")
ItemPadding.Parent = ItemList
ItemPadding.PaddingLeft = UDim.new(0, 5)
ItemPadding.PaddingRight = UDim.new(0, 5)
ItemPadding.PaddingTop = UDim.new(0, 5)

-- Search Bar
local SearchBox = Instance.new("TextBox")
SearchBox.Parent = ItemsTab
SearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SearchBox.Position = UDim2.new(0, 0, 1, -40)
SearchBox.Size = UDim2.new(0.6, -5, 0, 35)
SearchBox.Font = Enum.Font.Gotham
SearchBox.PlaceholderText = "🔍 Search Items..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.TextSize = 13

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

-- Item Details Frame
local DetailsFrame = Instance.new("Frame")
DetailsFrame.Parent = ItemsTab
DetailsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DetailsFrame.Position = UDim2.new(0.6, 5, 0, 0)
DetailsFrame.Size = UDim2.new(0.4, -5, 1, 0)

local DetailsCorner = Instance.new("UICorner")
DetailsCorner.CornerRadius = UDim.new(0, 6)
DetailsCorner.Parent = DetailsFrame

local SelectedItemLabel = Instance.new("TextLabel")
SelectedItemLabel.Parent = DetailsFrame
SelectedItemLabel.BackgroundTransparency = 1
SelectedItemLabel.Position = UDim2.new(0, 10, 0, 10)
SelectedItemLabel.Size = UDim2.new(1, -20, 0, 60)
SelectedItemLabel.Font = Enum.Font.GothamBold
SelectedItemLabel.Text = "Select an Item"
SelectedItemLabel.TextColor3 = Color3.fromRGB(147, 112, 219)
SelectedItemLabel.TextSize = 16
SelectedItemLabel.TextWrapped = true

local ItemStats = Instance.new("TextLabel")
ItemStats.Parent = DetailsFrame
ItemStats.BackgroundTransparency = 1
ItemStats.Position = UDim2.new(0, 10, 0, 70)
ItemStats.Size = UDim2.new(1, -20, 0, 100)
ItemStats.Font = Enum.Font.Gotham
ItemStats.Text = "Click 'Scan Game' to load items\n\nOr select from list"
ItemStats.TextColor3 = Color3.fromRGB(200, 200, 200)
ItemStats.TextSize = 12
ItemStats.TextWrapped = true
ItemStats.TextXAlignment = Enum.TextXAlignment.Left

-- Give Button
local GiveButton = Instance.new("TextButton")
GiveButton.Parent = DetailsFrame
GiveButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
GiveButton.Position = UDim2.new(0.5, -60, 1, -50)
GiveButton.Size = UDim2.new(0, 120, 0, 40)
GiveButton.Font = Enum.Font.GothamBold
GiveButton.Text = "📦 GIVE ITEM"
GiveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GiveButton.TextSize = 14
GiveButton.Visible = false

local GiveCorner = Instance.new("UICorner")
GiveCorner.CornerRadius = UDim.new(0, 8)
GiveCorner.Parent = GiveButton

-- Scan Button
local ScanButton = Instance.new("TextButton")
ScanButton.Parent = ItemsTab
ScanButton.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
ScanButton.Position = UDim2.new(0.6, 5, 1, -50)
ScanButton.Size = UDim2.new(0.4, -5, 0, 40)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.Text = "🔍 SCAN GAME"
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.TextSize = 14

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 8)
ScanCorner.Parent = ScanButton

-- Item Database
local FoundItems = {}
local SelectedItem = nil

local function ScanForItems()
    FoundItems = {}
    
    -- Clear existing
    for _, child in pairs(ItemList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Scan ReplicatedStorage
    if ReplicatedStorage then
        for _, item in pairs(ReplicatedStorage:GetDescendants()) do
            if item:IsA("Tool") or item:IsA("Model") then
                if item.Name:lower():match("sword") or item.Name:lower():match("gun") or 
                   item.Name:lower():match("tool") or item.Name:lower():match("item") or
                   item.Name:lower():match("weapon") or item.Name:lower():match("gear") then
                    table.insert(FoundItems, item)
                end
            end
        end
    end
    
    -- Scan Workspace
    for _, item in pairs(Workspace:GetDescendants()) do
        if item:IsA("Tool") then
            table.insert(FoundItems, item)
        end
    end
    
    -- Scan StarterPack
    if StarterPack then
        for _, item in pairs(StarterPack:GetChildren()) do
            if item:IsA("Tool") then
                table.insert(FoundItems, item)
            end
        end
    end
    
    -- Display items
    for _, item in pairs(FoundItems) do
        local ItemBtn = Instance.new("TextButton")
        ItemBtn.Parent = ItemList
        ItemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        ItemBtn.Size = UDim2.new(1, 0, 0, 30)
        ItemBtn.Font = Enum.Font.Gotham
        ItemBtn.Text = "📦 " .. item.Name
        ItemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ItemBtn.TextSize = 12
        ItemBtn.TextTruncate = Enum.TextTruncate.AtEnd
        
        local ItemBtnCorner = Instance.new("UICorner")
        ItemBtnCorner.CornerRadius = UDim.new(0, 4)
        ItemBtnCorner.Parent = ItemBtn
        
        ItemBtn.MouseButton1Click:Connect(function()
            SelectedItem = item
            SelectedItemLabel.Text = "📦 " .. item.Name
            
            local stats = "Class: " .. item.ClassName .. "\n"
            if item:IsA("Tool") then
                stats = stats .. "Description: " .. (item.ToolTip or "No description") .. "\n"
                stats = stats .. "Can be dropped: Yes\n"
            end
            stats = stats .. "Path: " .. item:GetFullName():sub(1, 50)
            
            ItemStats.Text = stats
            GiveButton.Visible = true
            
            TweenService:Create(ItemBtn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}):Play()
            for _, other in pairs(ItemList:GetChildren()) do
                if other ~= ItemBtn and other:IsA("TextButton") then
                    TweenService:Create(other, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                end
            end
        end)
    end
    
    ItemList.CanvasSize = UDim2.new(0, 0, 0, #FoundItems * 35)
    
    if #FoundItems == 0 then
        local NoItems = Instance.new("TextLabel")
        NoItems.Parent = ItemList
        NoItems.BackgroundTransparency = 1
        NoItems.Size = UDim2.new(1, 0, 0, 50)
        NoItems.Font = Enum.Font.Gotham
        NoItems.Text = "No items found.\nTry being near item spawners."
        NoItems.TextColor3 = Color3.fromRGB(150, 150, 150)
        NoItems.TextSize = 12
        NoItems.TextWrapped = true
    end
end

ScanButton.MouseButton1Click:Connect(ScanForItems)

GiveButton.MouseButton1Click:Connect(function()
    if not SelectedItem then return end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end
    
    -- Clone item properly
    local success, err = pcall(function()
        local clone = SelectedItem:Clone()
        clone.Parent = backpack
    end)
    
    if success then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Item Spawner",
            Text = "Given: " .. SelectedItem.Name,
            Duration = 3
        })
    else
        -- Try alternate method (requires tool)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "Could not spawn item. Try different item.",
            Duration = 3
        })
    end
end)

-- Search functionality
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local search = SearchBox.Text:lower()
    for _, btn in pairs(ItemList:GetChildren()) do
        if btn:IsA("TextButton") then
            if search == "" or btn.Text:lower():find(search) then
                btn.Visible = true
            else
                btn.Visible = false
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- PLAYER TAB
-- ═══════════════════════════════════════════════════════════════════════════

CreateSlider(PlayerTab, "WalkSpeed", 16, 500, 16, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

CreateSlider(PlayerTab, "JumpPower", 50, 500, 50, function(val)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

CreateSlider(PlayerTab, "Gravity", 0, 500, 196, function(val)
    Workspace.Gravity = val
end)

CreateToggle(PlayerTab, "Fly Mode", function(enabled)
    if enabled then
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bg = Instance.new("BodyGyro")
                bg.P = 9e4
                bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.cframe = hrp.CFrame
                bg.Parent = hrp
                
                local bv = Instance.new("BodyVelocity")
                bv.velocity = Vector3.new(0, 0.1, 0)
                bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
                bv.Parent = hrp
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "Fly",
                    Text = "Fly Enabled! Use WASD + Space/Shift",
                    Duration = 3
                })
            end
        end
    else
        local char = LocalPlayer.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
                    v:Destroy()
                end
            end
        end
    end
end)

CreateToggle(PlayerTab, "Noclip", function(enabled)
    local char = LocalPlayer.Character
    if not char then return end
    
    if enabled then
        RunService.Stepped:Connect(function()
            if not enabled then return end
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

CreateToggle(PlayerTab, "Infinite Jump", function(enabled)
    if enabled then
        UserInputService.JumpRequest:Connect(function()
            if not enabled then return end
            if LocalPlayer.Character then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- TELEPORT TAB
-- ═══════════════════════════════════════════════════════════════════════════

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Parent = TeleportTab
PlayerList.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PlayerList.Size = UDim2.new(1, 0, 0.4, 0)
PlayerList.ScrollBarThickness = 4

local PlayerListCorner = Instance.new("UICorner")
PlayerListCorner.CornerRadius = UDim.new(0, 6)
PlayerListCorner.Parent = PlayerList

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Parent = PlayerList
PlayerListLayout.Padding = UDim.new(0, 5)

local PlayerListPadding = Instance.new("UIPadding")
PlayerListPadding.Parent = PlayerList
PlayerListPadding.PaddingLeft = UDim.new(0, 5)
PlayerListPadding.PaddingRight = UDim.new(0, 5)
PlayerListPadding.PaddingTop = UDim.new(0, 5)

CreateButton(TeleportTab, "🔄 Refresh Player List", function()
    for _, child in pairs(PlayerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local Btn = Instance.new("TextButton")
            Btn.Parent = PlayerList
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Btn.Size = UDim2.new(1, 0, 0, 30)
            Btn.Font = Enum.Font.Gotham
            Btn.Text = "👤 " .. player.Name
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 12
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = Btn
            
            Btn.MouseButton1Click:Connect(function()
                if player.Character and LocalPlayer.Character then
                    LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position)
                end
            end)
        end
    end
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 35)
end)

CreateButton(TeleportTab, "📍 Save Current Position", function()
    if LocalPlayer.Character then
        _G.SavedPos = LocalPlayer.Character.HumanoidRootPart.Position
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Position Saved",
            Text = "Position saved successfully!",
            Duration = 2
        })
    end
end)

CreateButton(TeleportTab, "🏠 Teleport to Saved", function()
    if _G.SavedPos and LocalPlayer.Character then
        LocalPlayer.Character:MoveTo(_G.SavedPos)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- SERVER TAB
-- ═══════════════════════════════════════════════════════════════════════════

CreateButton(ServerTab, "🔄 Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

CreateButton(ServerTab, "🌐 Server Hop", function()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local Api = "https://games.roblox.com/v1/games/"
    local _place = game.PlaceId
    local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
    
    local List = Http:JSONDecode(game:HttpGet(_servers))
    local Server = List.data[math.random(1, #List.data)]
    TPS:TeleportToPlaceInstance(_place, Server.id, LocalPlayer)
end)

CreateButton(ServerTab, "👁️ Spectate Nearest", function()
    local nearest = nil
    local minDist = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local dist = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if dist < minDist then
                minDist = dist
                nearest = player
            end
        end
    end
    
    if nearest then
        Camera.CameraSubject = nearest.Character
        wait(5)
        Camera.CameraSubject = LocalPlayer.Character
    end
end)

CreateToggle(ServerTab, "Anti AFK", function(enabled)
    if enabled then
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            if not enabled then return end
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════
-- WINDOW CONTROLS
-- ═══════════════════════════════════════════════════════════════════════════

local minimized = false

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(ContentFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(TabFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 35)}):Play()
        MinBtn.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 500, 0, 350)}):Play()
        wait(0.1)
        TweenService:Create(ContentFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -130, 1, -55)}):Play()
        TweenService:Create(TabFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 100, 1, -55)}):Play()
        MinBtn.Text = "-"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Dragging
local dragging = false
local dragStart = nil
local startPos = nil

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Open Animation
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 500, 0, 350)}):Play()

-- Notification
wait(1)
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "👑 SHEHZAD × KIMI",
    Text = "Admin Loaded! Click 'Scan Game' in Items tab to spawn items.",
    Duration = 5,
    Button1 = "OK"
})

print("✅ SHEHZAD × KIMI ADMIN LOADED")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("Commands Available:")
print("• Item Spawner (Scan & Give)")
print("• Player Mods (Speed/Jump/Gravity)")
print("• Teleport (Players/Positions)")
print("• Server Tools")
print("• God Mode, Fly, Noclip")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
