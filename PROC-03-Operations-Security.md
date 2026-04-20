# PROC-03: Prosedur Keamanan Operasi
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROC-03: Prosedur Keamanan Operasi
**Dokumen ID:** PROC-03
**Versi:** 1.0  
**Tanggal Berlaku:** 15 April 2026  
**Status:** Final  
**Tingkat Keamanan:** Confidential

## Lembar Pengesahan

| Jabatan | Nama | Tanda Tangan | Tanggal |
|---------|------|-------------|--------|
| Direktur Utama |  |  |  |
| Manajer Keamanan Informasi |  |  |  |
| Manajer HR |  |  |  |

---

## Daftar Isi

- [1. Pendahuluan](#1-pendahuluan)
- [2. Prosedur Utama](#2-prosedur-utama)

---

## 1. Pendahuluan

Prosedur ini mengatur keamanan operasi sistem informasi PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001. Prosedur ini mencakup manajemen operasi harian, backup data, logging, proteksi malware, dan kontrol perubahan.

### 1.1 Tujuan

- Memastikan operasi sistem informasi berjalan aman dan handal
- Melindungi data dari kehilangan atau kerusakan
- Mendeteksi dan merespons insiden keamanan secara efektif
- Memenuhi persyaratan untuk operasi yang aman

### 1.2 Ruang Lingkup
Berlaku untuk semua operasi sistem informasi termasuk:

- Server dan infrastruktur IT
- Aplikasi bisnis dan database
- Backup dan recovery
- Pemantauan dan logging
- Patch manajemen dan perubahan sistem

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (Tata Kelola dan Kebijakan Keamanan Informasi.md)

---

## 2. Prosedur Utama

### 2.1 Prosedur Backup dan Recovery

#### Langkah-langkah Backup Harian:

1. **Penjadwalan Backup** (IT Operations - Harian)

   - Backup otomatis pukul 22:00 WIB setiap hari
   - Backup full mingguan pada hari Minggu pukul 23:00 WIB

2. **Verifikasi Backup** (IT Operations - Harian)

   - Check integritas file backup
   - Test restore pada sample data
   - Dokumentasikan hasil verifikasi

3. **Penyimpanan Backup** (IT Operations - Harian)

   - Backup lokal disimpan di NAS terenkripsi
   - Backup offsite ke cloud storage terpisah
   - Rotasi media backup sesuai retention kebijakan

#### Prosedur Recovery:

1. **Aktivasi Recovery** (IT Operations - Segera)

   - Identifikasi sistem/data yang terdampak
   - Pilih backup terbaru yang valid

2. **Restore Data** (IT Operations - < 4 jam untuk critical)

   - Restore dari backup offsite jika lokal terdampak
   - Verifikasi integritas data setelah restore
   - Test fungsionalitas sistem

3. **Post-Recovery Tinjauan** (IT Operations - 24 jam)

   - Analisis penyebab failure
   - Pembaruan prosedur berdasarkan lesson learned

#### RTO/RPO Targets:

- **Critical Systems**: RTO 4 jam, RPO 1 jam
- **Important Systems**: RTO 24 jam, RPO 4 jam
- **General Systems**: RTO 72 jam, RPO 24 jam

### 2.2 Prosedur Logging dan Pemantauan

#### Konfigurasi Logging:

1. **Centralized Logging** (IT Security - Berkelanjutan)

   - Semua sistem mengirim log ke SIEM server
   - Log disimpan minimal 2 tahun
   - Enkripsi log dalam transit dan storage

2. **Log Categories**:

   - Security events (login/logout, access denied)
   - System events (startup/shutdown, errors)
   - Application events (transactions, errors)
   - Network events (firewall, IDS alerts)

#### Pemantauan Prosedur:

1. **Real-time Pemantauan** (SOC Team - 24/7)

   - Alert otomatis untuk critical events
   - Dashboard pemantauan untuk IT Operations
   - Threshold-based alerting

2. **Daily Tinjauan** (IT Operations - Harian)

   - Tinjauan log harian untuk anomali
   - Check system health dan performance
   - Dokumentasikan temuan

3. **Weekly Audit** (IT Security - Mingguan)

   - Analisis trend dan pattern
   - Tinjauan privileged access logs
   - Generate security reports

### 2.3 Prosedur Proteksi Malware

#### Pencegahan:

1. **Endpoint Protection** (IT Security - Berkelanjutan)

   - Antivirus terbaru di semua endpoint
   - Anti-malware dengan real-time scanning
   - Email filtering dan web protection

2. **Network Security** (IT Security - Berkelanjutan)

   - Firewall dengan IPS/IDS
   - Email gateway dengan anti-spam
   - Web proxy dengan content filtering

#### Deteksi dan Respons:

1. **Malware Detection** (SOC Team - Segera)

   - Alert otomatis dari security tools
   - Manual scanning berkala
   - Endpoint isolation jika terdeteksi

2. **Insiden Respons** (IT Security - < 1 jam)

   - Isolate sistem terinfeksi
   - Forensic analysis
   - Clean dan recovery sistem

3. **Post-Insiden Tinjauan** (IT Security - 48 jam)

   - Root cause analysis
   - Pembaruan signature dan rules
   - Pelatihan kesadaran jika diperlukan

### 2.4 Prosedur Patch Manajemen

#### Langkah-langkah:

1. **Vulnerability Scanning** (IT Security - Mingguan)

   - Scan vulnerability pada semua sistem
   - Prioritas berdasarkan CVSS score

2. **Patch Testing** (IT Operations - Sebelum deployment)

   - Test patch di development environment
   - Compatibility testing dengan aplikasi
   - Rollback plan jika gagal

3. **Patch Deployment** (IT Operations - Jadwal)

   - Critical patches: Dalam 7 hari
   - High priority: Dalam 30 hari
   - Medium/Low: Dalam 90 hari

4. **Verification** (IT Operations - Setelah deployment)

   - Confirm patch berhasil installed
   - Monitor system stability
   - Pembaruan inventory software

### 2.5 Prosedur Change Manajemen

#### Proses Perubahan:

1. **Request for Change** (RFC) (Requestor)

   - Isi RFC Form (Form-OP-01)
   - Deskripsikan perubahan dan impact penilaian

2. **Change Persetujuan** (Change Advisory Board - 3 hari)

   - Tinjauan technical feasibility
   - Assess risiko dan impact
   - Approve/reject perubahan

3. **Implementation** (IT Operations - Jadwal)

   - Schedule change window
   - Backup sebelum perubahan
   - Implement dengan supervision

4. **Post-Implementation Tinjauan** (IT Operations - 24 jam)

   - Verify change berhasil
   - Monitor system selama 24 jam
   - Close change ticket

#### Darurat Changes:

- Bisa dilakukan tanpa CAB persetujuan penuh
- Tetapi harus didokumentasikan dan direview post-implementation

---

## 3. Formulir dan Template

### Form-OP-01: Request for Change (RFC)
```
ID RFC: ___________________________
Tanggal: __________________________
Requestor: ________________________
Departemen: _______________________

Deskripsi Perubahan: ______________
___________________________________
___________________________________

Sistem Terpengaruh: _______________
Risiko Penilaian: __________________
Business Impact: __________________

Persetujuan CAB:
___________________________
CAB Chairman
Tanggal: __________

Status Implementation:
□ Planned □ Darurat □ Completed □ Failed

Post-Implementation Notes:
___________________________________
```

### Form-OP-02: Insiden Report
```
Insiden ID: ______________________
Tanggal/Waktu: ___________________
Pelapor: __________________________
Kategori: □ Security □ Availability □ Performance

Deskripsi: ________________________
___________________________________
Impact: ___________________________

Action Taken: _____________________
___________________________________

Resolution: _______________________
Time to Resolve: __________________

Lessons Learned: _________________
```

### Log-OP-01: Backup Log
```
Tanggal | Waktu | Tipe Backup | Sistem | Status | Size | Lokasi
--------|-------|-------------|--------|--------|------|--------
```

---

## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Automated Backup**: Jadwal backup otomatis dengan verifikasi
- **SIEM Integration**: Centralized logging dengan correlation
- **Endpoint Detection**: Real-time malware protection
- **Change Control**: Mandatory RFC untuk semua perubahan

### 4.2 Pemantauan dan Audit

- Daily health checks untuk semua sistem critical
- Weekly vulnerability scanning
- Bulanan penetration testing
- Triwulanan disaster recovery testing

### 4.3 Pelaporan Insiden

- Critical insiden: Respons dalam 1 jam
- High priority: Respons dalam 4 jam
- Medium/Low: Respons dalam 24 jam

---

## 5. Pemenuhan Standar

### Persyaratan untuk Operations Security:

- ✅ **OP-1**: Operations prosedur documented - Prosedur lengkap dengan workflow
- ✅ **OP-2**: Backup and recovery prosedur - RTO/RPO defined dengan testing
- ✅ **OP-3**: Logging and pemantauan - SIEM dengan 24/7 pemantauan
- ✅ **OP-4**: Malware protection - Multi-layer protection dengan respons plan
- ✅ **OP-5**: Patch manajemen - Prioritized patching dengan testing
- ✅ **OP-6**: Change manajemen - CAB process dengan darurat prosedur
- ✅ **OP-7**: Capacity manajemen - Pemantauan resource utilization
- ✅ **OP-8**: Insiden manajemen - Defined respons times dan prosedur

---

## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Oversight operasi keamanan |
| Manajer Operasi IT | Daily operations dan change manajemen |
| Pimpinan Tim SOC | 24/7 pemantauan dan insiden respons |
| Petugas Keamanan IT | Vulnerability manajemen dan patch deployment |
| Dewan Penasihat Perubahan | Persetujuan perubahan sistem |

---

## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan:** Tahunan atau saat ada perubahan signifikan
- **Tanggung Jawab Peninjauan:** IT Operations dan Security Team
- **Persetujuan Pembaruan:** ISM dan Manajemen

---

## 8. Lampiran

- Lampiran A: Backup Schedule dan Retention Kebijakan
- Lampiran B: SIEM Configuration Guide
- Lampiran C: Insiden Respons Playbook
- Lampiran D: Change Manajemen Workflow Diagram
- Lampiran E: Disaster Recovery Test Results

---

**Disetujui Oleh:**

___________________________  
Heri Fauzan  
Manajer Keamanan Informasi  
Tanggal: __________________

___________________________  
Ahmad Firdaus  
Direktur Utama  
Tanggal: __________________
