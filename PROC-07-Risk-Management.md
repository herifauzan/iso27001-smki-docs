# PROSEDUR MANAJEMEN RISIKO KEAMANAN INFORMASI
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROSEDUR MANAJEMEN RISIKO KEAMANAN INFORMASI
**Dokumen ID:** PROC-07
**Versi:** 1.0
**Tanggal Berlaku:** 15 April 2026
**Status:** Final
**Tingkat Keamanan:** Confidential

## Lembar Pengesahan

| Jabatan | Nama | Tanda Tangan | Tanggal |
|---------|------|-------------|--------|
| Direktur Utama / CEO | Ahmad Firdaus |   |   |
| Direktur Operasional / COO | Dodi Darundriyo |   |   |
| Manajer Keamanan Informasi (ISM) | Heri Fauzan |   |   |



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

Prosedur ini mengatur proses identifikasi, analisis, evaluasi, penanganan, dan pemantauan risiko keamanan informasi PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001 (Annex A.8) dan kerangka kerja NIST Cybersecurity Framework. Manajemen risiko yang efektif adalah landasan dari seluruh program keamanan informasi organisasi.

### 1.1 Tujuan

- Mengidentifikasi risiko keamanan informasi secara sistematis dan komprehensif
- Mengevaluasi dan memprioritaskan risiko berdasarkan dampak dan kemungkinan terjadinya
- Menetapkan langkah mitigasi yang tepat dan terukur untuk setiap risiko
- Memelihara risk register yang akurat dan selalu mutakhir
- Memastikan keputusan keamanan informasi didasarkan pada penilaian risiko yang objektif

### 1.2 Ruang Lingkup

Prosedur ini berlaku untuk seluruh aset informasi organisasi, termasuk:

- Seluruh sistem informasi, aplikasi, dan infrastruktur IT
- Data dan informasi milik organisasi maupun klien
- Proses bisnis yang bergantung pada sistem informasi
- Pihak ketiga, vendor, dan mitra yang memiliki akses ke sistem organisasi
- Lingkungan fisik yang mendukung operasional IT

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (GOV-POL-TK3I), Area 1: Manajemen Risiko Keamanan Informasi
- ISO/IEC 27001:2022 - Annex A.8 (Information security risk assessment)
- NIST SP 800-30 - Guide for Conducting Risk Assessments


## 2. Prosedur Utama

### 2.1 Prosedur Identifikasi Risiko

#### Langkah-langkah:

1. **Inventarisasi Aset** (IT Operations & Pemilik Aset - Tahunan dan saat ada perubahan)

   - Mengidentifikasi seluruh aset informasi: perangkat keras, perangkat lunak, data, infrastruktur, dan personel kunci
   - Menetapkan nilai aset berdasarkan dampak bisnis jika terganggu (Kritis, Tinggi, Sedang, Rendah)
   - Mendokumentasikan kepemilikan aset dalam register aset (lihat PROC-04)

2. **Identifikasi Ancaman** (ISM & Tim Security - Tahunan)

   - Mengidentifikasi ancaman relevan untuk setiap kategori aset, meliputi:
     - **Ancaman Internal**: Kesalahan manusia, penyalahgunaan hak akses, sabotase
     - **Ancaman Eksternal**: Serangan siber (phishing, ransomware, DDoS), bencana alam
     - **Ancaman Teknis**: Kegagalan sistem, kerentanan perangkat lunak, kesalahan konfigurasi
   - Mengacu pada sumber ancaman terkini: CVE database, laporan ancaman BSSN, threat intelligence

3. **Identifikasi Kerentanan** (IT Security - Triwulanan)

   - Melaksanakan pemindaian kerentanan teknis pada seluruh sistem (lihat PROC-03, Bagian 2.4)
   - Meninjau hasil audit keamanan sebelumnya
   - Mengidentifikasi kelemahan pada proses, prosedur, dan kontrol yang ada

4. **Dokumentasi Risiko Awal** (ISM - Setelah identifikasi)

   - Mendokumentasikan setiap risiko yang teridentifikasi dalam Risk Register (Form-RM-01)
   - Memberikan ID unik untuk setiap risiko
   - Mencatat ancaman, kerentanan, dan aset terdampak untuk setiap risiko

#### Frekuensi: Tahunan (lengkap) dan setiap kali ada perubahan signifikan pada sistem atau lingkungan bisnis

### 2.2 Prosedur Penilaian Risiko (Risk Assessment)

