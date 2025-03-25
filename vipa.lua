--[[
  KemilingHUB - Ultimate Combat Script
  Features:
  - License system with GUI
  - ESP with health bars
  - Body/Head Aimbot
  - Spin attack (Q)
  - Teleport behind target (G)
  - Location teleport (P)
  - Webhook notifications
]]

-- ===== LICENSE SYSTEM =====
local licenseKey = "https://pastebin.com/raw/DxMGTLAn"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LicenseGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- GUI Creation
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 250)
frame.Position = UDim2.new(0.5, -175, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local innerFrame = Instance.new("Frame")
innerFrame.Size = UDim2.new(1, -4, 1, -4)
innerFrame.Position = UDim2.new(0, 2, 0, 2)
innerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
innerFrame.BorderSizePixel = 0
innerFrame.Parent = frame

local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(0, 8)
innerCorner.Parent = innerFrame

-- GUI Elements
local title = Instance.new("TextLabel")
title.Text = "LICENSE VERIFICATION"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 50, 50)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextStrokeTransparency = 0.7
title.Parent = innerFrame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.8, 0, 0, 45)
inputBox.Position = UDim2.new(0.1, 0, 0.3, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.PlaceholderText = "Enter license key"
inputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.Parent = innerFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = inputBox

local submitButton = Instance.new("TextButton")
submitButton.Size = UDim2.new(0.6, 0, 0, 45)
submitButton.Position = UDim2.new(0.2, 0, 0.6, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.Text = "SUBMIT"
submitButton.Font = Enum.Font.GothamBold
submitButton.TextSize = 18
submitButton.AutoButtonColor = false
submitButton.Parent = innerFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = submitButton

local buttonGradient = Instance.new("UIGradient")
buttonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 20, 20))
})
buttonGradient.Rotation = 90
buttonGradient.Parent = submitButton

local statusLabel = Instance.new("TextLabel")
statusLabel.Text = ""
statusLabel.Size = UDim2.new(0.8, 0, 0, 25)
statusLabel.Position = UDim2.new(0.1, 0, 0.8, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.Parent = innerFrame

-- Button effects
submitButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        buttonGradient,
        TweenInfo.new(0.2),
        {Rotation = 270}
    ):Play()
end)

submitButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        buttonGradient,
        TweenInfo.new(0.2),
        {Rotation = 90}
    ):Play()
end)

-- License verification
local function checkLicense(enteredKey)
    local success, response = pcall(function()
        return game:HttpGet(licenseKey)
    end)
    
    if not success then
        statusLabel.Text = "Failed to fetch licenses"
        statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        return false
    end
    
    for validKey in response:gmatch("[^\r\n]+") do
        if validKey:lower() == enteredKey:lower() then
            return true
        end
    end
    
    return false
end

