#!/usr/bin/env bash
# Pulls each rider's totals from the Dolphins Cancer Challenge (DonorDrive) public API
# and writes them to data.json. DonorDrive asks for no more than one request every 15 seconds.
set -euo pipefail
IDS=(60430 60431 60432 60433)
OUT="data.json"
TMP="$(mktemp)"
echo '{}' > "$TMP"
for i in "${!IDS[@]}"; do
  id="${IDS[$i]}"
  [ "$i" -gt 0 ] && sleep 16
  json="$(curl -fsS --retry 3 --retry-delay 20 -H 'Accept: application/json' \
    -A 'MerrittFamilyDCCPage/1.0 (GitHub Actions)' \
    "https://dolphinscancerchallenge.com/api/participants/${id}")"
  jq --arg id "$id" --argjson p "$json" \
    '.[$id] = {name: $p.displayName, raised: ($p.sumDonations // 0), goal: ($p.fundraisingGoal // 0)}' \
    "$TMP" > "$TMP.next" && mv "$TMP.next" "$TMP"
done
jq --arg now "$(date -u +%Y-%m-%dT%H:%M:%SZ)" '{updated: $now, riders: .}' "$TMP" > "$OUT"
rm -f "$TMP"
cat "$OUT"
