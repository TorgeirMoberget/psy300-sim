#!/bin/bash
# ---------------------------------------------------------------------------
# PSY300 · start appene lokalt
#
# Dobbeltklikk denne fila. Den starter en liten webserver i denne mappa og
# åpner avstemningsappen i nettleseren med underviserrollen satt.
#
# Hvorfor en server, og ikke bare dobbeltklikke HTML-fila? Fordi nettleseren
# behandler en fil åpnet fra disk som «ingen opprinnelse», og blokkerer da
# forespørselen som henter klassens svar fra Google-arket. Med en server får
# sida en ekte adresse (http://localhost), og alt virker som på nett.
#
# Serveren kjører bare mens dette vinduet er åpent. Lukk vinduet, eller trykk
# Ctrl-C, når du er ferdig. Ingenting installeres.
# ---------------------------------------------------------------------------

cd "$(dirname "$0")" || exit 1

PORT=8000
# ledig port? ellers prøv noen til
while lsof -i :$PORT >/dev/null 2>&1; do
  PORT=$((PORT+1))
  if [ $PORT -gt 8010 ]; then echo "Fant ingen ledig port."; exit 1; fi
done

URL="http://localhost:$PORT/PSY300_Prediksjoner.html?rolle=underviser"

echo ""
echo "  PSY300 · lokal server"
echo "  ─────────────────────────────────────────────────────────────"
echo "  Mappe:  $(pwd)"
echo "  Adresse: $URL"
echo ""
echo "  Oversikt over alle appene:  http://localhost:$PORT/index.html"
echo ""
echo "  La dette vinduet stå åpent så lenge du underviser."
echo "  Avslutt med Ctrl-C, eller bare lukk vinduet."
echo "  ─────────────────────────────────────────────────────────────"
echo ""

# gi serveren et halvsekund før nettleseren spør etter sida
( sleep 0.7; open "$URL" ) &

python3 -m http.server $PORT --bind 127.0.0.1
