TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

TriggerEvent('esx_society:registerSociety', 'burgershot', 'burgershot', 'society_burgershot', 'society_burgershot', 'society_burgershot', {type = 'private'})

FiveM = {
    PercentageRendement = 0.25, -- 0.25 = 25% - En gros le gars récup 25% de montant d'argent sale
}


GetPlayerLicense = function(player)
    local identifiers = GetPlayerIdentifiers(player)
        for _, identifier in pairs(identifiers) do
            if string.sub(identifier, 1, string.len("license:")) == "license:" then
                return string.sub(identifier, string.len("license:") + 1)
            end
        end
    return nil
end

GetPlayerDiscordID = function(player)
    local identifiers = GetPlayerIdentifiers(player)
        for _, identifier in pairs(identifiers) do
            if string.sub(identifier, 1, string.len("discord:")) == "discord:" then
                return string.sub(identifier, string.len("discord:") + 1)
            end
        end
    return nil
end


-- OnPluginStarted (BurgerShot)
local BS = "^3(^4BurgerShot^3) ^7=> ^2Started^7"
print(BS)

-- Notif All Player
RegisterNetEvent("burgershot:notif", function(message)
    TriggerClientEvent('esx:showNotification', -1, message)
end)

-- Notif Source Player
RegisterNetEvent("burgershot:notif2", function(message)
    TriggerClientEvent('esx:showNotification', source, message)
end)

-- Vente item
RegisterNetEvent("burgershot:item:sell", function(item,price,label)
    local xPlayer = ESX.GetPlayerFromId(source)
    local licence = GetPlayerLicense(source)

    if (xPlayer.getInventoryItem(item).count >= 1) then
        xPlayer.removeInventoryItem(item, 1)
        xPlayer.addAccountMoney("bank", price)

        TriggerClientEvent('esx:showNotification', source, "Vous venez de vendre un ~y~"..label)

        print("^3(^4BurgerShot^3) ^7=> ^2Vente de ^4"..label.." ^3("..item.." x1)^2 au prix de ^3"..price.."$^2 // Player : ^3"..GetPlayerName(source).." [licence:"..licence.."]^7")
    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez de ~y~"..label.."~s~ sur vous")        
    end
end)

-- Add item
RegisterNetEvent("burgershot:item:add", function(item,label,count)
    local xPlayer = ESX.GetPlayerFromId(source)
    local licence = GetPlayerLicense(source)

    if (xPlayer.getInventoryItem(item).count <= 10) then
        
        xPlayer.addInventoryItem(item, count)

        TriggerClientEvent("esx:showNotification", source, "Ajout de ~y~"..label.." (x1)~s~ dans votre inventaire.")

        print("^3(^4BurgerShot^3) ^7=> ^2Ajout de ^4"..label.." ^3("..item.." x1)^2 // Player : ^3"..GetPlayerName(source).." [licence:"..licence.."]^7")

    else
            
        TriggerClientEvent("esx:showNotification", source, "Vous ne pouvez pas prendre plus de "..label.." sur vous.")    

    end

end)

-- Transfo item
RegisterNetEvent("burgershot:item:transfo", function(item1,item2,item3,item4,type)
    local licence = GetPlayerLicense(source)

    --[[
        item1 = Salade (salad)
        item2 = Légumes (vegetables)
        item3 = Pain de Burger (burgerbun)
        item4 = Viande (meat) / Poisson (fish) / Poulet (chicken)

        -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-

        type [
            1 = Viande
            2 = Poisson
            3 = Poulet
        ]
    ]]

    local xPlayer = ESX.GetPlayerFromId(source)

    if (type == 1) then

        if (xPlayer.getInventoryItem(item1).count >= 1 and xPlayer.getInventoryItem(item2).count >= 1 and xPlayer.getInventoryItem(item3).count >= 1 and xPlayer.getInventoryItem(item4).count >= 1) then
            
            xPlayer.removeInventoryItem(item1, 1)
            xPlayer.removeInventoryItem(item2, 1)
            xPlayer.removeInventoryItem(item3, 1)
            xPlayer.removeInventoryItem(item4, 1)

            xPlayer.addInventoryItem("burgermeat", 1)

            print("^3(^4BurgerShot^3) ^7=> ^3"..GetPlayerName(source).." [licence:"..licence.."]^2 à fais une recette de cuisine ^4(Burger à la viande)^7")

        else
                
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas les ingrédients requis !")

        end
        
    elseif (type == 2) then

        if (xPlayer.getInventoryItem(item1).count >= 1 and xPlayer.getInventoryItem(item2).count >= 1 and xPlayer.getInventoryItem(item3).count >= 1 and xPlayer.getInventoryItem(item4).count >= 1) then
            
            xPlayer.removeInventoryItem(item1, 1)
            xPlayer.removeInventoryItem(item2, 1)
            xPlayer.removeInventoryItem(item3, 1)
            xPlayer.removeInventoryItem(item4, 1)

            xPlayer.addInventoryItem("burgerfish", 1)

            print("^3(^4BurgerShot^3) ^7=> ^3"..GetPlayerName(source).." [licence:"..licence.."]^2 à fais une recette de cuisine ^4(Burger au Poisson)^7")

        else
                
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas les ingrédients requis !")

        end
        
    elseif (type == 3) then

        if (xPlayer.getInventoryItem(item1).count >= 1 and xPlayer.getInventoryItem(item2).count >= 1 and xPlayer.getInventoryItem(item3).count >= 1 and xPlayer.getInventoryItem(item4).count >= 1) then

            xPlayer.removeInventoryItem(item1, 1)
            xPlayer.removeInventoryItem(item2, 1)
            xPlayer.removeInventoryItem(item3, 1)
            xPlayer.removeInventoryItem(item4, 1)

            xPlayer.addInventoryItem("burgerchicken", 1)

            print("^3(^4BurgerShot^3) ^7=> ^3"..GetPlayerName(source).." [licence:"..licence.."]^2 à fais une recette de cuisine ^4(Burger au Poulet)^7")

        else
                
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas les ingrédients requis !")

        end

    end

end)

