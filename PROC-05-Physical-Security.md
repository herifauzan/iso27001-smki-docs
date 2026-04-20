# PROC-05: Prosedur Keamanan Fisik
## PT ECOMINDO SARANA CIPTA

## Cover
**Dokumen:** PROC-05: Prosedur Keamanan Fisik
**Dokumen ID:** PROC-05
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

Prosedur ini mengatur keamanan fisik fasilitas PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001. Prosedur ini mencakup kontrol akses fisik, pemantauan, dan proteksi terhadap aset fisik.

### 1.1 Tujuan

- Melindungi aset fisik perusahaan dari akses tidak sah
- Mencegah kerusakan atau pencurian peralatan IT
- Memastikan lingkungan kerja yang aman
- Memenuhi persyaratan untuk Keamanan Fisik yang komprehensif

### 1.2 Ruang Lingkup
Berlaku untuk semua lokasi fisik perusahaan termasuk:

- Kantor pusat dan cabang
- Server room dan data center
- Area kerja karyawan
- Area publik dan visitor
- Remote sites dan kerja dari rumah

### 1.3 Referensi

- Tata Kelola dan Kebijakan Keamanan Informasi (Tata Kelola dan Kebijakan Keamanan Informasi.md)

---

## 2. Prosedur Utama

### 2.1 Prosedur Kontrol Akses Fisik

#### Akses Bangunan:

1. **Registrasi Pengunjung** (Security Officer - Saat kedatangan)

   - Verifikasi identitas dengan KTP/SIM
   - Isi log pengunjung (Form-PS-01)
   - Terima akses card sementara jika diperlukan

2. **Akses Karyawan** (HR/Security - Saat onboarding)

   - Foto untuk ID card dan akses card
   - Program akses card sesuai role
   - Pelatihan penggunaan sistem akses

3. **Pemantauan Akses** (Security Officer - Berkelanjutan)

   - CCTV pemantauan 24/7
   - Log semua akses masuk/keluar
   - Alert untuk akses tidak sah

#### Akses Area Sensitif:

1. **Server Room Access** (IT Security - Restricted)

   - Akses hanya untuk authorized personnel
   - Dual authentication (card + PIN)
   - Mantrap system untuk high-security areas

2. **Data Center Access** (IT Security - Restricted)

   - Pre-authorization required
   - Escort untuk pengunjung
   - Full audit logging

### 2.2 Prosedur Pengamanan Peralatan

#### Workstation Security:

1. **Locking Kebijakan** (Semua Karyawan - Selalu)

   - Lock screen saat meninggalkan workstation
   - Password protect atau auto-lock setelah 5 menit
   - Tidak meninggalkan device tanpa pengawasan

2. **Mobile Device Security** (IT Security - Saat issuance)

   - Enable device encryption
   - Install MDM (Mobile Device Manajemen)
   - Remote wipe capability

3. **Portable Equipment** (IT Operations - Saat peminjaman)

   - Isi form peminjaman (Form-PS-02)
   - Track location dan kondisi
   - Return check sebelum deadline

#### Server Room Security:

1. **Environmental Controls** (Facilities - Berkelanjutan)

   - Temperature: 18-24°C
   - Humidity: 40-60%
   - Fire suppression system
   - UPS dan generator backup

2. **Access Controls** (Security Officer - Berkelanjutan)

   - 24/7 pemantauan
   - Restricted access list
   - Darurat access prosedur

### 2.3 Prosedur Respons Insiden Fisik

#### Theft/Loss Respons:

1. **Segera Respons** (Security Officer - Segera)

   - Secure area terdampak
   - Notify police jika theft
   - Assess damage/data exposure

2. **Penyelidikan** (Security Team - < 24 jam)

   - Tinjauan CCTV footage
   - Interview saksi
   - Document findings

3. **Recovery** (IT Operations - Segera)

   - Restore dari backup jika data hilang
   - Replace equipment
   - Pembaruan security measures

#### Darurat Respons:

1. **Fire Alarm** (Semua Personil - Segera)

   - Evacuate sesuai darurat route
   - Head count di assembly point
   - Wait for all-clear dari security

2. **Medical Darurat** (First Aid Team - Segera)

   - Call ambulance (118)
   - Provide first aid
   - Escort to medical facility

3. **Security Breach** (Security Officer - Segera)

   - Lockdown area terdampak
   - Notify manajemen
   - Coordinate dengan police jika perlu

### 2.4 Prosedur Maintenance dan Inspeksi

#### Routine Inspections:

1. **Daily Checks** (Security Officer - Harian)

   - Periksa semua access points
   - Verify CCTV functionality
   - Check darurat equipment

2. **Weekly Inspections** (Facilities Team - Mingguan)

   - Test fire alarm system
   - Check UPS dan generator
   - Inspect Keamanan Fisik devices

3. **Bulanan Audits** (Security Team - Bulanan)

   - Tinjauan access logs
   - Test backup systems
   - Audit visitor logs

