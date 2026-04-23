EnablePrimaryMouseButtonEvents(true)

-- ================= CONFIGURAÇÕES =================
local EnableRCS       = true          -- Ativar/desativar o recoil control (true = ligado)
local RequireToggle   = true          -- Se true, precisa do toggle ligado
local ToggleKey       = "CapsLock"    -- Tecla de toggle: "CapsLock", "NumLock" ou "ScrollLock"
local RecoilMode      = "Medium"      -- Opções: "Low", "Medium", "High", "Ultra", "Custom"

local CustomStrength  = 8             -- Valor usado apenas se RecoilMode = "Custom"
local Delay           = 7             -- Delay em ms (7 é bom para maioria dos jogos, não mexa se não souber)

-- Tabela de presets (mais fácil de adicionar novos modos)
local Presets = {
    Low     = 3,
    Medium  = 6,
    High    = 9,
    Ultra   = 13,
    Custom  = CustomStrength
}

-- Define a força vertical conforme o modo escolhido
local VerticalStrength = Presets[RecoilMode] or Presets.Medium
local HorizontalStrength = 0   -- Mude para valor positivo/negativo se quiser compensação horizontal

-- ================= FUNÇÃO PRINCIPAL =================
function OnEvent(event, arg)
    if not EnableRCS then return end

    -- Verifica se precisa de toggle e se está ativado
    if RequireToggle and not IsKeyLockOn(ToggleKey) then
        return
    end

    -- Ativa apenas quando estiver mirando (botão direito pressionado)
    if IsMouseButtonPressed(3) then          -- 3 = botão direito do mouse (RMB)
        while IsMouseButtonPressed(3) do
            if IsMouseButtonPressed(1) then  -- 1 = botão esquerdo (LMB - atirando)
                while IsMouseButtonPressed(1) do
                    MoveMouseRelative(HorizontalStrength, VerticalStrength)
                    Sleep(Delay)
                end
            end
            Sleep(10)  -- Pequeno delay para não sobrecarregar
        end
    end
end
