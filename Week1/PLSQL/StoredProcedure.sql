-- Create Accounts Table
CREATE TABLE Customers (
    AccountrID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(50),
    AccountType VARCHAR2(20),
    Balance NUMBER
);

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(50),
    Department VARCHAR2(30),
    Salary NUMBER
);

-- Insert Sample Data
INSERT INTO Customers VALUES (101, 'Ishant Sharma', 'SAVINGS', 10000);
INSERT INTO Customers VALUES (102, 'Shivam Patel', 'SAVINGS', 20000);
INSERT INTO Customers VALUES (103, 'Amit Gupta', 'CURRENT', 15000);

INSERT INTO Employees VALUES (1, 'Rohit Sharma', 'IT', 50000);
INSERT INTO Employees VALUES (2, 'Neha Dhupia', 'HR', 45000);
INSERT INTO Employees VALUES (3, 'Aman Kumar', 'IT', 60000);

COMMIT;

-- Show Initial Data State
SELECT * FROM Customers;
SELECT * FROM Employees;

-- Scenario 1:
-- Process Monthly Interest for Savings Accounts
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
    UPDATE Customers
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'SAVINGS';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Monthly Interest Applied Successfully');
END;
/

-- Execute Procedure
BEGIN
    ProcessMonthlyInterest;
END;
/

SELECT * FROM Customers;

-- Scenario 2:
-- (Giving IT Dept a 10% Bonus)

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus
(
    p_department IN VARCHAR2,
    p_bonus      IN NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus / 100)
    WHERE Department = p_department;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Employee Bonus Updated Successfully');
END;
/

-- Execute Procedure
BEGIN
    UpdateEmployeeBonus('IT', 10);
END;
/

SELECT * FROM Employees;

-- SCENARIO 3:
-- TRANSFER FUNDS WITH BALANCE CHECK

CREATE OR REPLACE PROCEDURE TransferFunds
(
    p_from   IN NUMBER,
    p_to     IN NUMBER,
    p_amount IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance INTO v_balance
    FROM Customers
    WHERE AccountID = p_from;

    IF v_balance >= p_amount THEN
    
        UPDATE Customers
        SET Balance = Balance - p_amount
        WHERE AccountID = p_from;

        UPDATE Customers
        SET Balance = Balance + p_amount
        WHERE AccountID = p_to;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Transfer Successful');
        
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient Balance: Transfer Aborted');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: One or both Account IDs do not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Transaction failed and rolled back.');
END;
/

-- Execute Procedure
BEGIN
    TransferFunds(101, 102, 3000);
END;
/

SELECT * FROM Customers;