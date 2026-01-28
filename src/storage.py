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


import json
import os

SLA_DIR = "data/sla_output"
os.makedirs(SLA_DIR, exist_ok=True)

def save_sla_json(contract_id, sla_data):
    path = os.path.join(SLA_DIR, f"{contract_id}_sla.json")
    with open(path, "w", encoding="utf-8") as f:
        json.dump(sla_data, f, indent=4)
    return path