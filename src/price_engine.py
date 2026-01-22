def estimate_fair_price(monthly_emi):
    """
    Returns a fair EMI price range (+/- 5%)
    """
    lower = round(monthly_emi * 0.95, 2)
    upper = round(monthly_emi * 1.05, 2)
    return lower, upper
