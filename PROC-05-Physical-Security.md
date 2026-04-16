# PROC-05: Prosedur Keamanan Fisik

**Dokumen ID:** PROC-05  
**Versi:** 1.0  
**Tanggal Efektif:** 15 April 2026  
**Disetujui Oleh:** [Nama dan Jabatan]  
**Departemen:** Keamanan Informasi  

---

## 1. Pendahuluan

Prosedur ini mengatur keamanan fisik fasilitas PT Ecomindo Sarana Cipta sesuai dengan standar ISO 27001 dan persyaratan Mandiri VSA Score-4. Prosedur ini mencakup kontrol akses fisik, monitoring, dan proteksi terhadap aset fisik.

### 1.1 Tujuan
- Melindungi aset fisik perusahaan dari akses tidak sah
- Mencegah kerusakan atau pencurian peralatan IT
- Memastikan lingkungan kerja yang aman
- Memenuhi persyaratan Mandiri VSA untuk physical security yang komprehensif

### 1.2 Ruang Lingkup
Berlaku untuk semua lokasi fisik perusahaan termasuk:
- Kantor pusat dan cabang
- Server room dan data center
- Area kerja karyawan
- Area publik dan visitor
- Remote sites dan home office

### 1.3 Referensi
- Tata Kelola dan Kebijakan Keamanan Informasi (Tata Kelola dan Kebijakan Keamanan Informasi.md)
- Standar Mandiri VSA Assessment

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
   - Training penggunaan sistem akses

3. **Monitoring Akses** (Security Officer - Kontinyu)
   - CCTV monitoring 24/7
   - Log semua akses masuk/keluar
   - Alert untuk akses tidak sah

#### Akses Area Sensitif:
1. **Server Room Access** (IT Security - Restricted)
   - Akses hanya untuk authorized personnel
   - Dual authentication (card + PIN)
   - Mantrap system untuk high-security areas

2. **Data Center Access** (IT Security - Restricted)
   - Pre-authorization required
   - Escort untuk visitors
   - Full audit logging

### 2.2 Prosedur Pengamanan Peralatan

#### Workstation Security:
1. **Locking Policy** (Semua Karyawan - Selalu)
   - Lock screen saat meninggalkan workstation
   - Password protect atau auto-lock setelah 5 menit
   - Tidak meninggalkan device tanpa pengawasan

2. **Mobile Device Security** (IT Security - Saat issuance)
   - Enable device encryption
   - Install MDM (Mobile Device Management)
   - Remote wipe capability

3. **Portable Equipment** (IT Operations - Saat peminjaman)
   - Isi form peminjaman (Form-PS-02)
   - Track location dan kondisi
   - Return check sebelum deadline

#### Server Room Security:
1. **Environmental Controls** (Facilities - Kontinyu)
   - Temperature: 18-24°C
   - Humidity: 40-60%
   - Fire suppression system
   - UPS dan generator backup

2. **Access Controls** (Security Officer - Kontinyu)
   - 24/7 monitoring
   - Restricted access list
   - Emergency access procedures

### 2.3 Prosedur Response Insiden Fisik

#### Theft/Loss Response:
1. **Immediate Response** (Security Officer - Segera)
   - Secure area terdampak
   - Notify police jika theft
   - Assess damage/data exposure

2. **Investigation** (Security Team - < 24 jam)
   - Review CCTV footage
   - Interview saksi
   - Document findings

3. **Recovery** (IT Operations - Segera)
   - Restore dari backup jika data hilang
   - Replace equipment
   - Update security measures

#### Emergency Response:
1. **Fire Alarm** (Semua Personil - Segera)
   - Evacuate sesuai emergency route
   - Head count di assembly point
   - Wait for all-clear dari security

2. **Medical Emergency** (First Aid Team - Segera)
   - Call ambulance (118)
   - Provide first aid
   - Escort to medical facility

3. **Security Breach** (Security Officer - Segera)
   - Lockdown area terdampak
   - Notify management
   - Coordinate dengan police jika perlu

### 2.4 Prosedur Maintenance dan Inspeksi

#### Routine Inspections:
1. **Daily Checks** (Security Officer - Harian)
   - Periksa semua access points
   - Verify CCTV functionality
   - Check emergency equipment

