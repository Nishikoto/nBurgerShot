fx_version 'adamant'
game 'gta5'

author "NHK [Nishikoto]"
scriptname "nBurgerShot"
desc  "Menu touche avec RageUI / ESX"
version "1.0"


client_scripts {
    "Nishi/src/RMenu.lua",
    "Nishi/src/menu/RageUI.lua",
    "Nishi/src/menu/Menu.lua",
    "Nishi/src/menu/MenuController.lua",
    "Nishi/src/components/*.lua",
    "Nishi/src/menu/elements/*.lua",
    "Nishi/src/menu/items/*.lua",
    "Nishi/src/menu/panels/*.lua",
    "Nishi/src/menu/windows/*.lua",
    "Nishi/src/menu.lua",
    '@es_extended/locale.lua',
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}
