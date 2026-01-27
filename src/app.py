from flask import Flask, request, jsonify
from storage import save_uploaded_file, get_text_output_path
from ocr_service import extract_text_from_pdf

app = Flask(__name__)

@app.route("/", methods=["GET"])
def home():
    """
    Health check route to confirm the server is running
    """
    return "Milestone-1 OCR Backend is running successfully 🚀"

@app.route("/upload", methods=["POST"])
def upload_contract():
    """
    Upload PDF contract, extract text using OCR,
    and store both PDF and extracted text.
    """
    if "file" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["file"]

    if file.filename == "":
        return jsonify({"error": "Empty filename"}), 400

    # Save uploaded PDF
    pdf_path = save_uploaded_file(file)

    # Get output text file path
    text_path = get_text_output_path(file.filename)

    # Perform OCR
    extract_text_from_pdf(pdf_path, text_path)

    return jsonify({
        "message": "Contract processed successfully",
        "pdf_path": pdf_path,
        "text_path": text_path
    }), 200

if __name__ == "__main__":
    app.run(debug=True)
