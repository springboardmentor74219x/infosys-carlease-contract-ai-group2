from pdf2image import convert_from_path
import pytesseract
import os

POPPLER_PATH = r"C:\poppler\poppler-25.12.0\Library\bin"
pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

def extract_text_from_pdf(pdf_path, output_text_path):
    images = convert_from_path(
        pdf_path,
        poppler_path=POPPLER_PATH
    )

    extracted_text = ""

    for img in images:
        text = pytesseract.image_to_string(img)
        extracted_text += text + "\n"

    with open(output_text_path, "w", encoding="utf-8") as f:
        f.write(extracted_text)