#### Langkah-langkah:

1. **Penilaian Dampak** (Pemilik Aset & ISM - Per risiko)

   Menilai dampak potensial jika risiko terwujud menggunakan skala berikut:

   | Skala | Nilai | Kriteria Dampak |
   |-------|-------|-----------------|
   | Sangat Tinggi | 5 | Gangguan operasional parah, kerugian finansial besar (>Rp 1 M), dampak hukum serius |
   | Tinggi | 4 | Gangguan operasional signifikan, kerugian finansial sedang (Rp 100 jt - 1 M) |
   | Sedang | 3 | Gangguan terbatas, kerugian finansial kecil (Rp 10 jt - 100 jt) |
   | Rendah | 2 | Dampak minimal, kerugian sangat kecil (<Rp 10 jt) |
   | Sangat Rendah | 1 | Dampak dapat diabaikan, tanpa kerugian signifikan |

2. **Penilaian Kemungkinan** (ISM & Tim Security - Per risiko)

   Menilai kemungkinan terjadinya risiko menggunakan skala berikut:

   | Skala | Nilai | Kriteria Kemungkinan |
   |-------|-------|---------------------|
   | Hampir Pasti | 5 | >80% kemungkinan terjadi dalam 1 tahun |
   | Kemungkinan Besar | 4 | 50-80% kemungkinan terjadi dalam 1 tahun |
   | Mungkin | 3 | 20-50% kemungkinan terjadi dalam 1 tahun |
   | Tidak Mungkin | 2 | 5-20% kemungkinan terjadi dalam 1 tahun |
   | Sangat Tidak Mungkin | 1 | <5% kemungkinan terjadi dalam 1 tahun |

3. **Perhitungan Skor Risiko** (ISM - Per risiko)

   - **Skor Risiko = Dampak Ã— Kemungkinan**
   - Klasifikasi risiko berdasarkan skor:

   | Skor | Tingkat Risiko | Warna | Tindakan |
   |------|---------------|-------|---------|
   | 20-25 | Kritis | Merah | Tindakan segera, eskalasi ke manajemen |
   | 12-19 | Tinggi | Oranye | Tindakan dalam 30 hari, laporan rutin |
   | 6-11 | Sedang | Kuning | Tindakan dalam 90 hari, pemantauan |
   | 1-5 | Rendah | Hijau | Pantau, tangani pada siklus berikutnya |

4. **Heat Map Risiko** (ISM - Setelah penilaian)

   - Membuat matriks risiko visual (heat map) yang menggambarkan distribusi risiko
   - Mempresentasikan heat map kepada manajemen dalam Management Review triwulanan

#### Frekuensi: Tahunan (lengkap), diperbarui triwulanan untuk risiko tinggi/kritis

### 2.3 Prosedur Penanganan Risiko (Risk Treatment)

#### Langkah-langkah:

1. **Penentuan Opsi Penanganan** (ISM & Pemilik Aset - Per risiko)

   Untuk setiap risiko, pilih satu atau kombinasi opsi berikut:

   - **Mitigasi (Reduce)**: Menerapkan kontrol untuk mengurangi dampak atau kemungkinan risiko
   - **Transfer (Share)**: Mengalihkan risiko kepada pihak ketiga (asuransi, vendor managed service)
   - **Penghindaran (Avoid)**: Menghentikan aktivitas yang menimbulkan risiko
   - **Penerimaan (Accept)**: Menerima risiko jika berada dalam batas toleransi dan biaya mitigasi tidak sebanding

   > **Catatan:** Risiko dengan skor Kritis (20-25) TIDAK BOLEH hanya diterima tanpa tindakan mitigasi apapun. Harus ada persetujuan tertulis dari COO.

2. **Penyusunan Rencana Penanganan Risiko** (ISM - Per risiko)

   Untuk setiap risiko yang akan dimitigasi:
   - Mendefinisikan kontrol keamanan yang akan diterapkan
   - Menetapkan penanggung jawab (PIC) dan tenggat waktu pelaksanaan
   - Memperkirakan biaya implementasi
   - Mendefinisikan indikator keberhasilan (KPI)

3. **Persetujuan Rencana** (Manajemen - Dalam 7 hari kerja)

   - Rencana penanganan risiko tinggi/kritis disampaikan kepada COO dan ISM untuk disetujui
   - Risiko sedang/rendah dapat disetujui oleh ISM secara mandiri
   - Keputusan persetujuan didokumentasikan dalam Risk Register

