#!/bin/bash

usage() { echo "Usage: $0 [-h <host> (REQUIRED)] [-u <username>] [-s <subnet>]" 1>&2; exit 1; }

while getopts "h:u:s:" opt; do
    case "${opt}" in
        h)
            host_server=${OPTARG}
            ;;
        u)
            username=${OPTARG}
            ;;
        s)
            subnet=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${host_server}" ]; then
    usage
fi

if [ -n "$username" ];then
    export SSHUTTLECMD="./sshuttle -r ${username}@${host_server} ${subnet}"
else
    export SSHUTTLECMD="./sshuttle -r ${host_server} ${subnet}"
fi
supervisord -n -c sshuttle_supervisor.conf

