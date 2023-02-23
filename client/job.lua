---------------------------------------------------------
--                       Config                        --
---------------------------------------------------------

Config = {

    Release1 = {

        point_frigo = vector3(-1182.87, -878.9, 13.84), -- Ce point permet de récup tout ce qu'il n'y à pas besoin de farm

        point_garage_list_vehicle = vector3(-1187.78, -874.5, 13.78),
        point_garage_ranger_vehicle = vector3(-1201.15, -876.4, 13.29),
        point_garage_spawn = vector3(-1201.15, -876.4, 13.29),
        WaitVehicle = 300000, -- Combien de temps attendre avant de pouvoir faire spawn un autre véhicule (1 secondes = 1000)

        list_vehicle = {
            {Vehi = "benson", label = "Vapid Benson"},
            {Vehi = "youga", label = "Van"},
        }

    },

    Blips_BurgerShot = vector3(-1178.7, -885.4, 13.8),

    Farm = {

        ActiveVente = true, -- (true = active / false = désactive) Permet d'activer ou de désactiver la vente au point du job

        ActiveBlip = true, -- (true = active / false = désactive) Permet de voir sur la map ou se trouve la vente, récolte etc

        -- Coordonnée 
        Recolte_Viande = vector3(-1175.09, -875.1, 14.09),
        Recolte_Poulet = vector3(-1172.5, -879.05, 14.09),
        Recolte_Poisson = vector3(-1169.9, -883.1, 14.09),
        Recolte_Pain = vector3(-1166.7, -888.8, 14.09),
        Recolte_Salade = vector3(-1164.4, -892.6, 14.09),
        Recolte_Legume = vector3(-1169.7, -895.9, 13.9),

        Transformation_Burger = vector3(-1172.3, -892.2, 13.9),

        Vente_Burger = vector3(-1177.53, -891.0, 13.78),

        Menu_Boss = vector3(-1182.9, -883.9, 13.7),

        PrixDeVente = 15, -- x1 Burger seulement

        TempsDeVente = 1500 -- En milliseconde (1000 = 1 secondes), Temps de vente entre chaque vente de burger si vente active

    },

    Marker = {

        Type = 21, -- https://docs.fivem.net/docs/game-references/markers/
        Saut = false,
        Rotation = true,
        Distance = 050.0,
        Taille = {a = 0.3, b = 0.3, c = 0.3},
        Color = {r = 198, g = 198, b = 33, a = 255},

    },

    PNJ = {

        Active = true,
        Ped_Pos = vector3(-1178.4, -891.6, 12.7),
        Ped_Heading = 304.4,
        Ped_Model = "mp_m_weed_01", -- https://docs.fivem.net/docs/game-references/ped-models/

    },

    Blip = {

        Taille = 0.8,
        Sprite = 106, -- https://docs.fivem.net/docs/game-references/blips/
        Couleur = 46, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        Label = "Burger Shot",
        Radius = false,
        Taille_Radius = 800.0,
        
    }

}

---------------------------------------------------------
--                       local                         --
---------------------------------------------------------

NishiClient = {
    StringColor = {
        RED = "~r~",
        ORANGE = "~o~",
        GREEN = "~g~",
        YELLOW = "~y~",
        BASIC = "~s~",
    },
    Arrow = {
        RIGHT = "→→",
        LEFT = "←←",
        UP = "↑↑",
        DOWN = "↓↓",
    },
    Input = {
        E = "~INPUT_CONTEXT~",
    },
}

---------------------------------------------------------
--                        COM                          --
---------------------------------------------------------

-- ZZZ

---------------------------------------------------------
--                        job                          --
---------------------------------------------------------

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

