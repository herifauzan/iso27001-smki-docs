# PROSEDUR KELANGSUNGAN BISNIS DAN PEMULIHAN BENCANA
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROSEDUR KELANGSUNGAN BISNIS DAN PEMULIHAN BENCANA
**Dokumen ID:** PROC-08
**Versi:** 1.0
**Tanggal Berlaku:** 15 April 2026
**Status:** Final
**Tingkat Keamanan:** Confidential

## Lembar Pengesahan

| Jabatan | Nama | Tanda Tangan | Tanggal |
|---------|------|-------------|--------|
| Direktur Operasional / COO | Dodi Darundriyo |   |   |
| Manajer Keamanan Informasi (ISM) | Heri Fauzan |   |   |
| Direktur Utama / CEO | Ahmad Firdaus |   |   |


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

Prosedur ini mengatur perencanaan, implementasi, pengujian, dan pemeliharaan program Kelangsungan Bisnis (Business Continuity / BC) dan Pemulihan Bencana (Disaster Recovery / DR) PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001 (Annex A.17) dan kerangka kerja NIST SP 800-34.

Prosedur ini memastikan bahwa PT Ecomindo dapat mempertahankan atau memulihkan operasi bisnis kritis dengan cepat setelah terjadinya gangguan, baik yang bersifat insiden keamanan siber, kegagalan teknis, bencana alam, maupun kondisi darurat lainnya.

### 1.1 Tujuan

- Memastikan kelangsungan layanan bisnis kritis selama dan setelah gangguan
- Memulihkan sistem dan data secara terstruktur sesuai target RTO dan RPO
- Meminimalkan dampak finansial, reputasional, dan operasional akibat gangguan
- Memenuhi kewajiban kontraktual kepada klien terkait ketersediaan layanan
- Memastikan seluruh pemangku kepentingan mendapat informasi yang tepat selama krisis

### 1.2 Ruang Lingkup

Prosedur ini berlaku untuk:

- Seluruh sistem dan layanan TI yang mendukung proses bisnis kritis
- Seluruh data organisasi dan klien
- Seluruh personel yang terlibat dalam operasional dan pemulihan
- Seluruh fasilitas fisik yang mendukung operasional IT
- Mitra dan vendor yang menyediakan layanan kritis

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (GOV-POL-TK3I.md), Area 10: Kontinuitas Bisnis & Pemulihan Bencana, dan Area 8.3.7
- PROC-03-Operations-Security.md, Bagian 2.1 (Backup dan Recovery)
- ISO/IEC 27001:2022 â€” Annex A.17 (Business continuity management)
- NIST SP 800-34 â€” Contingency Planning Guide


## 2. Prosedur Utama

### 2.1 Prosedur Business Impact Analysis (BIA)

Business Impact Analysis adalah fondasi dari seluruh perencanaan BCP/DRP. BIA mengidentifikasi proses bisnis kritis dan menentukan dampak jika proses tersebut terganggu.

#### Langkah-langkah:

1. **Identifikasi Proses Bisnis Kritis** (ISM & Kepala Departemen â€” Tahunan)

   - Memetakan seluruh proses bisnis organisasi bersama kepala departemen
   - Menentukan proses yang diklasifikasikan sebagai "kritis" berdasarkan kriteria:
     - Dampak langsung pada pendapatan jika terhenti
     - Dampak pada pemenuhan kewajiban kontraktual klien
     - Dampak hukum/regulasi jika terhenti
     - Dampak reputasional yang signifikan

2. **Penilaian Dampak per Proses** (Kepala Departemen â€” Per proses kritis)

   Untuk setiap proses kritis, tentukan:
   - **Maximum Tolerable Downtime (MTD)**: Batas waktu maksimum proses boleh terhenti sebelum menimbulkan dampak tidak dapat dipulihkan
   - **Recovery Time Objective (RTO)**: Target waktu pemulihan yang harus dicapai
   - **Recovery Point Objective (RPO)**: Batas kehilangan data yang dapat diterima

3. **Identifikasi Sistem Pendukung** (IT Operations â€” Per proses)

   - Mengidentifikasi sistem IT, infrastruktur, dan sumber daya yang mendukung setiap proses kritis
   - Membuat peta ketergantungan (dependency map) antar sistem

4. **Dokumentasi Hasil BIA** (ISM â€” Setelah analisis)

   - Mendokumentasikan hasil BIA dalam Form-BC-01
   - Mempresentasikan hasil kepada COO untuk persetujuan prioritas pemulihan

#### Tabel RTO/RPO Standar Organisasi:

