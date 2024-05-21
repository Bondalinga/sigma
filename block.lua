local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local targetToolName = "Basketball"
local followEnabled = false
local playerWithBall = nil
local followingPlayer = nil
local followDistanceLimit = 50

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 300, 0, 50)
textLabel.Position = UDim2.new(0.5, -150, 0, 50)
textLabel.BackgroundTransparency = 0.5
textLabel.TextScaled = true
textLabel.Visible = false
textLabel.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0, 110)
button.Text = "Move In Front of Player"
button.BackgroundTransparency = 0.5
button.TextScaled = true
button.Visible = false
button.Parent = screenGui

local function findNearestPlayerWithTool(toolName)
    local nearestPlayer = nil
    local shortestDistance = followDistanceLimit
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild(toolName) then
            local distance = (HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end
    return nearestPlayer
end

local function moveToInFrontOf(target)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
    local distance = (HumanoidRootPart.Position - targetHRP.Position).magnitude
    
    if distance <= followDistanceLimit then
        local targetPosition = targetHRP.Position
        local targetLookVector = targetHRP.CFrame.LookVector

        -- Calculate a position 3 studs in front of the target's HumanoidRootPart
        local newPosition = targetPosition + targetLookVector * 3
        local newCFrame = CFrame.new(newPosition, targetPosition)

        -- Move the local player's HumanoidRootPart to this new position and face the target
        HumanoidRootPart.CFrame = newCFrame

        followingPlayer = target
    end
end

local function onButtonClicked()
    if playerWithBall then
        moveToInFrontOf(playerWithBall)
    end
end

local function followLoop()
    while followEnabled do
        followingPlayer = findNearestPlayerWithTool(targetToolName)
        if followingPlayer then
            moveToInFrontOf(followingPlayer)
        end
        wait(0.1)
    end
end

local function toggleFollowing()
    followEnabled = not followEnabled
    if followEnabled then
        spawn(followLoop)
    else
        wait(1)
        followingPlayer = nil
    end
end

button.MouseButton1Click:Connect(onButtonClicked)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.T then
        toggleFollowing()
    end
end)

RunService.RenderStepped:Connect(function()
    if not followEnabled then
        playerWithBall = findNearestPlayerWithTool(targetToolName)
        if playerWithBall then
            textLabel.Text = playerWithBall.Name .. " has the ball!"
            textLabel.Visible = true
            button.Visible = true
        else
            textLabel.Visible = false
            button.Visible = false
        end
    end
end)
