-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost:8889
-- Üretim Zamanı: 05 Ara 2023, 15:10:29
-- Sunucu sürümü: 5.7.39
-- PHP Sürümü: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `Botanik_ve_Herbalist`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bitki`
--

CREATE TABLE `bitki` (
  `bitki_id` int(11) NOT NULL,
  `bitki_yetistirme_kosul` varchar(255) DEFAULT NULL,
  `bitki_adi` varchar(255) DEFAULT NULL,
  `bitki_degeri` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `bitki`
--

INSERT INTO `bitki` (`bitki_id`, `bitki_yetistirme_kosul`, `bitki_adi`, `bitki_degeri`) VALUES
(1, 'nemli ortam,yüksek rakım,kireçli toprak', 'Kasnak Meşesi', 15000),
(2, 'nemli ortam,çayır', 'Anadolu Glayölü', 2150),
(3, 'su kenarı,taşlı kum', 'Kazdağı Göknarı', 1800),
(4, 'yüksek rakım', 'Ters Lale', 2000),
(5, 'tuzlu toprak', 'Tuzcul kirpidikeni', 4300),
(6, 'kurak toprak', 'Sahil sığırkuyruğu', 1600),
(7, 'sıcak iklim', 'Toros göknarı', 1700),
(8, 'sıcak iklim', 'Yılkıkulak', 2150),
(9, 'ılıman iklim,bozkır', 'Psephellus aucherianus', 20000),
(10, 'kayalık bölge,nemli ortam', 'Uludağ Çöveni', 6700),
(16, 'gübreli ve nemli toprak', 'Papatya', 150);

--
-- Tetikleyiciler `bitki`
--
DELIMITER $$
CREATE TRIGGER `bitki_ekleme_trigger` AFTER INSERT ON `bitki` FOR EACH ROW BEGIN
  INSERT INTO guncel_bitki_ekleme (bitki_id, eklenme_tarihi)
  VALUES (NEW.bitki_id, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bitki_tur`
--