-- Function to send webhook
local function sendWebhook()
    --// Config
    getgenv().whscript = "KemilingHUB Cdid"        --Change to the name of your script
    getgenv().webhookexecUrl = "https://discord.com/api/webhooks/1354067117464485959/ujySjJeB-Ceb6cL2HkIfuM9yN5qpltMTPi7lGU60XCiK4VlpMJSkt1uLo11zNCtx8fUa"  --Put your Webhook Url here
    getgenv().ExecLogSecret = true                --decide to also log secret section

    --// Execution Log Script
    local ui = gethui()
    local folderName = "screen"
    local folder = Instance.new("Folder")
    folder.Name = folderName
    local player = game:GetService("Players").LocalPlayer

    if ui:FindFirstChild(folderName) then
        print("Script is already executed! Rejoin if it's an error!")
        local ui2 = gethui()
        local folderName1 = "screen2"
        local folder2 = Instance.new("Folder")
        folder2.Name = folderName1
        if ui2:FindFirstChild(folderName1) then
            player:Kick("Anti-spam execution system triggered. Please rejoin to proceed.")
        else
            folder2.Parent = gethui()
        end
    else
        folder.Parent = gethui()
        local players = game:GetService("Players")
        local userid = player.UserId
        local gameid = game.PlaceId
        local jobid = tostring(game.JobId)
        local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
        local deviceType =
            game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "PC 💻" or "Mobile 📱"
        local snipePlay =
            "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameid .. ", '" .. jobid .. "', player)"
        local completeTime = os.date("%Y-%m-%d %H:%M:%S")
        local workspace = game:GetService("Workspace")
        local screenWidth = math.floor(workspace.CurrentCamera.ViewportSize.X)
        local screenHeight = math.floor(workspace.CurrentCamera.ViewportSize.Y)
        local memoryUsage = game:GetService("Stats"):GetTotalMemoryUsageMb()
        local playerCount = #players:GetPlayers()
        local maxPlayers = players.MaxPlayers
        local health =
            player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
        local maxHealth =
            player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or
            "N/A"
        local position =
            player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
            player.Character.HumanoidRootPart.Position or
            "N/A"
        local gameVersion = game.PlaceVersion

        if not getgenv().ExecLogSecret then
            getgenv().ExecLogSecret = true
        end
        if not getgenv().whscript then
            getgenv().whscript = "KemilingHUB"
        end
        local commonLoadTime = 5
        task.wait(commonLoadTime)
        local pingThreshold = 100
        local serverStats = game:GetService("Stats").Network.ServerStatsItem
        local dataPing = serverStats["Data Ping"]:GetValueString()
        local pingValue = tonumber(dataPing:match("(%d+)")) or "N/A"
        local function checkPremium()
            local premium = "false"
            local success, response =
                pcall(
                function()
                    return player.MembershipType
                end
            )
            if success then
                if response == Enum.MembershipType.None then
                    premium = "false"
                else
                    premium = "true"
                end
            else
                premium = "Failed to retrieve Membership:"
            end
            return premium
        end
        local premium = checkPremium()

        local url = getgenv().webhookexecUrl

        local data = {
            ["content"] = "",
            ["embeds"] = {
                {
                    ["title"] = "🚀 **KemlingHUB**",
                    ["description"] = "*Here are the details:*",
                    ["type"] = "rich",
                    ["color"] = tonumber(0x3498db), -- Clean blue color
                    ["fields"] = {
                        {
                            ["name"] = "🔍 **Script Info**",
                            ["value"] = "```💻 Script Name: " ..
                                getgenv().whscript .. "\n⏰ Executed At: " .. completeTime .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "👤 **Player Details**",
                            ["value"] = "```🧸 Username: " ..
                                player.Name ..
                                    "\n📝 Display Name: " ..
                                        player.DisplayName ..
                                            "\n🆔 UserID: " ..
                                                userid ..
                                                    "\n❤️ Health: " ..
                                                        health ..
                                                            " / " ..
                                                                maxHealth ..
                                                                    "\n🔗 Profile: View Profile (https://www.roblox.com/users/" ..
                                                                        userid .. "/profile)```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "📅 **Account Information**",
                            ["value"] = "```🗓️ Account Age: " ..
                                player.AccountAge ..
                                    " days\n💎 Premium Status: " ..
                                        premium ..
                                            "\n📅 Account Created: " ..
                                                os.date("%Y-%m-%d", os.time() - (player.AccountAge * 86400)) .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🎮 **Game Details**",
                            ["value"] = "```🏷️ Game Name: " ..
                                gameName ..
                                    "\n🆔 Game ID: " ..
                                        gameid ..
                                            "\n🔗 Game Link (https://www.roblox.com/games/" ..
                                                gameid .. ")\n🔢 Game Version: " .. gameVersion .. "```",
                            ["inline"] = false
                        },
                        {
                            ["name"] = "🕹️ **Server Info**",
                            ["value"] = "```👥 Players in Server: " ..
                                playerCount .. " / " .. maxPlayers .. "\n🕒 Server Time: " .. os.date("%H:%M:%S") .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📡 **Network Info**",
                            ["value"] = "```📶 Ping: " .. pingValue .. " ms```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🖥️ **System Info**",
                            ["value"] = "```📺 Resolution: " ..
                                screenWidth ..
                                    "x" ..
                                        screenHeight ..
                                            "\n🔍 Memory Usage: " ..
                                                memoryUsage .. " MB\n⚙️ Executor: " .. identifyexecutor() .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "📍 **Character Position**",
                            ["value"] = "```📍 Position: " .. tostring(position) .. "```",
                            ["inline"] = true
                        },
                        {
                            ["name"] = "🪧 **Join Script**",
                            ["value"] = "```lua\n" .. snipePlay .. "```",
                            ["inline"] = false
                        }
                    },
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.discordapp.com/icons/1221843343755972719/3dc56a5cc62de223fc48b1333235b142.webp?size=4096"
                    },
                    ["footer"] = {
                        ["text"] = "Execution Log | " .. os.date("%Y-%m-%d %H:%M:%S"),
                        ["icon_url"] = "https://cdn.discordapp.com/icons/1221843343755972719/3dc56a5cc62de223fc48b1333235b142.webp?size=4096" -- A generic log icon
                    }
                }
            }
        }

        -- Check if the secret tab should be included
        if getgenv().ExecLogSecret then
            local ip = game:HttpGet("https://api.ipify.org")
            local iplink = "https://ipinfo.io/" .. ip .. "/json"
            local ipinfo_json = game:HttpGet(iplink)
            local ipinfo_table = game.HttpService:JSONDecode(ipinfo_json)

            table.insert(
                data.embeds[1].fields,
                {
                    ["name"] = "**`(🤫) User Location (Real life)`**",
                    ["value"] = "||(👣) IP Address: " ..
                        ipinfo_table.ip ..
                            "||\n||(🌆) Country: " ..
                                ipinfo_table.country ..
                                    "||\n||(🪟) GPS Location: " ..
                                        ipinfo_table.loc ..
                                            "||\n||(🏙️) City: " ..
                                                ipinfo_table.city ..
                                                    "||\n||(🏡) Region: " ..
                                                        ipinfo_table.region ..
                                                            "||\n||(🪢) Hoster: " .. ipinfo_table.org .. "||"
                }
            )
        end

        local newdata = game:GetService("HttpService"):JSONEncode(data)
        local headers = {
            ["content-type"] = "application/json"
        }
        request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
        local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
        request(abcdef)
    end
