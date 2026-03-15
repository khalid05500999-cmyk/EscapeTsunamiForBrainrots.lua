local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local HRP = character:WaitForChild("HumanoidRootPart")

local System = {
    Speed = 500,
    MinSpeed = 16,
    MaxSpeed = 5000,
    Step = 500,
    AntiDetect = false,
    BypassMode = "normal",
    WavesHidden = false,
    WavesFar = false,
    UI = {MainFrame = nil, LogoButton = nil, IsOpen = true},
    DiscordLink = "https://discord.gg/d6M6ZHZQXK",
    DiscordClicked = false
}

function System:CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "k143"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MP"
    MainFrame.Size = UDim2.new(0, 860, 0, 120)
    MainFrame.Position = UDim2.new(0.5, -430, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.25
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 20)
    Corner.Parent = MainFrame
    
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "G"
    Glow.Size = UDim2.new(1, 40, 1, 40)
    Glow.Position = UDim2.new(0, -20, 0, -20)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://10822646701"
    Glow.ImageColor3 = Color3.fromRGB(100, 0, 200)
    Glow.ImageTransparency = 0.8
    Glow.Parent = MainFrame
    
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TB"
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    TitleBar.BackgroundTransparency = 0.3
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 15)
    TitleCorner.Parent = TitleBar
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0.2, 0, 1, 0)
    Title.Position = UDim2.new(0.01, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔮 k143"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar
    
    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Name = "DB"
    DiscordBtn.Size = UDim2.new(0, 120, 0, 24)
    DiscordBtn.Position = UDim2.new(0.22, 0, 0.5, -12)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    DiscordBtn.BackgroundTransparency = 0.2
    DiscordBtn.Text = "💬 Discord"
    DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.TextSize = 12
    DiscordBtn.Font = Enum.Font.GothamBold
    DiscordBtn.Parent = TitleBar
    
    Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 8)
    
    DiscordBtn.MouseButton1Click:Connect(function()
        if not self.DiscordClicked then
            self.DiscordClicked = true
            DiscordBtn.Text = "💬 Open Link"
            DiscordBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            
            StarterGui:SetCore("SendNotification", {
                Title = "💬 Discord",
                Text = "Link copied! Tap again to open",
                Duration = 3
            })
            
            if setclipboard then
                setclipboard(self.DiscordLink)
            end
        else
            local success = pcall(function()
                game:GetService("HttpService")
            end)
            
            if success then
                StarterGui:SetCore("SendNotification", {
                    Title = "💬 Opening...",
                    Text = "Launching browser",
                    Duration = 2
                })
            end
            
            DiscordBtn.Text = "💬 Discord"
            DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
            self.DiscordClicked = false
        end
    end)
    
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    MinimizeBtn.Position = UDim2.new(1, -60, 0.5, -12.5)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    MinimizeBtn.BackgroundTransparency = 0.5
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 18
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Parent = TitleBar
    
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.BackgroundTransparency = 0.5
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TitleBar
    
    local SpeedSection = Instance.new("Frame")
    SpeedSection.Name = "SS"
    SpeedSection.Size = UDim2.new(0, 200, 0, 70)
    SpeedSection.Position = UDim2.new(0.38, 0, 0, 35)
    SpeedSection.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    SpeedSection.BackgroundTransparency = 0.4
    SpeedSection.Parent = MainFrame
    
    Instance.new("UICorner", SpeedSection).CornerRadius = UDim.new(0, 12)
    
    local SpeedTitle = Instance.new("TextLabel")
    SpeedTitle.Size = UDim2.new(1, 0, 0, 20)
    SpeedTitle.Text = "⚡ SPEED"
    SpeedTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
    SpeedTitle.TextSize = 12
    SpeedTitle.Font = Enum.Font.GothamBold
    SpeedTitle.Parent = SpeedSection
    
    local MinusBtn = Instance.new("TextButton")
    MinusBtn.Size = UDim2.new(0, 50, 0, 40)
    MinusBtn.Position = UDim2.new(0.05, 0, 0, 25)
    MinusBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    MinusBtn.BackgroundTransparency = 0.3
    MinusBtn.Text = "−"
    MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinusBtn.TextSize = 20
    MinusBtn.Font = Enum.Font.GothamBold
    MinusBtn.Parent = SpeedSection
    
    local SpeedDisplay = Instance.new("TextLabel")
    SpeedDisplay.Name = "SD"
    SpeedDisplay.Size = UDim2.new(0, 80, 0, 40)
    SpeedDisplay.Position = UDim2.new(0.5, -40, 0, 25)
    SpeedDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    SpeedDisplay.BackgroundTransparency = 0.5
    SpeedDisplay.Text = tostring(self.Speed)
    SpeedDisplay.TextColor3 = Color3.fromRGB(0, 255, 0)
    SpeedDisplay.TextSize = 18
    SpeedDisplay.Font = Enum.Font.GothamBold
    SpeedDisplay.Parent = SpeedSection
    
    Instance.new("UICorner", SpeedDisplay).CornerRadius = UDim.new(0, 8)
    self.UI.SpeedDisplay = SpeedDisplay
    
    local PlusBtn = Instance.new("TextButton")
    PlusBtn.Size = UDim2.new(0, 50, 0, 40)
    PlusBtn.Position = UDim2.new(0.95, -50, 0, 25)
    PlusBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    PlusBtn.BackgroundTransparency = 0.3
    PlusBtn.Text = "+"
    PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlusBtn.TextSize = 20
    PlusBtn.Font = Enum.Font.GothamBold
    PlusBtn.Parent = SpeedSection
    
    MinusBtn.MouseButton1Click:Connect(function()
        self:UpdateSpeed(self.Speed - self.Step)
    end)
    
    PlusBtn.MouseButton1Click:Connect(function()
        self:UpdateSpeed(self.Speed + self.Step)
    end)
    
    local OptionsSection = Instance.new("Frame")
    OptionsSection.Name = "OS"
    OptionsSection.Size = UDim2.new(0, 280, 0, 70)
    OptionsSection.Position = UDim2.new(0.62, 0, 0, 35)
    OptionsSection.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    OptionsSection.BackgroundTransparency = 0.5
    OptionsSection.Parent = MainFrame
    
    Instance.new("UICorner", OptionsSection).CornerRadius = UDim.new(0, 12)
    
    local opts = {
        {n = "🔒 Anti", v = "AntiDetect"},
        {n = "🎯 CFrame", v = "BypassMode", t = "cframe"},
        {n = "🌊 Hide", v = "WavesHidden", a = "HideWaves"},
        {n = "📤 Far", v = "WavesFar", a = "SendWavesFar"}
    }
    
    for i, o in ipairs(opts) do
        self:CreateOpt(OptionsSection, o.n, 0.02 + ((i-1) * 0.24), o)
    end
    
    self:MakeDrag(TitleBar, MainFrame)
    self.UI.MainFrame = MainFrame
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        self:Minimize(ScreenGui)
    end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

