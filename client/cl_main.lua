local function EnableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
    SetAudioSubmixEffectParamInt(0, 0, `default`, 1)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_low`, 1250.0)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_hi`, 8500.0)
    SetAudioSubmixEffectParamFloat(0, 0, `fudge`, 0.5)
    SetAudioSubmixEffectParamFloat(0, 0, `rm_mix`, 19.0)
end exports("EnableSubmix", EnableSubmix)

local function DisableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
end exports("DisableSubmix", DisableSubmix)

local inWater = false
CreateThread(function()
    while true do
        Wait(100)
        ped = PlayerPedId()
        if IsPedSwimmingUnderWater(ped) then
            if not inWater then
                EnableSubmix()
                inWater = true
            end
        else
            if inWater then 
                DisableSubmix() 
                inWater = false 
            end
        end
    end
end)