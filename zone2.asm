500 TOP1:      EQU     0100H
600 TOP2:      EQU     09F7H
700 TOP3:      EQU     1032H
1000 MAIN:     EQU     TOP1+0056H
1010 MALEND:   EQU     TOP1+019EH
1020 MALRET:   EQU     TOP1+01A2H
1025 LIDAT:    EQU     TOP1+0432H
1030 JPTUCH:   EQU     TOP1+0338H
1040 KEY:      EQU     TOP1+0508H
1050 MOVE:     EQU     TOP1+05DEH
1060 RTURN:    EQU     TOP1+0603H
1070 DSET:     EQU     TOP1+064BH
1080 CLSPRI:   EQU     TOP1+068FH
1090 PALETE:   EQU     TOP1+069DH
1100 PLDAT:    EQU     TOP1+06D9H
1110 UNFADE:   EQU     TOP1+070AH
1120 FADE:     EQU     TOP1+072FH
1130 MHYOUJ:   EQU     TOP2+0000H
1140 STACK:    EQU     TOP1+07D0H
1150 SCROLL:   EQU     TOP1+07D2H
1160 SCOLOR:   EQU     TOP1+07D4H
1170 SWHICH:   EQU     TOP1+07D6H
1180 GAGE:     EQU     TOP1+07E1H
1190 LIFE:     EQU     TOP1+07DBH
1200 STOCK:    EQU     TOP1+07DCH
1210 DEADRT:   EQU     TOP1+07D9H
1220 CONTRT:   EQU     TOP1+07D7H
1230 MASTER:   EQU     TOP1+07E7H
1240 PORIDAT:  EQU     TOP1+07F7H
1250 MSDATA:   EQU     TOP2+04F8H
1251 SCORE:    EQU     TOP1+07DDH
1260 EXPTBL:   EQU     0FCC1H
1270 CALSLT:   EQU     001CH
1280 STRIG:    EQU     TOP3+0000H
1290 STICK:    EQU     TOP3+0026H
1300 DEAD:     EQU     TOP3+004CH
1310 MSSTR:    EQU     TOP3+00FBH
1320 TURBO:    EQU     TOP3+0167H
1330 TURBPT:   EQU     TOP3+01A2H
1340 CURE:     EQU     TOP3+01CFH
1350 CURPT1:   EQU     TOP3+0220H
1360 CURPT2:   EQU     TOP3+0247H
1370 TECHNO:   EQU     TOP3+029FH
1380 TECHPT:   EQU     TOP3+026EH
1390 PARTY:    EQU     TOP3+035BH
1400 PARPT1:   EQU     TOP3+0312H
1410 PARPT2:   EQU     TOP3+0337H
1420 RND:      EQU     TOP3+03BDH
1430 HOME:     EQU     TOP3+03CDH
1440 TUCH0:    EQU     TOP3+00A3H
1450 TUCH1:    EQU     TOP3+00A4H
1460 TUCH2:    EQU     TOP3+00B9H
1470 TUCH3:    EQU     TOP3+00D5H
1480 TUCH4:    EQU     TOP3+00EBH
1490 TUCH5:    EQU     TOP3+02E3H
1500 TUCH6:    EQU     TOP3+039CH
2000           ORG     1F70H
30000 ;
30010 ;---- STAGE2 PROGRAM ----
30020 ;
30030 STAGE2:   CALL    CLSPRI
30040           LD      (STACK),SP
30060           LD      A,00001000B
30070           LD      (SWHICH),A
30080           CALL    DSET
30090           DEFW    STAGM1,MHYOUJ
30100           DEFB    12,40,0,0,0,44
30110           DEFB    0,0,00010101B
30120           CALL    DSET
30130           DEFW    STAGM2,MHYOUJ
30140           DEFB    12,40,0,0,0,26
30150           DEFB    50,0,00000101B
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
30340           LD      A,24
30350           CALL    MAIN
30360         ; JP      BOSS
30370           LD      B,128
30380 LOOP:     LD      HL,RETLOP
30390           PUSH    HL
30400           CALL    TURBO
30410           CALL    CURE
30420           LD      A,B
30430           CP      64
30435           JP      Z,CHARA2
30440           JR      C,J1
30450           CALL    RND
30460           CP      100
30470           JP      C,CHARA3
30480           CP      150
30490           JP      C,CHARA6
30500           CP      180
30510           JP      C,TECHNO
30520           CP      215
30530           JP      C,PARTY
30540           RET
30550           ;
30556 J1:       CP      48
30557           RET     NC
30560           CP      40
30570           JP      NC,CHARA4
30590           CP      32
30600           JP      NC,CHARA5
30610           CP      28
30620           RET     NC
30630           CP      20
30640           JP      Z,CHARA2
30650           JP      NC,CHARA1
30660           POP     HL
30665           ;
30670 RETLOP:   CALL    RND
30675           AND     3
30676           ADD     A,2
30680           CALL    MAIN
30690           DJNZ    LOOP
30700           ;
30705           LD      A,(SWHICH)
30706           AND     11111110B
30707           LD      (SWHICH),A
30820           LD      HL,CONT2
30830           LD      (CONTRT),HL
30831 CONT2:    LD      A,24
30832           CALL    MAIN
30840           LD      B,192
30850 LOOP2:    CALL    TURBO
30860           CALL    CURE
30880           LD      HL,RETLP3
30890           PUSH    HL
30900           CALL    RND
30910           CP      80
30920           JP      C,CHARA3
30930           CP      110
30940           JP      C,CHARA6
30950           CP      135
30960           JP      C,CHARA4
30970           CP      145
30980           JP      C,CHARA5
30990           CP      155
31000           JP      C,CHARA1
31010           CP      190
31020           JP      C,TECHNO
31030           CP      220
31040           JP      C,PARTY
31050           POP     HL
31060 RETLP3:   LD      A,B
31070           RLCA
31080           RLCA
31090           AND     3
31100           ADD     A,2
31110           CALL    MAIN
31120           DJNZ    LOOP2
31130           LD      A,32
31135           CALL    MAIN
31140           JP      BOSS
40000 ;
40010 ; STAGE2 DATA
40020 ;
40030 STAGD1:   DEFB    32,5,12,2
40040           DEFB    01011011B
40050           DEFW    CONT,DEAD
40060           ;
40070 JPDAT1:   DEFW    TUCH0,TUCH1
40080           DEFW    TUCH2,TUCH3
40090           DEFW    TUCH4,TUCH5
40100           DEFW    TUCH6,TUCH6
40110           DEFW    TUCH7,TUCH8
40120           DEFW    TUCH0,TUCH0
40130           DEFW    TUCH0,TUCH0
40140           DEFW    TUCH0,TUCH0
40150           ;
40160 STAGM1:   DEFB    'Z',60,80
40170           DEFB    'O',75,80
40180           DEFB    'N',90,80
40190           DEFB    'E',105,80
40200           DEFB    '2',120,80,0
40210 STAGM2:   DEFB    'F',30,80
40220           DEFB    'O',60,80
40230           DEFB    'R',90,80
40240           DEFB    'E',120,80
40250           DEFB    'S',150,80
40260           DEFB    'T',180,80,0
50000 ;
50010 ; STAGE 1 -- CHARACTER 1
50020 ;
50030 CHARA1:   CALL    RND
50040           AND     127
50050           ADD     A,90
50060           LD      (CHARD1+4),A
50070           CALL    DSET
50080 CHARD1:   DEFW    CHPD11,CHARP1
50090           DEFB    0,225,245,0,0,0
50100           DEFB    13,1,00000000B
50110           RET
50120           ;
50130 CHPD11:   DEFB    6,0
50140           DEFB      0,  0,-20
50150           DEFB    -30,-10,-10
50160           DEFB     30,-10,-10
50170           DEFB      0,  0, 40
50180           DEFB    -10,-16,-20
50190           DEFB     10,-16,-20
50200           DEFB    1,2,4,3,1,4,0,5,1,6,0,0
50210           ;
50220 CHPD12:   DEFB    6,0
50230           DEFB      0,  0,-20
50240           DEFB    -20, 20,-10
50250           DEFB     20, 20,-10
50260           DEFB      0,  0, 40
50270           DEFB    -10,-16,-20
50280           DEFB     10,-16,-20
50290           DEFB    1,2,4,3,1,4,0,5,1,6,0,0
50300           ;
50310 HABATA:   LD      A,(IX+1)
50320           INC     (IX+1)
50330           LD      C,A
50340           LD      HL,CHPD11
50350           AND     2
50360           JR      Z,$+5
50370           LD      HL,CHPD12
50380           LD      (IX+3),L
50390           LD      (IX+4),H
50400           LD      A,C
50410           RET
50420           ;
50430 CHARP1:   CALL    HABATA
50440           CP      8
50450           JR      NC,$+11
50460           LD      A,(IX+9)
50470           SUB     16
50480           LD      (IX+9),A
50490           RET
50500           CP      40
50510           JR      NC,$+20
50520           CALL    RTURN
50530           DEFB    128,128,128,0,2,0
50540           CALL    MOVE
50550           DEFB    -2,0,0,0,2,0
50560           LD      A,(IX+9)
50570           SUB     16
50580           LD      (IX+9),A
50590           RET
50600 ;
50610 ; STAGE 2 -- CHARACTER 2
50620 ;
50630 CHARA2:   CALL    RND
50640           AND     31
50650           ADD     A,112
50660           LD      (CHARD2+4),A
50670           LD      (CHAR22+4),A
50680           CALL    DSET
50690 CHARD2:   DEFW    CHAPD2,CHARP2
50700           DEFB    128,128,245,0,0,0
50710           DEFB    12,2,00000010B
50720           CALL    DSET
50730 CHAR22:   DEFW    CHAPD2,CHARP2
50740           DEFB    128,128,245,8,0,0
50750           DEFB    12,2,00000010B
50760           RET
50770           ;
50780 CHAPD2:   DEFB    11,3
50790           DEFB     -8,-50, -8
50800           DEFB     -8,-50,  8
50810           DEFB      8,-50,  8
50820           DEFB      8,-50, -8
50830           DEFB     -8, 50, -8
50840           DEFB     -8, 50,  8
50850           DEFB      8, 50,  8
50860           DEFB      8, 50, -8
50870           DEFB      0, 24,  0
50880           DEFB      0,-24,  0
50890           DEFB      0,  0,  0
50900           DEFB    1,2,3,4,1,5,6
50910           DEFB    7,8,5,0,4,8,0
50920           DEFB    3,7,0,2,6,0,0
50930           ;
50940 CHARP2:   LD      A,(IX+13)
50950           XOR     15
50960           LD      (IX+13),A
50970           LD      A,(IX+1)
50980           INC    (IX+1)
50990           CP      8
51000           JR      NC,$+11
51010           CALL    MOVE
51020           DEFB    0,0,-24,2,0,0
51030           CP      40
51040           JR      NC,$+11
51050           CALL    MOVE
51060           DEFB    0,0,0,1,-2,-1
51070           CP      72
51080           JR      NC,$+11
51090           CALL    MOVE
51100           DEFB    0,0,0,2,1,2
51110           CALL    MOVE
51120           DEFB    0,0,-8,2,0,0
51130 ;
51140 ; STAGE 1 -- CHARACTER 3
51150 ;
51160 CHARA3:   CALL    RND
51170           CP      200
51180           JR      NC,$-5
51190           ADD     A,25
51200           LD      (CHARD3+4),A
51210           LD      HL,CHRP31
51220           CALL    RND
51230           AND     00010100B
51240           JR      Z,$+5
51250           LD      HL,CHRP32
51260           LD      (CHARD3+2),HL
51270           CALL    DSET
51280 CHARD3:   DEFW    CHAPD3,CHRP31
51290           DEFB    128,225,255
51300           DEFB    0,0,0,12,2,00000000B
51310           RET
51320           ;
51330 CHRP32:   LD      A,(IX+9)
51340           SUB     24
51350           LD      (IX+9),A
51360           RET
51370           ;
51380 CHRP31:   LD      A,(IX+1)
51390           CP      1
51400           JR      Z,CJ5
51410           LD      A,(IX+9)
51420           SUB     24
51430           LD      (IX+9),A
51440           LD      C,A
51450           LD      A,(MASTER+9)
51460           NEG
51470           ADD     A,C
51480           CP      60
51490           RET     NC
51500           LD      A,1
51510           LD      (IX+1),1
51520           RET
51530 CJ5:      LD      A,(IX+9)
51540           SUB     16
51550           LD      (IX+9),A
51560           LD      A,(IX+7)
51570           CP      128
51580           LD      A,(IX+10)
51590           JR      NC,CJ52
51600           CP      8
51610           RET     NC
51620           ADD     A,2
51630           LD      (IX+10),A
51640           RET
51650 CJ52:     SUB     2
51660           AND     31
51670           CP      24
51680           RET     C
51690           LD      (IX+10),A
51700           RET
51710           ;
51720 CHAPD3:   DEFB    10,0
51730           DEFB      0,-127, 0
51740           DEFB    -17,  0, 17
51750           DEFB     -7,  0,-23
51760           DEFB     23,  0,  7
51770           DEFB    -11,-43,  0
51780           DEFB     -5,-43,  0
51790           DEFB     16,-43,  0
51800           DEFB     -8,-86,  0
51810           DEFB     -2,-86,  0
51820           DEFB      8,-86,  0
51830           DEFB    1,2,3,1,4,2,0,4,3,0,0
51840 ;
51850 ; STAGE 2 -- BOSS
51860 ;
51870 BOSS:     CALL    DSET
51880           DEFW    ATACKM,MHYOUJ
51890           DEFB    9,16,1,1,0
51900           DEFB    72,80,0,00100101B
51910           LD      A,17
51920           CALL    MAIN
51930           CALL    CLSPRI
51940           CALL    DSET
51950           DEFW    COREPT,BOSMV2
51960           DEFB    128,56,64
51970           DEFB    0,0,0,9,9,00000000B
51980           CALL    DSET
51990           DEFW    CHPD11,BOSMV3
52000           DEFB    128,32,64
52010           DEFB    0,0,0,9,8,00000010B
52020           LD      HL,4005H
52030           CALL    BOSS2
52040           LD      A,8
52050           CALL    MAIN
52060           LD      HL,0C00DH
52070           CALL    BOSS2
52080           LD      A,8
52090           CALL    MAIN
52100           LD      HL,800BH
52110           CALL    BOSS2
52120 LOOP8:    LD      A,1
52130           CALL    MAIN
52140           LD      A,(PORIDAT)
52150           OR      A
52160           JR      NZ,LOOP8
52180           LD      HL,HOME
52190           LD      (MASTER+5),HL
52200 LOOP9:    LD      A,1
52210           CALL    MAIN
52220           LD      A,(MASTER+1)
52230           OR      A
52240           JR      NZ,LOOP9
52250           ;
52260           CALL    DSET
52270           DEFW    STAGM1,MHYOUJ
52280           DEFB    2,24,0,0,0,38,8
52290           DEFB    0,00000101B
52300           CALL    DSET
52310           DEFW    CLEARM,MHYOUJ
52320           DEFB    2,24,0,0,0,38,134
52330           DEFB    0,00000101B
52340           LD      A,28
52350           CALL    MAIN
52360           CALL    DSET
52370           DEFW    BONUSM,MHYOUJ
52380           DEFB    2,24,0,0,0,0,55
52390           DEFB    0,00000101B
52391           CALL    DSET
52392           DEFW    SCOREM,MHYOUJ
52393           DEFB    2,24,0,0,0,8,80
52394           DEFB    0,00010101B
52400           LD      HL,(SCORE)
52410           LD      DE,2000
52420           ADD     HL,DE
52430           JR      NC,$+5
52440           LD      HL,65535
52450           LD      (SCORE),HL
52460           LD      A,(STOCK)
52470           INC     A
52480           CP      10
52490           JR      C,$+4
52500           LD      A,9
52510           LD      (STOCK),A
52520           LD      A,30
52530           CALL    MAIN
52540           CALL    FADE
52550           LD      A,24
52560           CALL    MAIN
52570           RET
52580           ;
52590 TUCH7:    CALL    TUCH2
52600           LD      A,(MASTER+9)
52610           XOR     127
52620           ADD     A,17
52630           LD      (MASTER+9),A
52640           RET
52650           ;
52660 TUCH8:    LD      A,32
52670           LD      (MASTER+8),A
52680           LD      A,(IX+13)
52690           CP      9
52700           JR      NZ,$+8
52710           LD      A,8
52720           LD      (IX+13),A
52730           RET
52740           CP      8
52750           JR      NZ,$+8
52760           LD      A,6
52770           LD      (IX+13),A
52780           RET
52790           XOR     A
52800           LD      (IX+0),A
52810           RET
52820           ;
52830 COREPT:   DEFB    6,0
52840           DEFB      0,-24,  0
52850           DEFB      0, 24,  0
52860           DEFB      0,  0,-13
52870           DEFB    -13,  0,  0
52880           DEFB      0,  0, 13
52890           DEFB     13,  0,  0
52900           DEFB    1,4,2,6,1,0,5,4,3,6,5,0
52910           DEFB    1,3,2,5,1,0,0
52920           ;
52930 ATACKM:  DEFB    'A',9,0,'T',32,0,'A',55,0,'C',79,0,'K',106,0,0
52940 CLEARM:  DEFB    'C',60,30,'L',75,30,'E',90,30,'A',105,30,'R',120,30,0
52950 BONUSM:  DEFB    'B',88,30,'O',108,30,'N',128,30,'U',148,30,'S',168,30,0
52960 SCOREM:  DEFB    '2',98,60,'0',113,60,'0',128,60,'0',142,60
52970          DEFB    '1',98,90,'U',113,90,'P',128,90,0
52980 ;
52990 ; STAGE 2 -- CHARACTER 5
53000 ;
53010 CHARA5:   CALL    RND
53020           LD      (CHARD5+4),A
53030           CALL    DSET
53040 CHARD5:   DEFW    CHPD11,CHARP5
53050           DEFB    0,215,245,0,0,0
53060           DEFB    5,1,00000000B
53070           RET
53080           ;
53090 CHARP5:   CALL    HABATA
53100           CP      4
53110           JR      NC,$+11
53120           CALL    MOVE
53130           DEFB    0,-22,-8,0,2,0
53140           CP      8
53150           JR      NC,$+11
53160           CALL    MOVE
53170           DEFB    0,-22,-8,0,-2,0
53180           CP      12
53190           JR      NC,$+11
53200           CALL    MOVE
53210           DEFB    0,22,-8,0,-2,0
53220           CP      16
53230           JR      NC,$+11
53240           CALL    MOVE
53250           DEFB    0,22,-8,0,2,0
53260           XOR     A
53270           LD      (IX+1),A
53280           JR      CHARP5
53290 ;
53300 ; STAGE 2 -- CHARACTER 4
53310 ;
53320 CHARP4:   CALL    HABATA
53330           CALL    RTURN
53340           DEFB    128,128,128,2,0,0
53350           CALL    MOVE
53360           DEFB    0,0,-8,2,0,0
53370           ;
53380 CHARA4:   CALL    RND
53390           AND     127
53400           ADD     A,64
53410           LD      (CHARD4+4),A
53420           CALL    RND
53430           AND     31
53440           ADD     A,180
53450           LD      (CHARD4+5),A
53460           CALL    DSET
53470 CHARD4:   DEFW    CHPD11,CHARP4
53480           DEFB    0,0,240,0,0,0
53490           DEFB    11,1,00000000B
53500           RET
53510 ;
53520 ; STAGE 2 -- CHARACTER 6
53530 ;
53540 CHARA6:   CALL    RND
53550           CP      190
53560           JR      NC,$-5
53570           ADD     A,35
53580           LD      (CHARD6+4),A
53590           CALL    RND
53600           CP      190
53610           JR      NC,$-5
53620           ADD     A,25
53630           LD      (CHARD6+5),A
53640           CALL    DSET
53650 CHARD6:   DEFW    CHPD11,CHARP6
53660           DEFB    0,0,255,0,0,0
53670           DEFB    9,1,00000000B
53680           RET
53690           ;
53700 CHARP6:   CALL    HABATA
53710           LD      A,(IX+9)
53720           SUB     24
53730           LD      (IX+9),A
53740           RET
53830 ;
53840 ; STAGE 2 -- BOSS
53850 ;
53860 BOSS2:    LD      A,H
53870           LD      (BOSRD2+5),A
53880           LD      A,L
53890           LD      (BOSRD2+10),A
53900           CALL    DSET
53910 BOSRD2:   DEFW    CHPD11,BOSMV
53920           DEFB    192,128,102,0,0,0
53930           DEFB    7,8,00000000B
53940           RET
53950           ;
53951 BOSMV:    LD      A,(PORIDAT)
53952           OR      A
53953           JR      NZ,$+6
53955           LD      (IX+0),A
53956           RET
53960           CALL    RND
53970           AND     31
53980           CALL    Z,FUN
53990           CALL    HABATA
54000           CP      4
54010           JR      NC,$+11
54020           CALL    MOVE
54030           DEFB    0,0,-18,0,0,-2
54040           CP      12
54050           JR      NC,$+11
54060           CALL    MOVE
54070           DEFB    -18,0,0,0,0,-1
54080           CP      16
54090           JR      NC,$+11
54100           CALL    MOVE
54110           DEFB    0,0,18,0,0,-2
54120           CP      24
54130           JR      NC,$+11
54140           CALL    MOVE
54150           DEFB    18,0,0,0,0,-1
54160           XOR     A
54170           LD      (IX+1),A
54180           JR      BOSMV
54190           ;
54200 BOSMV2:   LD      A,(IX+1)
54210           INC     (IX+1)
54220           CP      16
54230           JR      NC,$+11
54240           CALL    MOVE
54250           DEFB    0,8,0,0,0,1
54260           CP      32
54270           JR      NC,$+11
54280           CALL    MOVE
54290           DEFB    0,-8,0,0,0,1
54300           XOR     A
54310           LD      (IX+1),A
54320           JR      BOSMV2
54330           ;
54331 BOSMV3:   LD      A,(PORIDAT)
54332           OR      A
54333           JR      NZ,$+6
54335           LD      (IX+0),A
54336           RET
54340           CALL    HABATA
54350           CP      16
54360           JR      NC,$+11
54370           LD      A,(IX+8)
54380           ADD     A,8
54390           LD      (IX+8),A
54400           RET
54410           CP      32
54420           JR      NC,$+11
54430           LD      A,(IX+8)
54440           SUB     8
54450           LD      (IX+8),A
54460           RET
54470           XOR     A
54480           LD      (IX+1),A
54490           JR      BOSMV3
54500 ;
54501 ; BOSS - FUN
54502 ;
54510 FUN:      LD      A,(IX+7)
54520           LD      (FUNRD+4),A
54530           LD      A,(IX+8)
54540           LD      (FUNRD+5),A
54550           LD      A,(IX+9)
54560           LD      (FUNRD+6),A
54570           CALL    DSET
54580 FUNRD:    DEFW    FUNPD,FUNMV
54590           DEFB    0,0,0,0,0,0
54600           DEFB    8,1,00000000B
54610           RET
54620           ;
54630 FUNMV:    LD      A,(IX+8)
54640           ADD     A,16
54650           LD      (IX+8),A
54660           RET
54670           ;
54700 FUNPD:    DEFB    4,0
54710           DEFB     -8,  5, -5
54720           DEFB      8,  5, -5
54730           DEFB      0,  5,  9
54740           DEFB      0, -9,  0
54750           DEFB    1,2,3,1,4,2,0
54760           DEFB    4,3,0,0
54770           ;
54780 END:      EQU     $
