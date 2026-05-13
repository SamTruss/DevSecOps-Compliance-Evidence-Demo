"""
Intentionally Vulnerable Flask Application
===========================================
DO NOT DEPLOY THIS APPLICATION. It exists solely to generate realistic
findings from security scanning tools (Bandit, Gitleaks, Safety, Trivy).

Each vulnerability is annotated with the scanner that should detect it
and the corresponding CWE/control mapping.
"""

import os
import sqlite3
import hashlib
import subprocess

from flask import Flask, request, jsonify, redirect

app = Flask(__name__)

# ┌──────────────────────────────────────────────────────────────────┐
# │ VULN 1: Hardcoded credentials                                   │
# │ Detected by: Gitleaks, Bandit (B105)                            │
# │ CWE: CWE-798 (Use of Hard-coded Credentials)                   │
# │ Control: SOC 2 CC6.1, ISO A.8.15                                │
# └──────────────────────────────────────────────────────────────────┘
DATABASE_PASSWORD = "SuperSecret123!"
API_KEY = "sk-demo-a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6"
AWS_SECRET_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"


# ┌──────────────────────────────────────────────────────────────────┐
# │ VULN 2: SQL injection                                           │
# │ Detected by: Bandit (B608)                                      │
# │ CWE: CWE-89 (SQL Injection)                                     │
# │ Control: SOC 2 CC8.1, ISO A.8.28                                │
# └──────────────────────────────────────────────────────────────────┘
def get_user(username):
    """Fetch user by username — vulnerable to SQL injection."""
    conn = sqlite3.connect(":memory:")
    cursor = conn.cursor()
    # Intentional: string formatting in SQL query
    query = "SELECT * FROM users WHERE username = '%s'" % username
    cursor.execute(query)
    return cursor.fetchone()


# ┌──────────────────────────────────────────────────────────────────┐
# │ VULN 3: Command injection                                       │
# │ Detected by: Bandit (B602, B605)                                │
# │ CWE: CWE-78 (OS Command Injection)                              │
# │ Control: SOC 2 CC8.1, ISO A.8.28                                │
# └──────────────────────────────────────────────────────────────────┘
@app.route("/ping")
def ping():
    """Ping a host — vulnerable to command injection."""
    host = request.args.get("host", "127.0.0.1")
    # Intentional: unsanitised user input in shell command
    result = subprocess.check_output("ping -c 1 " + host, shell=True)
    return result.decode()


# ┌──────────────────────────────────────────────────────────────────┐
# │ VULN 4: Weak hashing algorithm                                  │
# │ Detected by: Bandit (B303)                                      │
# │ CWE: CWE-328 (Use of Weak Hash)                                 │
# │ Control: ISO A.8.24                                              │
# └──────────────────────────────────────────────────────────────────┘
def hash_password(password):
    """Hash a password using MD5 — intentionally weak."""
    return hashlib.md5(password.encode()).hexdigest()


# ┌──────────────────────────────────────────────────────────────────┐
# │ VULN 5: Debug mode enabled                                      │
# │ Detected by: Bandit (B201)                                      │
# │ CWE: CWE-215 (Insertion of Sensitive Information Into Debug)     │
# │ Control: SOC 2 CC7.2, Cyber Essentials Secure Configuration     │
# └──────────────────────────────────────────────────────────────────┘
@app.route("/")
def index():
    return jsonify({
        "status": "running",
        "message": "DevSecOps Compliance Evidence Demo",
        "warning": "This application is intentionally vulnerable. Do not deploy."
    })


@app.route("/user")
def user_lookup():
    """User lookup endpoint — demonstrates SQL injection sink."""
    username = request.args.get("username", "")
    if not username:
        return jsonify({"error": "username parameter required"}), 400
    user = get_user(username)
    return jsonify({"user": user})


@app.route("/hash")
def hash_endpoint():
    """Password hashing endpoint — demonstrates weak hash."""
    password = request.args.get("password", "")
    if not password:
        return jsonify({"error": "password parameter required"}), 400
    hashed = hash_password(password)
    return jsonify({"hash": hashed, "algorithm": "md5"})


# ┌──────────────────────────────────────────────────────────────────┐
# │ VULN 6: Open redirect                                           │
# │ Detected by: Manual review / DAST (if added later)              │
# │ CWE: CWE-601 (URL Redirection to Untrusted Site)                │
# │ Control: SOC 2 CC8.1                                             │
# └──────────────────────────────────────────────────────────────────┘
@app.route("/redirect")
def open_redirect():
    """Open redirect — vulnerable to phishing via URL parameter."""
    url = request.args.get("url", "/")
    return redirect(url)


if __name__ == "__main__":
    # Intentional: debug=True exposes debugger in production
    app.run(host="0.0.0.0", port=5000, debug=True)
