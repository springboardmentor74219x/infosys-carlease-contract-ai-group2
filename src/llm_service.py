import os
import json

# Example shown with Claude-style client
# You can swap with OpenAI later without changing app.py

from anthropic import Anthropic

client = Anthropic(api_key=os.getenv("CLAUDE_API_KEY"))


def extract_sla_with_llm(contract_text: str):
    """
    Milestone 2 – Week 3
    LLM-based SLA & financial term extraction
    """

    prompt = f"""
You are a legal contract analysis assistant.

Your task is to extract financial and SLA-related terms from a vehicle finance or loan contract.

Important rules:
- The contract may NOT explicitly use words like APR or monthly payment.
- Interest rate may be described as:
  "interest", "finance charge", "annual rate", "borrowing rate".
- Default interest may be described as:
  "interest on overdue amounts", "penalty interest", "additional interest after default".
- Penalties may be described as:
  "default fees", "late payment charges", "dishonour fees", "enforcement costs".

If a value is not clearly mentioned, return:
"Not explicitly stated"

Return ONLY valid JSON in the following format:

{{
  "interest_rate": "",
  "interest_description": "",
  "default_interest": "",
  "loan_term": "",
  "monthly_payment": "",
  "penalties": "",
  "late_fees": ""
}}

Contract text:
<<<
{contract_text}
>>>
"""

    response = client.messages.create(
        model="claude-3-sonnet-20240229",
        max_tokens=500,
        temperature=0,
        messages=[
            {"role": "user", "content": prompt}
        ]
    )

    # Claude returns text, so parse safely
    try:
        return json.loads(response.content[0].text)
    except Exception:
        return {
            "error": "LLM response could not be parsed",
            "raw_response": response.content[0].text
        }