4. **Implementasi Kontrol** (IT Operations & Tim Security - Sesuai tenggat)

   - Melaksanakan kontrol keamanan sesuai rencana yang disetujui
   - Mendokumentasikan bukti implementasi (screenshot konfigurasi, laporan pengujian, dll.)
   - Melaporkan kemajuan implementasi kepada ISM setiap bulan

#### Frekuensi: Berkelanjutan, dengan pelaporan kemajuan bulanan

### 2.4 Prosedur Pemantauan dan Peninjauan Risiko

#### Langkah-langkah:

1. **Pemantauan Risiko Berkelanjutan** (ISM - Terus-menerus)

   - Memantau perubahan pada lingkungan ancaman (ancaman baru, kerentanan baru yang dipublikasikan)
   - Memantau efektivitas kontrol yang telah diterapkan melalui log, audit, dan insiden
   - Memperbarui Risk Register jika terjadi perubahan skor risiko

2. **Peninjauan Triwulanan Risiko Kritis/Tinggi** (ISM & Manajemen - Setiap triwulan)

   - Meninjau status penanganan seluruh risiko dengan skor Kritis dan Tinggi
   - Mengevaluasi efektivitas kontrol yang telah diimplementasikan
   - Melaporkan hasil tinjauan kepada COO

3. **Penilaian Risiko Tahunan Penuh** (ISM & Tim Security - Setiap tahun)

   - Melaksanakan siklus penilaian risiko lengkap dari awal (identifikasi ulang)
   - Memperbarui seluruh Risk Register
   - Mempresentasikan hasil kepada Board of Directors

4. **Penilaian Risiko Ad-Hoc** (ISM - Saat diperlukan)

   Penilaian risiko tambahan wajib dilakukan saat:
   - Terjadi insiden keamanan signifikan
   - Ada perubahan besar pada sistem atau infrastruktur
   - Ada perubahan peraturan atau persyaratan klien yang signifikan
   - Ditemukan kerentanan kritis baru

#### Frekuensi: Pemantauan berkelanjutan, tinjauan triwulanan (risiko tinggi), tahunan (penuh)

### 2.5 Prosedur Komunikasi dan Pelaporan Risiko

#### Langkah-langkah:

1. **Laporan Risiko Bulanan** (ISM - Setiap bulan)

   - Menyusun ringkasan status risiko aktif (jumlah per tingkat, perubahan skor)
   - Melaporkan kemajuan implementasi kontrol
   - Menyampaikan kepada manajemen melalui email atau rapat bulanan

2. **Laporan Risiko Triwulanan kepada Manajemen** (ISM - Setiap triwulan)

   - Menyajikan heat map risiko terkini
   - Melaporkan risiko baru yang teridentifikasi
   - Melaporkan risiko yang berhasil dimitigasi
   - Merekomendasikan alokasi anggaran untuk mitigasi risiko prioritas

3. **Laporan Risiko Tahunan kepada Board** (ISM & COO - Setiap tahun)

   - Menyajikan postur risiko keamanan informasi secara menyeluruh
   - Mengevaluasi pencapaian program manajemen risiko tahun berjalan
   - Menetapkan prioritas risiko untuk tahun mendatang


## 3. Formulir dan Template

### Form-RM-01: Risk Register (Daftar Risiko)

```
ID Risiko: _________________________
Tanggal Identifikasi: ______________
Diidentifikasi Oleh: _______________

DESKRIPSI RISIKO:
Aset Terdampak: ___________________
Ancaman: __________________________
Kerentanan: _______________________
Deskripsi Skenario Risiko: _________
__________________________________

PENILAIAN RISIKO:
Dampak (1-5): _____________________
Kemungkinan (1-5): ________________
Skor Risiko: ______________________
Tingkat Risiko: □ Kritis □ Tinggi □ Sedang □ Rendah

PENANGANAN RISIKO:
Opsi: □ Mitigasi □ Transfer □ Hindari □ Terima
Kontrol yang Direncanakan: _________
__________________________________
Penanggung Jawab (PIC): ___________
Tenggat Waktu: ____________________

STATUS IMPLEMENTASI:
□ Belum Dimulai □ Sedang Berjalan □ Selesai □ Ditangguhkan
Tanggal Update: ___________________
Catatan: __________________________

Disetujui Oleh:
___________________________
ISM / COO (untuk risiko Kritis)
Tanggal: __________
```

### Form-RM-02: Laporan Penilaian Risiko Tahunan

