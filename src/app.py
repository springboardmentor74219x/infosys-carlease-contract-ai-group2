from fairness import compute_fairness
from price_engine import get_fair_price_range
from classifier import extract_clauses

def analyze_contract(contract_price, car_price, contract_text):
    fair_range = get_fair_price_range(car_price)
    fairness = compute_fairness(contract_price, fair_range)
    clauses = extract_clauses(contract_text)

    return {
        "fair_price_range": fair_range,
        "fairness_score": fairness,
        "qa_issues": clauses
    }