Citizen.CreateThread(function()

    while ESX.GetPlayerData().job == nil do
        
        Wait(10)

    end

    ESX.PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent("esx:playerLoaded", function(xPlayer)

    ESX.PlayerData = xPlayer

end)

RegisterNetEvent("esx:setJob", function(job)

    ESX.PlayerData.job = job

end)

---------------------------------------------------------
--                      Menu F6                        --
---------------------------------------------------------

StatusMenu = false

local main = RageUI.CreateMenu("Burger Shot", "Intéraction", 0, 50, "Nishi", "interact_banner")
main.Closed = function()
    StatusMenu = false
end

function OpenMenu()
    if StatusMenu then
        StatusMenu = true
        RageUI.Visible(main, true)
    else
        StatusMenu = true
        RageUI.Visible(main, true)
    end
    CreateThread(function()
        while StatusMenu do
            
            RageUI.IsVisible(main, function()
                
                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Annonce "..NishiClient.StringColor.GREEN.."(Ouverture)", nil, {}, true, {

                    onSelected = function()
                        TriggerServerEvent("burgershot:notif", "Le "..NishiClient.StringColor.YELLOW.."BurgerShot"..NishiClient.StringColor.BASIC.." est "..NishiClient.StringColor.GREEN.."ouvert"..NishiClient.StringColor.BASIC.." !")
                    end
                    
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Annonce "..NishiClient.StringColor.RED.."(Fermeture)", nil, {}, true, {

                    onSelected = function()
                        TriggerServerEvent("burgershot:notif", "Le "..NishiClient.StringColor.YELLOW.."BurgerShot"..NishiClient.StringColor.BASIC.." est "..NishiClient.StringColor.RED.."fermer"..NishiClient.StringColor.BASIC.." !")
                    end
                    
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Annonce "..NishiClient.StringColor.ORANGE.."(Recrutement)", nil, {}, true, {

                    onSelected = function()
                        TriggerServerEvent("burgershot:notif", "Le "..NishiClient.StringColor.YELLOW.."BurgerShot"..NishiClient.StringColor.BASIC.." "..NishiClient.StringColor.ORANGE.."recrute"..NishiClient.StringColor.BASIC.." !")
                    end
                    
                })

                RageUI.Line(235, 198, 33, 255)

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Faire une facture ", nil, {}, true, {
                    onSelected = function()
                        
                        local billing = tonumber(NHK.InputOnScreen("Montant de la facture", "", 4))

                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                        if closestPlayer == -1 or closestDistance > 3.0 then

                            ESX.ShowNotification("Personne n'est à proximité.")

                        else

                            if (billing > 10000 or billing == 0 or billing == nil) then

                                ESX.ShowNotification("Le montant est inéxacte !")

                            else
                                
                                TriggerServerEvent("esx_billing:sendBill", GetPlayerServerId(closestPlayer), "bank", "Facture Burgershot", billing)

                            end
                        
                        end

                    end
                })

                RageUI.Line(235, 198, 33, 255)
                
                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Point de récolte de Viande", nil, {}, true, {
                    onSelected = function()
                        SetNewWaypoint(Config.Farm.Recolte_Viande)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Point de récolte de Poisson", nil, {}, true, {
                    onSelected = function()
                        SetNewWaypoint(Config.Farm.Recolte_Poisson)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Point de récolte de Poulet", nil, {}, true, {
                    onSelected = function()
                        SetNewWaypoint(Config.Farm.Recolte_Poulet)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Point de récolte de Salade", nil, {}, true, {
                    onSelected = function()
                        SetNewWaypoint(Config.Farm.Recolte_Salade)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Point de récolte de Légumes", nil, {}, true, {
                    onSelected = function()
                        SetNewWaypoint(Config.Farm.Recolte_Legume)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Point de récolte de Pain", nil, {}, true, {
                    onSelected = function()
                        SetNewWaypoint(Config.Farm.Recolte_Pain)
                    end
                })

            end)

        Wait(1)
        end
    end)
end

RegisterCommand("+nhkburgershot", function()
    if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then       
        OpenMenu()
    end
end)
RegisterKeyMapping("+nhkburgershot", "~y~(~b~Nishikoto~y~)~s~ Ouvre le menu job", "keyboard", "F6")

StatusMenu2 = false

local main2 = RageUI.CreateMenu("Burger Shot", "Hôtel de vente", 0, 50, "Nishi", "interact_banner")
main2.Closed = function()
    StatusMenu2 = false
end

VentePoint = true

