from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/transaction', methods=['POST'])
def process_transaction():
    data = request.json

    acc_id = data.get("account_id", "").ljust(5)
    trx_type = data.get("type", "").upper().ljust(10)
    amount = "{:09.2f}".format(float(data.get("amount", 0)))

    # Step 1: Write transaction.dat
    with open("transaction.dat", "w") as f:
        f.write(f"{acc_id}{trx_type}{amount}\n")

    # Step 2: Run COBOL executable
    result = subprocess.run(["./banking.exe"], capture_output=True)

    # Step 3: Read output.dat
    try:
        with open("output.dat", "r") as f:
            response = f.read().strip()
    except FileNotFoundError:
        response = "COBOL program failed."

    return jsonify({"response": response})

if __name__ == '__main__':
    app.run(debug=True)
