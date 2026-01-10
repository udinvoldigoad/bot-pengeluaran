# Bot Telegram Pencatat Keuangan (n8n + Google Sheets + AWS Free Tier)

Bot Telegram untuk mencatat pengeluaran harian dengan format teks bebas (contoh: `geprek 12k`, `ayam 25.5k`, `bensin 55.5k`).

Bot ini dibangun menggunakan **n8n yang di host di AWS Free Tier** menerima webhook Telegram melalui **Cloudflare Tunnel**, dan menyimpan data transaksi ke **Google Sheets**.

---

## Fitur
- 📥 Catat pengeluaran langsung via chat Telegram
- 📊 Rekap *7 hari terakhir* `/week` lengkap dengan total & kategori
- ↩️ Batalkan transaksi terakhir `/undo`
- 👥 Mendukung multi-user (dirancang untuk ±12 orang)
- ☁️ Self-hosted di AWS Free Tier (kontrol penuh, data milik sendiri)
- 💾 Simpan otomatis ke Google Sheets

## Arsitektur
- n8n self-hosted via Docker
- Webhook Telegram melalui Cloudflare Tunnel
- Storage transaksi: Google Sheets

## Menjalankan di server
1. Clone repo
2. Copy env:
   ```bash
   cp .env.example .env
    ```
3. Edit .env (isi domain kamu & secrets)
4. Jalankan:
    ```bash
   docker compose up -d
    ```
5. Buka n8n: `https://<domain>`
6. Import workflow dari `workflows/keuangan-lhs.workflow.json`
7. Setup Credentials di n8n:
    - Telegram Bot Token
    - Google Sheets OAuth2

## Keamanan
- Repository ini tidak menyertakan credential apa pun
- Jangan pernah commit `.env` atau data volume n8n