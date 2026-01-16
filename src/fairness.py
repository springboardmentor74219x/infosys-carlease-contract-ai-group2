def compute_fairness(contract_price, fair_price):
    ratio = contract_price / fair_price

    # Allow up to 1% margin as FAIR
    if ratio <= 1.01:
        return "FAIR"
    elif ratio <= 1.1:
        return "SLIGHTLY OVERPRICED"
    else:
        return "UNFAIR"
