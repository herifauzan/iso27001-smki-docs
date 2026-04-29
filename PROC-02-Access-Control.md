# PROSEDUR PENGENDALIAN AKSES
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROSEDUR PENGENDALIAN AKSES
**Dokumen ID:** PROC-02
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

Prosedur ini mengatur pengendalian akses terhadap sistem informasi PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001. Prosedur ini mencakup manajemen akses pengguna, kontrol akses fisik dan logis, serta pelaksanaan audit akses secara berkala untuk menjamin keamanan data dan sistem organisasi.

### 1.1 Tujuan

- Memastikan bahwa hanya pengguna yang berwenang dapat mengakses sistem dan data organisasi
- Mencegah akses tidak sah yang berpotensi menyebabkan pelanggaran keamanan informasi
- Memenuhi persyaratan pengendalian akses yang ketat sesuai standar keamanan informasi

### 1.2 Ruang Lingkup

Prosedur ini berlaku untuk seluruh sistem informasi, aplikasi, dan data perusahaan, termasuk:

- Sistem ERP dan basis data internal
- Akses jaringan dan internet
- Akses fisik ke ruang server dan workstation
- Akses jarak jauh dan VPN

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (GOV-POL-TK3I), khususnya Area 6: Pengendalian Akses & Identitas


## 2. Prosedur Utama

### 2.1 Prosedur Pemberian Akses Pengguna Baru

#### Langkah-langkah:

1. **Permintaan Akses** (HR/Admin)

   - Pengguna baru mengisi Formulir Permintaan Akses (Form-AK-01)
   - Manajer departemen meninjau dan menyetujui permintaan tersebut
   - HR mengirimkan permintaan yang telah disetujui kepada Tim IT Security

2. **Verifikasi Identitas** (IT Security - 1 hari kerja)

   - Memverifikasi data karyawan dengan sistem HR
   - Memvalidasi kebutuhan akses berdasarkan deskripsi jabatan dan prinsip least privilege
   - Melakukan pemeriksaan latar belakang tambahan jika diperlukan

3. **Konfigurasi Akses** (IT Security - 2 hari kerja)

   - Membuat akun pengguna di sistem Active Directory
   - Menetapkan role dan permission sesuai prinsip least privilege
   - Mengonfigurasi akses ke aplikasi dan basis data yang relevan

4. **Pelatihan dan Orientasi** (IT Security - 1 hari kerja)

   - Memberikan pelatihan keamanan akses kepada pengguna baru
   - Menjelaskan hak dan tanggung jawab terkait akses yang diberikan
   - Mendokumentasikan pelaksanaan pelatihan dalam log pelatihan

5. **Aktivasi dan Pemantauan** (IT Security - Segera)

   - Mengaktifkan akun setelah pelatihan selesai
   - Memantau aktivitas awal pengguna selama 7 hari pertama untuk mendeteksi anomali

#### Waktu Total: 5 hari kerja
#### Tanggung Jawab:

- HR: Permintaan dan verifikasi awal data karyawan
- IT Security: Implementasi teknis, konfigurasi, dan pemantauan
- Manajer Departemen: Persetujuan permintaan akses

### 2.2 Prosedur Penghapusan Akses

#### Langkah-langkah:

1. **Pemberitahuan Pengunduran Diri / Pemutusan Hubungan Kerja** (HR - Segera)

   - HR memberitahu IT Security mengenai karyawan yang mengundurkan diri atau diberhentikan
   - Pemberitahuan harus menyertakan tanggal efektif pemutusan hubungan kerja

2. **Penonaktifan Sementara** (IT Security - Dalam 1 jam)

   - Menonaktifkan akun Active Directory karyawan terkait
   - Memblokir akses VPN dan email
   - Mencatat seluruh tindakan dalam log akses

3. **Penghapusan Permanen** (IT Security - Dalam 24 jam)

   - Menghapus akun dari seluruh sistem yang digunakan
   - Melakukan backup data penting sebelum penghapusan
   - Memperbarui dokumentasi akses organisasi

4. **Pengembalian Aset** (HR/IT - Dalam 24 jam)

   - Mengumpulkan laptop, kartu identitas, dan kartu akses
   - Melakukan penghapusan data (wipe) pada perangkat yang dikembalikan
   - Mendokumentasikan proses pengembalian secara lengkap

