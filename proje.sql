create table adres (
    postakodu varchar(10) primary key,
    sehir varchar(50),
    ilce varchar(50),
    mahalle varchar(50),
    sokak varchar(50)
);

CREATE TABLE bagisci (
    bagisci_id SERIAL PRIMARY KEY,
    telefon TEXT[],     
    bagiscisayisi INT,
    postakodu VARCHAR(10) REFERENCES adres(postakodu)
);

CREATE TABLE bagisci_bireysel (
    bagisci_id INT PRIMARY KEY REFERENCES bagisci(bagisci_id),
    ad VARCHAR(50),
    soyad VARCHAR(50)
);


CREATE TABLE bagisci_kurumsal (
    bagisci_id INT PRIMARY KEY REFERENCES bagisci(bagisci_id),
    kurumismi VARCHAR(100)
);


CREATE TABLE alici (
    alici_id SERIAL PRIMARY KEY,
    telefon TEXT[],
    alinicaksayi INT,
    postakodu VARCHAR(10) REFERENCES adres(postakodu)
);

CREATE TABLE alici_bireysel (
    alici_id INT PRIMARY KEY REFERENCES alici(alici_id),
    ad VARCHAR(50),
    soyad VARCHAR(50)
);


CREATE TABLE alici_kurumsal (
    alici_id INT PRIMARY KEY REFERENCES alici(alici_id),
    kurumismi VARCHAR(100)
);


create table kategori (
	kategori_id serial primary key,
	kategori_adi varchar(100)
);

create table urun (
	urun_id serial primary key,
	ad varchar(100),
	birim varchar(20),
	agirlik numeric(10,2),
	tahmini_deger numeric(10,2),
	kategori_id int references kategori(kategori_id)
);

CREATE TABLE bagis_yapar (
    bagisci_id INT REFERENCES bagisci(bagisci_id),
    urun_id INT REFERENCES urun(urun_id),
    bagis_tarihi DATE,
    miktar INT,
    PRIMARY KEY (bagisci_id, urun_id, bagis_tarihi)
);

CREATE TABLE alir (
    alici_id INT REFERENCES alici(alici_id),
    urun_id INT REFERENCES urun(urun_id),
    alim_tarihi DATE,
    PRIMARY KEY (alici_id, urun_id, alim_tarihi)
);


CREATE TABLE depo (
    depo_id SERIAL PRIMARY KEY,
    depo_ismi VARCHAR(100),
    lokasyon VARCHAR(100),
    urun_total_miktar INT
);


CREATE TABLE depolanir (
    urun_id INT REFERENCES urun(urun_id),
    depo_id INT REFERENCES depo(depo_id),
    depolanma_miktari INT,
    denetim_tarihi DATE,
    PRIMARY KEY (urun_id, depo_id)
);


create table yonetici (
	yonetici_id serial primary key,
	ad varchar(30),
	soyad varchar(30)
);

CREATE TABLE dagitim (
    dagitim_id SERIAL PRIMARY KEY,
    dagitimsekli VARCHAR(50),
    ulasacagi_yer VARCHAR(150),
    sure INT
);

CREATE TABLE dagitilir (
    urun_id INT REFERENCES urun(urun_id),
    dagitim_id INT REFERENCES dagitim(dagitim_id),
    PRIMARY KEY (urun_id, dagitim_id)
);



create table yonetir (
	yonetici_id int references yonetici(yonetici_id),
	depo_id int references depo(depo_id),
	denetim_tarihi date, 
	primary key (yonetici_id, depo_id) 
);


INSERT INTO adres VALUES
('44000','Malatya','Yeşilyurt','Çavuşoğlu','Gül Sokak'),
('34100','İstanbul','Bakırköy','Zeytinlik','Çınar Sk.'),
('06000','Ankara','Çankaya','Kavaklıdere','Atatürk Blv'),
('35000','İzmir','Konak','Alsancak','Kıbrıs Şehitleri'),
('01000','Adana','Seyhan','Reşatbey','Baraj Yolu'),
('07000','Antalya','Muratpaşa','Güzeloba','Lara Cad'),
('25000','Erzurum','Yakutiye','Rabia Ana','Kazım Karabekir'),
('21000','Diyarbakır','Yenişehir','Ofis','İstasyon Cad'),
('16000','Bursa','Nilüfer','Beşevler','FSM Bulvarı'),
('55000','Samsun','Atakum','Cumhuriyet','İnönü Cad');


INSERT INTO bagisci (telefon, bagiscisayisi, postakodu) VALUES
(ARRAY['05071234567'],'2','44000'),
(ARRAY['05381231212'],'1','34100'),
(ARRAY['05554443322','05071234567'],'3','06000'),
(ARRAY['05367778899'],'1','35000'),
(ARRAY['05467778899'],'2','01000'),
(ARRAY['05051231212'],'1','07000'),
(ARRAY['05064564564'],'1','25000'),
(ARRAY['05436665544'],'2','21000'),
(ARRAY['05324443322'],'1','16000'),
(ARRAY['05079998877'],'1','55000');

INSERT INTO bagisci_bireysel VALUES
(1,'Ahmet','Yılmaz'),
(2,'Mehmet','Kaya'),
(3,'Ayşe','Kılıç'),
(4,'Fatma','Demir'),
(5,'Emre','Koç'),
(6,'Melike','Arslan');

INSERT INTO bagisci_kurumsal VALUES
(7,'Duman Gıda A.Ş.'),
(8,'Kocaağa İnşaat'),
(9,'Doğu Lojistik'),
(10,'Yeşil Tarım Ltd');


