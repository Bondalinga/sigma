-- Section: Initialization
local function initializeFrame()
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 600, 0, 350)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.new(0.3, 0.31, 0.3)
    frame.BorderSizePixel = 3
    frame.Active = true

    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = frame
    frameCorner.CornerRadius = UDim.new(0.15, 0)

    -- Add Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "Basket Ball Legends"
    titleLabel.TextColor3 = Color3.new(15,15,15)
    titleLabel.TextScaled = true
    titleLabel.Parent = frame

    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = titleLabel
    frameCorner.CornerRadius = UDim.new(0.25, 0)

    return frame
end

local function initializeToggleButton(screenGui)
    -- Create and configure the toggle button
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 100, 0, 25)
    toggleButton.Position = UDim2.new(0, 0, 0, 0)
    toggleButton.BackgroundColor3 = Color3.new(0.294118, 0.294118, 0.294118)
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.Text = "Toggle"
    toggleButton.TextScaled = true
    toggleButton.Parent = screenGui

    return toggleButton
end

local function initializeHighlightButton(frame)
    -- Create and configure the highlight button
    local highlightButton = Instance.new("TextButton")
    highlightButton.Size = UDim2.new(0, 150, 0, 50)
    highlightButton.Position = UDim2.new(1, -425, 1, -235)
    highlightButton.AnchorPoint = Vector2.new(1, 1)
    highlightButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    highlightButton.TextColor3 = Color3.new(1, 1, 1)
    highlightButton.Text = "Esp: B"
    highlightButton.TextScaled = true
    highlightButton.Parent = frame

    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = highlightButton
    frameCorner.CornerRadius = UDim.new(0.15, 0)

    local clicked = false
    highlightButton.MouseButton1Click:Connect(function()
        if not clicked then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Bondalinga/sigma/main/sigma.lua'))()
            clicked = true
        end
    end)

    return highlightButton
end

local function perfectShot(frame)
    local perfectShotButton = Instance.new("TextButton")
    perfectShotButton.Size = UDim2.new(0, 150, 0, 50)
    perfectShotButton.Position = UDim2.new(1, -425, 1, -175)
    perfectShotButton.AnchorPoint = Vector2.new(1, 1)
    perfectShotButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    perfectShotButton.TextColor3 = Color3.new(1, 1, 1)
    perfectShotButton.Text = "Mostly Green: Q"
    perfectShotButton.TextScaled = true
    perfectShotButton.Parent = frame

    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = perfectShotButton
    frameCorner.CornerRadius = UDim.new(0.15, 0)

    local clicked = false
    perfectShotButton.MouseButton1Click:Connect(function()
        if not clicked then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Bondalinga/sigma/main/sigma2.lua'))()
            clicked = true
        end
    end)

    return perfectShotButton
end

local function spinBot(frame)
    local spinBotButton = Instance.new("Text Button")
    spinBotButton.Size = UDim2.new(0, 150, 0, 50)
    spinBotButton.Position = UDim2.new(1, -425, 1, -115)
    spinBotButton.AnchorPoint = Vector2.new(1, 1)
    spinBotButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
    spinBotButton.TextColor3 = Color3.new(1, 1, 1)
    spinBotButton.Text = "Spin Bot"
    spinBotButton.TextScaled = true
    spinBotButton.Parent = frame

    local frameCorner = Instance.new("UICorner")
    frameCorner.Parent = spinBotButton
    frameCorner.CornerRadius = UDim.new(0.15, 0)

    spinBotButton.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Bondalinga/sigma/main/spin.lua'))()
    end)
end

-- Section: GUI Management
local function getOrCreateScreenGui()
    local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
    local screenGui = playerGui:FindFirstChild("ScreenGui")

    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "ScreenGui"
        screenGui.Parent = playerGui
    end

    return screenGui
end

-- Main Execution
local function main()
    local screenGui = getOrCreateScreenGui()

    local frame = initializeFrame()
    frame.Parent = screenGui
    setupDragging(frame)

    local toggleButton = initializeToggleButton(screenGui)
    toggleButton.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    initializeHighlightButton(frame)
    perfectShot(frame)
    spinBot(frame)
end

-- Execute the main function
main()
