def compute_fairness(contract_price, fair_price_range):
    if fair_price_range is None:
        return "UNKNOWN"

    lower, upper = fair_price_range

    if contract_price <= upper:
        return "FAIR"
    elif contract_price <= upper * 1.2:
        return "SLIGHTLY OVERPRICED"
    else:
        return "UNFAIR"