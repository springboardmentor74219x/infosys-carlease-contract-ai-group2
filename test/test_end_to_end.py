from src.classifier import analyze_contract

test_contracts = [
    {
        "car_model": "Toyota Corolla",
        "year": 2020,
        "price": 5600
    },
    {
        "car_model": "Toyota Corolla",
        "year": 2020,
        "price": 6000
    },
    {
        "car_model": "Toyota Corolla",
        "year": 2020,
        "price": 8000
    }
]

for contract in test_contracts:
    result = analyze_contract(contract)

    print("Car:", result["car"])
    print("Contract Price:", result["contract_price"])
    print("Fair Price:", result["fair_price"])
    print("Fairness:", result["fairness"])
    print("-" * 40)
