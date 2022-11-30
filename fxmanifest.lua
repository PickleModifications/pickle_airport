fx_version "cerulean"
game "gta5"

shared_scripts {
	"@ox_lib/init.lua",
	"config.lua",
	"bridge/**/shared.lua",
	"modules/**/shared.lua",
    "core/shared.lua"
}

client_scripts {
	"bridge/**/client.lua",
	"modules/**/client.lua",
    "core/client.lua"
}

server_scripts {
	"bridge/**/server.lua",
	"modules/**/server.lua",
    "core/server.lua"
}

lua54 'yes'