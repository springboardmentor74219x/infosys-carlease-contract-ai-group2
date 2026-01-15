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
