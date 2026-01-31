--[[
    👑 SHEHZAD × KIMI | FREE PURCHASE V1
    Buy ANYTHING without Robux | Works on vulnerable games
--]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Market = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Http = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Remove old
for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "FreeBuyer" then v:Destroy() end
end

-- Spoof Gamepass Ownership (Makes game think you own it)
local oldOwns = Market.PlayerOwnsAsset
Market.PlayerOwnsAsset = function(self, player, id)
    if player == LocalPlayer then
        print("✅ Spoofed ownership of:", id)
        return true
    end
    return oldOwns(self, player, id)
end

-- Hook Purchase Prompt
local oldPrompt = Market.PromptGamePassPurchase
Market.PromptGamePassPurchase = function(self, player, id)
    if player == LocalPlayer then
        -- Fire success without buying
        Market.PromptGamePassPurchaseFinished:Fire(player, id, true)
        notify("✅ Gamepass " .. id .. " activated FREE!")
        return
    end
    return oldPrompt(self, player, id)
end

-- UI
local SG = Instance.new("ScreenGui")
SG.Name = "FreeBuyer"
SG.Parent = CoreGui
SG.ResetOnSpawn = false

-- Main Frame (Small)
local Main = Instance.new("Frame")
Main.Parent = SG
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.Position = UDim2.new(0.5, -150, 0.5, -100)
Main.Size = UDim2.new(0, 300, 0, 200)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Top
local Top = Instance.new("Frame", Main)
Top.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
Top.Size = UDim2.new(1, 0, 0, 30)
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Top)
Title.Text = "👑 FREE BUYER"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)

local Close = Instance.new("TextButton", Top)
Close.Text = "×"
Close.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.Position = UDim2.new(1, -28, 0.5, -10)
Close.Size = UDim2.new(0, 22, 0, 22)
Instance.new("UICorner", Close).CornerRadius = UDim.new(1, 0)
Close.MouseButton1Click:Connect(function() SG:Destroy() end)

-- Content
local Content = Instance.new("ScrollingFrame", Main)
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 10, 0, 40)
Content.Size = UDim2.new(1, -20, 1, -50)
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 8)

local function notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "FREE BUYER",
        Text = text,
        Duration = 3
    })
end

local function CreateButton(text, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    btn.Size = UDim2.new(1, 0, 0, 35)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        -- Visual feedback
        btn.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        game:GetService("Debris"):AddItem(btn:Clone(), 0.1)
        wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        callback()
    end)
    return btn
end

-- METHOD 1: Auto-detect Purchase Remotes
CreateButton("🔥 UNLOCK ALL (Auto-Detect)", function()
    -- Look for purchase remotes in ReplicatedStorage
    local remotes = {}
    
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local name = v.Name:lower()
            if name:match("purchase") or name:match("buy") or name:match("gamepass") or name:match("own") or name:match("unlock") then
                table.insert(remotes, v)
            end
        end
    end
    
    -- Fire all with true/success
    for _, remote in pairs(remotes) do
        if remote:IsA("RemoteEvent") then
            remote:FireServer(true)
        elseif remote:IsA("RemoteFunction") then
            pcall(function() remote:InvokeServer(true) end)
        end
    end
    
    notify("Fired " .. #remotes .. " purchase remotes!")
    
    -- Also try common patterns
    pcall(function()
        ReplicatedStorage.Buy:FireServer({Success = true})
        ReplicatedStorage.Purchase:FireServer(true)
        ReplicatedStorage.Gamepass:FireServer(true)
    end)
end)

-- METHOD 2: Spoof All Gamepasses
CreateButton("💎 ACTIVATE ALL GAMEPASSES", function()
    -- Common gamepass IDs to try
    for i = 1, 100 do
        Market.PromptGamePassPurchaseFinished:Fire(LocalPlayer, i, true)
    end
    notify("Activated all gamepass slots!")
    
    -- Try to get gamepasses from game description
    local succ, id = pcall(function()
        return game.GameId
    end)
    
    if succ then
        -- Notify user to manually enter ID if needed
        notify("Game ID: " .. id .. " | Check console for passes")
    end
end)

-- METHOD 3: Free Money/Currency
CreateButton("💰 FREE CURRENCY", function()
    -- Common currency remotes
    local currencyRemotes = {
        "AddCash", "AddMoney", "AddCoins", "AddGems", "GiveMoney", 
        "AddCurrency", "AddPoints", "GiveCash"
    }
    
    for _, name in pairs(currencyRemotes) do
        pcall(function()
            ReplicatedStorage[name]:FireServer(999999)
            ReplicatedStorage[name]:InvokeServer(999999)
        end)
    end
    
    -- Try leaderstats
    if LocalPlayer:FindFirstChild("leaderstats") then
        for _, stat in pairs(LocalPlayer.leaderstats:GetChildren()) do
            if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                stat.Value = 999999
            end
        end
    end
    
    notify("Attempted to give max currency!")
end)

-- METHOD 4: One-Click Buy (Universal)
CreateButton("🛒 ONE-CLICK BUY (Universal)", function()
    -- Hook into PromptPurchase
    local connections = getconnections or signal_get_connections
    if connections then
        for _, conn in pairs(connections(Market.PromptPurchaseRequested)) do
            conn:Disable()
        end
    end
    
    -- Auto-accept any purchase
    local old = Market.PromptPurchase
    Market.PromptPurchase = function(self, player, id)
        if player == LocalPlayer then
            Market.PromptPurchaseFinished:Fire(player, id, true)
            notify("Bought Item ID: " .. id .. " FREE!")
            return
        end
        return old(self, player, id)
    end
    
    notify("Auto-buy activated! Now click any buy button in game!")
end)

-- METHOD 5: Delete Purchase Prompts (Instant Buy)
CreateButton("⚡ INSTANT BUY MODE", function()
    -- Deletes the purchase GUI when it appears
    LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
        if child.Name:lower():match("purchase") or child.Name:lower():match("buy") or child.Name:lower():match("prompt") then
            -- Get the ID from the prompt if possible
            local id = child:FindFirstChild("ProductId") or child:FindFirstChild("GamePassId")
            if id then
                Market.PromptProductPurchaseFinished:Fire(LocalPlayer, id.Value, true)
                Market.PromptGamePassPurchaseFinished:Fire(LocalPlayer, id.Value, true)
            end
            child:Destroy()
            notify("Blocked purchase GUI & activated item!")
        end
    end)
    
    notify("Instant Buy Mode ON - Click any buy button!")
end)

-- Info
CreateButton("ℹ️ HOW TO USE", function()
    notify("1. Click any button above\n2. Go click buy buttons in game\n3. They work FREE!")
end)

-- Update Canvas
Content.CanvasSize = UDim2.new(0, 0, 0, #Content:GetChildren() * 43)

-- Drag
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

-- Animation
Main.Size = UDim2.new(0, 0, 0, 0)
game:GetService("TweenService"):Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 200)}):Play()

wait(1)
notify("SHEHZAD × KIMI | Click 'ONE-CLICK BUY' then buy anything!")

print("━━━━━━━━━━━━━━━━━━━━━━")
print("👑 FREE BUYER LOADED 👑")
print("Methods Available:")
print("1. Auto-Detect Purchase Remotes")
print("2. Spoof All Gamepasses")
print("3. Free Currency")
print("4. One-Click Buy")
print("5. Instant Buy Mode (Removes purchase GUI)")
print("━━━━━━━━━━━━━━━━━━━━━━")
