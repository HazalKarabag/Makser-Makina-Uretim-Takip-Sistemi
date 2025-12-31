CREATE TABLE IF NOT EXISTS public.personel (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    ad text NOT NULL,
    soyad text NOT NULL,
    unvan text,
    mail text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM public.personel LIMIT 1) THEN
        INSERT INTO public.personel (ad, soyad, unvan, mail) VALUES
        ('Salih', 'Şener', 'Şirket Sahibi', 'salihsener@yonetici.com'),
        ('Yağız', 'Şener', 'Genel Müdür', 'yagizsener@yonetici.com'),
        ('Muhammed Tahir', 'Tüzün', 'Muhasebe', 'mtahirtuzun@muhasebe.com'),
        ('Murat', 'Karabıyık', 'Teknisyen', 'muratkarabiyik@teknisyen.com'),
        ('Ekrem', 'Ercan', 'Saha Montaj', NULL),
        ('Mustafa', 'Erten', 'Servis personeli', NULL),
        ('Arda', 'Ünal', 'Saha Montaj', NULL),
        ('İbrahim', 'Şengün', 'Saha Montaj', NULL),
        ('Yusuf', 'Hokkabaz', 'Saha Montaj', NULL),
        ('Zafer', 'Sezer', 'Üretim Şefi', 'zafersezer@uretimsefi.com'),
        ('Ahmet', 'Erli', 'Üretim Personeli', NULL);
    END IF;
END $$;
ALTER TABLE public.personel ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Personel tablosu herkese açık okuma"
ON public.personel
FOR SELECT
USING (true);
CREATE POLICY "Yöneticiler personel ekleyebilir"
ON public.personel
FOR INSERT
WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.user_roles ur
    WHERE ur.user_id = auth.uid()
    AND ur.role IN ('sirket_sahibi', 'genel_mudur')
  )
);
CREATE POLICY "Yöneticiler personel silebilir"
ON public.personel
FOR DELETE
USING (
  EXISTS (
    SELECT 1 FROM public.user_roles ur
    WHERE ur.user_id = auth.uid()
    AND ur.role IN ('sirket_sahibi', 'genel_mudur')
  )
);
CREATE POLICY "Yöneticiler personel güncelleyebilir"
ON public.personel
FOR UPDATE
USING (
  EXISTS (
    SELECT 1 FROM public.user_roles ur
    WHERE ur.user_id = auth.uid()
    AND ur.role IN ('sirket_sahibi', 'genel_mudur')
  )
);


