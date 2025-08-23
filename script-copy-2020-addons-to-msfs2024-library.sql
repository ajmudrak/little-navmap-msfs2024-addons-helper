-- Copy MSFS 2020 library addon airports flags to MSFS 2024 library
-- Expected main db is 'little_navmap_msfs24.sqlite'

attach 'little_navmap_msfs.sqlite' as msfs2020;

UPDATE main.airport 
SET is_addon = 1 
WHERE airport_id IN (
    SELECT a.airport_id 
    FROM msfs2020.airport a2020 
    INNER JOIN main.airport a 
        ON a.ident = a2020.ident 
    WHERE a2020.is_addon = 1
);

SELECT CONCAT(changes(), ' records updated');

SELECT 'This 2020 addon airport does not exist in 2024' AS msg, a2020.ident 
FROM msfs2020.airport a2020 
LEFT JOIN main.airport a 
    ON a.ident = a2020.ident 
WHERE a2020.is_addon = 1 
    AND a.airport_id IS NULL;

.exit
