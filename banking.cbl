       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKING.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ACCOUNTS-FILE ASSIGN TO "accounts.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TRANSACTION-FILE ASSIGN TO "transaction.dat"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUTPUT-FILE ASSIGN TO "output.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD ACCOUNTS-FILE.
       01 ACCOUNT-RECORD.
           05 ACC-ID          PIC X(5).
           05 ACC-NAME        PIC X(20).
           05 ACC-BALANCE     PIC 9(7)V99.

       FD TRANSACTION-FILE.
       01 TRANSACTION-RECORD.
           05 TRX-ID          PIC X(5).
           05 TRX-TYPE        PIC X(10).     *> "DEPOSIT" or "WITHDRAW"
           05 TRX-AMOUNT      PIC 9(7)V99.

       FD OUTPUT-FILE.
       01 OUTPUT-RECORD       PIC X(100).

       WORKING-STORAGE SECTION.
       01 EOF-FLAG            PIC X VALUE "N".
           88 END-OF-FILE     VALUE "Y".
           88 NOT-END-OF-FILE VALUE "N".

       01 MATCH-STATUS        PIC X VALUE "N".
           88 MATCH-FOUND     VALUE "Y".
           88 NO-MATCH        VALUE "N".

       01 UPDATED-BALANCE     PIC 9(7)V99.

       PROCEDURE DIVISION.
       MAIN.
           OPEN INPUT TRANSACTION-FILE
           READ TRANSACTION-FILE INTO TRANSACTION-RECORD
               AT END
                   DISPLAY "No transaction found."
                   STOP RUN
           END-READ
           CLOSE TRANSACTION-FILE

           OPEN INPUT ACCOUNTS-FILE
                OUTPUT OUTPUT-FILE

           PERFORM UNTIL END-OF-FILE
               READ ACCOUNTS-FILE
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       IF TRX-ID = ACC-ID
                           SET MATCH-FOUND TO TRUE
                           PERFORM PROCESS-TRANSACTION
                       END-IF
               END-READ
           END-PERFORM

           IF NO-MATCH
               MOVE "Account not found" TO OUTPUT-RECORD
               WRITE OUTPUT-RECORD
           END-IF

           CLOSE ACCOUNTS-FILE
                 OUTPUT-FILE
           STOP RUN.

       PROCESS-TRANSACTION.
           IF TRX-TYPE = "DEPOSIT"
               COMPUTE UPDATED-BALANCE = ACC-BALANCE + TRX-AMOUNT
           ELSE IF TRX-TYPE = "WITHDRAW"
               IF TRX-AMOUNT <= ACC-BALANCE
                   COMPUTE UPDATED-BALANCE = ACC-BALANCE - TRX-AMOUNT
               ELSE
                   MOVE "Insufficient funds" TO OUTPUT-RECORD
                   WRITE OUTPUT-RECORD
                   EXIT PARAGRAPH
               END-IF
           ELSE
               MOVE "Invalid transaction type" TO OUTPUT-RECORD
               WRITE OUTPUT-RECORD
               EXIT PARAGRAPH
           END-IF

           MOVE UPDATED-BALANCE TO ACC-BALANCE

           STRING
               "Account ID: " ACC-ID
               " Name: " ACC-NAME
               " New Balance: " ACC-BALANCE
               DELIMITED BY SIZE
               INTO OUTPUT-RECORD

           WRITE OUTPUT-RECORD.
