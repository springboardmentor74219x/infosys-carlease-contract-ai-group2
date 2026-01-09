from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware

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
    return {
        "message": "Upload successful",
        "filename": file.filename
    }

@app.post("/negotiate")
async def negotiate(data: dict):
    question = data.get("question", "")
    reply = (
        "You can negotiate a lower APR by highlighting your credit score "
        "and asking for better terms."
    )
    return {"reply": reply}
