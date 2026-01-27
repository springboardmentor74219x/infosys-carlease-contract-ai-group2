import os

# Directories for storing files
UPLOAD_DIR = os.path.join("data", "uploads")
TEXT_DIR = os.path.join("data", "extracted_text")

# Create directories if they don't exist
os.makedirs(UPLOAD_DIR, exist_ok=True)
os.makedirs(TEXT_DIR, exist_ok=True)

def save_uploaded_file(file):
    """
    Saves the uploaded PDF file to the uploads directory
    """
    file_path = os.path.join(UPLOAD_DIR, file.filename)
    file.save(file_path)
    return file_path

def get_text_output_path(pdf_filename):
    """
    Returns the output path for extracted text file
    """
    name = os.path.splitext(pdf_filename)[0]
    return os.path.join(TEXT_DIR, name + ".txt")
