CREATE OR REPLACE FUNCTION bagisci_bagis_sayisi_guncelle()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE bagisci
    SET bagissayisi = bagissayisi + 1
    WHERE bagisci_id = NEW.bagisci_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER bagis_ekle_guncelle
AFTER INSERT ON bagis_yapar
FOR EACH ROW
EXECUTE FUNCTION bagisci_bagis_sayisi_guncelle();


INSERT INTO bagis_yapar (bagisci_id, urun_id, bagis_tarihi)
VALUES (1, 1, CURRENT_DATE);



SELECT bagisci_id, bagissayisi FROM bagisci WHERE bagisci_id = 1;

SELECT bagisci_id, bagissayisi FROM bagisci WHERE bagisci_id = 3;

INSERT INTO bagis_yapar (bagisci_id, urun_id, bagis_tarihi)
VALUES (3, 1, CURRENT_DATE);

SELECT bagisci_id, bagissayisi FROM bagisci WHERE bagisci_id = 3;