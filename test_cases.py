"""
Wrapper script to run tests from project root
This allows running: python test_cases.py
"""

import sys
import os

# Add project root to path
sys.path.insert(0, os.path.dirname(__file__))

# Import and run tests from tests module
from tests.test_cases import main

if __name__ == "__main__":
    main()
