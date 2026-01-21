# 🚗 Car Lease Contract AI - Negotiation Assistant

> **Smart Contract Analysis & Negotiation Platform using AI**
> 
> A comprehensive solution that combines AI-powered contract analysis with a Flutter mobile app to help customers make informed decisions about car lease contracts.

---

## 📋 Table of Contents

- [Project Overview](#-project-overview)
- [Key Features](#-key-features)
- [Project Architecture](#-project-architecture)
- [Technology Stack](#-technology-stack)
- [Installation & Setup](#-installation--setup)
- [Backend Setup](#-backend-setup)
- [Frontend Setup](#-frontend-setup)
- [API Endpoints](#-api-endpoints)
- [How to Use](#-how-to-use)
- [Test Cases](#-test-cases)
- [Project Structure](#-project-structure)
- [Data Files](#-data-files)
- [Troubleshooting](#-troubleshooting)
- [Future Enhancements](#-future-enhancements)

---

## 🎯 Project Overview

**Car Lease Contract AI** is an intelligent negotiation assistant that:
- Analyzes car lease contracts using OCR and NLP
- Detects unfair clauses and risks
- Estimates fair market prices
- Provides personalized negotiation advice
- Detects phishing emails in contract communications
- Offers mobile-first user experience

### Problem Statement
Customers often struggle to understand complex car lease contracts and lack negotiating power against dealers. This solution empowers them with AI-driven insights.

### Solution
An end-to-end platform combining:
1. **Backend AI Engine** - Contract analysis, fairness scoring, price estimation
2. **Mobile App** - User-friendly Flutter interface
3. **Email Security** - Phishing detection for safe communications

---

## ✨ Key Features

### 1. **Contract Analysis** 📄
- OCR processing of PDF/Image contracts
- Automatic extraction of key terms (APR, tenure, penalties)
- Clause detection and analysis
- Risk flagging and warnings

### 2. **Fairness Scoring** ⚖️
- AI-powered fairness assessment
- Contract price vs. fair market price comparison
- Risk level determination
- Actionable insights

### 3. **Price Engine** 💰
- Fair market price estimation
- Vehicle depreciation calculations
- EMI-based valuation
- Price range recommendations

### 4. **Negotiation Assistant** 💬
- AI-powered negotiation advice
- Personalized recommendations
- Multiple scenario analysis
- Clause-specific negotiation tips

### 5. **Phishing Detection** 🔒
- Email security scanning
- Suspicious link detection
- Domain validation
- Attachment safety checks

### 6. **Mobile App** 📱
- Beautiful Flutter UI with gradient design
- Secure login (Name + Password)
- Contract upload functionality
- Real-time analysis dashboard
- Negotiation advice interface

---

## 🏗️ Project Architecture

```
┌─────────────────────────────────────────────────┐
│         Flutter Mobile App (UI Layer)            │
│  ┌──────────────────────────────────────────┐   │
│  │  Login Screen → Upload → Dashboard       │   │
│  │  (Nadvik / 1234)                         │   │
│  └──────────────────────────────────────────┘   │
└────────────────┬────────────────────────────────┘
                 │ HTTP/REST API
┌────────────────▼────────────────────────────────┐
│      Flask Backend (API Layer)                   │
│  ┌──────────────────────────────────────────┐   │
│  │  • Upload Endpoint                       │   │
│  │  • Negotiation Endpoint                  │   │
│  │  • Email Processing Routes               │   │
│  └──────────────────────────────────────────┘   │
└────────────────┬────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────┐
│    AI/ML Engine (Business Logic Layer)           │
│  ┌──────────────────────────────────────────┐   │
│  │  • classifier.py (Clause Extraction)     │   │
│  │  • price_engine.py (Fair Price)          │   │
│  │  • fairness.py (Fairness Scoring)        │   │
│  │  • phishing_detector.py (Email Safety)   │   │
│  └──────────────────────────────────────────┘   │
└────────────────┬────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────┐
│      Data Layer                                  │
│  ┌──────────────────────────────────────────┐   │
│  │  • CSV datasets                          │   │
│  │  • Market prices                         │   │
│  │  • Training data                         │   │
│  └──────────────────────────────────────────┘   │
└─────────────────────────────────────────────────┘
```

---

## 💻 Technology Stack

### Backend
- **Language**: Python 3.13
- **Framework**: Flask
- **Libraries**:
  - `pandas` - Data processing
  - `numpy` - Numerical operations
  - `http` - API requests
  - `json` - Data serialization
  - `re` - Pattern matching (phishing detection)

### Frontend
- **Framework**: Flutter
- **Language**: Dart
- **UI**: Material Design 3
- **Packages**:
  - `file_picker` - File selection
  - `http` - API calls
  - `flutter/material` - UI components

### Data & Testing
- **Notebooks**: Jupyter for analysis
- **Testing**: Python unittest framework
- **Data Format**: CSV

---

## 📦 Installation & Setup

### Prerequisites
- Python 3.11+
- Flutter SDK
- Git
- A code editor (VS Code recommended)

### Clone Repository
```bash
git clone https://github.com/springboardmentor74219x/infosys-carlease-contract-ai-group2.git
cd infosys-carlease-contract-ai-group2
```

---

## 🔧 Backend Setup

### 1. Create Virtual Environment
```bash
python -m venv venv
source venv/Scripts/activate  # Windows
# or
source venv/bin/activate  # Mac/Linux
```

### 2. Install Dependencies
```bash
pip install -r car_loan_backend/requirements.txt
```

### 3. Run Backend Server
```bash
cd car_loan_backend
python main.py
```

**Expected Output:**
```
 * Running on http://127.0.0.1:8000
```

### 4. Test Backend
```bash
python test_cases.py
```

**Expected Results:**
```
✅ Test Case 1: Basic Contract Analysis - PASSED
✅ Test Case 2: Contract with Penalty Clause - PASSED
✅ Test Case 3: Price Engine - PASSED
✅ Test Case 4: Fairness Computation - PASSED
✅ Test Case 5: Clause Extraction - PASSED
```

---

## 📱 Frontend Setup

### 1. Navigate to Flutter Project
```bash
cd car_loan_mvp
```

### 2. Get Dependencies
```bash
flutter pub get
```

### 3. Run App
```bash
# On Android Emulator
flutter run

# Or specific device
flutter run -d <device_id>
```

### 4. Build APK (Optional)
```bash
flutter build apk
flutter build apk --release
```

### Login Credentials
- **Name**: `Nadvik`
- **Password**: `1234`

---

## 🔌 API Endpoints

### Contract Upload
```http
POST /upload
Content-Type: multipart/form-data

Body:
- file: <PDF/Image file>
```

**Response:**
```json
{
  "status": "success",
  "contract_id": "12345",
  "extracted_data": {
    "apr": 8.5,
    "term_months": 60,
    "monthly_payment": 450,
    "penalty_clause": "5% early repayment"
  }
}
```

### Negotiation Advice
```http
POST /negotiate
Content-Type: application/json

Body:
{
  "question": "How can I reduce my APR?"
}
```

**Response:**
```json
{
  "reply": "Based on your contract, you can negotiate..."
}
```

### Email Phishing Check
```http
POST /api/emails/check-phishing
Content-Type: application/json

Body:
{
  "sender": "dealer@company.com",
  "subject": "Contract Review",
  "body": "Please review your contract..."
}
```

**Response:**
```json
{
  "status": "success",
  "phishing_detection": {
    "risk_score": 25,
    "is_phishing": false,
    "detected_issues": [],
    "recommendation": "✅ SAFE - Appears to be legitimate"
  }
}
```

---

## 🎮 How to Use

### Step 1: Login
1. Open Flutter app
2. Enter Name: `Nadvik`
3. Enter Password: `1234`
4. Tap "Sign In"

### Step 2: Upload Contract
1. Tap "Upload Contract" on next screen
2. Select PDF, PNG, JPG, or JPEG file
3. Tap "Upload & Analyze"

### Step 3: View Analysis
1. Dashboard shows:
   - Upload status ✅
   - Analysis steps (OCR, Risk, Negotiation)
   - Fair price range
   - Fairness score

### Step 4: Get Negotiation Advice
1. Tap "Get Negotiation Advice"
2. View AI-generated recommendations
3. Use tips for actual negotiations

### Step 5: Check Email Safety
1. Share suspicious emails
2. App analyzes phishing risk
3. Receive security recommendations

---

## 🧪 Test Cases

### Run All Tests
```bash
python tests/test_cases.py
```

### Test Coverage

#### Test Case 1: Basic Contract Analysis
- **Input**: Contract with tenure info
- **Expected**: Fair price range, fairness score = FAIR
- **Status**: ✅ PASSED

#### Test Case 2: Contract with Penalty
- **Input**: Contract with 5% early repayment penalty
- **Expected**: Detected penalty, fairness = SLIGHTLY OVERPRICED
- **Status**: ✅ PASSED

#### Test Case 3: Price Engine
- **Input**: Vehicle prices
- **Expected**: Fair range calculations ±5%
- **Status**: ✅ PASSED

#### Test Case 4: Fairness Scoring
- **Input**: Various price scenarios
- **Expected**: FAIR, SLIGHTLY OVERPRICED, UNFAIR
- **Status**: ✅ PASSED

#### Test Case 5: Clause Extraction
- **Input**: Contract text with clauses
- **Expected**: Detect penalty and foreclosure clauses
- **Status**: ✅ PASSED

---

## 📁 Project Structure

```
infosys-carlease-contract-ai-group2/
├── car_loan_backend/
│   ├── main.py                 # Flask server
│   └── requirements.txt         # Backend dependencies
│
├── car_loan_mvp/               # Flutter Mobile App
│   ├── lib/
│   │   ├── main.dart           # App entry point
│   │   ├── screens/
│   │   │   ├── login_screen.dart       # Login UI
│   │   │   ├── upload_screen.dart      # Contract upload
│   │   │   └── dashboard_screen.dart   # Analysis dashboard
│   │   └── services/
│   │       └── api_services.dart       # API client
│   ├── pubspec.yaml            # Flutter dependencies
│   └── android/, ios/, web/    # Platform-specific code
│
├── src/                        # Python Modules
│   ├── app.py                  # Main application logic
│   ├── classifier.py           # Clause extraction
│   ├── fairness.py             # Fairness scoring
│   ├── phishing_detector.py    # Email security
│   ├── price_engine.py         # Price estimation
│   ├── emails_routes.py        # Email API routes
│   └── __pycache__/
│
├── tests/
│   ├── test_cases.py           # Comprehensive test suite
│   ├── test_end_to_end.py      # Integration tests
│   └── __pycache__/
│
├── notebook/                   # Jupyter Notebooks
│   ├── carlease-contract-ai-project.ipynb
│   ├── W3_assignment_nadvik-k-m.ipynb
│   ├── Milestone1_nadvik-k-m.ipynb
│   ├── Milestone2_nadvik-k-m.ipynb
│   ├── milestone3_backend_test.ipynb
│   ├── milestone4_final.ipynb
│   └── Mileestone2_evaluation.ipynb
│
├── data/                       # Datasets
│   ├── sample_car_contracts.csv
│   ├── sample_car_contracts_with_vin.csv
│   ├── market_prices.csv
│   ├── Milestone_2_contract_evaluation_dataset_nadvik-k-m.csv
│   └── batch2_contracts_125rows.csv
│
├── test_cases.py               # Quick test runner
├── README.md                   # This file
├── LICENSE
└── .git/

```

---

## 📊 Data Files

### Sample Data Format

**Contracts CSV**
```csv
contract_id,customer_name,vehicle_type,contract_price,monthly_emi,apr,tenure_months,penalty_clause
1,John Doe,Toyota Corolla,800000,15000,8.5,60,5% early repayment
```

**Market Prices CSV**
```csv
car_model,year,base_price,depreciation_per_year
Toyota Corolla,2020,800000,0.08
Honda Civic,2019,900000,0.09
```

---

## 🐛 Troubleshooting

### Backend Issues

#### Port 8000 Already in Use
```bash
# Kill process on port 8000
lsof -i :8000  # Mac/Linux
netstat -ano | findstr :8000  # Windows
```

#### Module Not Found Error
```bash
# Reinstall dependencies
pip install --upgrade -r car_loan_backend/requirements.txt
```

#### CSV File Not Found
```bash
# Ensure data folder is in project root
# Check paths in price_engine.py use absolute paths
```

### Frontend Issues

#### Flutter Dependency Issues
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

#### Device Not Found
```bash
flutter devices
flutter run -d <device_id>
```

#### Build Errors
```bash
flutter doctor  # Check environment setup
flutter pub get
flutter clean && flutter run
```

### API Connection Issues

#### Backend Not Responding
1. Check backend is running: `http://127.0.0.1:8000`
2. Check firewall settings
3. Verify baseUrl in `api_services.dart`

#### CORS Issues
- Ensure Flask has CORS enabled
- Check API endpoint matches frontend URL

---

## 🚀 Future Enhancements

### Phase 2 Features
- [ ] Real-time OCR processing with progress bar
- [ ] Multi-language support
- [ ] Blockchain-based contract verification
- [ ] Advanced NLP for better clause detection
- [ ] Chat-based negotiation assistant
- [ ] Contract comparison tool
- [ ] Document storage in cloud

### Phase 3 Features
- [ ] Integration with dealer systems
- [ ] Mobile payment processing
- [ ] Push notifications for alerts
- [ ] Offline mode support
- [ ] Export contracts as PDF
- [ ] Multi-user account support

### Technical Improvements
- [ ] Implement JWT authentication
- [ ] Add database (PostgreSQL/MongoDB)
- [ ] Docker containerization
- [ ] CI/CD pipeline with GitHub Actions
- [ ] Performance optimization
- [ ] Analytics dashboard

---

## 📞 Support & Contact

### Issues & Bugs
Report issues on GitHub: [GitHub Issues](https://github.com/springboardmentor74219x/infosys-carlease-contract-ai-group2/issues)

### Pull Requests
Current PR: [Milestone 3 – Flutter App & Negotiation Assistant](https://github.com/springboardmentor74219x/infosys-carlease-contract-ai-group2/pull/13)

### Team
- **Developer**: Nadvik K M
- **Mentor**: Springboard Mentor
- **Organization**: Infosys Internship Program

---

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Infosys Internship Program
- Springboard Mentorship
- Open-source community (Flutter, Flask, Pandas)

---

## 📈 Statistics

- **Total Lines of Code**: 2000+
- **Backend Modules**: 6
- **API Endpoints**: 8+
- **Flutter Screens**: 3
- **Test Cases**: 5
- **Datasets**: 5+
- **Notebooks**: 8

---

## ✅ Verification Checklist

Before deployment, ensure:
- [ ] All tests pass: `python test_cases.py` ✅
- [ ] Backend runs: `python car_loan_backend/main.py` ✅
- [ ] Flutter builds: `flutter run` ✅
- [ ] API endpoints tested
- [ ] Login credentials working (Nadvik / 1234) ✅
- [ ] File uploads functional
- [ ] Negotiation advice working
- [ ] Phishing detection active

---

**Last Updated**: January 21, 2026  
**Version**: 1.0.0  
**Status**: ✅ Production Ready

---

*Made with ❤️ for car lease customers everywhere*

---

## 🧩 Milestones

| Milestone | Description | Week |
|----------|-------------|------|
| M1 | Contract data extraction & cleaning | Week 2 |
| M2 | NLP + Risk Detection | Week 4 |
| M3 | Negotiation Suggestions + UI | Week 6 |
| M4 | Final Integration + Demo | Week 8 |

---

## 🤝 Collaboration Rules

Each intern must:
✔ Work only in **your own branch**  
✔ Commit code regularly with meaningful messages  
✔ Push updates before sessions  
✔ Avoid pushing to main or editing others’ branches  

---

## 📜 License
MIT License © 2025 Infosys Internship  
Mentor: **Suresh Kumar Pantla**