| Kategori | Contoh Sistem | MTD | RTO | RPO |
|----------|--------------|-----|-----|-----|
| **Kritis** | ERP, sistem pembayaran, layanan inti klien | 4 jam | 2 jam | 30 menit |
| **Tinggi** | Email, portal internal, basis data transaksi | 24 jam | 8 jam | 2 jam |
| **Sedang** | Sistem pelaporan, sistem pendukung | 72 jam | 24 jam | 4 jam |
| **Rendah** | Sistem administrasi, arsip | 7 hari | 72 jam | 24 jam |

#### Frekuensi: Tahunan atau saat ada perubahan signifikan pada proses bisnis

### 2.2 Prosedur Penyusunan Business Continuity Plan (BCP)

#### Langkah-langkah:

1. **Penyusunan Strategi Kelangsungan** (ISM & Kepala Departemen â€” Berdasarkan BIA)

   Untuk setiap proses kritis, tentukan strategi kelangsungan:
   - **Operasi Manual**: Beralih ke prosedur manual sementara sistem dipulihkan
   - **Kapasitas Cadangan**: Menggunakan infrastruktur cadangan yang sudah siap
   - **Relokasi**: Berpindah ke lokasi alternatif jika fasilitas utama tidak dapat digunakan
   - **Sistem Alternatif**: Menggunakan sistem pengganti sementara

2. **Pendefinisian Tim Kelangsungan Bisnis** (COO â€” Sebelum insiden)

   - Membentuk Tim Manajemen Krisis (Crisis Management Team / CMT) dengan peran:
     - **Komandan Insiden**: COO (pengambil keputusan tertinggi selama krisis)
     - **Koordinator IT**: ISM (koordinasi pemulihan sistem)
     - **Koordinator Komunikasi**: Manajer Marketing/PR (komunikasi eksternal)
     - **Koordinator HR**: Manajer HR (koordinasi personel)
   - Mendokumentasikan kontak darurat seluruh anggota tim (lihat Form-BC-02)

3. **Penyusunan Prosedur Operasional Darurat** (Kepala Departemen â€” Per departemen)

   Untuk setiap departemen kritis:
   - Mendokumentasikan langkah-langkah operasional darurat (manual workaround)
   - Mengidentifikasi sumber daya minimum yang dibutuhkan (personel, peralatan, data)
   - Mendokumentasikan lokasi alternatif kerja jika diperlukan

4. **Rencana Komunikasi Krisis** (ISM & Koordinator Komunikasi â€” Sebelum insiden)

   - Menyusun template komunikasi untuk berbagai skenario bencana
   - Mendefinisikan alur komunikasi: internal (karyawan) dan eksternal (klien, vendor, regulator)
   - Menetapkan juru bicara resmi selama krisis

5. **Pengesahan BCP** (COO & CEO â€” Setelah penyusunan)

   - BCP ditinjau oleh seluruh kepala departemen terkait
   - BCP disahkan oleh COO dan CEO
   - BCP didistribusikan kepada seluruh pihak yang terlibat dalam bentuk tercetak dan digital

#### Frekuensi: Disusun pertama kali, diperbarui setiap tahun

### 2.3 Prosedur Penyusunan Disaster Recovery Plan (DRP)

#### Langkah-langkah:

1. **Penentuan Strategi DR** (ISM & IT Operations â€” Berdasarkan BIA)

   Pilih strategi DR sesuai RTO dan anggaran:

   | Strategi | Deskripsi | RTO Tipikal | Biaya |
   |----------|-----------|-------------|-------|
   | **Hot Site** | Infrastruktur identik yang selalu aktif dan siap | < 1 jam | Tinggi |
   | **Warm Site** | Infrastruktur sebagian dikonfigurasi, dapat aktif dalam jam | 2â€“8 jam | Sedang |
   | **Cold Site** | Infrastruktur dasar tersedia, perlu konfigurasi | 24â€“72 jam | Rendah |
   | **Cloud DR** | Menggunakan layanan cloud sebagai DR site | 1â€“8 jam | Sesuai penggunaan |

2. **Penyusunan Prosedur Pemulihan per Sistem** (IT Operations â€” Per sistem kritis)

   Untuk setiap sistem kritis, dokumentasikan:
   - Langkah-langkah failover ke sistem cadangan secara rinci
   - Daftar dependensi sistem yang harus dipulihkan terlebih dahulu
   - Prosedur verifikasi bahwa sistem telah berhasil dipulihkan
   - Prosedur failback (kembali ke sistem produksi utama setelah bencana selesai)

