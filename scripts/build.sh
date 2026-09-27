#!/usr/bin/env bash
set -euo pipefail

HAGEZI_URL="https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/pro-onlydomains.txt"
OUTPUT="blocklist.txt"
MANUAL="manual_additions.txt"
EXTENDED="extended_list.txt"

echo "Downloading HaGeZi Multi PRO..."
curl -sL --compressed "$HAGEZI_URL" -o /tmp/hagezi_base.txt

HAGEZI_COUNT=$(grep -cv '^#\|^$' /tmp/hagezi_base.txt)
echo "HaGeZi entries: $HAGEZI_COUNT"

echo "Merging lists..."
{
  # Keep HaGeZi header
  grep '^#' /tmp/hagezi_base.txt
  # Merge all domain sources, deduplicate, sort
  {
    grep -v '^#\|^$' /tmp/hagezi_base.txt
    grep -v '^#\|^$' "$MANUAL"
    grep -v '^#\|^$' "$EXTENDED"
  } | sort -u
} > "$OUTPUT"

TOTAL=$(grep -cv '^#\|^$' "$OUTPUT")
MANUAL_COUNT=$(grep -cv '^#\|^$' "$MANUAL")
EXTENDED_COUNT=$(grep -cv '^#\|^$' "$EXTENDED")

echo "Build complete:"
echo "  HaGeZi base:    $HAGEZI_COUNT"
echo "  Manual entries: $MANUAL_COUNT"
echo "  Extended list:  $EXTENDED_COUNT"
echo "  Total unique:   $TOTAL"

# Update README entry counts
TODAY=$(date -u +%Y-%m-%d)
sed -i.bak \
  -e "s/| HaGeZi Multi PRO Blocklist | [0-9.,]* |/| HaGeZi Multi PRO Blocklist | $HAGEZI_COUNT |/" \
  -e "s/| Manuell ergänzt | [0-9.,]* |/| Manuell ergänzt | $MANUAL_COUNT |/" \
  -e "s/| Erweiterte Subdomain-Liste | [0-9.,]* |/| Erweiterte Subdomain-Liste | $EXTENDED_COUNT |/" \
  -e "s/| \*\*Gesamt\*\* | \*\*[0-9.,]*\*\* |/| **Gesamt** | **$TOTAL** |/" \
  -e "s/Letzte Aktualisierung: [0-9-]*/Letzte Aktualisierung: $TODAY/" \
  README.md
rm -f README.md.bak

rm -f /tmp/hagezi_base.txt
echo "Done."
