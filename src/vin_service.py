import requests

def lookup_vin(vin):
    url = f"https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVin/{vin}?format=json"
    response = requests.get(url)
    results = response.json()["Results"]

    vehicle_data = {}
    for item in results:
        if item["Variable"] in ["Make", "Model", "Model Year"]:
            vehicle_data[item["Variable"]] = item["Value"]

    return vehicle_data