INSERT INTO alici (telefon, alinicaksayi, postakodu) VALUES
(ARRAY['05075554433'], 2,'44000'),
(ARRAY['05323334455'], 1,'34100'),
(ARRAY['05449998877','05073331212'],3,'06000'),
(ARRAY['05362223344'],1,'35000'),
(ARRAY['05123334455'],2,'01000'),
(ARRAY['05551112233'],1,'07000'),
(ARRAY['05345677889'],3,'25000'),
(ARRAY['05070001122'],1,'21000'),
(ARRAY['05469998877'],1,'16000'),
(ARRAY['05390001144'],1,'55000');

INSERT INTO alici_bireysel VALUES
(1,'Hasan','Duman'),
(2,'Büşra','Tekin'),
(3,'Seda','Acar'),
(4,'Selin','Çelik'),
(5,'Baran','Yurt'),
(6,'Zehra','Polat');

INSERT INTO alici_kurumsal VALUES
(7,'Erdem Market'),
(8,'Güneydoğu Yardım Derneği'),
(9,'Yeni Hayat Vakfı'),
(10,'Işık Sosyal Destek');

INSERT INTO kategori (kategori_adi) VALUES
('Gıda'),
('Temizlik'),
('Kıyafet'),
('Elektronik'),
('Kırtasiye'),
('Oyuncak'),
('Mobilya'),
('Hijyen'),
('Isıtıcı'),
('Mutfak');

INSERT INTO urun (ad, birim, agirlik, tahmini_deger, kategori_id) VALUES
('Pirinç', 'kg', 5.0, 150, 1),
('Şeker', 'kg', 3.0, 90, 1),
('Tişört', 'adet', 0.3, 120, 3),
('Mont', 'adet', 1.2, 600, 3),
('Defter', 'adet', 0.5, 30, 5),
('Oyuncak Araba', 'adet', 0.4, 80, 6),
('Sıvı Sabun', 'adet', 1.0, 40, 2),
('Tencere', 'adet', 2.0, 250, 10),
('Battaniye', 'adet', 2.5, 300, 7),
('Isıtıcı', 'adet', 3.0, 700, 9);

INSERT INTO bagis_yapar VALUES
(1, 1, '2025-01-05', 10),
(2, 3, '2025-02-10', 5),
(3, 2, '2025-01-20', 7),
(4, 4, '2025-03-01', 2),
(5, 5, '2025-02-15', 15),
(6, 6, '2025-01-28', 3),
(7, 7, '2025-03-05', 12),
(8, 8, '2025-02-05', 4),
(9, 9, '2025-03-10', 6),
(10, 10, '2025-01-18', 1);

INSERT INTO alir VALUES
(1, 1, '2025-03-15'),
(2, 2, '2025-03-18'),
(3, 3, '2025-03-20'),
(4, 4, '2025-03-22'),
(5, 5, '2025-03-25'),
(6, 6, '2025-03-27'),
(7, 7, '2025-03-29'),
(8, 8, '2025-03-30'),
(9, 9, '2025-04-01'),
(10,10,'2025-04-03');

INSERT INTO depo (depo_ismi, lokasyon, urun_total_miktar) VALUES
('Merkez Depo', 'Malatya', 500),
('İstanbul Depo', 'İstanbul', 700),
('Ankara Depo', 'Ankara', 650),
('İzmir Depo', 'İzmir', 400),
('Adana Depo', 'Adana', 550),
('Antalya Depo', 'Antalya', 350),
('Erzurum Depo', 'Erzurum', 300),
('Diyarbakır Depo', 'Diyarbakır', 450),
('Bursa Depo', 'Bursa', 520),
('Samsun Depo', 'Samsun', 480);

INSERT INTO depolanir VALUES
(1,1,200,'2025-01-10'),
(2,2,150,'2025-01-12'),
(3,3,120,'2025-01-15'),
(4,4,80,'2025-01-18'),
(5,5,300,'2025-02-01'),
(6,6,50,'2025-02-05'),
(7,7,40,'2025-02-10'),
(8,8,90,'2025-02-12'),
(9,9,110,'2025-02-20'),
(10,10,30,'2025-02-25');

INSERT INTO yonetici (ad, soyad) VALUES
('Ali', 'Yıldırım'),
('Mehmet', 'Çetin'),
('Ayşe', 'Uslu'),
('Fatih', 'Koç'),
('Merve', 'Demirtaş'),
('Hakan', 'Doğan'),
('Esra', 'Atak'),
('Burak', 'Sezer'),
('İrem', 'Kaplan'),
('Kaan', 'Torun');

INSERT INTO dagitim (dagitimsekli, ulasacagi_yer, sure) VALUES
('Araç', 'Yeşilyurt', 30),
('Araç', 'Battalgazi', 25),
('Yaya', 'Çavuşoğlu', 10),
('Araç', 'Doğanşehir', 50),
('Kargo', 'İstanbul', 720),
('Kargo', 'Ankara', 600),
('Araç', 'Beydağı', 20),
('Yaya', 'Tecde', 15),
('Araç', 'Orduzu', 18),
('Kargo', 'İzmir', 900);

INSERT INTO dagitilir VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

INSERT INTO yonetir VALUES
(1,1,'2025-01-01'),
(2,2,'2025-01-02'),
(3,3,'2025-01-03'),
(4,4,'2025-01-04'),
(5,5,'2025-01-05'),
(6,6,'2025-01-06'),
(7,7,'2025-01-07'),
(8,8,'2025-01-08'),
(9,9,'2025-01-09'),
(10,10,'2025-01-10');
