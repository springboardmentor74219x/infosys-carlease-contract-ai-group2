# AI-Powered Car Lease & Loan Contract Review and Negotiation Assistant  
### Turn Complex Contracts into Smart Decisions

Buying a car often becomes stressful because lease and loan contracts are
filled with legal and financial jargon that is difficult for normal users
to understand.

This project builds an **AI-powered assistant** that can read, analyze,
and help users review car lease or loan contracts — acting like a smart
financial advisor.

The system extracts key information from contracts, highlights important
clauses, and prepares the foundation for AI-based risk detection and
negotiation assistance.

---

## 🎯 Project Vision

To help users understand car loan and lease contracts **without requiring
legal or financial expertise** by using Artificial Intelligence.

This system enables users to:

- Understand what is written inside their contract  
- Extract key financial and legal terms  
- Detect risky or unfavorable clauses (planned)  
- Receive AI-assisted negotiation guidance (planned)  

Our goal is to **convert complex legal documents into simple,
actionable insights**.

---

## 🧩 Core Functionalities

### 🔍 1. Contract Understanding (Milestone-1)
- Accepts car lease/loan contract PDFs
- Uploads and stores documents securely
- Extracts raw text using OCR
- Stores extracted text for further analysis

### ⚠️ 2. Risk Detection (Upcoming)
- Identify high interest rates
- Detect penalty clauses and hidden fees
- Highlight unfavorable contract conditions

### 💸 3. Market Fairness Analysis (Upcoming)
- Compare contract price with market datasets
- Estimate fair vehicle pricing
- Generate fairness indicators

### 🤖 4. AI Negotiation Assistant (Upcoming)
- Suggest negotiation strategies
- Recommend reductions in APR or fees
- Generate ready-to-use negotiation statements

---

## 🏢 Internship Information

- **Platform:** Infosys Springboard Internship  
- **Project Title:** AI-LLM Based Car Lease / Loan Contract Review & Negotiation Assistant  
- **Mentor:** Suresh Kumar Pantla  
- **Duration:** 8 Weeks  
- **Team:** Group 2  
- **Mode:** Online  

---

## 🛠 Technology Stack

| Category | Tools |
|--------|------|
| Programming | Python |
| Backend | Flask |
| OCR | Tesseract OCR, Poppler |
| NLP / AI (Planned) | Large Language Models, LangChain |
| Data Handling | Pandas |
| UI (Planned) | Streamlit / Flutter |
| Version Control | Git & GitHub |

---

## 🧱 System Workflow

User uploads contract PDF
↓
Backend stores PDF
↓
OCR extracts text (Poppler + Tesseract)
↓
Extracted text stored for analysis
↓
AI processing (Milestone-2 onwards)


---

## 📁 Project Structure

infosys-carlease-contract-ai-group2
│
├── data/
├── src/
├── notebooks/
├── flutter_app/
│
├── README.md
└── LICENSE


---

## 🗺 Milestones

| Milestone | Description | Status |
|---------|-------------|--------|
| Week 2 | Contract upload & OCR text extraction | ✅ Completed |
| Week 4 | NLP-based SLA & risk detection | ⏳ Upcoming |
| Week 6 | Negotiation assistant & UI | ⏳ Upcoming |
| Week 8 | Final integration & demo | ⏳ Upcoming |

---

## 🏗 Architecture (Milestone-1)

1. User uploads car lease/loan contract PDF  
2. Backend stores uploaded document  
3. OCR service extracts text from PDF  
4. Extracted text is stored for later AI analysis  

### Pipeline

PDF → Upload API → OCR (Tesseract + Poppler) → Text Storage


---

## ✅ Features Implemented (Milestone-1)

- PDF upload via API
- OCR text extraction
- Secure file storage
- Backend health check endpoint
- End-to-end pipeline tested using Postman

---

## 🤝 Contribution Rules

- Work only in your **own branch**
- Use meaningful commit messages
- Do not push directly to `main`
- Update documentation with each milestone

---

## 🌟 Project Impact

This application is useful for:

- First-time car buyers  
- Non-technical users  
- Students and professionals  
- Anyone confused by loan or lease contracts  

The AI assistant acts as a **personal contract advisor**, helping users
make confident and informed decisions.

---

## 📜 License

MIT License © 2025  
Project developed under **Infosys Springboard Internship**  
Mentor: **Suresh Kumar Pantla**  
Contributor: **Thuppudu Dheeraj Kumar – Group 2 Intern**
