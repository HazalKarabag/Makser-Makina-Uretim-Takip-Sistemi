import fs from 'fs';

const path = 'd:/Github/Makser_makinee/seed_data.sql';
let content = fs.readFileSync(path, 'utf8');

const missingIds = [];
for (let i = 2021; i <= 2120; i++) {
    missingIds.push(
        `(${i}, 'Otomatik Eksik Parça ${i}', '10', '8', '100', 'ADET', 20, 20, 'GENEL', null, 'Evet', 0, '10', 1111)`
    );
}

const insertBlock = `
INSERT INTO public.hammadde (hammadde_id, stok_adi, satis_fiyati, alis_fiyati, kalan_miktar, birim, kdv_satis, kdv_alis, grubu, ara_grubu, aktif, bilgi_kodu, kritik_stok, tedarikci_id)
VALUES
${missingIds.join(',\n')}
ON CONFLICT (hammadde_id) DO NOTHING;
`;

const insertionPoint = "-- 10. URUN RECETESI";

const badBlockStart = "INSERT INTO public.hammadde (hammadde_id, stok_adi, satis_fiyati, alis_fiyati, kalan_miktar, birim, kdv_satis, kdv_alis, grubu, resim_url, aktif, kritik_stok, on_stok, tedarikci_id)";
if (content.includes(badBlockStart)) {
    console.log("Removing incorrect previous injection...");
    const endMarker = "ON CONFLICT (hammadde_id) DO NOTHING;";
    const startIndex = content.indexOf(badBlockStart);
    const endIndex = content.indexOf(endMarker, startIndex);

    if (startIndex !== -1 && endIndex !== -1) {
        const before = content.substring(0, startIndex);
        const after = content.substring(endIndex + endMarker.length);
        content = before + after;
    }
}

if (content.includes("'Otomatik Eksik Parça")) {
    console.log("Found existing auto-generated records, removing them to regenerate...");
}
if (content.includes(insertionPoint)) {
    if (!content.includes(badBlockStart)) {
        content = content.replace(insertionPoint, insertBlock + "\n\n" + insertionPoint);
        fs.writeFileSync(path, content, 'utf8');
        console.log("Successfully injected CORRECTED missing hammadde records into seed_data.sql");
    } else {
        console.log("Could not cleanly remove previous block. Replacing it directly.");
    }
}

let newContent = fs.readFileSync(path, 'utf8');
const wrongHeader = "INSERT INTO public.hammadde (hammadde_id, stok_adi, satis_fiyati, alis_fiyati, kalan_miktar, birim, kdv_satis, kdv_alis, grubu, resim_url, aktif, kritik_stok, on_stok, tedarikci_id)";
if (newContent.includes(wrongHeader)) {
    const parts = newContent.split(wrongHeader);
    if (parts.length > 1) {
        const afterHeader = parts[1];
        const endOfBlock = afterHeader.indexOf("ON CONFLICT (hammadde_id) DO NOTHING;");
        if (endOfBlock !== -1) {
            newContent = parts[0] + afterHeader.substring(endOfBlock + "ON CONFLICT (hammadde_id) DO NOTHING;".length);
        }
    }
}
if (newContent.includes(insertionPoint)) {
    const goodHeader = "INSERT INTO public.hammadde (hammadde_id, stok_adi, satis_fiyati, alis_fiyati, kalan_miktar, birim, kdv_satis, kdv_alis, grubu, ara_grubu, aktif, bilgi_kodu, kritik_stok, tedarikci_id)";
    if (!newContent.includes(goodHeader)) {
        newContent = newContent.replace(insertionPoint, insertBlock + "\n\n" + insertionPoint);
        fs.writeFileSync(path, newContent, 'utf8');
        console.log("Fixed schema and injected records.");
    } else {
        console.log("Good block already present.");
    }
}

