local player = game.Players.LocalPlayer -- Get the local player
local character = player.Character or player.CharacterAdded:Wait() -- Get the player's character or wait for it to be added
local humanoid = character:WaitForChild("Humanoid") -- Get the humanoid part of the character

local function spinCharacter()
    while true do -- Run indefinitely
        local rotationAngle = math.random(1, 360) -- Generate a random rotation angle between 1 and 360 degrees
        -- Rotate the character around its primary part (usually the torso) by the generated angle
        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(rotationAngle), 0))
        wait(0.01) -- Wait for a short time to control the speed of spinning
    end
end

spinCharacter() -- Call the function to start spinning the character