```
Periode Penilaian: _________________
Dilaksanakan Oleh: ________________
Tanggal Selesai: ___________________

RINGKASAN EKSEKUTIF:
Total Risiko Teridentifikasi: ______
- Kritis: ______
- Tinggi: ______
- Sedang: ______
- Rendah: ______

Risiko Baru (dibanding tahun lalu): _
Risiko Berhasil Dimitigasi: ________
Risiko Residual yang Diterima: _____

REKOMENDASI PRIORITAS:
1. ________________________________
2. ________________________________
3. ________________________________

Disetujui:
___________________________         ___________________________
Manajer Keamanan Informasi (ISM)    Direktur Operasional / COO
Tanggal: __________                 Tanggal: __________
```


## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Risk Register Terpusat**: Satu register yang dipelihara oleh ISM dan dapat diakses oleh manajemen
- **Batas Toleransi Risiko**: Risiko Kritis wajib ditangani; Tinggi dalam 30 hari; Sedang dalam 90 hari
- **Eskalasi Otomatis**: Risiko Kritis baru wajib dilaporkan kepada COO dalam 24 jam
- **Integrasi dengan Audit**: Temuan audit internal/eksternal otomatis masuk ke Risk Register

### 4.2 Pemantauan dan Audit

- Pembaruan Risk Register: Dilakukan setiap bulan
- Tinjauan risiko tinggi/kritis: Dilakukan setiap triwulan
- Penilaian risiko penuh: Dilakukan setiap tahun
- Audit program manajemen risiko: Dilakukan bersamaan dengan audit internal tahunan

### 4.3 Pelaporan Insiden

- Insiden keamanan yang terjadi wajib dievaluasi dampaknya terhadap Risk Register
- Risiko yang terwujud menjadi insiden harus dianalisis untuk perbaikan kontrol
- Laporan insiden diintegrasikan ke dalam siklus manajemen risiko berikutnya


## 5. Pemenuhan Standar

### Persyaratan Manajemen Risiko (ISO 27001):

- ✅ **RM-1**: Proses penilaian risiko formal ditetapkan dengan metodologi yang konsisten
- ✅ **RM-2**: Risk register dipelihara dan diperbarui secara berkala
- ✅ **RM-3**: Skala penilaian dampak dan kemungkinan didefinisikan dengan jelas
- ✅ **RM-4**: Rencana penanganan risiko disusun dan disetujui manajemen
- ✅ **RM-5**: Pemantauan dan peninjauan risiko dilaksanakan secara berkala
- ✅ **RM-6**: Pelaporan risiko kepada manajemen dilakukan secara rutin
- ✅ **RM-7**: Penilaian risiko ad-hoc dilakukan saat terjadi perubahan signifikan
- ✅ **RM-8**: Bukti pelaksanaan penilaian risiko didokumentasikan


## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Memimpin seluruh proses manajemen risiko, memelihara Risk Register, melaporkan kepada manajemen |
| Tim Risk Management (Team 1) | Melaksanakan penilaian risiko, menganalisis ancaman dan kerentanan |
| IT Security | Menyediakan data kerentanan teknis, melaksanakan kontrol mitigasi |
| Pemilik Aset / Kepala Departemen | Menilai dampak bisnis, menyetujui opsi penanganan risiko |
| COO | Menyetujui rencana penanganan risiko kritis, menerima laporan triwulanan |
| Board of Directors | Menetapkan toleransi risiko organisasi, menerima laporan tahunan |


## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan Prosedur:** Setiap tahun atau ketika terjadi perubahan signifikan pada metodologi atau standar
- **Tanggung Jawab Peninjauan:** ISM dan Tim Risk Management
- **Persetujuan Pembaruan:** ISM dan COO


## 8. Lampiran

- Lampiran A: Template Heat Map Risiko
- Lampiran B: Katalog Ancaman dan Kerentanan Umum
- Lampiran C: Panduan Pengisian Risk Register
- Lampiran D: Matriks Kontrol ISO 27001 vs Risiko
- Lampiran E: Kalender Penilaian Risiko Tahunan

**AKHIR DOKUMEN PROSEDUR**


*Dokumen ini bersifat Confidential dan hanya diperuntukkan bagi kebutuhan internal PT ECOMINDO SARANA CIPTA. Distribusi tanpa izin dari ISM dilarang.*


Tanggal Berlaku: 15 April 2026  
Tinjauan Selanjutnya: 15 April 2027