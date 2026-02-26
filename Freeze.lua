-- Joey's Custom Freeze Trade (made with Grok)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 180)
Frame.Position = UDim2.new(0.5, -140, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Joey's Freeze Trade"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local FreezeBtn = Instance.new("TextButton")
FreezeBtn.Size = UDim2.new(0.85, 0, 0, 60)
FreezeBtn.Position = UDim2.new(0.075, 0, 0.45, 0)
FreezeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FreezeBtn.Text = "FREEZE TRADE NOW"
FreezeBtn.TextColor3 = Color3.new(1,1,1)
FreezeBtn.TextScaled = true
FreezeBtn.Font = Enum.Font.GothamBold
FreezeBtn.Parent = Frame

FreezeBtn.MouseButton1Click:Connect(function()
    local tradeGui = LocalPlayer.PlayerGui:FindFirstChild("TradeGui") or LocalPlayer.PlayerGui:FindFirstChild("TradeApp")
    if tradeGui then
        for _, v in pairs(tradeGui:GetDescendants()) do
            if v:IsA("TextButton") and (v.Text:find("Cancel") or v.Text:find("Decline")) then
                v.Visible = false
                v.Active = false
            end
        end
        print("✅ Trade Frozen - remove your pets")
    end
end)

print("Joey's Freeze Trade loaded - start a trade!")
