## 0. Informasi Dokumen

- **Nama dokumen:** SOP Security Procedure – PT Ecomindo (untuk dukungan layanan MMI)
- **Versi:** 1.0
- **Tanggal efektif:** April 15, 2026
- **Pemilik dokumen:** Information Security Officer (ISO) / Security Lead
- **Disetujui oleh:** Direktur/Manajemen PT Ecomindo
- **Siklus review:** minimal tahunan atau saat terjadi perubahan signifikan (sistem, proses, regulasi, insiden)

## 1. Tujuan, Ruang Lingkup, dan Definisi

### 1.1 Tujuan

Menetapkan prosedur keamanan informasi untuk memastikan:

- Kerahasiaan, integritas, dan ketersediaan informasi (CIA).
- Kepatuhan terhadap persyaratan MMI/VSA dan best practice (mis. ISO 27001/NIST/CIS) sesuai relevansi.
- Pengendalian risiko pada layanan dan sistem yang digunakan untuk memenuhi kerja sama dengan MMI.

### 1.2 Ruang Lingkup

Berlaku untuk:

- Seluruh pegawai, kontraktor, dan sub-kontraktor yang terlibat dalam layanan terkait MMI.
- Seluruh aset informasi (data, aplikasi, server, jaringan, endpoint, akun, repositori source code, dokumentasi).
- Seluruh lingkungan (dev/test/prod) yang relevan.

### 1.3 Definisi Singkat

- **MMI:** Mandiri Manajemen Investasi.
- **PII/Data sensitif:** data pribadi, kredensial, data keuangan, data rahasia bisnis.
- **RBAC/Least privilege:** akses sesuai kebutuhan minimum.
- **VAPT:** Vulnerability Assessment & Penetration Testing.

---

## 2. Risk Management (VSA 1)

### 2.1 Kerangka Pengelolaan Risiko Keamanan Informasi

**Tujuan:** mengidentifikasi, menilai, dan menangani risiko keamanan.

**Prosedur:**

1. **Identifikasi aset & proses** terkait layanan MMI (data, sistem, integrasi, vendor, personel).
2. **Identifikasi ancaman & kerentanan** (mis. salah konfigurasi, akses tidak sah, kebocoran data, ransomware).
3. **Penilaian risiko** menggunakan matriks **Likelihood x Impact** (skala 1–5).
4. **Rencana penanganan risiko**: mitigate / transfer / accept / avoid.
5. **Penetapan kontrol** mengacu pada baseline (CIS/NIST) & SOP ini.
6. **Review berkala** minimal setiap 12 bulan dan setiap ada perubahan mayor.

**Output wajib:**

- Risk register (daftar risiko + status + PIC + due date).
- Notulen/rekaman rapat review risiko.

### 2.2 Audit/Assessment dan Sertifikasi

**Kebijakan:** PT Ecomindo melakukan assessment keamanan berkala.

**Prosedur minimum:**

- **Internal security review** minimal 1x/tahun (hardening, akses, logging, backup, SDLC).
- **External assessment** (bila disepakati kontrak/permintaan MMI): VA/penetration test atau audit pihak ketiga.
- Temuan harus memiliki **rencana perbaikan** (remediation plan) dan bukti penyelesaian.

---

## 3. Information Security Policies (VSA 2)

### 3.1 Kebijakan Keamanan Informasi Umum (VSA 2.1a)

**Kebijakan utama:**

- Klasifikasi data dan penanganannya.
- Enkripsi dan perlindungan data.
- Manajemen akses.
- Logging & monitoring.
- Manajemen insiden.
- Backup/DR.
- Kepatuhan & pelatihan.

**Prosedur sosialisasi:**

- Wajib onboarding security awareness.
- Refresh minimal tahunan (email/training) dan saat ada perubahan kebijakan.

### 3.2 Kebijakan Security Baseline (Aplikasi/Sistem/Endpoint) (VSA 2.1b)

**Tujuan:** memastikan hardening & konfigurasi aman.

**Baseline minimum:**

- OS hardening (CIS benchmark atau setara).
- Database hardening (disable default accounts, strong auth, encrypted connections).
- Aplikasi: secure headers, secrets management, dependency management.
- Endpoint: MDM/EDR/antivirus, disk encryption, screen lock, patching.

**Exception management:**

1. Ajukan form exception berisi alasan, risiko, kompensasi kontrol.
2. Approver: Security Lead + Owner sistem.
3. Tanggal kedaluwarsa exception dan rencana mitigasi wajib.

---

## 4. Organization of Information Security (VSA 3)

### 4.1 Struktur Organisasi & Tanggung Jawab (VSA 3.1)

**Peran minimum:**

