UPDATE public.hammadde
SET kalan_miktar = (
    COALESCE(NULLIF(regexp_replace(kalan_miktar, '[^0-9.]', '', 'g'), ''), '0')::numeric 
    + 
    floor(random() * 21 + 10)
)::text;
