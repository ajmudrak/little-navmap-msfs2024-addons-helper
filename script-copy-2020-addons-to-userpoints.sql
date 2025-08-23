-- Copy MSFS 2020 library addon airports flags to Userpoints database
-- Expected main db is 'little_navmap_userdata.sqlite'

attach 'little_navmap_msfs.sqlite' as msfs2020;

INSERT INTO main.userdata 
(
    type, 
    name, 
    ident,
    laty,
    lonx,
    altitude,
    tags,
    visible_from,
    last_edit_timestamp
)
SELECT 
    'Addon' AS type, 
    a2020.name,
    a2020.ident,
    a2020.laty,
    a2020.lonx,
    a2020.altitude,
    'MSFS2024,imported-from-MSFS2020' AS tags,
    3000 AS shown_at,
    CONCAT(
        strftime('%FT%R:%f', 'now', 'localtime'), 
        (
            SELECT CONCAT(SUBSTRING(timediff, 1, 1), SUBSTRING(timediff, 13, 5)) AS timezone_offset 
            FROM (
                SELECT timediff(datetime('now', 'localtime'), datetime()) timediff) timezonecalc
        )
    ) AS last_edit_timestamp 
FROM msfs2020.airport a2020 
LEFT JOIN main.userdata u
    ON u.ident = a2020.ident
        AND u.type = 'Addon' 
WHERE a2020.is_addon = 1 
    AND u.userdata_id IS NULL;


SELECT CONCAT(changes(), ' records inserted');

.exit
