# src/fairness.py

def compute_fairness(contract_price, fair_price_range):
    """
    Determines fairness of a contract price based on fair price range.

    Parameters:
    - contract_price (float): The EMI or price mentioned in the contract
    - fair_price_range (tuple): (lower_bound, upper_bound)

    Returns:
    - str: FAIR / SLIGHTLY OVERPRICED / UNFAIR / UNKNOWN
    """

    if fair_price_range is None:
        return "UNKNOWN"

    lower, upper = fair_price_range

    if contract_price <= upper:
        return "FAIR"
    elif contract_price <= upper * 1.2:
        return "SLIGHTLY OVERPRICED"
    else:
        return "UNFAIR"


# ✅ Alias function (this is what you import)
def contract_fairness_score(contract_price, fair_price_range):
    return compute_fairness(contract_price, fair_price_range)
