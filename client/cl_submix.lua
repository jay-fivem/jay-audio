local Submix = {}
local Effects = {
    ["megaphone"] = {
        [`default`] = 1,
        [`freq_low`] = 1250.0,
        [`freq_hi`] = 8500.0,
    },
    ["microphone"] = {
        [`default`] = 1,
        [`fudge`] = 0.5,
    },
    ["carmicrophone"] = {
        [`default`] = 1,
        [`freq_low`] = 1250.0,
        [`freq_hi`] = 8500.0,
        [`fudge`] = 0.5,
        [`rm_mix`] = 19.0,
    },
}

local effectFilter = {}

RegisterNetEvent("jay-audio:client:playerJoined", function(newMix)
    Submix = newMix
end)

CreateThread(function()
    for effect, mix in pairs(Effects) do
        effectFilter[effect] = CreateAudioSubmix(effect)
        SetAudioSubmixEffectRadioFx(effectFilter[effect], 0)
        for hash, value in pairs(mix) do
            SetAudioSubmixEffectParamInt(effectFilter[effect], 0, hash, data)
        end
        AddAudioSubmixOutput(effectFilter[effect], 0)
    end

    if Submix and #Submix > 0 then
        for source, effect in pairs(Submix) do
            MumbleSetSubmixForServerId(source, effectFilter[effect])
        end
    end
end)

RegisterNetEvent('jay-audio:client:updateSubmix', function(state, source, effect)
    if state then
        MumbleSetSubmixForServerId(source, effectFilter[effect])
    else
        MumbleSetSubmixForServerId(source, -1)
    end
end)