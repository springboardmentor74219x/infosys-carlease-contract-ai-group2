from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
import sys
import os

# Add parent directory to path to import from src
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.negotiation_advisor import generate_negotiation_advice

app = FastAPI()

# Enable CORS for Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.post("/upload")
async def upload_contract(file: UploadFile = File(...)):
    # Dummy upload handler (Week 5 continuation)
    return {
        "message": "Upload successful",
        "filename": file.filename
    }

@app.post("/negotiate")
async def negotiate(data: dict):
    """
    Generate smart negotiation advice based on contract details.
    
    Expected input:
    {
        "apr": float,
        "term_months": int,
        "monthly_payment": float,
        "has_penalty": bool,
        "risk_flag": str ("Low", "Medium", "High")
    }
    """
    apr = data.get("apr", 10.0)
    term_months = data.get("term_months", 36)
    monthly_payment = data.get("monthly_payment", 500)
    has_penalty = data.get("has_penalty", False)
    risk_flag = data.get("risk_flag", "Medium")
    
    # Generate smart negotiation advice
    advice = generate_negotiation_advice(
        apr=apr,
        term_months=term_months,
        monthly_payment=monthly_payment,
        has_penalty=has_penalty,
        risk_flag=risk_flag
    )
    
    return {
        "success": True,
        "advice": advice,
        "contract_details": {
            "apr": apr,
            "term_months": term_months,
            "monthly_payment": monthly_payment,
            "has_penalty": has_penalty,
            "risk_flag": risk_flag
        }
    }

