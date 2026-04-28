# PROSEDUR KEAMANAN OPERASI
## PT ECOMINDO SARANA CIPTA


## Cover
**Dokumen:** PROSEDUR KEAMANAN OPERASI
**Dokumen ID:** PROC-03
**Versi:** 1.0  
**Tanggal Berlaku:** 15 April 2026  
**Status:** Final  
**Tingkat Keamanan:** Confidential


## Lembar Pengesahan


| Jabatan | Nama | Tanda Tangan | Tanggal |
|---------|------|-------------|--------|
| Direktur Operasional / COO | Dodi Darundriyo |   |   |
| Manajer Keamanan Informasi (ISM) | Heri Fauzan |   |   |
| Manajer IT Operations |  |  |  |


## Daftar Isi


- [1. Pendahuluan](#1-pendahuluan)
- [2. Prosedur Utama](#2-prosedur-utama)
  - [2.1 Prosedur Backup dan Recovery](#21-prosedur-backup-dan-recovery)
  - [2.2 Prosedur Logging dan Pemantauan](#22-prosedur-logging-dan-pemantauan)
  - [2.3 Prosedur Proteksi Malware](#23-prosedur-proteksi-malware)
  - [2.4 Prosedur Patch Manajemen](#24-prosedur-patch-manajemen)
  - [2.5 Prosedur Change Manajemen](#25-prosedur-change-manajemen)
  - [2.6 Prosedur Audit Trail](#26-prosedur-audit-trail)
  - [2.7 Prosedur Pengamanan Jaringan](#27-prosedur-pengamanan-jaringan)
  - [2.8 Prosedur Secure Coding dan Pengamanan Source Code](#28-prosedur-secure-coding-dan-pengamanan-source-code)


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


- Tata Kelola dan Kebijakan Keamanan Informasi (GOV-POL-TK3I.md), khususnya Area 8: Keamanan Operasi, Area 9: Pengembangan Aman, dan Area 10: Kelangsungan Bisnis


## 2. Prosedur Utama


### 2.1 Prosedur Backup dan Recovery


Prosedur ini mengatur tata cara pencadangan (backup) dan pemulihan (recovery) data dan sistem informasi PT Ecomindo Sarana Cipta untuk memastikan ketersediaan data dan kelangsungan operasional saat terjadi kegagalan sistem atau bencana.


#### A. Penjadwalan dan Pelaksanaan Backup


**Penanggung Jawab:** IT Operations  
**Frekuensi:** Harian (otomatis) dan mingguan (full backup)


1. **Konfigurasi Jadwal Backup** (IT Operations - Saat setup dan setiap ada perubahan infrastruktur)


   - Konfigurasi backup otomatis menggunakan backup software yang telah ditentukan
   - Jadwal backup yang wajib diterapkan:
     - **Backup Inkremental Harian:** Pukul 22:00 WIB setiap hari kerja â€” mencakup perubahan data sejak backup terakhir
     - **Backup Full Mingguan:** Setiap Minggu pukul 23:00 WIB â€” mencakup seluruh sistem dan data
     - **Backup Snapshot Database:** Setiap 4 jam sekali untuk database yang mengandung data transaksi kritis
   - Pastikan cakupan backup meliputi: data aplikasi, konfigurasi sistem, database, dan aset konfigurasi penting lainnya


2. **Verifikasi Integritas Backup** (IT Operations - Setiap hari setelah backup selesai)


   - Periksa status eksekusi backup (sukses/gagal) dari backup management console
   - Lakukan verifikasi checksum/hash untuk memastikan integritas file backup tidak rusak
   - Lakukan uji restore parsial (test restore) secara rutin â€” minimal satu kali per minggu pada data sampel
   - Dokumentasikan hasil verifikasi dalam Log Backup Harian (Log-OP-01)
   - Jika backup gagal, lakukan investigasi dan perbaikan segera, kemudian jalankan backup ulang manual


3. **Penyimpanan dan Retensi Backup** (IT Operations - Berkelanjutan)


   - **Penyimpanan Lokal:** Backup disimpan di perangkat NAS (Network Attached Storage) terenkripsi di lokasi server utama
   - **Penyimpanan Offsite:** Backup full mingguan dikirim ke cloud storage atau lokasi terpisah secara geografis
   - Enkripsi backup wajib diterapkan baik saat penyimpanan (at rest) maupun pengiriman (in transit)
   - Kebijakan retensi backup yang berlaku:
     - Backup harian disimpan selama **30 hari**
     - Backup mingguan disimpan selama **3 bulan**
     - Backup bulanan (snapshot full akhir bulan) disimpan selama **1 tahun**
   - Akses ke backup dibatasi hanya untuk IT Operations dan ISM


#### B. Prosedur Pemulihan (Recovery)


**Penanggung Jawab:** IT Operations  
**Frekuensi:** Diaktifkan saat terjadi kegagalan sistem atau insiden data


1. **Identifikasi dan Penilaian Dampak** (IT Operations - Segera setelah insiden terdeteksi)


   - Identifikasi sistem, layanan, atau data yang terdampak
   - Tentukan prioritas pemulihan berdasarkan kategori sistem (lihat RTO/RPO Targets di bawah)
   - Laporkan kepada ISM dan Manajemen IT sesuai tingkat kegawatan insiden


2. **Pemilihan dan Persiapan Backup** (IT Operations - Dalam 30 menit)


   - Pilih titik backup (restore point) yang paling tepat â€” biasanya backup valid terakhir sebelum insiden
   - Verifikasi integritas backup yang dipilih sebelum digunakan untuk restore
   - Siapkan lingkungan restore (server tujuan, storage yang cukup, akses jaringan)


3. **Pelaksanaan Restore** (IT Operations - Sesuai RTO yang berlaku)


   - Jika backup lokal terdampak atau tidak tersedia, gunakan backup dari lokasi offsite/cloud
   - Jalankan proses restore sesuai panduan teknis yang berlaku untuk sistem terkait
   - Verifikasi integritas data setelah restore selesai (bandingkan checksum, jumlah record, dll.)
   - Lakukan pengujian fungsional sistem yang dipulihkan sebelum dikembalikan ke produksi


4. **Tinjauan Pasca-Recovery** (IT Operations & ISM - Dalam 24 jam setelah recovery selesai)


   - Dokumentasikan kronologi insiden, proses recovery, dan hasilnya dalam Form-OP-02
   - Lakukan analisis penyebab dasar (root cause analysis) kegagalan
   - Identifikasi lesson learned dan tindakan perbaikan yang diperlukan
   - Perbarui prosedur backup/recovery jika ditemukan kelemahan dalam proses


#### C. Target RTO dan RPO


| Kategori Sistem | Recovery Time Objective (RTO) | Recovery Point Objective (RPO) |
|-----------------|------------------------------|-------------------------------|
| **Kritis** (ERP, database transaksi, layanan inti) | Maksimal 4 jam | Maksimal 1 jam |
| **Penting** (aplikasi pendukung operasional) | Maksimal 24 jam | Maksimal 4 jam |
| **Umum** (sistem administrasi, internal tools) | Maksimal 72 jam | Maksimal 24 jam |


#### D. Pengujian Disaster Recovery


**Penanggung Jawab:** IT Operations & ISM  
**Frekuensi:** Minimal satu kali per tahun (uji penuh) dan satu kali per kuartal (uji parsial)


1. **Uji Parsial Triwulanan** (IT Operations - Setiap triwulan)


   - Lakukan restore dari backup ke lingkungan testing yang terisolasi
   - Verifikasi bahwa data dan konfigurasi dapat dipulihkan dengan benar
   - Ukur waktu aktual recovery dan bandingkan dengan target RTO
   - Dokumentasikan hasil dalam Laporan Uji Recovery


2. **Uji Disaster Recovery Penuh Tahunan** (IT Operations & ISM - Setiap tahun)


   - Simulasikan skenario bencana secara menyeluruh (mis. kegagalan sistem/infrastruktur utama)
   - Uji pemulihan sistem kritis ke lokasi backup/offsite
   - Libatkan semua pihak terkait termasuk manajemen
   - Evaluasi dan perbarui Business Continuity Plan (BCP) berdasarkan hasil uji


### 2.2 Prosedur Logging dan Pemantauan


Prosedur ini mengatur pengumpulan, penyimpanan, dan pemantauan log dari seluruh sistem informasi PT Ecomindo Sarana Cipta untuk mendeteksi anomali, mendukung investigasi insiden, dan memastikan akuntabilitas operasional.


#### A. Konfigurasi dan Pengumpulan Log


**Penanggung Jawab:** IT Security / IT Operations  
**Frekuensi:** Konfigurasi awal saat setup sistem, review tahunan


1. **Centralized Logging dengan SIEM** (IT Security - Wajib aktif)


   - Semua sistem (server, workstation, perangkat jaringan, aplikasi) wajib mengirimkan log ke SIEM terpusat secara real-time
   - Gunakan agen log shipper (mis. Filebeat, Syslog forwarder) untuk memastikan pengiriman log yang andal
   - Log dienkripsi saat transit (TLS 1.2+) dan saat penyimpanan (AES-256)
   - Pastikan sinkronisasi waktu (NTP) aktif di semua sistem agar timestamp log konsisten


2. **Kategori Event yang Wajib Dicatat**


   - **Security Events:** Login sukses dan gagal, perubahan hak akses, akses ditolak, perubahan konfigurasi keamanan
   - **System Events:** Startup dan shutdown server, perubahan konfigurasi OS, error sistem kritis
   - **Application Events:** Transaksi bisnis kritis, error aplikasi, perubahan data sensitif
   - **Network Events:** Alert firewall dan IDS/IPS, koneksi VPN, traffic anomali


3. **Validasi Konfigurasi Logging** (IT Security - Setelah setup dan setiap perubahan konfigurasi)


   - Verifikasi bahwa semua sistem mengirimkan log ke SIEM dengan benar
   - Pastikan tidak ada gap atau delay yang signifikan dalam pengiriman log
   - Dokumentasikan daftar sistem yang terpantau sebagai baseline


#### B. Pemantauan dan Tinjauan Log


**Penanggung Jawab:** ISM / IT Security  
**Frekuensi:** Real-time 24/7 untuk alert kritis; harian, mingguan untuk tinjauan rutin


1. **Pemantauan Real-Time** (ISM - 24/7 berkelanjutan)


   - ISM memantau dashboard SIEM secara berkelanjutan
   - Alert otomatis dikonfigurasi untuk event berikut:
     - Percobaan login gagal berulang (brute force) â€” threshold: 5 kali gagal dalam 10 menit
     - Akses ke sistem di luar jam kerja tanpa otorisasi
     - Penggunaan akun administrator di luar jadwal maintenance
     - Pola akses data yang tidak lazim (volume besar dalam waktu singkat)
   - Setiap alert HIGH atau CRITICAL wajib ditangani dalam **1 jam**


2. **Tinjauan Harian** (IT Operations - Setiap hari kerja)


   - Review ringkasan log harian dari SIEM untuk anomali yang tidak terpantau oleh alert otomatis
   - Periksa kondisi kesehatan (health check) semua sistem kritis: CPU, memori, storage, availability
   - Dokumentasikan temuan dalam Log Pemantauan Harian


3. **Tinjauan Mingguan** (IT Security - Setiap minggu)


   - Analisis tren dan pola dari log selama seminggu
   - Review log akses akun-akun privileged (admin, root, DBA)
   - Identifikasi anomali yang tidak ter-trigger oleh alert otomatis
   - Buat Laporan Keamanan Mingguan dan sampaikan kepada ISM


4. **Tinjauan Bulanan** (IT Security & Audit Internal - Setiap bulan)


   - Audit menyeluruh atas efektivitas konfigurasi logging dan alerting
   - Review dan tuning rule/threshold di SIEM untuk mengurangi false positive
   - Dokumentasikan temuan dalam Laporan Audit Bulanan
   - Laporan disampaikan kepada ISM dan Manajemen


### 2.3 Prosedur Proteksi Malware


Prosedur ini mengatur penerapan perlindungan berlapis terhadap ancaman malware (virus, ransomware, trojan, spyware, dll.) pada seluruh endpoint dan infrastruktur jaringan PT Ecomindo Sarana Cipta.


#### A. Pencegahan dan Perlindungan Berlapis


**Penanggung Jawab:** IT Security  
**Frekuensi:** Konfigurasi berkelanjutan; update definisi otomatis harian


1. **Perlindungan Endpoint** (IT Security - Wajib aktif di semua endpoint)


   - Pasang dan aktifkan solusi Endpoint Protection Platform (EPP) / Endpoint Detection and Response (EDR) di semua perangkat (laptop, PC, server)
   - Fitur yang wajib diaktifkan:
     - Real-time scanning terhadap file yang diakses dan diunduh
     - Behavior-based detection untuk mendeteksi ancaman yang belum dikenal (zero-day)
     - Email attachment scanning dan web browsing protection
     - Automatic quarantine untuk file/proses yang terdeteksi berbahaya
   - Update definisi antivirus/antimalware dilakukan **otomatis setiap hari**
   - Perangkat yang tidak memiliki antivirus aktif akan diblokir dari akses jaringan korporat


2. **Perlindungan di Level Jaringan** (IT Security - Wajib aktif)


   - Firewall dengan modul IPS/IDS aktif untuk mendeteksi dan memblokir trafik berbahaya
   - Email gateway dikonfigurasi dengan anti-spam, anti-phishing, dan pemindaian lampiran berbahaya
   - Web proxy dengan URL filtering untuk memblokir akses ke situs berbahaya dan kategori tidak aman
   - DNS filtering untuk memblokir komunikasi malware ke Command & Control (C2) server


3. **Pengendalian Media Removable** (IT Security - Kebijakan wajib)


   - Penggunaan USB flash drive dan media eksternal pada perangkat perusahaan harus mendapat izin IT Security
   - Media yang diizinkan wajib dipindai malware sebelum digunakan
   - Autorun/Autoplay dinonaktifkan di semua endpoint


#### B. Deteksi dan Respons Insiden Malware


**Penanggung Jawab:** ISM / IT Security  
**Frekuensi:** Respons segera saat insiden terdeteksi


1. **Deteksi Malware** (ISM - Real-time)


   - Alert otomatis dari solusi EDR/EPP diterima dan ditangani oleh ISM
   - ISM melakukan verifikasi apakah deteksi merupakan true positive atau false positive
   - Lakukan pemindaian manual (on-demand scan) secara berkala â€” minimal satu kali per bulan untuk semua server


2. **Isolasi dan Penahanan** (IT Security - Dalam 30 menit setelah konfirmasi insiden)


   - Isolasi segera endpoint yang terinfeksi dari jaringan (network isolation) untuk mencegah penyebaran
   - Nonaktifkan akun pengguna yang terdampak sementara waktu untuk investigasi
   - Amankan bukti forensik sebelum melakukan pembersihan


3. **Investigasi dan Pembersihan** (IT Security - Dalam 4 jam)


   - Lakukan analisis forensik untuk mengidentifikasi: jenis malware, vektor masuk, sistem yang terdampak, dan data yang mungkin terekspos
   - Hapus malware menggunakan tools yang sesuai atau format ulang sistem jika diperlukan
   - Verifikasi pembersihan tuntas sebelum endpoint dikembalikan ke jaringan


4. **Pemulihan dan Tinjauan Pasca-Insiden** (IT Security & ISM - Dalam 48 jam)


   - Pulihkan sistem dari backup bersih jika diperlukan (lihat Prosedur 2.1)
   - Perbarui signature/rule deteksi berdasarkan karakteristik malware yang ditemukan
   - Lakukan root cause analysis dan identifikasi kelemahan yang dieksploitasi
   - Dokumentasikan insiden dalam Form-OP-02 dan sampaikan Laporan Insiden kepada ISM
   - Lakukan pelatihan/awareness tambahan kepada karyawan jika vektor insiden adalah faktor manusia (mis. phishing)


#### C. Pemantauan dan Tinjauan Berkala


**Penanggung Jawab:** IT Security  
**Frekuensi:** Mingguan dan bulanan


1. **Tinjauan Mingguan** (IT Security - Setiap minggu)


   - Review laporan deteksi dan karantina dari solusi EPP/EDR selama seminggu
   - Identifikasi tren ancaman dan endpoint yang paling sering menjadi target
   - Verifikasi bahwa semua endpoint memiliki definisi malware terkini


2. **Tinjauan Bulanan** (IT Security - Setiap bulan)


   - Evaluasi efektivitas solusi proteksi malware (detection rate, false positive/negative)
   - Review status kepatuhan endpoint (apakah semua perangkat terproteksi dan ter-update)
   - Laporkan status keamanan endpoint kepada ISM


### 2.4 Prosedur Patch Manajemen


Prosedur ini mengatur proses identifikasi, evaluasi, pengujian, dan penerapan patch (pembaruan keamanan) pada semua sistem operasi, perangkat lunak, dan firmware yang digunakan di PT Ecomindo Sarana Cipta.


#### A. Identifikasi dan Penilaian Kerentanan


**Penanggung Jawab:** IT Security  
**Frekuensi:** Pemindaian otomatis mingguan; tinjauan manual bulanan


1. **Pemindaian Kerentanan** (IT Security - Setiap minggu)


   - Jalankan vulnerability scanner (mis. Nessus, OpenVAS, atau setara) terhadap seluruh inventarisasi sistem
   - Hasilkan laporan kerentanan yang merinci: sistem terdampak, deskripsi kerentanan, dan skor CVSS
   - Kategorikan kerentanan berdasarkan prioritas dan tenggat waktu remediasi:


   | Tingkat | Skor CVSS | Tenggat Remediasi |
   |---------|-----------|-------------------|
   | **Kritis** | 9.0â€“10.0 | Dalam **30 hari kalender** |
   | **Tinggi** | 7.0â€“8.9 | Dalam **60 hari kalender** |
   | **Sedang** | 4.0â€“6.9 | Dalam **90 hari kalender** |
   | **Rendah** | 0.1â€“3.9 | Dijadwalkan pada siklus maintenance berikutnya |


2. **Review dan Prioritisasi** (IT Security & IT Operations - Setelah pemindaian)


   - Review laporan kerentanan bersama IT Operations untuk menentukan urutan penanganan
   - Pertimbangkan faktor mitigasi yang sudah ada (misal: sistem tidak dapat diakses dari internet) yang mungkin menurunkan prioritas efektif
   - Dokumentasikan kerentanan yang diterima risikonya (accepted risk) dengan justifikasi dan persetujuan ISM


#### B. Pengujian Patch


**Penanggung Jawab:** IT Operations  
**Frekuensi:** Wajib untuk setiap patch sebelum deployment ke production


1. **Persiapan Lingkungan Pengujian** (IT Operations - Sebelum pengujian)


   - Siapkan lingkungan testing yang mencerminkan konfigurasi production
   - Buat snapshot/backup sistem testing sebelum pengujian dimulai


2. **Pelaksanaan Pengujian Patch** (IT Operations - Minimal 24 jam sebelum deployment)


   - Terapkan patch di lingkungan testing terlebih dahulu
   - Lakukan pengujian kompatibilitas dengan aplikasi bisnis yang berjalan di atas sistem tersebut
   - Verifikasi bahwa tidak ada regresi atau gangguan fungsionalitas setelah patch diterapkan
   - Siapkan rollback plan yang jelas jika patch menyebabkan masalah


3. **Persetujuan Deployment** (IT Security + IT Operations - Setelah pengujian selesai)


   - Dokumentasikan hasil pengujian dan sampaikan kepada ISM/CAB untuk persetujuan deployment
   - Untuk patch kritis, persetujuan dapat dilakukan secara ekspres (< 24 jam)


#### C. Penerapan Patch ke Production


**Penanggung Jawab:** IT Operations  
**Frekuensi:** Sesuai prioritas patch; melalui change management untuk sistem kritis


1. **Penjadwalan Deployment** (IT Operations - Setelah persetujuan)


   - Jadwalkan deployment selama maintenance window yang telah ditetapkan (mis. Sabtu pukul 22:00 WIB) untuk meminimalkan dampak operasional
   - Untuk patch kritis, deployment dapat dilakukan di luar maintenance window dengan persetujuan ISM
   - Komunikasikan jadwal downtime kepada pengguna yang terdampak minimal 24 jam sebelumnya


2. **Pelaksanaan Deployment** (IT Operations - Sesuai jadwal)


   - Buat snapshot/backup sistem production sebelum patch diterapkan
   - Terapkan patch sesuai prosedur vendor atau panduan teknis internal
   - Dokumentasikan langkah-langkah yang dilakukan selama deployment


3. **Verifikasi Pasca-Deployment** (IT Operations - Segera setelah deployment)


   - Konfirmasi patch berhasil terpasang dan versi sistem telah diperbarui
   - Pantau stabilitas sistem selama minimal **24 jam** setelah deployment
   - Jalankan pengujian fungsional singkat untuk memastikan layanan berjalan normal
   - Perbarui inventarisasi software/hardware dengan versi patch terbaru


#### D. Penanganan Situasi Khusus


1. **Patch Darurat (Emergency Patch)** (IT Security + ISM - Segera)


   - Untuk kerentanan zero-day atau ancaman aktif yang sedang dieksploitasi, patch dapat diterapkan langsung tanpa menunggu siklus pengujian penuh
   - Lakukan uji minimal (smoke test) sebelum deployment
   - Dokumentasikan alasan darurat dan laporkan kepada ISM
   - Lakukan review pasca-deployment dalam 48 jam


2. **Sistem yang Tidak Dapat Di-patch** (IT Security + ISM)


   - Jika suatu sistem tidak dapat di-patch (mis. end-of-life, dependensi aplikasi), terapkan kontrol kompensasi:
     - Isolasi jaringan (network isolation)
     - Pemantauan yang diperketat
     - Perencanaan penggantian sistem
   - Dokumentasikan dan dapatkan persetujuan formal dari ISM sebagai accepted risk


### 2.5 Prosedur Change Manajemen


Prosedur ini mengatur proses permohonan, evaluasi, persetujuan, implementasi, dan tinjauan atas setiap perubahan pada sistem informasi PT Ecomindo Sarana Cipta untuk memastikan perubahan dilakukan secara terkendali dan meminimalkan risiko gangguan operasional.


#### A. Pengajuan Permohonan Perubahan (RFC)


**Penanggung Jawab:** Pemohon (Requestor)  
**Frekuensi:** Setiap kali ada perubahan sistem yang direncanakan


1. **Identifikasi Kebutuhan Perubahan** (Requestor)


   - Identifikasi kebutuhan perubahan: peningkatan fitur, perbaikan bug, kepatuhan keamanan, atau penggantian sistem
   - Klasifikasi tipe perubahan:
     - **Standard Change:** Perubahan rutin berisiko rendah dengan prosedur yang sudah disetujui sebelumnya (mis. pembaruan antivirus, penambahan user baru)
     - **Normal Change:** Perubahan yang memerlukan evaluasi dan persetujuan CAB penuh
     - **Emergency Change:** Perubahan darurat untuk mengatasi insiden kritis atau kerentanan aktif


2. **Pengisian RFC Form** (Requestor - Sebelum implementasi)


   - Isi Formulir RFC (Form-OP-01) secara lengkap dengan informasi:
     - Deskripsi perubahan yang akan dilakukan
     - Alasan dan justifikasi perubahan
     - Sistem dan layanan yang akan terdampak
     - Penilaian risiko (risiko pada sistem, layanan, keamanan, dan kepatuhan)
     - Rencana implementasi (langkah-langkah, timeline, resource yang dibutuhkan)
     - Rollback plan jika implementasi gagal
     - Rencana pengujian pasca-implementasi
   - Sampaikan RFC kepada CAB (Change Advisory Board) untuk evaluasi


#### B. Evaluasi dan Persetujuan Perubahan


**Penanggung Jawab:** Change Advisory Board (CAB)  
**Frekuensi:** Review RFC dalam 3 hari kerja (Normal Change); ekspres untuk Emergency Change


1. **Evaluasi Teknis dan Risiko** (CAB - Dalam 3 hari kerja)


   - CAB mengevaluasi kelayakan teknis, risiko keamanan, dan dampak terhadap layanan bisnis
   - Anggota CAB yang relevan dilibatkan sesuai tipe perubahan (mis. ISM untuk perubahan keamanan, Manajer Operasi untuk perubahan infrastruktur)
   - Jika diperlukan, CAB dapat meminta klarifikasi atau informasi tambahan kepada Requestor


2. **Keputusan CAB**


   - **Disetujui:** RFC dapat dilanjutkan ke implementasi sesuai jadwal
   - **Disetujui dengan Syarat:** RFC dapat dilanjutkan setelah penyesuaian tertentu dipenuhi
   - **Ditolak:** RFC tidak dapat dilanjutkan; Requestor diberikan alasan penolakan
   - Keputusan CAB didokumentasikan dalam RFC Form dan dikomunikasikan kepada Requestor


#### C. Implementasi Perubahan


**Penanggung Jawab:** IT Operations  
**Frekuensi:** Sesuai jadwal yang disetujui CAB


1. **Persiapan Implementasi** (IT Operations - Sebelum jadwal implementasi)


   - Buat backup sistem yang akan diubah sebagai langkah pengamanan
   - Siapkan rollback procedure sesuai yang tercantum dalam RFC
   - Komunikasikan jadwal dan dampak perubahan kepada pengguna yang terdampak


2. **Pelaksanaan Implementasi** (IT Operations - Sesuai change window)


   - Terapkan perubahan sesuai rencana implementasi yang tertulis dalam RFC
   - Lakukan implementasi selama change window yang disetujui (biasanya di luar jam kerja)
   - **Wajib dihadiri minimal 2 personel IT**: satu melaksanakan implementasi, satu memantau dan siap melakukan rollback â€” berlaku untuk seluruh perubahan Normal Change dan Emergency Change
   - Komunikasikan kepada pengguna terdampak jika terjadi downtime yang tidak terduga
   - Dokumentasikan setiap langkah yang dilakukan selama implementasi beserta timestamp-nya


3. **Verifikasi Segera Pasca-Implementasi** (IT Operations - Segera setelah implementasi)


   - Lakukan pengujian fungsional untuk memastikan sistem berfungsi normal setelah perubahan
   - Jika terjadi masalah yang tidak terduga, aktifkan rollback plan segera
   - Informasikan kepada CAB dan ISM jika terjadi masalah atau rollback


#### D. Tinjauan Pasca-Implementasi


**Penanggung Jawab:** IT Operations & CAB  
**Frekuensi:** Dalam 24â€“48 jam setelah implementasi selesai


1. **Pemantauan Pasca-Implementasi** (IT Operations - Minimal 24 jam)


   - Pantau sistem secara aktif selama minimal 24 jam setelah implementasi
   - Perhatikan: performa sistem, error log, feedback pengguna, dan indikator layanan bisnis


2. **Penutupan RFC** (IT Operations - Setelah pemantauan selesai)


   - Dokumentasikan hasil implementasi dalam RFC Form: berhasil/gagal, masalah yang ditemukan, tindakan yang diambil
   - Update inventarisasi sistem/konfigurasi sesuai perubahan yang berhasil diterapkan
   - Tutup (close) change ticket dan sampaikan laporan kepada CAB


#### E. Penanganan Emergency Change


**Penanggung Jawab:** ISM + IT Operations  
**Frekuensi:** Hanya untuk situasi darurat yang tidak dapat menunggu proses normal


1. **Kriteria Emergency Change**


   - Insiden keamanan aktif yang memerlukan respons segera (mis. eksploitasi kerentanan zero-day)
   - Kegagalan sistem kritis yang berdampak langsung pada layanan bisnis
   - Ancaman yang bila tidak segera ditangani dapat menyebabkan kerugian signifikan


2. **Proses Emergency Change**


   - Persetujuan dapat diberikan langsung oleh ISM atau Manajer IT tanpa menunggu rapat CAB penuh
   - Implementasi dapat dilakukan segera setelah persetujuan verbal/tertulis dari ISM
   - RFC Form **tetap wajib** diisi â€” boleh dilakukan setelah implementasi (post-facto documentation)
   - Tinjauan pasca-implementasi oleh CAB penuh dilakukan dalam **48 jam**


### 2.6 Prosedur Audit Trail


Prosedur ini mengatur pengaktifan, pemantauan, review, dan retensi audit trail pada seluruh lapisan sistem informasi PT Ecomindo Sarana Cipta, mencakup sistem operasi (OS), perangkat database, serta sistem/aplikasi bisnis.


#### A. Pengaktifan Audit Trail pada Sistem Operasi (OS)


**Penanggung Jawab:** IT Security / Sistem Administrator  
**Frekuensi:** Saat deployment sistem baru dan review tahunan


1. **Konfigurasi Audit Policy pada OS** (IT Security - Saat setup)


   - **Windows:** Aktifkan Windows Security Auditing melalui Group Policy dengan cakupan minimum:
     - *Logon/Logoff*: Audit logon berhasil dan gagal
     - *Object Access*: Audit akses file dan registry
     - *Privilege Use*: Audit penggunaan hak istimewa
     - *System Events*: Audit perubahan waktu sistem dan audit policy
     - *Account Management*: Audit pembuatan, perubahan, dan penghapusan akun
     - *Process Tracking*: Audit pembuatan dan penghentian proses
   - **Linux/Unix:** Aktifkan `auditd` daemon dengan ruleset minimum:
     - Monitor `/etc/passwd`, `/etc/shadow`, `/etc/sudoers`
     - Monitor akses dan modifikasi file konfigurasi sistem
     - Catat semua perintah yang dijalankan oleh root dan pengguna istimewa
     - Log semua percobaan login (sukses dan gagal) melalui syslog/rsyslog


2. **Validasi Konfigurasi Audit Trail** (IT Security - Setelah konfigurasi)


   - Lakukan uji coba aksi yang seharusnya tercatat (test login, akses file)
   - Verifikasi event muncul di log dengan lengkap dan benar
   - Dokumentasikan konfigurasi audit policy sebagai baseline


#### B. Pengaktifan Audit Trail pada Database


**Penanggung Jawab:** Database Administrator (DBA) / IT Security  
**Frekuensi:** Saat provisioning database baru dan review tahunan


1. **Konfigurasi Database Audit Logging** (DBA - Saat setup)


   - **MySQL/MariaDB:** Aktifkan General Query Log dan Audit Plugin (MariaDB Audit Plugin / MySQL Enterprise Audit)
   - **PostgreSQL:** Aktifkan `pgaudit` extension untuk mencatat:
     - DDL (Data Definition Language): CREATE, ALTER, DROP
     - DML (Data Manipulation Language): SELECT, INSERT, UPDATE, DELETE pada tabel sensitif
     - Koneksi masuk dan keluar dari database
     - Perubahan hak akses (GRANT, REVOKE) dan modifikasi pengguna
   - **Microsoft SQL Server:** Aktifkan SQL Server Audit atau C2 audit logging
   - **Oracle Database:** Aktifkan Unified Auditing untuk semua aksi privileged


2. **Cakupan Event Database yang Wajib Diaudit**


   - Semua percobaan autentikasi (sukses dan gagal)
   - Akses ke tabel/kolom yang mengandung data sensitif (PII, data keuangan)
   - Perubahan skema database (CREATE, ALTER, DROP TABLE)
   - Perubahan data pada tabel kritis (INSERT, UPDATE, DELETE)
   - Perubahan hak akses dan konfigurasi keamanan database
   - Eksekusi stored procedure dan fungsi dengan privilege tinggi


3. **Validasi Audit Trail Database** (DBA - Setelah konfigurasi)


   - Jalankan query uji dan verifikasi tercatat di log audit
   - Pastikan log memuat: timestamp, nama pengguna, host asal, perintah SQL, dan objek yang diakses


#### C. Pengaktifan Audit Trail pada Sistem/Aplikasi


**Penanggung Jawab:** Developer / IT Operations / IT Security  
**Frekuensi:** Saat pengembangan/deployment aplikasi dan review tahunan


1. **Persyaratan Audit Trail Aplikasi** (Developer - Saat pengembangan)


   - Setiap aplikasi **WAJIB** memiliki mekanisme application-level audit log yang mencatat:
     - Login dan logout pengguna (sukses dan gagal)
     - Perubahan data kritis (siapa, kapan, sebelum-setelah nilai)
     - Akses ke fitur atau data sensitif
     - Perubahan konfigurasi aplikasi
     - Aktivitas admin dan penggunaan fungsi istimewa
     - Error dan exception yang berkaitan dengan keamanan


2. **Standar Format Log Aplikasi** (Developer - Saat pengembangan)


   - Setiap entri log wajib memuat field berikut:
     - `timestamp`: Waktu kejadian dalam format ISO 8601 (UTC)
     - `user_id` / `username`: Identitas pengguna yang melakukan aksi
     - `source_ip`: Alamat IP asal permintaan
     - `action`: Jenis aksi yang dilakukan
     - `resource`: Objek/entitas yang menjadi target aksi
     - `result`: Hasil aksi (sukses/gagal)
     - `detail`: Informasi tambahan yang relevan


3. **Integrasi dengan Centralized Logging** (IT Operations - Saat deployment)


   - Konfigurasi aplikasi untuk mengirimkan log ke SIEM server terpusat
   - Gunakan agen log shipper (Filebeat, Fluentd, atau setara) untuk forward log
   - Pastikan log dienkripsi saat transit dan saat penyimpanan


#### D. Mekanisme Review Audit Trail


**Penanggung Jawab:** IT Security / Audit Internal  


1. **Tinjauan Harian** (ISM / IT Security - Setiap hari kerja)


   - Review alert otomatis dari SIEM untuk anomali dan kejadian kritis
   - Investigasi setiap alert dengan prioritas HIGH atau CRITICAL
   - Dokumentasikan hasil investigasi dalam log harian SOC


2. **Tinjauan Mingguan** (IT Security - Setiap minggu)


   - Analisis tren dan pola dari audit log OS, database, dan aplikasi
   - Identifikasi aktivitas mencurigakan: login di luar jam kerja, akses massal data, perubahan konfigurasi tidak terjadwal
   - Review log akses dari akun-akun privileged (admin, DBA, root)
   - Buat laporan ringkasan mingguan dan sampaikan kepada ISM


3. **Tinjauan Bulanan** (IT Security & Audit Internal - Setiap bulan)


   - Audit menyeluruh atas log dari seluruh lapisan (OS, DB, Aplikasi)
   - Verifikasi bahwa audit trail berfungsi dengan baik dan tidak ada celah
   - Cocokkan aktivitas akun dengan otorisasi yang berlaku
   - Identifikasi akun tidak aktif yang masih memiliki akses
   - Dokumentasikan temuan dalam Laporan Audit Bulanan (Form-OP-03)


4. **Tinjauan Triwulanan** (Audit Internal - Setiap triwulan)


   - Lakukan audit sampling komprehensif terhadap seluruh audit trail
   - Verifikasi kepatuhan terhadap prosedur ini
   - Review dan perbarui ruleset deteksi di SIEM
   - Laporkan temuan kepada manajemen (ISM dan Direktur)


#### E. Retensi Penyimpanan Log Audit Trail


**Penanggung Jawab:** IT Operations / IT Security  


1. **Kebijakan Retensi Log**


   - **Log OS (Windows Event Log, syslog/auditd):** Disimpan minimal **2 (dua) tahun**
   - **Log Database (audit log database):** Disimpan minimal **3 (tiga) tahun**
   - **Log Aplikasi:** Disimpan minimal **2 (dua) tahun**
   - **Log SIEM (centralized log):** Disimpan minimal **2 (dua) tahun**
   - **Log terkait insiden keamanan:** Disimpan minimal **5 (lima) tahun** atau sesuai persyaratan hukum yang berlaku


2. **Arsitektur Penyimpanan Log**


   - **Penyimpanan Panas (Hot Storage):** 3 bulan terakhir disimpan di SIEM server untuk akses cepat
   - **Penyimpanan Hangat (Warm Storage):** 3â€“12 bulan disimpan di NAS atau object storage internal
   - **Penyimpanan Dingin (Cold Storage):** >12 bulan diarsipkan ke cold storage terenkripsi (cloud atau tape)


3. **Keamanan dan Integritas Log**


   - Akses ke log audit dibatasi: hanya IT Security, ISM, dan Audit Internal yang dapat membaca log
   - Log bersifat **append-only**: tidak boleh dimodifikasi atau dihapus sebelum masa retensi berakhir
   - Enkripsi log wajib diterapkan baik saat transit (TLS 1.2+) maupun saat penyimpanan (AES-256)
   - Checksum/hash log dibuat secara periodik untuk verifikasi integritas
   - Backup log dilakukan bersamaan dengan backup sistem utama


4. **Penghapusan Log Setelah Masa Retensi** (IT Operations - Sesuai jadwal)


   - Log yang telah melampaui masa retensi dihapus secara aman menggunakan secure deletion
   - Proses penghapusan didokumentasikan dalam Log Penghapusan Audit Trail
   - Verifikasi penghapusan dilakukan oleh IT Security


### 2.7 Prosedur Pengamanan Jaringan


Prosedur ini mengatur implementasi pengamanan jaringan di PT Ecomindo Sarana Cipta, mencakup pemisahan lingkungan sistem, pengamanan batas jaringan internal dan eksternal, serta pemantauan koneksi jaringan secara berkelanjutan.


#### A. Pemisahan Lingkungan Sistem (Development, Testing, dan Production)


**Penanggung Jawab:** IT Operations / IT Security  
**Frekuensi:** Diterapkan saat setup infrastruktur dan ditinjau setiap tahun


1. **Prinsip Pemisahan Lingkungan** (IT Operations - Wajib diterapkan)


   - Tiga lingkungan sistem wajib dipisahkan secara fisik atau logis:
     - **Development (DEV):** Lingkungan untuk pengembangan kode dan fitur baru oleh tim developer
     - **Testing/Staging (UAT):** Lingkungan untuk pengujian fungsional, integrasi, dan user acceptance testing
     - **Production (PROD):** Lingkungan operasional aktif yang melayani pengguna akhir
   - Pemisahan dilakukan menggunakan salah satu atau kombinasi metode berikut:
     - Segmentasi VLAN (Virtual LAN) yang terpisah untuk setiap lingkungan
     - Subnet dan routing policy yang berbeda (mis. 10.10.0.0/24 untuk DEV, 10.20.0.0/24 untuk UAT, 10.30.0.0/24 untuk PROD)
     - Server/infrastruktur fisik atau virtual yang dedicated per lingkungan
     - Container/cluster Kubernetes yang terpisah dengan namespace berbeda


2. **Kebijakan Akses Antar Lingkungan** (IT Security - Wajib diterapkan)


   - Akses dari DEV ke PROD **dilarang keras** secara langsung
   - Promosi kode dari DEV â†’ UAT â†’ PROD hanya boleh melalui proses Change Manajemen (RFC, lihat Prosedur 2.5)
   - Data produksi **tidak boleh** disalin ke lingkungan DEV tanpa proses anonimisasi/masking terlebih dahulu
   - Kredensial akun (username, password, API key) untuk setiap lingkungan harus berbeda dan tidak boleh dibagikan lintas lingkungan
   - Prinsip least privilege diterapkan: developer hanya memiliki akses ke DEV, QA ke UAT, dan operator ke PROD


3. **Konfigurasi DNS dan Naming Convention** (IT Operations - Saat setup)


   - Setiap lingkungan menggunakan subdomain/hostname yang jelas membedakan lingkungan:
     - Contoh: `app-dev.internal`, `app-uat.internal`, `app.ecomindo.co.id`
   - Firewall rules diterapkan untuk mencegah komunikasi tidak sah antar lingkungan


4. **Verifikasi Pemisahan Lingkungan** (IT Security - Tahunan dan saat ada perubahan infrastruktur)


   - Lakukan pengujian penetrasi terbatas untuk memverifikasi tidak ada jalur akses tidak sah antar lingkungan
   - Review firewall rules dan ACL (Access Control List) yang mengatur batas antar lingkungan
   - Dokumentasikan hasil verifikasi dalam Laporan Tinjauan Infrastruktur


#### B. Pengamanan Jaringan Internal dan Eksternal


**Penanggung Jawab:** IT Security / Network Administrator  
**Frekuensi:** Konfigurasi awal dan review berkala (minimal tahunan)


1. **Arsitektur Keamanan Jaringan Berlapis** (IT Security - Wajib diterapkan)


   - Terapkan konsep Defense in Depth dengan lapisan pengamanan sebagai berikut:
     - **Perimeter Layer:** Firewall eksternal sebagai garis pertahanan pertama antara internet dan jaringan DMZ
     - **DMZ (Demilitarized Zone):** Zona terpisah untuk server yang dapat diakses publik (web server, mail server, reverse proxy)
     - **Internal Layer:** Firewall internal antara DMZ dan jaringan internal perusahaan
     - **Endpoint Layer:** Host-based firewall pada setiap server dan workstation


2. **Implementasi Firewall** (Network Administrator - Wajib aktif)


   - Firewall jaringan (Network Firewall) dikonfigurasi dengan:
     - Kebijakan default **deny all** â€” hanya traffic yang secara eksplisit diizinkan yang dapat masuk/keluar
     - Whitelist port dan protokol yang dibutuhkan (mis. HTTPS/443, SMTP/587, DNS/53)
     - Blokir seluruh akses langsung dari internet ke jaringan internal
     - Logging seluruh traffic yang diblokir maupun yang diizinkan
     - Pembaruan rule firewall melalui proses RFC (Change Manajemen)
   - Review dan audit ruleset firewall dilakukan minimal **setiap 6 bulan** untuk menghapus rule yang sudah tidak relevan


3. **Implementasi Web Application Firewall (WAF)** (IT Security - Wajib untuk aplikasi web publik)


   - WAF wajib dipasang di depan setiap aplikasi web yang dapat diakses dari internet
   - WAF dikonfigurasi untuk mendeteksi dan memblokir:
     - OWASP Top 10 vulnerabilities (SQL Injection, XSS, CSRF, dll.)
     - DDoS attack dan HTTP flood
     - Bot traffic dan scraping berbahaya
     - Akses dari IP address yang masuk daftar hitam (threat intelligence feeds)
   - Mode WAF awal dapat menggunakan **Detection Mode** selama 2 minggu untuk evaluasi false positive, kemudian beralih ke **Prevention/Blocking Mode**
   - Review dan tuning rule WAF dilakukan minimal **setiap 3 bulan**


4. **Pengamanan Akses Remote** (IT Security - Wajib)


   - Seluruh akses remote ke jaringan internal wajib menggunakan VPN (Virtual Private Network) dengan enkripsi minimum AES-256
   - Multi-Factor Authentication (MFA) wajib diaktifkan untuk semua koneksi VPN
   - Split tunneling dinonaktifkan untuk akun dengan akses ke data sensitif
   - Sesi VPN yang tidak aktif lebih dari 30 menit otomatis terputus


5. **Segmentasi Jaringan Internal** (Network Administrator - Wajib)


   - Jaringan internal dibagi ke dalam segmen-segmen terpisah berdasarkan fungsi:
     - Segmen Server (server produksi)
     - Segmen Workstation Karyawan
     - Segmen Manajemen/Admin (untuk akses administrasi server)
     - Segmen Tamu/Guest (akses internet terbatas, terisolasi dari jaringan internal)
   - Komunikasi antar segmen dikendalikan oleh firewall internal dan ACL


#### C. Monitoring Koneksi Jaringan, Review, dan Analisis


**Penanggung Jawab:** ISM / IT Security  
**Frekuensi:** Pemantauan real-time 24/7, review berkala harian/mingguan/bulanan


1. **Infrastruktur Pemantauan Jaringan** (IT Operations - Wajib aktif)


   - Pasang dan aktifkan tools pemantauan jaringan berikut:
     - **IDS/IPS (Intrusion Detection/Prevention System):** Untuk mendeteksi dan memblokir aktivitas mencurigakan di jaringan
     - **NetFlow/sFlow Collector:** Untuk analisis trafik dan deteksi anomali pola koneksi
     - **Network Performance Monitoring (NPM):** Untuk pemantauan bandwidth, latency, dan availability
     - **SIEM (Security Information and Event Management):** Untuk korelasi log dari firewall, IDS/IPS, dan perangkat jaringan
   - Seluruh log dari perangkat jaringan (firewall, switch, router, WAF) dikirimkan ke SIEM terpusat secara real-time


2. **Pemantauan Real-Time (24/7)** (ISM - Berkelanjutan)


   - ISM memantau dashboard SIEM dan NPM secara terus-menerus
   - Alert otomatis dikonfigurasi untuk kondisi berikut:
     - Lonjakan trafik tidak normal yang mengindikasikan DDoS atau data exfiltration
     - Koneksi ke/dari IP address yang masuk blacklist atau threat intelligence
     - Port scanning dan network reconnaissance activity
     - Percobaan koneksi ke port yang seharusnya tertutup
     - Traffic antara segmen jaringan yang seharusnya tidak berkomunikasi
     - Penggunaan bandwidth melebihi threshold yang ditetapkan
   - Setiap alert dengan prioritas HIGH atau CRITICAL wajib direspons dalam waktu **maksimal 1 jam**


3. **Tinjauan Harian** (IT Security / ISM - Setiap hari kerja)


   - Review ringkasan alert harian dari SIEM dan firewall
   - Identifikasi dan investigasi anomali traffic yang terdeteksi
   - Verifikasi status operasional firewall, WAF, dan IDS/IPS
   - Dokumentasikan temuan dalam Log Pemantauan Harian


4. **Tinjauan Mingguan** (IT Security - Setiap minggu)


   - Analisis tren trafik jaringan selama seminggu terakhir:
     - Pola penggunaan bandwidth per segmen
     - Top talkers (sumber/tujuan trafik terbanyak)
     - Pola koneksi yang tidak lazim
   - Review laporan IDS/IPS untuk ancaman yang berhasil dideteksi
   - Review top blocked traffic dari firewall dan WAF
   - Buat Laporan Keamanan Jaringan Mingguan dan sampaikan kepada ISM


5. **Tinjauan Bulanan** (IT Security & Audit Internal - Setiap bulan)


   - Analisis komprehensif tren keamanan jaringan sebulan terakhir
   - Review dan evaluasi efektivitas rule firewall dan WAF (identifikasi false positive/negative)
   - Verifikasi bahwa semua perubahan rule firewall/WAF dilakukan melalui proses RFC yang sah
   - Review daftar koneksi VPN aktif dan pastikan hanya pengguna yang berwenang yang terdaftar
   - Dokumentasikan temuan dalam Laporan Audit Keamanan Jaringan Bulanan (Form-OP-04)


6. **Tinjauan Triwulanan** (IT Security & Audit Internal - Setiap triwulan)


   - Lakukan pengujian penetrasi jaringan (network penetration testing) untuk mengidentifikasi kelemahan
   - Review dan pembaruan arsitektur keamanan jaringan jika diperlukan
   - Evaluasi kapasitas infrastruktur keamanan jaringan
   - Laporkan hasil kepada manajemen (ISM dan Direktur Operasional)


### 2.8 Prosedur Secure Coding dan Pengamanan Source Code


Prosedur ini mengatur standar pengembangan perangkat lunak yang aman dan mekanisme perlindungan source code milik PT Ecomindo Sarana Cipta, guna mencegah kerentanan keamanan sejak tahap pengembangan (shift-left security) sekaligus menjaga kerahasiaan dan integritas kode sumber.


#### A. Standar Pengembangan Sistem Berdasarkan Prinsip Secure Coding


**Penanggung Jawab:** Tim Developer / IT Security  
**Frekuensi:** Diterapkan pada setiap siklus pengembangan; diperbarui tahunan


1. **Prinsip Dasar Secure Coding yang Wajib Diterapkan** (Developer - Setiap pengembangan)


   - **Validasi Input:** Semua input dari pengguna atau sistem eksternal wajib divalidasi dan di-sanitasi sebelum diproses â€” tidak ada kepercayaan implisit terhadap data yang masuk (zero-trust input)
   - **Parameterized Query / Prepared Statement:** Seluruh query database wajib menggunakan parameterized query atau stored procedure untuk mencegah SQL Injection
   - **Output Encoding:** Output yang ditampilkan ke browser wajib di-encode untuk mencegah Cross-Site Scripting (XSS)
   - **Autentikasi yang Kuat:** Implementasikan mekanisme autentikasi yang aman:
     - Password disimpan menggunakan algoritma hashing yang kuat dengan salt (bcrypt, Argon2, atau PBKDF2)
     - Tidak menyimpan password dalam plaintext atau enkripsi reversibel
     - Terapkan proteksi terhadap brute force (rate limiting, lockout setelah N percobaan gagal)
   - **Otorisasi dan Least Privilege:** Setiap fungsi sistem hanya dapat diakses oleh pengguna yang memiliki hak yang sesuai; terapkan prinsip least privilege untuk semua akun layanan (service account)
   - **Manajemen Sesi yang Aman:** Token sesi harus acak (menggunakan CSPRNG), memiliki batas waktu, dan diinvalidasi saat logout
   - **Penanganan Error yang Aman:** Pesan error yang ditampilkan kepada pengguna tidak boleh mengungkap detail teknis internal (stack trace, path file, nama database, dsb.); detail error dicatat di log server
   - **Enkripsi Data Sensitif:** Data sensitif (nomor identitas, data keuangan, kata sandi, token) wajib dienkripsi menggunakan algoritma standar industri (AES-256 untuk data diam, TLS 1.2+ untuk data bergerak)
   - **Dependency yang Aman:** Library dan framework pihak ketiga yang digunakan wajib diperbarui secara rutin; hindari penggunaan komponen yang sudah tidak didukung (end-of-life)


2. **Referensi Standar Secure Coding**


   - **OWASP Top 10** sebagai acuan utama kerentanan aplikasi web yang wajib dicegah
   - **OWASP ASVS (Application Security Verification Standard)** sebagai panduan verifikasi keamanan aplikasi
   - **SEI CERT Coding Standards** untuk standar coding tingkat bahasa (C, Java, Python, dll.)
   - **SANS/CWE Top 25 Most Dangerous Software Weaknesses** sebagai acuan kerentanan perangkat lunak


3. **Integrasi Keamanan dalam Siklus Pengembangan (Secure SDLC)**


   - **Fase Perencanaan & Desain:** Lakukan threat modeling untuk mengidentifikasi potensi ancaman sejak fase desain; dokumentasikan Security Requirements bersama Functional Requirements
   - **Fase Pengembangan (Coding):**
     - Developer wajib mengikuti panduan secure coding yang berlaku
     - Lakukan code review berpasangan (peer code review) dengan fokus pada aspek keamanan sebelum kode di-merge
     - Gunakan Static Application Security Testing (SAST) tools untuk mendeteksi kerentanan secara otomatis dalam pipeline CI/CD (mis. SonarQube, Semgrep, Bandit)
   - **Fase Pengujian:**
     - Lakukan Dynamic Application Security Testing (DAST) pada lingkungan staging sebelum deployment ke production (mis. OWASP ZAP, Burp Suite)
     - Sertakan test case keamanan (negative test) dalam rangkaian automated testing
   - **Fase Deployment:**
     - Deployment ke production hanya dilakukan melalui proses RFC (lihat Prosedur 2.5)
     - Verifikasi konfigurasi keamanan server/container sebelum go-live (hardening checklist)
   - **Fase Pemeliharaan:**
     - Monitor aplikasi untuk kerentanan baru yang ditemukan pada dependency yang digunakan
     - Lakukan penetration testing minimal satu kali per tahun pada aplikasi yang dihadapkan ke internet


4. **Pelatihan Secure Coding** (Tim Developer - Tahunan dan saat onboarding)


   - Seluruh developer wajib mengikuti pelatihan secure coding minimal satu kali per tahun
   - Materi pelatihan mencakup: OWASP Top 10, pencegahan kerentanan umum, dan penggunaan SAST tools
   - Developer baru wajib menyelesaikan pelatihan secure coding dalam 30 hari pertama bergabung
   - Hasil pelatihan didokumentasikan dalam catatan pelatihan karyawan (lihat PROC-06)


#### B. Pengamanan Source Code Milik Organisasi


**Penanggung Jawab:** Tim Developer / IT Security / ISM  
**Frekuensi:** Kontrol berkelanjutan; review akses triwulanan


1. **Manajemen Repository Source Code** (Tim Developer - Wajib diterapkan)


   - Seluruh source code yang dimiliki PT Ecomindo Sarana Cipta wajib disimpan dalam sistem version control yang terpusat dan terkelola (mis. Git melalui GitLab self-hosted, GitHub Enterprise, atau Azure DevOps)
   - Penggunaan penyimpanan source code di lokasi tidak terkelola (USB drive, Google Drive pribadi, laptop lokal tanpa sinkronisasi) dilarang keras
   - Setiap repository wajib dikonfigurasi dengan pengaturan berikut:
     - Akses private â€” tidak ada repository yang boleh bersifat public tanpa persetujuan tertulis ISM
     - Branch protection pada branch utama (`main`/`master`): wajib melalui pull/merge request dan code review sebelum dapat di-merge
     - Mandatory code review oleh minimal satu reviewer sebelum merge ke branch produksi


2. **Pengendalian Akses ke Source Code** (IT Security - Wajib diterapkan)


   - Akses ke repository source code mengikuti prinsip least privilege:
     - **Developer:** Read + Write access hanya ke repository yang menjadi tanggung jawabnya
     - **Tim Developer / Tech Lead:** Write + Merge access ke branch produksi
     - **ISM / IT Security:** Read-only access untuk keperluan audit
     - **Pihak ketiga (kontraktor, vendor):** Akses dibatasi dan dimonitor; diberikan hanya selama masa keterlibatan aktif
   - Autentikasi ke sistem version control wajib menggunakan kombinasi:
     - Akun personal yang unik (tidak boleh berbagi akun)
     - SSH key atau Personal Access Token (PAT) yang terdaftar; tidak menggunakan password akun langsung
     - Multi-Factor Authentication (MFA) jika platform mendukung
   - Review hak akses repository dilakukan minimal **setiap 3 bulan** â€” akses yang tidak diperlukan segera dicabut


3. **Pencegahan Kebocoran Data Sensitif dalam Source Code** (Developer - Wajib dipatuhi)


   - Dilarang menyimpan data berikut langsung di dalam source code:
     - Kredensial (username, password, API key, secret key, private key)
     - String koneksi database (connection string) yang memuat password
     - Data pelanggan atau data sensitif lainnya
     - Konfigurasi environment production (IP address, nama host, path internal)
   - Gunakan mekanisme manajemen konfigurasi yang aman untuk menyimpan nilai sensitif:
     - Environment variables yang di-inject saat runtime
     - Secrets management tools (mis. HashiCorp Vault, AWS Secrets Manager, Azure Key Vault)
     - File konfigurasi terpisah yang tidak di-commit ke repository (didaftarkan di `.gitignore`)
   - Terapkan **pre-commit hooks** dan secret scanning tools (mis. git-secrets, TruffleHog, Gitleaks) untuk mendeteksi dan mencegah commit yang mengandung credential secara otomatis


4. **Penandaan dan Backup Source Code** (IT Operations - Berkelanjutan)


   - Backup repository source code dilakukan secara otomatis minimal **setiap hari** ke lokasi penyimpanan terpisah dari server repository utama
   - Enkripsi diterapkan pada backup repository source code
   - Verifikasi backup repository dilakukan minimal satu kali per bulan
   - Setiap versi release yang di-deploy ke production wajib di-tag (Git tag) dengan versi yang jelas untuk memudahkan rollback


5. **Penanganan Source Code saat Kerjasama dengan Pihak Ketiga** (ISM + Tim Developer - Saat onboarding vendor)


   - Sebelum memberikan akses source code kepada pihak ketiga (kontraktor, vendor pengembangan), wajib:
     - Menandatangani NDA yang mencakup klausul kerahasiaan source code (lihat PROC-01 Prosedur 4)
     - Mendapatkan persetujuan tertulis dari ISM
   - Akses pihak ketiga bersifat sementara â€” wajib dicabut segera setelah keterlibatan berakhir
   - Pemantauan aktivitas git (commit history, file yang diakses) dari akun pihak ketiga dilakukan selama masa keterlibatan


#### C. Tinjauan dan Audit Keamanan Source Code


**Penanggung Jawab:** IT Security / Tim Developer  
**Frekuensi:** Otomatis per commit; bulanan dan tahunan untuk tinjauan mendalam


1. **Pemindaian Otomatis (Per Commit / Per Build)** (CI/CD Pipeline - Otomatis)


   - SAST tools diintegrasikan dalam pipeline CI/CD dan dijalankan otomatis setiap ada commit atau pull request
   - Secret scanning dijalankan otomatis untuk setiap commit
   - Build yang mengandung kerentanan kritis (severity HIGH/CRITICAL) dari SAST **diblokir otomatis** dan tidak dapat dilanjutkan ke tahap berikutnya sebelum diperbaiki
   - Laporan hasil pemindaian dikirimkan kepada developer yang bersangkutan dan Tim Developer


2. **Code Review Keamanan** (Tim Developer / IT Security - Per pull request ke branch produksi)


   - Setiap kode yang akan di-merge ke branch produksi wajib melalui security-focused code review
   - Reviewer memeriksa aspek: validasi input, autentikasi/otorisasi, manajemen sesi, penggunaan kriptografi, dan penanganan error
   - Temuan dari code review wajib diperbaiki sebelum merge disetujui


3. **Tinjauan Bulanan** (Tim Developer & IT Security - Setiap bulan)


   - Review laporan akumulatif hasil SAST dalam sebulan terakhir
   - Identifikasi pola kerentanan yang berulang untuk dijadikan materi pelatihan
   - Review status dependency (library pihak ketiga): identifikasi yang sudah kedaluwarsa atau memiliki kerentanan yang diketahui (CVE)
   - Dokumentasikan dalam Laporan Keamanan Pengembangan Bulanan


4. **Audit Keamanan Aplikasi Tahunan** (IT Security + Pihak Ketiga Independen - Setiap tahun)


   - Lakukan **penetration testing** komprehensif terhadap aplikasi yang dihadapkan ke internet minimal satu kali per tahun, dilakukan oleh pihak ketiga yang independen
   - Lakukan **code audit** manual terhadap bagian-bagian kritis dari source code (fungsi autentikasi, kriptografi, mekanisme otorisasi)
   - Temuan dari audit wajib ditindaklanjuti sesuai tingkat keparahan:
     - Kritis/High: Diperbaiki dalam **30 hari**
     - Medium: Diperbaiki dalam **90 hari**
     - Low: Dijadwalkan dalam siklus pengembangan berikutnya
   - Laporkan hasil audit kepada ISM dan Manajemen


## 3. Formulir dan Template


### Form-OP-01: Request for Change (RFC)
```
ID RFC: ___________________________
Tanggal: __________________________
Pemohon: __________________________
Departemen: _______________________


Deskripsi Perubahan: ______________
___________________________________
___________________________________


Sistem yang Terpengaruh: __________
Penilaian Risiko: __________________
Dampak Bisnis: ____________________


Persetujuan CAB:
___________________________
Ketua CAB
Tanggal: __________


Status Implementasi:
â–¡ Terjadwal â–¡ Darurat â–¡ Selesai â–¡ Gagal


Catatan Pasca-Implementasi:
___________________________________
```


### Form-OP-02: Laporan Insiden
```
ID Insiden: ______________________
Tanggal/Waktu: ___________________
Pelapor: __________________________
Kategori: â–¡ Keamanan â–¡ Ketersediaan â–¡ Kinerja


Deskripsi: ________________________
___________________________________
Dampak: ___________________________


Tindakan yang Diambil: ____________
___________________________________


Resolusi: _________________________
Waktu Penyelesaian: _______________


Pelajaran yang Dipetik: ___________
```


### Log-OP-01: Backup Log
```
Tanggal | Waktu | Tipe Backup | Sistem | Status | Size | Lokasi
--------|-------|-------------|--------|--------|------|--------
```


## 4. Kontrol dan Pemantauan


### 4.1 Mekanisme Kontrol


- **Backup Otomatis**: Jadwal backup otomatis dengan verifikasi integritas harian
- **Integrasi SIEM**: Pencatatan log terpusat dengan korelasi event keamanan
- **Deteksi Endpoint**: Perlindungan malware secara real-time pada seluruh perangkat
- **Pengendalian Perubahan**: RFC wajib untuk seluruh perubahan pada sistem produksi


### 4.2 Pemantauan dan Audit


- Pemeriksaan kesehatan harian untuk seluruh sistem kritis
- Pemindaian kerentanan dilakukan setiap minggu
- Pengujian penetrasi dilakukan setiap bulan
- Pengujian pemulihan bencana dilakukan setiap triwulan


### 4.3 Pelaporan Insiden


- Insiden kritis: Respons dalam 1 jam
- Prioritas tinggi: Respons dalam 4 jam
- Prioritas sedang/rendah: Respons dalam 24 jam


## 5. Pemenuhan Standar


### Persyaratan Keamanan Operasi:


- âœ… **OP-1**: Prosedur operasi telah didokumentasikan secara lengkap dengan alur kerja yang jelas
- âœ… **OP-2**: Prosedur backup dan recovery telah ditetapkan dengan target RTO/RPO dan pengujian berkala
- âœ… **OP-3**: Logging dan pemantauan diterapkan melalui SIEM dengan pemantauan 24/7
- âœ… **OP-4**: Perlindungan malware diterapkan secara berlapis dengan rencana respons
- âœ… **OP-5**: Manajemen patch diterapkan dengan prioritisasi dan pengujian sebelum deployment
- âœ… **OP-6**: Manajemen perubahan dikelola melalui proses CAB dengan prosedur darurat
- âœ… **OP-7**: Manajemen kapasitas diterapkan melalui pemantauan utilisasi sumber daya
- âœ… **OP-8**: Manajemen insiden ditetapkan dengan waktu respons dan prosedur yang jelas
- âœ… **OP-9**: Audit trail diterapkan mencakup pengaktifan, peninjauan, dan retensi log pada OS, basis data, dan aplikasi
- âœ… **OP-10**: Pengamanan jaringan diterapkan melalui pemisahan lingkungan, firewall/WAF, dan pemantauan koneksi


## 6. Tanggung Jawab


| Peran | Tanggung Jawab |
|-------|----------------|
| ISM | Mengawasi keseluruhan operasi keamanan, memantau insiden, dan mengoordinasikan respons |
| IT Operations | Mengelola operasi harian dan melaksanakan proses manajemen perubahan |
| Developer | Melaksanakan pengembangan sistem yang aman, menerapkan secure coding, dan mengelola keamanan repository |
| IT Security | Mengelola kerentanan dan melaksanakan deployment patch keamanan |


## 7. Tinjauan dan Pembaruan


- **Frekuensi Peninjauan:** Dilakukan setiap tahun atau ketika terjadi perubahan signifikan pada infrastruktur atau kebijakan
- **Tanggung Jawab Peninjauan:** Tim IT Operations dan Tim Security
- **Persetujuan Pembaruan:** ISM dan Manajemen


## 8. Lampiran


- Lampiran A: Jadwal Backup dan Kebijakan Retensi
- Lampiran B: Panduan Konfigurasi SIEM
- Lampiran C: Playbook Respons Insiden
- Lampiran D: Diagram Alur Manajemen Perubahan
- Lampiran E: Hasil Pengujian Pemulihan Bencana
- Lampiran F: Baseline Konfigurasi Audit Trail (OS, Basis Data, Aplikasi)
- Lampiran G: Diagram Arsitektur Keamanan Jaringan dan Baseline Ruleset Firewall
- Lampiran H: Daftar Periksa Secure Coding dan Panduan Konfigurasi SAST Tools

**AKHIR DOKUMEN PROSEDUR**


*Dokumen ini bersifat Confidential dan hanya diperuntukkan bagi kebutuhan internal PT ECOMINDO SARANA CIPTA. Distribusi tanpa izin dari ISM dilarang.*


Tanggal Berlaku: 15 April 2026  
Tinjauan Selanjutnya: 15 April 2027