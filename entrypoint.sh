#!/usr/bin/dumb-init /bin/sh

set -e

[ -z $APP_NAME ] && { echo "Need to set APP_NAME"; exit 1; }
[ -z $NAMESPACE ] && { echo "Need to set NAMESPACE"; exit 1; }

export APP_ROLE=$NAMESPACE-$APP_NAME
export VAULT_TOKEN=`cat /secrets/vault-token | jq .clientToken -r`
export VAULT_ADDR=`cat /secrets/vault-token | jq .vaultAddr -r`

chown objectivefs:objectivefs /volume
chown objectivefs:objectivefs -R /var/cache/objectivefs

echo "Starting objectivefs...."

ntpdate -q pool.ntp.org

consul-template \
    -exec-reload-signal="SIGHUP" \
    -template="/templates/ct-pawn.conf:/tmp/ct-pawn" \
    -exec="consul-template -config=\"/tmp/ct-pawn\""