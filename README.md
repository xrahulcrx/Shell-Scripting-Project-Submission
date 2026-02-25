# ATM Management System (Transaction.sh)

A Bash Shell based ATM Management System that simulates real-time banking operations through terminal interaction.

This project demonstrates practical implementation of:

- Functions
- Control Structures (if, case, while)
- Pattern Matching (Regex)
- Command Substitution
- String Manipulation & Substitution
- Arithmetic Operations & Expansion
- Error Handling
- User Input Validation
- Proper Terminal Interaction

---

## Script Name
Transaction.sh


Only one script file is used as per project requirement.

---
Video: https://github.com/xrahulcrx/Shell-Scripting-Project-Submission/tree/main/demo/ATM_Transaction_Shell_Script_Demo.mkv
---

## Features Implemented

### 1. Customer_Details Function
Handles:
- First Name & Last Name Validation
- ID Type Selection (Aadhar / PAN / License)
- ID Number Validation using Regex
- Account Type Selection (Savings / Current)
- Initial Deposit Validation:
  - Minimum ₹500
  - Multiples of 100 only

### 2. Customer_Choice Function
Handles:
- ATM Card Application
- Random 4-digit PIN Generation (Command Substitution)
- Access Confirmation (Okay / Cancel)

### 3. ATM_Process Function
Handles:
- 3-Attempt PIN Verification System
- Account Lock after 3 failed attempts
- ATM Transaction Menu:
  - Withdraw
  - Deposit
  - Check Balance
  - Exit

### 4. Debit_Process Function
Handles:
- Withdrawal Validation
- Zero Balance Protection
- Insufficient Balance Handling
- Multiple of 100 Enforcement
- Updated Balance Display

### 5. Credit_Process Function
Handles:
- Deposit Validation
- Multiple of 100 Enforcement
- Updated Balance Display

---

## Concepts Used

### 🔹 Command Substitution
- pin=$(shuf -i 1000-9999 -n 1)

### 🔹 String Manipulation
- accessChoice=${accessChoice,,}

### 🔹 Pattern Matching (Regex)
- [[ "$idNumber" =~ ^[0-9]{12}$ ]]

### 🔹 Arithmetic Expansion
- balance=$((balance + amount))
- balance=$((balance - amount))

### 🔹 Control Structures
- while loops
- case statements
- if conditions

### 🔹 Error Handling
- Invalid input rejection
- Incorrect PIN attempts
- Insufficient balance handling
- Zero balance withdrawal protection

---


## Security Features

- PIN hidden during input (`read -s`)
- 3-attempt lock mechanism
- Zero balance withdrawal prevention
- Strict numeric validation

---

## 🛠️ How To Run

1. Save the script as: 
```
Transaction.sh
```
2. Provide execution permission: 
```
chmod +x Transaction.sh
```
3. Run the script: 
```
./Transaction.sh
```
