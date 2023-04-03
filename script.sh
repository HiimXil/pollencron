#!/bin/bash
# Script to run pollen cron job
res=$(curl -s https://www.pollens.fr/risks/thea/counties/91)
# Take pollen Name and his level
lvlBouleau=$(echo "$res" | jq -r '.risks[] | select(.pollenName == "Bouleau") | .level')
lvlavg=$(echo "$res" | jq '[.risks[] | .level ]| add/length')
# Send message to discord
if [ "$lvlBouleau" -gt 2 ] || [ "$(echo "$lvlavg>=1"| bc)" -eq 1 ]; then
    curl  -X POST -H "Content-Type: application/json" -d '{"content":"ALERTE <@'"$DISCORD_ID"'> \nNiveau de pollen pour le Bouleau : '"$lvlBouleau"' \nNiveau moyen de pollen moyen : '"$lvlavg"'"}' "$DISCORD_WEBHOOK"
else
    curl  -X POST -H "Content-Type: application/json" -d '{"content":"Niveau de pollen pour le Bouleau : '"$lvlBouleau"' \nNiveau moyen de pollen moyen : '"$lvlavg"'"}' "$DISCORD_WEBHOOK"
fi
