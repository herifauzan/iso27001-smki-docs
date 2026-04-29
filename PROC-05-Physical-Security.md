# PROSEDUR KEAMANAN FISIK
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROSEDUR KEAMANAN FISIK
**Dokumen ID:** PROC-05
**Versi:** 1.0  
**Tanggal Berlaku:** 15 April 2026  
**Status:** Final  
**Tingkat Keamanan:** Confidential

## Lembar Pengesahan

| Jabatan | Nama | Tanda Tangan | Tanggal |
|---------|------|-------------|--------|
| Direktur Operasional / COO | Dodi Darundriyo |   |   |
| Manajer Keamanan Informasi (ISM) | Heri Fauzan |   |   |
| Manajer Fasilitas |  |  |  |


## Daftar Isi

- [1. Pendahuluan](#1-pendahuluan)
- [2. Prosedur Utama](#2-prosedur-utama)
- [3. Formulir dan Template](#3-formulir-dan-template)
- [4. Kontrol dan Pemantauan](#4-kontrol-dan-pemantauan)
- [5. Pemenuhan Standar](#5-pemenuhan-standar)
- [6. Tanggung Jawab](#6-tanggung-jawab)
- [7. Tinjauan dan Pembaruan](#7-tinjauan-dan-pembaruan)
- [8. Lampiran](#8-lampiran)


## 1. Pendahuluan

Prosedur ini mengatur keamanan fisik fasilitas PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001. Prosedur ini mencakup kontrol akses fisik, pemantauan lingkungan, serta perlindungan terhadap aset fisik organisasi untuk mencegah akses tidak sah, pencurian, dan kerusakan.

### 1.1 Tujuan

- Melindungi aset fisik perusahaan dari akses yang tidak sah
- Mencegah kerusakan atau pencurian peralatan IT dan aset informasi
- Memastikan lingkungan kerja yang aman bagi seluruh personel
- Memenuhi persyaratan keamanan fisik yang komprehensif sesuai standar keamanan informasi

### 1.2 Ruang Lingkup

Prosedur ini berlaku untuk seluruh lokasi fisik perusahaan, termasuk:

- Kantor pusat dan kantor cabang
- Ruang server dan pusat data (data center)
- Area kerja karyawan
- Area publik dan area penerimaan pengunjung
- Lokasi kerja jarak jauh (remote sites) dan lingkungan kerja dari rumah

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (GOV-POL-TK3I), khususnya Area 7: Keamanan Fisik & Lingkungan


## 2. Prosedur Utama

### 2.1 Prosedur Kontrol Akses Fisik

#### Akses Bangunan:

1. **Registrasi Pengunjung** (Security Officer - Saat kedatangan)

   - Memverifikasi identitas pengunjung dengan KTP atau SIM
   - Mengisi log pengunjung (Form-PS-01) dengan lengkap
   - Menerbitkan kartu akses sementara jika diperlukan untuk mengakses area tertentu

2. **Akses Karyawan** (HR/Security - Saat proses penerimaan karyawan)

   - Mengambil foto untuk pembuatan kartu identitas dan kartu akses
   - Memprogram kartu akses sesuai dengan peran dan area kerja karyawan
   - Memberikan pelatihan mengenai penggunaan sistem akses gedung

3. **Pembaruan Berkala Hak Akses Fisik** (Security Officer - Setiap triwulan)

   - Meninjau daftar seluruh pemegang kartu akses aktif setiap 3 bulan
   - Memverifikasi apakah hak akses masih sesuai dengan peran karyawan saat ini
   - Mencabut atau menyesuaikan akses yang sudah tidak relevan akibat perubahan jabatan, transfer departemen, atau pemutusan hubungan kerja
   - Mendokumentasikan hasil tinjauan dalam Log Tinjauan Akses Fisik (Log-PS-02)

3. **Pemantauan Akses** (Security Officer - Berkelanjutan)

   - Memantau CCTV selama 24 jam setiap hari, 7 hari seminggu
   - Mencatat seluruh aktivitas masuk dan keluar dalam log akses
   - Mengirimkan peringatan otomatis ketika terdeteksi akses yang tidak sah

#### Akses Area Sensitif:

1. **Akses Ruang Server** (IT Security - Terbatas)

   - Akses hanya diberikan kepada personel yang berwenang dan terdaftar
   - Menggunakan otentikasi ganda (kartu akses + PIN) untuk masuk
   - Menerapkan sistem mantrap untuk area dengan keamanan tertinggi

2. **Akses Pusat Data (Data Center)** (IT Security - Terbatas)

   - Otorisasi terlebih dahulu (pre-authorization) wajib diperoleh sebelum akses
   - Pengunjung wajib didampingi oleh personel berwenang selama berada di area
   - Seluruh aktivitas akses dicatat secara lengkap dalam log audit

### 2.2 Prosedur Pengamanan Peralatan

#### Keamanan Workstation:

1. **Kebijakan Penguncian Layar** (Seluruh Karyawan - Selalu)

   - Mengunci layar setiap kali meninggalkan workstation
   - Mengaktifkan penguncian otomatis setelah 5 menit tanpa aktivitas
   - Tidak meninggalkan perangkat tanpa pengawasan di area publik

2. **Keamanan Perangkat Mobile** (IT Security - Saat penerbitan perangkat)

   - Mengaktifkan enkripsi pada seluruh perangkat mobile
   - Menginstal MDM (Mobile Device Management) untuk pengelolaan jarak jauh
   - Memastikan tersedianya kemampuan penghapusan data jarak jauh (remote wipe)

3. **Peralatan Portabel** (IT Operations - Saat peminjaman)

   - Mengisi formulir peminjaman peralatan (Form-PS-02)
   - Melacak lokasi dan kondisi peralatan selama masa peminjaman
   - Melakukan pemeriksaan kondisi saat pengembalian sebelum tenggat waktu

#### Keamanan Ruang Server:

1. **Kontrol Lingkungan** (Tim Fasilitas - Berkelanjutan)

   - Mempertahankan suhu ruangan pada rentang 18-24Â°C
   - Mempertahankan kelembapan pada rentang 40-60%
   - Memastikan sistem pemadaman kebakaran berfungsi dengan baik
   - Memastikan ketersediaan UPS dan generator cadangan

2. **Kontrol Akses** (Security Officer - Berkelanjutan)

   - Melakukan pemantauan selama 24 jam setiap hari, 7 hari seminggu
   - Memelihara daftar akses terbatas (restricted access list)
   - Menyiapkan prosedur akses darurat untuk situasi tertentu

### 2.3 Prosedur Respons Insiden Fisik

#### Respons Pencurian/Kehilangan:

1. **Respons Segera** (Security Officer - Segera)

   - Mengamankan area yang terdampak
   - Menghubungi kepolisian jika terjadi pencurian
   - Menilai tingkat kerusakan dan potensi paparan data

2. **Penyelidikan** (Tim Keamanan - Kurang dari 24 jam)

   - Meninjau rekaman CCTV yang relevan
   - Mewawancarai saksi-saksi yang terkait
   - Mendokumentasikan seluruh temuan penyelidikan

3. **Pemulihan** (IT Operations - Segera)

   - Memulihkan data dari backup jika terjadi kehilangan data
   - Mengganti peralatan yang hilang atau rusak
   - Memperbarui langkah-langkah pengamanan berdasarkan temuan

#### Respons Darurat:

1. **Alarm Kebakaran** (Seluruh Personel - Segera)

   - Melakukan evakuasi sesuai jalur darurat yang telah ditetapkan
   - Melakukan penghitungan kepala (head count) di titik kumpul
   - Menunggu konfirmasi situasi aman dari petugas keamanan

2. **Darurat Medis** (Tim Pertolongan Pertama - Segera)

   - Menghubungi ambulans (118 atau 119)
   - Memberikan pertolongan pertama sesuai pelatihan yang diterima
   - Mendampingi korban ke fasilitas medis terdekat

3. **Pelanggaran Keamanan Fisik** (Security Officer - Segera)

   - Memberlakukan penguncian (lockdown) pada area yang terdampak
   - Memberitahu manajemen mengenai situasi yang terjadi
   - Berkoordinasi dengan kepolisian jika diperlukan

### 2.4 Prosedur Pemeliharaan dan Inspeksi

#### Inspeksi Rutin:

1. **Pemeriksaan Harian** (Security Officer - Setiap hari)

   - Memeriksa seluruh titik akses (pintu, gerbang) untuk memastikan keamanannya
   - Memverifikasi bahwa sistem CCTV berfungsi dengan baik
   - Memeriksa kelengkapan dan kesiapan peralatan darurat

2. **Inspeksi Mingguan** (Tim Fasilitas - Setiap minggu)

   - Menguji sistem alarm kebakaran
   - Memeriksa kondisi UPS dan generator cadangan
   - Menginspeksi seluruh perangkat keamanan fisik

3. **Audit Bulanan** (Tim Keamanan - Setiap bulan)

   - Meninjau log akses untuk mengidentifikasi anomali
   - Menguji sistem backup dan pemulihan
   - Mengaudit log pengunjung untuk memastikan kepatuhan

#### Jadwal Pemeliharaan:

- Sistem CCTV: Servis setiap bulan
- Sistem kontrol akses: Servis setiap triwulan
- Sistem pemadaman kebakaran: Inspeksi setiap tahun
- UPS/Generator: Pengujian setiap bulan

### 2.5 Prosedur Kerja dari Rumah (Work from Home)

#### Persiapan Kerja dari Rumah:

1. **Proses Persetujuan** (Manajer - Sebelum WFH dimulai)

   - Menyampaikan justifikasi bisnis untuk kebutuhan kerja dari rumah
   - Melakukan penilaian risiko keamanan terhadap lingkungan kerja dari rumah
   - Memperoleh persetujuan dari IT Security sebelum akses jarak jauh diaktifkan

2. **Pengaturan Lingkungan Kerja** (IT Operations - Saat persiapan)

   - Memastikan koneksi WiFi aman dengan enkripsi WPA3
   - Menginstal klien VPN pada perangkat karyawan
   - Mengonfigurasi workstation dengan kontrol keamanan yang sesuai

3. **Persyaratan Keamanan** (Karyawan - Selama WFH)

   - Mengunci perangkat saat tidak digunakan
   - Menyimpan dokumen kerja di tempat yang aman dan terkunci
   - Melakukan backup data secara rutin

#### Pemantauan Kerja dari Rumah:

1. **Pemantauan Akses** (IT Security - Berkelanjutan)

   - Memantau log koneksi VPN secara kontinu
   - Memantau kondisi dan keamanan perangkat
   - Mengirimkan peringatan jika terdeteksi aktivitas yang tidak biasa

2. **Pemeriksaan Berkala** (Manajer - Mingguan)

   - Melakukan pertemuan virtual untuk memastikan kelangsungan kerja
   - Memantau produktivitas dan kepatuhan terhadap kebijakan keamanan
   - Memverifikasi kepatuhan terhadap persyaratan keamanan yang berlaku


## 3. Formulir dan Template

### Form-PS-01: Log Pengunjung
```
Tanggal: __________________________
Nama Pengunjung: __________________
Perusahaan: _______________________
Tujuan Kunjungan: _________________
Pihak yang Dikunjungi: ____________

Waktu Masuk: _____________________
Waktu Keluar: ____________________

Kartu Akses Diterbitkan: □ Ya □ Tidak
Nomor Kartu: _____________________

Catatan: __________________________
__________________________________

Security Officer: _________________
Tanda Tangan: ____________________
```

### Form-PS-02: Peminjaman Peralatan
```
ID Peminjaman: ____________________
Tanggal: __________________________
Peminjam: _________________________
Departemen: _______________________

Peralatan:
□ Laptop □ Perangkat Mobile □ Proyektor □ Lainnya: _____
Nomor Seri: ______________________
Aksesori: ________________________

Tujuan: ___________________________
Lokasi Penggunaan: ________________
Tanggal Pengembalian: _____________

Persetujuan:
___________________________
Manajer Departemen
Tanggal: __________

Kondisi Saat Peminjaman: __________
___________________________

Kondisi Saat Pengembalian: ________
___________________________

Diterima Oleh: ___________________
Tanggal: __________
```

### Daftar Periksa-PS-01: Daftar Periksa Keamanan Harian
```
Tanggal: __________________________
Security Officer: _________________

□ Seluruh pintu utama dalam keadaan terkunci
□ Sistem CCTV beroperasi dengan normal
□ Sistem kontrol akses berfungsi dengan baik
□ Jalur darurat tidak terhalang
□ Alat pemadam kebakaran tersedia di tempatnya
□ Akses ruang server dalam keadaan aman
□ Log pengunjung telah diperbarui
□ Aktivitas mencurigakan telah dilaporkan

Catatan: __________________________
__________________________________
```


## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Akses Berlapis**: Kartu akses + PIN + biometrik untuk area sensitif
- **Pemantauan 24/7**: Sistem CCTV dengan penyimpanan rekaman selama 30 hari
- **Sensor Lingkungan**: Sensor suhu, kelembapan, dan detektor asap yang terintegrasi
- **Sistem Darurat**: Alarm kebakaran, sprinkler, dan pencahayaan darurat yang berfungsi

### 4.2 Pemantauan dan Audit

- Pemantauan CCTV secara real-time dari pusat keamanan
- Peringatan otomatis untuk kegagalan sistem keamanan
- Audit keamanan fisik dilaksanakan setiap bulan
- Pengujian penetrasi keamanan fisik dilaksanakan setiap tahun

### 4.3 Pelaporan Insiden

- Intrusi fisik: Respons dalam waktu 2 menit
- Pencurian peralatan: Respons dalam waktu 5 menit
- Insiden lingkungan (kebakaran, banjir, dll.): Respons dalam waktu 10 menit


## 5. Pemenuhan Standar

### Persyaratan Keamanan Fisik:

- ✅ **PS-1**: Kontrol akses fisik diterapkan secara berlapis dengan pemantauan menyeluruh
- ✅ **PS-2**: Perlindungan area sensitif dijamin melalui sistem mantrap di ruang server
- ✅ **PS-3**: Keamanan peralatan diterapkan melalui prosedur penguncian dan pelacakan
- ✅ **PS-4**: Manajemen pengunjung dikelola melalui registrasi dan pendampingan
- ✅ **PS-5**: Kontrol lingkungan diterapkan melalui sistem HVAC dan pemadaman kebakaran
- ✅ **PS-6**: Keamanan kabel dijamin melalui jalur kabel yang terlindungi
- ✅ **PS-7**: Kebijakan meja bersih (clean desk) diterapkan secara konsisten
- ✅ **PS-8**: Keamanan kerja jarak jauh dijamin melalui kontrol keamanan khusus WFH


## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Mengawasi keseluruhan program keamanan fisik |
| Manajer Keamanan | Mengelola operasional keamanan harian |
| Manajer Fasilitas | Mengelola pemeliharaan gedung dan kontrol lingkungan |
| Manajer IT Operations | Mengelola keamanan peralatan dan ruang server |
| Kepala Departemen | Memastikan kepatuhan keamanan fisik dalam departemennya |
| Seluruh Karyawan | Mematuhi prosedur keamanan fisik yang berlaku |


## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan:** Dilakukan setiap tahun atau ketika terjadi perubahan signifikan pada fasilitas atau kebijakan
- **Tanggung Jawab Peninjauan:** Tim Keamanan dan Tim Fasilitas
- **Persetujuan Pembaruan:** ISM dan Manajemen


## 8. Lampiran

- Lampiran A: Tata Letak Lokasi dengan Zona Keamanan
- Lampiran B: Prosedur Respons Darurat
- Lampiran C: Lokasi Penempatan Kamera CCTV
- Lampiran D: Konfigurasi Sistem Kontrol Akses
- Lampiran E: Pedoman Keamanan Kerja dari Rumah

**AKHIR DOKUMEN PROSEDUR**


*Dokumen ini bersifat Confidential dan hanya diperuntukkan bagi kebutuhan internal PT ECOMINDO SARANA CIPTA. Distribusi tanpa izin dari ISM dilarang.*


Tanggal Berlaku: 15 April 2026  
Tinjauan Selanjutnya: 15 April 2027