fx_version 'cerulean'
game 'gta5'

author 'Sna'
description 'Lapdance resource for the Unicorn'
version '1.0'

shared_scripts {
	'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
}

client_scripts {
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/functions.lua',
	'client/main.lua'
}

server_script 'server/main.lua'