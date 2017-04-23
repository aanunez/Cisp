      ******************************************************************
      * Author: Lauryn Brown
      * Date:
      * Purpose: Evalute tokenized lisp
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. LISP.
       DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01 WS-SYMBOL-TABLE-INDEX PIC 9(4).
       01 WS-CURR-COMMAND PIC X(100).
       01 WS-CURRENT-VALUE PIC X(100).
       01 WS-CURRENT-VALUE-NUMERIC
       REDEFINES WS-CURRENT-VALUE PIC 9(10).
       01 WS-INIT-COMMAND PIC X.
           88 WS-INIT-COMMAND-YES VALUE "Y", FALSE 'N'.
      *****************************************
      *    WS Shared with LOGGER SubRoutine
      *****************************************
           01 WS-LOG-OPERATION-FLAG PIC X(5).
           01 WS-LOG-RECORD.
               02 WS-LOG-RECORD-FUNCTION-NAME PIC X(40).
               02 WS-LOG-RECORD-MESSAGE PIC X(100).
      *****************************************
      *    WS Shared with RECUSRION SubRoutine
      *****************************************
       01 WS-RECURSION-FLAG PIC X(30).
       01 WS-RECURSION-OBJECT.
          02 WS-COMMAND-NAME PIC X(20).
          02 WS-COMMAND-RESULT PIC X(20).
          02 WS-COMMAND-RESULT-NUMERIC
          REDEFINES WS-COMMAND-RESULT PIC 9(20).
          02 WS-COMMAND-RETURNS-RESULT PIC X.
             88 WS-COMMAND-RETURNS-RESULT-YES VALUE 'Y', FALSE 'N'.
       LINKAGE SECTION.
       01 LS-LISP-SYMBOLS.
           02 LS-SYMBOL-TABLE-SIZE PIC 9.
           02 LS-SYMBOL PIC X(50) OCCURS 40 TIMES.
           02 LS-SYMBOL-LEN PIC 9(2) OCCURS 40 TIMES.
       PROCEDURE DIVISION USING LS-LISP-SYMBOLS.
       MAIN-PROCEDURE.
           PERFORM INIT-CALL-STACK-PROCEDURE.
      ********* EVALUTE LISP
           PERFORM VARYING WS-SYMBOL-TABLE-INDEX FROM 1 BY 1 UNTIL
           WS-SYMBOL-TABLE-INDEX > LS-SYMBOL-TABLE-SIZE
               EVALUATE LS-SYMBOL(WS-SYMBOL-TABLE-INDEX)
               WHEN "("
                   SET WS-INIT-COMMAND-YES TO TRUE
               WHEN ")"
                   PERFORM LOG-COMMAND-EVALUTATION
                   PERFORM RETURN-PROCEDURE
               WHEN OTHER
                   MOVE LS-SYMBOL(WS-SYMBOL-TABLE-INDEX)
                    TO WS-CURR-COMMAND
                   PERFORM LOG-CURRENT-COMMAND-PROCEDURE
                   IF WS-INIT-COMMAND-YES THEN
                       PERFORM INIT-RECURSION-OBJECT-PROCEDURE
                   ELSE
                       PERFORM EVALUATE-CURRENT-COMMAND
                   END-IF
           END-PERFORM.
           PERFORM CLOSE-CALL-STACK-PROCEDURE.
           GOBACK.
       INIT-CALL-STACK-PROCEDURE.
      *********Initialize Call stack for Recursion
       MOVE "INIT" TO WS-RECURSION-FLAG.
       CALL "RECURSION" USING WS-RECURSION-FLAG.
       INIT-RECURSION-OBJECT-PROCEDURE.
           IF WS-COMMAND-NAME = SPACES THEN
               MOVE WS-CURR-COMMAND TO WS-COMMAND-NAME
           ELSE
      *****Recursion detected saving current state to the stack
               MOVE "ADD-TO-CALL-STACK" TO WS-RECURSION-FLAG
               CALL "RECURSION" USING WS-RECURSION-FLAG,
               WS-RECURSION-OBJECT
      ******Add the next command to the recursion OBJECT
               MOVE WS-CURR-COMMAND TO WS-COMMAND-NAME
           END-IF.
           SET WS-INIT-COMMAND-YES TO FALSE.
       RETURN-PROCEDURE.
           MOVE "IS-EMPTY" TO WS-RECURSION-FLAG.
           CALL "RECURSION" USING WS-RECURSION-FLAG.
           IF NOT WS-RECURSION-FLAG = "STACK-EMPTY" THEN
               MOVE WS-COMMAND-RESULT TO WS-CURRENT-VALUE
               PERFORM POP-CALL-STACK
               MOVE WS-COMMAND-NAME TO WS-CURR-COMMAND
               PERFORM EVALUATE-CURRENT-COMMAND
           END-IF.

       POP-CALL-STACK.
           MOVE "POP-CALL-STACK" TO WS-RECURSION-FLAG.
           CALL "RECURSION" USING WS-RECURSION-FLAG,
           WS-RECURSION-OBJECT.
       CLOSE-CALL-STACK-PROCEDURE.
           MOVE "CLOSE" TO WS-RECURSION-FLAG.
           CALL "RECURSION" USING WS-RECURSION-FLAG.
       LOG-CURRENT-COMMAND-PROCEDURE.
      ******log Current Command To be Executed
           MOVE "ADD" TO WS-LOG-OPERATION-FLAG.
           MOVE "LISP" TO
                WS-LOG-RECORD-FUNCTION-NAME.
           STRING 'Command:' DELIMITED BY SIZE
             WS-CURR-COMMAND DELIMITED BY SIZE
             INTO WS-LOG-RECORD-MESSAGE
           CALL 'LOGGER' USING WS-LOG-OPERATION-FLAG, WS-LOG-RECORD.
       EVALUATE-CURRENT-COMMAND.
           EVALUATE WS-CURR-COMMAND
           WHEN "write"
               PERFORM LISP-WRITE-PROCEDURE
           WHEN "+"
               PERFORM LISP-ADD-PROCEDURE
           WHEN OTHER
      ************ Evalute values
              IF WS-CURR-COMMAND(1:LS-SYMBOL-LEN(WS-SYMBOL-TABLE-INDEX))
                  IS NUMERIC THEN
                   MOVE WS-CURR-COMMAND TO WS-CURRENT-VALUE-NUMERIC
               ELSE
                   MOVE WS-CURR-COMMAND TO WS-CURRENT-VALUE
               END-IF
               PERFORM APPLY-VALUE-TO-EXPRESSION
           .
       APPLY-VALUE-TO-EXPRESSION.
           MOVE WS-COMMAND-NAME TO WS-CURR-COMMAND.
           PERFORM EVALUATE-CURRENT-COMMAND.
       LISP-WRITE-PROCEDURE.
           MOVE WS-CURRENT-VALUE TO WS-COMMAND-RESULT.
           DISPLAY WS-COMMAND-RESULT.
       LISP-ADD-PROCEDURE.
           IF WS-COMMAND-RESULT-NUMERIC EQUALS SPACES THEN
               MOVE 0 TO WS-COMMAND-RESULT-NUMERIC
           END-IF.
           ADD WS-CURRENT-VALUE-NUMERIC TO WS-COMMAND-RESULT-NUMERIC.
       LOG-COMMAND-EVALUTATION.
           MOVE "ADD" TO WS-LOG-OPERATION-FLAG.
           STRING "LISP:" DELIMITED BY SIZE
            WS-CURR-COMMAND INTO
                WS-LOG-RECORD-FUNCTION-NAME.
           STRING 'Result:' DELIMITED BY SIZE
             WS-COMMAND-RESULT DELIMITED BY SIZE
             INTO WS-LOG-RECORD-MESSAGE
           CALL 'LOGGER' USING WS-LOG-OPERATION-FLAG, WS-LOG-RECORD.
       END PROGRAM LISP.