3. **Konfigurasi Infrastruktur DR** (IT Operations â€” Sebelum insiden)

   - Mengkonfigurasi dan menguji infrastruktur DR sesuai strategi yang dipilih
   - Memastikan replikasi data ke DR site berjalan sesuai target RPO
   - Mendokumentasikan konfigurasi DR dalam baseline konfigurasi

4. **Pengesahan DRP** (ISM & COO â€” Setelah penyusunan)

   - DRP ditinjau dan disahkan oleh ISM dan COO
   - DRP diperbarui setiap kali ada perubahan signifikan pada infrastruktur

#### Frekuensi: Disusun pertama kali, diperbarui setiap tahun atau saat ada perubahan infrastruktur signifikan

### 2.4 Prosedur Aktivasi BCP/DRP

Prosedur ini dijalankan saat terjadi gangguan yang berdampak pada operasional bisnis.

#### Langkah-langkah:

1. **Deteksi dan Deklarasi Bencana** (ISM / Tim IT â€” Segera saat gangguan terdeteksi)

   - Menilai dampak dan cakupan gangguan dalam waktu maksimal **30 menit**
   - Jika gangguan melebihi RTO sistem kritis, ISM merekomendasi deklarasi bencana kepada COO
   - COO memberikan keputusan deklarasi bencana secara resmi
   - Mengaktifkan Crisis Management Team (CMT)

2. **Notifikasi Pemangku Kepentingan** (Koordinator Komunikasi â€” Dalam 1 jam setelah deklarasi)

   **Internal:**
   - Seluruh karyawan diinformasikan mengenai situasi dan instruksi kerja
   - Manajer departemen diinformasikan mengenai prosedur operasi darurat

   **Eksternal:**
   - Klien yang terdampak diinformasikan sesuai SLA yang disepakati
   - Vendor dan mitra kritis diinformasikan
   - Regulator diinformasikan jika ada kewajiban pelaporan

3. **Aktivasi Prosedur Pemulihan** (IT Operations â€” Segera setelah deklarasi)

   - Mengaktifkan prosedur pemulihan sistem sesuai prioritas (Kritis â†’ Tinggi â†’ Sedang â†’ Rendah)
   - Melaksanakan failover ke infrastruktur DR
   - Memantau kemajuan pemulihan dan melaporkan status setiap jam kepada ISM

4. **Operasi Darurat** (Seluruh Departemen â€” Selama pemulihan berlangsung)

   - Melaksanakan prosedur operasional darurat (manual workaround) sesuai BCP
   - Mendokumentasikan seluruh tindakan yang diambil beserta timestamp-nya
   - ISM memimpin War Room dengan update status setiap 2 jam

5. **Verifikasi Pemulihan** (IT Operations & Pemilik Proses â€” Sebelum kembali normal)

   - Melakukan verifikasi fungsional terhadap seluruh sistem yang dipulihkan
   - Memastikan integritas data setelah pemulihan
   - Mendapat konfirmasi dari pemilik proses bisnis bahwa layanan berjalan normal

6. **Deklarasi Kembali Normal (Return to Normal)** (COO â€” Setelah verifikasi)

   - COO menyatakan kondisi kembali normal secara resmi
   - Seluruh pemangku kepentingan diinformasikan

7. **Tinjauan Pasca-Insiden** (ISM & CMT â€” Dalam 72 jam setelah pemulihan)

   - Melakukan Post-Incident Review (PIR) untuk menganalisis:
     - Penyebab gangguan
     - Efektivitas respons dan pemulihan
     - Kesenjangan antara RTO/RPO aktual vs target
   - Mendokumentasikan lessons learned
   - Memperbarui BCP/DRP berdasarkan temuan

#### Waktu Respons Target:

| Tahap | Target Waktu |
|-------|-------------|
| Deteksi dan penilaian | 30 menit |
| Deklarasi bencana | 1 jam |
| Notifikasi internal | 1 jam |
| Notifikasi klien | 2 jam |
| Aktivasi pemulihan sistem kritis | 2 jam |
| Kembali normal (sistem kritis) | Sesuai RTO |

### 2.5 Prosedur Pengujian BCP/DRP

Pengujian reguler adalah kewajiban untuk memastikan BCP/DRP berfungsi saat dibutuhkan.

#### Jenis Pengujian:

1. **Tabletop Exercise** (ISM & CMT â€” Setiap tahun, minimal)

   - Simulasi berbasis diskusi, tidak melibatkan sistem nyata
   - Membahas skenario bencana hipotetis dan mengevaluasi respons tim
   - Mengidentifikasi celah dalam prosedur BCP/DRP
   - Durasi: 2â€“4 jam

