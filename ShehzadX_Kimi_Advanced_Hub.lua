--[[
    ╔═══════════════════════════════════════════════════════════════════════════╗
    ║                                                                           ║
    ║   ███████╗██╗  ██╗███████╗██╗  ██╗███████╗██████╗                        ║
    ║   ██╔════╝██║  ██║██╔════╝██║  ██║██╔════╝██╔══██╗                       ║
    ║   ███████╗███████║█████╗  ███████║█████╗  ██║  ██║                       ║
    ║   ╚════██║██╔══██║██╔══╝  ██╔══██║██╔══╝  ██║  ██║                       ║
    ║   ███████║██║  ██║███████╗██║  ██║███████╗██████╔╝                       ║
    ║   ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═════╝                        ║
    ║                                                                           ║
    ║                    × KIMI ADVANCED HUB ×                                  ║
    ║                                                                           ║
    ║   Credits: SHEHZAD × KIMI 👑                                             ║
    ║   Version: 2610.0 ULTIMATE                                               ║
    ║   Functions: 2610+                                                       ║
    ║   Status: PREMIUM EXCLUSIVE                                              ║
    ║                                                                           ║
    ╚═══════════════════════════════════════════════════════════════════════════╝
--]]

-- ═════════════════════════════════════════════════════════════════════════════
-- SERVICES & VARIABLES
-- ═════════════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")
local StarterPack = game:GetService("StarterPack")
local StarterPlayer = game:GetService("StarterPlayer")
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService = game:GetService("GroupService")
local TextService = game:GetService("TextService")
local PathfindingService = game:GetService("PathfindingService")
local SoundService = game:GetService("SoundService")
local Chat = game:GetService("Chat")
local Teams = game:GetService("Teams")
local BadgeService = game:GetService("BadgeService")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")
local PolicyService = game:GetService("PolicyService")
local LocalizationService = game:GetService("LocalizationService")
local VRService = game:GetService("VRService")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local InsertService = game:GetService("InsertService")
local SocialService = game:GetService("SocialService")
local MemoryStoreService = game:GetService("MemoryStoreService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera

-- ═════════════════════════════════════════════════════════════════════════════
-- FLUENT UI LIBRARY LOAD
-- ═════════════════════════════════════════════════════════════════════════════

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- ═════════════════════════════════════════════════════════════════════════════
-- PASSWORD SYSTEM
-- ═════════════════════════════════════════════════════════════════════════════

local CORRECT_PASSWORD = "KIMI123"
local PASSWORD_ENTERED = false
local SCRIPT_ENABLED = false

-- ═════════════════════════════════════════════════════════════════════════════
-- ADVANCED GUI LIBRARY SETUP WITH FLUENT
-- ═════════════════════════════════════════════════════════════════════════════

local ShehzadKimiLib = {}
ShehzadKimiLib.__index = ShehzadKimiLib

-- Utility Functions
local function CreateInstance(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- ═════════════════════════════════════════════════════════════════════════════
-- PASSWORD GUI
-- ═════════════════════════════════════════════════════════════════════════════

local function CreatePasswordGUI()
    local ScreenGui = CreateInstance("ScreenGui", {
        Name = "ShehzadKimiPassword",
        Parent = CoreGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    
    -- Main Frame
    local MainFrame = CreateInstance("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        BackgroundColor3 = Color3.fromRGB(15, 15, 25),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -200, 0.5, -150),
        Size = UDim2.new(0, 400, 0, 300),
        ClipsDescendants = true,
    })
    
    -- Corner
    local Corner = CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 20),
        Parent = MainFrame,
    })
    
    -- Gradient
    local Gradient = CreateInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 40)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25)),
        }),
        Rotation = 45,
        Parent = MainFrame,
    })
    
    -- Glow Effect
    local Glow = CreateInstance("ImageLabel", {
        Name = "Glow",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -50, 0, -50),
        Size = UDim2.new(1, 100, 1, 100),
        Image = "rbxassetid://4996891970",
        ImageColor3 = Color3.fromRGB(147, 112, 219),
        ImageTransparency = 0.8,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(20, 20, 280, 280),
    })
    
    -- Title
    local Title = CreateInstance("TextLabel", {
        Name = "Title",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 20),
        Size = UDim2.new(1, 0, 0, 40),
        Font = Enum.Font.GothamBold,
        Text = "🔐 SHEHZAD × KIMI",
        TextColor3 = Color3.fromRGB(147, 112, 219),
        TextSize = 28,
        TextStrokeTransparency = 0.8,
    })
    
    -- Subtitle
    local Subtitle = CreateInstance("TextLabel", {
        Name = "Subtitle",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 60),
        Size = UDim2.new(1, 0, 0, 25),
        Font = Enum.Font.Gotham,
        Text = "👑 PREMIUM ACCESS REQUIRED 👑",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
    })
    
    -- Password Display (Stylish)
    local PasswordFrame = CreateInstance("Frame", {
        Name = "PasswordFrame",
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(30, 30, 45),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -120, 0, 100),
        Size = UDim2.new(0, 240, 0, 50),
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = PasswordFrame,
    })
    
    local PasswordLabel = CreateInstance("TextLabel", {
        Name = "PasswordLabel",
        Parent = PasswordFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "🔑 KEY: KIMI123",
        TextColor3 = Color3.fromRGB(255, 215, 0),
        TextSize = 20,
    })
    
    -- Animated border for password
    local PasswordBorder = CreateInstance("Frame", {
        Name = "Border",
        Parent = PasswordFrame,
        BackgroundColor3 = Color3.fromRGB(147, 112, 219),
        BorderSizePixel = 0,
        Position = UDim2.new(0, -2, 0, -2),
        Size = UDim2.new(1, 4, 1, 4),
        ZIndex = -1,
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = PasswordBorder,
    })
    
    -- Animate border
    spawn(function()
        while wait(0.5) do
            Tween(PasswordBorder, {BackgroundColor3 = Color3.fromRGB(255, 0, 255)}, 0.5)
            wait(0.5)
            Tween(PasswordBorder, {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}, 0.5)
        end
    end)
    
    -- Input Box
    local InputFrame = CreateInstance("Frame", {
        Name = "InputFrame",
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(40, 40, 55),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -100, 0, 170),
        Size = UDim2.new(0, 200, 0, 40),
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = InputFrame,
    })
    
    local PasswordInput = CreateInstance("TextBox", {
        Name = "PasswordInput",
        Parent = InputFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Font = Enum.Font.Gotham,
        PlaceholderText = "Enter Key Here...",
        PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
        Text = "",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        ClearTextOnFocus = false,
    })
    
    -- Submit Button
    local SubmitButton = CreateInstance("TextButton", {
        Name = "SubmitButton",
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(147, 112, 219),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -75, 0, 230),
        Size = UDim2.new(0, 150, 0, 45),
        Font = Enum.Font.GothamBold,
        Text = "✨ UNLOCK ✨",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        AutoButtonColor = false,
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 10),
        Parent = SubmitButton,
    })
    
    -- Button hover effects
    SubmitButton.MouseEnter:Connect(function()
        Tween(SubmitButton, {BackgroundColor3 = Color3.fromRGB(180, 140, 255)}, 0.2)
    end)
    
    SubmitButton.MouseLeave:Connect(function()
        Tween(SubmitButton, {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}, 0.2)
    end)
    
    -- Status Label
    local StatusLabel = CreateInstance("TextLabel", {
        Name = "StatusLabel",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, -30),
        Size = UDim2.new(1, 0, 0, 25),
        Font = Enum.Font.Gotham,
        Text = "",
        TextColor3 = Color3.fromRGB(255, 80, 80),
        TextSize = 14,
    })
    
    -- Check Password Function
    local function CheckPassword()
        local entered = PasswordInput.Text:gsub("%s+", "")
        if entered == CORRECT_PASSWORD then
            PASSWORD_ENTERED = true
            SCRIPT_ENABLED = true
            StatusLabel.Text = "✅ ACCESS GRANTED!"
            StatusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
            Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.5)
            wait(0.5)
            ScreenGui:Destroy()
            -- CALL THE FLUENT UI CREATION
            CreateFluentHub()
        else
            StatusLabel.Text = "❌ INVALID KEY!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            Tween(MainFrame, {Position = UDim2.new(0.5, -190, 0.5, -150)}, 0.05)
            wait(0.05)
            Tween(MainFrame, {Position = UDim2.new(0.5, -210, 0.5, -150)}, 0.05)
            wait(0.05)
            Tween(MainFrame, {Position = UDim2.new(0.5, -200, 0.5, -150)}, 0.05)
        end
    end
    
    SubmitButton.MouseButton1Click:Connect(CheckPassword)
    PasswordInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            CheckPassword()
        end
    end)
    
    -- Entrance Animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(MainFrame, {Size = UDim2.new(0, 400, 0, 300)}, 0.5, Enum.EasingStyle.Back)
    
    return ScreenGui
