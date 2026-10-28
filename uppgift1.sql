USE sql1;
GO

-- 1a) Antal ansökningar per utbildningsområde, flest först
SELECT utbildningsomrade, COUNT(*) AS antal_ansokningar
FROM yh_ansokningar
GROUP BY utbildningsomrade
ORDER BY antal_ansokningar DESC;

-- 1b) Antal beviljade ansökningar per utbildningsområde
SELECT utbildningsomrade, COUNT(*) AS antal_beviljade
FROM yh_ansokningar
WHERE beslut = 'Beviljad'
GROUP BY utbildningsomrade
ORDER BY antal_beviljade DESC;

-- 1c) Antal avslagna ansökningar per utbildningsområde
SELECT utbildningsomrade, COUNT(*) AS antal_avslag
FROM yh_ansokningar
WHERE beslut = 'Avslag'
GROUP BY utbildningsomrade
ORDER BY antal_avslag DESC;

-- 1d) Antal beviljade ansökningar per utbildningsnamn inom Data/IT
SELECT utbildningsnamn, COUNT(*) AS antal_beviljade
FROM yh_ansokningar
WHERE utbildningsomrade = 'Data/IT' AND beslut = 'Beviljad'
GROUP BY utbildningsnamn
ORDER BY antal_beviljade DESC, utbildningsnamn;

-- 1e) Antal avslagna ansökningar per utbildningsnamn inom Data/IT
SELECT utbildningsnamn, COUNT(*) AS antal_avslag
FROM yh_ansokningar
WHERE utbildningsomrade = 'Data/IT' AND beslut = 'Avslag'
GROUP BY utbildningsnamn
ORDER BY antal_avslag DESC, utbildningsnamn;

-- 1f) Antal beviljade ansökningar per utbildningsanordnare och utbildningsnamn inom Data/IT
SELECT utbildningsanordnare, utbildningsnamn, COUNT(*) AS antal_beviljade
FROM yh_ansokningar
WHERE utbildningsomrade = 'Data/IT' AND beslut = 'Beviljad'
GROUP BY utbildningsanordnare, utbildningsnamn
ORDER BY utbildningsanordnare, utbildningsnamn;

-- 1g) Topp 5 län efter antal beviljade ansökningar
SELECT TOP 5 lan, COUNT(*) AS antal_beviljade
FROM yh_ansokningar
WHERE beslut = 'Beviljad' AND lan <> 'Flera kommuner'
GROUP BY lan
ORDER BY antal_beviljade DESC;

-- 1h) Andel distans och andel bunden per utbildningsområde
SELECT
    utbildningsomrade,
    COUNT(*) AS antal_ansokningar,
    ROUND(AVG(CASE WHEN studieform = 'Distans' THEN 100.0 ELSE 0 END), 1) AS andel_distans_procent,
    ROUND(AVG(CASE WHEN studieform = 'Bunden' THEN 100.0 ELSE 0 END), 1) AS andel_bunden_procent
FROM yh_ansokningar
GROUP BY utbildningsomrade
ORDER BY andel_distans_procent DESC;

-- 1i) Antal utbildningar som innehåller ordet AI
-- Skiftlägeskänslig (CS) jämförelse, annars matchar "ai" i t.ex. "Mainframe".
SELECT
    COUNT(*) AS antal_ansokningar,
    COUNT(DISTINCT utbildningsnamn) AS antal_unika_utbildningsnamn
FROM yh_ansokningar
WHERE utbildningsnamn COLLATE Latin1_General_CS_AS LIKE '%AI%';
