# SLA Fields to Extract (Milestone-1)
The following contract fields are required for analysis:
1. APR (Annual Percentage Rate)
2. Loan / Lease Term (in months)
3. Monthly Payment Amount
4. Penalty Clauses:
- Late payment fee
- Early termination fee
These fields will be extracted as plain text in Milestone-1.
Structured parsing will be done in Milestone-2.
Update README as like below:
## Architecture (Milestone 1)
1. User uploads car lease/loan contract PDF
2. Backend stores uploaded PDF
3. OCR service extracts text from PDF
4. Extracted plain text is stored for later analysis
Pipeline:
PDF → Upload API → OCR (Tesseract) → Text Storage