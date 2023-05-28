#!/bin/bash
echo "cron running"
# Script to run pollen cron job
res=$(curl -s https://www.pollens.fr/risks/thea/counties/"$DEPARTEMENT")
# Take pollen Name and his level
lvlBouleau=$(echo "$res" | jq -r '.risks[] | select(.pollenName == "Bouleau") | .level')
lvlGramine=$(echo "$res" | jq -r '.risks[] | select(.pollenName == "Gramin\u00e9es") | .level')
lvlavg=$(echo "$res" | jq '[.risks[] | .level ]| add/length')
# Send message to discord
if [ "$lvlBouleau" -gt 2 ] || [ "$lvlGramine" -gt 2 ] || [ "$(echo "$lvlavg>=1"| bc)" -eq 1 ]; then
    curl  -s -X POST -H "Content-Type: application/json" -d '{"content":"ALERTE <@'"$DISCORD_ID"'> \nNiveau de pollen pour le Bouleau : '"$lvlBouleau"' \nNiveau de pollen pour les Gramine : '"$lvlGramine"' \nNiveau moyen de pollen moyen : '"$lvlavg"'"}' "$DISCORD_WEBHOOK"
else
    curl  -s -X POST -H "Content-Type: application/json" -d '{"content":"Niveau de pollen pour le Bouleau : '"$lvlBouleau"' \nNiveau de pollen pour les Gramines : '"$lvlGramine"' \nNiveau moyen de pollen moyen : '"$lvlavg"'"}' "$DISCORD_WEBHOOK"
fi
