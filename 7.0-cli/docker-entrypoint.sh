#!/bin/bash
[ "$DEBUG" = "true" ] && set -x

composer self-update > /dev/null
composer global require hirak/prestissimo > /dev/null

exec "$@"
