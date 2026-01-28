import openai
import json
import os

openai.api_key = os.getenv("OPENAI_API_KEY")

def extract_sla_with_llm(contract_text):
    prompt = f"""
You are a contract analysis assistant.

Extract the following SLA details from the contract text:
- APR
- Loan term in months
- Monthly payment amount
- Penalty clauses (early termination, late fee)

Return ONLY valid JSON in this format:
{{
  "apr": "",
  "term_months": "",
  "monthly_payment": "",
  "penalties": ""
}}

Contract Text:
{contract_text}
"""

    response = openai.ChatCompletion.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}],
        temperature=0
    )

    return json.loads(response.choices[0].message.content)