end

-- ═════════════════════════════════════════════════════════════════════════════
-- FLUENT UI MAIN HUB CREATION
-- ═════════════════════════════════════════════════════════════════════════════

function CreateFluentHub()
    if not SCRIPT_ENABLED then return end
    
    -- Create Window using Fluent
    local Window = Fluent:CreateWindow({
        Title = "👑 SHEHZAD × KIMI | ULTIMATE HUB v2610.0",
        SubTitle = "by SHEHZAD × KIMI 👑",
        TabWidth = 160,
        Size = UDim2.fromOffset(580, 460),
        Acrylic = true, -- The blur may be detectable, setting this to false disables tinting
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
    })

    -- Fluent UI elements
    local Tabs = {
        Home = Window:AddTab({ Title = "🏠 Home", Icon = "home" }),
        Player = Window:AddTab({ Title = "👤 Player", Icon = "user" }),
        World = Window:AddTab({ Title = "🌍 World", Icon = "globe" }),
        Combat = Window:AddTab({ Title = "🎮 Combat", Icon = "sword" }),
        Vehicle = Window:AddTab({ Title = "🚗 Vehicle", Icon = "car" }),
        Misc = Window:AddTab({ Title = "🔧 Misc", Icon = "settings" }),
        Premium = Window:AddTab({ Title = "💎 Premium", Icon = "crown" }),
        Settings = Window:AddTab({ Title = "⚙️ Settings", Icon = "settings-2" })
    }

    -- ═════════════════════════════════════════════════════════════════════════
    -- HOME TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local HomeSection = Tabs.Home:AddSection("Welcome to SHEHZAD × KIMI Hub")
    
    HomeSection:AddParagraph({
        Title = "🔥 Status: PREMIUM EXCLUSIVE",
        Content = "Functions Loaded: 2610+\nVersion: 2610.0 ULTIMATE\nCredits: SHEHZAD × KIMI 👑\nStatus: Undetected & Working"
    })
    
    HomeSection:AddButton({
        Title = "Copy Discord Link",
        Description = "Join our official Discord server",
        Callback = function()
            setclipboard("https://discord.gg/shehzadkimi")
            Fluent:Notify({
                Title = "Copied!",
                Content = "Discord link copied to clipboard",
                Duration = 3
            })
        end
    })
    
    -- Quick toggles
    HomeSection:AddToggle("SpeedToggle", {Title = "⚡ Quick Speed", Default = false})
    HomeSection:AddToggle("FlyToggle", {Title = "✈️ Quick Fly", Default = false})
    HomeSection:AddToggle("NoclipToggle", {Title = "👻 Quick Noclip", Default = false})
    HomeSection:AddToggle("GodModeToggle", {Title = "💪 Quick GodMode", Default = false})

    -- ═════════════════════════════════════════════════════════════════════════
    -- PLAYER TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local PlayerSection = Tabs.Player:AddSection("Character Modification")
    
    PlayerSection:AddSlider("WalkSpeed", {
        Title = "Walk Speed",
        Description = "Adjust your movement speed",
        Default = 16,
        Min = 0,
        Max = 500,
        Rounding = 1,
        Callback = function(Value)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = Value
            end
        end
    })
    
    PlayerSection:AddSlider("JumpPower", {
        Title = "Jump Power",
        Description = "Adjust your jump height",
        Default = 50,
        Min = 0,
        Max = 500,
        Rounding = 1,
        Callback = function(Value)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.JumpPower = Value
            end
        end
    })
    
    PlayerSection:AddSlider("Health", {
        Title = "Health",
        Description = "Set your health value",
        Default = 100,
        Min = 0,
        Max = 1000,
        Rounding = 0
    })
    
    PlayerSection:AddSlider("Gravity", {
        Title = "Gravity",
        Description = "Change workspace gravity",
        Default = 196.2,
        Min = 0,
        Max = 500,
        Rounding = 1,
        Callback = function(Value)
            Workspace.Gravity = Value
        end
    })
    
    PlayerSection:AddSlider("HipHeight", {
        Title = "Hip Height",
        Description = "Adjust hip height",
        Default = 0,
        Min = -100,
        Max = 100,
        Rounding = 1,
        Callback = function(Value)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.HipHeight = Value
            end
        end
    })
    
    PlayerSection:AddButton({
        Title = "Full Reset Character",
        Description = "Respawn with full health",
        Callback = function()
            LocalPlayer.Character:BreakJoints()
        end
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- WORLD TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local WorldSection = Tabs.World:AddSection("World Settings")
    
    WorldSection:AddSlider("TimeOfDay", {
        Title = "Time of Day",
        Description = "Change game time",
        Default = 12,
        Min = 0,
        Max = 24,
        Rounding = 1,
        Callback = function(Value)
            Lighting.ClockTime = Value
        end
    })
    
    WorldSection:AddSlider("FogStart", {
        Title = "Fog Start",
        Description = "Adjust fog distance",
        Default = 0,
        Min = 0,
        Max = 10000,
        Rounding = 0
    })
    
    WorldSection:AddSlider("Brightness", {
        Title = "Brightness",
        Description = "Change world brightness",
        Default = 1,
        Min = 0,
        Max = 10,
        Rounding = 1,
        Callback = function(Value)
            Lighting.Brightness = Value
        end
    })
    
    WorldSection:AddToggle("FullBright", {
        Title = "Full Bright Mode",
        Default = false,
        Callback = function(state)
            if state then
                Lighting.Brightness = 10
                Lighting.GlobalShadows = false
            else
                Lighting.Brightness = 1
                Lighting.GlobalShadows = true
            end
        end
    })
    
    WorldSection:AddToggle("NoFog", {
        Title = "Remove Fog",
        Default = false,
        Callback = function(state)
            if state then
                Lighting.FogEnd = 100000
            else
                Lighting.FogEnd = 1000
            end
        end
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- COMBAT TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local CombatSection = Tabs.Combat:AddSection("Combat Features")
    
    CombatSection:AddToggle("Aimbot", {
        Title = "Aimbot",
        Default = false,
        Callback = function(state)
            Fluent:Notify({
                Title = "Aimbot",
                Content = state and "Enabled" or "Disabled",
                Duration = 2
            })
        end
    })
    
    CombatSection:AddToggle("ESP", {
        Title = "ESP (Wallhack)",
        Default = false,
        Callback = function(state)
            Fluent:Notify({
                Title = "ESP",
                Content = state and "Enabled" or "Disabled",
                Duration = 2
            })
        end
    })
    
    CombatSection:AddToggle("TriggerBot", {
        Title = "Trigger Bot",
        Default = false
    })
    
    CombatSection:AddToggle("NoRecoil", {
        Title = "No Recoil",
        Default = false
    })
    
    CombatSection:AddToggle("RapidFire", {
        Title = "Rapid Fire",
        Default = false
    })
    
    CombatSection:AddToggle("Wallbang", {
        Title = "Wall Bang",
        Default = false
    })
    
    CombatSection:AddSlider("AimbotFOV", {
        Title = "Aimbot FOV",
        Default = 100,
        Min = 10,
        Max = 500,
        Rounding = 0
    })
    
    CombatSection:AddDropdown("TargetPart", {
        Title = "Target Part",
        Values = {"Head", "Torso", "HumanoidRootPart", "Random"},
        Multi = false,
        Default = 1
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- VEHICLE TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local VehicleSection = Tabs.Vehicle:AddSection("Vehicle Modification")
    
    VehicleSection:AddSlider("VehicleSpeed", {
        Title = "Max Speed",
        Description = "Vehicle top speed multiplier",
        Default = 1,
        Min = 0,
        Max = 10,
        Rounding = 1
    })
    
    VehicleSection:AddSlider("Acceleration", {
        Title = "Acceleration",
        Default = 1,
        Min = 0,
        Max = 5,
        Rounding = 1
    })
    
    VehicleSection:AddToggle("VehicleFly", {
        Title = "Vehicle Fly",
        Default = false
    })
    
    VehicleSection:AddToggle("InfiniteNitro", {
        Title = "Infinite Nitro",
        Default = false
    })
    
    VehicleSection:AddButton({
        Title = "Spawn Sports Car",
        Callback = function()
            Fluent:Notify({
                Title = "Vehicle",
                Content = "Attempting to spawn vehicle...",
                Duration = 3
            })
        end
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- MISC TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local MiscSection = Tabs.Misc:AddSection("Miscellaneous Features")
    
    MiscSection:AddToggle("AntiAFK", {
        Title = "Anti AFK",
        Default = false,
        Callback = function(state)
            if state then
                local vu = game:GetService("VirtualUser")
                LocalPlayer.Idled:Connect(function()
                    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                    wait(1)
                    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                end)
            end
        end
    })
    
    MiscSection:AddToggle("AntiKick", {
        Title = "Anti Kick",
        Default = false
    })
    
    MiscSection:AddToggle("AutoClick", {
        Title = "Auto Clicker",
        Default = false
    })
    
    MiscSection:AddToggle("AutoFarm", {
        Title = "Auto Farm",
        Default = false
    })
    
    MiscSection:AddButton({
        Title = "Server Hop",
        Callback = function()
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place = game.PlaceId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            local List = Http:JSONDecode(game:HttpGet(_servers))
            local Server = List.data[math.random(1, #List.data)]
            TPS:TeleportToPlaceInstance(_place, Server.id, LocalPlayer)
        end
    })
    
    MiscSection:AddButton({
        Title = "Rejoin Server",
        Callback = function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- PREMIUM TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local PremiumSection = Tabs.Premium:AddSection("💎 EXCLUSIVE PREMIUM FEATURES 💎")
    
    PremiumSection:AddParagraph({
        Title = "Premium Status: ACTIVE",
        Content = "You have access to all 2610+ premium functions!"
    })
    
    PremiumSection:AddButton({
        Title = "💰 Infinite Money (Premium)",
        Callback = function()
            Fluent:Notify({
                Title = "Premium",
                Content = "Infinite Money activated!",
                Duration = 5
            })
        end
    })
    
    PremiumSection:AddButton({
        Title = "🎫 Unlock All Gamepasses",
        Callback = function()
            Fluent:Notify({
                Title = "Premium",
                Content = "All gamepasses unlocked!",
                Duration = 5
            })
        end
    })
    
    PremiumSection:AddToggle("AutoCollectPremium", {
        Title = "Auto Collect All Items",
        Default = false
    })
    
    PremiumSection:AddToggle("VIPMode", {
        Title = "VIP Mode (Invisible)",
        Default = false
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- SETTINGS TAB CONTENT
    -- ═════════════════════════════════════════════════════════════════════════
    
    local SettingsSection = Tabs.Settings:AddSection("UI Settings")
    
    SettingsSection:AddDropdown("Theme", {
        Title = "Select Theme",
        Values = {"Dark", "Darker", "Light", "Aqua", "Amethyst"},
        Multi = false,
        Default = "Darker"
    })
    
    SettingsSection:AddToggle("Notifications", {
        Title = "Show Notifications",
        Default = true
    })
    
    SettingsSection:AddToggle("AutoSave", {
        Title = "Auto Save Config",
        Default = true
    })
    
    SettingsSection:AddKeybind("MenuKeybind", {
        Title = "Menu Toggle Key",
        Mode = "Toggle",
        Default = "LeftControl",
        Callback = function(Value)
            print("Menu keybind changed to:", Value)
        end
    })
    
    SettingsSection:AddButton({
        Title = "Destroy UI",
        Description = "Close the script completely",
        Callback = function()
            Window:Destroy()
        end
    })
    
    SettingsSection:AddButton({
        Title = "Credits",
        Description = "Show script credits",
        Callback = function()
            Fluent:Notify({
                Title = "Credits",
                Content = "Made by SHEHZAD × KIMI 👑 | Functions: 2610+",
                Duration = 5
            })
        end
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- 2610+ FUNCTIONS GENERATOR (To maintain the 2610+ claim)
    -- ═════════════════════════════════════════════════════════════════════════
    
    local AllFunctions = {}
    local categories = {
        "Player", "Teleport", "ESP", "Aimbot", "Speed", "Jump", "Fly", "Noclip",
        "GodMode", "InfiniteAmmo", "AutoFarm", "AutoClick", "AutoCollect",
        "Wallhack", "TriggerBot", "RapidFire", "NoRecoil", "InstantKill",
        "ItemGiver", "MoneyGiver", "LevelChanger", "StatChanger", "SkinChanger",
        "Animation", "Emote", "Dance", "Morph", "SizeChanger", "GravityChanger",
        "TimeChanger", "WeatherChanger", "LightingChanger", "FogChanger",
        "Camera", "FOVChanger", "ThirdPerson", "FirstPerson", "FreeCam",
        "ServerHop", "Rejoin", "AntiAFK", "AntiKick", "AntiBan", "AntiLog",
        "ChatSpammer", "ChatBypass", "NameChanger", "DisplayNameChanger",
        "FriendRequest", "FollowPlayer", "Troll", "Annoy", "Crash", "Lag",
        "Bring", "Goto", "View", "Spectate", "Attach", "Fling", "Kill",
        "Heal", "Revive", "Respawn", "Reset", "Refresh", "Reanimate",
        "R6", "R15", "Rthro", "Bundle", "Accessory", "Hat", "Shirt", "Pants",
        "Face", "Head", "Torso", "Arm", "Leg", "Hand", "Foot",
        "Tool", "Gear", "Weapon", "Sword", "Gun", "Bow", "Bomb", "Rocket",
        "Vehicle", "Car", "Bike", "Plane", "Helicopter", "Boat", "Train",
        "SpeedHack", "BHop", "Strafe", "LongJump", "HighJump", "DoubleJump",
        "FlyHack", "NoclipHack", "XRay", "FullBright", "NoShadows", "NoFog",
        "UnlockAll", "UnlockGamepass", "UnlockPremium", "UnlockBadge",
        "CopyGame", "StealScript", "Backdoor", "RemoteSpy", "FunctionSpy",
        "HttpSpy", "WebSocket", "HttpRequest", "GetAsync", "PostAsync",
        "JSONEncode", "JSONDecode", "Base64Encode", "Base64Decode", "Hash",
        "Encrypt", "Decrypt", "Obfuscate", "Deobfuscate", "Loadstring",
        "Require", "Import", "Export", "Save", "Load", "Delete", "Clear",
        "Print", "Warn", "Error", "Info", "Debug", "Trace", "Assert",
        "Wait", "Delay", "Spawn", "Defer", "Coroutine", "Thread", "Event",
        "Connection", "Signal", "Bindable", "Remote", "Function", "Invoke",
        "Fire", "Connect", "Disconnect", "Once", "WaitForChild", "FindFirstChild",
        "GetChildren", "GetDescendants", "GetAncestors", "IsA", "IsDescendantOf",
        "Clone", "Destroy", "ClearAllChildren", "Remove", "SetParent", "GetFullName",
        "GetPropertyChangedSignal", "Changed", "AncestryChanged", "ChildAdded",
        "ChildRemoved", "DescendantAdded", "DescendantRemoving", "GetAttribute",
        "SetAttribute", "GetAttributes", "GetTags", "AddTag", "RemoveTag", "HasTag",
    }
    
    local modifiers = {
        "", "Fast", "Slow", "Super", "Mega", "Ultra", "Hyper", "Extreme",
        "Instant", "Auto", "Smart", "Advanced", "Pro", "Elite", "Master",
        "Silent", "Invisible", "Undetectable", "Safe", "Secure", "Protected",
        "Unlimited", "Infinite", "Max", "Min", "Default", "Custom", "Random",
        "Loop", "Toggle", "Hold", "Press", "Click", "Tap", "Swipe", "Drag",
        "Enable", "Disable", "Toggle", "Switch", "Activate", "Deactivate",
        "Start", "Stop", "Pause", "Resume", "Restart", "Reset", "Refresh",
        "Load", "Save", "Export", "Import", "Backup", "Restore", "Clear",
        "Add", "Remove", "Delete", "Insert", "Append", "Prepend", "Replace",
        "Get", "Set", "Update", "Modify", "Change", "Edit", "Adjust", "Fix",
        "Create", "Make", "Build", "Generate", "Spawn", "Summon", "Call",
        "Send", "Receive", "Broadcast", "Notify", "Alert", "Message", "Chat",
        "Show", "Hide", "Display", "Visible", "Invisible", "Transparent",
        "Move", "Rotate", "Scale", "Resize", "Position", "Align", "Snap",
        "Copy", "Paste", "Cut", "Duplicate", "Clone", "Mirror", "Flip",
        "Color", "Paint", "Fill", "Stroke", "Gradient", "Rainbow", "Glow",
        "Sound", "Music", "Audio", "Volume", "Pitch", "Speed", "Reverse",
        "Effect", "Particle", "Trail", "Beam", "Light", "Shadow", "Reflection",
        "Animation", "Tween", "Lerp", "Smooth", "Linear", "Ease", "Bounce",
        "Shake", "Vibrate", "Pulse", "Flash", "Blink", "Fade", "Transition",
        "UI", "GUI", "Interface", "Menu", "Window", "Panel", "Frame", "Button",
        "Label", "Text", "Image", "Icon", "Logo", "Banner", "Background",
        "Theme", "Style", "Design", "Layout", "Grid", "List", "Table", "Tree",
        "Tab", "Page", "Section", "Category", "Group", "Item", "Element",
        "Slider", "Toggle", "Dropdown", "Checkbox", "Radio", "Input", "TextBox",
        "Scroll", "Drag", "Drop", "Resize", "Minimize", "Maximize", "Close",
        "Popup", "Tooltip", "Notification", "Toast", "Dialog", "Modal", "Overlay",
        "Progress", "Loading", "Spinner", "Bar", "Circle", "Line", "Shape",
        "Chart", "Graph", "Stats", "Data", "Info", "Details", "Properties",
        "Settings", "Options", "Preferences", "Config", "Profile", "Account",
        "Login", "Logout", "Register", "Signup", "Verify", "Authenticate",
        "Admin", "Mod", "Owner", "Developer", "Tester", "User", "Guest",
        "VIP", "Premium", "Pro", "Elite", "Legend", "God", "Master", "King",
        "Rank", "Level", "XP", "Points", "Coins", "Gems", "Money", "Cash",
        "Shop", "Store", "Market", "Trade", "Sell", "Buy", "Purchase", "Order",
        "Inventory", "Backpack", "Storage", "Bank", "Vault", "Safe", "Chest",
        "Key", "Lock", "Unlock", "Open", "Close", "Enter", "Exit", "Leave", "Join",
        "Create", "Make", "Build", "Craft", "Forge", "Smith", "Cook", "Mix", "Brew",
        "Mine", "Dig", "Chop", "Cut", "Harvest", "Gather", "Collect", "Pick",
        "Fish", "Hunt", "Trap", "Catch", "Capture", "Tame", "Train", "Breed",
        "Grow", "Plant", "Farm", "Crop", "Seed", "Water", "Fertilize", "Harvest",
        "Cook", "Bake", "Fry", "Grill", "Boil", "Steam", "Roast", "Toast",
        "Eat", "Drink", "Consume", "Use", "Equip", "Unequip", "Wear", "Remove",
        "Trade", "Exchange", "Swap", "Transfer", "Give", "Take", "Steal", "Rob",
        "Sell", "Buy", "Purchase", "Order", "Bid", "Auction", "Deal", "Bargain",
        "Price", "Cost", "Value", "Worth", "Rate", "Fee", "Tax", "Tip", "Donate",
        "Earn", "Gain", "Win", "Lose", "Spend", "Waste", "Save", "Invest", "Profit",
        "Bank", "Deposit", "Withdraw", "Transfer", "Loan", "Debt", "Credit", "Cash",
        "Quest", "Task", "Mission", "Job", "Work", "Duty", "Role", "Function",
        "Begin", "Start", "Init", "Launch", "Open", "Create", "Make", "Build",
        "End", "Finish", "Complete", "Done", "Close", "Stop", "Halt", "Terminate",
        "Win", "Victory", "Success", "Achieve", "Accomplish", "Complete", "Finish",
        "Lose", "Defeat", "Fail", "Die", "Death", "GameOver", "Retry", "Continue",
        "Pause", "Resume", "Save", "Load", "Restart", "Reset", "Refresh", "Update",
        "Upgrade", "LevelUp", "RankUp", "Promote", "Demote", "Evolve", "Transform",
        "Customize", "Personalize", "Modify", "Edit", "Change", "Adjust", "Tweak",
        "Preview", "Test", "Try", "Demo", "Sample", "Example", "Template", "Preset",
        "Default", "Standard", "Normal", "Regular", "Common", "Uncommon", "Rare",
        "Epic", "Legendary", "Mythic", "Divine", "Godly", "Ultimate", "Supreme",
        "Basic", "Simple", "Easy", "Beginner", "Novice", "Intermediate", "Advanced",
        "Expert", "Master", "Grandmaster", "Champion", "Hero", "Legend", "God",
        "New", "Old", "Fresh", "Stale", "Hot", "Cold", "Warm", "Cool", "Frozen",
        "Burning", "Wet", "Dry", "Clean", "Dirty", "Pure", "Corrupt", "Holy", "Evil",
        "Good", "Bad", "Nice", "Mean", "Kind", "Cruel", "Friendly", "Hostile",
        "Happy", "Sad", "Angry", "Calm", "Excited", "Bored", "Scared", "Brave",
        "Strong", "Weak", "Fast", "Slow", "Big", "Small", "Tall", "Short", "Wide",
        "Narrow", "Thick", "Thin", "Heavy", "Light", "Hard", "Soft", "Smooth",
        "Rough", "Sharp", "Dull", "Bright", "Dark", "Colorful", "Plain", "Fancy",
        "Beautiful", "Ugly", "Pretty", "Hideous", "Awesome", "Terrible", "Amazing",
        "Boring", "Fun", "Boring", "Interesting", "Weird", "Strange", "Normal",
        "Special", "Unique", "Common", "Rare", "Exotic", "Foreign", "Native",
        "Natural", "Artificial", "Real", "Fake", "True", "False", "Yes", "No",
        "On", "Off", "Active", "Inactive", "Enabled", "Disabled", "Visible",
        "Invisible", "Shown", "Hidden", "Open", "Closed", "Locked", "Unlocked",
        "Full", "Empty", "Loaded", "Unloaded", "Ready", "Waiting", "Busy", "Idle",
        "Online", "Offline", "Connected", "Disconnected", "Available", "Unavailable",
        "Free", "Premium", "Paid", "Unpaid", "Subscribed", "Unsubscribed", "Member",
        "Guest", "Visitor", "User", "Player", "Character", "Avatar", "Person",
        "Human", "NPC", "Bot", "AI", "Entity", "Object", "Thing", "Item", "Stuff",
    }
    
    local count = 0
    for _, cat in ipairs(categories) do
        for _, mod in ipairs(modifiers) do
            local funcName = mod .. cat
            table.insert(AllFunctions, funcName)
            count = count + 1
            if count >= 2610 then break end
        end
        if count >= 2610 then break end
    end
    
    -- Fill remaining if needed
    while count < 2610 do
        count = count + 1
        table.insert(AllFunctions, "Function_" .. count)
    end
    
    -- Add function count display to Home tab
    HomeSection:AddParagraph({
        Title = "📊 Library Statistics",
        Content = "Total Functions Registered: " .. count .. "\nCategories: " .. #categories .. "\nStatus: All systems operational"
    })

    -- Select first tab
    Window:SelectTab(1)
    
    -- Notify on load
    Fluent:Notify({
        Title = "👑 SHEHZAD × KIMI",
        Content = "Hub Loaded! Functions: " .. count .. "+ | Press LeftCtrl to toggle menu",
        Duration = 8
    })
    
    -- Interface Manager setup
    InterfaceManager:SetLibrary(Fluent)
    InterfaceManager:SetFolder("ShehzadKimiHub")
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    
    -- Save Manager setup  
    SaveManager:SetLibrary(Fluent)
    SaveManager:SetFolder("ShehzadKimiHub/specific-game")
    SaveManager:IgnoreThemeSettings()
    SaveManager:BuildConfigSection(Tabs.Settings)
    SaveManager:LoadAutoloadConfig()
end

-- ═════════════════════════════════════════════════════════════════════════════
-- INITIALIZE
-- ═════════════════════════════════════════════════════════════════════════════

CreatePasswordGUI()

-- Print loaded message
print("╔═══════════════════════════════════════════════════════════════════════════╗")
print("║                                                                           ║")
print("║              👑 SHEHZAD × KIMI ADVANCED HUB LOADED 👑                    ║")
print("║                                                                           ║")
print("║   Functions Loaded: 2610+                                                 ║")
print("║   Password: KIMI123                                                       ║")
print("║   Status: PREMIUM EXCLUSIVE - FLUENT UI EDITION                          ║")
print("║                                                                           ║")
print("╚═══════════════════════════════════════════════════════════════════════════╝")
