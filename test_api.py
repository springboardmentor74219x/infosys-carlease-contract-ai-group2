import requests
import json
import time

# Test the API endpoints
BASE_URL = "http://localhost:8000"

print("=" * 60)
print("CAR LEASE/LOAN CONTRACT AI ASSISTANT - API TEST")
print("=" * 60)

# Test 1: Check if API is running
print("\n[TEST 1] Checking if backend is running...")
try:
    response = requests.get(f"{BASE_URL}/docs", timeout=5)
    if response.status_code == 200 or response.status_code == 307:
        print("✅ Backend API is RUNNING on http://localhost:8000")
        print(f"   Status Code: {response.status_code}")
except Exception as e:
    print(f"❌ ERROR: Cannot connect to backend - {e}")
    print("   Make sure to start the backend with:")
    print("   python -m uvicorn main:app --host 0.0.0.0 --port 8000")
    exit(1)

# Test 2: Test negotiation endpoint
print("\n[TEST 2] Testing /negotiate endpoint...")
try:
    payload = {
        "question": "How can I negotiate a lower interest rate on my car lease contract?"
    }
    response = requests.post(f"{BASE_URL}/negotiate", json=payload, timeout=5)
    print(f"   Status: {response.status_code}")
    if response.status_code == 200:
        data = response.json()
        print(f"✅ Response received:")
        print(f"   {data}")
    else:
        print(f"⚠️  Unexpected status code: {response.status_code}")
except Exception as e:
    print(f"❌ ERROR: {e}")

# Test 3: Test upload endpoint
print("\n[TEST 3] Testing /upload endpoint...")
try:
    # Create a test file
    test_file = {"file": ("test.txt", b"Test contract content")}
    response = requests.post(f"{BASE_URL}/upload", files=test_file, timeout=5)
    print(f"   Status: {response.status_code}")
    if response.status_code == 200:
        data = response.json()
        print(f"✅ Response received:")
        print(f"   {data}")
    else:
        print(f"⚠️  Unexpected status code: {response.status_code}")
except Exception as e:
    print(f"❌ ERROR: {e}")

print("\n" + "=" * 60)
print("API DOCUMENTATION AVAILABLE AT:")
print(f"🔗 http://localhost:8000/docs")
print("=" * 60)