- **Security Lead / Information Security Officer (ISO):** pemilik kebijakan, risk register, incident commander.
- **System Owner:** bertanggung jawab atas keamanan sistem yang dimiliki.
- **IT Ops/Infra:** hardening, patching, backup, monitoring.
- **Engineering Lead:** secure SDLC, code review, dependency security.

**Dokumentasi:** job description dan matriks RACI untuk area keamanan.

### 4.2 Security Awareness Program (VSA 3.2)

**Program:**

- Onboarding awareness untuk pegawai baru.
- Pelatihan tahunan: phishing, password/MFA, data handling, incident reporting.
- Kuis/assessment untuk memastikan pemahaman.

---

## 5. Human Resource Security (VSA 4)

### 5.1 Pemeriksaan Latar Belakang & Siklus Kepegawaian (VSA 4.1a)

**Prosedur rekrutmen:**

- Verifikasi identitas dan riwayat kerja (sesuai kebijakan HR dan hukum yang berlaku).
- Penetapan role & akses sesuai posisi.

**Prosedur offboarding (PHK/Resign):**

1. HR menginformasikan tanggal efektif.
2. IT menonaktifkan akun pada hari terakhir (atau lebih cepat untuk kasus khusus).
3. Cabut akses VPN/SSO/email/repo/source code.
4. Pengembalian aset (laptop, token, kartu akses).
5. Review data & transfer knowledge.

### 5.2 Sub-kontraktor (VSA 4.1b, 4.3, 4.4)

**Ketentuan:**

- Penggunaan sub-kontraktor untuk layanan MMI harus **disetujui MMI** bila disyaratkan kontrak.
- Sub-kontraktor wajib memiliki NDA dan klausul keamanan informasi.
- Akses sub-kontraktor:
    - Diberikan terbatas (least privilege), berbatas waktu, dan diaudit.
    - Wajib MFA.
    - Proses onboarding/offboarding tercatat.

### 5.3 NDA Personil untuk MMI (VSA 4.2)

**Prosedur:**

- Seluruh personil yang ditugaskan ke layanan MMI wajib menandatangani **NDA personil** sesuai format/ketentuan MMI (atau setara yang disetujui).
- Dokumen NDA disimpan oleh HR/Legal dan dapat disediakan sebagai sample sesuai permintaan.

---

## 6. Asset Management & Information Handling (VSA 5)

### 6.1 Inventaris Aset

**Prosedur:**

- Buat dan pelihara inventaris aset: perangkat, server, layanan cloud, aplikasi, repositori, akun admin.
- Setiap aset memiliki owner, klasifikasi, dan lingkungan (dev/test/prod).

### 6.2 Klasifikasi Data & Penanganan (VSA 5.1a/5.1b/5.1c)

**Klasifikasi minimum:** Public / Internal / Confidential / Restricted.

**Kontrol wajib:**

- **Enkripsi data in transit:** TLS 1.2+ untuk semua komunikasi.
- **Enkripsi data at rest:** disk/storage encryption untuk server dan endpoint; untuk database gunakan encryption-at-rest jika tersedia.
- **Data sensitif/PII:** masking/redaction pada log; minimisasi data; akses terbatas.
- **Backup & restore:** lihat Bagian 9.
- **Secure disposal:** wipe/secure erase untuk perangkat dan storage.
- **Removable media:** dibatasi; jika perlu, wajib enkripsi dan approval.
- **Secure deletion (cache/temp):** prosedur pembersihan cache/temp untuk data sensitif.

### 6.3 Manajemen Secret & Kredensial

**Prosedur:**

- Secret (API key, password, token) disimpan di secrets manager atau vault yang disetujui.
- Dilarang menyimpan secret di source code.
- Rotasi secret berkala atau setelah insiden.

---

## 7. Access Control (VSA 6)

### 7.1 Identity & Access Management (VSA 6.1a)

**Prinsip:** least privilege, RBAC, separation of duties.

**Prosedur pembuatan/perubahan/penonaktifan:**

1. Permintaan akses via tiket/form, menyebutkan sistem, role, justifikasi, durasi.
2. Approver: System Owner + Security Lead (untuk akses elevated/admin).
3. Provisioning oleh IT/ops sesuai role.
4. Penonaktifan saat offboarding dan saat akses tidak lagi diperlukan.

**Review akses berkala:**

- Minimal **triwulanan** untuk sistem kritikal / admin.
- Minimal **semesteran** untuk sistem non-kritikal.
- Bukti: daftar user & role + hasil review (retain).

### 7.2 IAM untuk Cloud Provider / Lingkungan Cloud (VSA 6.1b)

**Kontrol:**

- Akun admin untuk layanan MMI wajib **MFA**.
- Akun admin dipisah dari akun sehari-hari.
- Logging aktivitas admin diaktifkan (audit trail).

