# PROC-02: Prosedur Kontrol Akses
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROC-02: Prosedur Kontrol Akses
**Dokumen ID:** PROC-02
**Versi:** 1.0  
**Tanggal Berlaku:** 15 April 2026  
**Status:** Final  
**Tingkat Keamanan:** Confidential

## Lembar Pengesahan

| Jabatan | Nama | Tanda Tangan | Tanggal |
|
---------|------|-------------|--------|
| CEO |  |  |  |
| Manajer Keamanan Informasi |  |  |  |
| Manajer HR |  |  |  |

---

## Daftar Isi

- [1. Pendahuluan](#1-pendahuluan)
- [2. Prosedur Utama](#2-prosedur-utama)

---

## 1. Pendahuluan

Prosedur ini mengatur pengendalian akses ke sistem informasi PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001. Prosedur ini mencakup manajemen akses pengguna, kontrol akses fisik dan logis, serta audit akses secara berkala.

### 1.1 Tujuan
- Memastikan hanya pengguna yang berwenang dapat mengakses sistem dan data
- Mencegah akses tidak sah yang dapat menyebabkan pelanggaran keamanan
- Memenuhi persyaratan untuk kontrol akses yang ketat

### 1.2 Ruang Lingkup
Berlaku untuk semua sistem informasi, aplikasi, dan data perusahaan termasuk:
- Sistem ERP dan database internal
- Akses jaringan dan internet
- Akses fisik ke server room dan workstation
- Akses remote dan VPN

### 1.3 Referensi
- Tata Kelola dan Kebijakan Keamanan Informasi (Tata Kelola dan Kebijakan Keamanan Informasi.md)

---

## 2. Prosedur Utama

### 2.1 Prosedur Pemberian Akses Pengguna Baru

#### Langkah-langkah:
1. **Permintaan Akses** (HR/Admin)
   - Pengguna baru mengisi Formulir Permintaan Akses (Form-AK-01)
   - Manajer departemen menyetujui permintaan
   - HR mengirim permintaan ke Tim IT Security

2. **Verifikasi Identitas** (IT Security - 1 hari)
   - Verifikasi data karyawan di sistem HR
   - Validasi kebutuhan akses berdasarkan job description
   - Lakukan background check jika diperlukan

3. **Konfigurasi Akses** (IT Security - 2 hari)
   - Buat akun pengguna di sistem Active Directory
   - Tetapkan role dan permission sesuai prinsip least privilege
   - Konfigurasi akses aplikasi dan database

4. **Pelatihan dan Orientasi** (IT Security - 1 hari)
   - Berikan pelatihan keamanan akses kepada pengguna
   - Jelaskan hak dan tanggung jawab akses
   - Dokumentasikan dalam log pelatihan

5. **Aktivasi dan Pemantauan** (IT Security - Segera)
   - Aktivasi akun setelah pelatihan selesai
   - Monitor aktivitas awal pengguna selama 7 hari pertama

#### Waktu Total: 5 hari kerja
#### Tanggung Jawab:
- HR: Permintaan dan verifikasi awal
- IT Security: Implementasi teknis dan pemantauan
- Manajer: Persetujuan

### 2.2 Prosedur Penghapusan Akses

#### Langkah-langkah:
1. **Pemberitahuan Resign/Termination** (HR - Segera)
   - HR memberitahu IT Security tentang karyawan yang resign/terminated
   - Sertakan tanggal efektif termination

2. **Penonaktifan Sementara** (IT Security - Dalam 1 jam)
   - Disable akun Active Directory
   - Blokir akses VPN dan email
   - Catat dalam log akses

3. **Penghapusan Permanen** (IT Security - Dalam 24 jam)
   - Hapus akun dari semua sistem
   - Backup data penting sebelum penghapusan
   - Pembaruan dokumentasi akses

4. **Pengembalian Aset** (HR/IT - Dalam 24 jam)
   - Kumpulkan laptop, ID card, dan akses card
   - Lakukan wipe data pada device yang dikembalikan
   - Dokumentasikan pengembalian

#### Waktu Total: 24-48 jam
#### Tanggung Jawab:
- HR: Koordinasi dan pengembalian aset
- IT Security: Penonaktifan dan penghapusan akses

### 2.3 Prosedur Perubahan Akses

#### Langkah-langkah:
1. **Permintaan Perubahan** (Pengguna/Manajer)
   - Isi Formulir Perubahan Akses (Form-AK-02)
   - Jelaskan alasan perubahan dan akses tambahan/dikurangi

2. **Tinjauan dan Persetujuan** (Manajer/IT Security - 2 hari)
   - Manajer menyetujui perubahan
   - IT Security tinjauan teknis feasibility

3. **Implementasi** (IT Security - 1 hari)
   - Pembaruan permission di sistem
   - Test akses baru
   - Pembaruan dokumentasi

4. **Verifikasi** (Pengguna - Segera)
   - Pengguna test akses baru
   - Konfirmasi fungsionalitas

#### Waktu Total: 3 hari kerja

### 2.4 Prosedur Kontrol Akses Fisik

#### Langkah-langkah:
1. **Pendaftaran Akses Fisik** (Security Officer)
   - Verifikasi identitas dengan KTP/Karyawan ID
   - Foto untuk akses card

2. **Konfigurasi Akses Card** (Security System - Segera)
   - Program akses card dengan zone yang sesuai
   - Test akses ke area yang diizinkan

3. **Pemantauan Akses** (Security Officer - Berkelanjutan)
   - Monitor CCTV dan log akses
   - Investigasi akses mencurigakan

4. **Pembaruan Akses Fisik** (Security Officer - Berkala)
   - Tinjauan akses fisik setiap 6 bulan
   - Pembaruan akses berdasarkan perubahan jabatan

### 2.5 Prosedur Audit Akses

#### Langkah-langkah:
1. **Penjadwalan Audit** (IT Security - Bulanan)
   - Audit akses bulanan untuk privileged accounts
   - Audit triwulanan untuk semua akses

2. **Pelaksanaan Audit** (IT Security - 5 hari kerja)
   - Tinjauan log akses dan aktivitas
   - Identifikasi akses tidak sah atau tidak digunakan
   - Analisis pattern akses mencurigakan

3. **Pembuatan Laporan** (IT Security - 2 hari)
   - Dokumentasikan temuan
   - Rekomendasikan perbaikan

4. **Tindak Lanjut** (Manajemen - 30 hari)
   - Implementasi rekomendasi
   - Pembaruan prosedur jika diperlukan

#### Frekuensi: Bulanan untuk privileged, Triwulanan untuk umum

---

## 3. Formulir dan Template

### Form-AK-01: Permintaan Akses Pengguna Baru
```
Nama Lengkap: ___________________________
Departemen: _____________________________
Jabatan: ________________________________
Email: __________________________________
Akses Diperlukan:
□ Email
□ ERP System
□ Database Access
□ Server Access
□ Internet Access
□ VPN Access

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
Akses Baru Diperlukan: __________________
Akses Dihapus: __________________________

Alasan Perubahan: ______________________
___________________________

Disetujui Oleh:
___________________________
Manajer
Tanggal: __________
```

### Log-AK-01: Log Aktivitas Akses
```
Tanggal | Waktu | Pengguna | Aksi | Sistem | Status
--------|-------|----------|------|--------|--------
```

---

## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol
- **Role-Based Access Control (RBAC)**: Semua akses berdasarkan role jabatan
- **Least Privilege Principle**: Hanya akses minimum yang diperlukan
- **Multi-Factor Authentication (MFA)**: Wajib untuk akses remote dan privileged
- **Session Timeout**: Otomatis logout setelah 30 menit tidak aktif

### 4.2 Pemantauan dan Audit
- Log semua aktivitas akses dicatat dan disimpan minimal 2 tahun
- Alert otomatis untuk aktivitas mencurigakan
- Tinjauan log akses bulanan oleh IT Security
- Audit eksternal tahunan

### 4.3 Pelaporan Insiden
Jika ditemukan akses tidak sah:
1. Segera disable akses terkait
2. Investigasi penyebab
3. Laporkan ke ISM dalam 24 jam
4. Pembaruan prosedur pencegahan

---

## 5. Pemenuhan Standar

### Persyaratan untuk Access Control:
- ✅ **AC-1**: Access control kebijakan established - Kebijakan lengkap dengan persetujuan
- ✅ **AC-2**: Access rights managed - Prosedur pemberian/penghapusan akses
- ✅ **AC-3**: User access reviews - Audit bulanan dan triwulanan
- ✅ **AC-4**: Secure authentication - MFA dan Kebijakan kata sandi
- ✅ **AC-5**: Access logging and pemantauan - Log lengkap dengan alert
- ✅ **AC-6**: Akses jarak jauh security - VPN dengan MFA
- ✅ **AC-7**: Physical access controls - Akses card dan CCTV
- ✅ **AC-8**: Privileged access manajemen - Separate admin accounts

---

## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Oversight keseluruhan kontrol akses |
| Petugas Keamanan IT | Implementasi teknis dan pemantauan |
| Manajer HR | Koordinasi akses karyawan |
| Manajer Departemen | Persetujuan akses departemen |
| Petugas Keamanan | Kontrol akses fisik |
| Pengguna Akhir | Kepatuhan terhadap kebijakan akses |

---

## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan:** Tahunan atau saat ada perubahan signifikan
- **Tanggung Jawab Peninjauan:** IT Security Team
- **Persetujuan Pembaruan:** ISM dan Manajemen

---

## 8. Lampiran

- Lampiran A: Daftar Role dan Permission Matrix
- Lampiran B: Kebijakan kata sandi Detail
- Lampiran C: MFA Implementation Guide
- Lampiran D: Access Control System Architecture

---

**Disetujui Oleh:**

___________________________  
Heri Fauzan  
Manajer Keamanan Informasi  
Tanggal: __________________

___________________________  
Ahmad Firdaus  
CEO  
Tanggal: __________________