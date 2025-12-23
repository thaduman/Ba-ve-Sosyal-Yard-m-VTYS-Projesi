create or replace view v_bagisci_analiz_paneli as
select b.bagisci_id,
coalesce(bk.kurumismi, bi.ad || ' ' || bi.soyad) as bagisci_kimligi, a.sehir,

count(bya.urun_id) as toplam_bagis_adeti,
sum(u.agirlik) as toplam_bagis_agirligi,
round(avg(u.tahmini_deger), 2) as ortalama_urun_degeri,

(select round(avg(tahmini_deger), 2) from urun) as sistem_genel_deger_ortalamasi,

case 
	when count(bya.urun_id) > 10 then 'stratejik partner'
	when count(bya.urun_id) between 5 and 10 then 'aktif destekçi'
	else 'yeni bağışçı'
end as bagisci_statusu

from bagisci b
left join bagisci_kurumsal bk on b.bagisci_id = bk.bagisci_id
left join bagisci_bireysel bi on b.bagisci_id = bi.bagisci_id
join adres a on b.postakodu = a.postakodu
join bagis_yapar bya on b.bagisci_id = bya.bagisci_id
join urun u on bya.urun_id = u.urun_id
group by b.bagisci_id, bk.kurumismi, bi.ad, bi.soyad, a.sehir;


SELECT * FROM v_bagisci_analiz_paneli WHERE sehir = 'Ankara';



SELECT * FROM v_bagisci_analiz_paneli 
WHERE bagisci_statusu = 'stratejik partner';



INSERT INTO bagis_yapar (bagisci_id, urun_id, bagis_tarihi, miktar) VALUES
(4, 1, '2025-03-01', 5),
(4, 4, '2025-03-05', 2),
(4, 5, '2025-03-10', 10),
(4, 3, '2025-06-10', 10),
(4, 2, '2025-07-10', 10),
(4, 6, '2025-08-10', 10),
(4, 5, '2025-05-10', 10),
(4, 5, '2025-09-10', 10),
(4, 5, '2025-01-10', 10),
(4, 7, '2025-03-15', 3);