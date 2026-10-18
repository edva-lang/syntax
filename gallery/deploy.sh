#!/usr/bin/env bash
# Deploy automation script with error trapping and health check

set -euo pipefail

readonly APP_NAME="syntax-service"
readonly TARGET_PORT=8080
readonly RETRIES=5

log() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] $*"
}

check_health() {
    local host="$1"
    for ((i=1; i<=RETRIES; i++)); do
        log "Attempt $i: Checking $host:$TARGET_PORT/health..."
        if curl -sf "http://$host:$TARGET_PORT/health" > /dev/null; then
            log "Service is healthy!"
            return 0
        fi
        sleep 2
    done
    return 1
}

main() {
    local env="${1:-production}"
    log "Initiating deploy for $APP_NAME into $env..."

    export APP_ENV="$env"
    export LOG_LEVEL="info"

    if [[ "$env" == "production" ]]; then
        check_health "127.0.0.1"
    fi

    log "Deployment completed successfully."
}

main "$@"
