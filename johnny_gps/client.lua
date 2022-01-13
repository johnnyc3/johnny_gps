-- GPS JOHNNNY
ESX                           = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(0)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)



RegisterNetEvent("esx_policejobgps:gpsoff")
AddEventHandler("esx_policejobgps:gpsoff", function(source)
    if ESX.GetPlayerData().job.name == 'police' then
        if GPS == 1 then
    ESX.ShowNotification('Funkcjonariusz wyłączył gps!')

        end
    end
end)





RegisterNetEvent("esx_policejobgps:wlacz_gps")
AddEventHandler("esx_policejobgps:wlacz_gps", function(source,xPlayer)

ESX.TriggerServerCallback('esx_policejobgps:checkid', function(id)
	if source == id then
	ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'menuname', -- Replace the menu name
	{
	  title    = ('GPS'),
	  align = 'top-left', -- Menu position
	  elements = { -- Contains menu elements=
		{label = ('Wlacz GPS'),     value = 'on'},
		{label = ('Wylacz GPS'),      value = 'off'}
	  }
	},
	function(data, menu) -- This part contains the code that executes when you press enter
      if data.current.value == 'on' then
		ESX.UI.Menu.CloseAll()
		GPS = 1
	  end
	  if data.current.value == 'off' then
		if GPS == 1 then
		ESX.UI.Menu.CloseAll()

		Officer = GetEntityCoords(PlayerPedId())

		TriggerServerEvent("esx_policejobgps:wyloczonogps",Officer)
		GPS = 0
		end
	  end    
	end,
	function(data, menu) -- This part contains the code  that executes when the return key is pressed.
		menu.close() -- Close the menu
	end
  )


end
end) -- koniec checkid


end)



RegisterNetEvent("esx_policejobgps:alertgpsoff")
AddEventHandler("esx_policejobgps:alertgpsoff", function(source,Officer)

	ESX.ShowNotification('~r~FUNKCJONARIUSZ WYLACZYL GPS!')
	PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
	local blip3 = AddBlipForCoord(Officer.x,Officer.y,Officer.z)
	SetBlipSprite(blip3, 161)
	SetBlipDisplay(blip3, 4)
	SetBlipScale(blip3, 1.0)
	EndTextCommandSetBlipName(blip3)
	SetBlipAsShortRange(blip3, true)
	BeginTextCommandSetBlipName("STRING") 
	AddTextComponentString('~r~#Ostatnia Lokalizacja Funkcjonariusza')
	EndTextCommandSetBlipName(blip3)


	Citizen.Wait(60000)
	RemoveBlip(blip3)




end)






	Citizen.CreateThread(function()
		while true do
			-- loop tzw petla
			Wait(350)


if GPS == 1 then
	ESX.TriggerServerCallback('esx_policejobgps:checkjob', function(ils1)
		if ils1 == true then




				local Officer = {}
				Officer.Player = PlayerId()
				Officer.Grade = ESX.GetPlayerData().job.grade_label
				Officer.Ped = PlayerPedId()
				Officer.Coords = GetEntityCoords(Officer.Ped)
				Officer.Nickname = GetPlayerName()
				
				Officer.Location = {} 
				TriggerServerEvent("esx_policejobgps:request", Officer,ID)
		else
			ESX.ShowNotification('Nie jestes w ~b~LSPD!')
		end
	end)


	end


end


end)
--koniec pentli



RegisterNetEvent("esx_policejobgps:alert")
AddEventHandler("esx_policejobgps:alert", function(source, Officer)
	if GPS == 1 then
	if ESX.GetPlayerData().job.name == 'police' then
		Citizen.CreateThread(function()

			local blip2 = AddBlipForCoord(Officer.Coords.x,Officer.Coords.y,Officer.Coords.z)
			SetBlipSprite(blip2, 1)
			SetBlipDisplay(blip2, 4)
			SetBlipColour(blip2,3)
			SetBlipScale(blip2, 1.3)
			EndTextCommandSetBlipName(blip2)
			SetBlipAsShortRange(blip2, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("#[" .. Officer.Grade .. ']' .. Officer.Nickname ..'LSPD')
			EndTextCommandSetBlipName(blip2)


			Citizen.Wait(350)
			RemoveBlip(blip2)
			blip2 = nil
		end)
	end
end
end)