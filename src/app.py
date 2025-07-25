import customtkinter as ctk
from flask import Flask, send_file
from PIL import Image
from customtkinter import CTkImage, CTkLabel, CTkButton, CTkFrame
from crossfiledialog import open_file
import threading
import socket
import qrcode
import os
import webbrowser

app = Flask(__name__)
UPLOAD_FOLDER = os.getcwd()
selected_file = ""

@app.route('/download')
def download_file(): # DOWNLOAD --------------------------------------------------------------------------------------------------------------------------------
    if selected_file:
        return send_file(os.path.join(UPLOAD_FOLDER, selected_file), as_attachment=True)
    return "No file selected", 404

def run_server():
    app.run(host='0.0.0.0', port=5000)

threading.Thread(target=run_server, daemon=True).start()

def get_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
    except Exception:
        ip = "127.0.0.1"
    finally:
        s.close()
    return ip

# === GUI Setup ===
ctk.set_appearance_mode("Dark")
ctk.set_default_color_theme("dark-blue")

root = ctk.CTk()
root.geometry("400x500")
root.title("📤 Beam")

frame = CTkFrame(root, fg_color="transparent")
frame.pack(pady=30, padx=20, expand=True)

title = CTkLabel(frame, text="📁 Beam a file & share", font=("Segoe UI", 20, "bold"))
title.pack(pady=10)

button = CTkButton(frame, text="Select File", command=lambda: select_file(), corner_radius=8)
button.pack(pady=15)

link_label = CTkLabel(frame, text="", font=("Segoe UI", 12, "underline"), text_color="#1E90FF", cursor="hand2")
link_label.pack(pady=10)

qr_label = CTkLabel(frame, text="")
qr_label.pack(pady=15)

footer = CTkLabel(root, text="⚡ Made by Ranne314", font=("Segoe UI", 10), text_color="gray")
footer.pack(pady=5)

def select_file():
    global selected_file
    filepath = open_file()
    if filepath:
        selected_file = os.path.basename(filepath)
        os.rename(filepath, os.path.join(UPLOAD_FOLDER, selected_file))
        url = f"http://{get_ip()}:5000/download"
        generate_qr(url)
        link_label.configure(text=url)
        link_label.bind("<Button-1>", lambda e: webbrowser.open(url))

def generate_qr(link):
    qr = qrcode.make(link)
    qr.save("qr.png")
    img = Image.open("qr.png").resize((200, 200))
    img_ctk = CTkImage(light_image=img, size=(200, 200))
    qr_label.configure(image=img_ctk)
    qr_label.image = img_ctk

root.mainloop()