-- Boss
RegisterNetEvent("burgershot:boss:recruter", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local playerJob = xPlayer.getJob()

    if playerJob.grade_name == "boss" then
        xTarget.setJob(sourceJob.name, 0)
        TriggerClientEvent("esx:showNotification", source, "Vous venez de recruté la personne.")
        TriggerClientEvent("esx:showNotification", target, "Vous venez de vous faire recruté.")
    end

end)

RegisterNetEvent("burgershot:boss:licencier", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local playerJob = xPlayer.getJob()

    if playerJob.grade_name == "boss" then
        xTarget.setJob("unemployed", 0)
        TriggerClientEvent("esx:showNotification", source, "Vous venez de licencier la personne.")
        TriggerClientEvent("esx:showNotification", target, "Vous venez de vous faire licencier.")
    end
end)

RegisterNetEvent("burgershot:boss:promouvoir", function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local playerJob = xPlayer.getJob()
    local targetJob = xTarget.getJob()

    if playerJob.grade_name == "boss" then
        if playerJob.name == targetJob.name then
            if (targetJob.grade <= 3) then
                xTarget.setjob(targetJob.name, targetJob.grade + 1)
                TriggerClientEvent("esx:showNotification", target, "Vous avez été promu.")
                TriggerClientEvent("esx:showNotification", source, "Le joueurs à été promu.")
            end
        else
            TriggerClientEvent("esx:showNotification", source, "Le joueurs n'est pas dans votre entreprise.")
        end
    end
end)

RegisterNetEvent('burgershot:boss:destituer', function(target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    local playerJob = xPlayer.getJob()
    local targetJob = xTarget.getJob()

    if playerJob.grade_name == "boss" then
        if playerJob.name == targetJob.name then
            if (targetJob.grade <= 3) then
                xTarget.setjob(targetJob.name, targetJob.grade - 1)
                TriggerClientEvent("esx:showNotification", target, "Vous avez été destituer d'un grade.")
                TriggerClientEvent("esx:showNotification", source, "Le joueurs à été destituer d'un grade.")
            end
        else
            TriggerClientEvent("esx:showNotification", source, "Le joueurs n'est pas dans votre entreprise.")
        end
    end
end)

-- Blanchiment
RegisterNetEvent("burgershot:money:blanchiment", function(amount)
    local licence = GetPlayerLicense(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local account = xPlayer.getAccount('black_money')

    if (account.money >= amount) then
        if (amount > 0 and amount >= 10000 and amount <= 1000000) then
                
            xPlayer.removeAccountMoney("black_money", amount)

            local total = amount * FiveM.PercentageRendement

            xPlayer.addMoney(total)

            print("^3(^4BurgerShot^3) ^7=> ^3"..GetPlayerName(source).." [licence:"..licence.."]^2 vient de blanchir ^4"..amount.."$ ("..total.."$)^2 grace à une entreprise.")

            TriggerClientEvent("esx:showNotification", source, "Vous venez de blanchir "..amount.."$ ("..total.."$)")  
        else
            TriggerClientEvent("esx:showNotification", source, "Vous ne pouvez pas blanchir moins de 10K et plus de 1M !")        
        end
    else
        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent sale sur vous !")  
    end
end)