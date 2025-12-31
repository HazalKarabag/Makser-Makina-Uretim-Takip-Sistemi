

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'makine' AND column_name = 'durum') THEN
        ALTER TABLE public.makine ADD COLUMN durum text DEFAULT 'idle';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'makine' AND column_name = 'son_bakim_tarihi') THEN
        ALTER TABLE public.makine ADD COLUMN son_bakim_tarihi date;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'makine' AND column_name = 'sonraki_bakim_tarihi') THEN
        ALTER TABLE public.makine ADD COLUMN sonraki_bakim_tarihi date;
    END IF;
END $$;

UPDATE public.makine SET durum = 'idle', sonraki_bakim_tarihi = NULL, son_bakim_tarihi = NULL;

UPDATE public.makine 
SET durum = 'maintenance', 
    son_bakim_tarihi = CURRENT_DATE 
WHERE makine_id IN (5500, 5501);

UPDATE public.makine 
SET durum = 'fault' 
WHERE makine_id IN (5502, 5503, 5504);
UPDATE public.makine 
SET sonraki_bakim_tarihi = (CURRENT_DATE + INTERVAL '2 days')::date
WHERE makine_id IN (5505, 5506, 5507, 5508);
