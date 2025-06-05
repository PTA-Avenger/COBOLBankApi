---

### 📁 `README.md`

````markdown
# COBOL-Powered REST API: Legacy Banking Simulation

This project is a hybrid system that demonstrates how to integrate **COBOL**, a legacy programming language, with a modern **Python Flask REST API** to simulate a banking system.

> ⚙️ Built by [Thato Mabena] as part of a third-year CS portfolio project.

---

## 📌 Project Overview

- ✅ **COBOL** handles core banking transaction logic (deposit/withdrawal)
- ✅ **Python (Flask)** acts as the REST API that bridges modern web apps with legacy COBOL systems
- ✅ **File-based data storage** simulates a mainframe flat-file database

---

## 🧠 What I Learned

### 🔹 COBOL
- File I/O using `FD` and `READ/WRITE`
- Arithmetic operations and conditional logic in legacy systems
- How to structure procedural COBOL code with `PERFORM`, `SET`, and `DISPLAY`
- Importance of fixed-length record formatting for file-based systems

### 🔹 Python + Flask
- Building a REST API using `Flask`
- Sending and receiving JSON data to/from a COBOL program
- Using `subprocess` to integrate and run a compiled COBOL executable from Python
- File parsing and encoding for cross-language compatibility

### 🔹 System-Level Skills
- Managing missing DLLs (`libcob-4.dll`)
- Working with environment variables and compilers (GnuCOBOL)
- Command-line testing with `curl`

---

## 🧪 How It Works

1. User sends a transaction request via a REST endpoint
2. Flask writes the transaction details to a `transaction.dat` file
3. The `banking.exe` COBOL program is executed by Python
4. COBOL reads the file, processes the transaction, and writes output to `output.dat`
5. Flask reads the result and sends it back to the user

---

## ▶️ Run the Project

### 📂 Requirements
- Windows OS
- [OpenCobolIDE](https://open-cobol.sourceforge.io/)
- Python 3.x with Flask

### 🔧 Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/PTA-Avenger/COBOLBankAPI.git
   cd COBOLBankAPI
````

2. **Install Flask**

   ```bash
   python -m pip install flask
   ```

3. **Ensure `banking.exe` is built**

   * Open `banking.cbl` in OpenCobolIDE
   * Click **Build → Compile to Executable**

4. **Make sure `libcob-4.dll` is on PATH**

   ```cmd
   setx PATH "%PATH%;C:\OpenCobolIDE\gnucobol\bin"
   ```

5. **Run the API**

   ```bash
   python app.py
   ```

---

## 📬 Example Request

Send a transaction using `curl`:

```bash
curl -X POST http://localhost:5000/transaction ^
 -H "Content-Type: application/json" ^
 -d "{\"account_id\":\"00001\", \"type\":\"deposit\", \"amount\":250.00}"
```

Expected JSON Response:

```json
{
  "response": "Account ID: 00001 Name: John Smith New Balance: 750.00"
}
```

---

## 📄 File Structure

```plaintext
COBOLBankAPI/
│
├── app.py                # Flask REST API
├── banking.cbl           # COBOL transaction logic
├── banking.exe           # Compiled COBOL binary
├── transaction.dat       # COBOL input file
├── output.dat            # COBOL output file
├── accounts.dat          # Simulated account database
├── README.md             # This file
```

---

## 🔐 Notes

* This is a **simulation**, not a real financial system.
* Flat files simulate a legacy COBOL mainframe.
* The project demonstrates **modernization strategies** for legacy systems.

---

## 👨‍💻 Author

**Thato Mabena**
Final-Year Computer Science Student
📫 [GitHub](https://github.com/PTA-Avenger)

---

## 🏁 Future Improvements

* [ ] Add endpoint to retrieve account balance
* [ ] Update account balance in `accounts.dat`
* [ ] Add transaction history log
* [ ] Dockerize the environment

````

---

### ✅ Next Steps:

- Save this file as `README.md` in the root of your repo.
- Then push to GitHub:

```bash
git add README.md
git commit -m "Add full project README"
git push origin main
````
