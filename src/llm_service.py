import os
import json
import anthropic

client = anthropic.Anthropic(
    api_key=os.getenv("ANTHROPIC_API_KEY")
)

def extract_sla_with_llm(contract_text: str):
    prompt = f"""
You are a contract analysis assistant.

Extract the following SLA details from the contract text:
- APR
- Loan term in months
- Monthly payment amount
- Penalty clauses (late fee, early termination)

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

    message = client.messages.create(
        model="claude-3-haiku-20240307",
        max_tokens=500,
        temperature=0,
        messages=[
            {"role": "user", "content": prompt}
        ]
    )
    return json.loads(message.content[0].text)