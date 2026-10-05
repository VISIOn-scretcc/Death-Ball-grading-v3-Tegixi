-- DEATH BALL GRADING SCANNER v3 (GUI + CONSOLE)
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- ======================== НАСТРОЙКИ ========================
local isActive = false
local autoScan = false

-- ======================== GUI ========================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GradeScannerV3"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 550)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 100)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
title.Text = "🎴 GRADING SCANNER v3"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

-- Кнопка закрытия (свернуть)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

-- Кружок для открытия (когда свёрнуто)
local circleBtn = Instance.new("TextButton")
circleBtn.Size = UDim2.new(0, 50, 0, 50)
circleBtn.Position = UDim2.new(0, 20, 0.5, -25)
circleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
circleBtn.Text = "T"
circleBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
circleBtn.TextScaled = true
circleBtn.Font = Enum.Font.GothamBold
circleBtn.Visible = false
circleBtn.Parent = screenGui

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circleBtn

-- ======================== КНОПКИ ========================
local currentY = 55

-- Кнопка сканирования
local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(0.9, 0, 0, 35)
scanBtn.Position = UDim2.new(0.05, 0, 0, currentY)
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
scanBtn.Text = "🔍 СКАНИРОВАТЬ"
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.TextScaled = true
scanBtn.Font = Enum.Font.GothamBold
scanBtn.Parent = mainFrame

local scanCorner = Instance.new("UICorner")
scanCorner.CornerRadius = UDim.new(0, 8)
scanCorner.Parent = scanBtn
currentY = currentY + 45

-- Кнопка очистки
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0.9, 0, 0, 35)
clearBtn.Position = UDim2.new(0.05, 0, 0, currentY)
clearBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
clearBtn.Text = "🗑️ ОЧИСТИТЬ КОНСОЛЬ"
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.TextScaled = true
clearBtn.Font = Enum.Font.GothamBold
clearBtn.Parent = mainFrame

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = clearBtn
currentY = currentY + 45

-- Кнопка PANIC (выключить всё)
local panicBtn = Instance.new("TextButton")
panicBtn.Size = UDim2.new(0.9, 0, 0, 35)
panicBtn.Position = UDim2.new(0.05, 0, 0, currentY)
panicBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
panicBtn.Text = "🚨 PANIC (ВЫКЛЮЧИТЬ)"
panicBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
panicBtn.TextScaled = true
panicBtn.Font = Enum.Font.GothamBold
panicBtn.Parent = mainFrame

local panicCorner = Instance.new("UICorner")
panicCorner.CornerRadius = UDim.new(0, 8)
panicCorner.Parent = panicBtn
currentY = currentY + 45

-- Переключатель авто-скана
local autoScanBtn = Instance.new("TextButton")
autoScanBtn.Size = UDim2.new(0.9, 0, 0, 35)
autoScanBtn.Position = UDim2.new(0.05, 0, 0, currentY)
autoScanBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
autoScanBtn.Text = "🤖 АВТО-СКАН: OFF"
autoScanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoScanBtn.TextScaled = true
autoScanBtn.Font = Enum.Font.GothamBold
autoScanBtn.Parent = mainFrame

local autoCorner = Instance.new("UICorner")
autoCorner.CornerRadius = UDim.new(0, 8)
autoCorner.Parent = autoScanBtn
currentY = currentY + 45

-- Слайдер скорости
local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(0.9, 0, 0, 20)
sliderLabel.Position = UDim2.new(0.05, 0, 0, currentY)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "⏱️ Скорость: 0.5 сек"
sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sliderLabel.TextScaled = true
sliderLabel.Font = Enum.Font.Gotham
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
sliderLabel.Parent = mainFrame
currentY = currentY + 25

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0.9, 0, 0, 10)
slider.Position = UDim2.new(0.05, 0, 0, currentY)
slider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
slider.Parent = mainFrame

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
sliderFill.Parent = slider

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(1, 0)
sliderCorner.Parent = slider

local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(1, 0)
sliderFillCorner.Parent = sliderFill
currentY = currentY + 20

-- ======================== КОНСОЛЬ ========================
local consoleFrame = Instance.new("ScrollingFrame")
consoleFrame.Size = UDim2.new(0.9, 0, 0, 180)
consoleFrame.Position = UDim2.new(0.05, 0, 0, currentY)
consoleFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
consoleFrame.BorderSizePixel = 1
consoleFrame.BorderColor3 = Color3.fromRGB(0, 200, 80)
consoleFrame.ScrollBarThickness = 6
consoleFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
consoleFrame.Parent = mainFrame

