import pandas as pd
from datetime import datetime

# Load market data
import os

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
prices = pd.read_csv(os.path.join(BASE_DIR, "data", "market_prices.csv"))

def estimate_fair_price(car_model, year):
   row = prices[prices["car_model"] == car_model]