#### Waktu Total: 24-48 jam
#### Tanggung Jawab:

- HR: Koordinasi keseluruhan dan pengembalian aset
- IT Security: Penonaktifan dan penghapusan akses teknis

### 2.3 Prosedur Perubahan Akses

#### Langkah-langkah:

1. **Permintaan Perubahan** (Pengguna/Manajer)

   - Mengisi Formulir Perubahan Akses (Form-AK-02)
   - Menjelaskan alasan perubahan serta akses yang ditambahkan atau dikurangi

2. **Tinjauan dan Persetujuan** (Manajer/IT Security - 2 hari kerja)

   - Manajer departemen meninjau dan menyetujui perubahan
   - IT Security melakukan tinjauan teknis terhadap kelayakan perubahan

3. **Implementasi** (IT Security - 1 hari kerja)

   - Memperbarui permission di sistem sesuai perubahan yang disetujui
   - Menguji akses baru untuk memastikan fungsionalitas yang benar
   - Memperbarui dokumentasi akses

4. **Verifikasi** (Pengguna - Segera)

   - Pengguna menguji akses baru yang telah diberikan
   - Mengonfirmasi bahwa fungsionalitas berjalan sesuai harapan

#### Waktu Total: 3 hari kerja

### 2.4 Prosedur Kontrol Akses Fisik

#### Langkah-langkah:

1. **Pendaftaran Akses Fisik** (Security Officer)

   - Memverifikasi identitas karyawan dengan KTP atau kartu identitas perusahaan
   - Mengambil foto untuk pembuatan kartu akses

2. **Konfigurasi Kartu Akses** (Sistem Keamanan - Segera)

   - Memprogram kartu akses dengan zona yang sesuai dengan peran karyawan
   - Menguji akses ke area yang diizinkan untuk memastikan konfigurasi benar

3. **Pemantauan Akses** (Security Officer - Berkelanjutan)

   - Memantau CCTV dan log akses secara kontinu
   - Menginvestigasi setiap akses yang mencurigakan

4. **Pembaruan Akses Fisik** (Security Officer - Berkala)

   - Meninjau akses fisik setiap 6 bulan
   - Memperbarui akses berdasarkan perubahan jabatan atau penugasan

### 2.5 Prosedur Audit Akses

#### Langkah-langkah:

1. **Penjadwalan Audit** (IT Security - Bulanan)

   - Audit akses bulanan untuk akun dengan hak istimewa (privileged accounts)
   - Audit triwulanan untuk seluruh akses pengguna

2. **Pelaksanaan Audit** (IT Security - 5 hari kerja)

   - Meninjau log akses dan aktivitas pengguna
   - Mengidentifikasi akses yang tidak sah atau tidak lagi digunakan
   - Menganalisis pola akses yang mencurigakan

3. **Pembuatan Laporan** (IT Security - 2 hari kerja)

   - Mendokumentasikan seluruh temuan audit
   - Merumuskan rekomendasi perbaikan

4. **Tindak Lanjut** (Manajemen - 30 hari)

   - Mengimplementasikan rekomendasi yang disetujui
   - Memperbarui prosedur jika diperlukan

#### Frekuensi: Bulanan untuk akun dengan hak istimewa, triwulanan untuk akun umum

### 2.6 Prosedur Pengendalian Akses Cloud dan IAM

#### Latar Belakang:

PT Ecomindo menggunakan layanan cloud (IaaS/PaaS/SaaS). Pengelolaan identitas dan akses pada lingkungan cloud memerlukan kontrol yang setara dengan sistem on-premise.

#### Langkah-langkah:

1. **Manajemen Akun Cloud** (IT Security - Berkelanjutan)

   - Seluruh akun cloud (AWS, Azure, GCP, atau setara) dikelola dengan prinsip yang sama seperti akun on-premise: pembuatan, perubahan, dan penonaktifan melalui proses formal
   - Akun layanan (service account) untuk aplikasi dibuat terpisah dari akun pengguna manusia
   - Tidak ada akun yang berbagi kredensial antar pengguna