function OpenMenu2()
    if StatusMenu2 then
        StatusMenu2 = true
        RageUI.Visible(main2, true)
    else
        StatusMenu2 = true
        RageUI.Visible(main2, true)
    end
    CreateThread(function()
        while StatusMenu2 do
            
            RageUI.IsVisible(main2, function()

                if (VentePoint == true) then
                    
                    RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Vendre un Burger (Poisson)", nil, {RightLabel = NishiClient.StringColor.GREEN..Config.Farm.PrixDeVente.."$/u"}, true, {
                        onSelected = function()
    
                            local prix = Config.Farm.PrixDeVente

                            VentePoint = false
                            
                            Wait(1500)
    
                            TriggerServerEvent("burgershot:item:sell", "burgerfish", prix, "Burger au Poisson")
    
                            VentePoint = true

                        end
                    })

                    RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Vendre un Burger (Viande)", nil, {RightLabel = NishiClient.StringColor.GREEN..Config.Farm.PrixDeVente.."$/u"}, true, {
                        onSelected = function()
    
                            local prix = Config.Farm.PrixDeVente

                            VentePoint = false
                            
                            Wait(1500)
    
                            TriggerServerEvent("burgershot:item:sell", "burgermeat", prix, "Burger à la Viande")
    
                            VentePoint = true

                        end
                    })

                    RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Vendre un Burger (Poulet)", nil, {RightLabel = NishiClient.StringColor.GREEN..Config.Farm.PrixDeVente.."$/u"}, true, {
                        onSelected = function()
    
                            local prix = Config.Farm.PrixDeVente

                            VentePoint = false
                            
                            Wait(1500)
    
                            TriggerServerEvent("burgershot:item:sell", "burgerchicken", prix, "Burger au Poulet")
    
                            VentePoint = true

                        end
                    })

                end
                
                if (VentePoint == false) then
                    
                    RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Vendre un Burger (Poisson)", nil, {RightLabel = NishiClient.StringColor.GREEN..Config.Farm.PrixDeVente.."$/u"}, false, {})

                    RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Vendre un Burger (Viande)", nil, {RightLabel = NishiClient.StringColor.GREEN..Config.Farm.PrixDeVente.."$/u"}, false, {})

                    RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Vendre un Burger (Poulet)", nil, {RightLabel = NishiClient.StringColor.GREEN..Config.Farm.PrixDeVente.."$/u"}, false, {})

                end

            end)

        Wait(1)
        end
    end)
end

StatusMenu3 = false

local main3 = RageUI.CreateMenu("Burger Shot", "Cuisine", 0, 50, "Nishi", "interact_banner")
main3.Closed = function()
    StatusMenu3 = false
end

function OpenMenu3()
    if StatusMenu3 then
        StatusMenu3 = true
        RageUI.Visible(main3, true)
    else
        StatusMenu3 = true
        RageUI.Visible(main3, true)
    end
    CreateThread(function()
        while StatusMenu3 do
            
            RageUI.IsVisible(main3, function()

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Burger "..NishiClient.StringColor.GREEN.." (Poisson)", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("burgershot:item:transfo", "salad", "vegetables", "burgerbun", "fish", 2)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Burger "..NishiClient.StringColor.GREEN.." (Viande)", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("burgershot:item:transfo", "salad", "vegetables", "burgerbun", "meat", 1)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Burger "..NishiClient.StringColor.GREEN.." (Poulet)", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("burgershot:item:transfo", "salad", "vegetables", "burgerbun", "chicken", 3)
                    end
                })

            end)

        Wait(1)
        end
    end)
end

StatusMenu4 = false

local main4 = RageUI.CreateMenu("Burger Shot", "Menu Patron", 0, 50, "Nishi", "interact_banner")
main4.Closed = function()
    StatusMenu4 = false
end

function OpenMenu4()
    if StatusMenu4 then
        StatusMenu4 = true
        RageUI.Visible(main4, true)
    else
        StatusMenu4 = true
        RageUI.Visible(main4, true)
    end
    CreateThread(function()
        while StatusMenu4 do
            
            RageUI.IsVisible(main4, function()

                RageUI.Separator(NishiClient.StringColor.GREEN.."Légal")

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Recruter une personne", nil, {}, true, {
                    onSelected = function()
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" and ESX.PlayerData.job.grade_name == "boss") then
                    
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification("Personne n'est à proximité !")
                            else    
                                TriggerServerEvent("burgershot:boss:recruter", GetPlayerServerId(closestPlayer))
                            end
                        end
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Licencier une personne", nil, {}, true, {
                    onSelected = function()
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" and ESX.PlayerData.job.grade_name == "boss") then
                    
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification("Personne n'est à proximité !")
                            else    
                                TriggerServerEvent("burgershot:boss:licencier", GetPlayerServerId(closestPlayer))
                            end
                        end
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Promouvoir une personne", nil, {}, true, {
                    onSelected = function()
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" and ESX.PlayerData.job.grade_name == "boss") then
                    
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification("Personne n'est à proximité !")
                            else    
                                TriggerServerEvent("burgershot:boss:promouvoir", GetPlayerServerId(closestPlayer))
                            end
                        end
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Destituer une personne", nil, {}, true, {
                    onSelected = function()
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" and ESX.PlayerData.job.grade_name == "boss") then
                    
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                            if closestPlayer == -1 or closestDistance > 3.0 then
                                ESX.ShowNotification("Personne n'est à proximité !")
                            else    
                                TriggerServerEvent("burgershot:boss:destituer", GetPlayerServerId(closestPlayer))
                            end
                        end
                    end
                })

                RageUI.Line(235, 198, 33, 255)

                RageUI.Separator(NishiClient.StringColor.RED.."Illégal")

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Blanchiment", nil, {}, true, {
                    onSelected = function()
                        local money = tonumber(NHK.InputOnScreen("Combien voulez-vous blanchir ? ~w~(Min. 10000$ / Max. 1000000$)", "", 10))

                        ESX.ShowNotification("Patienter 10 secondes...")

                        Wait(10000)

                        TriggerServerEvent("burgershot:money:blanchiment", money)
                    end
                })

            end)

        Wait(1)
        end
    end)
