import { createClient } from '@supabase/supabase-js';
import fs from 'fs';
import path from 'path';

const SUPABASE_URL = process.env.VITE_SUPABASE_URL || 'https://vcyymgawpffplchcaicv.supabase.co';
const SUPABASE_KEY = process.env.VITE_SUPABASE_ANON_KEY || 'YOUR_ANON_KEY_HERE'; 

const filesToUpload = [
    { productId: 3015, filePath: 'C:/Users/akyzs/.gemini/antigravity/brain/53df13f5-df5b-4b09-b380-8185851afaef/uploaded_image_0_1766840051881.jpg' },
    { productId: 3016, filePath: 'C:/Users/akyzs/.gemini/antigravity/brain/53df13f5-df5b-4b09-b380-8185851afaef/uploaded_image_1_1766840051881.jpg' },
    { productId: 3014, filePath: 'C:/Users/akyzs/.gemini/antigravity/brain/53df13f5-df5b-4b09-b380-8185851afaef/uploaded_image_2_1766840051881.jpg' },
    { productId: 3012, filePath: 'C:/Users/akyzs/.gemini/antigravity/brain/53df13f5-df5b-4b09-b380-8185851afaef/uploaded_image_3_1766840051881.jpg' }
];

async function uploadImages() {
    const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

    console.log('Upload işlemi başlıyor...');

    for (const item of filesToUpload) {
        try {
            console.log(`Ürün ${item.productId} için dosya yükleniyor: ${item.filePath}`);

            if (!fs.existsSync(item.filePath)) {
                console.error(`Dosya bulunamadı: ${item.filePath}`);
                continue;
            }

            const fileBuffer = fs.readFileSync(item.filePath);
            const fileName = path.basename(item.filePath);
            const storagePath = `${item.productId}/${Date.now()}-${fileName}`;

            const { data: uploadData, error: uploadError } = await supabase.storage
                .from('urun-dokumanlari')
                .upload(storagePath, fileBuffer, {
                    contentType: 'image/jpeg',
                    upsert: true
                });

            if (uploadError) {
                console.error(`Upload hatası (${item.productId}):`, uploadError.message);
                continue;
            }

            const { data: publicUrlData } = supabase.storage
                .from('urun-dokumanlari')
                .getPublicUrl(storagePath);

            const publicUrl = publicUrlData.publicUrl;
            console.log(`Dosya yüklendi. URL: ${publicUrl}`);

            const { error: updateError } = await supabase
                .from('urun')
                .update({ teknik_dokuman_url: publicUrl }) 
                .eq('urun_id', item.productId); 

            if (updateError) {
                console.error(`DB Update hatası (${item.productId}):`, updateError.message);
            } else {
                console.log(`Ürün ${item.productId} başarıyla güncellendi.`);
            }

        } catch (err) {
            console.error('Beklenmeyen hata:', err);
        }
    }
    console.log('İşlem tamamlandı.');
}

uploadImages();
