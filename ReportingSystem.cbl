           IDENTIFICATION DIVISION.
           PROGRAM-ID. ReportingSystem.

           ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
           FILE CONTROL.

           SELECT InputFile ASSIGN TO "transaction.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OutputFile ASSIGN TO "report.csv"
               ORGANIZATION IS LINE SEQUENTIAL.
       
           DATA DIVISION.
           FILE SECTION.

           FD InputFile.
           01 InputRecord.

               05 TransactionAmount        PIC 9(5)V99.
               05 CustomerAge              PIC 99.


           FD OutputFile.
           01 OutputRecord                 PIC X(100).


           WORKING-STORAGE SECTION.

           01 Total Amount                 PIC 9(10)V99 VALUE 0.
           01 Count                        PIC 9(5) VALUE 0.
           01 Average                      PIC 9(10)V99 Value 0.
           01 Eligibility                  PIC X(20).
           01 EOF                          PIC X VALUE 'N'.

           PROCEDURE DIVISION.
           START RUN.

           OPEN INPUT InputFile
           OPEN INPUT OutputFile

           PERFORM UNTIL EOF = 'Y'
           READ InputFile INTO InputRecord
           AT END
           MOVE 'Y' TO EOF NOT AT END
           ADD TransactionAmount TO TotalAmount
           ADD 1 TO Count
           
           IF CustomerAge >= 18 THEN
           MOVE "Eligible" TO Eligibility
           ELSE
           MOVE "Not Eligible" TO Eligibility
           END-IF

           STRING
           "Total Amount", TotalAmount DELIMITED BY SIZE
           ", Average: ", Average DELIMITED BY SIZE,
           ", Count: ", Count DELIMITED BY SIZE,
           ", Eligibility: ", Eligibility DELIMITED BY SIZE

           INTO OutputRecord
           END-READ
           END-PERFORM

           IF Count > 0 THEN
           COMPUTE Average = TotalAmount / Count
           MOVE "Average Transaction: " TO OutputRecord
           STRING Average DELIMITED BY SIZE INTO OutputRecord
           WRITE OutputRecord
           END-IF

           ClOSE InputFile
           CLOSE OutputFile

           DISPLAY "Report generated successfully."
           STOP RUN.
