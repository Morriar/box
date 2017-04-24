
[Client] curl -s localhost:*****/api/boxes/NOTFOUND/submissions
{"status":404,"message":"Box `NOTFOUND` not found"}
[Client] curl -s localhost:*****/api/boxes/dev:BoxNit/submissions
[{"box_id":"dev:BoxNit","user":"dev","files":[{"path":"src/hello.nit","content":"if args.is_empty then\n\tprint \"Hello, World\"\nelse\n\tprint \"Hello {args.first}\"\nend\n","filename":"hello.nit","extension":"nit"}],"teammate":null,"timestamp":1491971159000,"id":"1491971159000_dev","is_approuved":false}]
[Client] curl -s localhost:*****/api/boxes/BoxPep/submissions
[{"box_id":"BoxPep","user":"dev","files":[{"path":"src/romcryption.pep","content":";                 UQAM ON STRIKE PUBLIC LICENSE\n;                    Version 2, December 2004\n;\n; Copyright (C) 2017\n; Alexandre Terrasa <@>,\n; Jean Privat <@>,\n; Philippe Pepos Petitclerc <@>\n;\n; Everyone is permitted to copy and distribute verbatim or modified\n; copies of this license document, and changing it is allowed as long\n; as the name is changed.\n;\n;                 UQAM ON STRIKE PUBLIC LICENSE\n;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION\n;\n;  0. You just do what the fuck you want to as long as you're on strike.\n;\n; aHR0cDovL2NzZ2FtZXMub3JnLzIwMTYvCg==\n\n; Read input\nloop_in: LDA     mLength,i   ; do {\n         CALL    new         ;   X = new Node(); #mVal #mNext #mPrev\n\t\t\t\t\t\t\t ;\n         LDA     0, i\t\t ;\t A = 0\n         STA     mPrev,x     ;   X.prev = 0\n         STA     mNext,x     ;   X.next = 0\n\t\t\t\t\t\t\t ;\n         CHARI   mVal,x      ;   X.val = getChar()\n         LDBYTEA mVal,x      ;   A = X.val\n         CPA     '\\n', i\t ;\t if(A == '\\n')\n         BREQ    out         ;\t   break;\n\t\t\t\t\t\t\t ;\n         ADDA    12, d\t\t ;\t A -= 13\n         STBYTEA mVal,x      ;\t X.val = A\n         LDA     head,d      ;\n         STA     mNext,x     ;   X.next = head;\n         STX     head,d      ;   head = X;\n         LDA     head,d      ;   A = head;\n         LDX     mNext,x     ;   X = X.next;\n         CPX     0,i         ;   if(X != null) {\n         BREQ    else\t\t ;\n         STA     mPrev,x     ;       X.prev = A;\n         BR      next        ;   } else {\nelse:    STA     tail,d      ;       tail = A;\n                             ;   }\nnext:    BR      loop_in     ; } while (X.val != null)\n\t\t\t\t\t\t\t ;\n                             ;\nout:     LDX     head,d\t\t ;\nbackward:CPX     0,i\t\t ;\n         BREQ    fin         ; for (X=head; X!=null; X=X.next) {\n         CHARO   mVal,x      ;   print(X.val)\n         LDX     mNext,x\t ;\n         BR      backward    ; }\nfin:     STOP\t\t\t\t ;\nhead:    .BLOCK  2           ; #2h list head (null (aka 0) if empty)\ntail:    .BLOCK  2           ; #2h list tail (null (aka 0) if empty)\n;\n;******* Linked-list node structure\nmVal:    .EQUATE 0           ; #1c node value\nmNext:   .EQUATE 1           ; #2h next node (null (aka 0) for tail)\nmPrev:   .EQUATE 3           ; #2h prev node (null (aka 0) for head)\nmLength: .EQUATE 5           ; node size in bytes\n;\n;\n;******* operator new\n;        Precondition: A contains number of bytes\n;        Postcondition: X contains pointer to bytes\nnew:     LDX     hpPtr,d     ;returned pointer\n         ADDA    hpPtr,d     ;allocate from heap\n         STA     hpPtr,d     ;update hpPtr\n         RET0\nhpPtr:   .ADDRSS heap        ;address of next free byte\nheap:    .BLOCK  1           ;first byte in the heap\n","filename":"romcryption.pep","extension":"pep"}],"teammate":null,"timestamp":1491970595000,"id":"1491970595000_dev","is_approuved":false},{"box_id":"BoxPep","user":"dev","files":[{"path":"src/romcryption.pep","content":"; Read input\nloop_in: LDA     mLength,i   ; do {\n         CALL    new         ;   X = new Node(); #mVal #mNext #mPrev\n\t\t\t\t\t\t\t ;\n         LDA     0, i\t\t ;\t A = 0\n         STA     mPrev,x     ;   X.prev = 0\n         STA     mNext,x     ;   X.next = 0\n\t\t\t\t\t\t\t ;\n         CHARI   mVal,x      ;   X.val = getChar()\n         LDBYTEA mVal,x      ;   A = X.val\n         CPA     '\\n', i\t ;\t if(A == '\\n')\n         BREQ    out         ;\t   break;\n\t\t\t\t\t\t\t ;\n         SUBA    13, i\t\t ;\t A -= 13\n         STBYTEA mVal,x      ;\t X.val = A\n         LDA     head,d      ;\n         STA     mNext,x     ;   X.next = head;\n         STX     head,d      ;   head = X;\n         LDA     head,d      ;   A = head;\n         LDX     mNext,x     ;   X = X.next;\n         CPX     0,i         ;   if(X != null) {\n         BREQ    else\t\t ;\n         STA     mPrev,x     ;       X.prev = A;\n         BR      next        ;   } else {\nelse:    STA     tail,d      ;       tail = A;\n                             ;   }\nnext:    BR      loop_in     ; } while (X.val != null)\n\t\t\t\t\t\t\t ;\n                             ;\nout:     LDX     tail,d\t\t ;\nbackward:CPX     0,i\t\t ;\n         BREQ    fin         ; for (X=head; X!=null; X=X.next) {\n         CHARO   mVal,x      ;   print(X.val)\n         LDX     mPrev,x\t ;\n         BR      backward    ; }\nfin:     STOP\t\t\t\t ;\nhead:    .BLOCK  2           ; #2h list head (null (aka 0) if empty)\ntail:    .BLOCK  2           ; #2h list tail (null (aka 0) if empty)\n;\n;******* Linked-list node structure\nmVal:    .EQUATE 0           ; #1c node value\nmNext:   .EQUATE 1           ; #2h next node (null (aka 0) for tail)\nmPrev:   .EQUATE 3           ; #2h prev node (null (aka 0) for head)\nmLength: .EQUATE 5           ; node size in bytes\n;\n;\n;******* operator new\n;        Precondition: A contains number of bytes\n;        Postcondition: X contains pointer to bytes\nnew:     LDX     hpPtr,d     ;returned pointer\n         ADDA    hpPtr,d     ;allocate from heap\n         STA     hpPtr,d     ;update hpPtr\n         RET0\nhpPtr:   .ADDRSS heap        ;address of next free byte\nheap:    .BLOCK  1           ;first byte in the heap\n\n         .END\n","filename":"romcryption.pep","extension":"pep"}],"teammate":null,"timestamp":1491970695000,"id":"1491970695000_dev","is_approuved":true}]
