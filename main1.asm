10000 GTSTCK:   EQU     00D5H
10010 GTTRIG:   EQU     00D8H
10020 NEG:      EQU     44EDH
10030 BREAKX:   EQU     00B7H
10040 CALSLT:   EQU     001CH
10050 EXPTBL:   EQU     0FCC1H
10060 NEXT:     EQU     1450H
10070 WRLIFE:   EQU     09F7H+0537H
10075 SSTACK:   EQU     4000H
10080           ORG     0100H
10090 ;
10100 ;---- SCREEN & COLOR SET ----
10110 ;
10120           LD      A,(EXPTBL)
10130           LD      HL,0006H
10140           CALL    000CH
10150           LD      (RDVDP),A
10160           LD      A,(EXPTBL)
10170           LD      HL,0007H
10180           CALL    000CH
10190           LD      (RDVDP+1),A
10200           LD      A,7
10210           LD      (PLDAT),A
10220           CALL    PALETE
10230           ;
10240           LD      A,15
10250           LD      HL,0
10260           LD      (0F3E9H),A
10270           LD      (0F3EAH),HL
10280           LD      A,(0FFE7H)
10290           OR      00000010B
10300           LD      (0FFE7H),A
10310           LD      A,5
10320           LD      IX,005FH
10330           LD      IY,(EXPTBL-1)
10340           CALL    CALSLT
10350           ;
10360           DI
10370           LD      BC,(RDVDP+1)
10380           INC     C
10390           LD      A,22
10400           OUT     (C),A
10410           LD      A,23+80H
10420           OUT     (C),A
10430           EI
10440           ;
10450           LD      (SSTACK),SP
10490           JP      NEXT
10500 ;
10510 ;---- MAIN ROUTINE ----
10520 ;
10530 MAIN:     PUSH    IX
10540           PUSH    HL
10550           PUSH    DE
10560           PUSH    BC
10570           ;
10580 MAINS:    PUSH    AF
10590           LD      IX,BREAKX
10600           LD      IY,(EXPTBL-1)
10610           CALL    CALSLT
10620           JP      C,RETURN
10630           ;
10640           CALL    CLS
10650           LD      A,(SWHICH)
10660           BIT     0,A
10670           CALL    NZ,SCALE
10680           ;
10690           BIT     1,A
10700           JR      Z,MA0
10710           LD      IX,MASTER
10720           CALL    MALTI
10730           BIT     2,A
10740           CALL    NZ,MALTI
10750           ;
10760 MA0:      BIT     3,A
10770           JR      Z,MA2
10780           LD      HL,PORIDAT
10790           LD      DE,16
10800           LD      B,E
10810           PUSH    AF
10820 MA1:      LD      A,(HL)
10830           OR      A
10840           JR      Z,$+8
10850           PUSH    HL
10860           POP     IX
10870           CALL    MALTI
10880           ADD     HL,DE
10890           DJNZ    MA1
10900           POP     AF
10910           ;
10920 MA2:      BIT     6,A
10930           CALL    NZ,WRLIFE
10940           ;
10950           PUSH    AF
10960           LD      A,(VIJUAL)
10970           XOR     1
10980           LD      (VIJUAL),A
10990           RRCA
11000           RRCA
11010           RRCA
11020           OR      00011111B
11030           LD      BC,(RDVDP+1)
11040           INC     C
11050           DI
11060           OUT     (C),A
11070           LD      A,80H+2
11080           OUT     (C),A
11090           EI
11100           POP     AF
11110           ;
11120           BIT     4,A
11130           JR      Z,MA3
11140           LD      A,(LIFE)
11150           OR      A
11160           JR      NZ,MA3
11170           LD      HL,(DEADRT)
11180           JP      (HL)
11190           ;
11200 MA3:      POP     AF
11210           DEC     A
11220           JP      NZ,MAINS
11230           ;
11240           POP     BC
11250           POP     DE
11260           POP     HL
11270           POP     IX
11280           RET
11290           ;
11300 RETURN:   LD      SP,(SSTACK)
11320           JP      NEXT
11330           NOP
11335           NOP
11340           NOP
11350           NOP
11360           NOP
11370           NOP
11380           NOP
11390           NOP
11400           NOP
11410           NOP
11420           NOP
11430           NOP
11440           NOP
11450           NOP
11460           NOP
11470           NOP
11480           NOP
11490           NOP
11500           NOP
11510           NOP
11520           NOP
11530 ;
11540 ;---- PORY WRITE ----
11550 ;
11560 MALTI:    PUSH    AF
11570           PUSH    BC
11580           PUSH    DE
11590           PUSH    HL
11600           LD      (MALRET+1),SP
11610           LD      HL,PARET
11620           PUSH    HL
11630           LD      H,(IX+6)
11640           LD      L,(IX+5)
11650           JP      (HL)
11660 PARET:    BIT     0,(IX+15)
11670           JP      NZ,MALRET
11680           ;
11690           XOR     A
11700           LD      (IX+2),A
11710           LD      L,(IX+3)
11720           LD      H,(IX+4)
11730           LD      B,(HL)
11740           INC     HL
11750           LD      C,(HL)
11760           INC     HL
11770           LD      DE,HYOUJI
11780 MLOOP:    PUSH    BC
11790           PUSH    DE
11800           PUSH    HL
11810           PUSH    BC
11820           PUSH    DE
11830           LD      DE,WORK
11840           CALL    TURN
11850           POP     DE
11860           POP     BC
11870           LD      A,B
11880           CP      C
11890           LD      HL,WORK
11900           CALL    NC,MONMAK
11910           POP     HL
11920           INC     HL
11930           INC     HL
11940           INC     HL
11950           POP     DE
11960           INC     DE
11970           INC     DE
11980           POP     BC
11990           DJNZ    MLOOP
12000           ;
12010           PUSH    HL
12020           CALL    TUCH
12030           POP     BC
12040 SCREEN:   LD      A,(BC)
12050           ADD     A,A
12060           LD      HL,WORK+1
12070           ADD     A,L
12080           JR      NC,$+3
12090           INC     H
12100           LD      L,A
12110           LD      D,(HL)
12120           INC     HL
12130           LD      E,(HL)
12140 SC1:      INC     BC
12150           LD      A,(BC)
12160           ADD     A,A
12170           LD      HL,WORK+1
12180           ADD     A,L
12190           JR      NC,$+3
12200           INC     H
12210           LD      L,A
12220           PUSH    DE
12230           LD      D,(HL)
12240           INC     HL
12250           LD      E,(HL)
12260           POP     HL
12270           ;
12280           LD      A,(IX+2)
12290           OR      A
12300           JR      NZ,BREAK
12310           BIT     4,(IX+15)
12320           JR      Z,SSET
12330 BREAK:    LD      A,R
12340           AND     00011111B
12350           RRA
12360           JR      NC,$+4
12370           NEG
12380           ADD     A,D
12390           LD      D,A
12400           ADD     A,119
12410           AND     00111111B
12420           RRA
12430           JR      NC,$+4
12440           NEG
12450           ADD     A,L
12460           LD      L,A
12470           ;
12480 SSET:     LD      (LIDAT),HL
12490           LD      (LIDAT+2),DE
12500           CALL    LINE
12510           INC     BC
12520           LD      A,(BC)
12530           DEC     BC
12540           OR      A
12550           JR      NZ,SC1
12560           INC     BC
12570           INC     BC
12580           LD      A,(BC)
12590           OR      A
12600           JR      NZ,SCREEN
12610           POP     HL
12620           POP     DE
12630           POP     BC
12640           POP     AF
12650           RET
12660           ;
12670 MALEND:   XOR     A
12680           LD      (IX+0),A
12690 MALRET:   LD      SP,0
12700           POP     HL
12710           POP     DE
12720           POP     BC
12730           POP     AF
12740           RET
12750 ;
12760 ; POINT TURN
12770 ;
12780 TURN:     PUSH    DE
12790           LD      B,(HL)
12800           INC     HL
12810           LD      C,(HL)
12820           INC     HL
12830           LD      A,(IX+10)
12840           AND     00011111B
12850           CALL    NZ,KAITEN
12860           LD      D,B
12870           LD      B,(HL)
12880           LD      A,(IX+11)
12890           AND     00011111B
12900           CALL    NZ,KAITEN
12910           LD      E,C
12920           LD      C,B
12930           LD      B,D
12940           LD      A,(IX+12)
12950           AND     00011111B
12960           CALL    NZ,KAITEN
12970           POP     HL
12980           BIT     1,(IX+15)
12990           JR      Z,$+8
13000           SLA     B
13010           SLA     C
13020           SLA     E
13030           BIT     2,(IX+15)
13040           JR      Z,$+8
13050           SRA     B
13060           SRA     C
13070           SRA     E
13080           JP      SEARCH
13090           ;
13100 KAITEN:   PUSH    DE
13110           PUSH    HL
13120           LD      HL,SINDAT
13130           ADD     A,A
13140           ADD     A,L
13150           JR      NC,$+3
13160           INC     H
13170           LD      L,A
13180           LD      D,(HL)
13190           INC     HL
13200           LD      E,(HL)
13210           LD      A,D
13220           LD      H,B
13230           OR      A
13240           CALL    NZ,TIMES
13250           LD      L,A
13260           LD      A,E
13270           LD      H,C
13280           OR      A
13290           CALL    NZ,TIMES
13300           LD      H,A
13310           PUSH    HL
13320           LD      A,D
13330           LD      H,C
13340           OR      A
13350           CALL    NZ,TIMES
13360           LD      L,A
13370           LD      A,E
13380           LD      H,B
13390           OR      A
13400           CALL    NZ,TIMES
13410           SUB     L
13420           LD      B,A
13430           POP     HL
13440           LD      A,H
13450           ADD     A,L
13460           LD      C,A
13470           POP     HL
13480           POP     DE
13490           RET
13500           ;
13510 TIMES:    INC     H
13520           DEC     H
13530           JR      NZ,$+4
13540           XOR     A
13550           RET
13560           PUSH    HL
13570           PUSH    BC
13580           PUSH    DE
13590           LD      D,0
13600           LD      E,H
13610           LD      HL,0
13620           SLA     A   ;SIN<0
13630           LD      B,A
13640           JR      NC,$+5
13650           LD      HL,NEG
13660           LD      (NEGPAT),HL
13670           LD      HL,0
13680           LD      A,E
13690           OR      A
13700           JP      P,$+8
13710           LD      HL,NEG
13720           NEG
13730           LD      (NEGPT2),HL
13740           LD      E,A
13750           LD      A,B
13760           CP      0FEH  ;SIN=1
13770           JR      NZ,$+5
13780           LD      A,E
13790           JR      NEGPAT
13800           LD      HL,0
13810           LD      B,8
13820 LOOP2:    RRA
13830           JR      NC,$+3
13840           ADD     HL,DE
13850           SLA     E
13860           RL      D
13870           DJNZ    LOOP2
13880           LD      A,H
13890 NEGPAT:   NOP
13900           NOP
13910 NEGPT2:   NOP
13920           NOP
13930           POP     DE
13940           POP     BC
13950           POP     HL
13960           RET
13970 SINDAT:
13980 DEFB        0,127, 25,126
13990 DEFB       49,119, 71,107
14000 DEFB       91, 91,107, 71
14010 DEFB      119, 49,126, 25
14020 DEFB      127,  0,126,153
14030 DEFB      119,177,107,199
14040 DEFB       91,219, 71,235
14050 DEFB       49,247, 25,254
14060 DEFB        0,255,153,254
14070 DEFB      177,247,199,235
14080 DEFB      219,219,235,199
14090 DEFB      247,177,254,153
14100 DEFB      255,  0,254, 25
14110 DEFB      247, 49,235, 71
14120 DEFB      219, 91,199,107
14130 DEFB      177,119,153,126
14140 ;
14150 ; SEARCH IN GAGE
14160 ;
14170 SEARCH:   LD      D,B
14180           LD      A,B
14190           ADD     A,(IX+7)
14200           EX      AF,AF'
14210           RL      D
14220           JR      NC,$+7
14230           EX      AF,AF'
14240           JR      NC,SERRET
14250           JR      $+5
14260           EX      AF,AF'
14270           JR      C,SERRET
14280           LD      (HL),A
14290           INC     HL
14300           LD      D,E
14310           LD      A,E
14320           ADD     A,(IX+8)
14330           EX      AF,AF'
14340           RL      D
14350           JR      NC,$+7
14360           EX      AF,AF'
14370           JR      NC,SERRET
14380           JR      $+5
14390           EX      AF,AF'
14400           JR      C,SERRET
14410           LD      (HL),A
14420           INC     HL
14430           SRA     C
14440           LD      D,C
14450           LD      A,C
14460           ADD     A,(IX+9)
14470           EX      AF,AF'
14480           RL      D
14490           JR      NC,$+7
14500           EX      AF,AF'
14510           JR      NC,SERRET
14520           JR      $+5
14530           EX      AF,AF'
14540           JR      C,SERRET
14550           LD      (HL),A
14560           BIT     3,(IX+15)
14570           RET     NZ
14580           ;
14590           LD      DE,GAGE+5
14600           EX      DE,HL
14610           CP      (HL)
14620           RET     NC
14630           DEC     HL
14640           CP      (HL)
14650           RET     C
14660           LD      A,(IX+2)
14670           OR      A
14680           RET     NZ
14690           EX      DE,HL
14700           DEC     DE
14710           DEC     HL
14720           LD      A,(DE)
14730           CP      (HL)
14740           RET     C
14750           DEC     DE
14760           LD      A,(DE)
14770           CP      (HL)
14780           RET     NC
14790           DEC     DE
14800           DEC     HL
14810           LD      A,(DE)
14820           CP      (HL)
14830           RET     C
14840           DEC     DE
14850           LD      A,(DE)
14860           CP      (HL)
14870           RET     NC
14880           LD      A,1
14890           LD      (IX+2),A
14900           RET
14910           ;
14920 SERRET:   BIT     5,(IX+15)
14930           JP      Z,MALEND
14940           JP      MALRET
14950 ;
14960 ; TUCH ROUTINE
14970 ;
14980 TUCH:     LD      H,0
14990           LD      L,(IX+13)
15000           LD      (LIDAT+4),HL
15010           LD      A,(IX+2)
15020           OR      A
15030           RET     Z
15040           ;
15050           LD      HL,JPTUCH
15060           LD      A,(IX+14)
15070           AND     15
15080           ADD     A,A
15090           LD      E,A
15100           LD      D,0
15110           ADD     HL,DE
15120           LD      E,(HL)
15130           INC     HL
15140           LD      D,(HL)
15150           EX      DE,HL
15160           JP      (HL)
15170           ;
15180 JPTUCH:   DEFS    32
15190 ;
15200 ; MONITOR POINT
15210 ;
15220 MONMAK:   LD      A,(HL)
15230           LD      C,0
15240           INC     HL
15250           INC     HL
15260           ADD     A,(HL)
15270           RL      C
15280           ADD     A,(HL)
15290           JR      NC,$+3
15300           INC     C
15310           RR      C
15320           RRA
15330           RR      C
15340           RRA
15350           RR      C
15360           LD      B,A
15370           PUSH    DE
15380           LD      D,0
15390           LD      A,(HL)
15400           ADD     A,64
15410           RL      D
15420           LD      E,A
15430           CALL    WARIZU
15440           POP     DE
15450           LD      (DE),A
15460           DEC     HL
15470           INC     DE
15480           LD      A,(HL)
15490           LD      C,0
15500           INC     HL
15510           ADD     A,(HL)
15520           RL      C
15530           ADD     A,(HL)
15540           JR      NC,$+3
15550           INC     C
15560           RR      C
15570           RRA
15580           RR      C
15590           RRA
15600           RR      C
15610           LD      B,A
15620           PUSH    DE
15630           LD      D,0
15640           LD      A,(HL)
15650           ADD     A,64
15660           RL      D
15670           LD      E,A
15680           CALL    WARIZU
15690           POP     DE
15700           LD      (DE),A
15710           RET
15720           ;
15730 WARIZU:   PUSH    HL
15740           LD      H,0
15750           LD      L,B
15760           LD      B,8
15770 WALOOP:   RL      C
15780           RL      L
15790           RL      H
15800           OR      A
15810           SBC     HL,DE
15820           JR      NC,$+4
15830           ADD     HL,DE
15840           SCF
15850           CCF
15860           RLA
15870           DJNZ    WALOOP
15880           POP     HL
15890           RET
15900 ;
15910 ; LINE ROUTINE
15920 ;
15930 LINE:     PUSH    AF
15940           PUSH    BC
15950           PUSH    DE
15960           PUSH    HL
15970           LD      BC,(RDVDP)
15980           INC     B
15990           INC     C
16000           LD      L,C
16010           LD      C,B
16020           LD      DE,028FH
16030           DI
16040           OUT     (C),D
16050           OUT     (C),E
16060           LD      DE,2491H
16070           OUT     (C),D
16080           OUT     (C),E
16090           LD      H,C
16100           LD      C,L
16110 WAITLI:   IN      A,(C)
16120           AND     1
16130           JR      NZ,WAITLI
16140           LD      C,H
16150           OUT     (C),A
16160           LD      A,8FH
16170           OUT     (C),A
16180           INC     C
16190           INC     C
16200           ;
16210           LD      HL,(LIDAT)
16220           LD      DE,(LIDAT+2)
16230           XOR     A
16240           OUT     (C),H
16250           OUT     (C),A
16260           OUT     (C),L
16270           LD      A,(VIJUAL)
16280           XOR     1
16290           OUT     (C),A
16300           LD      B,0
16310           LD      A,D
16320           SUB     H
16330           JR      NC,LINE1
16340           NEG
16350           SET     2,B
16360 LINE1:    LD      D,A
16370           LD      A,E
16380           SUB     L
16390           JR      NC,LINE2
16400           NEG
16410           SET     3,B
16420 LINE2:    LD      E,A
16430           CP      D
16440           JR      C,LINE3
16450           SET     0,B
16460           LD      A,D
16470           LD      D,E
16480           LD      E,A
16490 LINE3:    XOR     A
16500           OUT     (C),D
16510           OUT     (C),A
16520           OUT     (C),E
16530           OUT     (C),A
16540           LD      DE,(LIDAT+4)
16550           OUT     (C),E
16560           OUT     (C),B
16570           LD      A,D
16580           OR      01110000B
16590           OUT     (C),A
16600           EI
16610           POP     HL
16620           POP     DE
16630           POP     BC
16640           POP     AF
16650           RET
16660           ;
16670 LIDAT:    DEFB    0,0  ;X ,Y
16680           DEFB    0,0  ;X',Y'
16690           DEFB    0,0  ;COLOR
16700 ;
16710 ; CLS ROUTINE
16720 ;
16730 CLS:      PUSH    AF
16740           PUSH    BC
16750           PUSH    DE
16760           PUSH    HL
16770           LD      A,(VIJUAL)
16780           XOR     1
16790           LD      (CMDDAT+3),A
16800           LD      BC,(RDVDP)
16810           LD      DE,028FH
16820           INC     B
16830           INC     C
16840           LD      L,C
16850           LD      C,B
16860           DI
16870           OUT     (C),D
16880           OUT     (C),E
16890           LD      DE,2491H
16900           OUT     (C),D
16910           OUT     (C),E
16920           INC     C
16930           INC     C
16940           LD      H,C
16950           LD      C,L
16960 WAITCL:   IN      A,(C)
16970           AND     1
16980           JR      NZ,WAITCL
16990           LD      C,H
17000           LD      HL,CMDDAT
17010           OUTI
17020           OUTI
17030           OUTI
17040           OUTI
17050           OUTI
17060           OUTI
17070           OUTI
17080           OUTI
17090           OUTI
17100           OUTI
17110           OUTI
17120           DEC     C
17130           DEC     C
17140           OUT     (C),A
17150           LD      A,8FH
17160           OUT     (C),A
17170           EI
17180           POP     HL
17190           POP     DE
17200           POP     BC
17210           POP     AF
17220           RET
17230           ;
17240 CMDDAT:   DEFW    0,22
17250           DEFW    256,212
17260           DEFB    0
17270           DEFB    00000000B
17280           DEFB    11000000B
17290 ;
17300 ; SCALE SUB
17310 ;
17320 SCALE:    PUSH    AF
17330           PUSH    BC
17340           PUSH    DE
17350           PUSH    HL
17360           LD      A,(SCOLOR)
17370           LD      L,A
17380           LD      H,0
17390           LD      (LIDAT+4),HL
17400           LD      L,154
17410           LD      (LIDAT),HL
17420           LD      H,255
17430           LD      (LIDAT+2),HL
17440           CALL    LINE
17450           LD      A,(SCOLOR+1)
17460           AND     3
17470           LD      H,A
17480           LD      A,(POINTA)
17490           ADD     A,H
17500           AND     7
17510           LD      (POINTA),A
17520           LD      HL,POINTA+1
17530           ADD     A,L
17540           JR      NC,$+3
17550           INC     H
17560           LD      L,A
17570           LD      B,4
17580 SLOOP:    LD      A,(HL)
17590           LD      E,A
17600           LD      D,0
17610           LD      (LIDAT),DE
17620           LD      D,255
17630           LD      (LIDAT+2),DE
17640           CALL    LINE
17650           LD      DE,8
17660           ADD     HL,DE
17670           DJNZ    SLOOP
17680           POP     HL
17690           POP     DE
17700           POP     BC
17710           POP     AF
17720           RET
17730 POINTA:
17740 DEFB      0
17750 DEFB      154,154,155,156
17760 DEFB      157,157,158,159
17770 DEFB      160,161,162,163
17780 DEFB      165,166,168,169
17790 DEFB      171,173,175,177
17800 DEFB      180,182,185,189
17810 DEFB      193,197,202,208
17820 DEFB      214,222,232,243
17830 ;
17840 ; KEY ROUTINE
17850 ;
17860 KEY:      PUSH    IX
17870           XOR     A
17880           LD      IX,GTSTCK
17890           LD      IY,(EXPTBL-1)
17900           CALL    CALSLT
17910           OR      A
17920           JR      NZ,JRKE
17930           INC     A
17940           LD      IX,GTSTCK
17950           LD      IY,(EXPTBL-1)
17960           CALL    CALSLT
17970 JRKE:     POP     IX
17980           ;
17990           OR      A
18000           JR      Z,TRIG
18010           DEC     A
18020           LD      B,A
18030           LD      D,(IX+7)
18040           LD      E,(IX+8)
18050           AND     3
18060           JR      Z,DOWN
18070           BIT     2,B
18080           LD      A,D
18090           JR      NZ,LEFT
18100           ADD     A,16
18110           CP      225
18120           JR      NC,DOWN
18130           LD      D,A
18140           DEC     (IX+10)
18150           JR      DOWN
18160 LEFT:     SUB     16
18170           CP      32
18180           JR      C,DOWN
18190           LD      D,A
18200           INC     (IX+10)
18210 DOWN:     LD      A,B
18220           ADD     A,2
18230           AND     7
18240           LD      B,A
18250           AND     3
18260           JR      Z,SET
18270           BIT     2,B
18280           LD      A,E
18290           JR      NZ,DW
18300           ADD     A,16
18310           CP      225
18320           JR      NC,SET
18330           LD      E,A
18340           JR      SET
18350 DW:       SUB     16
18360           CP      32
18370           JR      C,SET
18380           LD      E,A
18390           ;
18400 SET:      LD      (IX+7),D
18410           LD      (IX+8),E
18420           ;
18430 TRIG:     PUSH    IX
18440           XOR     A
18450           LD      IX,GTTRIG
18460           LD      IY,(EXPTBL-1)
18470           CALL    CALSLT
18480           INC     A
18490           JR      Z,JRTR
18500           LD      IX,GTTRIG
18510           LD      IY,(EXPTBL-1)
18520           CALL    CALSLT
18530           INC     A
18540 JRTR:     POP     IX
18550           ;
18560           JR      Z,GO
18570           LD      A,-8
18580           ADD     A,(IX+9)
18590           CP      16
18600           JR      C,SET2+3
18610           JR      SET2
18620 GO:       LD      A,16
18630           ADD     A,(IX+9)
18640           CP      129
18650           JR      NC,SET2+3
18660 SET2:     LD      (IX+9),A
18670           ;
18680           CALL    SETGAG
18690           RET
18700 ;
18710 ; SET GAGE
18720 ;
18730 SETGAG:   LD      IY,GAGE
18740           LD      A,(IX+7)
18750           ADD     A,24
18760           LD      (IY+1),A
18770           SUB     48
18780           LD      (IY+0),A
18790           LD      A,(IX+8)
18800           ADD     A,20
18810           LD      (IY+3),A
18820           SUB     38
18830           LD      (IY+2),A
18840           LD      A,(IX+9)
18850           ADD     A,16
18860           LD      (IY+5),A
18870           SUB     32
18880           LD      (IY+4),A
18890           RET
18900 ;
18910 ; MOVE SUB
18920 ;
18930 MOVE:     PUSH    IX
18940           POP     HL
18950           LD      DE,7
18960           ADD     HL,DE
18970           POP     DE
18980           LD      A,(DE)
18990           ADD     A,(HL)
19000           LD      (HL),A
19010           INC     DE
19020           INC     HL
19030           LD      A,(DE)
19040           ADD     A,(HL)
19050           LD      (HL),A
19060           INC     DE
19070           INC     HL
19080           LD      A,(DE)
19090           ADD     A,(HL)
19100           LD      (HL),A
19110           INC     DE
19120           INC     HL
19130           LD      A,(DE)
19140           ADD     A,(HL)
19150           LD      (HL),A
19160           INC     DE
19170           INC     HL
19180           LD      A,(DE)
19190           ADD     A,(HL)
19200           LD      (HL),A
19210           INC     DE
19220           INC     HL
19230           LD      A,(DE)
19240           ADD     A,(HL)
19250           LD      (HL),A
19260           RET
19270           ;
19280 RTURN:    EX      (SP),HL
19290           PUSH    DE
19300           PUSH    BC
19310           PUSH    AF
19320           PUSH    HL
19330           LD      A,(IX+7)
19340           SUB     (HL)
19350           LD      B,A
19360           INC     HL
19370           LD      A,(IX+8)
19380           SUB     (HL)
19390           LD      C,A
19400           INC     HL
19410           LD      A,(IX+9)
19420           SUB     (HL)
19430           LD      D,A
19440           INC     HL
19450           LD      A,(HL)
19460           OR      A
19470           CALL    NZ,KAITEN
19480           LD      E,B
19490           LD      B,D
19500           INC     HL
19510           LD      A,(HL)
19520           OR      A
19530           CALL    NZ,KAITEN
19540           LD      D,C
19550           LD      C,B
19560           LD      B,E
19570           INC     HL
19580           LD      A,(HL)
19590           OR      A
19600           CALL    NZ,KAITEN
19610           POP     HL
19620           LD      A,B
19630           ADD     A,(HL)
19640           LD      (IX+7),A
19650           INC     HL
19660           LD      A,D
19670           ADD     A,(HL)
19680           LD      (IX+8),A
19690           INC     HL
19700           LD      A,C
19710           ADD     A,(HL)
19720           LD      (IX+9),A
19730           INC     HL
19740           INC     HL
19750           INC     HL
19760           INC     HL
19770           POP     AF
19780           POP     BC
19790           POP     DE
19800           EX      (SP),HL
19810           RET
19820 ;
19830 ; DATA SET
19840 ;
19850 DSET:     EX      (SP),HL
19860           PUSH    DE
19870           PUSH    BC
19880           PUSH    AF
19890           PUSH    HL
19900           LD      HL,PORIDAT
19910           LD      DE,16
19920           LD      B,E
19930 DSLOOP:   LD      A,(HL)
19940           OR      A
19950           JR      Z,DSSET
19960           ADD     HL,DE
19970           DJNZ    DSLOOP
19980           POP     HL
19990           LD      DE,13
20000           ADD     HL,DE
20010           JR      DSRET
20020           ;
20030 DSSET:    POP     DE
20040           LD      (HL),1
20050           INC     HL
20060           LD      (HL),0
20070           INC     HL
20080           LD      (HL),0
20090           INC     HL
20100           EX      DE,HL
20110           LDI
20120           LDI
20130           LDI
20140           LDI
20150           LDI
20160           LDI
20170           LDI
20180           LDI
20190           LDI
20200           LDI
20210           LDI
20220           LDI
20230           LDI
20240 DSRET:    POP     AF
20250           POP     BC
20260           POP     DE
20270           EX      (SP),HL
20280           RET
20290           ;
20300 CLSPRI:   XOR     A
20310           LD      HL,PORIDAT
20320           LD      DE,PORIDAT+1
20330           LD      BC,255
20340           LD      (HL),A
20350           LDIR
20360           RET
20370 ;
20380 ; PALETTE SET
20390 ;
20400 PALETE:   PUSH    AF
20410           PUSH    BC
20420           PUSH    DE
20430           PUSH    HL
20440           LD      BC,(RDVDP+1)
20450           INC     C
20460           DI
20470           XOR     A
20480           OUT     (C),A
20490           LD      A,80H+16
20500           OUT     (C),A
20510           INC     C
20520           LD      B,16
20530           LD      HL,PLDAT
20540           LD      E,(HL)
20550 PLLOOP:   INC     HL
20560           LD      A,(HL)
20570           SUB     E
20580           JR      NC,$+3
20590           XOR     A
20600           RLCA
20610           RLCA
20620           RLCA
20630           RLCA
20640           LD      D,A
20650           INC     HL
20660           LD      A,(HL)
20670           SUB     E
20680           JR      NC,$+3
20690           XOR     A
20700           OR      D
20710           OUT     (C),A
20720           INC     HL
20730           LD      A,(HL)
20740           SUB     E
20750           JR      NC,$+3
20760           XOR     A
20770           OUT     (C),A
20780           DJNZ    PLLOOP
20790           EI
20800           POP     HL
20810           POP     DE
20820           POP     BC
20830           POP     AF
20840           RET
20850           ;
20860 PLDAT:    DEFB    7
20870           DEFB    0,0,0,0,0,0
20880           DEFB    1,1,6,3,3,7
20890           DEFB    1,7,1,2,7,3
20900           DEFB    5,1,1,2,7,6
20910           DEFB    7,1,1,7,3,3
20920           DEFB    6,1,6,6,3,6
20930           DEFB    1,1,4,6,5,2
20940           DEFB    5,5,5,7,7,7
20950           ;
20960 UNFADE:   CALL    DSET
20970           DEFW    0,UNFAD
20980           DEFW    0,0,0,0
20990           DEFB    00000001B
21000           RET
21010 UNFAD:    LD      A,(IX+1)
21020           INC     (IX+1)
21030           CP      8
21040           JP      Z,MALEND
21050           XOR     7
21060           LD      (PLDAT),A
21070           CALL    PALETE
21080           RET
21090           ;
21100 FADE:     CALL    DSET
21110           DEFW    0,FAD
21120           DEFW    0,0,0,0
21130           DEFB    00000001B
21140           RET
21150 FAD:      LD      A,(IX+1)
21160           INC     (IX+1)
21170           CP      8
21180           JP      Z,MALEND
21190           LD      (PLDAT),A
21200           CALL    PALETE
21210           RET
21220 ;
21230 ;---- WORK AREA ----
21240 ;
21250 RDVDP:    DEFS    2
21260 WORK:     DEFS    3
21270 HYOUJI:   DEFS    120
21280 VIJUAL:   DEFB    0
21290 STACK:    DEFW    0
21300 ;
21310 SCROLL:   DEFB    0,0
21320 SCOLOR:   DEFB    3,1
21330 SWHICH:   DEFB    00001001B
21340 CONTRT:   DEFW    00
21350 DEADRT:   DEFW    00
21360 LIFE:     DEFB    0
21370 STOCK:    DEFB    0
21380 SCORE:    DEFW    00
21390 HSCORE:   DEFW    00
21400 GAGE:     DEFB    0,0,0,0,0,0
21410 MASTER:   DEFS    16
21420 PORIDAT:  DEFS    256
21430 END:      EQU     $
