-- Joey's Freeze Trade v3 - Draggable + Always on top
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 180)
Main.Position = UDim2.new(0.5, -150, 0.4, -90)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "Joey's Freeze Trade"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

local FreezeBtn = Instance.new("TextButton")
FreezeBtn.Size = UDim2.new(0.85, 0, 0, 70)
FreezeBtn.Position = UDim2.new(0.075, 0, 0.45, 0)
FreezeBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
FreezeBtn.Text = "FREEZE TRADE NOW"
FreezeBtn.TextColor3 = Color3.new(1,1,1)
FreezeBtn.TextScaled = true
FreezeBtn.Font = Enum.Font.GothamBold
FreezeBtn.Parent = Main

-- Draggable (works on mobile)
local dragging = false
local dragStart
local startPos

TitleBar.InputBegan:Connect(function(input)
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
        for _, v in pairs(tradeGui:GetDescendants()) do
            if v:IsA("TextButton") and (v.Text:find("Cancel") or v.Text:find("Decline")) then
                v.Visible = false
                v.Active = false
            end
        end
        print("✅ Trade Frozen - remove your pets now!")
    end
end)

print("✅ Joey's Freeze Trade v3 loaded")