function System:CreateOpt(p, t, x, d)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0.22, 0, 0.8, 0)
    f.Position = UDim2.new(x, 0, 0.1, 0)
    f.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    f.BackgroundTransparency = 0.5
    f.Parent = p
    
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 0.5, 0)
    l.BackgroundTransparency = 1
    l.Text = t
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.TextSize = 10
    l.Font = Enum.Font.GothamBold
    l.Parent = f
    
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.8, 0, 0.4, 0)
    b.Position = UDim2.new(0.1, 0, 0.5, 0)
    b.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    b.BackgroundTransparency = 0.4
    b.Text = "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.Parent = f
    
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    
    local s = false
    b.MouseButton1Click:Connect(function()
        s = not s
        b.Text = s and "ON" or "OFF"
        b.BackgroundColor3 = s and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(100, 100, 100)
        
        if d.v == "AntiDetect" then
            self.AntiDetect = s
        elseif d.v == "BypassMode" then
            self.BypassMode = s and "cframe" or "normal"
        elseif d.v == "WavesHidden" then
            if s then self:HideWaves() else self:ShowWaves() end
        elseif d.v == "WavesFar" then
            if s then self:SendWavesFar() end
        end
    end)
end

function System:UpdateSpeed(ns)
    self.Speed = math.clamp(ns, self.MinSpeed, self.MaxSpeed)
    humanoid.WalkSpeed = self.Speed
    
    if self.UI.SpeedDisplay then
        local tw = TweenService:Create(self.UI.SpeedDisplay, TweenInfo.new(0.1), {
            Size = UDim2.new(0, 85, 0, 45)
        })
        tw:Play()
        
        task.delay(0.1, function()
            TweenService:Create(self.UI.SpeedDisplay, TweenInfo.new(0.1), {
                Size = UDim2.new(0, 80, 0, 40)
            }):Play()
        end)
        
        self.UI.SpeedDisplay.Text = tostring(self.Speed)
        
        if self.Speed <= 100 then
            self.UI.SpeedDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
        elseif self.Speed <= 500 then
            self.UI.SpeedDisplay.TextColor3 = Color3.fromRGB(0, 255, 0)
        elseif self.Speed <= 2000 then
            self.UI.SpeedDisplay.TextColor3 = Color3.fromRGB(255, 255, 0)
        else
            self.UI.SpeedDisplay.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
