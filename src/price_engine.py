import pandas as pd
from datetime import datetime

prices = pd.read_csv("E:\infosys\infosys-carlease-contract-ai-group2\data\market_prices.csv")

def estimate_fair_price(car_model, year):
    row = prices[(prices["car_model"] == car_model) & (prices["year"] == year)]
    if row.empty:
        return None

    base = row.iloc[0]["base_price"]
    dep = row.iloc[0]["depreciation_per_year"]

    current_year = datetime.now().year
    age = current_year - year

    fair_price = base * ((1 - dep) ** age)
    return round(fair_price, 2)