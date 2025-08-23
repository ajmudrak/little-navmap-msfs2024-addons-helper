-- Copy Userpoints database addons to MSFS 2024 library airports addon flags
-- Expected main db is 'little_navmap_msfs24.sqlite'

attach 'little_navmap_userdata.sqlite' as userpointsdb;

UPDATE main.airport 
SET is_addon = 1 
WHERE airport_id IN (
    SELECT a.airport_id
    FROM userpointsdb.userdata u
    INNER JOIN main.airport a
        ON a.ident = u.ident
    WHERE u.type = 'Addon'
);

SELECT CONCAT(changes(), ' records updated');

SELECT
    'This addon userpoint does not exist as an airport in 2024' AS msg,
    u.ident
FROM userpointsdb.userdata u
LEFT JOIN main.airport a
    ON a.ident = u.ident
WHERE u.type = 'Addon'
    AND a.airport_id IS NULL;

.exit
