500 TOP1:      EQU     0100H
600 TOP2:      EQU     09F7H
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
1280 GTSTCK:   EQU     00D5H
1290 GTTRIG:   EQU     00D8H
1295 THEEND:   EQU     0C500H
1300           ORG     1032H
20000 ;
20010 ;---- MALTI STAGE SUB ROUTINE ----
20020 ;
20030 ;
20040 ; TRIGER & STICK
20050 ;
20060 STRIG:    PUSH    BC
20070           PUSH    DE
20080           PUSH    HL
20090           PUSH    IX
20100           XOR     A
20110           LD      IX,GTTRIG
20120           LD      IY,(EXPTBL-1)
20130           CALL    CALSLT
20140           INC     A
20150           JR      Z,RETSTR
20160           LD      IX,GTTRIG
20170           LD      IY,(EXPTBL-1)
20180           CALL    CALSLT
20190           INC     A
20200 RETSTR:   POP     IX
20210           POP     HL
20220           POP     DE
20230           POP     BC
20240           RET
20250           ;
20260 STICK:    PUSH    BC
20270           PUSH    DE
20280           PUSH    HL
20290           PUSH    IX
20300           XOR     A
20310           LD      IX,GTSTCK
20320           LD      IY,(EXPTBL-1)
20330           CALL    CALSLT
20340           OR      A
20350           JR      NZ,RETSTI
20355           INC     A
20360           LD      IX,GTSTCK
20370           LD      IY,(EXPTBL-1)
20380           CALL    CALSLT
20400 RETSTI:   POP     IX
20410           POP     HL
20420           POP     DE
20430           POP     BC
20440           RET
21000 ;
21010 ; DEAD ROUTINE
21020 ;
21030 DEAD:     LD      SP,(STACK)
21040           LD      HL,DEADPT
21050           LD      (MASTER+5),HL
21060           LD      A,(SWHICH)
21070           AND     11101111B
21080           LD      (SWHICH),A
21090           LD      HL,0
21100           LD      (GAGE),HL
21110           LD      A,45
21120           CALL    MAIN
21130           CALL    FADE
21140           LD      A,8
21150           CALL    MAIN
21160           LD      A,(STOCK)
21170           DEC     A
21180 JPDEAD:   JP      Z,THEEND
21190           LD      (STOCK),A
21200           CALL    MSSTR
21210           LD      HL,(CONTRT)
21220           JP      (HL)
21230           ;
21240 DEADPT:   LD      A,(IX+9)
21250           ADD     A,6
21260           CP      200
21270           JR      NC,$+12
21280           LD      (IX+9),A
21290           INC     (IX+10)
21295           INC     (IX+10)
21300           RET
21310           LD      A,00011000B
21320           LD      (IX+15),A
21330           LD      A,(SWHICH)
21340           AND     11111001B
21350           LD      (SWHICH),A
21360           RET
22000 ;
22010 ; TUCH ROUTINE ( 0 - 4 )
22020 ;
22030 TUCH0:    RET
22040           ;
22050 TUCH1:    LD      A,(SWHICH)
22060           BIT     5,A
22070           RET     NZ
22080           LD      A,(LIFE)
22090           OR      A
22100           JR      Z,$+6
22110           DEC     A
22120           LD      (LIFE),A
22130           XOR     A
22140           LD      (IX+0),A
22150           RET
22160           ;
22170 TUCH2:    XOR     A
22180           LD      (IX+2),A
22190           LD      A,(MASTER+13)
22200           LD      (LIDAT+4),A
22210           LD      A,(SWHICH)
22220           BIT     5,A
22230           RET     NZ
22240           LD      A,(LIFE)
22250           SUB     2
22260           JR      NC,$+3
22270           XOR     A
22280           LD      (LIFE),A
22290           RET
22300           ;
22310 TUCH3:    LD      A,(LIFE)
22320           ADD     A,4
22330           CP      17
22340           JR      C,$+4
22350           LD      A,16
22360           LD      (LIFE),A
22370           XOR     A
22380           LD      (IX+0),A
22390           LD      (IX+2),A
22400           RET
22410           ;
22420 TUCH4:    LD      A,(SWHICH)
22430           XOR     00000100B
22440           LD      (SWHICH),A
22450           XOR     A
22460           LD      (IX+0),A
22470           LD      (IX+2),A
22480           RET
23000 ;
23010 ; MASTER START ROUTINE
23020 ;
23030 MSSTR:    LD      HL,MSSTDT
23040           LD      DE,MASTER
23050           LD      BC,16
23060           LDIR
23070           LD      A,16
23080           LD      (LIFE),A
23090           LD      A,(SWHICH)
23100           OR      00010010B
23110           LD      (SWHICH),A
23120           CALL    CLSPRI
23130           CALL    DSET
23140           DEFW    STARTM,MHYOUJ
23150           DEFB    7,24,1,1,0,40
23160           DEFB    0,0,00110101B
23170           CALL    UNFADE
23180           RET
23190           ;
23200 MSSTDT:   DEFB    1,0,0
23210           DEFW    MSDATA,STARPT
23220           DEFB    128,128,128
23230           DEFB    0,0,0,8,0
23240           DEFB    00101000B
23250           ;
23260 STARTM:   DEFB    'G',40,80
23270           DEFB    'O',55,80
23280           DEFB    'A',75,80
23290           DEFB    'H',90,80
23300           DEFB    'E',105,80
23310           DEFB    'A',120,80
23320           DEFB    'D',135,80,0
23330           ;
23340 STARPT:   LD      A,(IX+9)
23350           SUB     8
23360           CP      16
23370           JR      C,$+6
23380           LD      (IX+9),A
23390           RET
23400           LD      HL,KEY
23410           LD      (IX+5),L
23420           LD      (IX+6),H
23430           RET
24000 ;
24010 ; TURBO ROUTINE
24020 ;
24030 TURBO:    LD      A,0
24040           INC     A
24050           LD      (TURBO+1),A
24060           AND     15
24070           RET     NZ
24080           CALL    RND
24090           CP      200
24100           JR      NC,$-5
24110           ADD     A,30
24120           LD      (TURBRD+4),A
24130           CALL    RND
24140           CP      185
24150           JR      NC,$-5
24160           ADD     A,40
24170           LD      (TURBRD+5),A
24180           CALL    DSET
24190 TURBRD:   DEFW    TURBPT,TURBMV
24200           DEFB    0,0,255,0,0,0
24210           DEFB    13,4,00000000B
24220           RET
24230           ;
24240 TURBMV:   CALL    MOVE
24250           DEFB    0,0,-16,0,3,0
24260           ;
24270 TURBPT:   DEFB    9,0
24280           DEFB     12,-24,  0
24290           DEFB    -18,  6,  0
24300           DEFB      6, 18,  0
24310           DEFB      3,-36,  0
24320           DEFB    -21, 12,-18
24330           DEFB    -21, 12, 18
24340           DEFB     27,-24,  0
24350           DEFB      3, 24,-18
24360           DEFB      3, 24, 18
24370           DEFB     1,2,3,1,0,4,5,6,4,0
24380           DEFB     7,8,9,7,0,0
25000 ;
25010 ; CURE ROUTINE
25020 ;
25030 CURE:     LD      A,0
25040           INC     A
25050           LD      (CURE+1),A
25060           AND     31
25070           RET     NZ
25080           CALL    RND
25090           CP      205
25100           JR      NC,$-5
25110           ADD     A,25
25120           LD      (CURERD+4),A
25130           CALL    RND
25140           CP      190
25150           JR      NC,$-5
25160           ADD     A,33
25170           LD      (CURERD+5),A
25180           CALL    DSET
25190 CURERD:   DEFW    CURPD1,CUREMV
25200           DEFB    0,0,255,0,0,0
25210           DEFB    9,3,00000000B
25220           RET
25230           ;
25240 CUREMV:   LD      A,(IX+1)
25250           INC     (IX+1)
25260           LD      HL,CURPD1
25270           AND     2
25280           JR      NZ,$+5
25290           LD      HL,CURPD2
25300           LD      (IX+4),H
25310           LD      (IX+3),L
25320           LD      A,(IX+9)
25330           SUB     24
25340           LD      (IX+9),A
25350           RET
25360           ;
25370 CURPD1:   DEFB    6,0
25380           DEFB      0,-18,  0
25390           DEFB      0, 18,  0
25400           DEFB      0,  0,-22
25410           DEFB    -22,  0,  0
25420           DEFB      0,  0, 22
25430           DEFB     22,  0,  0
25440           DEFB    1,4,2,6,1,0,5,4,3,6,5,0
25450           DEFB    1,3,2,5,1,0,0
25460           ;
25470 CURPD2:   DEFB    6,0
25480           DEFB      0,-28,  0
25490           DEFB      0, 28,  0
25500           DEFB      0,  0,-12
25510           DEFB    -12,  0,  0
25520           DEFB      0,  0, 12
25530           DEFB     12,  0,  0
25540           DEFB    1,4,2,6,1,0,5,4,3,6,5,0
25550           DEFB    1,3,2,5,1,0,0
26000 ;
26010 ; TECHNOITE ROUTINE
26020 ;
26030 TECHPT:   DEFB    6,0
26040           DEFB    -23,-23,  3
26050           DEFB      0, 18,  3
26060           DEFB     18,  0,  3
26070           DEFB    -23,-23, -3
26080           DEFB      0, 18, -3
26090           DEFB     18,  0, -3
26100           DEFB    1,2,3,1,0,4,5,6,4,0
26110           DEFB    1,4,0,2,5,0,3,6,0,0
26120           ;
26130 TECHMV:   CALL    MOVE
26140           DEFB    0,0,-26,0,0,3
26150           ;
26160 TECHNO:   CALL    RND
26170           CP      215
26180           JR      NC,$-5
26190           ADD     A,23
26200           LD      (TECHRD+4),A
26210           CALL    RND
26220           CP      215
26230           JR      NC,$-5
26240           ADD     A,23
26250           LD      (TECHRD+5),A
26260           CALL    RND
26270           LD      C,8
26280           AND     15
26290           JR      Z,CJ4
26300           LD      C,7
26310           CP      13
26320           JR      NC,CJ4
26330           LD      C,3
26340           CP      9
26350           JR      NC,CJ4
26360           LD      C,10
26370 CJ4:      LD      A,C
26380           LD      (TECHRD+10),A
26390           CALL    DSET
26400 TECHRD:   DEFW    TECHPT,TECHMV
26410           DEFB    0,0,255,0,0,0
26420           DEFB    0,5,00000000B
26430           RET
26440           ;
26450 TUCH5:    LD      A,(IX+13)
26460           LD      DE,400
26470           CP      8
26480           JR      Z,TJ5
26490           LD      DE,200
26500           CP      7
26510           JR      Z,TJ5
26520           LD      DE,100
26530           CP      3
26540           JR      Z,TJ5
26550           LD      DE,50
26560 TJ5:      LD      HL,(SCORE)
26570           ADD     HL,DE
26580           JR      NC,$+5
26590           LD      HL,65535
26600           LD      (SCORE),HL
26610           XOR     A
26620           LD      (IX+0),A
26630           LD      (IX+2),A
26640           RET
27000 ;
27010 ; MINING PARTY
27020 ;
27030 PARPD1:   DEFB    7,0
27040           DEFB    -12,  0,-12
27050           DEFB     -5,  0, 16
27060           DEFB     20,  0, -2
27070           DEFB      0,-30,  0
27080           DEFB      0,-60,  0
27090           DEFB     20,-52,  0
27100           DEFB      0,-44,  0
27110           DEFB    1,2,3,1,4,2,0,3,4,5,6,7,0,0
27120           ;
27130 PARPD2:   DEFB    7,0
27140           DEFB      0,-40,  0
27150           DEFB     12,-40,  0
27160           DEFB      0,-30,  0
27170           DEFB    -12,-40,  0
27180           DEFB      0,-20,  0
27190           DEFB    -10,  0,  0
27200           DEFB     10,  0,  0
27210           DEFB    1,3,5,6,0,4,3,2,0,5,7,0,0
27220           ;
27230 PARTY:    CALL    RND
27240           CP      224
27250           JR      NC,$-5
27260           ADD     A,12
27270           LD      (PARRD+4),A
27280           CALL    RND
27290           AND     7
27300           LD      HL,PARPD1
27310           LD      C,7
27320           JR      Z,$+7
27330           LD      HL,PARPD2
27340           LD      C,6
27350           LD      (PARRD+0),HL
27360           LD      A,C
27370           LD      (PARRD+11),A
27380           CALL    DSET
27390 PARRD:    DEFW    PARPD1,PARMV
27400           DEFB    0,255,255,0,0,0
27410           DEFB    15,6,00000000B
27420           RET
27430           ;
27440 PARMV:    LD      A,(IX+9)
27450           ADD     A,-24
27460           JP      NC,MALEND
27470           LD      (IX+9),A
27480           RET
27490           ;
27500 TUCH6:    LD      A,(IX+14)
27510           LD      DE,250
27520           CP      6
27530           JR      Z,$+5
27540           LD      DE,500
27550           LD      HL,(SCORE)
27560           ADD     HL,DE
27570           JR      NC,$+5
27580           LD      HL,65535
27590           LD      (SCORE),HL
27600           XOR     A
27610           LD      (IX+0),A
27620           LD      (IX+2),A
27630           RET
28000 ;
28010 ; RUNDUM ROUTINE
28020 ;
28030 RND:      PUSH    BC
28040           LD      BC,0
28050           LD      A,R
28060           ADD     A,C
28070           ADD     A,B
28080           LD      C,B
28090           LD      B,A
28100           LD      (RND+2),BC
28110           POP     BC
28120           RET
28500 ;
28510 ; HOME POSITION RETURN
28520 ;
28530 HOME:     LD      A,3
28540           LD      (IX+1),A
28550           LD      A,(IX+7)
28560           CP      128
28570           JR      Z,YPOS
28580           JR      C,HJ1
28590           SUB     16
28600           LD      (IX+7),A
28610           INC     (IX+10)
28650           RET
28660 HJ1:      ADD     A,16
28670           LD      (IX+7),A
28680           DEC     (IX+10)
28720           RET
28730 YPOS:     LD      A,2
28740           LD      (IX+1),A
28750           LD      A,(IX+8)
28760           CP      128
28770           JR      Z,ZPOS
28780           JR      C,HJ2
28790           SUB     4
28800           LD      (IX+8),A
28810           RET
28820 HJ2:      ADD     A,4
28830           LD      (IX+8),A
28840           RET
28850 ZPOS:     LD      A,1
28860           LD      (IX+1),A
28870           LD      A,(IX+9)
28880           CP      16
28890           JR      Z,HJ3
28900           SUB     4
28910           LD      (IX+9),A
28920           RET
28930 HJ3:      XOR     A
28940           LD      (IX+1),A
28950           RET
50000 END:      EQU     $
