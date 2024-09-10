--- Credits
-- Youtube: @WhiteRabbitStudioRoblox

- Place the script inside a Frame which you want to move with everything you have inside

-- Variables
local frame = script.Parent -- The Frame to be moved
local userInputService = game:GetService("UserInputService")
local dragging = false
local dragStart
local startPos

-- Function to start dragging
local function onMouseDown(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then -- Detects left mouse click
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        print("Dragging started at: ", dragStart)

        -- Disconnect dragging when the mouse button is released
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                print("Dragging ended.")
            end
        end)
    end
end

-- Function to handle mouse movement
local function onMouseMove(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart -- Calculate the difference from the initial click position
        local newPosition = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        frame.Position = newPosition

        print("Frame moved to: ", newPosition)
    end
end

-- Connect events to start and handle dragging
frame.InputBegan:Connect(onMouseDown)
userInputService.InputChanged:Connect(onMouseMove)