### 7.3 Remote Access (VSA 6.2)

**Prosedur:**

- Remote access hanya melalui mekanisme yang disetujui (mis. VPN/ZTNA) dengan **MFA**.
- Akses remote ke produksi dibatasi dan diaudit.
- Review akses remote dilakukan minimal triwulanan.

---

## 8. Physical & Environmental Security (VSA 7)

### 8.1 Keamanan Area Kerja (VSA 7.1)

**Kontrol minimum:**

- Kontrol akses fisik (kartu akses/fingerprint) untuk area kerja.
- CCTV pada area yang relevan.
- Kebijakan meja bersih (clean desk) untuk data sensitif.

### 8.2 Keamanan Ruang Server/DC (VSA 7.2)

Jika PT Ecomindo mengelola server on-prem:

- Access control (kartu/fingerprint) + CCTV.
- Logbook akses (manual/digital) dan review berkala.

Jika menggunakan DC/cloud pihak ketiga:

- Simpan bukti SLA/kontrak dan pernyataan kontrol fisik dari penyedia DC/cloud bila tersedia.

---

## 9. Operations Security (VSA 8)

### 9.1 Security Configuration (VSA 8.1)

**Prosedur:**

- Terapkan password policy dan MFA.
- Hardening OS/DB/aplikasi berdasarkan baseline.
- Antivirus/EDR di endpoint dan server (sesuai kompatibilitas).
- Patch management: lihat 9.2.

### 9.2 Change Management (VSA 8.2)

**Tujuan:** mengontrol perubahan pada produksi.

**Prosedur:**

1. Setiap perubahan memiliki tiket/change request: deskripsi, risiko, rencana rollback.
2. Approval sebelum implementasi (Engineering Lead/System Owner; Security untuk perubahan kritikal).
3. Uji di dev/test sebelum prod.
4. Implementasi mengikuti jadwal maintenance bila perlu.
5. Dokumentasi hasil dan post-change verification.

### 9.3 Segregation of Environments & Network Security (VSA 8.3a/8.3b)

**Kontrol wajib:**

- Pemisahan environment **dev/test/prod**.
- Firewall/WAF untuk aplikasi internet-facing.
- Monitoring koneksi jaringan dan review log.
- Akses ke produksi dibatasi (RBAC, MFA) dan dicatat.

### 9.4 Backup, Restore, dan Disaster Recovery (VSA 8.4)

**Kebijakan:** backup terjadwal dan diuji.

**Prosedur minimum:**

- Backup data kritikal (database, konfigurasi, artefak) sesuai RPO/RTO yang disepakati.
- Enkripsi backup.
- Retensi backup sesuai kebutuhan kontrak/regulasi.
- **Uji restore** minimal triwulanan (atau sesuai kritikalitas).

### 9.5 VAPT & Vulnerability Management (VSA 8.5)

**Prosedur:**

1. Scan kerentanan berkala (minimal bulanan untuk internet-facing; kuartalan untuk lainnya).
2. Penetration test minimal tahunan atau sesuai permintaan MMI.
3. Triase temuan (Critical/High/Medium/Low) dan SLA perbaikan.
4. Verifikasi perbaikan (re-scan/retest) dan dokumentasi.

### 9.6 Obsolete Technology Management (VSA 8.6)

**Prosedur:**

- Inventaris versi OS/DB/runtime.
- Identifikasi komponen EOL/EOS.
- Rencana upgrade/migrasi + timeline.
- Mitigasi sementara jika upgrade belum memungkinkan (network isolation, compensating control).

### 9.7 Incident Management (VSA 8.7)

**Prosedur respon insiden:**

1. **Deteksi & pelaporan:** semua personil wajib melapor ke channel/tiket insiden.
2. **Klasifikasi & prioritas:** berdasarkan dampak dan scope.
3. **Containment:** isolasi sistem/akun yang terdampak.
4. **Eradikasi & pemulihan:** perbaiki root cause, restore dari backup bila perlu.
5. **Forensics (bila diperlukan):** kumpulkan log/bukti sesuai chain-of-custody.
6. **Komunikasi:** pemberitahuan ke manajemen dan ke MMI sesuai kontrak/SLA.
7. **Post-incident review:** RCA dan action items.

### 9.8 Audit Trail & Log Retention (VSA 8.8)

**Kontrol:**

- Aktifkan logging pada OS, database, aplikasi, dan akses admin.
- Log dikirim ke lokasi terpusat (SIEM/log server) bila memungkinkan.
- Retensi log minimal **90 hari** (atau sesuai kontrak/permintaan MMI); untuk sistem kritikal dianjurkan lebih lama.
- Review log berkala dan bukti review disimpan.

---

## 10. Secure Software Development Lifecycle (VSA 9)