local consoleCorner = Instance.new("UICorner")
consoleCorner.CornerRadius = UDim.new(0, 8)
consoleCorner.Parent = consoleFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 3)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = consoleFrame

-- ======================== ЛОГИКА ========================
local lineCounter = 0
local scanDelay = 0.5

local function clearConsole()
    for _, v in pairs(consoleFrame:GetChildren()) do
        if v:IsA("TextLabel") then
            v:Destroy()
        end
    end
    lineCounter = 0
end

local function addLine(text, color)
    lineCounter = lineCounter + 1
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 22)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = lineCounter
    label.Parent = consoleFrame
end

-- ======================== СКАНИРОВАНИЕ ========================
local function findCards()
    local cards = {}
    
    for _, v in pairs(playerGui:GetDescendants()) do
        if v.Name == "GradeLabel" and v:IsA("ImageLabel") then
            local pos = v.AbsolutePosition
            if pos.X > 0 and pos.Y > 0 and v.Visible then
                table.insert(cards, {
                    object = v,
                    position = pos,
                    image = tostring(v.Image)
                })
            end
        end
    end
    
    table.sort(cards, function(a, b)
        return a.position.X < b.position.X
    end)
    
    return cards
end

local function scanCards()
    clearConsole()
    addLine("=== СКАНИРОВАНИЕ ===", Color3.fromRGB(0, 255, 100))
    
    local cards = findCards()
    
    if #cards == 0 then
        addLine("❌ Карточки не найдены!", Color3.fromRGB(255, 100, 100))
        addLine("Открой окно Grading.", Color3.fromRGB(200, 200, 200))
        return
    end
    
    addLine("Найдено карт: " .. #cards, Color3.fromRGB(255, 255, 0))
    addLine("-------------------", Color3.fromRGB(100, 100, 100))
    
    local clowns = 0
    local sword = 0
    
    for i, card in ipairs(cards) do
        local imageId = card.image
        local text = ""
        local color = Color3.fromRGB(255, 255, 255)
        
        if imageId:find("GuiImagePlaceholder") then
            text = i .. ". ⚔️ МЕЧ (НЕ ТРОГАТЬ!)"
            color = Color3.fromRGB(255, 200, 0)
            sword = sword + 1
        elseif imageId:find("72494671681419") then
            text = i .. ". 🤡 КЛОУН"
            color = Color3.fromRGB(255, 100, 100)
            clowns = clowns + 1
        elseif imageId:find("94329879919910") then
            text = i .. ". 🤡 КЛОУН"
            color = Color3.fromRGB(255, 150, 100)
            clowns = clowns + 1
        else
            text = i .. ". ❓ НЕИЗВЕСТНО"
            color = Color3.fromRGB(150, 150, 150)
        end
        
        addLine(text, color)
    end
    
    addLine("-------------------", Color3.fromRGB(100, 100, 100))
    addLine("🤡 Клоунов: " .. clowns, Color3.fromRGB(255, 150, 100))
    addLine("⚔️ Мечей: " .. sword, Color3.fromRGB(255, 200, 0))
    addLine("✅ ГОТОВО!", Color3.fromRGB(0, 255, 100))
end

-- ======================== КНОПКИ ========================
scanBtn.MouseButton1Click:Connect(scanCards)
clearBtn.MouseButton1Click:Connect(clearConsole)

panicBtn.MouseButton1Click:Connect(function()
    isActive = false
    autoScan = false
    autoScanBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    autoScanBtn.Text = "🤖 АВТО-СКАН: OFF"
    clearConsole()
    addLine("🚨 PANIC! Всё выключено.", Color3.fromRGB(255, 50, 50))
end)

autoScanBtn.MouseButton1Click:Connect(function()
    autoScan = not autoScan
    if autoScan then
        autoScanBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        autoScanBtn.Text = "🤖 АВТО-СКАН: ON"
    else
        autoScanBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        autoScanBtn.Text = "🤖 АВТО-СКАН: OFF"
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    circleBtn.Visible = true
end)

circleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    circleBtn.Visible = false
end)

-- ======================== АВТО-СКАН ========================
task.spawn(function()
    while task.wait(scanDelay) do
        if autoScan then
            scanCards()
        end
    end
end)

print("✅ GRADING SCANNER v3 ЗАГРУЖЕН!")
