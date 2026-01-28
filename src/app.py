from flask import Flask, request, jsonify
from llm_service import extract_sla_with_llm
from vin_service import lookup_vin
from storage import save_sla_json

app = Flask(__name__)

@app.route("/analyze", methods=["POST"])
def analyze_contract():
    # Try to read JSON safely
    data = request.get_json(silent=True) or {}

    contract_text = data.get("contract_text", "")
    vin = data.get("vin", None)

    return jsonify({
        "status": "success",
        "message": "Analyze API working successfully",
        "received": {
            "vin": vin,
            "contract_text_present": bool(contract_text)
        },
        "text_length": len(contract_text)
    }), 200


if __name__ == "__main__":
    app.run(debug=True)
