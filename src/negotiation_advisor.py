"""
Smart Negotiation Advice Generator
Based on Contract Quality Metrics
"""

def generate_negotiation_advice(apr, term_months, monthly_payment, has_penalty, risk_flag):
    """
    Generate negotiation advice based on contract details.
    
    Args:
        apr: Annual Percentage Rate (float)
        term_months: Lease term in months (int)
        monthly_payment: Monthly payment amount (float)
        has_penalty: Whether penalty clauses exist (bool)
        risk_flag: Risk level - "Low", "Medium", "High" (str)
    
    Returns:
        dict with 'score', 'category', 'advice', 'focus_areas', 'tips'
    """
    
    # Calculate quality score (0-100)
    quality_score = calculate_quality_score(apr, term_months, monthly_payment, has_penalty, risk_flag)
    
    if quality_score >= 80:
        return get_good_contract_advice(apr, term_months, monthly_payment)
    elif quality_score >= 60:
        return get_moderate_contract_advice(apr, term_months, monthly_payment, has_penalty)
    else:
        return get_bad_contract_advice(apr, term_months, monthly_payment, has_penalty, risk_flag)


def calculate_quality_score(apr, term_months, monthly_payment, has_penalty, risk_flag):
    """
    Calculate contract quality score (0-100).
    Lower APR = Better
    Longer term = Potentially better (lower monthly)
    Lower monthly payment = Better
    No penalties = Better
    Low risk = Better
    """
    score = 100
    
    # APR scoring (0-30 points)
    # Excellent: < 4%, Good: 4-6%, Fair: 6-10%, Poor: > 10%
    if apr < 4:
        apr_score = 30
    elif apr < 6:
        apr_score = 25
    elif apr < 10:
        apr_score = 18
    elif apr < 13:
        apr_score = 10
    else:
        apr_score = 5
    score -= (30 - apr_score)
    
    # Term scoring (0-20 points) - longer terms help with affordability
    if term_months >= 60:
        term_score = 20
    elif term_months >= 48:
        term_score = 18
    elif term_months >= 36:
        term_score = 15
    elif term_months >= 24:
        term_score = 12
    else:
        term_score = 8
    score -= (20 - term_score)
    
    # Monthly payment scoring (0-20 points)
    if monthly_payment < 400:
        payment_score = 20
    elif monthly_payment < 700:
        payment_score = 16
    elif monthly_payment < 1000:
        payment_score = 12
    elif monthly_payment < 1200:
        payment_score = 8
    else:
        payment_score = 4
    score -= (20 - payment_score)
    
    # Penalty clause scoring (0-15 points)
    penalty_score = 0 if has_penalty else 15
    score -= (15 - penalty_score)
    
    # Risk flag scoring (0-15 points)
    if risk_flag == "Low":
        risk_score = 15
    elif risk_flag == "Medium":
        risk_score = 8
    else:  # High
        risk_score = 2
    score -= (15 - risk_score)
    
    return max(0, min(100, score))


def get_good_contract_advice(apr, term_months, monthly_payment):
    """Advice for good contracts (quality score >= 80)"""
    return {
        "score": "EXCELLENT",
        "category": "Well-Structured Contract",
        "overall_assessment": f"You have secured a favorable lease agreement with an APR of {apr}% and a monthly payment of ${monthly_payment}. This is a strong position for you as the lessee.",
        "main_advice": f"""
Your contract terms are quite favorable:
• APR Rate: {apr}% - Below market average (excellent)
• Lease Term: {term_months} months - Balanced term length
• Monthly Payment: ${monthly_payment} - Competitive rate
• No harsh penalties detected

MAINTAIN YOUR POSITION:
Since you have a good contract, focus on protecting these favorable terms rather than renegotiating.
""",
        "focus_areas": [
            {
                "title": "Protect Your Terms",
                "description": "Ensure all agreed terms are clearly documented. Get copies of all signed documents.",
                "action": "Request a final contract summary with all terms clearly stated."
            },
            {
                "title": "Understand Payment Schedule",
                "description": "Your monthly payment is reasonable. Verify the payment dates and method.",
                "action": "Confirm automatic payment setup if preferred, or set up manual reminders."
            },
            {
                "title": "Mileage & Maintenance",
                "description": "Review mileage allowance and maintenance responsibilities carefully.",
                "action": "Ask about mileage allowance (typically 10k-15k miles/year) and wear-and-tear policy."
            },
            {
                "title": "Future Flexibility",
                "description": "With good terms, focus on flexibility options.",
                "action": "Ask about early termination options and any associated fees if your circumstances change."
            }
        ],
        "tips": [
            "✓ Your APR is competitive - don't let dealer convince you to change it",
            "✓ Keep excellent payment history to build credit and get better rates on future contracts",
            "✓ Document all communications with the leasing company",
            "✓ Maintain the vehicle well to avoid excess wear-and-tear charges",
            "✓ Track your mileage to stay within allowance limits"
        ]
    }


