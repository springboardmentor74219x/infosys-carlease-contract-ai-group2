from flask import Flask, request, jsonify
import os
import json

from pdf2image import convert_from_path
import pytesseract

# ---------------- APP SETUP ----------------
app = Flask(__name__)

UPLOAD_FOLDER = "data/uploads"
EXTRACTED_FOLDER = "data/extracted_text"
ANALYSIS_FOLDER = "data/analysis"

os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(EXTRACTED_FOLDER, exist_ok=True)
os.makedirs(ANALYSIS_FOLDER, exist_ok=True)

POPPLER_PATH = r"C:\poppler\Library\bin"
pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

# Store last extracted text path (simple in-memory state)
LAST_TEXT_PATH = None


# ---------------- UPLOAD + OCR ----------------
@app.route("/upload", methods=["POST"])
def upload_contract():
    global LAST_TEXT_PATH

    if "file" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["file"]

    if file.filename == "":
        return jsonify({"error": "Empty filename"}), 400

    if not file.filename.lower().endswith(".pdf"):
        return jsonify({"error": "Only PDF files allowed"}), 400

    pdf_path = os.path.join(UPLOAD_FOLDER, file.filename)
    file.save(pdf_path)

    images = convert_from_path(pdf_path, poppler_path=POPPLER_PATH)

    extracted_text = ""
    for img in images:
        extracted_text += pytesseract.image_to_string(img) + "\n"

    text_filename = file.filename.replace(".pdf", ".txt")
    text_path = os.path.join(EXTRACTED_FOLDER, text_filename)

    with open(text_path, "w", encoding="utf-8") as f:
        f.write(extracted_text)

    # Save last extracted file
    LAST_TEXT_PATH = text_path

    return jsonify({
        "message": "Contract uploaded and OCR completed",
        "pdf_path": pdf_path,
        "text_path": text_path
    }), 200


# ---------------- ANALYZE ----------------
@app.route("/analyze", methods=["POST"])
def analyze_contract():
    global LAST_TEXT_PATH

    data = request.get_json(silent=True) or {}
    text_path = data.get("text_path") or LAST_TEXT_PATH

    if not text_path or not os.path.exists(text_path):
        return jsonify({
            "error": "No contract available for analysis. Upload a PDF first."
        }), 400

    with open(text_path, "r", encoding="utf-8") as f:
        contract_text = f.read()

    # ---- MOCK SLA EXTRACTION ----
    sla_data = {
        "lease_term": "36 months",
        "monthly_payment": "INR 18,500",
        "late_fee": "INR 500 per day",
        "maintenance_interval": "Every 10,000 km",
        "early_termination_fee": "3 months lease amount"
    }

    base_name = os.path.basename(text_path).replace(".txt", "")
    analysis_file = f"{base_name}_sla.json"
    analysis_path = os.path.join(ANALYSIS_FOLDER, analysis_file)

    with open(analysis_path, "w", encoding="utf-8") as f:
        json.dump(sla_data, f, indent=2)

    return jsonify({
        "message": "Contract analyzed successfully",
        "input_text_path": text_path,
        "analysis_path": analysis_path
    }), 200


# ---------------- RUN ----------------
if __name__ == "__main__":
    app.run(debug=True)
