# Bot Telegram Pencatat Keuangan (n8n + Google Sheets)

Bot Telegram untuk mencatat pengeluaran harian langsung melalui chat Telegram.
Pesan yang dikirim pengguna akan diproses oleh n8n dan disimpan otomatis ke Google Sheets.

Contoh input:
- `geprek 12k`
- `bensin 55.5k`
- `ayam 25k`

---

## Fitur
- Pencatatan pengeluaran via Telegram
- Penyimpanan data ke Google Sheets
- Rekap pengeluaran 7 hari terakhir (`/week`)
- Batalkan input terakhir (`/undo`)
- Download file rekap (`/download`)
- Dapat digunakan oleh beberapa user
- Workflow berjalan di n8n (self-hosted)

---

## Arsitektur (Local Development)

- **n8n** dijalankan di localhost menggunakan Docker
- **ngrok** digunakan untuk menyediakan URL HTTPS publik (dibutuhkan Telegram webhook)
- **Google Sheets** sebagai penyimpanan data
- **Telegram Bot** sebagai interface pengguna

---

## Prasyarat
Pastikan sudah terinstall:
- Docker & Docker Compose
- Akun ngrok
- Telegram Bot Token (dari BotFather)
- Akun Google untuk Google Sheets (OAuth2 di n8n)

---

## Cara Menjalankan di Localhost (Docker + ngrok)

### 1. Clone repository
```bash
git clone https://github.com/udinvoldigoad/bot-pengeluaran.git
cd bot-pengeluaran
```
### 2. Siapkan file environment
Salin file contoh environment:
```bash
cp .env.example .env
```
Isi variabel penting di .env (sesuaikan dengan file Anda):
- N8N_HOST=localhost
- N8N_PORT=5678
- N8N_PROTOCOL=http
- WEBHOOK_URL= (kosong dulu, akan diisi setelah ngrok jalan)
Jangan pernah commit file .env.

### 3. Jalankan n8n
```bash
docker compose up -d
```
Buka n8n di browser: `http://localhost:5678`

### 4. Jalankan ngrok
Buka terminal baru, lalu jalankan:
```bash
ngrok http 5678
```
ngrok akan memberikan URL HTTPS publik, contoh: `https://abcd-1234.ngrok-free.app`
Salin URL tersebut.

### 5. Set WEBHOOK_URL
Edit file .env dan isi:
```bash
WEBHOOK_URL=https://abcd-1234.ngrok-free.app
```
Setelah itu restart n8n:
```bash
docker compose down
docker compose up -d
```
Langkah ini wajib agar Telegram webhook mengarah ke URL publik (bukan localhost).

### 6. Import workflow n8n
1. Masuk ke n8n Editor
2. Klik Import workflow
3. Import file JSON dari folder workflows/
4. Pastikan semua node tidak error

### 7. Setup Credentials di n8n
1. Telegram
    - Buat Telegram Credential
    - Masukkan Bot Token dari BotFather
2. Google Sheets
    - Buat Google Sheets OAuth2 Credential
    - Login dan authorize akun Google
    - Pastikan spreadsheet tujuan sudah ada dan bisa diakses

### 8. Aktifkan workflow & test
1. Klik Activate pada workflow
2. Kirim pesan ke bot Telegram: `makan 12k`
3. Pastikan data masuk ke Google Sheets
4. Coba perintah: `/undo`, `/week`, `/download`

### Troubleshooting

1. Telegram webhook tidak masuk
    - Pastikan WEBHOOK_URL sudah HTTPS (ngrok)
    - Pastikan n8n direstart setelah update .env
    - Pastikan workflow sudah Activate

2. Error HTTPS webhook
    - Telegram tidak menerima HTTP
    - Gunakan URL https:// dari ngrok

3. ngrok berubah URL
    - Jika ngrok direstart, URL akan berubah
    - Update WEBHOOK_URL
    - Restart n8n
    - Re-activate workflow

### Keamanan
- Tidak ada credential yang disimpan di repository
- .env dan data n8n tidak di-commit
- Workflow JSON sudah disanitasi