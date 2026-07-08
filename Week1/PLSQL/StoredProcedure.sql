-- Create Tables Customers and Employees
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(50),
    Age NUMBER,
    Balance NUMBER,
    AccountType VARCHAR2(20),
    IsVIP VARCHAR2(5)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    EmployeeName VARCHAR2(50),
    Department VARCHAR2(30),
    Salary NUMBER
);

-- Insert data
INSERT INTO Customers VALUES (1, 'Ishant', 65, 12000, 'Savings', 'FALSE');
INSERT INTO Customers VALUES (2, 'Ayush', 45, 8000, 'Current', 'FALSE');
INSERT INTO Customers VALUES (3, 'Krishna', 40, 65000, 'Savings', 'FALSE');

INSERT INTO Employees VALUES (501, 'Rahul', 'IT', 60000);
INSERT INTO Employees VALUES (502, 'Priya', 'HR', 45000);
INSERT INTO Employees VALUES (503, 'Amit', 'IT', 75000);

COMMIT;

-- Show Initial Data
SELECT * FROM Customers;
SELECT * FROM Employees;

-- Scenario 1:
-- Applies a 1% interest rate top-up to all 'Savings' accounts.
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE Customers
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Monthly interest processed successfully for all savings accounts.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in ProcessMonthlyInterest: ' || SQLERRM);
END;
/

-- Scenario 2:
-- Increases salary for all employees in a specific department by a dynamic bonus percentage.
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_Department IN VARCHAR2,
    p_BonusPercentage IN NUMBER
) IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * (p_BonusPercentage / 100))
    WHERE Department = p_Department;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bonus of ' || p_BonusPercentage || '% applied to the ' || p_Department || ' department.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in UpdateEmployeeBonus: ' || SQLERRM);
END;
/

-- Scenario 3:
-- Moves funds between source and destination IDs if sufficient balance exists.
CREATE OR REPLACE PROCEDURE TransferFunds (
    p_SourceAccountID IN NUMBER,
    p_DestAccountID IN NUMBER,
    p_Amount IN NUMBER
) IS
    v_CurrentBalance NUMBER;
BEGIN
    SELECT Balance INTO v_CurrentBalance
    FROM Customers
    WHERE CustomerID = p_SourceAccountID;

    IF v_CurrentBalance < p_Amount THEN
        DBMS_OUTPUT.PUT_LINE('Transaction Aborted: Insufficient funds in Account ' || p_SourceAccountID);
        RETURN;
    END IF;

    UPDATE Customers
    SET Balance = Balance - p_Amount
    WHERE CustomerID = p_SourceAccountID;

    UPDATE Customers
    SET Balance = Balance + p_Amount
    WHERE CustomerID = p_DestAccountID;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Successfully transferred $' || p_Amount || ' from Account ' || p_SourceAccountID || ' to Account ' || p_DestAccountID);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Failed: One or both Account IDs do not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error in TransferFunds: ' || SQLERRM);
END;
/