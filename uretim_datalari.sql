TRUNCATE TABLE public.uretim_kayit RESTART IDENTITY CASCADE;

INSERT INTO public.uretim_kayit 
(uretim_id, urun_id, makine_id, baslama_zamani, bitis_zamani, hedef_adet, uretilen_adet, fire_adet) 
VALUES
(5001, 3012, 5500, NOW() - INTERVAL '7 days', NOW() - INTERVAL '7 days' + INTERVAL '6 hours', 100, 95, 2), 
(5002, 3013, 5501, NOW() - INTERVAL '7 days', NOW() - INTERVAL '7 days' + INTERVAL '5 hours', 50, 40, 5),  
(5003, 3014, 5502, NOW() - INTERVAL '6 days', NOW() - INTERVAL '6 days' + INTERVAL '8 hours', 200, 198, 1),

(5004, 3015, 5503, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days' + INTERVAL '7 hours', 80, 75, 0),
(5005, 3016, 5504, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days' + INTERVAL '4 hours', 40, 38, 1),
(5006, 3012, 5505, NOW() - INTERVAL '5 days', NOW() - INTERVAL '5 days' + INTERVAL '6 hours', 120, 110, 8),

(5007, 3013, 5506, NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days' + INTERVAL '5 hours', 60, 60, 0), 
(5008, 3014, 5507, NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days' + INTERVAL '8 hours', 150, 130, 10),
(5009, 3015, 5508, NOW() - INTERVAL '4 days', NOW() - INTERVAL '4 days' + INTERVAL '3 hours', 40, 35, 2),

(5010, 3016, 5509, NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days' + INTERVAL '9 hours', 50, 48, 1),
(5011, 3012, 5510, NOW() - INTERVAL '3 days', NOW() - INTERVAL '3 days' + INTERVAL '6 hours', 90, 85, 3),

(5012, 3013, 5500, NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days' + INTERVAL '7 hours', 70, 68, 0),
(5013, 3014, 5501, NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days' + INTERVAL '5 hours', 110, 90, 15), 
(5014, 3015, 5502, NOW() - INTERVAL '2 days', NOW() - INTERVAL '2 days' + INTERVAL '8 hours', 100, 99, 1),

(5015, 3016, 5503, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day' + INTERVAL '6 hours', 60, 58, 2),
(5016, 3012, 5504, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day' + INTERVAL '4 hours', 85, 80, 0),
(5017, 3013, 5505, NOW() - INTERVAL '1 day', NOW() - INTERVAL '1 day' + INTERVAL '7 hours', 130, 100, 5),

(5018, 3014, 5500, NOW() - INTERVAL '2 hours', NULL, 150, 30, 0),  
(5019, 3015, 5501, NOW() - INTERVAL '4 hours', NULL, 80, 45, 1),   
(5020, 3016, 5502, NOW() - INTERVAL '1 hours', NULL, 50, 10, 0),   
(5021, 3012, 5503, NOW() - INTERVAL '6 hours', NULL, 200, 150, 2),  
(5022, 3013, 5504, NOW() - INTERVAL '3 hours', NULL, 120, 60, 2),  
(5023, 3014, 5505, NOW() - INTERVAL '30 minutes', NULL, 100, 5, 0), 
(5024, 3015, 5506, NOW() - INTERVAL '5 hours', NULL, 90, 80, 1),   
(5025, 3012, 5507, NOW() - INTERVAL '2 hours', NULL, 150, 40, 0), 
(5026, 3013, 5508, NOW() - INTERVAL '4 hours', NULL, 110, 75, 4),   
(5027, 3016, 5509, NOW() - INTERVAL '1 hours', NULL, 60, 15, 0),    
(5028, 3014, 5510, NOW() - INTERVAL '7 hours', NULL, 250, 240, 5), 
(5029, 3012, 5511, NOW() - INTERVAL '2 hours', NULL, 130, 50, 1);   

SELECT setval('uretim_kayit_uretim_id_seq', (SELECT MAX(uretim_id) FROM uretim_kayit));
