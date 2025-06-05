#!/bin/bash

##### postAttachCommand.sh
#
# Do you need to do something each time a user attaches to the container?
#
# set -eux
# export postAttachCommand=true

##### Set Helpful Environment Variables

cp -f ${DEVLITE_CONTAINER_DEVCONTAINER_FOLDER}/.bash_aliases ~/.bash_aliases

##### Make sure Laravel and Node are fully installed

cd ${DEVLITE_CONTAINER_SRC_FOLDER}

[ ! -d "vendor" ] && composer install
[ ! -d "node_modules" ] && npm install

[ ! -f ".env" ] && (
    cp ".env.devlite" ".env"
    php artisan key:generate
    php artisan migrate
    )

##### Add your changes below here.