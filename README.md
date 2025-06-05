# COBOLBankAPI: COBOL-Powered REST API for Legacy Banking Simulation

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Python Version](https://img.shields.io/badge/python-3.x-blue)
![License](https://img.shields.io/badge/license-MIT-green)

A hybrid system that demonstrates integrating **COBOL**—a legacy language—with a modern **Python Flask REST API** to simulate a banking system.  
> ⚙️ Portfolio project by [Thato Mabena](https://github.com/PTA-Avenger).

---

## 📚 Table of Contents

- [Project Overview](#-project-overview)
- [Quick Start](#-quick-start)
- [What I Learned](#-what-i-learned)
- [How It Works](#-how-it-works)
- [Requirements](#-requirements)
- [Setup & Running](#-setup--running)
- [Example Request](#-example-request)
- [File Structure](#-file-structure)
- [Notes](#-notes)
- [Future Improvements](#-future-improvements)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

---

## 📌 Project Overview

- **COBOL** handles core banking transaction logic (deposit/withdrawal)
- **Python (Flask)** provides the REST API, bridging modern web apps and COBOL
- **File-based data storage** simulates a mainframe flat-file database

---

## 🚀 Quick Start

1. Clone the repo:  
   `git clone https://github.com/PTA-Avenger/COBOLBankAPI.git && cd COBOLBankAPI`
2. Install dependencies:  
   `python -m pip install flask`
3. Build `banking.exe` from `banking.cbl` using OpenCobolIDE.
4. Ensure `libcob-4.dll` is on PATH.
5. Run the API:  
   `python app.py`

---

## 🧠 What I Learned

### COBOL
- File I/O with `FD`, `READ/WRITE`
- Arithmetic and conditional logic in legacy code
- Procedural structure with `PERFORM`, `SET`, `DISPLAY`
- Fixed-length record formatting for flat files

### Python + Flask
- REST API construction with Flask
- JSON <-> COBOL data interchange
- Integrating COBOL executables via `subprocess`
- File parsing and encoding across languages

### System-Level
- Handling missing DLLs (`libcob-4.dll`)
- Working with environment variables and GnuCOBOL
- Command-line testing using `curl`

---

## 🛠 How It Works

```mermaid
graph TD;
    UserRequest --> FlaskAPI;
    FlaskAPI --> TransactionFile;
    TransactionFile --> COBOLProgram;
    COBOLProgram --> OutputFile;
    OutputFile --> FlaskAPI;
    FlaskAPI --> UserResponse;
