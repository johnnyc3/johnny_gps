--GPS JOHNNY 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



ESX.RegisterServerCallback('esx_policejobgps:checkjob', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
 	if xPlayer.job.name == 'police' then
		cb(true)
	else
		cb(false)
	end
end)



ESX.RegisterServerCallback('esx_policejobgps:checkid', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		cb(_source)
end)




ESX.RegisterUsableItem('gps', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("esx_policejobgps:wlacz_gps", -1, source,xPlayer)


end)

RegisterServerEvent("esx_policejobgps:wyloczonogps")
AddEventHandler("esx_policejobgps:wyloczonogps", function(Officer)

	TriggerClientEvent("esx_policejobgps:alertgpsoff", -1, source,Officer)
end)



RegisterServerEvent("esx_policejobgps:request")
AddEventHandler("esx_policejobgps:request", function(Officer,ID)
	TriggerClientEvent("esx_policejobgps:alert", -1, source, Officer)
end)



-- KONIEC

