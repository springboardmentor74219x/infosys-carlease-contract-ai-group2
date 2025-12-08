import re
def clean_text(text):
    """
    Basic cleaning for contract text: remove extra spaces, newlines, and symbols.
    """
    text = text.replace("\n", " ")
    text = re.sub(r"\s+", " ", text)  
    text = re.sub(r"[^\x00-\x7F]+", " ", text)  # remove special unicode chars
    return text.strip()
