fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

author 'Scott'
description 'Campfire Crafting Script'
version '0.3'

shared_script {
    'config.lua',
    'assets'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

ui_page 'UI/index.html'

files {
    'UI/index.html',
    'UI/style.css',
    'UI/main.js'
}