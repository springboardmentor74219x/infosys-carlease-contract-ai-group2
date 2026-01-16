from src.price_engine import estimate_fair_price
from src.fairness import compute_fairness


def analyze_contract(contract):
    car_model = contract["car_model"]
    year = contract["year"]
    price = contract["price"]

    fair_price = estimate_fair_price(car_model, year)

    if fair_price is None:
        fairness = "UNKNOWN"
    else:
        fairness = compute_fairness(price, fair_price)

    return {
        "car": car_model,
        "contract_price": price,
        "fair_price": fair_price,
        "fairness": fairness
    }
