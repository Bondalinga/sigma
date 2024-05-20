local keyToHold = Enum.KeyCode.Q -- Change this to the key you want to use
local holdDuration = 0.325 -- Change this to the duration you want to hold the 'E' key (in seconds)

-- Function to hold down the 'E' key for a specified duration
local function holdEKey(duration)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
    wait(duration)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

-- Function to detect when the programmable key is pressed
local function onKeyPress(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == keyToHold then
        holdEKey(holdDuration)
    end
end

-- Connect the key press event
game:GetService("UserInputService").InputBegan:Connect(onKeyPress)
