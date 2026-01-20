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

from src.classifier import analyze_contract

test = {
    "car_model": "Toyota Corolla",
    "year": 2020,
    "price": 8000
}

print(analyze_contract(test))

from langchain_google_genai import ChatGoogleGenerativeAI
import os

llm = ChatGoogleGenerativeAI(
    model="gemini-1.5-pro",
    google_api_key=os.getenv("GOOGLE_API_KEY")
)

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