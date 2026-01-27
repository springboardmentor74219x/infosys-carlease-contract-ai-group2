import pandas as pd
from fpdf import FPDF
import os

df = pd.read_csv("data/sample_car_contracts.csv")

os.makedirs("data/uploads", exist_ok=True)

for i, row in df.head(2).iterrows():
    pdf = FPDF()
    pdf.add_page()
    pdf.set_auto_page_break(auto=True, margin=15)
    pdf.set_font("Arial", size=12)

    text = f"""
CAR LOAN CONTRACT

Customer: {row['customer_name']}
Contract Type: {row['contract_type']}
Vehicle: {row['vehicle_type']}
Monthly EMI: {row['monthly_emi']}
Interest Rate: {row['interest_rate']}
Tenure: {row['tenure_months']} months

Clauses:
{row['clause_summary']}
"""

    for line in text.split("\n"):
        pdf.multi_cell(0, 8, line)

    pdf.output(f"data/uploads/contract_{i+1}.pdf")

print("PDFs generated successfully.")