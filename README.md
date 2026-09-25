# AdBlockerList

DNS-Blockliste für die AVM FritzBox – blockiert Werbung, Tracking, Telemetrie und Datensammler.

## Einbinden in die FritzBox

1. FritzBox-Oberfläche öffnen: `http://fritz.box`
2. **Heimnetz** → **Netzwerk** → **DNS-Rebind-Schutz** (oder je nach Firmware: **Heimnetz** → **Heimnetzübersicht** → **DNS**)
3. Unter "Blacklist" folgende URL eintragen:

```
https://cdn.jsdelivr.net/gh/deltacore-labs/AdBlockerList@main/blocklist.txt
```

4. Speichern und Liste aktualisieren.

## Inhalt

| Quelle | Einträge |
|---|---|
| HaGeZi Multi PRO Blocklist | 228.217 |
| Manuell ergänzt | 86 |
| **Gesamt** | **228.303** |

### Manuell ergänzte Kategorien

- **Social Media Ads:** Facebook, Twitter, LinkedIn, Pinterest, Reddit, TikTok, YouTube
- **Analytics:** Google Analytics, Yahoo Analytics, Yandex Metrika
- **Heatmap/Session-Tools:** Hotjar, Mouseflow, LuckyOrange, Freshmarketer
- **Error Tracking:** Sentry, Bugsnag
- **Mobile Hersteller:** Xiaomi/MIUI, Samsung, Huawei/HiCloud, OPPO, Realme, OnePlus
- **Sonstige:** Unity Ads, Yahoo Gemini, media.net, Amazon S3 Ad-Domains

## Aktualisierung

Die Liste basiert auf der [HaGeZi DNS Blocklist](https://github.com/hagezi/dns-blocklists) und wird bei Bedarf manuell aktualisiert.

## Lizenz

Die HaGeZi-Basis-Liste steht unter ihrer eigenen [Lizenz](https://github.com/hagezi/dns-blocklists/blob/main/LICENSE).
