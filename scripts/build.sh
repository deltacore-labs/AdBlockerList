#!/usr/bin/env bash
set -euo pipefail

HAGEZI_URL="https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/wildcard/pro-onlydomains.txt"
OUTPUT="blocklist.txt"
MANUAL="manual_additions.txt"
EXTENDED="extended_list.txt"
WHITELIST="whitelist.txt"

echo "Downloading HaGeZi Multi PRO..."
curl -sL --compressed "$HAGEZI_URL" -o /tmp/hagezi_base.txt

HAGEZI_COUNT=$(grep -cv '^#\|^$' /tmp/hagezi_base.txt)
echo "HaGeZi entries: $HAGEZI_COUNT"

echo "Merging lists..."
# Split whitelist into exact entries and wildcard (*.domain.tld) entries
grep -v '^#\|^$' "$WHITELIST" | grep -v '^\*\.' | sort > /tmp/whitelist_exact.txt
grep -v '^#\|^$' "$WHITELIST" | grep '^\*\.' | sed 's/^\*\.//' | sort > /tmp/whitelist_wildcards.txt
WHITELIST_COUNT=$(grep -cv '^#\|^$' "$WHITELIST")
echo "Whitelist entries: $WHITELIST_COUNT ($(wc -l < /tmp/whitelist_exact.txt) exact, $(wc -l < /tmp/whitelist_wildcards.txt) wildcard)"

# Build merged+deduped list, then apply whitelist
{
  grep -v '^#\|^$' /tmp/hagezi_base.txt
  grep -v '^#\|^$' "$MANUAL"
  grep -v '^#\|^$' "$EXTENDED"
} | sort -u > /tmp/merged_domains.txt

# Remove exact matches
comm -23 /tmp/merged_domains.txt /tmp/whitelist_exact.txt > /tmp/after_exact.txt

# Remove wildcard matches (domains ending in *.whitelisted.tld)
if [ -s /tmp/whitelist_wildcards.txt ]; then
  WILDCARD_PATTERN=$(sed 's/\./\\./g' /tmp/whitelist_wildcards.txt | sed 's/^/\\./' | tr '\n' '|' | sed 's/|$//')
  grep -Ev "(${WILDCARD_PATTERN})$" /tmp/after_exact.txt > /tmp/after_wildcard.txt
else
  cp /tmp/after_exact.txt /tmp/after_wildcard.txt
fi

{
  grep '^#' /tmp/hagezi_base.txt
  cat /tmp/after_wildcard.txt
} > "$OUTPUT"
rm -f /tmp/whitelist_exact.txt /tmp/whitelist_wildcards.txt /tmp/merged_domains.txt /tmp/after_exact.txt /tmp/after_wildcard.txt

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