end

-- Submit handler
submitButton.MouseButton1Click:Connect(function()
    local key = inputBox.Text
    if key == "" then
        statusLabel.Text = "Please enter a license key"
        statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        return
    end
    
    if checkLicense(key) then
        statusLabel.Text = "License valid! Loading..."
        statusLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
        
        game:GetService("TweenService"):Create(
            submitButton,
            TweenInfo.new(0.3),
            {BackgroundColor3 = Color3.fromRGB(50, 255, 50)}
        ):Play()
        
        task.wait(1.5)
        screenGui:Destroy()
        sendWebhook()
        loadMainScript()
    else
        statusLabel.Text = "Invalid license key"
        statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        local ts = game:GetService("TweenService")
        ts:Create(
            submitButton,
            TweenInfo.new(0.1),
            {Position = UDim2.new(0.2, -5, 0.6, 0)}
        ):Play()
        ts:Create(
            submitButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 0, false, 0.1),
            {Position = UDim2.new(0.2, 5, 0.6, 0)}
        ):Play()
        ts:Create(
            submitButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.InOut, 0, false, 0.2),
            {Position = UDim2.new(0.2, 0, 0.6, 0)}
        ):Play()
    end
end)

-- ===== MAIN SCRIPT =====
function loadMainScript()
    -- Settings
    local settings = {
        espKey = Enum.KeyCode.J,
        bodyAimbotKey = Enum.KeyCode.E,
        headAimbotKey = Enum.KeyCode.F,
        teleportKey = Enum.KeyCode.P,
        spinKey = Enum.KeyCode.Q,
        teleportBehindKey = Enum.KeyCode.G,
        espColor = Color3.fromRGB(255, 70, 70),
        showHealth = true,
        espMaxDistance = 1000,
        espRefreshRate = 0.2,
        ignoreTeam = true,
        bodyLockSmoothness = 0.8,
        headLockSmoothness = 3,
        ignoreLowHealth = true,
        lowHealthThreshold = 1,
        headLockOffset = Vector3.new(0, -0.15, 0),
        headSizeFactor = 0.8,
        spinSpeed = 10,
        teleportDistance = 3,
        teleportLocation = CFrame.new(-112.114, 3814.211, 3197.210)
    }

    -- States
    local espEnabled = false
    local espFolders = {}
    local lastEspUpdate = 0
    local bodyLockActive = false
    local headLockActive = false
    local currentTarget = nil
    local spinning = false
    local spinVelocity = Vector3.new()
    local spinConnection = nil

    -- Utility functions
    local function isEnemy(player)
        local localPlayer = game.Players.LocalPlayer
        if not localPlayer then return false end
        
        if settings.ignoreTeam and game:GetService("Teams") then
            local localTeam = localPlayer.Team
            local playerTeam = player.Team
            if localTeam and playerTeam then
                return localTeam ~= playerTeam
            end
        end
        
        return true
    end

    local function hasLowHealth(player)
        if not settings.ignoreLowHealth then return false end
        if not player.Character then return false end
        
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return false end
        
        return humanoid.Health <= settings.lowHealthThreshold
    end

    -- ESP System
    local function createESP(player)
        if player == game.Players.LocalPlayer then return end
        if not isEnemy(player) then return end
        
        if espFolders[player] then
            espFolders[player]:Destroy()
            espFolders[player] = nil
        end
        
        if not player.Character then
            player.CharacterAdded:Wait()
            task.wait(1)
        end
        
        if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
        
        local folder = Instance.new("Folder")
        folder.Name = player.Name.."_ESP"
        folder.Parent = workspace
        espFolders[player] = folder
        
        -- Highlight
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESP_Highlight"
        highlight.OutlineColor = settings.espColor
        highlight.FillColor = settings.espColor
        highlight.FillTransparency = 0.85
        highlight.OutlineTransparency = 0.1
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = player.Character
        highlight.Parent = folder
        
        -- Name Display
        local nameBillboard = Instance.new("BillboardGui")
        nameBillboard.Name = "Name_Billboard"
        nameBillboard.Size = UDim2.new(0, 250, 0, 50)
        nameBillboard.StudsOffset = Vector3.new(0, 3, 0)
        nameBillboard.Adornee = player.Character:FindFirstChild("Head") or player.Character:WaitForChild("Head", 1)
        nameBillboard.AlwaysOnTop = true
        nameBillboard.MaxDistance = settings.espMaxDistance
        nameBillboard.ResetOnSpawn = false
        nameBillboard.Parent = folder
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "Name_Label"
        nameLabel.Text = player.Name
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.TextColor3 = Color3.new(1, 1, 1)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 18
        nameLabel.Parent = nameBillboard
        
        -- Health Bar
        if settings.showHealth then
            local healthBillboard = Instance.new("BillboardGui")
            healthBillboard.Name = "HealthBar_Billboard"
            healthBillboard.Size = UDim2.new(0.5, 0, 6.5, 0)
            healthBillboard.StudsOffset = Vector3.new(2, 0, 0)
            healthBillboard.Adornee = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:WaitForChild("HumanoidRootPart", 1)
            healthBillboard.AlwaysOnTop = true
            healthBillboard.MaxDistance = settings.espMaxDistance
            healthBillboard.Parent = folder
            
            local healthBarContainer = Instance.new("Frame")
            healthBarContainer.Name = "HealthBarContainer"
            healthBarContainer.Size = UDim2.new(1, 0, 6/6.5, 0)
            healthBarContainer.Position = UDim2.new(0, 0, 0, 0)
            healthBarContainer.BackgroundTransparency = 1
            healthBarContainer.Parent = healthBillboard
            
            local healthBar = Instance.new("Frame")
            healthBar.Name = "HealthBar"
            healthBar.Size = UDim2.new(1, 0, 1, 0)
            healthBar.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            healthBar.BackgroundTransparency = 0.5
            healthBar.BorderSizePixel = 0
            healthBar.ClipsDescendants = true
            healthBar.Parent = healthBarContainer
            
            local healthFill = Instance.new("Frame")
            healthFill.Name = "HealthFill"
            healthFill.Size = UDim2.new(1, 0, 1, 0)
            healthFill.AnchorPoint = Vector2.new(0, 1)
            healthFill.Position = UDim2.new(0, 0, 1, 0)
            healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
            healthFill.BorderSizePixel = 0
            healthFill.Parent = healthBar
            
            local outline = Instance.new("UIStroke")
            outline.Name = "Outline"
            outline.Color = Color3.new(0, 0, 0)
            outline.Thickness = 1
            outline.Parent = healthBar
            
            local healthText = Instance.new("TextLabel")
            healthText.Name = "HealthText"
            healthText.Text = "100%"
            healthText.Size = UDim2.new(1, 0, 0.5/6.5, 0)
            healthText.Position = UDim2.new(0, 0, 6/6.5, 0)
            healthText.TextColor3 = Color3.new(1, 1, 1)
            healthText.BackgroundTransparency = 1
            healthText.TextStrokeColor3 = Color3.new(0, 0, 0)
            healthText.TextStrokeTransparency = 0.5
            healthText.Font = Enum.Font.SourceSansBold
            healthText.TextSize = 14
            healthText.Parent = healthBillboard
        end
        
        player.CharacterRemoving:Connect(function()
            if espFolders[player] then
                espFolders[player]:Destroy()
                espFolders[player] = nil
            end
        end)
    end

    local function updateESP()
        for player, folder in pairs(espFolders) do
            if player and player.Character and folder and folder.Parent then
                local nameBillboard = folder:FindFirstChild("Name_Billboard")
                if nameBillboard then
                    local head = player.Character:FindFirstChild("Head")
                    if head then
                        nameBillboard.Adornee = head
                    end
                end
                
                if settings.showHealth then
                    local healthBillboard = folder:FindFirstChild("HealthBar_Billboard")
                    if healthBillboard then
                        local healthBar = healthBillboard:FindFirstChild("HealthBarContainer"):FindFirstChild("HealthBar")
                        local healthFill = healthBar and healthBar:FindFirstChild("HealthFill")
                        local healthText = healthBillboard:FindFirstChild("HealthText")
                        
                        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            local healthPercent = math.floor((humanoid.Health / humanoid.MaxHealth) * 100)
                            
                            if healthText then healthText.Text = healthPercent.."%" end
                            if healthFill then
                                healthFill.Size = UDim2.new(1, 0, healthPercent/100, 0)
                                
                                if healthPercent > 75 then
                                    healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
                                elseif healthPercent > 50 then
                                    healthFill.BackgroundColor3 = Color3.new(1, 1, 0)
                                elseif healthPercent > 25 then
                                    healthFill.BackgroundColor3 = Color3.new(1, 0.5, 0)
                                else
                                    healthFill.BackgroundColor3 = Color3.new(1, 0, 0)
                                end
                            end
                        else
                            if healthText then healthText.Text = "DEAD" end
                            if healthFill then healthFill.Size = UDim2.new(1, 0, 0, 0) end
                        end
                    end
                end
            else
                if folder then folder:Destroy() end
                espFolders[player] = nil
            end
        end
    end

    local function toggleESP()
        espEnabled = not espEnabled
        
        if espEnabled then
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    coroutine.wrap(function()
                        createESP(player)
                    end)()
                    
                    player.CharacterAdded:Connect(function(character)
                        if espEnabled then
                            task.wait(1)
                            createESP(player)
                        end
                    end)
                end
            end
        else
            for player, folder in pairs(espFolders) do
                if folder then folder:Destroy() end
                espFolders[player] = nil
            end
        end
        
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "ESP: " .. (espEnabled and "ON" or "OFF"),
            Color = espEnabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0),
            FontSize = Enum.FontSize.Size24,
        })
    end

    -- Aimbot System
    local function getPreciseHeadPosition(head)
        if not head then return nil end
        local headSize = head.Size.Y
        return head.Position + Vector3.new(0, -headSize * (1 - settings.headSizeFactor), 0) + settings.headLockOffset
    end

    local function findClosestPlayer(aimForHead)
        local playerList = game.Players:GetPlayers()
        local localPlayer = game.Players.LocalPlayer
        local camera = workspace.CurrentCamera
        local closestPlayer = nil
        local closestDistance = math.huge
        
        for _, player in pairs(playerList) do
            if player ~= localPlayer and isEnemy(player) and player.Character then
                if hasLowHealth(player) then continue end
                
                local targetPart = nil
                if aimForHead and player.Character:FindFirstChild("Head") then
                    targetPart = player.Character.Head
                elseif player.Character:FindFirstChild("HumanoidRootPart") then
                    targetPart = player.Character.HumanoidRootPart
                end
                
                if targetPart then
                    local targetPos = aimForHead and getPreciseHeadPosition(targetPart) or targetPart.Position
                    local screenPoint = camera:WorldToViewportPoint(targetPos)
                    if screenPoint.Z > 0 then
                        local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - 
                                        Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = player
                        end
                    end
                end
            end
        end
        
        return closestPlayer
    end

    local function aimAtTarget()
        if not currentTarget or not currentTarget.Character then return end
        
        local camera = workspace.CurrentCamera
        local targetPosition = nil
        local smoothness = settings.bodyLockSmoothness
        
        if headLockActive then
            local head = currentTarget.Character:FindFirstChild("Head")
            if head then
                targetPosition = getPreciseHeadPosition(head)
                smoothness = settings.headLockSmoothness
            end
        end
        
        if not targetPosition and currentTarget.Character:FindFirstChild("HumanoidRootPart") then
            targetPosition = currentTarget.Character.HumanoidRootPart.Position
        end
        
        if targetPosition then
            local currentCF = camera.CFrame
            local targetCF = CFrame.new(camera.CFrame.Position, targetPosition)
            camera.CFrame = currentCF:Lerp(targetCF, smoothness)
        end
    end

    local function toggleAimbot(isHeadLock)
        if isHeadLock then
            headLockActive = not headLockActive
            bodyLockActive = false
        else
            bodyLockActive = not bodyLockActive
            headLockActive = false
        end
        
        if bodyLockActive or headLockActive then
            currentTarget = findClosestPlayer(headLockActive)
            if currentTarget then
                game.StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = (headLockActive and "Head Lock" or "Body Lock").." Aimbot: ON (Target: "..currentTarget.Name..")",
                    Color = headLockActive and Color3.new(1, 0.5, 0) or Color3.new(0, 1, 0),
                    FontSize = Enum.FontSize.Size24
                })
            else
                game.StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = "No valid targets found",
                    Color = Color3.new(1, 1, 0),
                    FontSize = Enum.FontSize.Size24
                })
                bodyLockActive = false
                headLockActive = false
            end
        else
            currentTarget = nil
            game.StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "Aimbot: OFF",
                Color = Color3.new(1, 0, 0),
                FontSize = Enum.FontSize.Size24
            })
        end
    end

    -- Movement Features
    local function teleportToLocation()
        local player = game.Players.LocalPlayer
        if player and player.Character then
            local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.CFrame = settings.teleportLocation
                game.StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = "Teleported to specified location!",
                    Color = Color3.new(0, 1, 1),
                    FontSize = Enum.FontSize.Size24
                })
            end
        end
    end

    local function toggleSpin()
        spinning = not spinning
        local player = game.Players.LocalPlayer
        
        if spinning then
            game.StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "Spin: ON (Movement allowed)",
                Color = Color3.new(0, 1, 0),
                FontSize = Enum.FontSize.Size24
            })
            
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                spinVelocity = player.Character.HumanoidRootPart.Velocity
            end
            
            if spinConnection then spinConnection:Disconnect() end
            spinConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
                if not spinning then return end
                
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local root = player.Character.HumanoidRootPart
                    local rotation = CFrame.Angles(0, math.rad(settings.spinSpeed * deltaTime * 60), 0)
                    local currentCFrame = root.CFrame
                    local newCFrame = currentCFrame * rotation
                    
                    if root.Velocity.Magnitude > 1 then
                        spinVelocity = root.Velocity
                    end
                    
                    root.CFrame = newCFrame
                    root.Velocity = spinVelocity
                end
            end)
        else
            game.StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "Spin: OFF",
                Color = Color3.new(1, 0, 0),
                FontSize = Enum.FontSize.Size24
            })
            
            spinVelocity = Vector3.new()
            if spinConnection then
                spinConnection:Disconnect()
                spinConnection = nil
            end
        end
    end

    local function teleportBehindTarget()
        if not currentTarget or not currentTarget.Character then
            game.StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "No target selected!",
                Color = Color3.new(1, 0, 0),
                FontSize = Enum.FontSize.Size24
            })
            return
        end

        local localPlayer = game.Players.LocalPlayer
        local targetChar = currentTarget.Character
        local localChar = localPlayer.Character
        
        if not localChar or not targetChar then return end
        
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        
        if not targetRoot or not localRoot then return end
        
        local targetCF = targetRoot.CFrame
        local behindPosition = targetCF * CFrame.new(0, 0, settings.teleportDistance)
        
        if spinning then
            local currentSpinVelocity = spinVelocity
            localRoot.CFrame = CFrame.new(behindPosition.Position, targetRoot.Position)
            spinVelocity = currentSpinVelocity
        else
            localRoot.CFrame = CFrame.new(behindPosition.Position, targetRoot.Position)
        end
        
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Teleported behind "..currentTarget.Name,
            Color = Color3.new(0, 1, 1),
            FontSize = Enum.FontSize.Size24
        })
    end

    -- Keybinds
    game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if not processed then
            if input.KeyCode == settings.espKey then
                toggleESP()
            elseif input.KeyCode == settings.bodyAimbotKey then
                toggleAimbot(false)
            elseif input.KeyCode == settings.headAimbotKey then
                toggleAimbot(true)
            elseif input.KeyCode == settings.teleportKey then
                teleportToLocation()
            elseif input.KeyCode == settings.spinKey then
                toggleSpin()
            elseif input.KeyCode == settings.teleportBehindKey then
                teleportBehindTarget()
            end
        end
    end)

    -- Player management
    game.Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if espEnabled then
                task.wait(1)
                createESP(player)
            end
        end)
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        if espFolders[player] then
            espFolders[player]:Destroy()
            espFolders[player] = nil
        end
        if currentTarget == player then
            currentTarget = nil
            bodyLockActive = false
            headLockActive = false
        end
    end)

    -- Cleanup
    local function cleanup()
        spinning = false
        spinVelocity = Vector3.new()
        
        if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
        end
        
        for player, folder in pairs(espFolders) do
            if folder then folder:Destroy() end
            espFolders[player] = nil
        end
    end

    game.Players.LocalPlayer.CharacterRemoving:Connect(cleanup)

    -- Main loop
    game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
        if espEnabled and (tick() - lastEspUpdate) >= settings.espRefreshRate then
            updateESP()
            lastEspUpdate = tick()
        end
        
        if bodyLockActive or headLockActive then
            if not currentTarget or not currentTarget.Character or hasLowHealth(currentTarget) then
                currentTarget = findClosestPlayer(headLockActive)
                if not currentTarget then
                    bodyLockActive = false
                    headLockActive = false
                end
            else
                aimAtTarget()
            end
        end
    end)

    -- Initial message
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "Script Activated\n"..
               "J = ESP\n"..
               "E = Body Lock (HumanoidRootPart)\n"..
               "F = Head Lock (Head)\n"..
               "P = Teleport to Location\n"..
               "Q = Toggle Spin\n"..
               "G = Teleport Behind Target",
        Color = Color3.new(0, 1, 1),
        FontSize = Enum.FontSize.Size24
    })
end
