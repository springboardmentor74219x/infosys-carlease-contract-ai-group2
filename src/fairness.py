def compute_fairness(contract_price, fair_price):
    ratio = contract_price / fair_price

    if ratio <= 0.9:
        return "FAIR"
    elif ratio <= 1.1:
        return "SLIGHTLY OVERPRICED"
    else:
        return "UNFAIR"
