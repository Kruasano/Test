local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local animations = {
    ["1"] = "10714360343"
}

local shouldPlayAnimation = false

local function playAnimation(animationId)
    local character = LocalPlayer.Character
    if not character then return end

    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end

    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:Stop()
    end

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. animationId
    local animationTrack = humanoid:LoadAnimation(animation)

    if animationTrack then
        animationTrack.Looped = true
        animationTrack:Play()
    end
end

local function onPlayerChatted(player, message)
    if message:lower():find("arbuz") then
        shouldPlayAnimation = true
        playAnimation(animations["1"])

        
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(
            "MEOWWWW",
            "All"
        )
    end
end


for _, player in ipairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end


Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        onPlayerChatted(player, message)
    end)
end)


if LocalPlayer.Character and shouldPlayAnimation then
    playAnimation(animations["1"])
end

LocalPlayer.CharacterAdded:Connect(function(character)
    if shouldPlayAnimation then
        playAnimation(animations["1"])
    end
end)
