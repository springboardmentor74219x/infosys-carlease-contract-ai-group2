from flask import Flask, request, jsonify
from src.ocr_service import extract_text_from_pdf
from src.storage import save_uploaded_file, get_text_output_path

app = Flask(__name__)
@app.route("/upload", methods=["POST"])
def upload_contract():
    if "file" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400
    file = request.files["file"]
    pdf_path = save_uploaded_file(file)
    text_path = get_text_output_path(file.filename)
    extract_text_from_pdf(pdf_path, text_path)
    return jsonify({
        "message": "Contract processed successfully",
        "pdf_path": pdf_path,
        "text_path": text_path
    })
if __name__ == "__main__":
    app.run(debug=True)