from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
import json

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
    """Upload a contract file"""
    try:
        contents = await file.read()
        return {
            "status": "success",
            "message": "Upload successful",
            "filename": file.filename,
            "size": len(contents)
        }
    except Exception as e:
        return {
            "status": "error",
            "message": str(e),
            "filename": file.filename
        }

@app.post("/negotiate")
async def negotiate(question: str = None):
    """Get negotiation advice for a contract"""
    try:
        # Return the same mock data as before, but with better structure
        return {
            "status": "success",
            "contract": {
                "customer_name": "Arjun Patel",
                "vehicle": "SUV",
                "monthly_emi": 27500,
                "interest_rate": "10.8%",
                "tenure_months": 72
            },
            "sla": {
                "risk_flag": "Medium",
                "issue_type": "High Interest Rate",
                "recommended_action": "Negotiate for a lower APR or shorter tenure"
            },
            "negotiation_advice": (
                "Based on your EMI and interest rate, you can negotiate a lower APR by "
                "highlighting your stable income, credit score, and comparing offers "
                "from other lenders."
            )
        }
    except Exception as e:
        return {
            "status": "error",
            "message": str(e)
        }

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "service": "Smart Contract Negotiator API",
        "version": "1.0.0"
    }

if __name__ == "__main__":
    import uvicorn
    print("Starting API on http://localhost:8000")
    uvicorn.run(app, host="127.0.0.1", port=8000, log_level="info")
