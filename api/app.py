import os
from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

@app.route('/transaction', methods=['POST'])
def process_transaction():
    data = request.json

    acc_id = data.get("account_id", "").ljust(5)
    trx_type = data.get("type", "").upper().ljust(10)
    amount = "{:09.2f}".format(float(data.get("amount", 0)))

    # Step 1: Write transaction.dat
    trx_file_path = os.path.join(BASE_DIR, "transaction.dat")
    with open(trx_file_path, "w") as f:
        f.write(f"{acc_id}{trx_type}{amount}\n")

    # Step 2: Run COBOL program in same directory
    exe_path = os.path.join(BASE_DIR, "banking.exe")
    result = subprocess.run([exe_path], capture_output=True)

    # Step 3: Read output.dat
    output_path = os.path.join(BASE_DIR, "output.dat")
    try:
        with open(output_path, "r") as f:
            response = f.read().strip()
    except FileNotFoundError:
        response = "COBOL program failed or didn't write output."

    return jsonify({"response": response})

if __name__ == '__main__':
    app.run(debug=True)
