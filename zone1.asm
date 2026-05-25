10000 TOP1:     EQU     0100H
10010 TOP2:     EQU     09F7H
10020 TOP3:     EQU     1032H
10030 MAIN:     EQU     TOP1+0056H
10040 MALEND:   EQU     TOP1+019EH
10050 MALRET:   EQU     TOP1+01A2H
10060 LIDAT:    EQU     TOP1+0432H
10070 JPTUCH:   EQU     TOP1+0338H
10080 KEY:      EQU     TOP1+0508H
10090 MOVE:     EQU     TOP1+05DEH
10100 RTURN:    EQU     TOP1+0603H
10110 DSET:     EQU     TOP1+064BH
10120 CLSPRI:   EQU     TOP1+068FH
10130 PALETE:   EQU     TOP1+069DH
10140 PLDAT:    EQU     TOP1+06D9H
10150 UNFADE:   EQU     TOP1+070AH
10160 FADE:     EQU     TOP1+072FH
10170 MHYOUJ:   EQU     TOP2+0000H
10180 STACK:    EQU     TOP1+07D0H
10190 SCROLL:   EQU     TOP1+07D2H
10200 SCOLOR:   EQU     TOP1+07D4H
10210 SWHICH:   EQU     TOP1+07D6H
10220 GAGE:     EQU     TOP1+07E1H
10230 LIFE:     EQU     TOP1+07DBH
10240 STOCK:    EQU     TOP1+07DCH
10250 DEADRT:   EQU     TOP1+07D9H
10260 CONTRT:   EQU     TOP1+07D7H
10270 MASTER:   EQU     TOP1+07E7H
10280 PORIDAT:  EQU     TOP1+07F7H
10290 MSDATA:   EQU     TOP2+04F8H
10300 SCORE:    EQU     TOP1+07DDH
10310 EXPTBL:   EQU     0FCC1H
10320 CALSLT:   EQU     001CH
10330 STRIG:    EQU     TOP3+0000H
10340 STICK:    EQU     TOP3+0026H
10350 DEAD:     EQU     TOP3+004CH
10360 MSSTR:    EQU     TOP3+00FBH
10370 TURBO:    EQU     TOP3+0167H
10380 TURBPT:   EQU     TOP3+01A2H
10390 CURE:     EQU     TOP3+01CFH
10400 CURPT1:   EQU     TOP3+0220H
10410 CURPT2:   EQU     TOP3+0247H
10420 TECHNO:   EQU     TOP3+029FH
10430 TECHPT:   EQU     TOP3+026EH
10440 PARTY:    EQU     TOP3+035BH
10450 PARPT1:   EQU     TOP3+0312H
10460 PARPT2:   EQU     TOP3+0337H
10470 RND:      EQU     TOP3+03BDH
10480 HOME:     EQU     TOP3+03CDH
10490 TUCH0:    EQU     TOP3+00A3H
10500 TUCH1:    EQU     TOP3+00A4H
10510 TUCH2:    EQU     TOP3+00B9H
10520 TUCH3:    EQU     TOP3+00D5H
10530 TUCH4:    EQU     TOP3+00EBH
10540 TUCH5:    EQU     TOP3+02E3H
10550 TUCH6:    EQU     TOP3+039CH
10600           ORG     1B0BH
10610 ;
10620 ;---- STAGE1 PROGRAM ----
10630 ;
10640 STAGE1:   CALL    CLSPRI
10641           LD      (STACK),SP
10650           LD      A,00001000B
10660           LD      (SWHICH),A
10670           CALL    DSET
10680           DEFW    STAGM1,MHYOUJ
10690           DEFB    11,40,0,0,0,44
10700           DEFB    0,0,00010101B
10710           CALL    DSET
10720           DEFW    STAGM2,MHYOUJ
10730           DEFB    11,40,0,0,0,40
10740           DEFB    50,0,00010001B
10750           CALL    UNFADE
10760           LD      A,32
10770           CALL    MAIN
10780           CALL    FADE
10790           LD      A,8
10800           CALL    MAIN
10810           CALL    MSSTR
10820           ;
10830 CONT:     LD      HL,STAGD1
10840           LD      DE,SCROLL
10850           LD      BC,9
10860           LDIR
10870           LD      HL,JPDAT1
10880           LD      DE,JPTUCH
10890           LD      BC,32
10900           LDIR
10910           LD      A,24
10920           CALL    MAIN
10930          ;JP      BOSS
10940           LD      B,192
10950 LOOP:     LD      HL,RETLOP
10960           PUSH    HL
10970           CALL    RND
10980           CP      90
10990           JP      C,CHARA1
11000           CP      150
11010           JP      C,CHARA2
11020           CP      200
11030           JP      C,CHARA3
11040           CP      240
11050           JP      C,TECHNO
11060           JP      PARTY
11070 RETLOP:   CALL    TURBO
11080           CALL    CURE
11090           LD      A,B
11100           RLCA
11110           RLCA
11120           AND     3
11130           INC     A
11140           INC     A
11150           CALL    MAIN
11160           DJNZ    LOOP
11170           ;
11180           LD      A,(SWHICH)
11190           AND     11111110B
11200           LD      (SWHICH),A
11210           LD      HL,CONT2
11220           LD      (CONTRT),HL
11230 CONT2:    LD      A,28
11240           CALL    MAIN
11250           LD      B,40
11260 LOOP2:    CALL    CHARA3
11270           CALL    CHARA3
11280           LD      A,2
11290           CALL    MAIN
11300           DJNZ    LOOP2
11310           LD      B,50
11320 LOOP3:    CALL    CHARA1
11330           CALL    CHARA1
11340           CALL    CURE
11350           CALL    TURBO
11360           LD      A,2
11370           CALL    MAIN
11380           DJNZ    LOOP3
11390           LD      A,16
11400           CALL    MAIN
11410           JP      BOSS
11420 ;
11430 ; STAGE1 DATA
11440 ;
11450 STAGD1:   DEFB    32,5,11,2
11460           DEFB    01011011B
11470           DEFW    CONT,DEAD
11480           ;
11490 JPDAT1:   DEFW    TUCH0,TUCH1
11500           DEFW    TUCH2,TUCH3
11510           DEFW    TUCH4,TUCH5
11520           DEFW    TUCH6,TUCH6
11530           DEFW    TUCH7,TUCH8
11540           DEFW    TUCH0,TUCH0
11550           DEFW    TUCH0,TUCH0
11560           DEFW    TUCH0,TUCH0
11570           ;
11580 STAGM1:   DEFB    'Z',60,80
11590           DEFB    'O',75,80
11600           DEFB    'N',90,80
11610           DEFB    'E',105,80
11620           DEFB    '1',120,80,0
11630 STAGM2:   DEFB    'P',30,80
11640           DEFB    'L',60,80
11650           DEFB    'A',90,80
11660           DEFB    'N',120,80
11670           DEFB    'E',150,80,0
11680 ;
11690 ; STAGE 1 -- CHARACTER 1
11700 ;
11710 CHARA1:   CALL    RND
11720           CP      186
11730           JR      NC,$-5
11740           ADD     A,38
11750           LD      (CHARD1+4),A
11760           CALL    RND
11770           CP      196
11780           JR      NC,$-5
11790           ADD     A,44
11800           LD      (CHARD1+5),A
11810           CALL    DSET
11820 CHARD1:   DEFW    CHAPT1,CHAMV1
11830           DEFB    0,0,250,0,0,0
11840           DEFB    10,1,00000000B
11850           RET
11860           ;
11870 CHAMV1:   CALL    MOVE
11880           DEFB    0,0,-32,0,0,-2
11890           ;
11900 CHAPT1:   DEFB    4,0
11910           DEFB    -32, 18, 18
11920           DEFB     32, 18, 18
11930           DEFB      0,-36, 18
11940           DEFB      0,  0,-36
11950           DEFB    1,2,3,1,4,2,0
11960           DEFB    4,3,0,0
11970 ;
11980 ; STAGE 2 -- CHARACTER 2
11990 ;
12000 CHARA2:   CALL    RND
12010           AND     127
12020           ADD     A,64
12030           LD      (CHARD2+4),A
12040           CALL    RND
12050           AND     127
12060           ADD     A,64
12070           LD      (CHARD2+5),A
12080           CALL    DSET
12090 CHARD2:   DEFW    CHAPT2,CHAMV2
12100           DEFB    0,0,255,0,0,0
12110           DEFB    2,2,00000000B
12120           RET
12130           ;
12140 CHAPT2:   DEFB    11,3
12150           DEFB    -12,-48,-12
12160           DEFB    -12,-48, 12
12170           DEFB     12,-48, 12
12180           DEFB     12,-48,-12
12190           DEFB    -12, 48,-12
12200           DEFB    -12, 48, 12
12210           DEFB     12, 48, 12
12220           DEFB     12, 48,-12
12230           DEFB      0, 24,  0
12240           DEFB      0,-24,  0
12250           DEFB      0,  0,  0
12260           DEFB    1,2,3,4,1,5,6
12270           DEFB    7,8,5,0,4,8,0
12280           DEFB    3,7,0,2,6,0,0
12290           ;
12300 CHAMV2:   CALL    MOVE
12310           DEFB    0,0,-16,2,0,0
12320 ;
12330 ; STAGE 1 -- CHARACTER 3
12340 ;
12350 CHARA3:   CALL    RND
12360           LD      (CHARD3+4),A
12370           CALL    RND
12380           AND     127
12390           ADD     A,64
12400           LD      (CHARD3+5),A
12410           CALL    DSET
12420 CHARD3:   DEFW    CHAPT2,CHAMV3
12430           DEFB    128,128,255
12440           DEFB    0,0,0,2,2,00000000B
12450           RET
12460           ;
12470 CHAMV3:   LD      A,(IX+9)
12480           SUB     32
12490           LD      (IX+9),A
12500           RET
12510 ;
12520 ; STAGE 1 -- BOSS
12530 ;
12540 BOSSPT:   DEFB    10,0
12550           DEFB      0,-48, 17
12560           DEFB      0,-61,  0
12570           DEFB    -13,-48,  0
12580           DEFB      0,-35,  0
12590           DEFB     13,-48,  0
12600           DEFB      0, 48, 17
12610           DEFB      0, 61,  0
12620           DEFB    -13, 48,  0
12630           DEFB      0, 35,  0
12640           DEFB     13, 48,  0
12650           DEFB    2,3,4,5,2,0,2,1,4,0
12660           DEFB    3,1,5,0,7,8,9,10,7,0
12670           DEFB    7,6,9,0,8,6,10,0,0
12680           ;
12690 BOSMV1:   LD      A,(PORIDAT)
12700           OR      A
12710           JR      Z,ENDMV1
12720           LD      A,(IX+1)
12730           INC     (IX+1)
12740           CP      16
12750           JR      NC,$+11
12760           CALL    MOVE
12770           DEFB    0,0,-8,2,0,0
12780           CP      32
12790           JR      NC,$+11
12800           CALL    MOVE
12810           DEFB    -4,0,0,0,0,0
12820           CP      64
12830           JR      NC,$+11
12840           CALL    MOVE
12850           DEFB    4,0,0,0,2,0
12860           CP      80
12870           JR      NC,$+11
12880           CALL    MOVE
12890           DEFB    0,0,-4,0,0,0
12900           CP      112
12910           JR      NC,$+11
12920           CALL    MOVE
12930           DEFB    -4,0,0,0,-2,0
12940           CP      144
12950           JR      NC,$+11
12960           CALL    MOVE
12970           DEFB    2,0,6,1,-2,0
12980           XOR     A
12990           LD      (IX+1),A
13000           JR      BOSMV1
13010 ENDMV1:   XOR     A
13020           LD      (IX+0),A
13030           RET
13040           ;
13050 BOSMV2:   LD      A,(PORIDAT)
13060           OR      A
13070           JR      Z,ENDMV2
13080           LD      A,(IX+1)
13090           INC     (IX+1)
13100           CP      16
13110           JR      NC,$+11
13120           CALL    MOVE
13130           DEFB    0,0,-8,0,0,2
13140           CP      32
13150           JR      NC,$+11
13160           CALL    MOVE
13170           DEFB    -4,0,0,0,0,3
13180           CP      64
13190           JR      NC,$+11
13200           CALL    MOVE
13210           DEFB    4,0,0,0,0,0
13220           CP      80
13230           JR      NC,$+11
13240           CALL    MOVE
13250           DEFB    0,0,-4,0,0,-3
13260           CP      112
13270           JR      NC,$+11
13280           CALL    MOVE
13290           DEFB    -4,0,0,0,0,1
13300           CP      144
13310           JR      NC,$+11
13320           CALL    MOVE
13330           DEFB    2,0,6,-1,0,2
13340           XOR     A
13350           LD      (IX+1),A
13360           JR      BOSMV2
13370 ENDMV2:   XOR     A
13380           LD      (IX+0),A
13390           RET
13400           ;
13410 BOSS:     CALL    DSET
13420           DEFW    ATACKM,MHYOUJ
13430           DEFB    9,16,1,1,0
13440           DEFB    68,80,0,00100101B
13450           LD      A,17
13460           CALL    MAIN
13470           CALL    CLSPRI
13480           CALL    DSET
13490           DEFW    COREPT,BOSMV2
13500           DEFB    128,128,230
13510           DEFB    0,0,0,9,9,00000000B
13520           CALL    DSET
13530           DEFW    BOSSPT,BOSMV1
13540           DEFB    128,128,230
13550           DEFB    0,0,0,5,8,00000000B
13560           CALL    DSET
13570           DEFW    BOSSPT,BOSMV2
13580           DEFB    128,128,230
13590           DEFB    8,0,0,5,8,00000000B
13600 LOOP8:    LD      A,1
13610           CALL    MAIN
13620           LD      A,(PORIDAT)
13630           OR      A
13640           JR      NZ,LOOP8
13650           LD      HL,HOME
13660           LD      (MASTER+5),HL
13670 LOOP9:    LD      A,1
13680           CALL    MAIN
13690           LD      A,(MASTER+1)
13700           OR      A
13710           JR      NZ,LOOP9
13720           ;
13730           CALL    DSET
13740           DEFW    STAGM1,MHYOUJ
13750           DEFB    10,24,0,0,0,38,8
13760           DEFB    0,00000101B
13770           CALL    DSET
13780           DEFW    CLEARM,MHYOUJ
13790           DEFB    10,24,0,0,0,38,134
13800           DEFB    0,00000101B
13810           LD      A,28
13820           CALL    MAIN
13830           CALL    DSET
13840           DEFW    BONUSM,MHYOUJ
13850           DEFB    10,24,0,0,0,0,55
13860           DEFB    0,00000101B
13870           CALL    DSET
13880           DEFW    SCOREM,MHYOUJ
13890           DEFB    10,24,0,0,0,8,80
13900           DEFB    0,00010101B
13910           LD      HL,(SCORE)
13920           LD      DE,1000
13930           ADD     HL,DE
13940           JR      NC,$+5
13950           LD      HL,65535
13960           LD      (SCORE),HL
13970           LD      A,(STOCK)
13980           INC     A
13990           CP      10
14000           JR      C,$+4
14010           LD      A,9
14020           LD      (STOCK),A
14030           LD      A,30
14040           CALL    MAIN
14050           CALL    FADE
14060           LD      A,24
14070           CALL    MAIN
14080           RET
14090           ;
14100 TUCH7:    CALL    TUCH2
14110           LD      A,(MASTER+9)
14120           XOR     127
14130           ADD     A,17
14140           LD      (MASTER+9),A
14150           RET
14160           ;
14170 TUCH8:    LD      A,64
14180           LD      (MASTER+8),A
14190           LD      A,(IX+13)
14200           CP      9
14210           JR      NZ,$+8
14220           LD      A,8
14230           LD      (IX+13),A
14240           RET
14250           CP      8
14260           JR      NZ,$+8
14270           LD      A,6
14280           LD      (IX+13),A
14290           RET
14300           XOR     A
14310           LD      (IX+0),A
14320           RET
14330           ;
14340 COREPT:   DEFB    6,0
14350           DEFB      0,-24,  0
14360           DEFB      0, 24,  0
14370           DEFB      0,  0,-13
14380           DEFB    -14,  0,  0
14390           DEFB      0,  0, 13
14400           DEFB     13,  0,  0
14410           DEFB    1,4,2,6,1,0,5,4,3,6,5,0
14420           DEFB    1,3,2,5,1,0,0
14430           ;
14440 ATACKM:   DEFB    'A',20,0,'T',40,0,'A',60,0,'C',80,0,'K',100,0,0
14450 CLEARM:   DEFB    'C',60,30,'L',75,30,'E',90,30,'A',105,30,'R',120,30,0
14460 BONUSM:   DEFB    'B',88,30,'O',108,30,'N',128,30,'U',148,30,'S',168,30,0
14470 SCOREM:   DEFB    '1',98,60,'0',113,60,'0',128,60,'0',142,60
14480           DEFB    '1',98,90,'U',113,90,'P',128,90,0
14490           ;
14500 END:      EQU     $
