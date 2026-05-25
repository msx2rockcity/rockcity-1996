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
2000           ORG     25EDH
30000 ;
30010 ;---- STAGE3 PROGRAM ----
30020 ;
30030 STAGE3:   CALL    CLSPRI
30040           LD      (STACK),SP
30060           LD      A,00001000B
30070           LD      (SWHICH),A
30080           CALL    DSET
30090           DEFW    STAGM1,MHYOUJ
30100           DEFB    7,40,0,0,0,44
30110           DEFB    0,0,00010101B
30120           CALL    DSET
30130           DEFW    STAGM2,MHYOUJ
30140           DEFB    7,40,0,0,0,46
30150           DEFB    55,0,00000101B
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
30400         ; JP      BOSS
30410           LD      B,192
30420 LOOP:     LD      HL,RETLOP
30430           PUSH    HL
30440           CALL    CURE
30450           CALL    TURBO
30460           CALL    RND
30470           CP      40
30480           CALL    C,TECHNO
30490           CALL    RND
30500           CP      30
30510           CALL    C,PARTY
30520           LD      A,B
30530           CP      160
30540           JR      C,SJ1
30550           CALL    CHARA1
30560           JP      CHARA6
30570           ;
30580 SJ1:      CP      90
30590           JR      C,SJ2
30600           CALL    RND
30610           CP      120
30620           CALL    C,CHARA1
30630           CALL    RND
30640           CP      100
30650           JP      C,CHARA6
30660           CP      180
30670           JP      C,CHARA3
30680           JP      CHARA4
30690           ;
30700 SJ2:      CP      15
30710           JR      C,SJ3
30720           AND     15
30730           CALL    Z,CHARA5
30740           CALL    RND
30750           CP      100
30760           CALL    C,CHARA1
30770           CALL    RND
30780           CP      60
30790           JP      C,CHARA6
30800           CP      120
30810           JP      C,CHARA3
30820           CP      180
30830           JP      C,CHARA4
30840           CP      190
30850           JP      C,CHARA2
30860           RET
30870           ;
30880 SJ3:      CP      14
30890           CALL    Z,CHARA8
30900           RET
30910           ;
30920 RETLOP:   LD      A,4
30930           CALL    MAIN
30940           DJNZ    LOOP
30950           ;
30960           LD      A,(SWHICH)
30970           AND     11111110B
30980           LD      (SWHICH),A
30990           LD      HL,CONT2
31000           LD      (CONTRT),HL
31010           ;
31020 CONT2:    LD      A,32
31030           CALL    MAIN
31040           LD      B,192
31050 LOOP2:    CALL    TURBO
31060           CALL    CURE
31070           LD      HL,RETLP2
31080           PUSH    HL
31090           LD      A,B
31100           AND     31
31110           JP      Z,CHARA8
31120           CALL    RND
31130           CP      80
31140           CALL    C,CHARA1
31150           CALL    RND
31160           CP      70
31170           JP      C,CHARA6
31180           CP      115
31190           JP      C,CHARA4
31200           CP      145
31210           JP      C,CHARA3
31220           CP      155
31230           JP      C,CHARA2
31240           CP      165
31250           JP      C,CHARA7
31260           CP      200
31270           JP      C,TECHNO
31280           CP      240
31290           JP      C,PARTY
31300           CP      248
31310           JP      C,CHARA5
31320           RET
31330           ;
31340 RETLP2:   LD      A,B
31350           RLCA
31360           RLCA
31370           AND     3
31380           ADD     A,3
31390           CALL    MAIN
31400           DJNZ    LOOP2
31410           LD      A,32
31420           CALL    MAIN
31430           JP      BOSS
31440 ;
31450 ; STAGE3 DATA
31460 ;
31470 STAGD1:   DEFB    32,5,5,2
31480           DEFB    01011011B
31490           DEFW    CONT,DEAD
31500           ;
31510 JPDAT1:   DEFW    TUCH0,TUCH1
31520           DEFW    TUCH2,TUCH3
31530           DEFW    TUCH4,TUCH5
31540           DEFW    TUCH6,TUCH6
31550           DEFW    TUCH0,TUCH0
31560           DEFW    TUCH0,TUCH0
31570           DEFW    TUCH0,TUCH0
31580           DEFW    TUCH0,TUCH0
31590           ;
31600 STAGM1:   DEFB    'Z',60,80
31610           DEFB    'O',75,80
31620           DEFB    'N',90,80
31630           DEFB    'E',105,80
31640           DEFB    '3',120,80,0
31650 STAGM2:   DEFB    'I',30,80
31660           DEFB    'C',45,80
31670           DEFB    'E',60,80
31680           DEFB    'L',90,80
31690           DEFB    'A',105,80
31700           DEFB    'N',120,80
31710           DEFB    'D',135,80,0
40000 ;
40010 ; STAGE 3 -- CHARACTER 1
40020 ;
40030 CHARA1:   CALL    RND
40040           LD      (CHARD1+4),A
40050           CALL    RND
40060           AND     31
40070           LD      (CHARD1+5),A
40080           LD      HL,CHARP1
40090           AND     1
40100           JR      Z,$+5
40110           LD      HL,CHRP12
40120           LD      (CHARD1+2),HL
40130           CALL    DSET
40140 CHARD1:   DEFW    CHAPD1,CHARP1
40150           DEFB    0,20,255,0,0,0
40160           DEFB    7,1,00000000B
40170           RET
40180           ;
40190 CHAPD1:   DEFB    6,2
40200           DEFB    -10,  0, 10
40210           DEFB     10,  0, 10
40220           DEFB      0,  0,-10
40230           DEFB      0, 80,  0
40240           DEFB      0, 25, -6
40250           DEFB      0, 50, -3
40260           DEFB    1,2,3,1,4,3,0,2,4,0,0
40270           ;
40280 CHPD12:   DEFB    6,2
40290           DEFB    -10,  0, 10
40300           DEFB     10,  0, 10
40310           DEFB      0,  0,-10
40320           DEFB      0,-80,  0
40330           DEFB      0,-25, -6
40340           DEFB      0,-50, -3
40350           DEFB    1,4,3,0,4,2,0,0,4,0,0
40360           ;
40370 CHARP1:   LD      A,(IX+1)
40380           CP      1
40390           JR      Z,CHRP1J
40400           LD      A,(IX+9)
40410           SUB     24
40420           LD      (IX+9),A
40430           LD      A,(MASTER+9)
40440           XOR     (IX+9)
40450           CP      40
40460           RET     NC
40470           LD      A,1
40480           LD      (IX+1),A
40490           RET
40500 CHRP1J:   LD      A,(IX+8)
40510           ADD     A,32
40520           LD      (IX+8),A
40530           RET
40540           ;
40550 CHRP12:   LD      A,(IX+9)
40560           SUB     24
40570           LD      (IX+9),A
40580           RET
40590 ;
40600 ; STAGE 3 -- CHARACTER 2
40610 ;
40620 CHARA2:   CALL    RND
40630           AND     63
40640           ADD     A,64
40650           LD      (CHARD2+4),A
40660           ADD     A,32
40670           LD      (CHAR22+4),A
40680           CALL    RND
40690           AND     127
40700           ADD     A,64
40710           LD      (CHARD2+5),A
40720           LD      (CHAR22+5),A
40730           CALL    DSET
40740 CHARD2:   DEFW    CHAPD2,CHARP2
40750           DEFB    128,128,245,0,0,0
40760           DEFB    7,2,00000010B
40770           CALL    DSET
40780 CHAR22:   DEFW    CHAPD2,CHRP22
40790           DEFB    128,128,245,0,0,0
40800           DEFB    7,2,00000010B
40810           RET
40820           ;
40830 CHAPD2:   DEFB    10,2
40840           DEFB     -6,-28, -6
40850           DEFB     -6,-28,  6
40860           DEFB      6,-28,  6
40870           DEFB      6,-28, -6
40880           DEFB     -6, 28, -6
40890           DEFB     -6, 28,  6
40900           DEFB      6, 28,  6
40910           DEFB      6, 28, -6
40920           DEFB      0,  0,  0
40930           DEFB      0, -9,  0
40940           DEFB    1,2,3,4,1,5,6
40950           DEFB    7,8,5,0,4,8,0
40960           DEFB    3,7,0,2,6,0,0
40970           ;
40980 CHARP2:   LD      A,(IX+1)
40990           INC     (IX+1)
41000           CP      3
41010           JR      NC,$+11
41020           CALL    MOVE
41030           DEFB    -16,0,-10,0,0,0
41040           CP      6
41050           JR      NC,$+11
41060           CALL    MOVE
41070           DEFB    16,0,-10,0,0,0
41080           XOR     A
41090           LD      (IX+1),A
41100           JR      CHARP2
41110           ;
41120 CHRP22:   LD      A,(IX+1)
41130           INC     (IX+1)
41140           CP      3
41150           JR      NC,$+11
41160           CALL    MOVE
41170           DEFB    16,0,-10,0,0,0
41180           CP      6
41190           JR      NC,$+11
41200           CALL    MOVE
41210           DEFB    -16,0,-10,0,0,0
41220           XOR     A
41230           LD      (IX+1),A
41240           JR      CHRP22
41250 ;
41260 ; STAGE3 -- CHARACTER 3
41270 ;
41280 CHARA3:   CALL    RND
41290           CP      210
41300           JR      NC,$-5
41310           ADD     A,20
41320           LD      (CHARD3+4),A
41330           CALL    RND
41340           CP      210
41350           JR      NC,$-5
41360           ADD     A,20
41370           LD      (CHARD3+5),A
41380           CALL    DSET
41390 CHARD3:   DEFW    CHAPD3,CHARP3
41400           DEFB    0,0,245,0,0,0
41410           DEFB    7,1,00000000B
41420           RET
41430           ;
41440 CHARP3:   LD      A,(IX+9)
41450           SUB     33
41460           LD      (IX+9),A
41470           LD      A,(IX+8)
41480           XOR     16
41490           LD      (IX+8),A
41500           LD      A,(IX+13)
41510           XOR     2
41520           LD      (IX+13),A
41530           RET
41540           ;
41550 CHAPD3:   DEFB    9,1
41560           DEFB    -16,-16,-16
41570           DEFB     16,-16,-16
41580           DEFB    -16, 16,-16
41590           DEFB     16, 16,-16
41600           DEFB    -16,-16, 16
41610           DEFB     16,-16, 16
41620           DEFB    -16, 16, 16
41630           DEFB     16, 16, 16
41640           DEFB      0,  0,  0
41650           DEFB    1,2,4,3,7,5,1,3,0
41660           DEFB    5,6,8,7,0,6,2,0,8,4,0,0
41670 ;
41680 ; STAGE 3 -- BOSS
41690 ;
41700 BOSS:     LD      A,(SWHICH)
41710           OR      00000001B
41715           AND     11111011B
41720           LD      (SWHICH),A
41730           LD      A,24
41740           CALL    MAIN
41750           CALL    CLSPRI
41755           ;
41760           LD      A,1
41770           LD      (SCOLOR+1),A
41780           LD      A,1
41790           LD      HL,HOME
41800           LD      (MASTER+5),HL
41810           LD      A,1
41820           CALL    MAIN
41830           LD      A,(MASTER+1)
41840           OR      A
41850           JR      NZ,$-9
41860           ;
41870           CALL    DSET
41880           DEFW    PARPT1,CLPTR2
41890           DEFB    128,255,240,0,0,0
41900           DEFB    11,0,00001010B
41910           LD      A,20
41920           CALL    MAIN
41930           LD      HL,CLPTR
41940           LD      (MASTER+5),HL
41950           XOR     A
41960           LD      (SCOLOR+1),A
41970           LD      A,32
41980           CALL    MAIN
42000           ;
42150           CALL    DSET
42160           DEFW    STAGM1,MHYOUJ
42170           DEFB    7,24,0,0,0,38,8
42180           DEFB    0,00000101B
42190           CALL    DSET
42200           DEFW    CLEARM,MHYOUJ
42210           DEFB    7,24,0,0,0,38,134
42220           DEFB    0,00000101B
42230           LD      A,28
42240           CALL    MAIN
42250           CALL    DSET
42260           DEFW    BONUSM,MHYOUJ
42270           DEFB    7,24,0,0,0,0,55
42280           DEFB    0,00000101B
42281           CALL    DSET
42282           DEFW    SCOREM,MHYOUJ
42283           DEFB    7,24,0,0,0,8,80
42284           DEFB    0,00010101B
42290           LD      HL,(SCORE)
42300           LD      DE,3000
42310           ADD     HL,DE
42320           JR      NC,$+5
42330           LD      HL,65535
42340           LD      (SCORE),HL
42350           LD      A,(STOCK)
42360           ADD     A,2
42370           CP      10
42380           JR      C,$+4
42390           LD      A,9
42400           LD      (STOCK),A
42410           LD      A,30
42420           CALL    MAIN
42430           CALL    FADE
42440           LD      A,24
42450           CALL    MAIN
42460           RET
42470           ;
42480 CLPTR:    LD      A,(IX+1)
42490           INC     (IX+1)
42500           CP      8
42510           JR      NC,$+11
42520           LD      A,(IX+9)
42530           ADD     A,6
42540           LD      (IX+9),A
42550           RET
42555           CP      16
42556           RET     NC
42560           LD      A,(IX+8)
42570           ADD     A,12
42580           LD      (IX+8),A
42590           INC     (IX+12)
42610           RET
42620           ;
42630 CLPTR2:   LD      A,(IX+1)
42640           INC     (IX+1)
42650           CP      16
42660           RET     NC
42670           LD      A,(IX+9)
42680           SUB     6
42690           LD      (IX+9),A
42700           RET
42710           ;
42820 ATACKM:   DEFB  'A',9,0,'T',32,0,'A',55,0,'C',79,0,'K',106,0,0
42830 CLEARM:   DEFB  'C',60,30,'L',75,30,'E',90,30,'A',105,30,'R',120,30,0
42840 BONUSM:   DEFB  'B',88,30,'O',108,30,'N',128,30,'U',148,30,'S',168,30,0
42850 SCOREM:   DEFB  '3',98,60,'0',113,60,'0',128,60,'0',142,60
42860           DEFB  '2',98,90,'U',113,90,'P',128,90,0
42870 ;
42880 ; STAGE 3 -- CHARACTER 5
42890 ;
42900 CHARA5:   CALL    DSET
42910           DEFW    CHAPD5,CHARP5
42920           DEFB    128,128,255,0,0,0
42930           DEFB    7,2,00000010B
42940           RET
42950           ;
42960 CHAPD5:   DEFB    10,4
42970           DEFB      0,-30,-10
42980           DEFB     26,-15,  0
42990           DEFB     26, 15,-10
43000           DEFB      0, 30,  0
43010           DEFB    -26, 15,-10
43020           DEFB    -26,-15,  0
43030           DEFB      0,  0,  0
43040           DEFB    -16,  0, -5
43050           DEFB      8,-15, -5
43060           DEFB      8, 15, -5
43070           DEFB    1,2,5,6,3,4,1,0,0
43080           ;
43090 CHARP5:   LD      A,(LIFE)
43100           OR      A
43110           JR      Z,RP5END
43120           LD      A,(IX+1)
43130           INC     (IX+1)
43140           AND     3
43150           LD      HL,HOME
43160           JR      Z,$+5
43170           LD      HL,KEY
43180           LD      (MASTER+5),HL
43190 RP5END:   LD      A,(IX+13)
43200           XOR     2
43210           LD      (IX+13),A
43220           CALL    MOVE
43230           DEFB    0,0,-8,3,0,0
43240 ;
43250 ; STAGE 3 -- CHARACTER 4
43260 ;
43270 CHAPD4:   DEFB    5,1
43280           DEFB    -25,-25,  0
43290           DEFB     25,-25,  0
43300           DEFB     25, 25,  0
43310           DEFB    -25, 25,  0
43320           DEFB      0,  0,  0
43330           DEFB    1,2,3,4,1,0,0
43340           ;
43350 CHARP4:   LD      A,(IX+13)
43360           XOR     2
43370           LD      (IX+13),A
43380           CALL    MOVE
43390           DEFB    0,0,-32,2,0,3
43400           ;
43410 CHRP42:   LD      A,(IX+13)
43420           XOR     2
43430           LD      (IX+13),A
43440           CALL    MOVE
43450           DEFB    0,0,-32,0,-3,0
43460           ;
43470 CHARA4:   CALL    RND
43480           LD      (CHARD4+4),A
43490           CALL    RND
43500           LD      (CHARD4+5),A
43510           LD      HL,CHARP4
43520           AND     1
43530           JR      Z,$+5
43540           LD      HL,CHRP42
43550           LD      (CHARD4+2),HL
43560           CALL    DSET
43570 CHARD4:   DEFW    CHAPD4,CHRP42
43580           DEFB    0,0,255,0,0,0
43590           DEFB    7,1,00000000B
43600           RET
43610 ;
43620 ; STAGE 3 -- CHARACTER 6
43630 ;
43640 CHARA6:   CALL    RND
43650           LD      (CHARD6+4),A
43660           CALL    DSET
43670 CHARD6:   DEFW    CHPD12,CHARP6
43680           DEFB    0,235,255,0,0,0
43690           DEFB    7,1,00000000B
43700           RET
43710           ;
43720 CHARP6:   LD      A,(IX+9)
43730           SUB     24
43740           LD      (IX+9),A
43750           RET
43760 ;
43770 ; STAGE 3 -- CHARACTER 7
43780 ;
43790 CHARA7:   CALL    RND
43800           AND     127
43810           ADD     A,64
43820           LD      (CHARD7+5),A
43830           CALL    DSET
43840 CHARD7:   DEFW    CHAPD2,CHARP7
43850           DEFB    30,128,255,0,0,0
43860           DEFB    7,2,00000010B
43870           RET
43880           ;
43890 CHARP7:   LD      A,(IX+11)
43900           ADD     A,3
43910           LD      (IX+11),A
43920           LD      A,(IX+1)
43930           INC     (IX+1)
43940           CP      5
43950           JR      NC,$+5
43960           JP      CHARP6
43970           CP      29
43980           JR      NC,CHARP6
43990           CALL    RTURN
44000           DEFB    128,128,144,0,0,2
44010           INC     (IX+12)
44020           INC     (IX+12)
44030           RET
44040 ;
44050 ; STAGE 3 -- CHARACTER 8
44060 ;
44070 CHARA8:   CALL    DSET
44080           DEFW    CHAPD8,CHRP81
44090           DEFB    128,20,40,0,0,0
44100           DEFB    11,2,00000000B
44110           CALL    DSET
44120           DEFW    CHAPD5,CHRP82
44130           DEFB    128,20,40,0,8,0
44140           DEFB    11,2,00000000B
44150           RET
44160           ;
44170 CHARP8:   LD      A,(IX+1)
44180           INC     (IX+1)
44190           CP      46
44200           JR      NC,$+11
44210           LD      A,(IX+8)
44220           ADD     A,4
44230           LD      (IX+8),A
44240           RET
44250           CALL    RTURN
44260           DEFB    128,128,128,2,0,0
44270           LD      A,(IX+9)
44280           ADD     A,8
44290           LD      (IX+9),A
44300           RET
44310           ;
44320 CHRP81:   CALL    CHARP8
44330           LD      A,(IX+1)
44340           CP      46
44350           RET     C
44360           JP      BACURA
44370           ;
44380 CHRP82:   CALL    CHARP8
44390           LD      A,(IX+10)
44400           ADD     A,3
44410           LD      (IX+10),A
44420           RET
44430           ;
44440 CHAPD8:   DEFB    7,0
44450           DEFB    -15,  5,-10
44460           DEFB    -15, 35,-10
44470           DEFB     15,  5,-10
44480           DEFB     15, 35,-10
44490           DEFB      0, 20, 40
44500           DEFB      0, -5,  0
44510           DEFB      0, 10,  0
44520           DEFB    1,2,4,3,1,5,2,0
44530           DEFB    3,5,4,0,6,7,0,0
44540 ;
44550 ; STAGE 3 -- BACURA
44560 ;
44570 BACURA:   LD      A,(IX+7)
44580           LD      (BACURD+4),A
44590           LD      A,(IX+8)
44600           LD      (BACURD+5),A
44610           LD      A,(IX+9)
44620           LD      (BACURD+6),A
44630           CALL    DSET
44640 BACURD:   DEFW    CHAPD4,BACURP
44650           DEFB    0,0,0,0,0,0
44660           DEFB    10,1,00000100B
44670           RET
44680           ;
44690 BACURP:   LD      A,(IX+10)
44700           SUB     3
44710           LD      (IX+10),A
44720           LD      A,(IX+9)
44730           SUB     24
44740           JP      C,MALEND
44750           LD      (IX+9),A
44760           RET
44770           ;
44780 END:      EQU     $