2. **MFA Wajib untuk Akun Cloud** (IT Security - Sebelum akses diberikan)

   - Multi-Factor Authentication (MFA) **wajib** diaktifkan untuk **seluruh** akun cloud tanpa pengecualian, termasuk:
     - Akun administrator dan akun dengan hak istimewa
     - Akun human (pengguna nyata)
     - Akun root/superuser
   - Jenis MFA yang digunakan: TOTP (Google Authenticator, Microsoft Authenticator) atau hardware token (Yubikey)
   - Kode backup MFA harus dibuat dan disimpan dengan aman di brankas kata sandi

3. **Pemisahan Tugas (Separation of Duties)** (IT Security - Saat konfigurasi)

   - Akun admin cloud dipisahkan berdasarkan fungsi:
     - Contoh: akun terpisah untuk Billing vs Security vs Development
   - Satu akun tidak boleh memiliki kendali penuh atas seluruh lingkungan cloud
   - Matriks akun admin dan privilege-nya didokumentasikan dan ditinjau triwulanan

4. **Rotasi Kredensial Cloud** (IT Security - Rutin)

   - API key dan access token dirotasi minimal setiap 90 hari
   - Kredensial yang tidak aktif lebih dari 90 hari dicabut secara otomatis
   - Pembaruan kredensial dilakukan tanpa gangguan layanan menggunakan secrets management

#### Frekuensi: Pemantauan berkelanjutan, tinjauan triwulanan


## 3. Formulir dan Template

### Form-AK-01: Permintaan Akses Pengguna Baru
```
Nama Lengkap: ___________________________
Departemen: _____________________________
Jabatan: ________________________________
Email: __________________________________
Akses yang Diperlukan:
□ Email
□ Sistem ERP
□ Akses Basis Data
□ Akses Server
□ Akses Internet
□ Akses VPN

Alasan: _________________________________
___________________________
Tanda Tangan Pemohon

Disetujui Oleh:
___________________________
Manajer Departemen
Tanggal: __________

Dikonfigurasi Oleh:
___________________________
IT Security Officer
Tanggal: __________
```

### Form-AK-02: Perubahan Akses
```
Nama: ___________________________________
Akses Saat Ini: _________________________
Akses Baru yang Diperlukan: ______________
Akses yang Dihapus: _____________________

Alasan Perubahan: ______________________
___________________________

Disetujui Oleh:
___________________________
Manajer Departemen
Tanggal: __________
```

### Log-AK-01: Log Aktivitas Akses
```
Tanggal | Waktu | Pengguna | Tindakan | Sistem | Status
--------|-------|----------|----------|--------|--------
```


## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Role-Based Access Control (RBAC)**: Seluruh akses diberikan berdasarkan peran jabatan karyawan
- **Prinsip Least Privilege**: Setiap pengguna hanya diberikan akses minimum yang diperlukan untuk menjalankan tugasnya
- **Multi-Factor Authentication (MFA)**: Wajib untuk akses jarak jauh, akun dengan hak istimewa, dan **seluruh akun cloud**
- **Session Timeout**: Sesi pengguna secara otomatis berakhir setelah 30 menit tanpa aktivitas

**Kebijakan Kata Sandi (sesuai GOV-POL-TK3I Area 8.3.1.A):**

| Parameter | Ketentuan |
|-----------|----------|
| Panjang minimum | 12 karakter (15+ direkomendasikan) |
| Kompleksitas | Wajib mengandung huruf besar, huruf kecil, angka, dan simbol |
| Masa berlaku | Kadaluwarsa setiap **90 hari** |
| Riwayat | Tidak dapat menggunakan ulang **5 kata sandi terakhir** |
| Penguncian akun | Akun dikunci setelah **3-5 percobaan gagal** selama 30 menit |
| Kata sandi admin | Unik per sistem, disimpan di vault, dirotasi setiap 90 hari |
| Kata sandi akun layanan | Disimpan di secrets manager, tidak hardcoded, dirotasi triwulanan |

**Kebijakan Sertifikat VPN:**

