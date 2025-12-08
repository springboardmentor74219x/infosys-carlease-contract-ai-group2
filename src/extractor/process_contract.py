import os
from csv_reader import read_contract_csv
from pdf_reader import read_contract_pdf
from text_cleaner import clean_text
def load_contract(file_path):
    """
    Loads CSV or PDF and returns clean text.
    """
    ext = os.path.splitext(file_path)[1].lower()
    # CSV extraction
    if ext == ".csv":
        raw_text = read_contract_csv(file_path)

    # PDF extraction
    elif ext == ".pdf":
        raw_text = read_contract_pdf(file_path)
    else:
        print("Unsupported file format:", ext)
        return ""

    return clean_text(raw_text)

# Quick test
if __name__ == "__main__":
    sample = "../../data/sample_car_contract.csv"
    output = load_contract(sample)
    print(output[:500])
