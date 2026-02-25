# !/bin/bash

echo "==================================="
echo "      ATM Management System"
echo "==================================="


# Initialize global variables
balance=0
pin=""
fullName=""
accType=""



# Customer_Details Function
Customer_Details(){
    
    echo ""
    echo "--------Account Creation--------"
    echo "  Creation of Account for User  "


    # First name
    getValidName "Enter the First Name : " fname

    # Last name
    getValidName "Enter the Last Name  : " lname

    fullName="$fname $lname"

    echo "-------------------------------"
    echo "      Welcome $fullName        "
    echo "-------------------------------"



    # ID Type Selection (Control Structures)
    echo ""
    echo "User Verification"
    while true
    do
        echo ""
        echo "Select ID Proof Type:"
        echo "1) Aadhar"
        echo "2) PAN"
        echo "3) License"

        read -p "Enter the choice (1-3 or name) : " idchoice

        case "$idchoice" in

            1|Aadhar|aadhar)
                idType="Aadhar"
                break
                ;;
            2|PAN|pan)
                idType="PAN"
                break
                ;;
            3|License|license)
                idType="License"
                break
                ;;
            *)
                echo "Invalid Selection try again.."
                ;;
        esac
    done


    # ID Number Validation (Pattern Matching & String Substitution)
    while true
    do
        read -p "Enter the $idType number for verfication : " idNumber
        [[ "${idType}" != "Aadhar" ]] && idNumber=$(echo "$idNumber" | tr 'a-z' 'A-Z')
        case "$idType" in
            Aadhar)
                if [[ "$idNumber" =~ ^[0-9]{12}$ ]];then
                    break
                else
                    echo "Aadhar must be exactly 12 digits." >&2
                fi
                ;;
            PAN)
                if [[ "$idNumber" =~ ^[A-Z]{5}[0-9]{4}[A-Z]{1}$ ]];then
                    break
                else
                    echo "PAN must be in format: ABCDE1234F " >&2
                fi
                ;;
            License)
                if [[ "$idNumber" =~ ^[A-Z]{2}[0-9]{2}[A-Z0-9]{11}$ ]];then
                    break
                else
                    echo "License must be 15 alphanumeric characters (e.g. TN01**). " >&2
                fi
                ;;
        esac
    done

    

    # Account Type Selection (Control Structures)
    echo ""
    echo "Account Type Selection"
    while true
    do
        echo "Select Account Type"
        echo "1) Savings"
        echo "2) Current"

        read -p "Enter the choice (1-2 or name) : " idchoice

        case "$idchoice" in
            1|Savings|savings)
                accType="Savings"
                break
                ;;
            2|Current|current)
                accType="Current"
                break
                ;;
            *)
                echo "Inavlid choice. Try again.."
                ;;
        esac
    done


    # Initial Deposit (Arithmetic Operation & Expansion)
    echo "=========================================="
    echo "Initial Money Deposit for Account Creation"
    echo "=========================================="
    while true
    do
        read -p "Enter Initial Deposit Amount (Minimum 500, multiples of 100) : " deposit

        #check number only
        if [[ ! "$deposit" =~ ^[0-9]+$ ]];then
            echo "Amount must contain digits only." >&2
            continue
        fi

        # Minimum 500 check
        if (( deposit < 500 ));then
            echo "Minimum deposit amount is 500." >&2
            continue
        fi

        # Must be multiple of 100
        if (( deposit % 100 != 0 )); then
            echo "Amount must be in multiples of 100." >&2
            continue
        fi

        break
    done


    balance=$deposit
    echo "Initial Deposit Successful."
    echo "---------------------------"


    echo "$fullName has created $accType Account"
    echo "Your current available balance is Rs.$balance"

    # Project Mapping: Redirect to Customer_Choice after account creation
    Customer_Choice 
}


# verify letters for the names entered
getValidName() {
    local prompt="$1"
    local resultvar="$2"
    local value

    while true
    do
        read -p "$prompt" value

        if [[ -n "$value" && "$value" =~ ^[A-Za-z]+$ ]]; then
            eval $resultvar="'$value'"
            return
        else
            echo "Enter valid input (letters only, no spaces)" >&2
        fi
    done    

}



