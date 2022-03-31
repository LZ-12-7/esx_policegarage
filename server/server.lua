ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
ESX = obj 
end)

RegisterServerEvent('esx_policegarage:getJob') -- Lo del trabajo
AddEventHandler('esx_policegarage:getJob', function()
	local source = source -- No lo quites
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayers[i] == source then
			TriggerClientEvent('esx_policegarage:setJob',xPlayers[i],xPlayer.job.name)
		end
	end
end)