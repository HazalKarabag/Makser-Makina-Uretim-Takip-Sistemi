DO $$
DECLARE
    rec RECORD;
    random_progress INTEGER;
BEGIN
    FOR rec IN SELECT * FROM uretim_kayit WHERE bitis_zamani IS NULL AND hedef_adet > 0 LOOP
        random_progress := floor(rec.hedef_adet * (random() * 0.8 + 0.1));
        UPDATE uretim_kayit
        SET uretilen_adet = GREATEST(uretilen_adet, random_progress)
        WHERE uretim_id = rec.uretim_id;
    END LOOP;
END $$;
