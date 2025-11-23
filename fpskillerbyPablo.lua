-- Inicio del Script para Delta Executor
-- Creador: AI Assistant
-- Propósito: Ejemplo de GUI para un executor

-- Servicios de Roblox que usaremos
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Referencia al jugador local
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Función para proteger el objeto de ser eliminado por anti-cheats
local function protect(obj)
	if obj and not gethiddenproperty or is_synapse then -- Detección simple de executor
		obj.RobloxLocked = true
	end
end

-- Crear la pantalla principal de la GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaExecutorHub"
screenGui.ResetOnSpawn = false -- Para que la GUI no desaparezca al morir
screenGui.Parent = game:GetService("CoreGui") -- Se pone en CoreGui para que no sea visible para otros jugadores
protect(screenGui)

-- Crear el marco principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
protect(mainFrame)

-- Añadir una esquina redondeada
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Título de la GUI
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Text = "Delta Hub v1.0"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = mainFrame
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Función para crear botones
local function createButton(text, position)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 250, 0, 40)
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.SourceSans
	button.TextSize = 18
	button.Text = text
	button.Parent = mainFrame
	
	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 5)
	buttonCorner.Parent = button
	
	-- Efecto hover
	button.MouseEnter:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(85, 85, 85)}):Play()
	end)
	button.MouseLeave:Connect(function()
		TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
	end)
	
	return button
end

-- Función para crear cajas de texto
local function createTextBox(text, position)
	local textBox = Instance.new("TextBox")
	textBox.Size = UDim2.new(0, 100, 0, 30)
	textBox.Position = position
	textBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
	textBox.TextColor3 = Color3.fromRGB(200, 200, 200)
	textBox.Font = Enum.Font.SourceSans
	textBox.TextSize = 16
	textBox.Text = text
	textBox.Parent = mainFrame

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 5)
	boxCorner.Parent = textBox
	
	return textBox
end

-- --- SECCIÓN DE VELOCIDAD ---
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0, 100, 0, 20)
speedLabel.Position = UDim2.new(0, 25, 0, 60)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidad:"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextSize = 16
speedLabel.Parent = mainFrame

local speedInput = createTextBox("25", UDim2.new(0, 130, 0, 55))
local speedButton = createButton("Aplicar Velocidad", UDim2.new(0, 25, 0, 95))

speedButton.MouseButton1Click:Connect(function()
	local newSpeed = tonumber(speedInput.Text)
	if newSpeed then
		humanoid.WalkSpeed = newSpeed
	end
end)

-- --- SECCIÓN DE SALTO ---
local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(0, 100, 0, 20)
jumpLabel.Position = UDim2.new(0, 25, 0, 145)
jumpLabel.BackgroundTransparency = 1
jumpLabel.Text = "Potencia Salto:"
jumpLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpLabel.Font = Enum.Font.SourceSans
jumpLabel.TextSize = 16
jumpLabel.Parent = mainFrame

local jumpInput = createTextBox("50", UDim2.new(0, 130, 0, 140))
local jumpButton = createButton("Aplicar Salto", UDim2.new(0, 25, 0, 180))

jumpButton.MouseButton1Click:Connect(function()
	local newJumpPower = tonumber(jumpInput.Text)
	if newJumpPower then
		humanoid.JumpPower = newJumpPower
	end
end)

-- Función para hacer que la GUI se pueda arrastrar
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Fin del Script
