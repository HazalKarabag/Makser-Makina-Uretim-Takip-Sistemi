TRUNCATE TABLE public.uretim_kayit RESTART IDENTITY CASCADE;

DO $$
DECLARE
    m_id INT;       
    p_id INT;       
    curr_day TIMESTAMP;
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    target INT;
    produced INT;
    scrap INT;
    shift INT;
    is_active BOOLEAN;
    day_count INT;
BEGIN
    FOR day_count IN REVERSE 365..0 LOOP
        curr_day := CURRENT_DATE - (day_count || ' days')::INTERVAL;
        
        FOR m_id IN 5500..5511 LOOP
            
            FOR shift IN 1..(1 + floor(random() * 3)::int) LOOP
                p_id := 3012 + floor(random() * 5)::int;

                IF shift = 1 THEN
                    start_time := curr_day + INTERVAL '08:00:00' + (floor(random()*60) || ' minutes')::INTERVAL;
                ELSIF shift = 2 THEN
                    start_time := curr_day + INTERVAL '16:00:00' + (floor(random()*60) || ' minutes')::INTERVAL;
                ELSE
                    start_time := curr_day + INTERVAL '23:00:00' + (floor(random()*60) || ' minutes')::INTERVAL;
                END IF;
                end_time := start_time + (floor(random() * 4 + 4) || ' hours')::INTERVAL;
                IF start_time > NOW() THEN 
                    CONTINUE; 
                END IF;
                IF day_count = 0 AND shift = 3 AND random() < 0.8 THEN
                    end_time := NULL; 
                    is_active := TRUE;
                ELSIF day_count = 0 AND end_time > NOW() THEN
                    end_time := NULL;
                    is_active := TRUE;
                ELSE
                    is_active := FALSE;
                END IF;
                target := 100 + floor(random() * 400); 
                
                IF is_active THEN
                    produced := floor(target * (random() * 0.9));
                    scrap := floor(produced * (random() * 0.03)); 
                ELSE
                    produced := floor(target * (0.85 + random() * 0.25));
                    scrap := floor(produced * (random() * 0.05)); 
                END IF;
                INSERT INTO public.uretim_kayit (
                    urun_id, 
                    makine_id, 
                    baslama_zamani, 
                    bitis_zamani, 
                    hedef_adet, 
                    uretilen_adet, 
                    fire_adet
                )
                VALUES (
                    p_id, 
                    m_id, 
                    start_time, 
                    end_time, 
                    target, 
                    produced, 
                    scrap
                );

            END LOOP;
        END LOOP;
    END LOOP;
    PERFORM setval('uretim_kayit_uretim_id_seq', (SELECT MAX(uretim_id) FROM uretim_kayit));
END $$;
