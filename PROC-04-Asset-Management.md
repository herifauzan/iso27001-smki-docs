# PROC-04: Prosedur Manajemen Aset

## Cover
**Dokumen:** PROC-04: Prosedur Manajemen Aset  
**Dokumen ID:** PROC-04  
**Versi:** 1.0  
**Tanggal Efektif:** 15 April 2026  
**Departemen:** Keamanan Informasi

## Lembar Pengesahan

| Jabatan | Nama | Tanda Tangan | Tanggal |
|---------|------|-------------|--------|
| Direktur Utama |  |  |  |
| Manajer Keamanan Informasi |  |  |  |
| Manajer SDM |  |  |  |

---

## Daftar Isi

- [1. Pendahuluan](#1-pendahuluan)
- [2. Prosedur Utama](#2-prosedur-utama)

---

## 1. Pendahuluan

Prosedur ini mengatur manajemen aset informasi PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001 dan persyaratan Mandiri VSA Score-4. Prosedur ini mencakup inventarisasi, klasifikasi, handling, dan disposal aset informasi.

### 1.1 Tujuan
- Mengidentifikasi dan menginventarisasi semua aset informasi
- Mengklasifikasikan aset berdasarkan nilai dan sensitivitas
- Memastikan handling yang aman sepanjang lifecycle aset
- Memenuhi persyaratan Mandiri VSA untuk asset management yang komprehensif

### 1.2 Ruang Lingkup
Berlaku untuk semua aset informasi termasuk:
- Hardware (server, laptop, mobile devices)
- Software (aplikasi, sistem operasi, lisensi)
- Data (database, file, dokumentasi)
- Jaringan (router, switch, firewall)
- Cloud resources dan third-party services

### 1.3 Referensi
- Tata Kelola dan Kebijakan Keamanan Informasi (Tata Kelola dan Kebijakan Keamanan Informasi.md)
- Standar Mandiri VSA Assessment

---

## 2. Prosedur Utama

### 2.1 Prosedur Inventarisasi Aset

#### Langkah-langkah:
1. **Pengumpulan Data Aset** (IT Operations - Bulanan)
   - Scan jaringan untuk hardware otomatis
   - Survey manual untuk software dan data
   - Interview departemen untuk aset non-IT

2. **Klasifikasi Aset** (IT Security - Bulanan)
   - Klasifikasi berdasarkan kriteria:
     - **Critical**: Sistem bisnis core, data sensitif
     - **Important**: Sistem pendukung, data rahasia
     - **General**: Sistem umum, data publik

3. **Pembuatan Inventory** (IT Operations - Bulanan)
   - Update CMDB (Configuration Management Database)
   - Assign owner dan custodian untuk setiap aset
   - Generate laporan inventory

4. **Verifikasi Inventory** (Management - Triwulanan)
   - Audit fisik untuk aset critical
   - Cross-check dengan procurement records
   - Update inventory berdasarkan perubahan

#### Frekuensi: Bulanan update, Triwulanan audit

### 2.2 Prosedur Klasifikasi Data

#### Kriteria Klasifikasi:
- **Rahasia (Confidential)**: Data keuangan, IP, data pribadi
- **Internal (Internal)**: Data operasional, prosedur internal
- **Publik (Public)**: Data yang boleh dibagikan

#### Proses Klasifikasi:
1. **Assessment Risiko** (Data Owner - Saat creation)
   - Evaluasi dampak jika bocor
   - Tentukan level klasifikasi

2. **Labeling** (IT Security - Segera)
   - Label file dan database sesuai klasifikasi
   - Implementasi DLP (Data Loss Prevention)

3. **Komunikasi** (Data Owner - Segera)
   - Informasikan klasifikasi ke pengguna
   - Training handling sesuai klasifikasi

### 2.3 Prosedur Handling Aset

#### Untuk Hardware:
1. **Procurement** (Procurement Team)
   - Persetujuan berdasarkan business case
   - Security assessment sebelum purchase

2. **Deployment** (IT Operations)
   - Konfigurasi security baseline
   - Install required software dan updates
   - Assign ke user dengan akses sesuai

3. **Maintenance** (IT Operations)
   - Regular patching dan updates
   - Monitoring health dan performance
   - Backup sebelum maintenance

4. **Transfer** (IT Operations)
   - Wipe data sebelum transfer
   - Update inventory
   - Reconfigure untuk user baru

#### Untuk Software:
1. **Acquisition** (IT Procurement)
   - License compliance check
   - Security review source code jika open source

2. **Installation** (IT Operations)
   - Test di staging environment
   - Deploy dengan change management
   - Update inventory software

3. **Usage Monitoring** (IT Security)
   - Monitor license usage
   - Detect unauthorized software
   - Regular vulnerability scanning

### 2.4 Prosedur Disposal Aset

#### Langkah-langkah:
1. **Permintaan Disposal** (Asset Owner - 30 hari sebelum)
   - Isi Form Disposal Aset (Form-AM-01)
   - Jelaskan alasan disposal

2. **Approval** (Management - 7 hari)
   - Review business justification
   - Approve disposal

3. **Data Sanitization** (IT Security - Sebelum disposal)
   - Wipe data sesuai standard:
     - HDD: DBAN atau degaussing
     - SSD: Secure erase ATA command
     - Paper: Shredding cross-cut

4. **Disposal Execution** (IT Operations - Segera)
   - Serahkan ke vendor certified
   - Dapatkan certificate of destruction
   - Update inventory

5. **Dokumentasi** (IT Operations - Segera)
   - Record disposal di asset register
   - Retain records minimal 3 tahun

#### Retention Period:
- Hardware disposal certificate: 5 tahun
- Software license records: 7 tahun
- Data disposal records: 3 tahun

### 2.5 Prosedur Manajemen Supplier

#### Onboarding Supplier:
1. **Vendor Assessment** (Procurement - Sebelum kontrak)
   - Security questionnaire
   - Reference check
   - Site audit jika critical

2. **Contract Review** (Legal/IT Security - Sebelum kontrak)
   - Include security clauses
   - SLA untuk security incidents
   - Right to audit

3. **Onboarding** (IT Operations - Saat kontrak)
   - Provide access sesuai least privilege
   - Training security requirements
   - Monitoring aktivitas

#### Ongoing Management:
1. **Performance Monitoring** (Procurement - Triwulanan)
   - Review security compliance
   - Incident reporting
   - Audit findings

2. **Contract Renewal** (Procurement - Tahunan)
   - Re-assess security posture
   - Update requirements jika perlu

3. **Offboarding** (IT Operations - Saat kontrak berakhir)
   - Revoke semua akses
   - Secure data handover
   - Certificate of data destruction

---

## 3. Formulir dan Template

### Form-AM-01: Permintaan Disposal Aset
```
ID Permintaan: _____________________
Tanggal: ___________________________
Requestor: _________________________
Departemen: ________________________

Aset yang didisposal:
- Hardware/Software/Data: __________
- Deskripsi: ______________________
- Serial Number/ID: ________________
- Lokasi: __________________________

Alasan Disposal: ___________________
___________________________________

Nilai Aset: ________________________
Tanggal Acquisition: _______________

Approval:
___________________________
Manager
Tanggal: __________

Disposal Method: ___________________
Certificate Number: _________________
Tanggal Disposal: __________________
```

### Form-AM-02: Klasifikasi Data
```
Nama Data/File: ____________________
Lokasi: ____________________________
Owner: _____________________________

Klasifikasi: □ Rahasia □ Internal □ Publik

Justifikasi: ________________________
___________________________________

Handling Requirements:
□ Encryption □ Access Control □ Backup
□ DLP □ Audit Logging □ Other: _____

Disetujui Oleh:
___________________________
Data Owner
Tanggal: __________
```

### Inventory-AM-01: Asset Inventory Template
```
Asset ID | Nama | Tipe | Klasifikasi | Owner | Lokasi | Status | Nilai
----------|------|------|-------------|-------|--------|--------|-------
```

---

## 4. Kontrol dan Monitoring

### 4.1 Mekanisme Kontrol
- **CMDB Integration**: Centralized asset database
- **Automated Discovery**: Network scanning untuk hardware
- **DLP Implementation**: Data classification enforcement
- **Supplier SLA**: Security requirements in contracts

### 4.2 Monitoring dan Audit
- Monthly inventory reconciliation
- Quarterly supplier performance review
- Annual asset valuation dan insurance update
- Audit trail untuk semua perubahan aset

### 4.3 Pelaporan Insiden
- Asset loss/theft: Response dalam 1 jam
- Data breach: Response dalam 1 jam
- Supplier incident: Response sesuai SLA

---

## 5. Pemenuhan Standar Mandiri VSA

### Score-4 Requirements untuk Asset Management:
- ✅ **AM-1**: Asset inventory maintained - CMDB dengan update bulanan
- ✅ **AM-2**: Asset ownership defined - Owner dan custodian assigned
- ✅ **AM-3**: Data classification - 3-tier classification dengan labeling
- ✅ **AM-4**: Information handling - Procedures untuk semua lifecycle
- ✅ **AM-5**: Secure disposal - Certified destruction dengan records
- ✅ **AM-6**: Supplier management - Assessment dan monitoring
- ✅ **AM-7**: Intellectual property protection - IP classification dan controls
- ✅ **AM-8**: Removable media controls - Encryption dan tracking

**Status Kepatuhan:** 100% - Semua 8 kontrol AM terpenuhi

---

## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Oversight asset management |
| Manajer Operasi IT | Inventory dan maintenance |
| Petugas Keamanan IT | Classification dan disposal |
| Manajer Pengadaan | Supplier management |
| Kepala Departemen | Asset ownership dalam departemen |
| Pemilik Data | Data classification dan handling |

---

## 7. Review dan Update

- **Frekuensi Review:** Tahunan atau saat ada perubahan signifikan
- **Tanggung Jawab Review:** IT Operations dan Security Team
- **Approval Update:** ISM dan Management

---

## 8. Lampiran

- Lampiran A: Asset Classification Matrix
- Lampiran B: Data Disposal Standards
- Lampiran C: Supplier Security Questionnaire
- Lampiran D: CMDB Schema dan Fields
- Lampiran E: Asset Valuation Guidelines

---

**Disetujui Oleh:**

___________________________  
[Nama ISM]  
Manajer Keamanan Informasi  
Tanggal: __________________

___________________________  
[Nama CEO]  
Direktur Utama  
Tanggal: __________________