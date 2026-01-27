import os
import shutil

UPLOAD_DIR = os.path.join("data", "uploads")
TEXT_DIR = os.path.join("data", "extracted_text")

os.makedirs(UPLOAD_DIR, exist_ok=True)
os.makedirs(TEXT_DIR, exist_ok=True)

def save_uploaded_file(file):
    file_path = os.path.join(UPLOAD_DIR, file.filename)
    file.save(file_path)
    return file_path

def get_text_output_path(pdf_filename):
    name = os.path.splitext(pdf_filename)[0]
    return os.path.join(TEXT_DIR, name + ".txt")