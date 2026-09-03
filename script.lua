-- [[ L11 MERE ALL TIME ]]
-- Developer: KOBRAyLEADERyS27

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- ژێبرنا مێنویا کەڤن ئەگەر هەبت
if CoreGui:FindFirstChild("L11_Script_GUI") then
    CoreGui.L11_Script_GUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "L11_Script_GUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- سەرەکی فریم (مێنویێ)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 20, 1, -240)
MainFrame.Size = UDim2.new(0, 220, 0, 210)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- تایبەتمەندیا ڤەگوهاستنا فڕێمان ب دەستی (Draggable)
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(MainFrame)

-- ناڤێ سکریپتێ (Title)
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = MainFrame
TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 8)
TitleLabel.Size = UDim2.new(0, 200, 0, 25)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "L11 MERE ALL TIME"
TitleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleLabel.TextSize = 16

-- ئاڤاتار و پشکا دێڤەلۆپەری
local DevContainer = Instance.new("Frame")
DevContainer.Parent = MainFrame
DevContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DevContainer.BackgroundTransparency = 0.5
DevContainer.Position = UDim2.new(0, 10, 0, 38)
DevContainer.Size = UDim2.new(0, 200, 0, 65)

local DevCorner = Instance.new("UICorner")
DevCorner.CornerRadius = UDim.new(0, 8)
DevCorner.Parent = DevContainer

--
local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Parent = DevContainer
AvatarImage.BackgroundTransparency = 1
AvatarImage.Position = UDim2.new(0, 8, 0, 8)
AvatarImage.Size = UDim2.new(0, 48, 0, 48)
AvatarImage.ImageTransparency = 0.25

task.spawn(function()
    local success, userId = pcall(function()
        return Players:GetUserIdFromNameAsync("KOBRAyL11")
    end)
    if success and userId then
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size420x420
        local content, isReady = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
        AvatarImage.Image = content
    else
        AvatarImage.Image = "rbxassetid://6034287595"
    end
end)

local DevText = Instance.new("TextLabel")
DevText.Parent = DevContainer
DevText.BackgroundTransparency = 1
DevText.Position = UDim2.new(0, 62, 0, 12)
DevText.Size = UDim2.new(0, 130, 0, 40)
DevText.Font = Enum.Font.SourceSans
DevText.Text = "OWNER:\nKOBRAyLEADERyS27"
DevText.TextColor3 = Color3.fromRGB(200, 200, 200)
DevText.TextSize = 13
DevText.TextXAlignment = Enum.TextXAlignment.Left

--
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 115)
ToggleButton.Size = UDim2.new(0, 200, 0, 40)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "بازدانا ئوتوماتیکی: ڤەمری"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleButton

local autoJumpEnabled = false

ToggleButton.MouseButton1Click:Connect(function()
    autoJumpEnabled = not autoJumpEnabled
    if autoJumpEnabled then
        ToggleButton.Text = "ە
      بازدانا ئوتوماتیکی: ڤەکريە"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
    else
        ToggleButton.Text = "بازدانا ئوتوماتیکی: ڤەمری"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    end
end)

-- لۆپێ بازدانێ هەر 3.0 چرکە جارەکێ
task.spawn(function()
    while true do
        task.wait(3.0)
        if autoJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local humanoid = LocalPlayer.Character.Humanoid
            if humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- دوگمەیا ڤەکرن و داخستنێ (ب شێوەیێ بازنەیەکا بچووک یان دوگمە)
local OpenCloseBtn = Instance.new("TextButton")
OpenCloseBtn.Parent = ScreenGui
OpenCloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenCloseBtn.Position = UDim2.new(0, 20, 1, -290)
OpenCloseBtn.Size = UDim2.new(0, 95, 0, 35)
OpenCloseBtn.Font = Enum.Font.SourceSansBold
OpenCloseBtn.Text = "د داخستن"
OpenCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCloseBtn.TextSize = 13

local OC_Corner = Instance.new("UICorner")
OC_Corner.CornerRadius = UDim.new(0, 6)
OC_Corner.Parent = OpenCloseBtn

makeDraggable(OpenCloseBtn)

local menuVisible = true
OpenCloseBtn.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainFrame.Visible = menuVisible
    if menuVisible then
        OpenCloseBtn.Text = "د داخستن"
    else
        OpenCloseBtn.Text = "ڤەکرن"
    end
end)