2. **Pengujian Fungsional (Partial DR Test)** (IT Operations â€” Setiap semester)

   - Menguji pemulihan sebagian sistem dalam lingkungan terisolasi
   - Memverifikasi bahwa backup dapat dipulihkan ke sistem DR
   - Mengukur RTO dan RPO aktual vs target
   - Mendokumentasikan hasil dalam Form-BC-03

3. **Pengujian DR Penuh (Full DR Test)** (IT Operations & CMT â€” Setiap tahun)

   - Simulasi lengkap skenario failover ke DR site
   - Melibatkan seluruh sistem kritis dan tim terkait
   - Mengukur seluruh parameter RTO/RPO
   - Mendokumentasikan seluruh hasil dan anomali yang ditemukan

#### Langkah-langkah Pelaksanaan Pengujian:

1. **Perencanaan Pengujian** (ISM â€” 2 minggu sebelum)

   - Menetapkan skenario pengujian yang realistis
   - Mengidentifikasi sistem dan sumber daya yang terlibat
   - Menginformasikan pihak yang terdampak (karyawan, klien jika diperlukan)

2. **Pelaksanaan Pengujian** (IT Operations & Tim â€” Sesuai jadwal)

   - Melaksanakan pengujian sesuai skenario yang telah ditetapkan
   - Mencatat waktu setiap tahap pemulihan
   - Mendokumentasikan seluruh masalah yang ditemukan

3. **Evaluasi Hasil** (ISM â€” Dalam 5 hari kerja setelah pengujian)

   - Membandingkan hasil aktual vs target RTO/RPO
   - Mengidentifikasi gaps dan area perbaikan
   - Menyusun laporan pengujian dan rekomendasi

4. **Tindak Lanjut** (IT Operations â€” Dalam 30 hari)

   - Mengimplementasikan perbaikan berdasarkan hasil evaluasi
   - Memperbarui DRP jika diperlukan
   - Melaporkan status perbaikan kepada ISM


## 3. Formulir dan Template

### Form-BC-01: Business Impact Analysis
```
Nama Proses Bisnis: ________________
Departemen Pemilik: ________________
Tanggal BIA: ______________________

PENILAIAN DAMPAK:
Dampak Finansial jika Terhenti: ____
Dampak Operasional: _______________
Dampak Reputasional: ______________
Dampak Regulasi/Hukum: ___________

TARGET PEMULIHAN:
MTD (Maximum Tolerable Downtime): _
RTO (Recovery Time Objective): _____
RPO (Recovery Point Objective): _____
Prioritas Pemulihan: â–¡ Kritis â–¡ Tinggi â–¡ Sedang â–¡ Rendah

SISTEM PENDUKUNG:
Sistem IT Utama: __________________
Sistem IT Pendukung: ______________
Sumber Daya Kritis: _______________

Disetujui:
___________________________
Kepala Departemen
Tanggal: __________
```

### Form-BC-02: Daftar Kontak Darurat (Crisis Contact List)
```
Versi: ____________________________
Tanggal Pembaruan Terakhir: ________

CRISIS MANAGEMENT TEAM:
Komandan Insiden (COO): ___________
  HP: _____________ Email: _________

Koordinator IT (ISM): ______________
  HP: _____________ Email: _________

Koordinator HR: ___________________
  HP: _____________ Email: _________

Koordinator Komunikasi: ___________
  HP: _____________ Email: _________

KONTAK VENDOR KRITIS:
Vendor Hosting/Cloud: _____________
  Kontak Darurat: _________________

Vendor Internet (ISP): _____________
  Kontak Darurat: _________________

KONTAK EKSTERNAL DARURAT:
BSSN (Badan Siber): 021-XXXXX
Kepolisian: 110
Pemadam Kebakaran: 113
Ambulans: 118/119
```

### Form-BC-03: Laporan Hasil Pengujian BCP/DRP
```
Jenis Pengujian: â–¡ Tabletop â–¡ Parsial â–¡ Penuh
Tanggal Pengujian: ________________
Skenario yang Diuji: ______________

HASIL PENGUJIAN SISTEM:
Sistem | RTO Target | RTO Aktual | RPO Target | RPO Aktual | Status
-------|------------|------------|------------|------------|-------

TEMUAN DAN GAPS:
1. ________________________________
2. ________________________________

REKOMENDASI PERBAIKAN:
1. ________________________________
2. ________________________________

Disetujui:
___________________________         ___________________________
ISM                                  COO
Tanggal: __________                 Tanggal: __________
```


## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Pembaruan BCP/DRP Tahunan**: Dokumen diperbarui setiap tahun atau setelah pengujian/insiden
- **Pengujian Terjadwal**: Jadwal pengujian ditetapkan di awal tahun dan tidak boleh dilewati
- **Integrasi dengan Manajemen Risiko**: Skenario bencana diintegrasikan dengan Risk Register (PROC-07)
- **Validasi Backup**: Pengujian restore dilakukan setiap bulan (lihat PROC-03, Bagian 2.1)

### 4.2 Pemantauan dan Audit

- Pengujian tabletop: Setiap tahun
- Pengujian parsial: Setiap semester (2 kali per tahun)
- Pengujian DR penuh: Setiap tahun
- Tinjauan BCP/DRP: Setiap tahun dan setelah setiap pengujian atau insiden nyata
- Audit program BCP/DRP: Setiap 2 tahun oleh pihak eksternal

### 4.3 Kondisi yang Memerlukan Pembaruan Segera

BCP/DRP harus segera diperbarui jika terjadi:

- Perubahan signifikan pada infrastruktur IT
- Penambahan atau penghapusan sistem kritis
- Perubahan personel kunci dalam tim pemulihan
- Perubahan lokasi kantor atau data center
- Setelah aktivasi BCP/DRP dalam insiden nyata


## 5. Pemenuhan Standar

### Persyaratan Kelangsungan Bisnis (ISO 27001 Annex A.17):

- âœ… **BC-1**: Business Impact Analysis dilaksanakan dan didokumentasikan secara formal
- âœ… **BC-2**: Business Continuity Plan disusun, disahkan, dan didistribusikan
- âœ… **BC-3**: Disaster Recovery Plan mencakup prosedur pemulihan sistem per kategori
- âœ… **BC-4**: Strategi DR ditetapkan sesuai target RTO/RPO berdasarkan BIA
- âœ… **BC-5**: Tim Manajemen Krisis dibentuk dengan peran dan tanggung jawab yang jelas
- âœ… **BC-6**: Rencana komunikasi krisis mencakup komunikasi internal dan eksternal
- âœ… **BC-7**: Pengujian tabletop dilaksanakan setiap tahun
- âœ… **BC-8**: Pengujian fungsional dilaksanakan setiap semester
- âœ… **BC-9**: Pengujian DR penuh dilaksanakan setiap tahun
- âœ… **BC-10**: Tinjauan pasca-insiden dilaksanakan setelah setiap aktivasi BCP/DRP


## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| COO | Menyetujui BCP/DRP, mendeklarasikan bencana, memimpin Crisis Management Team |
| ISM | Mengembangkan dan memelihara BCP/DRP, mengkoordinasikan pengujian dan pemulihan |
| IT Operations | Melaksanakan pemulihan sistem, memelihara infrastruktur DR, menguji backup |
| Kepala Departemen | Mendefinisikan proses kritis, menyetujui prosedur operasi darurat departemen |
| Koordinator Komunikasi | Mengelola komunikasi dengan klien, vendor, dan publik selama krisis |
| Manajer HR | Mengkoordinasikan penempatan personel selama dan setelah krisis |
| Seluruh Karyawan | Memahami prosedur evakuasi dan operasi darurat |


## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan Prosedur:** Setiap tahun, atau setelah setiap insiden atau pengujian DR
- **Tanggung Jawab Peninjauan:** ISM, IT Operations, dan Kepala Departemen
- **Persetujuan Pembaruan:** ISM dan COO


## 8. Lampiran

- Lampiran A: Daftar Sistem Kritis dan Kategori Pemulihan
- Lampiran B: Prosedur Pemulihan Teknis per Sistem (runbook DR)
- Lampiran C: Peta Lokasi DR Site dan Alternatif Kantor
- Lampiran D: Template Komunikasi Krisis (untuk klien, karyawan, media)
- Lampiran E: Jadwal Pengujian BCP/DRP Tahunan
- Lampiran F: Hasil Pengujian BCP/DRP Sebelumnya

**AKHIR DOKUMEN PROSEDUR**


*Dokumen ini bersifat Confidential dan hanya diperuntukkan bagi kebutuhan internal PT ECOMINDO SARANA CIPTA. Distribusi tanpa izin dari ISM dilarang.*


Tanggal Berlaku: 15 April 2026  
Tinjauan Selanjutnya: 15 April 2027