from flask import Flask, request, jsonify
from llm_service import extract_sla_with_llm
from vin_service import lookup_vin
from storage import save_sla_json

app = Flask(__name__)

@app.route("/analyze", methods=["POST"])
def analyze_contract():
    data = request.json

    contract_id = data["contract_id"]
    contract_text = data["contract_text"]
    vin = data["vin"]

    sla_data = extract_sla_with_llm(contract_text)
    sla_path = save_sla_json(contract_id, sla_data)

    vehicle_data = lookup_vin(vin)

    return jsonify({
        "contract_id": contract_id,
        "sla_data": sla_data,
        "vehicle_data": vehicle_data,
        "sla_file": sla_path
    })

if __name__ == "__main__":
    app.run(debug=True)