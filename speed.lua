-- Place this script in StarterPlayerScripts

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

local teleportDistance = 10
local teleportInterval = 0.1
local tweenTime = 0.25 -- Duration of the tween

local moveDirection = Vector3.new(0, 0, 0)

local directionMap = {
    [Enum.KeyCode.W] = Vector3.new(0, 0, -1),
    [Enum.KeyCode.S] = Vector3.new(0, 0, 1),
    [Enum.KeyCode.A] = Vector3.new(-1, 0, 0),
    [Enum.KeyCode.D] = Vector3.new(1, 0, 0)
}

-- Function to create a tween and move the player smoothly
local function teleport()
    while moveDirection.magnitude > 0 do
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local goalCFrame = rootPart.CFrame + (rootPart.CFrame:VectorToWorldSpace(moveDirection) * teleportDistance)

            -- Tween information
            local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
            local tween = tweenService:Create(rootPart, tweenInfo, {CFrame = goalCFrame})

            -- Play the tween
            tween:Play()
            tween.Completed:Wait()
        end
        wait(teleportInterval)
    end
end

-- Function to update movement direction
local function updateMoveDirection()
    moveDirection = Vector3.new(0, 0, 0)
    for key, direction in pairs(directionMap) do
        if userInputService:IsKeyDown(key) then
            moveDirection = moveDirection + direction
        end
    end
    if moveDirection.magnitude > 0 then
        moveDirection = moveDirection.unit -- Normalize to keep constant speed
    end
end

-- Function to check if the player starts or stops pressing movement keys
local function onInputChanged()
    updateMoveDirection()
    if moveDirection.magnitude > 0 then
        if not isMovingForward then
            isMovingForward = true
            spawn(teleport)
        end
    else
        isMovingForward = false
    end
end

-- Connect the input events
userInputService.InputBegan:Connect(onInputChanged)
userInputService.InputEnded:Connect(onInputChanged)

-- Initialize the move direction
updateMoveDirection()