CREATE TABLE `bitki_tur` (
  `tür_id` int(11) DEFAULT NULL,
  `bitki_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `bitki_tur`
--

INSERT INTO `bitki_tur` (`tür_id`, `bitki_id`) VALUES
(1, 1),
(3, 2),
(11, 3),
(3, 4),
(9, 5),
(6, 6),
(10, 7),
(11, 8),
(3, 9),
(3, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bölgeler`
--

CREATE TABLE `bölgeler` (
  `bölge_id` int(11) NOT NULL,
  `bölge_adi` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `bölgeler`
--

INSERT INTO `bölgeler` (`bölge_id`, `bölge_adi`) VALUES
(1, 'Akdeniz Bölgesi'),
(2, 'Ege Bölgesi'),
(3, 'Doğu Anadolu Bölgesi'),
(4, 'Güneydoğu Anadolu Bölgesi'),
(5, 'İç Anadolu Bölgesi'),
(6, 'Marmara Bölgesi'),
(7, 'Karadeniz Bölgesi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bölge_bitki`
--

CREATE TABLE `bölge_bitki` (
  `bölge_id` int(11) DEFAULT NULL,
  `bitki_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `bölge_bitki`
--

INSERT INTO `bölge_bitki` (`bölge_id`, `bitki_id`) VALUES
(2, 1),
(5, 2),
(6, 3),
(3, 4),
(5, 5),
(1, 6),
(4, 7),
(6, 8),
(3, 9),
(6, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bölge_herbalist`
--

CREATE TABLE `bölge_herbalist` (
  `bölge_id` int(11) DEFAULT NULL,
  `herbalist_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `bölge_herbalist`
--

INSERT INTO `bölge_herbalist` (`bölge_id`, `herbalist_id`) VALUES
(1, 1),
(4, 2),
(7, 3),
(2, 4),
(3, 5),
(5, 6),
(6, 7),
(5, 8),
(2, 9),
(3, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bölge_tas`
--

CREATE TABLE `bölge_tas` (
  `tas_id` int(11) DEFAULT NULL,
  `bölge_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `bölge_tas`
--

INSERT INTO `bölge_tas` (`tas_id`, `bölge_id`) VALUES
(2, 7),
(3, 1),
(4, 6),
(5, 2),
(6, 4),
(7, 5),
(8, 4),
(9, 2),
(10, 1),
(2, 7),
(3, 1),
(4, 6),
(5, 2),
(6, 4),
(7, 5),
(8, 4),
(9, 2),
(10, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `guncel_bitki_ekleme`
--

CREATE TABLE `guncel_bitki_ekleme` (
  `guncel_bitki_id` int(11) NOT NULL,
  `bitki_id` int(11) DEFAULT NULL,
  `eklenme_tarihi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `guncel_bitki_ekleme`
--

INSERT INTO `guncel_bitki_ekleme` (`guncel_bitki_id`, `bitki_id`, `eklenme_tarihi`) VALUES
(1, 15, '2023-12-04 18:26:55'),
(2, 16, '2023-12-04 18:29:08');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `guncel_tas_ekleme`
--

CREATE TABLE `guncel_tas_ekleme` (
  `log_id` int(11) NOT NULL,
  `tas_id` int(11) DEFAULT NULL,
  `eklenme_tarihi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `guncel_tas_ekleme`
--

INSERT INTO `guncel_tas_ekleme` (`log_id`, `tas_id`, `eklenme_tarihi`) VALUES
(1, 14, '2023-12-04 18:46:30');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `herbalist`
--

CREATE TABLE `herbalist` (
  `herbalist_id` int(11) NOT NULL,
  `herbalist_adi` varchar(150) DEFAULT NULL,
  `herbalist_soyadi` varchar(150) DEFAULT NULL,
  `herbalist_tel` varchar(15) DEFAULT NULL,
  `herbalist_tc` varchar(11) DEFAULT NULL,
  `herbalist_tarih` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `herbalist`
--

INSERT INTO `herbalist` (`herbalist_id`, `herbalist_adi`, `herbalist_soyadi`, `herbalist_tel`, `herbalist_tc`, `herbalist_tarih`) VALUES
(1, 'irfan', 'tekirdağ', '545778288', '12341245', '2020-01-01'),
(2, 'Veli', 'Sönmez', '5678904523', '56278909123', '2023-11-29'),
(3, 'Ayşe', 'Katarlı', '3473204513', '56209909123', '2022-06-19'),
(4, 'Hüseyin', 'İpek', '5328907303', '56205209123', '2021-05-01'),
(5, 'Burak', 'Evrentuğ', '1238760923', '6578901245', '2020-02-16'),
(6, 'Veli', 'Sönmez', '5678904523', '56278909123', '2023-11-29'),
(7, 'Emre', 'Kısakulak', '7658206792', '10293847532', '2021-09-25'),
(8, 'Haşmet', 'Kirli', '5324567801', '98745609123', '2023-04-10'),
(9, 'Ali', 'Uslu', '453786340912', '56271100923', '2023-06-10'),
(10, 'Ramazan', 'Yıldırım', '0981236788', '55589900452', '2023-09-16');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `taslar`
--

CREATE TABLE `taslar` (
  `tas_id` int(11) NOT NULL,
  `tas_adi` varchar(255) DEFAULT NULL,
  `tas_degeri` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `taslar`
--

INSERT INTO `taslar` (`tas_id`, `tas_adi`, `tas_degeri`) VALUES
(1, 'Tanzanit Tası', 150),
(2, 'Siyah Opal', 9500),
(3, 'Kırmızı Beril', 10000),
(4, 'Musgravit', 35000),
(5, 'Aleksandrit', 70000),
(6, 'Zümrüt', 305000),
(7, 'Yakut', 1800000),
(8, 'Pembe Elmas', 1900000),
(9, 'Jadeit', 3000000),
(10, 'Mavi Elmas', 3930000),
(11, 'Çakıl Taşı', 100),
(12, 'Çakmak Taşı', 250),
(13, 'Çakmak Taşı', 250),
(14, 'Kum taşı', 75);

--
-- Tetikleyiciler `taslar`
--
DELIMITER $$
CREATE TRIGGER `tas_ekleme_trigger` AFTER INSERT ON `taslar` FOR EACH ROW BEGIN
  INSERT INTO guncel_tas_ekleme (tas_id)
  VALUES (NEW.tas_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tas_guncelleme_trigger` AFTER UPDATE ON `taslar` FOR EACH ROW BEGIN
IF NEW.tas_degeri <> OLD.tas_degeri THEN INSERT INTO tas_guncelleme (tas_id, yeni_deger)
VALUES (NEW.tas_id, NEW.tas_degeri);
END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tas_silme_trigger` AFTER DELETE ON `taslar` FOR EACH ROW BEGIN
  INSERT INTO silinen_taslar (tas_id)
  VALUES (OLD.tas_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tas_guncelleme`
--

CREATE TABLE `tas_guncelleme` (
  `tas_guncelleme_id` int(11) NOT NULL,
  `tas_id` int(11) DEFAULT NULL,
  `yeni_deger` varchar(255) DEFAULT NULL,
  `guncellenme_tarihi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `tas_guncelleme`
--

INSERT INTO `tas_guncelleme` (`tas_guncelleme_id`, `tas_id`, `yeni_deger`, `guncellenme_tarihi`) VALUES
(1, 1, '150', '2023-12-04 18:35:20');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `tas_tur`
--

CREATE TABLE `tas_tur` (
  `tür_id` int(11) DEFAULT NULL,
  `tas_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `tas_tur`
--

INSERT INTO `tas_tur` (`tür_id`, `tas_id`) VALUES
(15, 1),
(14, 2),
(16, 3),
(14, 4),
(16, 5),
(15, 6),
(15, 7),
(14, 8),
(14, 9),
(16, 10);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `turler`
--

CREATE TABLE `turler` (
  `tür_id` int(11) NOT NULL,
  `tür_adi` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `turler`
--

INSERT INTO `turler` (`tür_id`, `tür_adi`) VALUES
(1, 'çiçekli bitki'),
(2, 'kozalaklı bitkiler'),
(3, 'açık tohumlu bitkiler'),
(4, 'eğrelti otu'),
(5, 'Kırmızı algler'),
(6, 'tek çenekli bitki'),
(7, 'kozalaklı bitkiler'),
(8, 'açık tohumlu bitkiler'),
(9, 'eğrelti otu'),
(10, 'Kırmızı algler'),
(11, 'kapalı tohumlu bitki'),
(14, 'kimyasal taşlar'),
(15, 'organik taşlar'),
(16, 'tortul taşlar');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `bitki`
--
ALTER TABLE `bitki`
  ADD PRIMARY KEY (`bitki_id`);

--
-- Tablo için indeksler `bitki_tur`
--
ALTER TABLE `bitki_tur`
  ADD KEY `bitki_id` (`bitki_id`),
  ADD KEY `tür_id` (`tür_id`);

--
-- Tablo için indeksler `bölgeler`
--
ALTER TABLE `bölgeler`
  ADD PRIMARY KEY (`bölge_id`);

--
-- Tablo için indeksler `bölge_bitki`
--
ALTER TABLE `bölge_bitki`
  ADD KEY `bölge_id` (`bölge_id`),
  ADD KEY `fk_bölge_bitki` (`bitki_id`);

--
-- Tablo için indeksler `bölge_herbalist`
--
ALTER TABLE `bölge_herbalist`
  ADD KEY `fk_bölge_herbalist_bölge_id` (`bölge_id`),
  ADD KEY `fk_bölge_herbalist_herbalist_id` (`herbalist_id`);

--
-- Tablo için indeksler `bölge_tas`
--
ALTER TABLE `bölge_tas`
  ADD KEY `fk_bölge_tas_tas_id` (`tas_id`),
  ADD KEY `fk_bölge_tas_bölge_id` (`bölge_id`);

--
-- Tablo için indeksler `guncel_bitki_ekleme`
--
ALTER TABLE `guncel_bitki_ekleme`
  ADD PRIMARY KEY (`guncel_bitki_id`);

--
-- Tablo için indeksler `guncel_tas_ekleme`
--
ALTER TABLE `guncel_tas_ekleme`
  ADD PRIMARY KEY (`log_id`);

--
-- Tablo için indeksler `herbalist`
--
ALTER TABLE `herbalist`
  ADD PRIMARY KEY (`herbalist_id`);

--
-- Tablo için indeksler `taslar`
--
ALTER TABLE `taslar`
  ADD PRIMARY KEY (`tas_id`);

--
-- Tablo için indeksler `tas_guncelleme`
--
ALTER TABLE `tas_guncelleme`
  ADD PRIMARY KEY (`tas_guncelleme_id`);

--
-- Tablo için indeksler `tas_tur`
--
ALTER TABLE `tas_tur`
  ADD KEY `fk_tas_tur` (`tür_id`),
  ADD KEY `fk_tas_tur_tas_id` (`tas_id`);

--
-- Tablo için indeksler `turler`
--
ALTER TABLE `turler`
  ADD PRIMARY KEY (`tür_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `bitki`
--
ALTER TABLE `bitki`
  MODIFY `bitki_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Tablo için AUTO_INCREMENT değeri `bölgeler`
--
ALTER TABLE `bölgeler`
  MODIFY `bölge_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Tablo için AUTO_INCREMENT değeri `guncel_bitki_ekleme`
--
ALTER TABLE `guncel_bitki_ekleme`
  MODIFY `guncel_bitki_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `guncel_tas_ekleme`
--
ALTER TABLE `guncel_tas_ekleme`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `herbalist`
--
ALTER TABLE `herbalist`
  MODIFY `herbalist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Tablo için AUTO_INCREMENT değeri `taslar`
--
ALTER TABLE `taslar`
  MODIFY `tas_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Tablo için AUTO_INCREMENT değeri `tas_guncelleme`
--
ALTER TABLE `tas_guncelleme`
  MODIFY `tas_guncelleme_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `turler`
--
ALTER TABLE `turler`
  MODIFY `tür_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `bitki_tur`
--
ALTER TABLE `bitki_tur`
  ADD CONSTRAINT `bitki_tur_ibfk_1` FOREIGN KEY (`bitki_id`) REFERENCES `bitki` (`bitki_id`),
  ADD CONSTRAINT `bitki_tur_ibfk_2` FOREIGN KEY (`tür_id`) REFERENCES `turler` (`tür_id`),
  ADD CONSTRAINT `bitki_tur_ibfk_3` FOREIGN KEY (`tür_id`) REFERENCES `turler` (`tür_id`);

--
-- Tablo kısıtlamaları `bölge_bitki`
--
ALTER TABLE `bölge_bitki`
  ADD CONSTRAINT `bölge_bitki_ibfk_1` FOREIGN KEY (`bölge_id`) REFERENCES `bölgeler` (`bölge_id`),
  ADD CONSTRAINT `fk_bölge_bitki` FOREIGN KEY (`bitki_id`) REFERENCES `bitki` (`bitki_id`);

--
-- Tablo kısıtlamaları `bölge_herbalist`
--
ALTER TABLE `bölge_herbalist`
  ADD CONSTRAINT `fk_bölge_herbalist_bölge_id` FOREIGN KEY (`bölge_id`) REFERENCES `bölgeler` (`bölge_id`),
  ADD CONSTRAINT `fk_bölge_herbalist_herbalist_id` FOREIGN KEY (`herbalist_id`) REFERENCES `herbalist` (`herbalist_id`);

--
-- Tablo kısıtlamaları `bölge_tas`
--
ALTER TABLE `bölge_tas`
  ADD CONSTRAINT `fk_bölge_tas_bölge_id` FOREIGN KEY (`bölge_id`) REFERENCES `bölgeler` (`bölge_id`),
  ADD CONSTRAINT `fk_bölge_tas_tas_id` FOREIGN KEY (`tas_id`) REFERENCES `taslar` (`tas_id`);

--
-- Tablo kısıtlamaları `tas_tur`
--
ALTER TABLE `tas_tur`
  ADD CONSTRAINT `fk_tas_tur` FOREIGN KEY (`tür_id`) REFERENCES `turler` (`tür_id`),
  ADD CONSTRAINT `fk_tas_tur_tas_id` FOREIGN KEY (`tas_id`) REFERENCES `taslar` (`tas_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