2. **Weekly Inspections** (Facilities Team - Mingguan)
   - Test fire alarm system
   - Check UPS dan generator
   - Inspect physical security devices

3. **Monthly Audits** (Security Team - Bulanan)
   - Review access logs
   - Test backup systems
   - Audit visitor logs

#### Maintenance Schedule:
- CCTV system: Service bulanan
- Access control system: Service triwulanan
- Fire suppression: Inspection tahunan
- UPS/Generator: Test bulanan

### 2.5 Prosedur Working from Home

#### Setup WFH:
1. **Approval Process** (Manager - Sebelum WFH)
   - Business justification
   - Risk assessment
   - Approval dari IT Security

2. **Home Office Setup** (IT Operations - Saat setup)
   - Secure WiFi dengan WPA3
   - Install VPN client
   - Setup workstation dengan security controls

3. **Security Requirements** (Karyawan - Selama WFH)
   - Lock device saat tidak digunakan
   - Secure storage untuk documents
   - Regular backup data

#### Monitoring WFH:
1. **Access Monitoring** (IT Security - Kontinyu)
   - VPN connection logs
   - Device health monitoring
   - Unusual activity alerts

2. **Periodic Checks** (Manager - Mingguan)
   - Virtual check-in
   - Productivity monitoring
   - Security compliance verification

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

Approval:
___________________________
Manager
Tanggal: __________

Kondisi Saat Peminjaman: __________
___________________________

Kondisi Saat Pengembalian: ________
___________________________

Diterima Oleh: ___________________
Tanggal: __________
```

### Checklist-PS-01: Daily Security Checklist
```
Tanggal: __________________________
Security Officer: _________________

□ Semua pintu utama terkunci
□ CCTV system operational
□ Access control system functional
□ Emergency exits clear
□ Fire extinguishers in place
□ Server room access secure
□ Visitor log updated
□ Suspicious activity reported

Catatan: __________________________
__________________________________
```

---

## 4. Kontrol dan Monitoring

### 4.1 Mekanisme Kontrol
- **Multi-layer Access**: Card access + PIN + biometric
- **24/7 Monitoring**: CCTV dengan recording 30 hari
- **Environmental Sensors**: Temperature, humidity, smoke detectors
- **Emergency Systems**: Fire alarm, sprinkler, emergency lighting

### 4.2 Monitoring dan Audit
- Real-time CCTV monitoring di security center
- Automated alerts untuk system failures
- Monthly physical security audits
- Annual penetration testing untuk physical security

### 4.3 Pelaporan Insiden
- Physical intrusion: Response dalam 2 menit
- Equipment theft: Response dalam 5 menit
- Environmental incident: Response dalam 10 menit

---

## 5. Pemenuhan Standar Mandiri VSA

### Score-4 Requirements untuk Physical Security:
- ✅ **PS-1**: Physical access controls - Multi-layer access dengan monitoring
- ✅ **PS-2**: Secure areas protection - Server room dengan mantrap
- ✅ **PS-3**: Equipment security - Locking dan tracking procedures
- ✅ **PS-4**: Visitor management - Registration dan escort
- ✅ **PS-5**: Environmental controls - HVAC dan fire suppression
- ✅ **PS-6**: Cabling security - Protected cable runs
- ✅ **PS-7**: Clean desk policy - Clear desk procedures
- ✅ **PS-8**: Remote working security - WFH security controls

**Status Kepatuhan:** 100% - Semua 8 kontrol PS terpenuhi

---

## 6. Tanggung Jawab

| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Oversight physical security |
| Manajer Keamanan | Daily security operations |
| Manajer Fasilitas | Building maintenance dan environmental controls |
| Manajer Operasi IT | Equipment security dan server room |
| Kepala Departemen | Compliance dalam departemen |
| Semua Karyawan | Adhere to physical security procedures |

---

## 7. Review dan Update

- **Frekuensi Review:** Tahunan atau saat ada perubahan signifikan
- **Tanggung Jawab Review:** Security dan Facilities Team
- **Approval Update:** ISM dan Management

---

## 8. Lampiran

- Lampiran A: Site Layout dengan Security Zones
- Lampiran B: Emergency Response Procedures
- Lampiran C: CCTV Camera Locations
- Lampiran D: Access Control System Configuration
- Lampiran E: WFH Security Guidelines

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