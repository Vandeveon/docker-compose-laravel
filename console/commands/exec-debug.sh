#!/usr/bin/env bash
set -euo pipefail

usage()
{
    printf "${YELLOW}Usage:${COLOR_RESET}\n"
    echo "  exec [options] command"
    echo ""
    printf "${YELLOW}Options:${COLOR_RESET}\n"
    printf "  ${GREEN}--root${COLOR_RESET}     Run command as root user\n"
    echo ""
    echo "Example:"
    printf "  ${GREEN}dockeravel exec ls -lah${COLOR_RESET}\n"
}

if [ "$#" == 0 ] || [ "$1" == "--help" ]; then
    usage
    exit 0
fi

: ${EXEC_OPTIONS:=""}

if [ ${TTY_DISABLE} == true ]; then
    EXEC_OPTIONS="${EXEC_OPTIONS} -T"
fi

if [[ "$1" == "--root" ]]; then
    shift
    EXEC_OPTIONS="${EXEC_OPTIONS} -u root"
fi

DOCKER_COMPOSE_EXEC="${DOCKER_COMPOSE} exec"
if [ "${EXEC_OPTIONS}" != "" ]; then
    DOCKER_COMPOSE_EXEC="${DOCKER_COMPOSE_EXEC} ${EXEC_OPTIONS}"
fi

${DOCKER_COMPOSE_EXEC} ${SERVICE_PHP_XDEBUG} "$@"
