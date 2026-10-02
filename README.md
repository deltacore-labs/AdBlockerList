# AdBlockerList

DNS-Blockliste für die AVM FritzBox – blockiert Werbung, Tracking, Telemetrie und Datensammler.

## Einbinden in die FritzBox

> **Hinweis:** Diese Funktion erfordert die Beta-Firmware von AVM (FRITZ!Lab). Nur bestimmte Modelle werden unterstützt.
> Beta-Firmware herunterladen: [fritz.com/fritz-lab](https://fritz.com/en/pages/fritz-lab-fresh-from-development)

1. FritzBox-Oberfläche öffnen: `http://fritz.box`
2. **Heimnetz** → **Netzwerk** → Reiter **Netzwerkeinstellungen**
3. Nach unten scrollen zu **Erweiterte Netzwerkeinstellungen** und aufklappen
4. Reiter **DNS-Filter** öffnen
5. Checkbox **FritzBox als DNS-Filter** aktivieren
6. Unter **DNS-Filterliste** auf **Filterliste hinzufügen** (rechts unten) klicken
7. Einen Namen vergeben und folgende URL eintragen:

```
https://cdn.jsdelivr.net/gh/deltacore-labs/AdBlockerList@main/blocklist.txt
```

8. Speichern und Liste aktualisieren.

## Inhalt

| Quelle | Einträge |
|---|---|
| HaGeZi Multi PRO Blocklist | 227618 |
| Manuell ergänzt | 181 |
| Erweiterte Subdomain-Liste | 104220 |
| **Gesamt** | **331232** |

Letzte Aktualisierung: 2026-10-02

### Manuell ergänzte Kategorien (`manual_additions.txt`)

- **Social Media Ads:** Facebook/Meta, Twitter/X, LinkedIn, Pinterest, Reddit, TikTok, YouTube
- **Analytics:** Google Analytics/Tag Manager, Yahoo Analytics, Yandex Metrika, Adobe Omniture, Microsoft Clarity
- **Heatmap/Session-Tools:** Hotjar, Mouseflow, LuckyOrange, Freshmarketer, Smartlook, FullStory
- **Error Tracking:** Sentry, Bugsnag, Rollbar
- **Mobile Hersteller:** Xiaomi/MIUI, Samsung ACR, Huawei/HiCloud, OPPO, Realme, OnePlus
- **Sonstige:** Unity Ads, media.net, Amazon Ads, Apple Tracking, Spotify Ads

### Erweiterte Subdomain-Liste (`extended_list.txt`)

Enthält ~104.000 subdomain-spezifische Tracking-Einträge (z.B. Analytics-Endpunkte einzelner Websites). Diese werden bei jedem Update beibehalten.

## Dateien

| Datei | Beschreibung |
|---|---|
| `blocklist.txt` | Fertige Blockliste (wird automatisch generiert) |
| `manual_additions.txt` | Manuell gepflegte Ergänzungen (nach Kategorie) |
| `extended_list.txt` | Erweiterte Subdomain-Einträge |
| `scripts/build.sh` | Build-Skript zum lokalen Generieren der Liste |

## Aktualisierung

Die Liste wird täglich automatisch via GitHub Actions aktualisiert:
- Aktuelle [HaGeZi Multi PRO](https://github.com/hagezi/dns-blocklists) Basis wird heruntergeladen
- Mit `manual_additions.txt` und `extended_list.txt` zusammengeführt
- Duplikate werden entfernt, Liste wird sortiert
- README-Statistiken werden automatisch aktualisiert

Manuellen Update-Trigger: **Actions** → **Update Blocklist** → **Run workflow**

## Lizenz

Die HaGeZi-Basis-Liste steht unter ihrer eigenen [Lizenz](https://github.com/hagezi/dns-blocklists/blob/main/LICENSE).
