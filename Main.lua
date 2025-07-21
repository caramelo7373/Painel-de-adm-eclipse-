-- 🧠 Carregar a Eclipse Library
local Eclipse = loadstring(game:HttpGet("https://raw.githubusercontent.com/caramelo7373/Eclipse-libary/main/Main.lua", true))()

-- 🪟 Criar Janela
local Window = Eclipse:CreateWindow({
    Title = "Painel Administrativo",
    Size = UDim2.new(0, 500, 0, 400),
    MainColor = Color3.fromRGB(98, 0, 238),
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    Animations = true
})

-- 👑 Lista de administradores
local Admins = {
    ["caramelo7373"] = true,
    ["IceMael17"] = true,
    -- Adicione outros nomes aqui
}

-- 👮 Identifica se é admin
local LocalPlayer = game.Players.LocalPlayer
if not Admins[LocalPlayer.Name] then
    Window:Notify({
        Title = "Acesso Negado",
        Content = "Você não tem permissão para acessar o Painel de Admin.",
        Duration = 5
    })
    return
end

-- 🧑‍⚖️ Aplica tag de "Moderador do Eclipse"
local function setAsModerator(player)
    if not player or not player.Character then return end
    local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        humanoid.DisplayName = player.DisplayName .. "\nModerador do Eclipse"
    end
end

-- Aplica automaticamente aos admins
game.Players.PlayerAdded:Connect(function(player)
    if Admins[player.Name] then
        player.CharacterAdded:Connect(function()
            wait(1)
            setAsModerator(player)
        end)
        if player.Character then
            setAsModerator(player)
        end
    end
end)

-- 🧰 Aba de comandos
local AdminTab = Window:CreateTab("Moderação")

-- 💥 Kick
AdminTab:AddTextBox({
    Name = "Kick Jogador",
    Default = "",
    Callback = function(nome)
        local plr = game.Players:FindFirstChild(nome)
        if plr then
            plr:Kick("Você foi removido pelo Painel de Admin do Eclipse Hub.")
        else
            Window:Notify({Title="Erro", Content="Jogador não encontrado.", Duration=4})
        end
    end
})

-- 💤 Freeze
AdminTab:AddTextBox({
    Name = "Congelar Jogador",
    Default = "",
    Callback = function(nome)
        local plr = game.Players:FindFirstChild(nome)
        if plr and plr.Character then
            local humanoidRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRoot then
                humanoidRoot.Anchored = true
                Window:Notify({Title="Congelado", Content=nome.." foi congelado.", Duration=4})
            end
        end
    end
})

-- 🚀 Fling
AdminTab:AddTextBox({
    Name = "Fling Jogador",
    Default = "",
    Callback = function(nome)
        local plr = game.Players:FindFirstChild(nome)
        if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            hrp.Velocity = Vector3.new(0, 150, 0)
            hrp.RotVelocity = Vector3.new(999999, 999999, 999999)
        end
    end
})

-- ✅ Notificação de carregamento
Window:Notify({
    Title = "Painel de Admin",
    Content = "bem vindo moderador",
    Duration = 5
})
