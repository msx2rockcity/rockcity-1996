1000 TOP1:     EQU     0100H
1010 TOP2:     EQU     09F7H
1020 TOP3:     EQU     1032H
1030 MAIN:     EQU     TOP1+0056H
1040 MALEND:   EQU     TOP1+019EH
1050 MALRET:   EQU     TOP1+01A2H
1060 LIDAT:    EQU     TOP1+0432H
1070 JPTUCH:   EQU     TOP1+0338H
1080 KEY:      EQU     TOP1+0508H
1090 MOVE:     EQU     TOP1+05DEH
1100 RTURN:    EQU     TOP1+0603H
1110 DSET:     EQU     TOP1+064BH
1120 CLSPRI:   EQU     TOP1+068FH
1130 PALETE:   EQU     TOP1+069DH
1140 PLDAT:    EQU     TOP1+06D9H
1150 UNFADE:   EQU     TOP1+070AH
1160 FADE:     EQU     TOP1+072FH
1170 MHYOUJ:   EQU     TOP2+0000H
1180 STACK:    EQU     TOP1+07D0H
1190 SCROLL:   EQU     TOP1+07D2H
1200 SCOLOR:   EQU     TOP1+07D4H
1210 SWHICH:   EQU     TOP1+07D6H
1220 GAGE:     EQU     TOP1+07E1H
1230 LIFE:     EQU     TOP1+07DBH
1240 STOCK:    EQU     TOP1+07DCH
1250 DEADRT:   EQU     TOP1+07D9H
1260 CONTRT:   EQU     TOP1+07D7H
1270 MASTER:   EQU     TOP1+07E7H
1280 PORIDAT:  EQU     TOP1+07F7H
1290 MSDATA:   EQU     TOP2+04F8H
1300 SCORE:    EQU     TOP1+07DDH
1310 EXPTBL:   EQU     0FCC1H
1320 CALSLT:   EQU     001CH
1330 STRIG:    EQU     TOP3+0000H
1340 STICK:    EQU     TOP3+0026H
1350 DEAD:     EQU     TOP3+004CH
1360 MSSTR:    EQU     TOP3+00FBH
1370 TURBO:    EQU     TOP3+0167H
1380 TURBPT:   EQU     TOP3+01A2H
1390 CURE:     EQU     TOP3+01CFH
1400 CURPT1:   EQU     TOP3+0220H
1410 CURPT2:   EQU     TOP3+0247H
1420 TECHNO:   EQU     TOP3+029FH
1430 TECHPT:   EQU     TOP3+026EH
1440 PARTY:    EQU     TOP3+035BH
1450 PARPT1:   EQU     TOP3+0312H
1460 PARPT2:   EQU     TOP3+0337H
1470 RND:      EQU     TOP3+03BDH
1480 HOME:     EQU     TOP3+03CDH
1490 TUCH0:    EQU     TOP3+00A3H
1500 TUCH1:    EQU     TOP3+00A4H
1510 TUCH2:    EQU     TOP3+00B9H
1520 TUCH3:    EQU     TOP3+00D5H
1530 TUCH4:    EQU     TOP3+00EBH
1540 TUCH5:    EQU     TOP3+02E3H
1550 TUCH6:    EQU     TOP3+039CH
1560           ORG     2C68H
30000 ;
30010 ;---- STAGE4 PROGRAM ----
30020 ;
30030 STAGE4:   CALL    CLSPRI
30040           LD      (STACK),SP
30060           LD      A,00001000B
30070           LD      (SWHICH),A
30080           CALL    DSET
30090           DEFW    STAGM1,MHYOUJ
30100           DEFB    8,40,0,0,0,44
30110           DEFB    0,0,00010101B
30120           CALL    DSET
30130           DEFW    STAGM2,MHYOUJ
30140           DEFB    8,40,0,0,0,10
30150           DEFB    60,0,00000101B
30160           CALL    UNFADE
30170           LD      A,32
30180           CALL    MAIN
30190           CALL    FADE
30200           LD      A,8
30210           CALL    MAIN
30240           CALL    MSSTR
30250           ;
30260 CONT:     LD      HL,STAGD1
30270           LD      DE,SCROLL
30280           LD      BC,9
30290           LDIR
30300           LD      HL,JPDAT1
30310           LD      DE,JPTUCH
30320           LD      BC,32
30330           LDIR
30340           LD      A,13
30350           LD      (MASTER+13),A
30360           LD      A,24
30370           CALL    MAIN
30380          ;JP      BOSS
30390           LD      B,32
30400 LOOP0:    CALL    CHARA1
30410           CALL    CURE
30420           LD      A,3
30430           CALL    MAIN
30440           DJNZ    LOOP0
30450           CALL    CHARA6
30460           ;
30470           LD      B,128
30480 LOOP:     LD      HL,RETLOP
30490           PUSH    HL
30500           CALL    CURE
30520           CALL    TURBO
30530           LD      A,B
30540           CP      92
30550           JR      C,SJ1
30560           CALL    CHARA1
30570           CALL    RND
30580           CP      50
30590           JP      C,CHARA3
30600           CP      90
30610           JP      C,CHAR51
30620           CP      150
30630           JP      C,TECHNO
30640           CP      200
30650           JP      C,PARTY
30660           RET
30670           ;
30680 SJ1:      CP      70
30690           JR      C,SJ2
30700           CALL    CHARA1
30710           JP      CHARA4
30720           ;
30730 SJ2:      CP      48
30740           JR      C,SJ3
30750           CALL    CHARA1
30760           JP      CHAR51
30770           ;
30780 SJ3:      AND     15
30790           JP      Z,CHARA6
30800           CALL    CHARA1
30810           JP      C,PARTY
30820           CALL    RND
30830           CP      40
30840           JP      C,CHARA3
30850           CP      80
30860           JP      C,CHARA4
30870           CP      120
30880           JP      C,CHAR51
30890           CP      140
30900           JP      C,CHARA7
30910           CP      185
30920           JP      C,TECHNO
30930           CP      225
30940           JP      C,PARTY
30950           RET
30960           ;
30970 RETLOP:   LD      A,6
30980           CALL    MAIN
30990           DJNZ    LOOP
31000           ;
31010           LD      A,(SWHICH)
31020           AND     11111110B
31030           LD      (SWHICH),A
31040           LD      HL,CONT2
31050           LD      (CONTRT),HL
31055           ;
31060 CONT2:    LD      A,13
31070           LD      (MASTER+13),A
31080           LD      A,32
31090           CALL    MAIN
31100           CALL    CHARA5
31110           LD      A,24
31120           CALL    MAIN
31130           LD      B,128
31140 LOOP2:    CALL    TURBO
31150           CALL    CURE
31160           CALL    CURE
31180           LD      HL,RETLP2
31190           PUSH    HL
31200           LD      A,B
31210           AND     31
31220           CALL    Z,CHARA6
31230           LD      A,B
31240           AND     28
31250           RET     Z
31260           CALL    RND
31270           AND     1
31280           CALL    Z,CHARA1
31290           CALL    RND
31300           CP      35
31310           JP      C,CHARA3
31320           CP      80
31330           JP      C,CHARA4
31340           CP      125
31350           JP      C,CHAR51
31360           CP      145
31370           JP      C,CHARA7
31380           CP      185
31390           JP      C,CHRA72
31400           CP      230
31410           JP      C,TECHNO
31420           JP      PARTY
31430           ;
31440 RETLP2:   LD      A,B
31450           RLCA
31460           RLCA
31470           AND     3
31480           ADD     A,3
31490           CALL    MAIN
31500           DJNZ    LOOP2
31510           LD      A,32
31520           CALL    MAIN
31530           JP      BOSS
31540 ;
31550 ; STAGE4 DATA
31560 ;
31570 STAGD1:   DEFB    32,5,6,2
31580           DEFB    01011011B
31590           DEFW    CONT,DEAD
31600           ;
31610 JPDAT1:   DEFW    TUCH0,TUCH1
31620           DEFW    TUCH2,TUCH3
31630           DEFW    TUCH4,TUCH5
31640           DEFW    TUCH6,TUCH6
31650           DEFW    TUCH7,TUCH8
31660           DEFW    TUCH0,TUCH0
31670           DEFW    TUCH0,TUCH0
31680           DEFW    TUCH0,TUCH0
31690           ;
31700 STAGM1:   DEFB    'Z',60,80
31710           DEFB    'O',75,80
31720           DEFB    'N',90,80
31730           DEFB    'E',105,80
31740           DEFB    '4',120,80,0
31750 STAGM2:   DEFB    'V',69,80
31760           DEFB    'O',86,80
31770           DEFB    'L',103,80
31780           DEFB    'C',120,80
31790           DEFB    'A',137,80
31800           DEFB    'N',154,80
31810           DEFB    'O',171,80,0
31820 ;
31830 ; STAGE 1 -- CHARACTER 1
31840 ;
31850 CHARA1:   CALL    RND
31860           AND     127
31870           ADD     A,90
31880           LD      (CHARD1+4),A
31890           CALL    RND
31900           AND     00000010B
31910           LD      (CHARD1+12),A
31920           CALL    DSET
31930 CHARD1:   DEFW    CHAPD1,CHARP1
31940           DEFB    0,235,180,0,0,0
31950           DEFB    8,2,00000000B
31960           RET
31970           ;
31980 CHAPD1:   DEFB    14,5
31990           DEFB      0,-60, -6
32000           DEFB      0,-25,-12
32010           DEFB      0,  0,-25
32020           DEFB     -6,-60,  5
32030           DEFB    -12,-25, 10
32040           DEFB    -25,  0, 20
32050           DEFB      6,-60,  5
32060           DEFB     12,-25, 10
32070           DEFB     25,  0, 20
32080           DEFB      0,-42, -9
32090           DEFB     -9,-42,  8
32100           DEFB      9,-42,  8
32110           DEFB    -12,-12,  8
32120           DEFB     12,-12,  8
32130           DEFB    1,2,3,0,4,5,6,0
32140           DEFB    7,8,9,0,1,4,7,1,0,0
32150           ;
32160 CHARP1:   LD      A,(IX+9)
32170           SUB     16
32180           LD      (IX+9),A
32190           LD      A,(IX+15)
32200           AND     00000010B
32210           RET     Z
32220           CALL    RND
32230           AND     15
32240           CALL    Z,CHARA2
32250           RET
32260 ;
32270 ; STAGE 4 -- CHARACTER 2
32280 ;
32290 CHARA2:   LD      A,(IX+7)
32300           LD      (CHARD2+4),A
32310           LD      (CHAR22+4),A
32320           LD      (CHAR23+4),A
32330           LD      A,(IX+9)
32340           LD      (CHARD2+6),A
32350           LD      (CHAR22+6),A
32360           LD      (CHAR23+6),A
32370           CALL    DSET
32380 CHARD2:   DEFW    CHAPD2,CHRP21
32390           DEFB    0,112,0,0,0,0
32400           DEFB    8,1,00000000B
32410           CALL    DSET
32420 CHAR22:   DEFW    CHAPD2,CHRP22
32430           DEFB    0,112,0,0,0,0
32440           DEFB    8,1,00000000B
32450           CALL    DSET
32460 CHAR23:   DEFW    CHAPD2,CHRP23
32470           DEFB    0,112,0,0,0,0
32480           DEFB    8,1,00000000B
32490           RET
32500           ;
32510 CHAPD2:   DEFB    4,0
32520           DEFB    -12,  8, -8
32530           DEFB     12,  8, -8
32540           DEFB      0,  8, 12
32550           DEFB      0,-13,  0
32560           DEFB    1,2,3,1,4,2,0
32570           DEFB    4,3,0,0
32580           ;
32590 CHRP21:   CALL    CHARP2
32600           CALL    MOVE
32610           DEFB    4,0,2,0,0,0
32620           ;
32630 CHRP22:   CALL    CHARP2
32640           CALL    MOVE
32650           DEFB    -4,0,2,0,0,0
32660           ;
32670 CHRP23:   CALL    CHARP2
32680           CALL    MOVE
32690           DEFB    0,0,-6,0,0,0
32700           ;
32710 CHARP2:   LD      A,(IX+1)
32720           INC     (IX+1)
32730           OR      A
32740           RET     Z
32750           CP      8
32760           JR      NC,CJ2
32770           LD      B,A
32780           LD      A,-64
32790           SRA     A
32800           DJNZ    $-2
32810           ADD     A,(IX+8)
32820           JP      NC,MALEND
32830           LD      (IX+8),A
32840           RET
32850 CJ2:      SUB     7
32860           LD      B,A
32870           LD      A,2
32880           RLCA
32890           DJNZ    $-1
32900           ADD     A,(IX+8)
32910           JP      C,MALEND
32920           LD      (IX+8),A
32930           RET
32940 ;
32950 ; STAGE 1 -- CHARACTER 3
32960 ;
32970 CHARA3:   CALL    RND
32980           LD      (CHARD3+4),A
32990           CALL    RND
33000           AND     127
33010           ADD     A,127
33020           LD      (CHARD3+6),A
33030           CALL    DSET
33040 CHARD3:   DEFW    CHAPD3,CHARP3
33050           DEFB    0,127,0,0,0,0
33060           DEFB    8,2,00000010B
33070           RET
33080           ;
33090 CHARP3:   LD      A,(IX+7)
33100           XOR     15
33110           LD      (IX+7),A
33120           LD      A,(IX+13)
33130           XOR     1
33140           LD      (IX+13),A
33150           LD      A,(IX+9)
33160           SUB     12
33170           JP      C,MALEND
33180           LD      (IX+9),A
33190           LD      A,(IX+1)
33200           INC     (IX+1)
33210           AND     8
33220           RET     NZ
33230           LD      A,(IX+15)
33240           XOR     1
33250           LD      (IX+15),A
33260           RET
33270           ;
33280 CHAPD3:   DEFB    9,0
33290           DEFB     -5,-60,  0
33300           DEFB      5,-45,  0
33310           DEFB     -5,-30,  0
33320           DEFB      5,-15,  0
33330           DEFB     -5,  0,  0
33340           DEFB      5, 15,  0
33350           DEFB     -5, 30,  0
33360           DEFB      5, 45,  0
33370           DEFB     -5, 60,  0
33380           DEFB    1,2,3,4,5,6,7,8,9,0,0
40000 ;
40010 ; STAGE 4 -- BOSS
40020 ;
40030 BOSS:     CALL    DSET
40040           DEFW    ATACKM,MHYOUJ
40050           DEFB    9,16,1,1,0
40060           DEFB    72,80,0,00100101B
40070           LD      A,17
40080           CALL    MAIN
40090           CALL    CLSPRI
40100           CALL    DSET
40110           DEFW    COREPT,CORERP
40120           DEFB    128,128,64,0,0,0
40130           DEFB    9,9,00000000B
40135           CALL    MAHOU
40140           CALL    DSET
40150           DEFW    BOSPD2,BOSSRP
40160           DEFB    128,128,64,0,0,0
40170           DEFB    8,8,00000000B
40180           CALL    DSET
40190           DEFW    BOSPD2,BOSSRP
40200           DEFB    128,128,64,0,11,0
40210           DEFB    8,8,00000000B
40220           CALL    DSET
40230           DEFW    BOSPD2,BOSSRP
40240           DEFB    128,128,64,0,22,0
40250           DEFB    8,8,00000000B
40260 BOSLOP:   CALL    RND
40270           AND     15
40280           CALL    Z,CHARA4
40290           LD      A,1
40300           CALL    MAIN
40310           LD      A,(PORIDAT+1)
40320           OR      A
40330           JR      Z,BOSLOP
40335           ;
40340           LD      HL,HOME
40350           LD      (MASTER+5),HL
40360 LOOP8:    LD      A,1
40370           CALL    MAIN
40380           LD      A,(MASTER+1)
40390           OR      A
40400           JR      NZ,LOOP8
40405           ;
40410           LD      HL,CORRP2
40420           LD      (PORIDAT+5),HL
40430           LD      A,80
40440           CALL    MAIN
40470           ;
40520 BOSM:     CALL    DSET
40530           DEFW    STAGM1,MHYOUJ
40540           DEFB    8,24,0,0,0,38,8
40550           DEFB    0,00000101B
40560           CALL    DSET
40570           DEFW    CLEARM,MHYOUJ
40580           DEFB    8,24,0,0,0,38,134
40590           DEFB    0,00000101B
40600           LD      A,28
40610           CALL    MAIN
40620           CALL    DSET
40630           DEFW    MISSIM,MJIPTR
40640           DEFB    10,46,0,0,0,70,55
40650           DEFB    0,00000101B
40660           CALL    DSET
40670           DEFW    ENDM,MJIPTR
40680           DEFB    10,46,0,0,0,14,80
40690           DEFB    0,00000101B
40700           LD      A,38
40710           CALL    MAIN
40720           CALL    FADE
40730           LD      A,24
40740           CALL    MAIN
40750           RET
40880           ;
40890 TUCH7:    CALL    TUCH2
40900           LD      A,(MASTER+9)
40910           XOR     127
40920           ADD     A,17
40930           LD      (MASTER+9),A
40940           RET
40950           ;
40960 TUCH8:    LD      A,32
40970           LD      (MASTER+8),A
40980           LD      A,(IX+13)
40990           CP      9
41000           JR      NZ,$+8
41010           LD      A,8
41020           LD      (IX+13),A
41030           RET
41040           CP      8
41050           JR      NZ,$+8
41060           LD      A,6
41070           LD      (IX+13),A
41080           RET
41090           XOR     A
41100           LD      (IX+2),A
41110           INC     A
41120           LD      (IX+1),A
41125           LD      A,00001000B
41126           LD      (IX+15),A
41130           RET
41140           ;
41150 COREPT:   DEFB    6,0
41160           DEFB      0,-24,  0
41170           DEFB      0, 24,  0
41180           DEFB      0,  0,-13
41190           DEFB    -13,  0,  0
41200           DEFB      0,  0, 13
41210           DEFB     13,  0,  0
41220           DEFB    1,4,2,6,1,0,5,4,3,6,5,0
41230           DEFB    1,3,2,5,1,0,0
41240           ;
41250 ATACKM:  DEFB    'A',9,0,'T',32,0,'A',55,0,'C',79,0,'K',106,0,0
41260 CLEARM:  DEFB    'C',60,30,'L',75,30,'E',90,30,'A',105,30,'R',120,30,0
41270 MISSIM:  DEFB    'M',20,30,'I',31,30,'S',42,30,'S',57,30,'I',68,30
41280          DEFB    'O',79,30,'N',94,30,0
41290 ENDM:    DEFB    'E',98,90,'N',113,90,'D',128,90,0
41300 ;
41310 ; STAGE 4 -- CHARACTER 4
41320 ;
41330 CHARA4:   CALL    RND
41340           AND     127
41350           ADD     A,64
41360           LD      (CHARD4+4),A
41370           CALL    RND
41380           AND     127
41390           ADD     A,64
41400           LD      (CHARD4+5),A
41410           CALL    RND
41420           AND     63
41430           ADD     A,32
41440           LD      (CHARD4+6),A
41450           CALL    RND
41460           AND     7
41470           ADD     A,A
41480           LD      HL,RNDPT4
41490           ADD     A,L
41500           JR      NC,$+3
41510           INC     H
41520           LD      L,A
41530           LD      E,(HL)
41540           INC     HL
41550           LD      D,(HL)
41560           EX      DE,HL
41570           LD      (CHARD4+2),HL
41580           CALL    DSET
41590 CHARD4:   DEFW    CHAPD4,CHARP4
41600           DEFB    0,0,0,0,0,0
41610           DEFB    8,1,00011000B
41620           RET
41630           ;
41640 CHAPD4:   DEFB    6,0
41650           DEFB      0,-18,  0
41660           DEFB      0, 18,  0
41670           DEFB      0,  0,-18
41680           DEFB    -18,  0,  0
41690           DEFB      0,  0, 18
41700           DEFB     18,  0,  0
41710           DEFB    1,4,2,6,1,0,5,4,3,6,5,0
41720           DEFB    1,3,2,5,1,0,0
41730           ;
41740 RNDPT4:   DEFW    CHRP41,CHRP42,CHRP43,CHRP44
41750           DEFW    CHRP45,CHRP46,CHRP47,CHRP48
41760           ;
41770 CHARP4:   LD      A,(IX+13)
41780           XOR     1
41790           LD      (IX+13),A
41800           LD      A,(IX+1)
41810           INC     (IX+1)
41820           CP      2
41830           RET     NC
41840           POP     HL
41850           CP      1
41860           RET     C
41870           XOR     A
41880           LD      (IX+15),A
41890           RET
41900           ;
41910 CHRP41:   CALL    CHARP4
41920           CALL    MOVE
41930           DEFB    18,2,-8,0,0,0
41940           ;
41950 CHRP42:   CALL    CHARP4
41960           CALL    MOVE
41970           DEFB    -10,3,-15,0,0,0
41980           ;
41990 CHRP43:   CALL    CHARP4
42000           CALL    MOVE
42010           DEFB    11,-12,-8,0,0,0
42020           ;
42030 CHRP44:   CALL    CHARP4
42040           CALL    MOVE
42050           DEFB    12,21,-8,0,0,0
42060           ;
42070 CHRP45:   CALL    CHARP4
42080           CALL    MOVE
42090           DEFB    -8,13,-12,0,0,0
42100           ;
42110 CHRP46:   CALL    CHARP4
42120           CALL    MOVE
42130           DEFB    -18,-12,1,0,0,0
42140           ;
42150 CHRP47:   CALL    CHARP4
42160           CALL    MOVE
42170           DEFB    6,-18,-7,0,0,0
42180           ;
42190 CHRP48:   CALL    CHARP4
42200           CALL    MOVE
42210           DEFB    -10,-18,-16,0,0,0
42220 ;
42230 ; STAGE 4 -- CHARACTER 5
42240 ;
42250 CHAPD5:   DEFB    12,4
42260           DEFB    -10,-48,-10
42270           DEFB    -10, 48,-10
42280           DEFB     10,-48,-10
42290           DEFB     10, 48,-10
42300           DEFB    -10,-48, 10
42310           DEFB    -10, 48, 10
42320           DEFB     10,-48, 10
42330           DEFB     10, 48, 10
42340           DEFB    -10,  0,-10
42350           DEFB    -10,  0, 10
42360           DEFB     10,  0,-10
42370           DEFB     10,  0, 10
42380           DEFB    1,2,4,3,1,5,7,8,6,5,0
42390           DEFB    6,2,0,8,4,0,7,3,0,0
42400           ;
42410 CHARP5:   LD      A,(IX+9)
42420           SUB     16
42430           LD      (IX+9),A
42440           LD      A,(IX+13)
42450           XOR     1
42460           LD      (IX+13),A
42470           LD      A,(IX+1)
42480           OR      A
42490           JR      NZ,UP
42500           LD      A,(IX+8)
42510           ADD     A,32
42520           CP      200
42530           JR      NC,$+6
42540           LD      (IX+8),A
42550           RET
42560           LD      A,1
42570           LD      (IX+1),A
42580           RET
42590 UP:       LD      A,(IX+8)
42600           SUB     32
42610           CP      50
42620           JR      C,$+6
42630           LD      (IX+8),A
42640           RET
42650           XOR     A
42660           LD      (IX+1),A
42670           RET
42680           ;
42690 CHAR52:   LD      (CHARD5+4),A
42700           CALL    RND
42710           AND     127
42720           ADD     A,64
42730           AND     11111000B
42740           LD      (CHARD5+5),A
42750           CALL    DSET
42760 CHARD5:   DEFW    CHAPD5,CHARP5
42770           DEFB    128,128,240,0,0,0
42780           DEFB    9,2,00000000B
42790           RET
42800           ;
42810 CHARA5:   PUSH    BC
42820           LD      B,8
42830           LD      C,32
42840           LD      A,16
42850 DJ5:      ADD     A,C
42860           PUSH    AF
42870           CALL    CHAR52
42880           POP     AF
42890           DJNZ    DJ5
42900           POP     BC
42910           RET
42920           ;
42930 CHAR51:   CALL    RND
42940           CALL    CHAR52
42950           RET
42960 ;
42970 ; STAGE 4 -- CHARACTER 6
42980 ;
42990 CHAPD6:   DEFB    10,4
43000           DEFB     15,-15,-15
43010           DEFB     15,-15, 15
43020           DEFB     15,120,  0
43030           DEFB    -15,-15,-15
43040           DEFB    -15,-15, 15
43050           DEFB    -15,120,  0
43060           DEFB    -15, 40,-10
43070           DEFB    -15, 80, -5
43080           DEFB     15, 40,-10
43090           DEFB     15, 80, -5
43100           DEFB    1,2,3,1,4,5,6,4,0
43110           DEFB    2,5,0,3,6,0,0
43120           ;
43130 CHARP6:   LD      A,(IX+1)
43140           INC     (IX+1)
43150           CP      3
43160           JR      NC,$+11
43170           CALL    MOVE
43180           DEFB    0,5,-10,0,-1,0
43190           CP      6
43200           JR      NC,$+11
43210           CALL    MOVE
43220           DEFB    0,-5,-10,0,1,0
43230           CP      9
43240           JR      NC,$+11
43250           CALL    MOVE
43260           DEFB    0,5,-10,0,1,0
43270           CP      12
43280           JR      NC,$+11
43290           CALL    MOVE
43300           DEFB    0,-5,-10,0,-1,0
43310           XOR     A
43320           LD      (IX+1),A
43330           JR      CHARP6
43340           ;
43350 CHARA6:   CALL    RND
43360           AND     127
43370           ADD     A,64
43380           LD      (CHARD6+4),A
43390           ADD     A,30
43400           LD      (CHRD62+4),A
43410           CALL    DSET
43420 CHARD6:   DEFW    CHAPD6,CHARP6
43430           DEFB    50,130,225,0,0,0
43440           DEFB    8,2,00000000B
43450           CALL    DSET
43460 CHRD62:   DEFW    CHAPD6,CHARP6
43470           DEFB    80,130,225,0,0,16
43480           DEFB    8,2,00000000B
43490           RET
43500 ;
43510 ; STAGE 4 -- CHARACTER 7
43520 ;
43530 CHARA7:   CALL    RND
43540           AND     7
43550           LD      (CHARD7+8),A
43560           CALL    DSET
43570 CHARD7:   DEFW    CHAPD5,CHARP7
43580           DEFB    55,128,240,0,0,0
43590           DEFB    8,2,00000000B
43600           RET
43610           ;
43620 CHARP7:   CALL    RTURN
43630           DEFB    128,128,128,3,0,0
43640           CALL    MOVE
43650           DEFB    0,0,-12,-3,0,0
43660           ;
43670 CHRA72:   CALL    RND
43680           AND     127
43690           ADD     A,64
43700           LD      (CHRD72+4),A
43710           CALL    RND
43720           AND     127
43730           ADD     A,64
43740           LD      (CHRD72+5),A
43750           CALL    RND
43760           AND     2
43770           LD      A,8
43780           JR      Z,$+3
43790           XOR     A
43800           LD      (CHRD72+7),A
43810           CALL    DSET
43820 CHRD72:   DEFW    CHAPD5,CHRP72
43830           DEFB    0,0,255,0,0,0
43840           DEFB    8,2,00000000B
43850           RET
43860           ;
43870 CHRP72:   LD      A,(IX+9)
43880           SUB     42
43890           LD      (IX+9),A
43900           LD      A,(IX+13)
43910           XOR     1
43920           LD      (IX+13),A
43930           RET
43940 ;
43950 ; STAGE4 -- BOSS
43960 ;
43970 BOSSRP:   LD      A,(IX+13)
43980           XOR     1
43990           LD      (IX+13),A
44000           LD      A,(PORIDAT+1)
44010           OR      A
44020           JR      Z,$+12
44030           XOR     A
44040           LD      (IX+0),A
44050           LD      A,00011000B
44060           LD      (IX+15),A
44070           RET
44080 BOSRJ:    LD      A,(IX+1)
44090           INC     (IX+1)
44100           CP      8
44110           JR      NC,$+11
44120           CALL    MOVE
44130           DEFB    0,0,0H,3,0,0
44140           CP      40
44150           JR      NC,$+11
44160           CALL    MOVE
44170           DEFB    0,0,0,0,3,0
44180           CP      72
44190           JR      NC,$+11
44200           CALL    MOVE
44210           DEFB    0,0,0,0,0,3
44220           CP      88
44230           JR      NC,$+11
44240           CALL    MOVE
44250           DEFB    0,0,0,2,2,2
44260           XOR     A
44270           LD      (IX+1),A
44280           JR      BOSRJ
44290           ;
44300 BOSPD2:   DEFB    8,0
44310           DEFB    -40,0F6H,40
44320           DEFB    -40,0F6H,60
44330           DEFB    -40,0AH,40
44340           DEFB    -40,0AH,60
44350           DEFB    40,0F6H,40
44360           DEFB    40,0F6H,60
44370           DEFB    40,0AH,40
44380           DEFB    40,0AH,60
44390           DEFB    1,2,4,3,7,5,1,3,0
44400           DEFB    5,6,8,7,0,2,6,0,4,8,0,0
44410           ;
44420 CORERP:   INC     (IX+12)
44430           RET
44440           ;
44450 CORRP2:   INC     (IX+12)
44455           INC     (IX+8)
44456           LD      A,(IX+13)
44457           XOR     15
44458           LD      (IX+13),A
44460           LD      A,(IX+1)
44470           INC     (IX+1)
44480           CP      40
44490           JR      NC,COJ1
44500           AND     3
44510           LD      A,00011000B
44520           JR      Z,$+4
44530           LD      A,00001000B
44540           LD      (IX+15),A
44550           RET
44560 COJ1:     XOR     A
44570           LD      (IX+0),A
44580           LD      A,00011000B
44590           LD      (IX+15),A
44600           RET
60400 ;
60410 ; MAHOUJIN
60420 ;
60430 MAHOU:    CALL    DSET
60440           DEFW    MAHOPD,DEMO21
60450           DEFB    128,255,128,0,0,0
60460           DEFB    5,0,00101000B
60470           RET
60540           ;
60730 MAHOPD:   DEFB    7,0
60740           DEFB      0,  0,  0
60750           DEFB   -104,  0,-60
60760           DEFB   -104,  0, 60
60770           DEFB      0,  0,120
60780           DEFB    104,  0, 60
60790           DEFB    104,  0,-60
60800           DEFB      0,  0,-120
60810           DEFB    2,3,4,5,6,7,2,0
60820           DEFB    2,4,6,2,0,3,5,7,3,0,0
60830           ;
60840 DEMO21:   LD      A,(PORIDAT+1)
60850           OR      A
60860           RET     Z
60870           LD      HL,DEMO22
60880           LD      (IX+5),L
60890           LD      (IX+6),H
60900           RET
60910           ;
60911 DEMO22:   LD      A,(PORIDAT+0)
60912           OR      A
60913           JR      Z,DEMJ
60920           INC     (IX+12)
60930           LD      A,(IX+13)
60940           XOR     15
60950           LD      (IX+13),A
60960           RET
60970 DEMJ:     LD      A,(IX+1)
60980           INC     (IX+1)
60990           CP      8
61000           JR      NC,$+8
61010           LD      A,7
61020           LD      (IX+13),A
61030           RET
61040           CP      16
61050           JR      NC,$+8
61060           LD      A,5
61070           LD      (IX+13),A
61080           RET
61090           CP      24
61100           JP      NC,MALEND
61110           LD      A,4
61120           LD      (IX+13),A
61130           RET
61140           ;
61150 MJIPTR:   LD      A,(IX+7)
61160           XOR     15
61170           LD      (IX+7),A
61180           JP      MHYOUJ
61190           ;
61200 END:      EQU     $
