# from app import analyze_contract

# # Test Case 1
# contract_text = """
# Car loan contract.
# Interest rate is 9%.
# Tenure is 5 years.
# Penalty applies on late EMI.
# """

# result = analyze_contract(
#     contract_price=820000,
#     car_price=800000,
#     contract_text=contract_text
# )

# print("Test Case 1 Result:")
# print(result)

# # Test Case 2 (different format)
# contract_text_2 = """
# Loan amount mentioned.
# Tenure: 60 months.
# Penalty clause included.
# """

# result_2 = analyze_contract(
#     contract_price=900000,
#     car_price=800000,
#     contract_text=contract_text_2
# )

# print("Test Case 2 Result:")
# print(result_2)

import sys
sys.path.append("src")

from src.app import analyze_contract

# Test Case 1
contract_text = """
Car loan contract.
Interest rate is 9%.
Tenure is 5 years.
Penalty applies on late EMI.
"""

result = analyze_contract(
    contract_price=820000,
    car_price=800000,
    contract_text=contract_text
)

print("Test Case 1 Result:")
print(result)

# Test Case 2 (different format)
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

print("Test Case 2 Result:")
print(result_2)

# python test_cases.py in terminal to run