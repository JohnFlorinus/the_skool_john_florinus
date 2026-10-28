# The Skool – analys av YH-ansökningsomgång 2025

SQL-analys av MYHs resultat för ansökningsomgång 2025 (Tabell 3) för att hjälpa The Skool att välja vilka utbildningar de ska ansöka om. Datan är manuellt inladdad i SQL Server via SSMS (queries riktade mot databas `sql1` och tabell `yh_ansokningar`).

- `uppgift1.sql` – grundläggande EDA (1a–1i)
- `uppgift3.sql` – fyra egna frågor med motivering kopplat till stakeholderintervjun

## Resultat i korthet

Beviljandegrad = andel beviljade av alla ansökningar.

- **Data/IT** har 219 ansökningar men bara 14 % beviljas (31 st). Webbutvecklare, IT-projektledare och systemutveckling/programmering ligger på 0–7 %.
- Högst beviljandegrad (områden med minst 10 ansökningar): Transporttjänster 64 %, Hälso- och sjukvård 54 %, Teknik och tillverkning 53 %.
- **Platsbunden** utbildning beviljas oftare än distans: 42,6 % mot 35,0 %.
- **Kommun** har högre beviljandegrad än privata aktörer i bl.a. Data/IT (31 % mot 13 %), men det är få kommunala ansökningar.
- Beviljade och avslagna ansökningar liknar varandra i YH-poäng, platser och SeQF-nivå, så det går inte att "pricka rätt" genom att justera dessa.
- Stockholm och Västra Götaland har flest beviljade (89 vardera), därefter Skåne (45).