end

StatusMenu5 = false

local main5 = RageUI.CreateMenu("Burger Shot", "Réfrigérateur", 0, 50, "Nishi", "interact_banner")
main5.Closed = function()
    StatusMenu5 = false
end

function OpenMenu5()
    if StatusMenu5 then
        StatusMenu5 = true
        RageUI.Visible(main5, true)
    else
        StatusMenu5 = true
        RageUI.Visible(main5, true)
    end
    CreateThread(function()
        while StatusMenu5 do
            
            RageUI.IsVisible(main5, function()

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Frites", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("burgershot:item:add", "fries", "Frites", 1)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Cocal-Cola", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("burgershot:item:add", "coke", "Coca-Cola", 1)
                    end
                })

                RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." Orangina", nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent("burgershot:item:add", "orangina", "Orangina", 1)
                    end
                })

            end)

        Wait(1)
        end
    end)
end

StatusMenu6 = false

local main6 = RageUI.CreateMenu("Burger Shot", "Garage", 0, 50, "Nishi", "interact_banner")
main6.Closed = function()
    StatusMenu6 = false
end

BlockButton = false

function OpenMenu6()
    if StatusMenu6 then
        StatusMenu6 = true
        RageUI.Visible(main6, true)
    else
        StatusMenu6 = true
        RageUI.Visible(main6, true)
    end
    CreateThread(function()
        while StatusMenu6 do
            
            RageUI.IsVisible(main6, function()

                for _,v in pairs(Config.Release1.list_vehicle) do

                    if (BlockButton == false) then
                
                        RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." "..v.label, nil, {}, true, {
                            onSelected = function()
                                local player = GetPlayerServerId(PlayerId())
                                local vehicle = v.Vehi
                                local Hash = GetHashKey(vehicle)
                                RequestModel(Hash)
                                local spawn = CreateVehicle(Hash, Config.Release1.point_garage_spawn, 300.0, false, false)
                                SetVehicleEngineOn(spawn, true, true, false)

                                Wait(50)
                                BlockButton = true
                                Wait(Config.Release1.WaitVehicle)
                                BlockButton = false
                            end
                        })
                        
                    end

                    local total = Config.Release1.WaitVehicle / 60 
                    local total2 = total / 1000

                    if (BlockButton == true) then
                        
                        RageUI.Button(NishiClient.StringColor.YELLOW..NishiClient.Arrow.RIGHT..NishiClient.StringColor.BASIC.." "..v.label, "~o~Patientez "..total2.." minutes avant de pouvoir faire spawn un autre véhicule", {}, false, {})

                    end

                end

            end)

        Wait(1)
        end
    end)
end

---------------------------------------------------------
--                      Marker                         --
---------------------------------------------------------

-- Récolte Viande
CreateThread(function()
    while true do
                
        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then 

            Recolte.Viande()
            Recolte.Poisson()
            Recolte.Legumes()
            Recolte.Pain()
            Recolte.Poulet()
            Recolte.Salade()
            Tranfo.Burger()
            Frigo.Menu()
            Garage.SortirVeh.vehicule()
            Garage.RangerVeh.vehicule()

            if (Config.Farm.ActiveVente == true) then
                
                Vente.Burger()

            end

        end

        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot" and ESX.PlayerData.job.grade_name == "boss") then
            
            Boss.Menu()

        end

    Wait(1)
    end
end)

