local Submix = {}

AddEventHandler("playerJoining", function()
    TriggerClientEvent('jay-audio:client:playerJoined', source, Submix)
end)

AddEventHandler("playerDropped", function()
    if Submix[source] then
        Submix[source] = nil
        TriggerClientEvent('jay-audio:client:updateSubmix', -1, false, source)
    end
end)

RegisterNetEvent('jay-audio:server:addSubmix', function(effect)
    Submix[source] = effect
    TriggerClientEvent('jay-audio:client:updateSubmix', -1, true, source, effect)
end)

RegisterNetEvent('jay-audio:server:removeSubmix', function()
    Submix[source] = nil
    TriggerClientEvent('jay-audio:client:updateSubmix', -1, false, source)
end)