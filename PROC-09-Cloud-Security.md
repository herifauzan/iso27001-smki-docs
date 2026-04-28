# PROSEDUR KEAMANAN CLOUD
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROSEDUR KEAMANAN CLOUD
**Dokumen ID:** PROC-09
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
  - [2.1 Cloud Onboarding](#21-cloud-onboarding)
  - [2.2 Shared Responsibility Model](#22-shared-responsibility-model)
  - [2.3 Data Location & Residency](#23-data-location--residency)
- [3. Formulir dan Template](#3-formulir-dan-template)
- [4. Kontrol dan Pemantauan](#4-kontrol-dan-pemantauan)
- [5. Pemenuhan Standar](#5-pemenuhan-standar)
- [6. Tanggung Jawab](#6-tanggung-jawab)
- [7. Tinjauan dan Pembaruan](#7-tinjauan-dan-pembaruan)


## 1. Pendahuluan

Prosedur ini mengatur tata cara penggunaan, pengelolaan, dan pengamanan layanan cloud (IaaS, PaaS, SaaS) di lingkungan PT Ecomindo Sarana Cipta. Penggunaan layanan cloud harus mematuhi kebijakan keamanan informasi organisasi untuk meminimalkan risiko terkait kerahasiaan, integritas, dan ketersediaan data.

### 1.1 Tujuan

- Memastikan setiap penggunaan layanan cloud melalui proses persetujuan dan onboarding yang resmi.
- Memperjelas batasan tanggung jawab keamanan antara penyedia layanan cloud (Cloud Service Provider/CSP) dan PT Ecomindo.
- Menjamin kepatuhan penyimpanan data sensitif terhadap regulasi lokasi data (Data Residency).

### 1.2 Ruang Lingkup

Prosedur ini berlaku untuk:

- Seluruh pengajuan penggunaan layanan cloud baru.
- Seluruh layanan cloud yang saat ini digunakan oleh organisasi.
- Seluruh karyawan, vendor, dan pihak ketiga yang mengelola atau menggunakan layanan cloud organisasi.
- Semua data organisasi yang disimpan atau diproses di lingkungan cloud.

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (GOV-POL-TK3I.md), Area 5: Manajemen Aset & Pengamanan Data (Cloud Data Security Policy)
- PROC-02-Access-Control.md (Prosedur Pengendalian Akses Cloud dan IAM)


## 2. Prosedur Utama

### 2.1 Cloud Onboarding

**Kebijakan:**

- Setiap penggunaan cloud (IaaS, PaaS, SaaS) **wajib** melalui proses onboarding resmi.
- **Tidak diperbolehkan** penggunaan atau pengadaan layanan cloud jenis apa pun (termasuk *Shadow IT*) tanpa persetujuan (approval) resmi dari tim IT dan Keamanan Informasi.

#### Langkah-langkah:

1. **Pengajuan Kebutuhan Cloud** (User / Business Owner)
   - Mengisi Formulir Pengajuan Layanan Cloud (Form-CS-01).
   - Menjelaskan justifikasi bisnis, jenis data yang akan diproses, dan layanan yang dibutuhkan.

2. **Review dan Penilaian Risiko** (IT & IT Security)
   - Melakukan evaluasi terhadap penyedia layanan cloud yang diajukan (sertifikasi keamanan seperti ISO 27001, SOC 2).
   - Meninjau kepatuhan layanan terhadap kebijakan keamanan PT Ecomindo.
   - Memberikan persetujuan atau penolakan dengan justifikasi.

3. **Setup Environment** (IT Operations / Cloud Administrator)
   Setelah disetujui, IT Operations akan melakukan pengaturan awal:
   - **Subscription/Account:** Membuat akun resmi perusahaan, tidak menggunakan akun email pribadi.
   - **Resource Grouping:** Mengatur isolasi resource berdasarkan proyek, departemen, atau lingkungan (Dev/Staging/Prod).
   - **Network Configuration:** Mengkonfigurasi VPC, subnet, security group, aturan firewall, dan akses VPN/Direct Connect jika diperlukan.
   - **Identity & Access:** Menerapkan kontrol akses berbasis peran (RBAC) dan mewajibkan MFA untuk semua pengguna cloud (Sesuai PROC-02).

4. **Aktivasi Monitoring & Logging** (IT Security / SOC)
   - Mengintegrasikan log aktivitas cloud (seperti AWS CloudTrail, Azure Monitor) dengan SIEM terpusat.
   - Mengaktifkan peringatan (alerts) untuk aktivitas anomali (misalnya login dari lokasi tak dikenal, pembuatan resource diluar batas).

### 2.2 Shared Responsibility Model (Model Tanggung Jawab Bersama)

**Kebijakan:**

- Perusahaan memahami, mendokumentasikan, dan mematuhi pembagian tanggung jawab keamanan antara penyedia layanan cloud (CSP) dan pengguna (PT Ecomindo) sesuai dengan jenis layanan yang digunakan (IaaS, PaaS, SaaS).

**Contoh Matriks Tanggung Jawab (IaaS):**

| Area Keamanan | Tanggung Jawab Provider | Tanggung Jawab Perusahaan |
|---|:---:|:---:|
| Infrastruktur fisik & Fasilitas | âœ” | âœ– |
| Perangkat Keras & Jaringan Dasar | âœ” | âœ– |
| Virtualization Layer | âœ” | âœ– |
| OS & Aplikasi (Patching, Konfigurasi) | âœ– | âœ” |
| Data (Enkripsi, Klasifikasi, Backup) | âœ– | âœ” |
| Identity & Access Management | âœ– | âœ” |
| Network Traffic & Firewall Configuration | âœ– | âœ” |

#### Langkah-langkah:

1. **Dokumentasi Tanggung Jawab per Layanan** (IT Security)
   - Setiap kali layanan cloud baru disetujui, matriks Shared Responsibility harus didokumentasikan dan disesuaikan dengan jenis layanan.
   - Mendefinisikan kontrol teknis spesifik yang menjadi tanggung jawab internal PT Ecomindo.

2. **Sosialisasi ke Tim IT dan User** (IT Security)
   - Memastikan tim operasional (SysOps, DevOps) memahami area yang wajib mereka kelola (misalnya patch OS pada IaaS, manajemen konfigurasi database pada PaaS).
   - Memberikan panduan pengamanan sesuai tanggung jawab yang diemban.

### 2.3 Data Location & Residency

**Kebijakan:**

- Data sensitif, khususnya Data Pribadi dan data keuangan, **wajib** disimpan di lokasi geografis yang sesuai dengan regulasi yang berlaku (misalnya, server/region yang berada di dalam wilayah hukum Indonesia sesuai UU PDP atau regulasi sektoral lainnya).
- **Dilarang keras** memindahkan, mereplikasi, atau mencadangkan data sensitif ke region/lokasi luar wilayah yang disetujui tanpa persetujuan tertulis dari ISM dan Legal/Compliance.

#### Langkah-langkah:

1. **Klasifikasi Data yang akan Disimpan di Cloud** (Data Owner)
   - Menentukan tingkat klasifikasi data (Terbatas/Restricted, Rahasia, Internal, Publik) sesuai prosedur di PROC-04.
   - Mengidentifikasi apakah data mengandung informasi pribadi (PII) atau informasi finansial yang tunduk pada aturan pelokalan data.

2. **Penentuan Lokasi Penyimpanan (Region)** (IT Security & IT Operations)
   - Mengonfigurasi pengaturan region/lokasi penyimpanan cloud agar sesuai dengan hasil klasifikasi.
   - **Region Lokal (Wajib):** Untuk data berklasifikasi "Terbatas" atau data yang diatur regulasi (harus disimpan di region Indonesia, misal: `ap-southeast-3` untuk AWS Jakarta).
   - Menonaktifkan fitur replikasi otomatis ke region luar negeri (geo-replication cross-border) untuk data sensitif.

3. **Monitoring Lokasi Data Berkala** (IT Security / Compliance)
   - Melakukan audit berkala (triwulanan) untuk memverifikasi bahwa resource data (database, object storage) tetap berada di region yang diizinkan.
   - Memanfaatkan alat compliance management dari penyedia cloud (misal AWS Config, Azure Policy) untuk mencegah pembuatan resource penyimpanan di region yang tidak sah.


## 3. Formulir dan Template

### Form-CS-01: Formulir Pengajuan Layanan Cloud (Cloud Onboarding)
```text
Tanggal Pengajuan: _______________________
Nama Pemohon: __________________________
Departemen: _____________________________

1. DETAIL LAYANAN
Nama Layanan Cloud: ______________________
Jenis Layanan: [ ] IaaS  [ ] PaaS  [ ] SaaS
Penyedia Layanan (Vendor): _______________

2. JUSTIFIKASI BISNIS
Tujuan Penggunaan: _______________________
________________________________________

3. KEBUTUHAN DATA
Jenis Data yang akan disimpan:
[ ] Terbatas/Restricted  [ ] Rahasia
[ ] Internal             [ ] Publik
Apakah mengandung Data Pribadi (PII)? [ ] Ya  [ ] Tidak

4. PERSETUJUAN
[ ] Disetujui  [ ] Ditolak
Alasan/Catatan: ___________________________

___________________________      ___________________________
Reviewer (IT Operations)         Penyetuju (IT Security / ISM)
Tanggal: _______________         Tanggal: _______________
```


## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Cloud Governance Policies:** Penerapan kebijakan otomatis (Infrastructure as Code / Policy as Code) yang membatasi region (lokasi) pembuatan resource.
- **Approval Gate:** Tidak ada pembelian atau aktivasi cloud tanpa persetujuan tercatat.
- **MFA Enforcement:** Paksaan teknis pada level cloud directory agar semua pengguna mengaktifkan MFA.

### 4.2 Pemantauan

- Log audit (Audit Trails) cloud dikirim dan dipantau terpusat.
- Pemindaian postur keamanan cloud (Cloud Security Posture Management / CSPM) dijalankan rutin untuk mendeteksi salah konfigurasi (misal: S3 bucket yang terbuka untuk publik).


## 5. Pemenuhan Standar

### Persyaratan Keamanan Cloud:

- **CS-1**: Seluruh layanan cloud telah melalui proses penilaian risiko dan persetujuan formal.
- **CS-2**: Lingkungan cloud dikonfigurasi menggunakan standar keamanan yang disetujui sebelum digunakan (Resource grouping, network, logging).
- **CS-3**: Model tanggung jawab bersama didokumentasikan untuk setiap layanan.
- **CS-4**: Lokasi penyimpanan data (Data Residency) diatur, dipantau, dan mematuhi regulasi perundang-undangan (mis. UU PDP).
- **CS-5**: Audit postur keamanan cloud dilakukan secara berkala.


## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| **User / Business Owner** | Mengajukan kebutuhan cloud dan mengklasifikasikan data. |
| **IT Security / ISM** | Melakukan evaluasi risiko vendor, mendefinisikan tanggung jawab bersama, dan menyetujui pengajuan. |
| **IT Operations / Cloud Admin**| Melakukan konfigurasi teknis (network, IAM, region) sesuai kebijakan. |
| **Data Owner** | Memastikan klasifikasi data akurat untuk penentuan lokasi region penyimpanan. |


## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan Prosedur:** Tahunan, atau apabila terjadi perubahan besar pada lingkungan arsitektur cloud perusahaan atau regulasi nasional.
- **Tanggung Jawab Peninjauan:** Tim IT Security dan IT Operations.
- **Persetujuan Pembaruan:** Manajer Keamanan Informasi (ISM) dan COO.

**AKHIR DOKUMEN PROSEDUR**


*Dokumen ini bersifat Confidential dan hanya diperuntukkan bagi kebutuhan internal PT ECOMINDO SARANA CIPTA. Distribusi tanpa izin dari ISM dilarang.*


Tanggal Berlaku: 15 April 2026  
Tinjauan Selanjutnya: 15 April 2027
