from src.app import analyze_contract

# Test Case 1
contract_text_1 = """
Loan amount mentioned.
Tenure: 60 months.
"""

result_1 = analyze_contract(
    contract_price=800000,
    car_price=800000,
    contract_text=contract_text_1
)

print("Test Case 1 Result:")
print(result_1)

# Test Case 2
contract_text_2 = """
Loan amount mentioned.
Tenure: 60 months.
Penalty clause included.
"""

result_2 = analyze_contract(
    contract_price=900000,
    car_price=800000,
    contract_text=contract_text_2
)

print("\nTest Case 2 Result:")
print(result_2)