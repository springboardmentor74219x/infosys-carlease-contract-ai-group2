def get_fair_price_range(car_price):
    """
    Returns a fair price range (+/- 5%)
    """
    lower = round(car_price * 0.95, 2)
    upper = round(car_price * 1.05, 2)
    return (lower, upper)