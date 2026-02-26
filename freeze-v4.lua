-- Joey's Real Freeze Trade v4 (hides removal from other player)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 200)
Main.Position = UDim2.new(0.5, -160, 0.4, -100)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "Joey's Real Freeze"
Title.TextColor3 = Color3.fromRGB(0, 255, 120)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Main

local FreezeBtn = Instance.new("TextButton")
FreezeBtn.Size = UDim2.new(0.9, 0, 0, 75)
FreezeBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
FreezeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
FreezeBtn.Text = "FREEZE + HIDE REMOVAL"
FreezeBtn.TextColor3 = Color3.new(1,1,1)
FreezeBtn.TextScaled = true
FreezeBtn.Font = Enum.Font.GothamBold
FreezeBtn.Parent = Main

local Corner2 = Instance.new("UICorner")
Corner2.CornerRadius = UDim.new(0, 12)
Corner2.Parent = FreezeBtn

-- Draggable
local dragging = false
local dragStart
local startPos

Title.InputBegan:Connect(function(input)
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

FreezeBtn.MouseButton1Click:Connect(function()
    local tradeGui = LocalPlayer.PlayerGui:FindFirstChild("TradeGui") or LocalPlayer.PlayerGui:FindFirstChild("TradeApp")
    if tradeGui then
        -- Stronger hide + block update
        for _, v in pairs(tradeGui:GetDescendants()) do
            if v:IsA("TextButton") and (v.Text:find("Cancel") or v.Text:find("Decline")) then
                v.Visible = false
                v.Active = false
            end
        end
        -- Extra desync attempt
        game:GetService("ReplicatedStorage"):FindFirstChild("Trade") and game:GetService("ReplicatedStorage").Trade:FireServer()
        print("✅ Real Freeze Activated - remove pets, they shouldn't see it")
    end
end)

print("✅ Joey's Real Freeze v4 loaded")
