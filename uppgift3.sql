USE sql1;
GO

-- Beviljandegrad = andel beviljade av alla ansökningar (endast 1 av 1183 är återkallad).

-- Fråga 1: Vilka utbildningsområden har högst beviljandegrad?
-- Motivering: Ansökan kostar mycket och akademin är ny, så den bör satsa på områden där
-- chansen att få bifall är störst. Data/IT har många ansökningar men många avslag.
-- Områden med färre än 10 ansökningar utesluts eftersom andelen då blir opålitlig.
SELECT
    utbildningsomrade,
    COUNT(*) AS antal_ansokningar,
    SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) AS antal_beviljade,
    ROUND(100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*), 1) AS beviljandegrad_procent
FROM yh_ansokningar
GROUP BY utbildningsomrade
HAVING COUNT(*) >= 10
ORDER BY beviljandegrad_procent DESC;

-- Fråga 2: Vilka SUN5-inriktningar har högst beviljandegrad?
-- Motivering: Inom ett område skiljer det sig mycket mellan inriktningar. Det hjälper att hitta
-- nischer där det finns plats, eller se vilka inriktningar som är för trånga och bör styras om.
-- Minst 5 ansökningar krävs för att slumpen inte ska dominera.
SELECT
    utbildningsomrade,
    sun5_inriktning_namn,
    COUNT(*) AS antal_ansokningar,
    ROUND(100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*), 1) AS beviljandegrad_procent
FROM yh_ansokningar
GROUP BY utbildningsomrade, sun5_inriktning, sun5_inriktning_namn
HAVING COUNT(*) >= 5
ORDER BY beviljandegrad_procent DESC, antal_ansokningar DESC;

-- Fråga 3: Beviljandegrad för distans jämfört med bunden (platsbunden) utbildning
-- Motivering: Akademin kan hyra lokal och är inte geografiskt bunden. Om distans oftare får avslag
-- är platsbunden utbildning ett säkrare val.
SELECT
    studieform,
    COUNT(*) AS antal_ansokningar,
    SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) AS antal_beviljade,
    ROUND(100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*), 1) AS beviljandegrad_procent
FROM yh_ansokningar
GROUP BY studieform;

-- Fråga 4: Beviljandegrad för privata respektive kommunala/regionala anordnare per område
-- Motivering: Visar om en privat nystartad akademi står sig mot offentliga aktörer inom ett område,
-- eller om området domineras av kommun/region. Grupper med färre än 5 ansökningar utesluts.
SELECT
    utbildningsomrade,
    huvudmannatyp,
    COUNT(*) AS antal_ansokningar,
    ROUND(100.0 * SUM(CASE WHEN beslut = 'Beviljad' THEN 1 ELSE 0 END) / COUNT(*), 1) AS beviljandegrad_procent
FROM yh_ansokningar
GROUP BY utbildningsomrade, huvudmannatyp
HAVING COUNT(*) >= 5
ORDER BY utbildningsomrade, huvudmannatyp;