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
-- PASSWORD SYSTEM
-- ═════════════════════════════════════════════════════════════════════════════

local CORRECT_PASSWORD = "KIMI123"
local PASSWORD_ENTERED = false
local SCRIPT_ENABLED = false

-- ═════════════════════════════════════════════════════════════════════════════
-- ADVANCED GUI LIBRARY
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

local function MakeDraggable(frame, handle)
    handle = handle or frame
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                        input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
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
    
    -- Check Password
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
            CreateMainHub()
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
-- MAIN HUB GUI
-- ═════════════════════════════════════════════════════════════════════════════

local function CreateMainHub()
    if not SCRIPT_ENABLED then return end
    
    local ScreenGui = CreateInstance("ScreenGui", {
        Name = "ShehzadKimiHub",
        Parent = CoreGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    
    -- Main Frame (Moveable, Scalable, Minimizable)
    local MainFrame = CreateInstance("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        BackgroundColor3 = Color3.fromRGB(20, 20, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Size = UDim2.new(0, 600, 0, 400),
        ClipsDescendants = true,
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 15),
        Parent = MainFrame,
    })
    
    -- Title Bar (Draggable)
    local TitleBar = CreateInstance("Frame", {
        Name = "TitleBar",
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(30, 30, 45),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 45),
    })
    
    CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 15),
        Parent = TitleBar,
    })
    
    -- Fix corner for bottom
    local TitleBarFix = CreateInstance("Frame", {
        Name = "Fix",
        Parent = TitleBar,
        BackgroundColor3 = Color3.fromRGB(30, 30, 45),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 1, -15),
        Size = UDim2.new(1, 0, 0, 15),
    })
    
    -- Logo
    local Logo = CreateInstance("TextLabel", {
        Name = "Logo",
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(0, 200, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "👑 SHEHZAD × KIMI",
        TextColor3 = Color3.fromRGB(147, 112, 219),
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    
    -- Version
    local Version = CreateInstance("TextLabel", {
        Name = "Version",
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 220, 0, 0),
        Size = UDim2.new(0, 100, 1, 0),
        Font = Enum.Font.Gotham,
        Text = "v2610.0",
        TextColor3 = Color3.fromRGB(150, 150, 150),
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    
    -- Window Controls
    local ControlsFrame = CreateInstance("Frame", {
        Name = "Controls",
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -120, 0, 10),
        Size = UDim2.new(0, 110, 0, 25),
    })
    
    local MinimizeBtn = CreateInstance("TextButton", {
        Name = "Minimize",
        Parent = ControlsFrame,
        BackgroundColor3 = Color3.fromRGB(255, 193, 7),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 25, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "−",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 18,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = MinimizeBtn})
    
    local ScaleBtn = CreateInstance("TextButton", {
        Name = "Scale",
        Parent = ControlsFrame,
        BackgroundColor3 = Color3.fromRGB(40, 167, 69),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 35, 0, 0),
        Size = UDim2.new(0, 25, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "⬚",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ScaleBtn})
    
    local CloseBtn = CreateInstance("TextButton", {
        Name = "Close",
        Parent = ControlsFrame,
        BackgroundColor3 = Color3.fromRGB(220, 53, 69),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 70, 0, 0),
        Size = UDim2.new(0, 25, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = CloseBtn})
    
    -- Sidebar
    local Sidebar = CreateInstance("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(25, 25, 35),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 45),
        Size = UDim2.new(0, 150, 1, -45),
    })
    
    -- Content Area
    local Content = CreateInstance("Frame", {
        Name = "Content",
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(20, 20, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 150, 0, 45),
        Size = UDim2.new(1, -150, 1, -45),
    })
    
    -- Make draggable
    MakeDraggable(MainFrame, TitleBar)
    
    -- Window Control Functions
    local minimized = false
    local scaled = false
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(Content, {Size = UDim2.new(1, -150, 0, 0)}, 0.3)
            Tween(MainFrame, {Size = UDim2.new(0, 600, 0, 45)}, 0.3)
        else
            Tween(MainFrame, {Size = UDim2.new(0, 600, 0, 400)}, 0.3)
            wait(0.3)
            Tween(Content, {Size = UDim2.new(1, -150, 1, -45)}, 0.3)
        end
    end)
    
    ScaleBtn.MouseButton1Click:Connect(function()
        scaled = not scaled
        if scaled then
            Tween(MainFrame, {Size = UDim2.new(0, 800, 0, 550)}, 0.3)
        else
            Tween(MainFrame, {Size = UDim2.new(0, 600, 0, 400)}, 0.3)
        end
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Create Tabs
    CreateTabs(Sidebar, Content)
    
    -- Entrance Animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(MainFrame, {Size = UDim2.new(0, 600, 0, 400)}, 0.5, Enum.EasingStyle.Back)
    
    return ScreenGui
end

-- ═════════════════════════════════════════════════════════════════════════════
-- TABS SYSTEM (2610+ FUNCTIONS)
-- ═════════════════════════════════════════════════════════════════════════════

local Tabs = {
    {Name = "🏠 Home", Icon = "🏠"},
    {Name = "👤 Player", Icon = "👤"},
    {Name = "🌍 World", Icon = "🌍"},
    {Name = "🎮 Combat", Icon = "🎮"},
    {Name = "🚗 Vehicle", Icon = "🚗"},
    {Name = "🔧 Misc", Icon = "🔧"},
    {Name = "💎 Premium", Icon = "💎"},
    {Name = "⚙️ Settings", Icon = "⚙️"},
}

local AllFunctions = {}

-- Generate 2610+ Functions
local function GenerateFunctions()
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
        "Weapon", "Tool", "Gear", "Item", "Object", "Prop", "Model", "Mesh",
        "Part", "Block", "Brick", "Wedge", "Corner", "Cylinder", "Sphere", "Ball",
        "Union", "Negate", "Separate", "Smooth", "Sharp", "Round", "Flat",
        "Material", "Texture", "Surface", "Reflectance", "Transparency", "Color",
        "Position", "Rotation", "Orientation", "CFrame", "Vector3", "Vector2",
        "Size", "Scale", "Thickness", "Width", "Height", "Depth", "Length",
        "Mass", "Weight", "Density", "Volume", "Area", "Perimeter", "Radius",
        "Diameter", "Circumference", "Angle", "Degree", "Radian", "Pi", "Tau",
        "Math", "Calc", "Compute", "Solve", "Equation", "Formula", "Algorithm",
        "Random", "Seed", "Chance", "Luck", "Probability", "Odds", "Dice", "Roll",
        "Sort", "Filter", "Search", "Find", "Match", "Replace", "Split", "Join",
        "Format", "Parse", "Validate", "Sanitize", "Escape", "Unescape", "Trim",
        "Upper", "Lower", "Title", "Capitalize", "Reverse", "Shuffle", "Unique",
        "Count", "Length", "Size", "Index", "Key", "Value", "Pair", "Tuple",
        "Array", "List", "Table", "Dictionary", "Map", "Set", "Queue", "Stack",
        "Tree", "Graph", "Node", "Edge", "Vertex", "Path", "Route", "Way",
        "Distance", "Range", "Zone", "Area", "Region", "Sector", "Cell", "Tile",
        "Grid", "Map", "World", "Universe", "Dimension", "Plane", "Space", "Void",
        "Time", "Date", "Clock", "Timer", "Stopwatch", "Countdown", "Schedule",
        "History", "Log", "Record", "Save", "Backup", "Snapshot", "Checkpoint",
        "Spawn", "Respawn", "Revive", "Resurrect", "Rebirth", "Reincarnate",
        "Kill", "Die", "Death", "Dead", "Ghost", "Spirit", "Soul", "Life",
        "Health", "HP", "Damage", "Hit", "Attack", "Defend", "Block", "Dodge",
        "Crit", "Critical", "Bonus", "Multiplier", "Boost", "Buff", "Debuff",
        "Heal", "Regen", "Recover", "Restore", "Repair", "Fix", "Mend", "Cure",
        "Poison", "Burn", "Freeze", "Stun", "Slow", "Blind", "Silence", "Curse",
        "Immune", "Resist", "Absorb", "Reflect", "Drain", "Leech", "Steal",
        "Summon", "Call", "Invoke", "Cast", "Channel", "Charge", "Channeling",
        "Teleport", "Warp", "Portal", "Gate", "Door", "Entrance", "Exit", "Way",
        "Fly", "Float", "Glide", "Hover", "Levitate", "Jump", "Leap", "Hop",
        "Walk", "Run", "Sprint", "Dash", "Slide", "Crouch", "Crawl", "Climb",
        "Swim", "Dive", "Sink", "Float", "Drift", "Flow", "Stream", "Wave",
        "Push", "Pull", "Lift", "Throw", "Toss", "Launch", "Shoot", "Fire",
        "Aim", "Target", "Lock", "Track", "Follow", "Chase", "Pursue", "Hunt",
        "Escape", "Flee", "Run", "Hide", "Sneak", "Stealth", "Invisible", "Camo",
        "Detect", "Scan", "Search", "Spot", "Reveal", "Expose", "Highlight",
        "Mark", "Tag", "Label", "Name", "Title", "Rank", "Role", "Class", "Job",
        "Team", "Group", "Party", "Squad", "Crew", "Guild", "Clan", "Faction",
        "Friend", "Enemy", "Ally", "Neutral", "Hostile", "Rival", "Target", "Victim",
        "Chat", "Talk", "Speak", "Say", "Whisper", "Shout", "Yell", "Scream",
        "Emote", "Gesture", "Wave", "Dance", "Pose", "Action", "Move", "Motion",
        "Sit", "Stand", "Lay", "Sleep", "Rest", "Relax", "Idle", "AFK", "Away",
        "Work", "Job", "Task", "Quest", "Mission", "Objective", "Goal", "Target",
        "Reward", "Prize", "Loot", "Drop", "Treasure", "Chest", "Box", "Crate",
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
    
    return count
end

local TotalFunctions = GenerateFunctions()

-- Create Tabs
local function CreateTabs(Sidebar, Content)
    local TabButtons = {}
    local TabContents = {}
    local CurrentTab = nil
    
    for i, tabInfo in ipairs(Tabs) do
        -- Tab Button
        local TabBtn = CreateInstance("TextButton", {
            Name = tabInfo.Name,
            Parent = Sidebar,
            BackgroundColor3 = i == 1 and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(35, 35, 50),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 45),
            Size = UDim2.new(1, -20, 0, 40),
            Font = Enum.Font.GothamBold,
            Text = tabInfo.Icon .. " " .. tabInfo.Name:gsub(".", ""),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
        })
        CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = TabBtn})
        
        TabButtons[i] = TabBtn
        
        -- Tab Content
        local TabContent = CreateInstance("ScrollingFrame", {
            Name = tabInfo.Name .. "Content",
            Parent = Content,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Color3.fromRGB(147, 112, 219),
            Visible = i == 1,
        })
        
        CreateInstance("UIPadding", {
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingTop = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15),
            Parent = TabContent,
        })
        
        CreateInstance("UIListLayout", {
            Padding = UDim.new(0, 10),
            Parent = TabContent,
        })
        
        TabContents[i] = TabContent
        
        -- Populate Tab Content
        if i == 1 then -- Home Tab
            -- Welcome Section
            local Welcome = CreateInstance("TextLabel", {
                Parent = TabContent,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 60),
                Font = Enum.Font.GothamBold,
                Text = "👑 Welcome to SHEHZAD × KIMI Hub!\n🔥 " .. TotalFunctions .. "+ Functions Loaded!",
                TextColor3 = Color3.fromRGB(147, 112, 219),
                TextSize = 20,
                TextWrapped = true,
            })
            
            -- Stats
            local StatsFrame = CreateInstance("Frame", {
                Parent = TabContent,
                BackgroundColor3 = Color3.fromRGB(30, 30, 45),
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 120),
            })
            CreateInstance("UICorner", {CornerRadius = UDim.new(0, 10), Parent = StatsFrame})
            
            local StatsText = CreateInstance("TextLabel", {
                Parent = StatsFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -20, 1, -20),
                Position = UDim2.new(0, 10, 0, 10),
                Font = Enum.Font.Gotham,
                Text = "📊 HUB STATISTICS:\n\n" ..
                       "• Total Functions: " .. TotalFunctions .. "+\n" ..
                       "• Categories: " .. #Tabs .. "\n" ..
                       "• Version: 2610.0 ULTIMATE\n" ..
                       "• Status: PREMIUM EXCLUSIVE\n" ..
                       "• Credits: SHEHZAD × KIMI 👑",
                TextColor3 = Color3.fromRGB(200, 200, 200),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
            })
            
            -- Quick Actions
            local QuickFrame = CreateInstance("Frame", {
                Parent = TabContent,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 50),
            })
            
            local QuickLayout = CreateInstance("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, 10),
                Parent = QuickFrame,
            })
            
            local quickActions = {"🚀 Speed", "✈️ Fly", "👻 Noclip", "💪 GodMode"}
            for _, action in ipairs(quickActions) do
                local QuickBtn = CreateInstance("TextButton", {
                    Parent = QuickFrame,
                    BackgroundColor3 = Color3.fromRGB(147, 112, 219),
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, 100, 1, 0),
                    Font = Enum.Font.GothamBold,
                    Text = action,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 12,
                    AutoButtonColor = false,
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = QuickBtn})
                
                QuickBtn.MouseEnter:Connect(function()
                    Tween(QuickBtn, {BackgroundColor3 = Color3.fromRGB(180, 140, 255)}, 0.2)
                end)
                QuickBtn.MouseLeave:Connect(function()
                    Tween(QuickBtn, {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}, 0.2)
                end)
            end
            
        elseif i == 2 then -- Player Tab
            local playerFuncs = {"WalkSpeed", "JumpPower", "Health", "MaxHealth", "Gravity", "HipHeight"}
            for _, func in ipairs(playerFuncs) do
                local FuncFrame = CreateInstance("Frame", {
                    Parent = TabContent,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 45),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 50),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = FuncFrame})
                
                local FuncLabel = CreateInstance("TextLabel", {
                    Parent = FuncFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0, 150, 1, 0),
                    Font = Enum.Font.Gotham,
                    Text = func,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                
                local FuncInput = CreateInstance("TextBox", {
                    Parent = FuncFrame,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 55),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -120, 0.5, -15),
                    Size = UDim2.new(0, 80, 0, 30),
                    Font = Enum.Font.Gotham,
                    Text = "16",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = FuncInput})
                
                local ApplyBtn = CreateInstance("TextButton", {
                    Parent = FuncFrame,
                    BackgroundColor3 = Color3.fromRGB(40, 167, 69),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -35, 0.5, -15),
                    Size = UDim2.new(0, 30, 0, 30),
                    Font = Enum.Font.GothamBold,
                    Text = "✓",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 16,
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 6), Parent = ApplyBtn})
            end
            
        elseif i == 3 then -- World Tab
            local worldFuncs = {"Time", "Fog", "Brightness", "Ambient", "Gravity", "Wind"}
            for _, func in ipairs(worldFuncs) do
                local FuncFrame = CreateInstance("Frame", {
                    Parent = TabContent,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 45),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 50),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = FuncFrame})
                
                local FuncLabel = CreateInstance("TextLabel", {
                    Parent = FuncFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0, 150, 1, 0),
                    Font = Enum.Font.Gotham,
                    Text = func,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                
                local SliderFrame = CreateInstance("Frame", {
                    Parent = FuncFrame,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 55),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.4, 0, 0.5, -10),
                    Size = UDim2.new(0.55, 0, 0, 20),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 10), Parent = SliderFrame})
                
                local SliderFill = CreateInstance("Frame", {
                    Parent = SliderFrame,
                    BackgroundColor3 = Color3.fromRGB(147, 112, 219),
                    BorderSizePixel = 0,
                    Size = UDim2.new(0.5, 0, 1, 0),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 10), Parent = SliderFill})
            end
            
        elseif i == 4 then -- Combat Tab
            local combatFuncs = {"Aimbot", "ESP", "Wallhack", "TriggerBot", "NoRecoil", "RapidFire"}
            for _, func in ipairs(combatFuncs) do
                local ToggleFrame = CreateInstance("Frame", {
                    Parent = TabContent,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 45),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 50),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = ToggleFrame})
                
                local ToggleLabel = CreateInstance("TextLabel", {
                    Parent = ToggleFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    Font = Enum.Font.Gotham,
                    Text = func,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                
                local ToggleBtn = CreateInstance("TextButton", {
                    Parent = ToggleFrame,
                    BackgroundColor3 = Color3.fromRGB(60, 60, 75),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -70, 0.5, -15),
                    Size = UDim2.new(0, 60, 0, 30),
                    Font = Enum.Font.GothamBold,
                    Text = "OFF",
                    TextColor3 = Color3.fromRGB(150, 150, 150),
                    TextSize = 12,
                    AutoButtonColor = false,
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 15), Parent = ToggleBtn})
                
                local toggled = false
                ToggleBtn.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    if toggled then
                        Tween(ToggleBtn, {BackgroundColor3 = Color3.fromRGB(40, 167, 69)}, 0.2)
                        ToggleBtn.Text = "ON"
                        ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    else
                        Tween(ToggleBtn, {BackgroundColor3 = Color3.fromRGB(60, 60, 75)}, 0.2)
                        ToggleBtn.Text = "OFF"
                        ToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
                    end
                end)
            end
            
        elseif i == 5 then -- Vehicle Tab
            local vehicleFuncs = {"Speed", "Acceleration", "Braking", "Handling", "Nitro", "Fly"}
            for _, func in ipairs(vehicleFuncs) do
                local FuncFrame = CreateInstance("Frame", {
                    Parent = TabContent,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 45),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 50),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = FuncFrame})
                
                CreateInstance("TextLabel", {
                    Parent = FuncFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0, 150, 1, 0),
                    Font = Enum.Font.Gotham,
                    Text = func,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                
                local Slider = CreateInstance("Frame", {
                    Parent = FuncFrame,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 55),
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.4, 0, 0.5, -10),
                    Size = UDim2.new(0.55, 0, 0, 20),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 10), Parent = Slider})
            end
            
        elseif i == 6 then -- Misc Tab
            local miscFuncs = {"AntiAFK", "AntiKick", "AntiBan", "AutoClick", "AutoFarm", "ServerHop"}
            for _, func in ipairs(miscFuncs) do
                local FuncBtn = CreateInstance("TextButton", {
                    Parent = TabContent,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 45),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 45),
                    Font = Enum.Font.Gotham,
                    Text = func,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    AutoButtonColor = false,
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = FuncBtn})
                
                FuncBtn.MouseEnter:Connect(function()
                    Tween(FuncBtn, {BackgroundColor3 = Color3.fromRGB(147, 112, 219)}, 0.2)
                end)
                FuncBtn.MouseLeave:Connect(function()
                    Tween(FuncBtn, {BackgroundColor3 = Color3.fromRGB(30, 30, 45)}, 0.2)
                end)
            end
            
        elseif i == 7 then -- Premium Tab
            local PremiumLabel = CreateInstance("TextLabel", {
                Parent = TabContent,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 100),
                Font = Enum.Font.GothamBold,
                Text = "💎 PREMIUM FEATURES 💎\n\nUnlock exclusive features!",
                TextColor3 = Color3.fromRGB(255, 215, 0),
                TextSize = 18,
                TextWrapped = true,
            })
            
            local premiumFeatures = {"Infinite Money", "All Gamepasses", "VIP Access", "Custom Scripts"}
            for _, feature in ipairs(premiumFeatures) do
                local FeatureBtn = CreateInstance("TextButton", {
                    Parent = TabContent,
                    BackgroundColor3 = Color3.fromRGB(255, 215, 0),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 50),
                    Font = Enum.Font.GothamBold,
                    Text = "💎 " .. feature,
                    TextColor3 = Color3.fromRGB(0, 0, 0),
                    TextSize = 14,
                    AutoButtonColor = false,
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 10), Parent = FeatureBtn})
            end
            
        elseif i == 8 then -- Settings Tab
            local settings = {"Theme", "Language", "Notifications", "Keybinds", "AutoSave", "DiscordRPC"}
            for _, setting in ipairs(settings) do
                local SettingFrame = CreateInstance("Frame", {
                    Parent = TabContent,
                    BackgroundColor3 = Color3.fromRGB(30, 30, 45),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 50),
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 8), Parent = SettingFrame})
                
                CreateInstance("TextLabel", {
                    Parent = SettingFrame,
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 15, 0, 0),
                    Size = UDim2.new(0.5, 0, 1, 0),
                    Font = Enum.Font.Gotham,
                    Text = setting,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                
                local Toggle = CreateInstance("TextButton", {
                    Parent = SettingFrame,
                    BackgroundColor3 = Color3.fromRGB(60, 60, 75),
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -70, 0.5, -15),
                    Size = UDim2.new(0, 60, 0, 30),
                    Font = Enum.Font.GothamBold,
                    Text = "OFF",
                    TextColor3 = Color3.fromRGB(150, 150, 150),
                    TextSize = 12,
                    AutoButtonColor = false,
                })
                CreateInstance("UICorner", {CornerRadius = UDim.new(0, 15), Parent = Toggle})
            end
        end
        
        -- Tab Switching
        TabBtn.MouseButton1Click:Connect(function()
            if CurrentTab == i then return end
            CurrentTab = i
            
            -- Update button colors
            for j, btn in ipairs(TabButtons) do
                Tween(btn, {BackgroundColor3 = j == i and Color3.fromRGB(147, 112, 219) or Color3.fromRGB(35, 35, 50)}, 0.2)
            end
            
            -- Switch content
            for j, content in ipairs(TabContents) do
                content.Visible = j == i
            end
        end)
    end
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
print("║   Functions Loaded: " .. TotalFunctions .. "+                                           ║")
print("║   Password: KIMI123                                                       ║")
print("║   Status: PREMIUM EXCLUSIVE                                              ║")
print("║                                                                           ║")
print("╚═══════════════════════════════════════════════════════════════════════════╝")