### 10.1 Secure Coding Procedure (VSA 9.1)

**Prosedur minimum:**

- Standar secure coding (OWASP ASVS/Top 10 sebagai acuan).
- Code review wajib untuk perubahan signifikan.
- Static analysis (SAST) dan dependency scanning pada pipeline.
- Hard-coded secrets dilarang; gunakan secrets manager.

### 10.2 Source Code Security (VSA 9.2)

**Kontrol:**

- Source code berada di repository terpercaya dengan akses RBAC dan MFA.
- Branch protection (review mandatory, CI checks).
- Backup repository / mekanisme restore.
- Audit log akses repository diaktifkan bila tersedia.

---

## 11. Business Continuity Management (VSA 10)

### 11.1 Kebijakan BCM (VSA 10.1)

**Tujuan:** memastikan layanan tetap berjalan saat gangguan.

**Prosedur:**

- Identifikasi skenario gangguan: pandemi, bencana alam, kebakaran, banjir, outage cloud, ransomware.
- Tetapkan RTO/RPO layanan (sesuai kontrak MMI).
- Siapkan rencana kerja jarak jauh (remote working) yang aman.
- Kontak darurat & rantai eskalasi.
- Drill/latihan BCM minimal tahunan.

---

## 12. Prosedur Operasional Pendukung (Wajib untuk Kepatuhan)

### 12.1 Pengelolaan Dokumen & Bukti

- Semua kebijakan, SOP, tiket change, tiket insiden, hasil review akses, dan hasil audit disimpan terpusat.
- Retensi dokumen minimal mengikuti kontrak dan kebutuhan audit.

### 12.2 Mekanisme Review Berkala (Minimum Baseline)

- Review akses: triwulanan/semesteran (lihat 7.1).
- Review kebijakan: tahunan.
- Review log: sesuai kritikalitas (minimal bulanan untuk sistem kritikal).
- Uji restore: minimal triwulanan.
- VA scan: minimal bulanan untuk internet-facing.

---

## 13. Lampiran A — Daftar Expected Deliverables (Bukti untuk VSA)

### A1. Risk Management (VSA 1.1)

- Sample capture penerapan security requirements (hardening OS/DB)
- Executive summary audit/assessment (internal/eksternal)
- Dokumen sertifikasi + scope (jika ada)

### A2. Policies (VSA 2.1a, 2.1b)

- Cover/lembar pengesahan/daftar isi kebijakan
- Capture ketentuan pengamanan data sensitif + mekanisme exception
- Sample bukti sosialisasi (email, poster, materi training, daftar hadir)

### A3. Organization (VSA 3.1, 3.2)

- Struktur organisasi tim keamanan informasi
- Job description peran keamanan
- Bukti pelaksanaan awareness (materi/daftar hadir)

### A4. HR Security (VSA 4.1a, 4.1b, 4.2, 4.3, 4.4)

- Kebijakan pengelolaan karyawan + background check (sample)
- Exit clearance/offboarding checklist (sample)
- Sample NDA personil untuk personil yang ditugaskan ke MMI
- Dokumen PKS dengan sub-kontraktor (jika ada) + persetujuan MMI (jika dipersyaratkan)
- Perjanjian keamanan informasi/NDA sub-kontraktor + ketentuan akses

### A5. Asset Management (VSA 5)

- Dokumen kebijakan pengamanan data
- Sample capture klasifikasi, enkripsi, disposal, removable media
- Bukti backup & restore (jadwal + hasil uji restore)

### A6. Access Control (VSA 6.1a, 6.1b, 6.2)

- Kebijakan pengelolaan akses
- Sample user access matrix
- Bukti MFA admin (screenshot/policy)
- Bukti review akses berkala

### A7. Physical Security (VSA 7.1, 7.2)

- Kebijakan pengamanan ruang kerja / server room
- Capture implementasi access control/CCTV/logbook

### A8. Operations Security (VSA 8)

- Kebijakan security configuration
- Kebijakan change management + sample tiket perubahan
- Kebijakan pengamanan jaringan + bukti WAF/firewall/monitoring
- Kebijakan DRP + dokumen DR plan
- Kebijakan VAPT + executive summary + remediation tracking
- Kebijakan obsolete tech + rencana upgrade
- Kebijakan incident management + sample incident report/RCA
- Kebijakan audit trail + bukti konfigurasi logging + bukti review + retensi

### A9. Secure SDLC (VSA 9)

- Kebijakan secure coding
- Bukti implementasi (SAST/dependency scan, code review)
- Kebijakan pengamanan source code + akses repo

### A10. BCM (VSA 10)

- Kebijakan BCM
- Dokumen rencana respon kejadian (BCP)
- Bukti drill/latihan