#### Maintenance Schedule:

- CCTV system: Service bulanan
- Access control system: Service triwulanan
- Fire suppression: Inspection tahunan
- UPS/Generator: Test bulanan

### 2.5 Prosedur Working from Home

#### Setup WFH:

1. **Persetujuan Process** (Manajer - Sebelum WFH)

   - Justifikasi bisnis
   - Risiko penilaian
   - Persetujuan dari IT Security

2. **Home Office Setup** (IT Operations - Saat setup)

   - Secure WiFi dengan WPA3
   - Install VPN client
   - Setup workstation dengan Kontrol keamanan

3. **Persyaratan keamanan** (Karyawan - Selama WFH)

   - Lock device saat tidak digunakan
   - Secure storage untuk documents
   - Regular backup data

#### Pemantauan WFH:

1. **Access Pemantauan** (IT Security - Berkelanjutan)

   - VPN connection logs
   - Device health pemantauan
   - Unusual activity alerts

2. **Periodic Checks** (Manajer - Mingguan)

   - Virtual check-in
   - Productivity pemantauan
   - Security kepatuhan verification

---

## 3. Formulir dan Template

### Form-PS-01: Log Pengunjung
```
Tanggal: __________________________
Nama Pengunjung: __________________
Perusahaan: _______________________
Tujuan Kunjungan: _________________
Host: _____________________________

Waktu Masuk: _____________________
Waktu Keluar: ____________________

Akses Card Issued: □ Ya □ Tidak
Card Number: _____________________

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
□ Laptop □ Mobile □ Projector □ Other: _____
Serial Number: ___________________
Aksesoris: ________________________

Tujuan: ___________________________
Lokasi Penggunaan: ________________
Tanggal Pengembalian: _____________

Persetujuan:
___________________________
Manajer
Tanggal: __________

Kondisi Saat Peminjaman: __________
___________________________

Kondisi Saat Pengembalian: ________
___________________________

Diterima Oleh: ___________________
Tanggal: __________
```

### Daftar Periksa-PS-01: Daily Security Daftar Periksa
```
Tanggal: __________________________
Security Officer: _________________

□ Semua pintu utama terkunci
□ CCTV system operational
□ Access control system functional
□ Darurat exits clear
□ Fire extinguishers in place
□ Server room access secure
□ Visitor log updated
□ Suspicious activity reported

Catatan: __________________________
__________________________________
```

---

## 4. Kontrol dan Pemantauan

### 4.1 Mekanisme Kontrol

- **Multi-layer Access**: Card access + PIN + biometric
- **24/7 Pemantauan**: CCTV dengan recording 30 hari
- **Environmental Sensors**: Temperature, humidity, smoke detectors
- **Darurat Systems**: Fire alarm, sprinkler, darurat lighting

### 4.2 Pemantauan dan Audit

- Real-time CCTV pemantauan di security center
- Automated alerts untuk system failures
- Bulanan Keamanan Fisik audits
- Tahunan penetration testing untuk Keamanan Fisik

### 4.3 Pelaporan Insiden

- Physical intrusion: Respons dalam 2 menit
- Equipment theft: Respons dalam 5 menit
- Environmental insiden: Respons dalam 10 menit

---

## 5. Pemenuhan Standar

### Persyaratan untuk Keamanan Fisik:

- ✅ **PS-1**: Physical access controls - Multi-layer access dengan pemantauan
- ✅ **PS-2**: Secure areas protection - Server room dengan mantrap
- ✅ **PS-3**: Equipment security - Locking dan tracking prosedur
- ✅ **PS-4**: Visitor manajemen - Registration dan escort
- ✅ **PS-5**: Environmental controls - HVAC dan fire suppression
- ✅ **PS-6**: Cabling security - Protected cable runs
- ✅ **PS-7**: Kebijakan clean desk - Clear desk prosedur
- ✅ **PS-8**: Pekerja jarak jauh security - WFH Kontrol keamanan

---

## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Oversight Keamanan Fisik |
| Manajer Keamanan | Daily security operations |
| Manajer Fasilitas | Building maintenance dan environmental controls |
| Manajer Operasi IT | Equipment security dan server room |
| Kepala Departemen | Kepatuhan dalam departemen |
| Semua Karyawan | Adhere to Keamanan Fisik prosedur |

---

## 7. Tinjauan dan Pembaruan

- **Frekuensi Peninjauan:** Tahunan atau saat ada perubahan signifikan
- **Tanggung Jawab Peninjauan:** Security dan Facilities Team
- **Persetujuan Pembaruan:** ISM dan Manajemen

---

## 8. Lampiran

- Lampiran A: Site Layout dengan Security Zones
- Lampiran B: Darurat Respons Prosedur
- Lampiran C: CCTV Camera Locations
- Lampiran D: Access Control System Configuration
- Lampiran E: WFH Security Pedoman

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
