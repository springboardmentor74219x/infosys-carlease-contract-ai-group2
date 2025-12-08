import pandas as pd
def read_contract_csv(file_path):
    """
    Reads a contract CSV and merges the text content into one clean string.
    """
    try:
        df = pd.read_csv(file_path)
        text_data = ""

        # Combine all 'content' fields into one text block
        if "content" in df.columns:
            for _, row in df.iterrows():
                section = str(row.get("section", ""))
                content = str(row.get("content", ""))
                text_data += f"{section}: {content}\n"

        return text_data.strip()

    except Exception as e:
        print("Error reading CSV:", e)
        return ""
