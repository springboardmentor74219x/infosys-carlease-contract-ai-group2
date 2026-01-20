def extract_clauses(contract_text):
    issues = []

    text = contract_text.lower()

    if "penalty" in text:
        issues.append("Penalty clause detected")

    if "foreclosure" in text:
        issues.append("Foreclosure clause detected")

    return issues