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
10305 HSCORE:   EQU     TOP1+07DFH
10310 EXPTBL:   EQU     0FCC1H
10320 CALSLT:   EQU     001CH
10330 STRIG:    EQU     TOP3+0000H
10340 STICK:    EQU     TOP3+0026H
10350 DEAD:     EQU     TOP3+004CH
10355 JPDEAD:   EQU     TOP3+0076H
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
10554 CHTEN:    EQU     TOP2+05FEH
10555 STAGE1:   EQU     1B0BH
10560 STAGE2:   EQU     1F70H
10570 STAGE3:   EQU     25EDH
10580 STAGE4:   EQU     2C68H
10581 M1:       EQU     TOP2+0402H
10582 M2:       EQU     TOP2+0412H
10583 M3:       EQU     TOP2+042AH
10584 M4:       EQU     TOP2+044AH
10600           ORG     1450H
10610 ;
10620 ;---- STAGE DATA ----
10630 ;
10650 TITLE:    LD      IX,SCOLOR
10660           LD      A,2
10670           LD      (IX+0),A
10680           LD      A,1
10690           LD      (IX+1),A
10700           LD      A,00001001B
10710           LD      (IX+2),A
10720           ;
10730 MENSET:   CALL    CLSPRI
10740           CALL    UNFADE
10750           LD      A,4
10760           CALL    MAIN
10770           CALL    DSSS   ;MOJI
10780           DEFW    TOP2+015AH
10790           DEFB    44,70
10800           CALL    DSSS
10810           DEFW    TOP2+0176H
10820           DEFB    100,70
10830           CALL    DSSS
10840           DEFW    TOP2+0193H
10850           DEFB    156,70
10860           CALL    DSSS
10870           DEFW    TOP2+01AFH
10880           DEFB    212,70
10890           LD      A,3
10900           CALL    MAIN
10910           CALL    DSSS
10920           DEFW    TOP2+0193H
10930           DEFB     44,178
10940           CALL    DSSS
10950           DEFW    TOP2+01C8H
10960           DEFB    100,178
10970           CALL    DSSS
10980           DEFW    TOP2+01D4H
10990           DEFB    156,178
11000           CALL    DSSS
11010           DEFW    TOP2+01E9H
11020           DEFB    212,178
11030           LD      A,77
11040           CALL    MAIN
11050           ;
11060           CALL    DSET
11070           DEFW    MSDATA,PATER2
11080           DEFB    128,128,255
11090           DEFB    0,0,0,3,0
11100           DEFB    00101000B
11110           LD      A,34
11120           CALL    MAIN
11130           CALL    DSET
11140           DEFW    MOJI,MJIPAT
11150           DEFB    3,255,0,2,0,50
11160           DEFB    50,0,00100101B
11170           ;
11180           LD      B,0
11190 LOSTI:    CALL    STRIG
11200           JP      Z,NEXTGO
11210           CALL    MAIN
11220           DJNZ    LOSTI
11230           CALL    FADE
11240           LD      A,10
11250           CALL    MAIN
11260           CALL    WSCORE
11265           JP      TITLE
11270           ;
11280 NEXTGO:   CALL    FADE
11290           LD      A,16
11300           CALL    MAIN
11310           JP      SELECT
11320           ;
11330 DSSS:     POP     HL
11340           LD      E,(HL)
11350           INC     HL
11360           LD      D,(HL)
11370           INC     HL
11380           LD      C,(HL)
11390           INC     HL
11400           LD      B,(HL)
11410           INC     HL
11420           LD      (DSSD+0),DE
11430           LD      (DSSD+4),BC
11440           CALL    DSET
11450 DSSD:     DEFW    0,PATER1,0
11460           DEFB    250,0,0,16,3,0
11470           DEFB    001010B
11480           PUSH    HL
11490           LD      A,1
11500           CALL    MAIN
11510           RET
11520           ;
11530 MOJI:     DEFB    'P',15,30
11540           DEFB    'U',30,30
11550           DEFB    'S',45,30
11560           DEFB    'H',60,30
11570           DEFB    'S',90,30
11580           DEFB    'P',105,30
11590           DEFB    'A',120,30
11600           DEFB    'C',135,30
11610           DEFB    'E',150,30,0
11620           ;
11630 MJIPAT:   LD      A,(IX+1)
11640           AND     3
11650           RLCA
11660           RLCA
11670           RLCA
11680           OR      00100101B
11690           LD      (IX+15),A
11700           JP      MHYOUJ
11710 ;
11720 ;---- PATERN ROUTINE ----
11730 ;
11740 PATER1:   LD      A,(IX+1)
11750           INC     (IX+1)
11760           CP      8
11770           JR      NC,$+11
11780           CALL    MOVE
11790           DEFB    0,0,-26
11800           DEFB    0,-4,2
11810           CP      30
11820           JR      NC,PJ1
11830           AND     2
11840           JR      Z,$+11
11850           CALL    MOVE
11860           DEFB    0,4,0
11870           DEFB    0,0,0
11880           CALL    MOVE
11890           DEFB    0,-4,0
11900           DEFB    0,0,0
11910 PJ1:      CP      66
11920           JR      NC,$+20
11930           CALL    RTURN
11940           DEFB    128,128,128
11950           DEFB    0,2,0
11960           CALL    MOVE
11970           DEFB    0,0,0
11980           DEFB    0,2,0
11990           CALL    MOVE
12000           DEFB    0,0,16
12010           DEFB    1,2,2
12020           ;
12030 PATER2:   LD      A,(IX+1)
12040           INC     (IX+1)
12050           CP      16
12060           JR      NC,$+11
12070           CALL    MOVE
12080           DEFB    0,0,-10
12090           DEFB    2,0,0
12100           JR      NZ,PJ2
12110           SET     1,(IX+15)
12120           LD      A,200
12130           LD      (IX+9),A
12140           LD      A,16
12150 PJ2:      CP      34
12160           JR      NC,$+11
12170           CALL    MOVE
12180           DEFB    0,0,-8
12190           DEFB    2,0,0
12200           CP      70
12210           JR      NC,$+11
12220           CALL    MOVE
12230           DEFB    0,0,0
12240           DEFB    0,-1,-1
12250           CP      120
12260           JR      NC,$+11
12270           CALL    MOVE
12280           DEFB    0,0,0
12290           DEFB    0,0,-1
12300           CP      190
12310           JR      NC,$+11
12320           CALL    MOVE
12330           DEFB    0,0,0
12340           DEFB    -1,0,0
12350           LD      A,34
12360           LD      (IX+1),A
12370           JR      PATER2
12380 ;
12390 ; --- GAME SELECT ROUTINE ---
12400 ;
12410 SELECT:   CALL    CLSPRI
12420           LD      A,00001001B
12430           LD      (SWHICH),A
12435           LD      A,13
12436           LD      (SCOLOR),A
12440           CALL    DSET
12450           DEFW    GAMEM,MOJIMV
12460           DEFB    9,200,0,0,0,66
12470           DEFB    100,0,00010001B
12480           CALL    DSET
12490           DEFW    PRACTM,MOJIMV
12500           DEFB    11,200,0,0,0,60
12510           DEFB    150,0,00010101B
12520           CALL    DSET
12530           DEFW    WALLPT,WALLMV
12540           DEFB    135,75,60,0,0,0
12550           DEFB    9,0,00001000B
12560           CALL    DSET
12570           DEFW    WALLPT,WALLMV
12580           DEFB    135,170,60,0,0,0
12590           DEFB    11,0,00001001B
12600           CALL    UNFADE
12610           LD      A,8
12620           CALL    MAIN
12630           ;
12640           LD      C,0
12650 LPSLCT:   LD      A,2
12660           CALL    MAIN
12670           CALL    STRIG
12680           OR      A
12690           JR      Z,JUMPSL
12700           CALL    STICK
12710           OR      A
12720           JR      Z,LPSLCT
12730           LD      A,C
12740           XOR     1
12750           LD      C,A
12760           LD      A,(PORIDAT+63)
12770           LD      B,A
12780           LD      A,(PORIDAT+47)
12790           LD      (PORIDAT+63),A
12800           LD      A,B
12810           LD      (PORIDAT+47),A
12820           JP      LPSLCT
12830           ;
12840 JUMPSL:   CALL    FADE
12850           LD      A,10
12860           CALL    MAIN
12870           LD      HL,0
12880           LD      (SCORE),HL
12890           LD      A,3
12900           LD      (STOCK),A
12910           LD      A,C
12920           OR      A
12930           JP      NZ,PRATCE
12940           ;
12945 GAME:     LD      HL,GMOUT
12946           LD      (JPDEAD),HL
12950           CALL    STAGE1
12960           CALL    STAGE2
12970           CALL    STAGE3
12980           CALL    STAGE4
12990           CALL    ENDING
13000           CALL    WSCORE
13005           JP      TITLE
13006           ;
13007 GMOUT:    CALL    GMOVER
13008           CALL    WSCORE
13009           POP     HL
13010           JP      TITLE
13019           ;
13020 GAMEM:    DEFB    'G',20,0,'A',50,0,'M',80,0,'E',110,0,0
13030 PRACTM:   DEFB    'P',20,0,'R',35,0,'A',50,0,'C',65,0,'T',80,0
13040           DEFB    'I',95,0,'C',110,0,'E',125,0,0
13050           ;
13060 WALLPT:   DEFB    8,0
13070           DEFB    -120,  30, 5
13080           DEFB    -120, -30, 5
13090           DEFB     120, -30, 5
13100           DEFB     120,  30, 5
13110           DEFB    -120,  30,-5
13120           DEFB    -120, -30,-5
13130           DEFB     120, -30,-5
13140           DEFB     120,  30,-5
13150           DEFB    1,2,3,4,1,0
13160           DEFB    5,6,7,8,5,0,0
13170           ;
13180 WALLMV:   CALL    MOVE
13190           DEFB    0,0,0,0,1,0
13200           ;
13210 MOJIMV:   INC     (IX+1)
13220           JP      MHYOUJ
13230 ;
13240 ; --- PRACTICE ROUTINE ---
13250 ;
13260 PRATCE:   CALL    CLSPRI
13270           LD      A,00001001B
13280           LD      (SWHICH),A
13290           LD      A,1
13300           LD      (SCOLOR+1),A
13310           CALL    DSET
13320           DEFW    PRATM,PRAMJV
13330           DEFB    9,200,0,0,0,76
13340           DEFB    100,0,00010001B
13350           CALL    DSET
13360           DEFW    M1,SJIMV
13370           DEFB    0,0,0,0,0,0
13380           DEFB    10,0,00001010B
13390           CALL    DSET
13400           DEFW    M4,SJIMV
13410           DEFB    0,0,0,0,0,0
13420           DEFB    8,8,00001010B
13430           CALL    DSET
13440           DEFW    M3,SJIMV
13450           DEFB    0,0,0,0,0,0
13460           DEFB    5,16,00001010B
13470           CALL    DSET
13480           DEFW    M2,SJIMV
13490           DEFB    0,0,0,0,0,0
13500           DEFB    3,24,00001010B
13510           CALL    UNFADE
13520           LD      C,0
13530 PRLOOP:   LD      A,1
13540           CALL    MAIN
13550           CALL    STRIG
13560           JP      Z,JPPRCT
13570           CALL    STICK
13580           CP      3
13590           JR      NZ,PRJP2
13600           LD      B,8
13610 PRJP1:    INC     C
13620           LD      A,1
13630           CALL    MAIN
13640           DJNZ    PRJP1
13650           JR      PRLOOP
13660 PRJP2:    CP      7
13670           JR      NZ,PRLOOP
13680           LD      B,8
13690 PRJP3:    DEC     C
13700           LD      A,1
13710           CALL    MAIN
13720           DJNZ    PRJP3
13730           JP      PRLOOP
13740           ;
13750 JPPRCT:   LD      B,10
13760           CALL    FADE
13770 JPPRJ1:   LD      A,1
13780           CALL    MAIN
13790           DJNZ    JPPRJ1
13791           LD      HL,PRART
13792           LD      (JPDEAD),HL
13793           LD      HL,0
13794           LD      (SCORE),HL
13795           LD      A,3
13796           LD      (STOCK),A
13800           LD      A,C
13810           SRL     A
13820           SRL     A
13830           SRL     A
13840           AND     3
13850           JR      NZ,JPCT1
13860           CALL    STAGE1
13870           JP      PRATCE
13880 JPCT1:    CP      1
13890           JR      NZ,JPCT2
13900           CALL    STAGE2
13910           JP      PRATCE
13920 JPCT2:    CP      2
13930           JR      NZ,JPCT3
13940           CALL    STAGE3
13950           JP      PRATCE
13960 JPCT3:    CALL    STAGE4
13965           CALL    ENDING
13970           JP      PRATCE
13980           ;
13981 PRART:    POP     HL
13982           JP      PRATCE
13983           ;
13990 SJIMV:    LD      (IX+7),128
14000           LD      (IX+8),160
14010           LD      (IX+9),10
14020           LD      A,C
14030           ADD     A,(IX+14)
14040           AND     31
14050           LD      (SJI1+2),A
14060           LD      (IX+12),A
14070           CALL    RTURN
14080           DEFB    128,100,128
14090 SJI1:     DEFB    0,0,0
14100           CALL    MOVE
14110           DEFB    0,0,0
14120           DEFB    1,0,0
14130           ;
14140 PRATM:    DEFB    'Z',20,0,'O',40,5,'N',60,2,'E',85,0,0
14150           ;
14160 PRAMJV:   INC     (IX+1)
14170           LD      A,C
14180           AND     31
14190           SRL     A
14200           SRL     A
14210           SRL     A
14220           LD      H,0
14230           LD      L,A
14240           LD      DE,TBLCOR
14250           ADD     HL,DE
14260           LD      A,(HL)
14270           LD      (SCOLOR),A
14280           LD      (IX+7),A
14290           JP      MHYOUJ
14300           ;
14310 TBLCOR:   DEFB    11,2,4,6
40000 ;
40010 ;--- GAME CLEAR ---
40015 ;
40030 ENDING:   CALL    CLSPRI
40040           LD      A,8
40050           CALL    MAIN
40060           LD      A,00001001B
40070           LD      (SWHICH),A
40080           LD      HL,0203H
40090           LD      (SCOLOR),HL
40100           LD      HL,0
40110           LD      (GAGE),HL
40130           CALL    DSET
40140           DEFW    MSDATA,EMSPT1
40150           DEFB    128,160,16,0,1,0
40160           DEFB    3,0,00001000B
40170           CALL    UNFADE
40180           LD      A,24
40190           CALL    MAIN
40200           CALL    DSET
40210           DEFW    PRODUM,MHYOUJ
40220           DEFB    2,34,0,0,0,75
40230           DEFB    80,0,00000101B
40240           LD      A,36
40250           CALL    MAIN
40260           CALL    DSET
40270           DEFW    RYUZKM,MHYOUJ
40280           DEFB    2,34,0,0,0,73
40290           DEFB    80,0,00000101B
40300           LD      A,36
40310           CALL    MAIN
40320           CALL    DSET
40330           DEFW    ROCKM ,MHYOUJ
40340           DEFB    2,34,0,0,0,73
40350           DEFB    80,0,00000101B
40360           LD      A,36
40370           CALL    MAIN
40380           CALL    DSET
40390           DEFW    THEENM,MHYOUJ
40400           DEFB    2,34,0,0,0,82
40410           DEFB    80,0,00000101B
40420           LD      A,36
40430           CALL    MAIN
40440           XOR     A
40450           LD      (PORIDAT+1),A
40460           LD      HL,EMSPT2
40470           LD      (PORIDAT+5),HL
40480           LD      A,32
40490           CALL    MAIN
40500           CALL    FADE
40510           LD      A,16
40520           CALL    MAIN
40530           LD      A,00001000B
40540           LD      (SWHICH),A
40550           CALL    DSET
40560           DEFW    MSXM,MHYOUJ
40570           DEFB    15,230,0,0,0,98
40580           DEFB    110,0,00010001B
40590           CALL    DSET
40600           DEFW    FOREVM,MHYOUJ
40610           DEFB    15,230,0,0,0,83
40620           DEFB    150,0,00010101B
40630           CALL    UNFADE
40640           LD      A,150
40650           CALL    MAIN
40660           CALL    FADE
40670           LD      A,8
40680           CALL    MAIN
40690           RET
40700           ;
40710 EMSPT1:   LD      A,(IX+1)
40720           INC     (IX+1)
40730           CP      6
40740           JR      NC,$+11
40750           CALL    MOVE
40760           DEFB    -16,0,0,1,0,0
40770           CP      18
40780           JR      NC,$+11
40790           CALL    MOVE
40800           DEFB    16,0,0,-1,0,0
40810           CP      24
40820           JR      NC,$+11
40830           CALL    MOVE
40840           DEFB    -16,0,0,1,0,0
40850           XOR     A
40860           LD      (IX+1),A
40870           JR      EMSPT1
40880           ;
40890 EMSPT2:   LD      A,(IX+1)
40900           INC     (IX+1)
40910           CP      12
40920           JR      NC,$+11
40930           CALL    MOVE
40940           DEFB    -5,-2,16,0,0,0
40950           CP      16
40960           JR      NC,$+11
40970           CALL    MOVE
40980           DEFB    0,0,0,0,-1,-3
40990           CALL    MOVE
41000           DEFB    8,-6,-24,0,0,0
41010           ;
41020 PRODUM:   DEFB   'P',0,0,'R',15,0,'O',30,0,'D',45,0,'U',60,0,'C',75,0
41030           DEFB   'E',90,0,'D',105,0,'B',45,50,'Y',60,50,0
41040 RYUZKM:   DEFB   'H',0,0,'R',30,0,'Y',41,0,'U',52,0,'Z',67,0,'A',83,0
41050           DEFB   'K',98,0,'I',113,0,0
41060 ROCKM:    DEFB   'R',0,0,'O',15,0,'C',30,0,'K',45,0,'C',65,0,'I',80,0
41070           DEFB   'T',95,0,'Y',110,0,0
41080 THEENM:   DEFB   'T',0,0,'H',15,0,'E',30,0,'E',55,0,'N',70,0,'D',85,0,0
41090 MSXM:     DEFB   'M',0,0,'S',30,0,'X',60,0,0
41100 FOREVM:   DEFB   'F',0,0,'O',15,0,'R',30,0,'E',45,0,'V',60,0,'E',75,0
41110           DEFB   'R',90,0,0
41120 ;
41130 ; SCORE ROUTINE
41140 ;
41150 WSCORE:   LD      HL,(SCORE)
41160           LD      IX,SCOREM
41170           CALL    CHTEN
41175           CALL    CLSPRI
41180           CALL    DSET
41190           DEFW    SCOREM,MHYOUJ
41200           DEFB    15,80,0,0,0,140
41210           DEFB    140,0,00010001B
41220           LD      HL,(HSCORE)
41230           LD      DE,(SCORE)
41240           OR      A
41250           SBC     HL,DE
41260           PUSH    AF
41270           ADD     HL,DE
41280           POP     AF
41290           LD      C,15
41300           JR      NC,$+4
41310           EX      DE,HL
41320           LD      C,8
41330           LD      A,C
41340           LD      (HSCORD+4),A
41350           LD      (HSCORE),HL
41360           LD      IX,HSCORM
41370           CALL    CHTEN
41380           CALL    DSET
41390 HSCORD:   DEFW    HSCORM,MHYOUJ
41400           DEFB    15,80,0,0,0,140
41410           DEFB    100,0,00010001B
41420           CALL    DSET
41430           DEFW    HSCOR2,MHYOUJ
41440           DEFB    14,80,0,0,0,20
41450           DEFB    100,0,00010101B
41460           CALL    DSET
41470           DEFW    SCORE2,MHYOUJ
41480           DEFB    14,80,0,0,0,20
41490           DEFB    140,0,00010101B
41500           CALL    UNFADE
41510           LD      A,00001000B
41520           LD      (SWHICH),A
41530           CALL    UNFADE
41540           LD      A,50
41550           CALL    MAIN
41560           CALL    FADE
41570           LD      A,8
41580           CALL    MAIN
41590           RET
41600           ;
41610 SCOREM:   DEFB    '0',0,0,'0',20,0,'0',40,0,'0',60,0,'0',80,0,0
41620 HSCORM:   DEFB    '0',0,0,'0',20,0,'0',40,0,'0',60,0,'0',80,0,0
41630 HSCOR2:   DEFB    'H',0,0,'I',12,0,'S',30,0,'C',45,0,'O',60,0
41640           DEFB    'R',75,0,'E',90,0,0
41650 SCORE2:   DEFB    'S',0,0,'C',15,0,'O',30,0,'R',45,0,'E',60,0,0
41660 ;
41670 ; GAME OVER
41680 ;
41690 GMOVER:   CALL    CLSPRI
41700           LD      A,14
41710           CALL    MAIN
41720           CALL    DSET
41730           DEFW    GMOVEM,MHYOUJ
41740           DEFB    8,40,0,0,0,80
41750           DEFB    90,0,00000001B
41760           CALL    UNFADE
41770           LD      A,00001000B
41780           LD      (SWHICH),A
41790           LD      A,32
41800           CALL    MAIN
41810           CALL    FADE
41820           LD      A,20
41830           CALL    MAIN
41840           RET
41850           ;
41860 GMOVEM:   DEFB    'G',0,0,'A',30,0,'M',60,0,'E',90,0
41870           DEFB    'O',0,80,'V',30,80,'E',60,80,'R',90,80,0
50000 END:      EQU     $
