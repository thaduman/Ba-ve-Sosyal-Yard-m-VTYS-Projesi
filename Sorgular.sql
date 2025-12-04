-- Bağışçıların bulundukları şehirde yapılan bağış sayısı (JOIN + GROUP BY)
select a.sehir, count(by.bagisci_id) as bagis_sayisi
from bagis_yapar by
join bagisci b on b.bagisci_id = by.bagisci_id
join adres a on a.postakodu = b.postakodu
group by a.sehir;


-- Her kategorideki toplam ürün çeşit sayısı (JOIN + GROUP BY)
select k.kategori_adi, count(u.urun_id) as toplam_urun
from kategori k
left join urun u on u.kategori_id = k.kategori_id
group by k.kategori_adi;

-- Ankara'daki Bağışçıların Bağış Sayısını Güncelleme (UPDATE & SUBQUERY)
UPDATE bagisci
SET bagissayisi = bagissayisi + 1
WHERE postakodu IN (
    SELECT postakodu 
    FROM adres 
    WHERE sehir = 'Ankara'
);

-- Depolara göre toplam stok miktarı ve ortalama depolanan miktar (JOIN + GROUP BY)
select d.depo_ismi,
	sum(dp.depolanma_miktari) as toplam_stok,
	avg(dp.depolanma_miktari) as ortalama_stok
from depo d
join depolanir dp on dp.depo_id = d.depo_id
group by d.depo_ismi;


-- Kategori Bazlı Toplam Bağış Ağırlığının Hesaplanması
SELECT k.kategori_adi,
SUM(u.agirlik) AS toplam_bagis_agirligi
FROM kategori k
JOIN urun u ON u.kategori_id = k.kategori_id
JOIN bagis_yapar b ON b.urun_id = u.urun_id
GROUP BY k.kategori_adi;


-- Yönetici, Depo ve Dağıtım Denetim Bilgisi
SELECT y.ad, y.soyad, d.depo_ismi, yt.denetim_tarihi
FROM yonetir yt
INNER JOIN yonetici y ON yt.yonetici_id = y.yonetici_id
INNER JOIN depo d ON yt.depo_id = d.depo_id;

-- Her depo için depolanan ürün çeşit sayısı
select d.depo_ismi, count(dp.urun_id) as urun_cesit_sayisi from depo d
left join depolanir dp on dp.depo_id = d.depo_id
group by d.depo_ismi;


-- Kritik Stok Seviyesindeki Ürünlerin Depo Bilgisi (NATURAL JOIN)
SELECT 
    u.ad AS urun_adi, 
    d.depo_ismi, 
    dp.depolanma_miktari
FROM 
    urun u
NATURAL JOIN 
    depolanir dp
NATURAL JOIN 
    depo d
WHERE 
    dp.depolanma_miktari < 50;