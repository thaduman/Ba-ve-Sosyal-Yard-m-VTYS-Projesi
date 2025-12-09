alter table bagis_yapar
drop constraint if exists bagis_yapar_bagisci_id_fkey;
-- isimli foreign key (dış anahtar) kısıtını siler.
--Bir tabloda bir foreign key kısıtı, başka bir tabloya bağlı olduğunuz anlamına gelir.
--Bu kısıtı kaldırmak, şu durumlarda işe yarar:
--Eğer artık ilgili tabloya bağlı olmasını istemiyorsan**
--Yanlış oluşturulmuş veya adını değiştirmek istediğin bir foreign key’i silmek istiyorsan
--Bağımlılıklar yüzünden veri silme/güncelleme hataları alıyorsan**
--Yeni bir foreign key tanımlamadan önce eskiyi kaldırmak istiyorsan
--**Ayrıca IF EXISTS kullanılması, eğer böyle bir constraint yoksa hata vermemesini sağlar.
--Yani komut güvenli çalışır.**



alter table bagis_yapar -- değişikliği bagis_yapar tablosundan yap
add constraint bagis_yapar_bagisci_id_fkey -- eklenecek foreign key adı
foreign key (bagisci_id) -- bagis_yapar tablosundaki bagisci_id kolono foreign key olacak.
references bagisci(bagisci_id) -- ilişki kurulacak tablo ve kolon
on delete cascade; -- bagisci silinirse ona ait bagis kayıtları da silinir.



drop table if exists bagisci_kurumsal;
-- bagisci_kurumsal tablosu varsa silinir, yoksa hata oluşmaz

create table bagisci_kurumsal (
bagisci_id int primary key 
references bagisci(bagisci_id) on delete cascade,
-- bagisci tablosuna bağlı; bagisci silinirse buradaki kayıt da silinir
kurumismi varchar(100)
);



create or replace function bagisci_seviyesi_belirle(id integer) 
-- Yeni fonksiyon oluşturur / mevcut fonksiyonu günceller
returns varchar
language plgsql
as -- Fonksiyonun kod bölümünün başladığını belirtir
$$ --Fonksiyonun gövdesini sınırlayan işaretler (çok satırlı string)
declare -- Fonksiyon içi yerel değişkenlerin tanımlandığı bölüm. Zorunlu değil
-- Eğer fonksiyon içindeki değişkenlere ihtiyacın yoksa yazmazsın.
	toplam_sayi integer; -- bağışçının toplam bağış sayısını tutacak değişken
	seviye varchar(50); -- döndürülecek bağışçı seviyesini tutacak değişken
begin
	select bagis_sayisi -- bagisci tablosundaki bağış sayısını al
	into toplam_sayi -- sonucu toplam_sayi değişkenine ata
	from bagisci
	where bagisci_id = id -- fonksiyona gönderilen id'li bağışçıyı seç

	if toplam_sayi >= 100 then
		seviye :='ALTIN BAĞIŞÇI';
	elseif toplam_sayi >= 50 then
		seviye := 'GÜMÜŞ BAĞIŞÇI';
	else
		seviye := 'BRONZ BAĞIŞÇI';
	END IF;
	RETURN seviye;
END;
$$;
	
/*
Burada “bagisci_seviyesi_belirle” adlı bir fonksiyon oluşturup parametresini “int” değer olarak
alıp “varchar” dönmesini sağladık. “Declare” komutu ile fonksiyonumuzda “toplam_sayi” ile
“seviye” adında iki tane değişken tanımladık. “Begin” komutu ile fonksiyonumuzun hangi
işlemleri yapacağı sağlanmıştır. En sonda “Return seviye;” komutu ile fonksiyonun geri
gönderdiği değer belirlenmiştir. Fonksiyonumuzun işlevi : “bagisci” tablosundan “bagissayisi”nı
alıp “toplam_sayi” değişkenine atayıp “if” bloklarıyla “toplam_sayi” değişkeni eğer 100 ve
üzeriyse “seviye” değişkenimizi “ALTIN BAĞIŞÇI” eğer “toplam_sayi” değişkeni 50 ile 99
arasında ise “seviye” değişkenimizi “GÜMÜŞ BAĞIŞÇI” eğer “toplam_sayi” değişkeni 50’nin
altında ise “seviye” değişkenimizi “BRONZ BAĞIŞÇI” bağışçı olarak sınıflandırılmış olup,
belirlenen bu değer “RETURN” komutuyla fonksiyon çıktısı olarak geri döndürülmüştür.
*/

	