end

function System:MakeDrag(dh, mf)
    local dragging = false
    local ds, sp = nil, nil
    
    dh.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            ds = i.Position
            sp = mf.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
            local d = i.Position - ds
            mf.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

function System:Minimize(pg)
    local mf = self.UI.MainFrame
    if not mf then return end
    
    TweenService:Create(mf, TweenInfo.new(0.3), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(1, -30, 1, -30)
    }):Play()
    
    task.wait(0.3)
    mf.Visible = false
    
    if not self.UI.LogoButton then
        local lg = Instance.new("TextButton")
        lg.Name = "L"
        lg.Size = UDim2.new(0, 50, 0, 50)
        lg.Position = UDim2.new(1, -60, 1, -60)
        lg.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
        lg.BackgroundTransparency = 0.3
        lg.Text = "🔮"
        lg.TextSize = 24
        lg.Parent = pg
        
        Instance.new("UICorner", lg).CornerRadius = UDim.new(0.5, 0)
        
        local gl = Instance.new("ImageLabel")
        gl.Size = UDim2.new(1.4, 0, 1.4, 0)
        gl.Position = UDim2.new(-0.2, 0, -0.2, 0)
        gl.BackgroundTransparency = 1
        gl.Image = "rbxassetid://10822646701"
        gl.ImageColor3 = Color3.fromRGB(150, 0, 255)
        gl.ImageTransparency = 0.7
        gl.Parent = lg
        
        local r = 0
        RunService.RenderStepped:Connect(function()
            if lg.Parent then
                r = r + 2
                gl.Rotation = r
            end
        end)
        
        lg.MouseButton1Click:Connect(function()
            self:Restore()
        end)
        
        self:MakeDrag(lg, lg)
        self.UI.LogoButton = lg
    end
    
    self.UI.LogoButton.Visible = true
    self.UI.IsOpen = false
end

function System:Restore()
    if not self.UI.LogoButton then return end
    self.UI.LogoButton.Visible = false
    
    if self.UI.MainFrame then
        self.UI.MainFrame.Visible = true
        TweenService:Create(self.UI.MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 860, 0, 120),
            Position = UDim2.new(0.5, -430, 0, 10)
        }):Play()
    end
    
    self.UI.IsOpen = true
end

function System:HideWaves()
    self.WavesHidden = true
    for _, o in pairs(Workspace:GetDescendants()) do
        if o.Name:lower():find("tsunami") or o.Name:lower():find("wave") then
            if o:IsA("BasePart") then
                o:SetAttribute("op", o.Position)
                o.Transparency = 1
                o.CanCollide = false
            end
        end
    end
end

function System:ShowWaves()
    self.WavesHidden = false
    for _, o in pairs(Workspace:GetDescendants()) do
        if o.Name:lower():find("tsunami") or o.Name:lower():find("wave") then
            if o:IsA("BasePart") then
                local op = o:GetAttribute("op")
                if op then o.Position = op end
                o.Transparency = 0
                o.CanCollide = true
            end
        end
    end
end

function System:SendWavesFar()
    self.WavesFar = true
    for _, o in pairs(Workspace:GetDescendants()) do
        if o.Name:lower():find("tsunami") or o.Name:lower():find("wave") then
            if o:IsA("BasePart") then
                o.Position = Vector3.new(0, -10000, 0)
            end
        end
    end
end

spawn(function()
    while true do
        task.wait(0.03)
        if System.BypassMode == "cframe" and HRP then
            local md = humanoid.MoveDirection
            if md.Magnitude > 0 then
                HRP.CFrame = HRP.CFrame + (md * System.Speed * 0.03)
            end
        end
    end
end)

System:CreateUI()
System:UpdateSpeed(System.Speed)

StarterGui:SetCore("SendNotification", {
    Title = "✈️",
    Text = "k143 Loaded",
    Duration = 3
})

getgenv().k143 = System
