500 TOP1:      EQU     0100H
1000 MALEND:   EQU     TOP1+019EH
1010 LINE:     EQU     TOP1+03B9H
1020 LIDAT:    EQU     TOP1+0432H
1030 LIFE:     EQU     TOP1+07DBH
1040 SCORE:    EQU     TOP1+07DDH
1050 STOCK:    EQU     TOP1+07DCH
1060 MALTI:    EQU     TOP1+00F5H
1100           ORG     09F7H
10000 ;
10010 ;---- MOJI HYOUJI ----
10020 ;
10030 MHYOUJ:   BIT     5,(IX+15)
10040           JR      Z,HMOJI
10050           LD      A,(IX+11)
10060           OR      A
10070           JR      NZ,ONH
10080           LD      A,(IX+2)
10090           OR      A
10100           JR      Z,OFFH
10110           DEC     (IX+2)
10120           JR      MJIRET
10130 OFFH:     LD      A,(IX+10)
10140           LD      (IX+2),A
10150           LD      A,1
10160           LD      (IX+11),A
10170           JR      HMOJI
10180 ONH:      LD      A,(IX+2)
10190           DEC     (IX+2)
10200           OR      A
10210           JR      NZ,HMOJI
10220           LD      A,(IX+9)
10230           LD      (IX+2),A
10240           XOR     A
10250           LD      (IX+11),A
10260           JR      MJIRET
10270           ;
10280 HMOJI:    LD      E,(IX+7)
10290           LD      D,0
10300           LD      (LIDAT+4),DE
10310           LD      H,(IX+4)
10320           LD      L,(IX+3)
10330 MJLOOP:   LD      A,(HL)
10340           OR      A
10350           JR      Z,MJIRET
10360           INC     HL
10370           LD      B,(HL)
10380           INC     HL
10390           LD      C,(HL)
10400           INC     HL
10410           CALL    MOJI
10420           JR      MJLOOP
10430           ;
10440 MJIRET:   LD      A,(IX+1)
10450           INC     (IX+1)
10460           CP      (IX+8)
10470           JP      Z,MALEND
10480           RET
10490           ;
10500 MOJI:     PUSH    HL
10510           CP      41H
10520           LD      D,30H
10530           JR      C,$+4
10540           LD      D,41H-10
10550           SUB     D
10560           ADD     A,A
10570           LD      HL,MOJIDAT
10580           ADD     A,L
10590           JR      NC,$+3
10600           INC     H
10610           LD      L,A
10620           LD      E,(HL)
10630           INC     HL
10640           LD      D,(HL)
10650           EX      DE,HL
10660           LD      A,B
10670           ADD     A,(IX+12)
10680           LD      B,A
10690           LD      A,C
10700           ADD     A,(IX+13)
10710           LD      C,A
10720           ;
10730           LD      A,(HL)
10740           ADD     A,A
10750           ADD     A,(HL)
10760           INC     HL
10770           INC     HL
10780           LD      E,A
10790           LD      D,0
10800           PUSH    HL
10810           ADD     HL,DE
10820           POP     DE
10830           DEC     DE
10840           DEC     DE
10850           DEC     DE
10860           ;
10870 LOOPMJ:   LD      A,(HL)
10880           ADD     A,A
10890           ADD     A,(HL)
10900           PUSH    BC
10910           PUSH    DE
10920           ADD     A,E
10930           JR      NC,$+3
10940           INC     D
10950           LD      E,A
10960           LD      A,(DE)
10970           INC     DE
10980           BIT     1,(IX+15)
10990           JR      Z,$+4
11000           SLA     A
11010           BIT     2,(IX+15)
11020           JR      Z,$+4
11030           SRA     A
11040           ADD     A,B
11050           LD      B,A
11060           LD      A,(DE)
11070           BIT     3,(IX+15)
11080           JR      Z,$+4
11090           SLA     A
11100           BIT     4,(IX+15)
11110           JR      Z,$+4
11120           SRA     A
11130           ADD     A,C
11140           LD      C,A
11150           LD      (LIDAT),BC
11160           POP     DE
11170           POP     BC
11180           INC     HL
11190           LD      A,(HL)
11200           ADD     A,A
11210           ADD     A,(HL)
11220           PUSH    BC
11230           PUSH    DE
11240           ADD     A,E
11250           JR      NC,$+3
11260           INC     D
11270           LD      E,A
11280           LD      A,(DE)
11290           INC     DE
11300           BIT     1,(IX+15)
11310           JR      Z,$+4
11320           SLA     A
11330           BIT     2,(IX+15)
11340           JR      Z,$+4
11350           SRA     A
11360           ADD     A,B
11370           LD      B,A
11380           LD      A,(DE)
11390           BIT     3,(IX+15)
11400           JR      Z,$+4
11410           SLA     A
11420           BIT     4,(IX+15)
11430           JR      Z,$+4
11440           SRA     A
11450           ADD     A,C
11460           LD      C,A
11470           LD      (LIDAT+2),BC
11480           POP     DE
11490           POP     BC
11500           CALL    LINE
11510           INC     HL
11520           LD      A,(HL)
11530           DEC     HL
11540           OR      A
11550           JR      NZ,LOOPMJ
11560           INC     HL
11570           INC     HL
11580           LD      A,(HL)
11590           OR      A
11600           JR      NZ,LOOPMJ
11610           POP     HL
11620           RET
11640 MOJIDAT:
11650 DEFW      M0,M1,M2,M3,M4,M5,M6
11660 DEFW      M7,M8,M9,MA,MB,MC,MD
11680 DEFW      ME,MF,MG,MH,MI,MJ,MK
11690 DEFW      ML,MM,MN,MO,MP,MQ,MR
11700 DEFW      MS,MT,MU,MV,MW,MX,MY
11705 DEFW      MZ
11870 ;
11875 ; MOJI POINT DATA
11876 ;
11880 MR:
11890 DEFB      6,0
11900 DEFB      -12, 16,  0
11910 DEFB      -12,-16,  0
11920 DEFB        0,-16,  0
11930 DEFB       12, -8,  0
11940 DEFB        0,  0,  0
11950 DEFB       12, 16,  0
11960 DEFB      1,2,3,4,5,6,0,0
11970 MO:
11980 DEFB      6,0
11990 DEFB        0,-16,  0
12000 DEFB      -12, -8,  0
12010 DEFB       12, -8,  0
12020 DEFB      -12,  8,  0
12030 DEFB       12,  8,  0
12040 DEFB        0, 16,  0
12050 DEFB      1,2,4,6,5,3,1,0,0
12060 MC:
12070 DEFB      6,0
12080 DEFB        0,-16,  0
12090 DEFB      -12, -8,  0
12100 DEFB       12, -8,  0
12110 DEFB      -12,  8,  0
12120 DEFB       12,  8,  0
12130 DEFB        0, 16,  0
12140 DEFB      3,1,2,4,6,5,0,0
12150 MK:
12160 DEFB      5,0
12170 DEFB      -12,-16,  0
12180 DEFB      -12,  0,  0
12190 DEFB      -12, 16,  0
12200 DEFB       12,-16,  0
12210 DEFB       12, 16,  0
12220 DEFB      1,3,0,4,2,5,0,0
12230 MI:
12240 DEFB      2,0
12250 DEFB        0,-16,  0
12260 DEFB        0, 16,  0
12270 DEFB      1,2,0,0
12280 MT:
12290 DEFB      4,0
12300 DEFB      -12,-16,  0
12310 DEFB       12,-16,  0
12320 DEFB        0,-16,  0
12330 DEFB        0, 16,  0
12340 DEFB      1,2,0,3,4,0,0
12350 MY:
12360 DEFB      4,0
12370 DEFB      -12,-16,  0
12380 DEFB       12,-16,  0
12390 DEFB        0,  0,  0
12400 DEFB        0, 16,  0
12410 DEFB      1,3,2,0,3,4,0,0
12420 MA:
12430 DEFB      5,0
12440 DEFB      -12, 16,  0
12450 DEFB       12, 16,  0
12460 DEFB       -8,  6,  0
12470 DEFB        8,  6,  0
12480 DEFB        0,-16,  0
12490 DEFB      1,5,2,0,3,4,0,0
12500 MB:
12510 DEFB      7,0
12520 DEFB      -12,-16,  0
12530 DEFB      -12, 16,  0
12540 DEFB        0, 16,  0
12550 DEFB       12,  8,  0
12560 DEFB        0,  0,  0
12570 DEFB       12, -8,  0
12580 DEFB        0,-16,  0
12590 DEFB      1,2,3,4,5,6,7,1,0,0
12600 MD:
12610 DEFB      6,0
12620 DEFB      -12,-16,  0
12630 DEFB      -12, 16,  0
12640 DEFB        0, 16,  0
12650 DEFB       12,  8,  0
12660 DEFB       12, -8,  0
12670 DEFB        0,-16,  0
12680 DEFB      1,2,3,4,5,6,1,0,0
12690 ME:
12700 DEFB      6,0
12710 DEFB      -11,-16,  0
12720 DEFB       11,-16,  0
12730 DEFB      -11,  0,  0
12740 DEFB       11,  0,  0
12750 DEFB      -11, 16,  0
12760 DEFB       11, 16,  0
12770 DEFB      2,1,5,6,0,3,4,0,0
12780 MF:
12790 DEFB      5,0
12800 DEFB      -12,-16,  0
12810 DEFB       12,-16,  0
12820 DEFB      -12,  0,  0
12830 DEFB        4,  0,  0
12840 DEFB      -12, 16,  0
12850 DEFB      2,1,5,0,3,4,0,0
12860 MG:
12870 DEFB      8,0
12880 DEFB       12, -8,  0
12890 DEFB        0,-16,  0
12900 DEFB      -12, -8,  0
12910 DEFB      -12,  8,  0
12920 DEFB        0, 16,  0
12930 DEFB       12,  8,  0
12940 DEFB       12,  4,  0
12950 DEFB        0,  4,  0
12960 DEFB      1,2,3,4,5,6,7,8,0,0
12970 MH:
12980 DEFB      6,0
12990 DEFB      -12,-16,  0
13000 DEFB       12,-16,  0
13010 DEFB      -12,  0,  0
13020 DEFB       12,  0,  0
13030 DEFB      -12, 16,  0
13040 DEFB       12, 16,  0
13050 DEFB      1,5,0,2,6,0,3,4,0,0
13060 MJ:
13070 DEFB      4,0
13080 DEFB       12,-16,  0
13090 DEFB       12,  8,  0
13100 DEFB        0, 16,  0
13110 DEFB      -12,  8,  0
13120 DEFB      1,2,3,4,0,0
13130 ML:
13140 DEFB      3,0
13150 DEFB      -12,-16,  0
13160 DEFB      -12, 16,  0
13170 DEFB       12, 16,  0
13180 DEFB      1,2,3,0,0
13190 MM:
13200 DEFB      5,0
13210 DEFB      -12, 16,  0
13220 DEFB       -8,-16,  0
13230 DEFB        0, 16,  0
13240 DEFB        8,-16,  0
13250 DEFB       12, 16,  0
13260 DEFB      1,2,3,4,5,0,0
13270 MN:
13280 DEFB      4,0
13290 DEFB      -12, 16,  0
13300 DEFB      -12,-16,  0
13310 DEFB       12, 16,  0
13320 DEFB       12,-16,  0
13330 DEFB      1,2,3,4,0,0
13340 MP:
13350 DEFB      6,0
13360 DEFB      -12, 16,  0
13370 DEFB      -12,-16,  0
13380 DEFB        0,-16,  0
13390 DEFB       12, -8,  0
13400 DEFB        0,  0,  0
13410 DEFB      -12,  0,  0
13420 DEFB      1,2,3,4,5,6,0,0
13430 MQ:
13440 DEFB      8,0
13450 DEFB        0,-16,  0
13460 DEFB      -12, -8,  0
13470 DEFB      -12,  8,  0
13480 DEFB        0, 16,  0
13490 DEFB       12,  8,  0
13500 DEFB       12, -8,  0
13510 DEFB        0,  8,  0
13520 DEFB       12, 16,  0
13530 DEFB      1,2,3,4,5,6,1,0
13540 DEFB      7,8,0,0
13550 MS:
13560 DEFB      6,0
13570 DEFB       12, -8,  0
13580 DEFB        0,-16,  0
13590 DEFB      -12, -8,  0
13600 DEFB       12,  8,  0
13610 DEFB        0, 16,  0
13620 DEFB      -12,  8,  0
13630 DEFB      1,2,3,4,5,6,0,0
13640 MU:
13650 DEFB      5,0
13660 DEFB      -12,-16,  0
13670 DEFB      -12,  8,  0
13680 DEFB        0, 16,  0
13690 DEFB       12,  8,  0
13700 DEFB       12,-16,  0
13710 DEFB      1,2,3,4,5,0,0
13720 MV:
13730 DEFB      3,0
13740 DEFB      -12,-16,  0
13750 DEFB        0, 16,  0
13760 DEFB       12,-16,  0
13770 DEFB      1,2,3,0,0
13780 MW:
13790 DEFB      5,0
13800 DEFB      -12,-16,  0
13810 DEFB       -8, 16,  0
13820 DEFB        0,-16,  0
13830 DEFB        8, 16,  0
13840 DEFB       12,-16,  0
13850 DEFB      1,2,3,4,5,0,0
13860 MX:
13870 DEFB      4,0
13880 DEFB      -12,-16,  0
13890 DEFB      -12, 16,  0
13900 DEFB       12,-16,  0
13910 DEFB       12, 16,  0
13920 DEFB      1,4,0,2,3,0,0
13930 MZ:
13940 DEFB      4,0
13950 DEFB      -12,-16,  0
13960 DEFB      -12, 16,  0
13970 DEFB       12,-16,  0
13980 DEFB       12, 16,  0
13990 DEFB      1,3,2,4,0,0
14000 M0:
14010 DEFB      6,0
14020 DEFB        0,-16,  0
14030 DEFB       -8, -8,  0
14040 DEFB       -8,  8,  0
14050 DEFB        0, 16,  0
14060 DEFB        8,  8,  0
14070 DEFB        8, -8,  0
14080 DEFB      1,2,3,4,5,6,1,0,0
14100 M1:
14110 DEFB      3,0
14120 DEFB       -4, -8,  0
14130 DEFB        0,-16,  0
14140 DEFB        0, 16,  0
14150 DEFB      1,2,3,0,0
14160 M2:
14170 DEFB      5,0
14180 DEFB       -8, -8,  0
14190 DEFB        0,-16,  0
14200 DEFB        8, -8,  0
14210 DEFB       -8, 16,  0
14220 DEFB        8, 16,  0
14230 DEFB      1,2,3,4,5,0,0
14240 M3:
14250 DEFB      7,0
14260 DEFB       -8, -8,  0
14270 DEFB        0,-16,  0
14280 DEFB        8, -8,  0
14290 DEFB        0,  0,  0
14300 DEFB        8,  8,  0
14310 DEFB        0, 16,  0
14320 DEFB       -8,  8,  0
14330 DEFB      1,2,3,4,5,6,7,0,0
14335 M4:
14340 DEFB      5,0
14350 DEFB        0,-16,  0
14360 DEFB       -8,  8,  0
14370 DEFB        8,  8,  0
14380 DEFB        4, -8,  0
14390 DEFB        4, 16,  0
14400 DEFB      1,2,3,0,4,5,0,0
14410 M5:
14420 DEFB      7,0
14430 DEFB        6,-16,  0
14440 DEFB       -8,-16,  0
14450 DEFB       -8, -4,  0
14460 DEFB        4, -4,  0
14470 DEFB        8,  8,  0
14480 DEFB        0, 16,  0
14490 DEFB       -8, 12,  0
14500 DEFB      1,2,3,4,5,6,7,0,0
14510 M6:
14520 DEFB      8,0
14530 DEFB        8, -8,  0
14540 DEFB        0,-16,  0
14550 DEFB       -8, -8,  0
14560 DEFB       -8,  8,  0
14570 DEFB        0, 16,  0
14580 DEFB        8,  8,  0
14590 DEFB        4,  0,  0
14600 DEFB       -8,  0,  0
14610 DEFB      1,2,3,4,5,6,7,8,0,0
14620 M7:
14630 DEFB      3,0
14640 DEFB       -8,-16,  0
14650 DEFB        8,-16,  0
14660 DEFB        0, 16,  0
14670 DEFB      1,2,3,0,0
14680 M8:
14690 DEFB      6,0
14700 DEFB        0,-16,  0
14710 DEFB       -8, -8,  0
14720 DEFB        8,  8,  0
14730 DEFB        0, 16,  0
14740 DEFB       -8,  8,  0
14750 DEFB        8, -8,  0
14760 DEFB      1,2,3,4,5,6,1,0,0
14770 M9:
14780 DEFB      8,0
14790 DEFB       -8,  8,  0
14800 DEFB        0, 16,  0
14810 DEFB        8,  8,  0
14820 DEFB        8, -8,  0
14830 DEFB        0,-16,  0
14840 DEFB       -8, -8,  0
14850 DEFB       -4,  0,  0
14860 DEFB        8,  0,  0
14870 DEFB      1,2,3,4,5,6,7,8,0,0
30000 ;
30010 ; MASTER POINT DATA
30020 ;
30030 MSDATA:
30040 DEFB      10,0
30050 DEFB      -24,  0, 20
30060 DEFB      -24,-18,-20
30070 DEFB      -24, 20,-20
30080 DEFB      -18,  0,-16
30090 DEFB       24,  0, 20
30100 DEFB       24,-18,-20
30110 DEFB       24, 20,-20
30120 DEFB       18,  0,-16
30130 DEFB        0,-16,-22
30140 DEFB        0,-10, 50
30150 DEFB      1,2,3,1,4,2,0,3,4,9
30160 DEFB      10,4,0,5,6,7,5,8,6,0
30170 DEFB      7,8,10,0,8,9,0,4,8,0,0
30180 ;
30181 ;---- WRITE LIFE GAGE ----
30182 ;
30190 WRLIFE:   PUSH    AF
30200           PUSH    HL
30210           LD      HL,0006H
30220           LD      (LIDAT+4),HL
30230           LD      H,178
30240           LD      L,20
30250           LD      (LIDAT+0),HL
30260           LD      L,39
30270           LD      (LIDAT+2),HL
30280           CALL    LINE
30290           LD      H,246
30300           LD      (LIDAT+0),HL
30310           LD      L,20
30320           LD      (LIDAT+2),HL
30330           CALL    LINE
30340           LD      H,180
30350           LD      L,30
30360           LD      (LIDAT+0),HL
30370           LD      H,244
30380           LD      (LIDAT+2),HL
30390           CALL    LINE
30400           ;
30410           LD      A,(LIFE)
30420           RLCA
30430           RLCA
30440           ADD     A,180
30450           LD      H,A
30460           LD      L,24
30470           LD      (LIDAT+0),HL
30480           LD      L,36
30490           LD      (LIDAT+2),HL
30500           LD      HL,0009H
30510           LD      (LIDAT+4),HL
30520           CALL    LINE
30580           ;
40030 WSCORE:   CALL    STRIGB
40040           JR      NZ,RETSC
40050           LD      HL,(SCORE)
40060           LD      IX,SCOREM+15
40070           CALL    CHTEN
40080           LD      A,(STOCK)
40090           ADD     A,2FH
40100           LD      (SCOREM+42),A
40110           LD      IX,MDSCOR
40120           CALL    MALTI
40130 RETSC:    POP     HL
40131           POP     AF
40135           RET
40140           ;
40150 SCOREM:   DEFB    'S',20,30,'C',35,30,'O',50,30,'R',65,30,'E',80,30
40160           DEFB     0,107,30,0,119,30,0,131,30,0,143,30,0,155,30
40170           DEFB    'L',20,50,'E',35,50,'F',50,50,'T',65,50,'3',107,50,0
40180           ;
40190 STRIGB:   PUSH    BC
40200           PUSH    DE
40210           LD      IY,(0FCC0H)
40220           LD      IX,00D8H
40230           LD      A,3
40240           CALL    001CH
40250           INC     A
40260           JR      Z,RETSTR
40270           LD      A,(0FBE5H+6)
40280           AND     00000100B
40290 RETSTR:   POP     DE
40300           POP     BC
40310           RET
40320           ;
40330 MDSCOR:   DEFB    1,0,0
40340           DEFW    SCOREM,MHYOUJ
40350           DEFB    8,1,0,0,0,0,0,0,00010101B
40360 ;
40365 ;---- CHANGE TEN ----
40366 ;
40370 CHTEN:    PUSH    DE
40380           LD      DE,10000
40390           CALL    DOWNGE
40400           LD      (IX+0),A
40410           LD      DE,1000
40420           CALL    DOWNGE
40430           LD      (IX+3),A
40440           LD      DE,100
40450           CALL    DOWNGE
40460           LD      (IX+6),A
40470           LD      DE,10
40480           CALL    DOWNGE
40490           LD      (IX+9),A
40500           LD      DE,1
40510           CALL    DOWNGE
40520           LD      (IX+12),A
40530           POP     DE
40540           RET
40550           ;
40560 DOWNGE:   XOR     A
40570           OR      A
40580           SBC     HL,DE
40590           JR      C,$+5
40600           INC     A
40610           JR      DOWNGE+1
40620           ADD     HL,DE
40630           ADD     A,30H
40640           RET
40650           ;
40660 END:      EQU     $
