Auriga development environment
------------------------------

### How to start

Host machine:

    CORE_APPS="lurcher seeker shooter"
    git clone git@github.com:AurigaDiscord/devbox.git devbox
    for A in $CORE_APPS; do git clone git@github.com:AurigaDiscord/${A}.git devbox/apps/${A}
    cd devbox
    cp vagrant-vars.yml.example vagrant-vars.yml
    # edit vagrant-vars.yml if you aren't happy with default VM configuration options
    vagrant up
    vagrant ssh

Inside VM:

    cd /apps
    export BOT_TOKEN="your_discord.bot_token"
    docker-compose build
    docker-compose up
