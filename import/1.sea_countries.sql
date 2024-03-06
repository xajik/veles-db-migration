DO $$
DECLARE
    row_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO row_count FROM geo.country;
    IF row_count = 0 THEN
        COPY geo.country(id, name, iso_alpha2, iso_alpha3, iso_numeric, continent)
        FROM '1.sea_countries.csv' DELIMITER ',' CSV HEADER;
    END IF;
END $$;