- Sertifikat VPN bersifat unik per pengguna (tidak boleh berbagi sertifikat)
- Sertifikat menggunakan enkripsi minimum RSA 2048-bit atau ECC 256-bit
- Sertifikat dirotasi setiap **1 tahun**
- Sertifikat dicabut segera saat karyawan mengalami pemutusan hubungan kerja
- Cadangan sertifikat disimpan di lokasi aman yang terenkripsi

**Standar Enkripsi:**

- Seluruh koneksi jaringan menggunakan **TLS 1.2 atau lebih baru** (TLS 1.0 dan 1.1 dinonaktifkan)
- VPN menggunakan enkripsi **AES-256** minimum
- Data sensitif at-rest dienkripsi dengan **AES-256**

### 4.2 Pemantauan dan Audit

- Seluruh aktivitas akses dicatat dalam log dan disimpan minimal 2 tahun
- Sistem peringatan otomatis diaktifkan untuk mendeteksi aktivitas mencurigakan
- Tinjauan log akses dilakukan setiap bulan oleh IT Security
- Audit eksternal dilaksanakan setiap tahun

### 4.3 Pelaporan Insiden

Jika ditemukan akses yang tidak sah, langkah-langkah berikut harus segera dilakukan:

1. Menonaktifkan akses terkait secara segera
2. Melakukan investigasi untuk menentukan penyebab
3. Melaporkan insiden kepada ISM dalam waktu maksimal 24 jam
4. Memperbarui prosedur pencegahan berdasarkan hasil investigasi


## 5. Pemenuhan Standar

### Persyaratan Pengendalian Akses:

- ✅ **AC-1**: Kebijakan pengendalian akses telah ditetapkan secara lengkap dengan persetujuan manajemen
- ✅ **AC-2**: Hak akses dikelola melalui prosedur pemberian dan penghapusan akses yang formal
- ✅ **AC-3**: Tinjauan akses pengguna dilaksanakan secara bulanan dan triwulanan
- ✅ **AC-4**: Otentikasi yang aman diterapkan melalui MFA, kebijakan kata sandi kuat (min 12 karakter, 90 hari), dan penguncian akun
- ✅ **AC-5**: Pencatatan dan pemantauan akses dilengkapi dengan sistem peringatan otomatis
- ✅ **AC-6**: Keamanan akses jarak jauh dijamin melalui VPN (AES-256) + MFA + sertifikat per pengguna
- ✅ **AC-7**: Kontrol akses fisik diterapkan melalui kartu akses dan pemantauan CCTV
- ✅ **AC-8**: Akses dengan hak istimewa dikelola melalui akun administratif terpisah
- ✅ **AC-9**: Pengendalian akses cloud diterapkan melalui IAM, MFA wajib, dan pemisahan tugas
- ✅ **AC-10**: Sertifikat VPN dikelola dengan rotasi tahunan dan pencabutan saat terminasi


## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Mengawasi keseluruhan pengendalian akses dan menyetujui kebijakan |
| Petugas IT Security | Melaksanakan implementasi teknis dan pemantauan akses |
| Manajer HR | Mengoordinasikan akses karyawan dan proses pengembalian aset |
| Manajer Departemen | Memberikan persetujuan akses untuk anggota departemennya |
| Security Officer | Mengelola kontrol akses fisik ke fasilitas |
| Pengguna Akhir | Mematuhi kebijakan akses dan melaporkan insiden |


## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan:** Dilakukan setiap tahun atau ketika terjadi perubahan signifikan terhadap sistem atau kebijakan
- **Tanggung Jawab Peninjauan:** Tim IT Security
- **Persetujuan Pembaruan:** ISM dan Manajemen


## 8. Lampiran

- Lampiran A: Matriks Role dan Permission
- Lampiran B: Detail Kebijakan Kata Sandi
- Lampiran C: Panduan Implementasi MFA
- Lampiran D: Arsitektur Sistem Pengendalian Akses

**AKHIR DOKUMEN PROSEDUR**


*Dokumen ini bersifat Confidential dan hanya diperuntukkan bagi kebutuhan internal PT ECOMINDO SARANA CIPTA. Distribusi tanpa izin dari ISM dilarang.*


Tanggal Berlaku: 15 April 2026  
Tinjauan Selanjutnya: 15 April 2027