local lugar = {x=453.8625, y=-1017.06, z=28.844}
local lugar2 = {x=462.8166, y=-1019.99, z=28.744}
local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
local isPolice = false
local job = nil

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('esx_policegarage:getJob')
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	TriggerServerEvent('esx_policegarage:getJob')
end)

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

Keys = {
    ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
    ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
    ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 116,  ["]"]   = 40,   ["ENTER"]   = 18,
    ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
    ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
    ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70,
    ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
    ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
    ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}


Citizen.CreateThread(function()
	while true do
        local Player = PlayerPedId()
        local PPos = GetEntityCoords(Player)
		Citizen.Wait(0)
        if isPolice == false then
		if #(PPos - vector3(453.8625, -1017.06, 27.744)) < 5 then
            DrawMarker(2, lugar.x, lugar.y, lugar.z - 1 , 0, 0, 0, 0, 0, 0, 0.75, 1.00, 0.6001,52,155,0, 200, 0, 0, 0, 0)
            DrawText3D(453.8625, -1017.06, 27.744 +1, "Pulsa ~y~[E]~w~ para abrir el Garaje")
			if IsControlJustPressed(1, Keys['E']) and job == 'police' then
				OpenMenu()
                elseif IsControlJustPressed(1, Keys['E']) and not job == 'police' then
                end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
        local Player = PlayerPedId()
        local PPos = GetEntityCoords(Player)
		Citizen.Wait(0)
        if isPolice == false then
		if #(PPos - vector3(462.8166, -1019.99, 27.444)) < 5 then
            DrawMarker(2, lugar2.x, lugar2.y, lugar2.z - 1 , 0, 0, 0, 0, 0, 0, 0.75, 1.00, 0.6001,52,155,0, 200, 0, 0, 0, 0)
            DrawText3D(462.8166, -1019.99, 27.444 +1, "Pulsa ~y~[E]~w~ para guardar el Vehículo")
			if IsControlJustPressed(1, Keys['E']) and job == 'police' then
                if IsPedInAnyVehicle(Player, false) then
                    DeleteVehicle(GetVehiclePedIsIn(Player))
                end
                elseif IsControlJustPressed(1, Keys['E']) and not job == 'police' then
                end
			end
		end
	end
end)

function DrawText3D(x,y,z, text) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.5*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function OpenMenu()
    local Player = PlayerPedId()
    local vehicles = {
        {label = 'Moto Poli', value = 'policeb'},
        {label = 'Coche Poli 1', value = 'coche1'},
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage',{
        title = 'Coches Policia',
        align = 'bottom-right',
        elements = vehicles
    },
    function(data, menu)
        if data.current.value == 'policeb' then
            ESX.Game.SpawnVehicle('policeb', vector3(450.1105, -1017.53, 28.522), 79.877, function(veh)
                TaskWarpPedIntoVehicle(Player, veh, -1)
                exports['LegacyFuel']:SetFuel(veh, 100)
            end)
            menu.close()
        elseif data.current.value == 'coche1' then
            ESX.Game.SpawnVehicle('police3', vector3(450.1105, -1017.53, 28.522), 79.877, function(veh)
                TaskWarpPedIntoVehicle(Player, veh, -1)
                exports['LegacyFuel']:SetFuel(veh, 100)
            end)
            menu.close()
        end
    end,
    function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('esx_policegarage:setJob')
AddEventHandler('esx_policegarage:setJob',function(jobu)
	job = jobu
end)