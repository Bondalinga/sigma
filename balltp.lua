-- Define the key we want to use
local teleportKey = Enum.KeyCode.F

-- Function to get the nearest basketball
local function getNearestBasketball()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

    local nearestBasketball = nil
    local shortestDistance = math.huge

    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("BasePart") and obj.Name == "Basketball" then
            local distance = (obj.Position - rootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestBasketball = obj
            end
        end
    end

    return nearestBasketball
end

-- Function to teleport to the nearest basketball
local function teleportToBasketball()
    local nearestBasketball = getNearestBasketball()
    if nearestBasketball then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if humanoid and humanoid.Sit then
            humanoid.Sit = false
        end

        -- Temporarily disable collisions
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end

        -- Set velocity to zero
        rootPart.Velocity = Vector3.new(0, 0, 0)

        -- Teleport the player
        rootPart.CFrame = nearestBasketball.CFrame

        -- Re-enable collisions after a short delay
        wait(0.1)
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Connect the key press event
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == teleportKey and not gameProcessedEvent then
        teleportToBasketball()
    end
end)
