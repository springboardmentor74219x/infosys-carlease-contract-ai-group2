from src.price_engine import estimate_fair_price
from src.fairness import compute_fairness


def analyze_contract(contract):
    car = contract["car_model"]
    year = contract["year"]
    price = contract["price"]

    fair_price = estimate_fair_price(car, year)
    fairness = compute_fairness(price, fair_price)

    return {
        "car": car,
        "year": year,
        "contract_price": price,
        "fair_price": fair_price,
        "fairness": fairness
    }

def generate_explanation(contract):
    analysis = analyze_contract(contract)

    prompt = f"""
Car: {analysis['car']}
Market Value: {analysis['fair_price']}
Offered Price: {analysis['contract_price']}
Fairness: {analysis['fairness']}

Explain this deal to the user in simple language.
"""

    response = llm.invoke(prompt)
    return response.content
