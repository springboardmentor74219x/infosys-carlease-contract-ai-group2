#!/usr/bin/env python3
"""
Simple HTTP Server to serve the Car Lease Contract AI Web UI
"""
from http.server import HTTPServer, SimpleHTTPRequestHandler
import os
import sys

class MyHTTPRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        self.send_header('Expires', '0')
        super().end_headers()

if __name__ == '__main__':
    # Change to the directory containing web_ui.html
    os.chdir(r'c:\Users\user\Downloads\infosys-carlease-contract-ai-group2-B-jestavi')
    
    # Create server
    server = HTTPServer(('localhost', 5000), MyHTTPRequestHandler)
    print("=" * 60)
    print("WEB UI Server Started")
    print("=" * 60)
    print("[+] Web UI: http://localhost:5000/web_ui.html")
    print("[+] API Docs: http://localhost:8000/docs")
    print("[+] Backend: http://localhost:8000")
    print("=" * 60)
    print("Press Ctrl+C to stop the server")
    print("=" * 60)
    
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\n\nServer stopped.")
        sys.exit(0)