#application for ATM Card and PIN generation
Customer_Choice() {

    echo ""
    echo "Apply ATM Card"

    while true
    do
        read -p "Do you want apply for ATM Card. Type [Yes/No] or [Y/N] : " atmChoice
        
        case "$atmChoice" in
            Yes|yes|Y|y)
                echo "Your ATM card is processed Successfully."
                pin=$(shuf -i 1000-9999 -n 1)
                echo "-----------------------------------------------------"
                echo "Your Temporaray ATM PIN has been Generated. PIN: $pin"
                echo "-----------------------------------------------------"

                # Prompt for ATM access
                while true
                do
                    echo "=========ATM Tranactions Access========="
                    read -p "Do you want to access ATM for transactions [Okay/Cancel]: " accessChoice

                    accessChoice=${accessChoice,,}   #convert to lowercase
                    case "$accessChoice" in
                        okey|ok|yes)
                            #Redirect to ATM_Process if user selects 'Okay'
                            ATM_Process #involve fallback method for incrrect attempts
                            return
                            ;;
                        cancel|no)
                            echo "Thank you!! Visit Again.."
                            return
                            ;;
                        *)
                            echo "Invalid Choice. Try again.."
                            ;;
                    esac
                done
                ;;

            No|no|N|n)
                echo "ATM card not applied."
                echo "Thanks for being valuable customer $fullName"
                return
                ;;
            *)
                echo "Invalid choice. Try again"
                ;;
        esac
    done
    
}



#involve fallback method for incrrect attempts
ATM_Process() {

    attempts=0
    maxAttempts=3

    while (( attempts < maxAttempts ))
    do
        read -s -p "Enter the 4-digit PIN : " getpin
        echo

        # Validate format
        if [[ ! "$getpin" =~ ^[0-9]{4}$ ]]; then
            echo "PIN must be exactly 4 digits."
            continue
        fi

        if [[ "$getpin" == "$pin" ]]; then
            echo "Access Granted"
            echo "Welcome $fullName"
            break
        else
            ((attempts++))
            remaining=$((maxAttempts - attempts))
            echo "Invalid PIN. Attempts left: $remaining"
        fi
    done


    if (( attempts == maxAttempts )); then
        echo "Account Locked due to 3 incorrect PIN attempts."
        exit 1
    fi

    #atm menu with check balance, deposit, withdraw and exit
    while true
    do
        echo ""
        echo "========== ATM MENU =========="
        echo "1) Withdraw Money"
        echo "2) Deposit Money"
        echo "3) Check Balance"
        echo "4) Exit"
        echo "=============================="

        read -p "Select option (1-4): " option

        case "$option" in

            1) Debit_Process ;;
            2) Credit_Process ;;
            3) echo "Current Balance: Rs.$balance" ;;
            4) echo "Thank you for banking with us!"; break ;;
            *) echo "Invalid choice. Try again." ;;
        esac
    done



}



# credit amount in user account function logic
Credit_Process() {

    echo ""
    echo "========== CASH DEPOSIT =========="
    echo ""

    while true
    do
        read -p "Enter deposit amount (multiples of 100): " amount

        if [[ ! "$amount" =~ ^[0-9]+$ ]]; then
            echo "Amount must contain digits only."
            continue
        fi

        if (( amount % 100 != 0 )); then
            echo "Amount must be in multiples of 100."
            continue
        fi

        if (( amount <= 0 )); then
            echo "Credit amount must be greater than 0."
            continue
        fi

        balance=$((balance + amount))
        echo "Deposit Successful"
        echo "Updated Balance: Rs.$balance"
        break
    done
}


# debit amount in user account function logic
Debit_Process() {

    echo ""
    echo "========== CASH WITHDRAWAL =========="
    echo ""


    # Block withdrawal if balance is zero
    if (( balance == 0 )); then
        echo "Withdrawal not allowed. Your account balance is zero."
        return
    fi

    while true
    do
        read -p "Enter withdrawal amount (multiples of 100): " amount

        if [[ ! "$amount" =~ ^[0-9]+$ ]]; then
            echo "Amount must contain digits only."
            continue
        fi

        if (( amount % 100 != 0 )); then
            echo "Amount must be in multiples of 100."
            continue
        fi

        if (( amount <= 0 )); then
            echo "Debit amount must be greater than 0."
            continue
        fi

        if (( amount > balance )); then
            echo "Insufficient Balance!"
            continue
        fi

        balance=$((balance - amount))
        echo "Withdrawal Successful"
        echo "Remaining Balance: Rs.$balance"
        break
    done
}



# To run the first process for ATM
Customer_Details