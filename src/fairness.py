def compute_fairness(contract_price, fair_price):
    if fair_price is None:
        return "UNKNOWN"

    ratio = contract_price / fair_price

    if ratio <= 1.05:
        return "FAIR"
    elif ratio <= 1.20:
        return "SLIGHTLY OVERPRICED"
    else:
        return "UNFAIR"
    
def contract_fairness_score(contract_text, fair_price, contract_price):
    # Week-8 robustness requirement
    if fair_price is None:
        return 50 # neutral score when market data missing

    score = 100

    ratio = contract_price / fair_price

    if ratio > 1.20:
        score -= 40
    elif ratio > 1.05:
        score -= 20

    risky_terms = ["penalty", "non-refundable", "termination fee"]
    for term in risky_terms:
        if term in contract_text.lower():
            score -= 15

    return max(score, 0)