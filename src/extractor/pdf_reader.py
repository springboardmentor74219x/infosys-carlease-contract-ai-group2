import PyPDF2
def read_contract_pdf(file_path):
    """
    Extracts text from a PDF contract file page by page.
    """
    text = ""
    try:
        with open(file_path, "rb") as f:
            reader = PyPDF2.PdfReader(f)
            for page in reader.pages:
                content = page.extract_text()
                if content:
                    text += content + "\n"

    except Exception as e:
        print("Error reading PDF:", e)

    return text.strip()
