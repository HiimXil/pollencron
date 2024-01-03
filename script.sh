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
    curl  -s -X POST -H "Content-Type: application/json" -d '{"content":"<@'"$DISCORD_ID"'>","embeds": [{"title": "Pollen💐","url": "https://pollens.fr/","fields": [{"name": "🌼Niveau de pollen pour le Bouleau :","value": "'"$lvlBouleau"'"},{"name": "🌼Niveau de pollen pour les Gramine :","value": "'"$lvlGramine"'"},{"name": "🌼Niveau moyen de pollen moyen :","value": "'"$lvlavg"'"}],"footer": {"icon_url": "https://slate.dan.onl/slate.png"}}]}' "$DISCORD_WEBHOOK"
fi
