-- Create Customers Table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(50),
    Age NUMBER,
    Balance NUMBER,
    IsVIP VARCHAR2(5)
);

-- Create Loans Table
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER,
    DueDate DATE
);

-- Insert Sample Data with New Names
INSERT INTO Customers VALUES (1, 'Ishant', 65, 12000, 'FALSE');
INSERT INTO Customers VALUES (2, 'Ayush', 45, 8000, 'FALSE');
INSERT INTO Customers VALUES (3, 'Aditya', 70, 85000, 'FALSE');
INSERT INTO Customers VALUES (4, 'Krishna', 40, 65000, 'FALSE');

INSERT INTO Loans VALUES (101, 1, 9, SYSDATE + 10);
INSERT INTO Loans VALUES (102, 2, 10, SYSDATE + 40);
INSERT INTO Loans VALUES (103, 3, 8, SYSDATE + 30);
INSERT INTO Loans VALUES (104, 4, 11, SYSDATE + 15);

COMMIT;

-- Show Initial State of Data
SELECT * FROM Customers;
SELECT * FROM Loans;

-- Scenario 1
-- Apply 1% Discount to Customers Above 60
BEGIN
    FOR rec IN (
        SELECT c.CustomerID, c.Age, l.LoanID
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
    )
    LOOP
        IF rec.Age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = rec.LoanID;
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Scenario 1 Completed');
END;
/

SELECT * FROM Loans;

-- Scenario 2
-- Promote Customers to VIP Based on Balance
BEGIN
    FOR rec IN (SELECT CustomerID, Balance FROM Customers)
    LOOP
        IF rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = rec.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Scenario 2 Completed');
END;
/

SELECT * FROM Customers;

-- Scenario 3
-- Send Loan Due Reminders for Next 30 Days
BEGIN
    FOR rec IN (
        SELECT c.CustomerName, l.LoanID, l.DueDate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE l.DueDate BETWEEN SYSDATE AND SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder : ' || rec.CustomerName || 
            ' Loan ID : ' || rec.LoanID || 
            ' Due Date : ' || TO_CHAR(rec.DueDate, 'DD-MON-YYYY')
        );
    END LOOP;
END;
/

-- Show Final State of Tables After Processing
SELECT * FROM Customers;
SELECT * FROM Loans;