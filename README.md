# 💾 Beam: Drop & Beam

Beam is a sleek, lightweight desktop app for instant file sharing. Built with Python, it lets you drop a file, beam a download link across your network, and share it via a QR code or clickable hyperlink — all in a minimal dark-mode UI.

---

## 🎯 Features

- 📁 Modern cross-platform file picker  
- 🌐 Local Flask server to host files instantly  
- 📲 Auto-generated QR code for easy sharing  
- 🔗 Clickable hyperlink opens directly in browser  
- 🖤 CustomTkinter dark-themed interface  
- 💨 Works offline on local networks — no cloud needed

---

## 🧩 Tech Stack

| Component     | Library            |
|---------------|--------------------|
| GUI           | `customtkinter`    |
| File Dialog   | `crossfiledialog`  |
| Hosting       | `flask`            |
| QR Generator  | `qrcode`           |
| Image Handler | `Pillow`           |

---

## 🚀 Installation

Download this repo and run install.sh

```bash
pip install customtkinter flask qrcode pillow crossfiledialog
