import os
import pandas as pd
from datetime import datetime

# --- Robust path handling (always works) ---
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_PATH = os.path.join(BASE_DIR, "data", "market_prices.csv")

# Load CSV safely
prices = pd.read_csv(DATA_PATH)

def estimate_fair_price(car_model, year):
    row = prices[prices["car_model"] == car_model]

    if row.empty:
        return None

    base = row.iloc[0]["base_price"]
    dep = row.iloc[0]["depreciation_per_year"]

    current_year = datetime.now().year
    age = current_year - year

    fair_price = base * ((1 - dep) ** age)
    return float(round(fair_price, 2))
