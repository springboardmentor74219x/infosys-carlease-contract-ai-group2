# src/fairness.py

def compute_fairness(contract_price, fair_price):
    if fair_price is None or fair_price == 0:
        return "UNKNOWN"

    ratio = contract_price / fair_price

    if ratio <= 1.01:
        return "FAIR"
    elif ratio <= 1.1:
        return "SLIGHTLY OVERPRICED"
    else:
        return "UNFAIR"


def contract_fairness_score(clause_summary, fair_price, monthly_emi):
    return compute_fairness(monthly_emi, fair_price)
