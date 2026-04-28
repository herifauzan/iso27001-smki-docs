# PROSEDUR MANAJEMEN ASET
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROSEDUR MANAJEMEN ASET
**Dokumen ID:** PROC-04
**Versi:** 1.0  
**Tanggal Berlaku:** 15 April 2026  
**Status:** Final  
**Tingkat Keamanan:** Confidential

## Lembar Pengesahan

| Jabatan | Nama | Tanda Tangan | Tanggal |
|---------|------|-------------|--------|
| Direktur Operasional / COO | Dodi Darundriyo |   |   |
| Manajer Keamanan Informasi (ISM) | Heri Fauzan |   |   |
| Manajer HR |  |  |  |

---

## Daftar Isi

- [1. Pendahuluan](#1-pendahuluan)
- [2. Prosedur Utama](#2-prosedur-utama)
- [3. Formulir dan Template](#3-formulir-dan-template)
- [4. Kontrol dan Pemantauan](#4-kontrol-dan-pemantauan)
- [5. Pemenuhan Standar](#5-pemenuhan-standar)
- [6. Tanggung Jawab](#6-tanggung-jawab)
- [7. Tinjauan dan Pembaruan](#7-tinjauan-dan-pembaruan)
- [8. Lampiran](#8-lampiran)

---

## 1. Pendahuluan

Prosedur ini mengatur manajemen aset informasi PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001. Prosedur ini mencakup inventarisasi, klasifikasi, penanganan, dan pembuangan aset informasi secara aman untuk memastikan perlindungan menyeluruh sepanjang siklus hidup aset.

### 1.1 Tujuan

- Mengidentifikasi dan menginventarisasi seluruh aset informasi yang dimiliki organisasi
- Mengklasifikasikan aset berdasarkan nilai bisnis dan tingkat sensitivitasnya
- Memastikan penanganan yang aman sepanjang siklus hidup aset
- Memenuhi persyaratan manajemen aset yang komprehensif sesuai standar keamanan informasi

### 1.2 Ruang Lingkup

Prosedur ini berlaku untuk seluruh aset informasi, termasuk:

- Perangkat keras (server, laptop, perangkat mobile)
- Perangkat lunak (aplikasi, sistem operasi, lisensi)
- Data (basis data, file, dokumentasi)
- Jaringan (router, switch, firewall)
- Sumber daya cloud dan layanan pihak ketiga

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (GOV-POL-TK3I.md), khususnya Area 5: Manajemen Aset & Pengamanan Data

---

## 2. Prosedur Utama

### 2.1 Prosedur Inventarisasi Aset

#### Langkah-langkah:

1. **Pengumpulan Data Aset** (IT Operations — Bulanan)

   - Melakukan pemindaian jaringan secara otomatis untuk mendeteksi perangkat keras
   - Melakukan survei manual untuk perangkat lunak dan data
   - Melakukan wawancara dengan departemen terkait untuk mendata aset non-IT

2. **Klasifikasi Aset** (IT Security — Bulanan)

   - Mengklasifikasikan aset berdasarkan kriteria berikut:
     - **Kritis (Critical)**: Sistem bisnis inti dan data sensitif yang memiliki dampak tinggi jika terganggu
     - **Penting (Important)**: Sistem pendukung dan data rahasia internal
     - **Umum (General)**: Sistem umum dan data yang bersifat publik

3. **Pembuatan Inventaris** (IT Operations — Bulanan)

   - Memperbarui CMDB (Configuration Management Database) dengan data terkini
   - Menetapkan pemilik (owner) dan penanggung jawab (custodian) untuk setiap aset
   - Menghasilkan laporan inventaris yang komprehensif

4. **Verifikasi Inventaris** (Manajemen — Triwulanan)

   - Melakukan audit fisik terhadap aset yang bersifat kritis
   - Mencocokkan data inventaris dengan catatan pengadaan
   - Memperbarui inventaris berdasarkan perubahan yang ditemukan

#### Frekuensi: Pembaruan bulanan, audit triwulanan

### 2.2 Prosedur Klasifikasi Data

#### Kriteria Klasifikasi (4 Tingkat — sesuai GOV-POL-TK3I Area 5):

Seluruh data organisasi **wajib** diklasifikasikan ke salah satu dari empat tingkat berikut:

| Tingkat | Nama | Deskripsi | Contoh |
|---------|------|-----------|--------|
| **1** | **Terbatas (Restricted)** | Data dengan sensitivitas tertinggi — akses sangat dibatasi | Kredensial sistem, data pelanggan sensitif, data PII, kunci enkripsi |
| **2** | **Rahasia (Confidential)** | Data bisnis sensitif — hanya untuk pihak tertentu yang berwenang | Data keuangan, rencana strategis, kekayaan intelektual |
| **3** | **Internal** | Data internal — hanya untuk karyawan yang berwenang | Prosedur operasional, memo internal, laporan non-sensitif |
| **4** | **Publik (Public)** | Data yang dapat dibagikan kepada publik | Materi pemasaran, informasi publik perusahaan |

**Aturan Penanganan per Tingkat:**

- **Terbatas**: Enkripsi wajib saat penyimpanan dan pengiriman, akses berbasis need-to-know, log akses setiap saat, tidak boleh disimpan di perangkat pribadi
- **Rahasia**: Enkripsi wajib saat pengiriman, akses berbasis peran, tidak boleh dikirim ke email eksternal tanpa enkripsi
- **Internal**: Tidak boleh dibagikan ke pihak luar tanpa persetujuan manajer
- **Publik**: Tidak ada pembatasan khusus, namun tetap harus melalui persetujuan sebelum dipublikasikan

#### Proses Klasifikasi:

1. **Penilaian Risiko** (Pemilik Data — Saat data dibuat)

   - Mengevaluasi dampak potensial jika data bocor atau diakses secara tidak sah
   - Menentukan tingkat klasifikasi yang sesuai berdasarkan hasil evaluasi
   - Mempertimbangkan persyaratan regulasi (UU PDP, GDPR jika berlaku)

2. **Pelabelan** (IT Security — Segera)

   - Memberi label pada file dan basis data sesuai dengan klasifikasi yang ditetapkan
   - Mengimplementasikan DLP (Data Loss Prevention) untuk menegakkan aturan klasifikasi
   - Memastikan label klasifikasi tampil pada header/footer dokumen fisik dan digital

3. **Komunikasi** (Pemilik Data — Segera)

   - Menginformasikan klasifikasi data kepada seluruh pengguna yang terkait
   - Memberikan pelatihan mengenai tata cara penanganan data sesuai klasifikasinya

### 2.3 Prosedur Penanganan Aset

#### Untuk Perangkat Keras:

1. **Pengadaan** (Tim Pengadaan)

   - Memperoleh persetujuan berdasarkan justifikasi kebutuhan bisnis
   - Melakukan penilaian keamanan sebelum pembelian dilaksanakan

2. **Penerapan** (IT Operations)

   - Mengonfigurasi security baseline sesuai standar organisasi
   - Menginstal perangkat lunak yang diperlukan beserta pembaruan keamanan terbaru
   - Menetapkan pengguna dengan akses yang sesuai

3. **Pemeliharaan** (IT Operations)

   - Menerapkan patch dan pembaruan keamanan secara berkala
   - Memantau kondisi dan kinerja perangkat keras
   - Melakukan backup data sebelum setiap pemeliharaan

4. **Transfer** (IT Operations)

   - Menghapus data secara aman (wipe) sebelum transfer perangkat ke pengguna lain
   - Memperbarui catatan inventaris
   - Mengonfigurasi ulang perangkat untuk pengguna baru

#### Untuk Perangkat Lunak:

1. **Pengadaan** (IT Procurement)

   - Memeriksa kepatuhan lisensi sebelum pengadaan
   - Melakukan tinjauan keamanan terhadap source code jika menggunakan perangkat lunak open source

2. **Instalasi** (IT Operations)

   - Menguji perangkat lunak di lingkungan staging terlebih dahulu
   - Melakukan deployment melalui proses change management yang berlaku
   - Memperbarui inventaris perangkat lunak

3. **Pemantauan Penggunaan** (IT Security)

   - Memantau penggunaan lisensi untuk memastikan kepatuhan
   - Mendeteksi perangkat lunak yang tidak sah (unauthorized)
   - Melakukan pemindaian kerentanan secara berkala

### 2.4 Prosedur Pembuangan Aset

#### Langkah-langkah:

1. **Permintaan Pembuangan** (Pemilik Aset — 30 hari sebelum pembuangan)

   - Mengisi Formulir Pembuangan Aset (Form-AM-01)
   - Menjelaskan alasan pembuangan secara jelas

2. **Persetujuan** (Manajemen — 7 hari kerja)

   - Meninjau justifikasi bisnis yang disampaikan
   - Memberikan persetujuan pembuangan

3. **Sanitasi Data** (IT Security — Sebelum pembuangan)

   - Menghapus data secara aman sesuai standar yang berlaku:
     - HDD: Menggunakan DBAN atau degaussing
     - SSD: Menggunakan perintah secure erase ATA
     - Dokumen kertas: Penghancuran dengan mesin cross-cut shredder

4. **Eksekusi Pembuangan** (IT Operations — Segera setelah sanitasi)

   - Menyerahkan perangkat kepada vendor pembuangan yang bersertifikat
   - Memperoleh sertifikat pemusnahan (certificate of destruction) dari vendor
   - Memperbarui catatan inventaris

5. **Dokumentasi** (IT Operations — Segera)

   - Mencatat pembuangan dalam register aset
   - Menyimpan catatan pembuangan minimal selama 3 tahun

#### Periode Retensi:

- Sertifikat pembuangan perangkat keras: 5 tahun
- Catatan lisensi perangkat lunak: 7 tahun
- Catatan pembuangan data: 3 tahun

### 2.5 Prosedur Manajemen Pemasok

#### Proses Penerimaan Pemasok (Onboarding):

1. **Penilaian Vendor** (Pengadaan — Sebelum kontrak)

   - Memberikan kuesioner keamanan kepada vendor untuk diisi
   - Melakukan pemeriksaan referensi dari klien vendor sebelumnya
   - Melakukan audit lokasi jika vendor menangani aset atau data kritis

2. **Tinjauan Kontrak** (Hukum/IT Security — Sebelum kontrak ditandatangani)

   - Memastikan kontrak mencakup klausul keamanan informasi
   - Menyertakan SLA untuk penanganan insiden keamanan
   - Memastikan adanya hak audit (right to audit) dalam kontrak

3. **Penerimaan Vendor** (IT Operations — Saat kontrak berlaku)

   - Memberikan akses sesuai prinsip least privilege
   - Memberikan pelatihan mengenai persyaratan keamanan organisasi
   - Mengaktifkan pemantauan terhadap aktivitas vendor

#### Pengelolaan Berkelanjutan:

1. **Pemantauan Kinerja** (Pengadaan — Triwulanan)

   - Meninjau kepatuhan vendor terhadap persyaratan keamanan
   - Meninjau laporan insiden dari vendor
   - Mengevaluasi temuan audit terkait vendor

2. **Perpanjangan Kontrak** (Pengadaan — Tahunan)

   - Mengevaluasi kembali postur keamanan vendor
   - Memperbarui persyaratan keamanan jika diperlukan

3. **Pemutusan Kontrak (Offboarding)** (IT Operations — Saat kontrak berakhir)

   - Mencabut seluruh akses yang diberikan kepada vendor
   - Melakukan serah terima data secara aman
   - Memperoleh sertifikat pemusnahan data dari vendor

---

## 3. Formulir dan Template

### Form-AM-01: Permintaan Pembuangan Aset
```
ID Permintaan: _____________________
Tanggal: ___________________________
Pemohon: ___________________________
Departemen: ________________________

Aset yang Akan Dibuang:

- Jenis (Perangkat Keras/Perangkat Lunak/Data): __________
- Deskripsi: ______________________
- Nomor Seri/ID: __________________
- Lokasi: __________________________

Alasan Pembuangan: ___________________
___________________________________

Nilai Aset: ________________________
Tanggal Pengadaan: _________________

Persetujuan:
___________________________
Manajer Departemen
Tanggal: __________

Metode Pembuangan: ___________________
Nomor Sertifikat: ____________________
Tanggal Pembuangan: __________________
```

### Form-AM-02: Klasifikasi Data
```
Nama Data/File: ____________________
Lokasi: ____________________________
Pemilik: ___________________________

Klasifikasi: □ Rahasia □ Internal □ Publik

Justifikasi: ________________________
___________________________________

Persyaratan Penanganan:
□ Enkripsi □ Kontrol Akses □ Backup
□ DLP □ Pencatatan Audit □ Lainnya: _____

Disetujui Oleh:
___________________________
Pemilik Data
Tanggal: __________
```

### Inventory-AM-01: Template Inventaris Aset
```
ID Aset | Nama | Jenis | Klasifikasi | Pemilik | Lokasi | Status | Nilai
--------|------|-------|-------------|---------|--------|--------|------
```

---

## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Integrasi CMDB**: Basis data aset terpusat yang memungkinkan pelacakan menyeluruh
- **Penemuan Otomatis**: Pemindaian jaringan secara berkala untuk mendeteksi perangkat keras baru
- **Implementasi DLP**: Penegakan aturan klasifikasi data secara otomatis
- **SLA Pemasok**: Persyaratan keamanan yang mengikat dalam setiap kontrak vendor

### 4.2 Pemantauan dan Audit

- Rekonsiliasi inventaris dilakukan setiap bulan
- Tinjauan kinerja pemasok dilaksanakan setiap triwulan
- Penilaian ulang nilai aset dan pembaruan asuransi dilakukan setiap tahun
- Jejak audit dipelihara untuk seluruh perubahan pada aset

### 4.3 Pelaporan Insiden

- Kehilangan atau pencurian aset: Respons dalam waktu 1 jam
- Pelanggaran keamanan data: Respons dalam waktu 1 jam
- Insiden yang melibatkan pemasok: Respons sesuai SLA yang tercantum dalam kontrak

---

## 5. Pemenuhan Standar

### Persyaratan Manajemen Aset:

- ✅ **AM-1**: Inventaris aset dipelihara melalui CMDB dengan pembaruan bulanan
- ✅ **AM-2**: Kepemilikan aset didefinisikan secara jelas dengan penetapan pemilik dan penanggung jawab
- ✅ **AM-3**: Klasifikasi data diterapkan dalam 3 tingkat dengan pelabelan yang konsisten
- ✅ **AM-4**: Penanganan informasi diatur melalui prosedur yang mencakup seluruh siklus hidup aset
- ✅ **AM-5**: Pembuangan yang aman dilaksanakan dengan pemusnahan bersertifikat dan pencatatan lengkap
- ✅ **AM-6**: Manajemen pemasok dilakukan melalui penilaian dan pemantauan berkala
- ✅ **AM-7**: Perlindungan kekayaan intelektual diterapkan melalui klasifikasi dan kontrol yang sesuai
- ✅ **AM-8**: Kontrol terhadap media lepas pasang (removable media) diterapkan melalui enkripsi dan pelacakan

---

## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Mengawasi keseluruhan manajemen aset dan menyetujui kebijakan |
| Manajer IT Operations | Mengelola inventaris dan pemeliharaan aset |
| Petugas IT Security | Melaksanakan klasifikasi dan pembuangan aset secara aman |
| Manajer Pengadaan | Mengelola hubungan dan kepatuhan pemasok |
| Kepala Departemen | Bertanggung jawab atas kepemilikan aset dalam departemennya |
| Pemilik Data | Menentukan klasifikasi dan mengawasi penanganan data |

---

## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan:** Dilakukan setiap tahun atau ketika terjadi perubahan signifikan
- **Tanggung Jawab Peninjauan:** Tim IT Operations dan Tim Security
- **Persetujuan Pembaruan:** ISM dan Manajemen

---

## 8. Lampiran

- Lampiran A: Matriks Klasifikasi Aset
- Lampiran B: Standar Pemusnahan Data
- Lampiran C: Kuesioner Keamanan Pemasok
- Lampiran D: Skema dan Struktur CMDB
- Lampiran E: Pedoman Penilaian Nilai Aset

---

**Disetujui Oleh:**

___________________________  
Heri Fauzan  
Manajer Keamanan Informasi  
Tanggal: __________________

___________________________  
Dodi Darundriyo  
Direktur Operasional / COO  
Tanggal: __________________
