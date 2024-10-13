alert = nil
alertId = 0
function ShowDialog(title, description)
    if alert then return end
    id = alertId + 1
    alertId = id
    alert = promise.new()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'setDialog',
        data = {
            title = title, 
            description = description
        }
    })
    return Citizen.Await(alert)
end

RegisterNUICallback('dialog:close', function(data, cb)
    cb(1)
    SetNuiFocus(false, false)
    local promise = alert
    alert = nil
    promise:resolve(data.options)
end)



RegisterCommand("showDialog", function ()
    local result = ShowDialog("Dialog", "Ceci est un script qui permet de créer des dialogues super rapidement en utilisant ~r~REACT~s~ ET ~b~TAILWIND")
    print("Result", result)
end)
exports("ShowDialog", ShowDialog)