Recolte = {
    Viande = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Recolte_Viande)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Recolte_Viande, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then
    
                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour prendre de la "..NishiClient.StringColor.YELLOW.."Viande")
                    
                    if IsControlJustPressed(0,38) then
                        
                        NHK.Animation("anim@mp_snowball", "pickup_snowball")

                        TriggerServerEvent("burgershot:item:add", "meat", "Viande", 1)

                    end

                end
    
        end
    end,

    Poisson = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Recolte_Poisson)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Recolte_Poisson, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then
    
                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour prendre du "..NishiClient.StringColor.YELLOW.."Poisson")

                    if IsControlJustPressed(0,38) then
                        
                        NHK.Animation("anim@mp_snowball", "pickup_snowball")

                        TriggerServerEvent("burgershot:item:add", "fish", "Poisson", 1)

                    end

                end
    
        end
    end,

    Poulet = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Recolte_Poulet)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Recolte_Poulet, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then
    
                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour prendre du "..NishiClient.StringColor.YELLOW.."Poulet")

                    if IsControlJustPressed(0,38) then
                        
                        NHK.Animation("anim@mp_snowball", "pickup_snowball")

                        TriggerServerEvent("burgershot:item:add", "chicken", "Poulet", 1)

                    end

                end
    
        end
    end,

    Pain = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Recolte_Pain)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Recolte_Pain, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then
    
                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour prendre du "..NishiClient.StringColor.YELLOW.."Pain")

                    if IsControlJustPressed(0,38) then
                        
                        NHK.Animation("anim@mp_snowball", "pickup_snowball")

                        TriggerServerEvent("burgershot:item:add", "burgerbun", "Pain de Burger", 1)

                    end

                end
    
        end
    end,

    Salade = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Recolte_Salade)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Recolte_Salade, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then
    
                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour prendre de la "..NishiClient.StringColor.YELLOW.."Salade")

                    if IsControlJustPressed(0,38) then
                        
                        NHK.Animation("anim@mp_snowball", "pickup_snowball")

                        TriggerServerEvent("burgershot:item:add", "salad", "Salade", 1)

                    end

                end
    
        end
    end,

    Legumes = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Recolte_Legume)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Recolte_Legume, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then
    
                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour prendre des "..NishiClient.StringColor.YELLOW.."Légumes")

                    if IsControlJustPressed(0,38) then
                        
                        NHK.Animation("anim@mp_snowball", "pickup_snowball")

                        TriggerServerEvent("burgershot:item:add", "vegetables", "Légumes", 1)

                    end

                end
    
        end
    end,
}

Vente = {
    Burger = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Vente_Burger)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Vente_Burger, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then
    
                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour vendre un "..NishiClient.StringColor.YELLOW.."Burger")

                    if IsControlJustPressed(0,38) then

                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then
                            
                            OpenMenu2()

                        end
                        
                    end

                end
    
        end
    end
}

Tranfo = {
    Burger = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Transformation_Burger)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Transformation_Burger, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then

                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour faire un "..NishiClient.StringColor.YELLOW.."Burger")

                    if IsControlJustPressed(0,38) then

                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then
                            
                            OpenMenu3()

                        end

                    end

                end
    
        end
    end
}

Boss = {
    Menu = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Farm.Menu_Boss)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Farm.Menu_Boss, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then

                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour accéder au "..NishiClient.StringColor.YELLOW.."Menu Boss")

                    if IsControlJustPressed(0,38) then
                        
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then

                            OpenMenu4()

                        end

                    end

                end
    
        end
    end
}

Frigo = {
    Menu = function()
        local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Release1.point_frigo)
    
        if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Release1.point_frigo, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then

                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour accéder au "..NishiClient.StringColor.YELLOW.."Frigo")

                    if IsControlJustPressed(0,38) then
                        
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then

                            OpenMenu5()

                        end

                    end

                end
    
        end
    end
}

