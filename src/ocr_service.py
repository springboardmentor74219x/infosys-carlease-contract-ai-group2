from pdf2image import convert_from_path
import pytesseract
import os

# Correct paths
POPPLER_PATH = r"C:\poppler\poppler-25.12.0\Library\bin"
pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

def extract_text_from_pdf(pdf_path, output_txt_path):
    images = convert_from_path(
        pdf_path,
        poppler_path=POPPLER_PATH
    )

    full_text = ""
    for i, image in enumerate(images):
        text = pytesseract.image_to_string(image)
        full_text += f"\n--- Page {i+1} ---\n{text}"

   # os.makedirs(os.path.dirname(output_txt_path), exist_ok=True)
    with open(output_txt_path, "w", encoding="utf-8") as f:
        f.write(full_text)

   # return output_txt_path