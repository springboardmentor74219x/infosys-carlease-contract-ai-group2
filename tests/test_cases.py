"""
Test Cases for Car Lease Contract AI Project
Run from project root: python tests/test_cases.py
"""

import sys
import os

# Add project root to path
PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
sys.path.insert(0, PROJECT_ROOT)

from src.app import analyze_contract
from src.price_engine import get_fair_price_range
from src.fairness import compute_fairness
from src.classifier import extract_clauses

def test_analyze_contract():
    """Test the analyze_contract function"""
    print("=" * 60)
    print("TEST CASE 1: Basic Contract Analysis")
    print("=" * 60)
    
    contract_text_1 = """
    Loan amount mentioned.
    Tenure: 60 months.
    Interest Rate: 8.5% APR
    """
    
    try:
        result_1 = analyze_contract(
            contract_price=800000,
            car_price=800000,
            contract_text=contract_text_1
        )
        print("✅ Test Case 1 PASSED")
        print(f"Fair Price Range: {result_1.get('fair_price_range', 'N/A')}")
        print(f"Fairness Score: {result_1.get('fairness_score', 'N/A')}")
        print(f"QA Issues: {result_1.get('qa_issues', 'N/A')}")
    except Exception as e:
        print(f"❌ Test Case 1 FAILED: {str(e)}")
    
    print("\n" + "=" * 60)
    print("TEST CASE 2: Contract with Penalty Clause")
    print("=" * 60)
    
    contract_text_2 = """
    Loan amount mentioned.
    Tenure: 60 months.
    Penalty clause included: 5% early repayment penalty
    """
    
    try:
        result_2 = analyze_contract(
            contract_price=900000,
            car_price=800000,
            contract_text=contract_text_2
        )
        print("✅ Test Case 2 PASSED")
        print(f"Fair Price Range: {result_2.get('fair_price_range', 'N/A')}")
        print(f"Fairness Score: {result_2.get('fairness_score', 'N/A')}")
        print(f"QA Issues: {result_2.get('qa_issues', 'N/A')}")
    except Exception as e:
        print(f"❌ Test Case 2 FAILED: {str(e)}")


def test_price_engine():
    """Test the price estimation functionality"""
    print("\n" + "=" * 60)
    print("TEST CASE 3: Price Engine - Fair Price Range Estimation")
    print("=" * 60)
    
    test_cases = [
        (800000, "Toyota Corolla"),
        (900000, "Honda Civic"),
        (1200000, "Hyundai Creta")
    ]
    
    for car_price, car_model in test_cases:
        try:
            fair_range = get_fair_price_range(car_price)
            print(f"✅ {car_model} Price: ₹{car_price}")
            print(f"   Fair Range: ₹{fair_range[0]} - ₹{fair_range[1]}")
        except Exception as e:
            print(f"❌ {car_model}: {str(e)}")


def test_fairness_computation():
    """Test fairness score calculation"""
    print("\n" + "=" * 60)
    print("TEST CASE 4: Fairness Computation")
    print("=" * 60)
    
    test_scenarios = [
        (800000, 800000, "Exactly Fair"),
        (840000, 800000, "Slightly Higher (Fair Range)"),
        (950000, 800000, "Overpriced"),
    ]
    
    for contract_price, car_price, description in test_scenarios:
        try:
            fair_range = get_fair_price_range(car_price)
            fairness = compute_fairness(contract_price, fair_range)
            print(f"✅ {description}")
            print(f"   Car Price: ₹{car_price} | Fair Range: ₹{fair_range[0]}-₹{fair_range[1]} | Contract: ₹{contract_price} | Result: {fairness}")
        except Exception as e:
            print(f"❌ {description}: {str(e)}")


def test_clause_extraction():
    """Test clause extraction from contract text"""
    print("\n" + "=" * 60)
    print("TEST CASE 5: Contract Clause Extraction")
    print("=" * 60)
    
    contract_examples = [
        ("Simple contract with no special clauses", "No special clauses"),
        ("Contract with penalty clause for early repayment", "Penalty clause"),
        ("Foreclosure clause included in the agreement", "Foreclosure clause"),
    ]
    
    for contract_text, description in contract_examples:
        try:
            clauses = extract_clauses(contract_text)
            print(f"✅ {description}")
            if clauses:
                print(f"   Detected: {clauses}")
            else:
                print(f"   No issues detected")
        except Exception as e:
            print(f"❌ {description}: {str(e)}")


def main():
    """Run all test cases"""
    print("\n")
    print("╔" + "=" * 58 + "╗")
    print("║" + " " * 10 + "Car Lease Contract AI - Test Suite" + " " * 14 + "║")
    print("╚" + "=" * 58 + "╝")
    
    try:
        test_analyze_contract()
        test_price_engine()
        test_fairness_computation()
        test_clause_extraction()
        
        print("\n" + "=" * 60)
        print("✅ ALL TESTS COMPLETED")
        print("=" * 60)
        
    except Exception as e:
        print(f"\n❌ Test Suite Error: {str(e)}")
        import traceback
        traceback.print_exc()


if __name__ == "__main__":
    main()