Garage = {
    SortirVeh = {
        vehicule = function()
            local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Release1.point_garage_list_vehicle)
    
            if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Release1.point_garage_list_vehicle, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then

                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour accéder au "..NishiClient.StringColor.YELLOW.."Garage")

                    if IsControlJustPressed(0,38) then
                        
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then

                            OpenMenu6()

                        end

                    end

                end
    
            end
        end
    },

    RangerVeh = {
        vehicule = function()
            local PlayerPos = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, Config.Release1.point_garage_ranger_vehicle)
    
            if dist <= Config.Marker.Distance then
                    
            DrawMarker(Config.Marker.Type, Config.Release1.point_garage_ranger_vehicle, 0.0,0.0,0.0,0.0,0.0,0.0, Config.Marker.Taille.a, Config.Marker.Taille.b, Config.Marker.Taille.c, Config.Marker.Color.r, Config.Marker.Color.g, Config.Marker.Color.b, Config.Marker.Color.a, Config.Marker.Saut, false, p19, Config.Marker.Rotation)
    
                if dist <= 1.0 then

                    ESX.ShowHelpNotification("Faîte "..NishiClient.Input.E.." pour ranger le "..NishiClient.StringColor.YELLOW.."Véhicule")

                    if IsControlJustPressed(0,38) then
                        
                        if (ESX.PlayerData.job and ESX.PlayerData.job.name == "burgershot") then

                            NHK.DeleteVeh()

                        end

                    end

                end
    
            end
        end
    },
}

---------------------------------------------------------
--                      Blips                          --
---------------------------------------------------------

CreateThread(function()
    
    Bliiiip.Bliiiiiip()

end)

Bliiiip = {
    Bliiiiiip = function()
        local blip = AddBlipForCoord(Config.Blips_BurgerShot)
        
        SetBlipSprite(blip, Config.Blip.Sprite)
        SetBlipColour(blip, Config.Blip.Couleur)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.Blip.Taille)
        SetBlipAsShortRange(blip, true)
        
        if Config.Blip.Radius == true then
            local blipradius = AddBlipForRadius(Config.Blips_BurgerShot, Config.Blip.Taille_Radius)

            SetBlipSprite(blipradius,1)
            SetBlipColour(blipradius, Config.Blip.Couleur)
            SetBlipAlpha(blipradius, 100)
        end

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Config.Blip.Label)
        EndTextCommandSetBlipName(blip)
    end
}

---------------------------------------------------------
--                       Ped                           --
---------------------------------------------------------

CreateThread(function()

    if (Config.PNJ.Active == true) then

        Peed.Peeeeeeed()

    end
    
end)

Peed = {
    Peeeeeeed = function()
        function LoadModel(model)
            while not HasModelLoaded(model) do
                RequestModel(model)
                Wait(1)
            end
        end

        LoadModel(Config.PNJ.Ped_Model)
        Ped = CreatePed(2, GetHashKey(Config.PNJ.Ped_Model), Config.PNJ.Ped_Pos, Config.PNJ.Ped_Heading, 0, 0)
        DecorSetInt(Ped, "Nishi", 5431)
        FreezeEntityPosition(Ped, 1)
        SetEntityInvincible(Ped, true)
        SetBlockingOfNonTemporaryEvents(Ped, 1)
    end
}

---------------------------------------------------------
--                     Fonction                        --
---------------------------------------------------------

RegisterNetEvent("burgershot:test:client")
AddEventHandler("burgershot:test:client", function()
    print("^3(^4BurgerShot^3) ^7=> ^2Test is Good^7")
end)

NHK = {
    InputOnScreen = function(TextEntry, ExampleText, MaxStringLenght)
        AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
        blockinput = true 
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
            Citizen.Wait(1)
        end
        if UpdateOnscreenKeyboard() ~= 2 then
            local result = GetOnscreenKeyboardResult() 
            Citizen.Wait(500) 
            blockinput = false 
            return result 
        else
            Citizen.Wait(500) 
            blockinput = false 
            return nil 
        end
    end,

    ---@param DictAnim string
    ---@param TaskAnim string
    Animation = function(DictAnim, TaskAnim) 
        FreezeEntityPosition(PlayerPedId(), true)
        RequestAnimDict(DictAnim)
        while (not HasAnimDictLoaded(DictAnim)) do Citizen.Wait(1) end
        TaskPlayAnim(PlayerPedId(),DictAnim,TaskAnim,1.0,-1.0, 5000, 0, 1, true, true, true)
        Wait(1500)
        FreezeEntityPosition(PlayerPedId(), false)
    end,

    DeleteVeh = function()
        if IsPedInAnyVehicle(PlayerPedId()) then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            ESX.Game.DeleteVehicle(vehicle)
            Wait(50)
            ESX.ShowNotification("Le véhicule à été supprimer")
        else
            ESX.ShowNotification("Vous n'êtes pas dans un véhicule !")
        end
    end
}

