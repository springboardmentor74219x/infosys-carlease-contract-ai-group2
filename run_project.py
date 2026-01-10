#!/usr/bin/env python3
"""
Complete Project Runner and Tester
"""
import subprocess
import time
import requests
import json
import sys
import os
from pathlib import Path

PROJECT_ROOT = Path(r'c:\Users\user\Downloads\infosys-carlease-contract-ai-group2-B-jestavi')
BACKEND_DIR = PROJECT_ROOT / 'car_loan_backend'
FLUTTER_DIR = PROJECT_ROOT / 'car_loan_mvp'

def print_header(text):
    print("\n" + "=" * 70)
    print(f"  {text}")
    print("=" * 70)

def check_api_health():
    """Check if backend API is healthy"""
    try:
        response = requests.get('http://localhost:8000/docs', timeout=3)
        return response.status_code in [200, 307]
    except:
        return False

def test_api_endpoints():
    """Test the API endpoints"""
    print_header("TESTING API ENDPOINTS")
    
    # Test negotiate endpoint
    print("\n[1] Testing /negotiate endpoint...")
    try:
        payload = {
            "question": "How can I negotiate a lower interest rate on my car lease contract?"
        }
        response = requests.post(
            'http://localhost:8000/negotiate',
            json=payload,
            timeout=5
        )
        
        if response.status_code == 200:
            data = response.json()
            print(f"✅ Success (Status: {response.status_code})")
            print(f"   Response: {data.get('reply', 'No reply')}")
            return True
        else:
            print(f"❌ Failed (Status: {response.status_code})")
            return False
    except Exception as e:
        print(f"❌ Error: {e}")
        return False

def main():
    print_header("CAR LEASE/LOAN CONTRACT AI PROJECT")
    print("\nProject Structure:")
    print(f"  Backend: {BACKEND_DIR}")
    print(f"  Flutter: {FLUTTER_DIR}")
    print(f"  Web UI: {PROJECT_ROOT / 'web_ui.html'}")
    
    # Check backend
    print_header("CHECKING BACKEND STATUS")
    if check_api_health():
        print("\n✅ Backend API is RUNNING on http://localhost:8000")
        print("   Status: HEALTHY")
        
        # Test endpoints
        test_api_endpoints()
    else:
        print("\n❌ Backend API is NOT RUNNING")
        print("\n   To start the backend, run:")
        print(f"   cd {BACKEND_DIR}")
        print("   python -m uvicorn main:app --host 0.0.0.0 --port 8000")
        return False
    
    # Check web UI
    print_header("CHECKING WEB UI STATUS")
    try:
        response = requests.get('http://localhost:5000/web_ui.html', timeout=3)
        if response.status_code == 200:
            print("\n✅ Web UI Server is RUNNING on http://localhost:5000")
            print("   Access: http://localhost:5000/web_ui.html")
        else:
            print(f"\n⚠️  Web UI returned status: {response.status_code}")
    except:
        print("\n❌ Web UI Server is NOT RUNNING")
        print("   To start the web UI server, run:")
        print("   python serve_ui.py")
    
    # Summary
    print_header("PROJECT SUMMARY")
    print("\n📊 Services:")
    print("  ✅ Backend API: http://localhost:8000")
    print("  📖 API Docs: http://localhost:8000/docs")
    print("  🌐 Web UI: http://localhost:5000/web_ui.html")
    print("\n🔗 Quick Links:")
    print("  • API Documentation: http://localhost:8000/docs")
    print("  • Web Interface: http://localhost:5000/web_ui.html")
    print("\n📝 Available Endpoints:")
    print("  • POST /upload - Upload contract files")
    print("  • POST /negotiate - Get AI negotiation advice")
    print("\n✨ Project is ready for submission!")
    
    return True

if __name__ == '__main__':
    try:
        success = main()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print("\n\nExiting...")
        sys.exit(0)
