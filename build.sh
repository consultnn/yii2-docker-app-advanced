#!/usr/bin/env bash

readonly DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly CONTAINER_PREFIX=$(echo $(basename ${DIR}) | sed 's/[^a-zA-Z0-9_]//g');
readonly CONTAINER_PHP="${CONTAINER_PREFIX}_php_1";
readonly CONTAINER_MONGO="${CONTAINER_PREFIX}_mongo_1";

function init()
{
    ENV=Development
    DOMAIN=ru

    while [ -n "$1" ]
      do
        if [ "$1" != "$FUNCNAME" ];then
            case "$1" in
            -e|--env)   shift
                ENV=$1
                ;;
            -d|--domain)   shift
            DOMAIN=$1
                ;;
            -h|--help)
                _showHelpInit
                exit
                ;;
            esac
        fi
        shift
    done

    docker exec ${CONTAINER_PHP} php ./init --env=${ENV} --overwrite=y --domain=${DOMAIN}
}

function composer()
{
    COMMAND=""

    while [ -n "$1" ]
      do
        if [ "$1" != "$FUNCNAME" ];then
            case "$1" in
            -p|--prod)   shift
                COMMAND="--no-dev"
                ;;
            -h|--help)
                _showHelpComposer
                exit
                ;;
            esac
        fi
        shift
    done

    docker exec ${CONTAINER_PHP} composer install --prefer-dist --optimize-autoloader ${COMMAND}
}


# PRIVATE FUNCTIONS
function _showHelp()
{
cat <<EOF
  Supported commands:
    init            proxy to init php
    composer        proxy to install on dependencies in vendor
EOF
}

function _showHelpInit()
{
cat <<EOF
  Supported keys:
  --env|-e      [arg]       Environment (set "Development" or "Production")
                            Default: Development
EOF
}

function _showHelpComposer()
{
cat <<EOF
  Supported keys:
  --prod|-p                  Without dev dependences
EOF
}

# Enter point
case "$1" in
-h|--help)
    _showHelp
    ;;
*)
    if [ ! -z $(type -t $1 | grep function) ]; then
        $1 "${@:2}"
    else
        _showHelp
    fi
    ;;
esac