def get_moderate_contract_advice(apr, term_months, monthly_payment, has_penalty):
    """Advice for moderate contracts (quality score 60-79)"""
    return {
        "score": "FAIR",
        "category": "Room for Negotiation",
        "overall_assessment": f"Your contract has mixed terms. While some aspects are acceptable, there are opportunities to improve your position with the lender or dealer.",
        "main_advice": f"""
Your contract shows room for improvement:
• APR Rate: {apr}% - Mid-range, negotiable
• Lease Term: {term_months} months - Acceptable
• Monthly Payment: ${monthly_payment} - Could be optimized
• Penalty Clauses: {'Present - Focus here' if has_penalty else 'Not detected'}

NEGOTIATION STRATEGY:
You have leverage to request better terms. The lender would prefer to keep your business rather than lose you.
""",
        "focus_areas": [
            {
                "title": "APR Negotiation",
                "description": f"Your APR of {apr}% can likely be reduced to {max(2, apr - 1.5)}-{max(2.5, apr - 1)}%",
                "action": "Present your credit score and ask if the lender can offer a lower rate. Request quotes from competing dealers."
            },
            {
                "title": "Remove or Modify Penalties",
                "description": "If penalty clauses exist, negotiate to remove or reduce them.",
                "action": "Ask about waiving early termination fees or reducing late payment penalties."
            },
            {
                "title": "Monthly Payment Adjustment",
                "description": f"Request to reduce monthly payment by extending term from {term_months} to {term_months + 12} months.",
                "action": "Recalculate total lease cost with extended term to see total impact."
            },
            {
                "title": "Insurance & Maintenance",
                "description": "Negotiate what costs are covered (insurance, maintenance, repairs).",
                "action": "Ask if maintenance package can be included or bundled for better value."
            }
        ],
        "tips": [
            "✓ Get written quotes from at least 2 other dealers for comparison",
            "✓ Highlight your creditworthiness and payment history during negotiations",
            "✓ Ask for bundle deals (insurance + maintenance) to reduce overall cost",
            "✓ Negotiate each component separately: APR, term, penalties",
            "✓ Don't accept the first offer - ask for manager to review your request"
        ]
    }


def get_bad_contract_advice(apr, term_months, monthly_payment, has_penalty, risk_flag):
    """Advice for bad contracts (quality score < 60)"""
    return {
        "score": "UNFAVORABLE",
        "category": "Significant Renegotiation Needed",
        "overall_assessment": f"Your contract contains several unfavorable terms. Immediate action is recommended to negotiate better conditions before finalizing.",
        "main_advice": f"""
⚠️ ALERT: Your contract has concerning terms:
• APR Rate: {apr}% - ABOVE market average (HIGH)
• Lease Term: {term_months} months
• Monthly Payment: ${monthly_payment} - EXPENSIVE
• Penalty Clauses: {'PRESENT & RESTRICTIVE' if has_penalty else 'Detected'}
• Risk Level: {risk_flag}

URGENT ACTION REQUIRED:
This contract may cost you $5,000-$15,000 more than necessary. Do NOT sign until renegotiated.
""",
        "focus_areas": [
            {
                "title": "Negotiate APR Reduction",
                "description": f"Your APR of {apr}% is significantly high. Target rate: {max(2, apr - 3)}-{max(3, apr - 2)}%",
                "action": "Request APR reduction by 2-3%. Reference your credit score. Get competing quotes."
            },
            {
                "title": "Reduce Monthly Payment",
                "description": f"Current ${monthly_payment}/month is unsustainable. Target: ${max(200, monthly_payment - 200)}-${max(300, monthly_payment - 150)}/month",
                "action": "Extend lease term to 60+ months OR reduce vehicle price/features to lower payment."
            },
            {
                "title": "Remove Harsh Penalties",
                "description": "Contract has restrictive penalty clauses that could cost you thousands.",
                "action": "Eliminate early termination fees, reduce late payment penalties, negotiate mileage overages."
            },
            {
                "title": "Request Rate Review",
                "description": "Ask for management review of your rate based on creditworthiness.",
                "action": "Document your credit score, employment, and income. Present formal request for rate reconsideration."
            },
            {
                "title": "Consider Alternative Lenders",
                "description": f"With {risk_flag} risk classification, you may qualify for better rates elsewhere.",
                "action": "Shop with credit unions, online lenders, and competing dealers before accepting this deal."
            }
        ],
        "tips": [
            "⚠️ DO NOT SIGN - This contract will cost you significantly more",
            "✓ Request a 48-hour review period before committing",
            "✓ Get 3+ competing quotes from different lenders/dealers",
            "✓ Bring in a trusted advisor or family member to review terms",
            "✓ Ask specifically: 'Can you reduce the APR to [X%]?' Make it a direct negotiation",
            "✓ Walk away if dealer refuses to negotiate - there are better deals available",
            f"✓ Estimated savings potential: ${(apr - 3) * monthly_payment * term_months / 12 / 100:.0f} or more"
        ]
    }
