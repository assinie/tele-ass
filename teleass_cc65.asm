; da65 V2.17 - Git 334e30c
; Created:    2018-05-13 21:49:27
; Input file: original/teleass.rom
; Page:       1


;        .setcpu "6502"

    * = $c000
#include "telemon.inc"


; ----------------------------------------------------------------------------
RES             = $0000
RESB            = $0002
DECDEB          = $0004
DECFIN          = $0006
DECCIB          = $0008
DECTRV          = $000A
TR0             = $000C
TR1             = $000D
TR2             = $000E
TR3             = $000F
TR5             = $0011
TR6             = $0012
DEFAFF          = $0014
ADSCR           = $0026
HRSY            = $0047
XLPRBI          = $0048                        ; Printer flag (b7)
HRSX40          = $0049
HRSX6           = $004A
HRS1            = $004D
HRS2            = $004F
HRS3            = $0051
HRS4            = $0053
INDIC0          = $0055                        ; Also HRS5
INDIC2          = $0057                        ; Also HRSFB
SCEDEB          = $005C
SCEFIN          = $005E
VARLNG          = $008C
VARAPL          = $00D0
CharGet         = $00E2
CharGot         = $00E8
TXTPTR          = $00E9
VARAPL2         = $00EB
BUFTRV          = $0100
TABDRV          = $0208
FLGTEL          = $020D
SCRX            = $0220
SCRY            = $0224
SCRDX           = $0228
SCRFX           = $022C
SCRDY           = $0230
SCRFY           = $0234
FLGSCR          = $0248
FLGKBD          = $0275
KBDSHT          = $0278
LPRX            = $0286
LPRY            = $0287
LPRFY           = $0289                        ; Nombre de lignes par page pour
; l'imprimante
LPRSY           = $028B                        ; N° de ligne pour le saut de
; page
VNMI            = $02F4
VAPLIC          = $02FD
V1DRB           = $0300
V1DRA           = $0301
V1DDRB          = $0302
V1DDRA          = $0303
V1T1            = $0304
V1T1L           = $0306
V1T2            = $0308
V1ACR           = $030B
V1PCR           = $030C
V1IFR           = $030D
V1ER            = $030E
V1DRAB          = $030F
V2DRA           = $0321
EXBNK           = $040C
VEXBNK          = $0414
BNKCIB          = $0417
DEFBNK          = $04E0                        ; Banque par défaut
BNKSAV          = $04E1                        ; Sauvegarde de la banque couran
;te?
Proc1           = $04E2                        ; Trouver un meilleur nom
; (cf $D101)
Ptr1            = $04EE                        ; Trouver un meilleur nom
Ptr2            = $04F0                        ; Trouver un meilleur nom
Ptr3            = $04F2                        ; b6: Trace, aussi utilisé
; comme pointeur avec $04F3 (adresse emplacement physique pour l'assemblage)
Proc2           = $04F4                        ; Copie de LEA0F-LEA14 (Trouver
; un meilleur nom)
DRIVE           = $0500
ERRNB           = $0512
SAVES           = $0513
BUFNOM          = $0517
VSALO0          = $0528
VSALO1          = $0529
FTYPE           = $052C
INPIS           = $052D                        ; Also DESALO
INSEC           = $052E
PARPIS          = $052F
PARSEC          = $0530
EXSALO          = $0531
EXTDEF          = $055D
BUFEDT          = $0590
; ----------------------------------------------------------------------------
        jmp     teleass_start                   ; C000 4C 70 D0

; ----------------------------------------------------------------------------
; Mnemonics table
MnemonicsTable:
        .byte   "BR"                            ; C003 42 52
        .byte   $CB                             ; C005 CB
        .byte   "CL"                            ; C006 43 4C
        .byte   $C3                             ; C008 C3
        .byte   "CL"                            ; C009 43 4C
        .byte   $C4                             ; C00B C4
        .byte   "CL"                            ; C00C 43 4C
        .byte   $C9                             ; C00E C9
        .byte   "CL"                            ; C00F 43 4C
        .byte   $D6                             ; C011 D6
        .byte   "DE"                            ; C012 44 45
        .byte   $D8                             ; C014 D8
        .byte   "DE"                            ; C015 44 45
        .byte   $D9                             ; C017 D9
        .byte   "IN"                            ; C018 49 4E
        .byte   $D8                             ; C01A D8
        .byte   "IN"                            ; C01B 49 4E
        .byte   $D9                             ; C01D D9
        .byte   "NO"                            ; C01E 4E 4F
        .byte   $D0                             ; C020 D0
        .byte   "PH"                            ; C021 50 48
        .byte   $C1                             ; C023 C1
        .byte   "PH"                            ; C024 50 48
        .byte   $D0                             ; C026 D0
        .byte   "PL"                            ; C027 50 4C
        .byte   $C1                             ; C029 C1
        .byte   "PL"                            ; C02A 50 4C
        .byte   $D0                             ; C02C D0
        .byte   "RT"                            ; C02D 52 54
        .byte   $C9                             ; C02F C9
        .byte   "RT"                            ; C030 52 54
        .byte   $D3                             ; C032 D3
        .byte   "SE"                            ; C033 53 45
        .byte   $C3                             ; C035 C3
        .byte   "SE"                            ; C036 53 45
        .byte   $C4                             ; C038 C4
        .byte   "SE"                            ; C039 53 45
        .byte   $C9                             ; C03B C9
        .byte   "TA"                            ; C03C 54 41
        .byte   $D8                             ; C03E D8
        .byte   "TA"                            ; C03F 54 41
        .byte   $D9                             ; C041 D9
        .byte   "TS"                            ; C042 54 53
        .byte   $D8                             ; C044 D8
        .byte   "TX"                            ; C045 54 58
        .byte   $C1                             ; C047 C1
        .byte   "TX"                            ; C048 54 58
        .byte   $D3                             ; C04A D3
        .byte   "TY"                            ; C04B 54 59
        .byte   $C1                             ; C04D C1
        .byte   "BC"                            ; C04E 42 43
        .byte   $C3                             ; C050 C3
        .byte   "BC"                            ; C051 42 43
        .byte   $D3                             ; C053 D3
        .byte   "BE"                            ; C054 42 45
        .byte   $D1                             ; C056 D1
        .byte   "BN"                            ; C057 42 4E
        .byte   $C5                             ; C059 C5
        .byte   "BM"                            ; C05A 42 4D
        .byte   $C9                             ; C05C C9
        .byte   "BP"                            ; C05D 42 50
        .byte   $CC                             ; C05F CC
        .byte   "BV"                            ; C060 42 56
        .byte   $C3                             ; C062 C3
        .byte   "BV"                            ; C063 42 56
        .byte   $D3                             ; C065 D3
        .byte   "AD"                            ; C066 41 44
        .byte   $C3                             ; C068 C3
        .byte   "AN"                            ; C069 41 4E
        .byte   $C4                             ; C06B C4
        .byte   "AS"                            ; C06C 41 53
        .byte   $CC                             ; C06E CC
        .byte   "BI"                            ; C06F 42 49
        .byte   $D4                             ; C071 D4
        .byte   "CM"                            ; C072 43 4D
        .byte   $D0                             ; C074 D0
        .byte   "CP"                            ; C075 43 50
        .byte   $D8                             ; C077 D8
        .byte   "CP"                            ; C078 43 50
        .byte   $D9                             ; C07A D9
        .byte   "DE"                            ; C07B 44 45
        .byte   $C3                             ; C07D C3
        .byte   "EO"                            ; C07E 45 4F
        .byte   $D2                             ; C080 D2
        .byte   "IN"                            ; C081 49 4E
        .byte   $C3                             ; C083 C3
        .byte   "JM"                            ; C084 4A 4D
        .byte   $D0                             ; C086 D0
        .byte   "JS"                            ; C087 4A 53
        .byte   $D2                             ; C089 D2
        .byte   "LD"                            ; C08A 4C 44
        .byte   $C1                             ; C08C C1
        .byte   "LD"                            ; C08D 4C 44
        .byte   $D8                             ; C08F D8
        .byte   "LD"                            ; C090 4C 44
        .byte   $D9                             ; C092 D9
        .byte   "LS"                            ; C093 4C 53
        .byte   $D2                             ; C095 D2
        .byte   "OR"                            ; C096 4F 52
        .byte   $C1                             ; C098 C1
        .byte   "RO"                            ; C099 52 4F
        .byte   $CC                             ; C09B CC
        .byte   "RO"                            ; C09C 52 4F
        .byte   $D2                             ; C09E D2
        .byte   "SB"                            ; C09F 53 42
        .byte   $C3                             ; C0A1 C3
        .byte   "ST"                            ; C0A2 53 54
        .byte   $C1                             ; C0A4 C1
        .byte   "ST"                            ; C0A5 53 54
        .byte   $D8                             ; C0A7 D8
        .byte   "ST"                            ; C0A8 53 54
        .byte   $D9                             ; C0AA D9
; Pseudo Operations
PseudoOps:
        .byte   "BY"                            ; C0AB 42 59
        .byte   $D4                             ; C0AD D4
        .byte   "EQ"                            ; C0AE 45 51
        .byte   $D5                             ; C0B0 D5
        .byte   "DB"                            ; C0B1 44 42
        .byte   $D4                             ; C0B3 D4
        .byte   "RE"                            ; C0B4 52 45
        .byte   $D3                             ; C0B6 D3
        .byte   "OR"                            ; C0B7 4F 52
        .byte   $C7                             ; C0B9 C7
        .byte   "WR"                            ; C0BA 57 52
        .byte   $C4                             ; C0BC C4
        .byte   "??"                            ; C0BD 3F 3F
        .byte   $BF                             ; C0BF BF
        .byte   "??"                            ; C0C0 3F 3F
        .byte   $BF                             ; C0C2 BF
        .byte   "??"                            ; C0C3 3F 3F
        .byte   $BF                             ; C0C5 BF
; ----------------------------------------------------------------------------
; Oplen
Oplen:  .byte   $01,$55,$00,$00,$00,$01,$01,$00 ; C0C6 01 55 00 00 00 01 01 00
        .byte   $00,$81,$00,$00,$00,$02,$02,$00 ; C0CE 00 81 00 00 00 02 02 00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00 ; C0D6 C1 69 00 00 00 11 11 00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00 ; C0DE 00 0A 00 00 00 12 12 00
        .byte   $02,$55,$00,$00,$01,$01,$01,$00 ; C0E6 02 55 00 00 01 01 01 00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00 ; C0EE 00 81 00 00 02 02 02 00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00 ; C0F6 C1 69 00 00 00 11 11 00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00 ; C0FE 00 0A 00 00 00 12 12 00
        .byte   $00,$55,$00,$00,$00,$01,$01,$00 ; C106 00 55 00 00 00 01 01 00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00 ; C10E 00 81 00 00 02 02 02 00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00 ; C116 C1 69 00 00 00 11 11 00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00 ; C11E 00 0A 00 00 00 12 12 00
        .byte   $00,$55,$00,$00,$00,$01,$01,$00 ; C126 00 55 00 00 00 01 01 00
        .byte   $00,$81,$00,$00,$62,$02,$02,$00 ; C12E 00 81 00 00 62 02 02 00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00 ; C136 C1 69 00 00 00 11 11 00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00 ; C13E 00 0A 00 00 00 12 12 00
        .byte   $00,$55,$00,$00,$01,$01,$01,$00 ; C146 00 55 00 00 01 01 01 00
        .byte   $00,$00,$00,$00,$02,$02,$02,$00 ; C14E 00 00 00 00 02 02 02 00
        .byte   $C1,$69,$00,$00,$11,$11,$09,$00 ; C156 C1 69 00 00 11 11 09 00
        .byte   $00,$0A,$00,$00,$00,$12,$00,$00 ; C15E 00 0A 00 00 00 12 00 00
        .byte   $81,$55,$81,$00,$01,$01,$01,$00 ; C166 81 55 81 00 01 01 01 00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00 ; C16E 00 81 00 00 02 02 02 00
        .byte   $C1,$69,$00,$00,$11,$11,$09,$00 ; C176 C1 69 00 00 11 11 09 00
        .byte   $00,$0A,$00,$00,$12,$12,$0A,$00 ; C17E 00 0A 00 00 12 12 0A 00
        .byte   $81,$55,$00,$00,$01,$01,$01,$00 ; C186 81 55 00 00 01 01 01 00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00 ; C18E 00 81 00 00 02 02 02 00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00 ; C196 C1 69 00 00 00 11 11 00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00 ; C19E 00 0A 00 00 00 12 12 00
        .byte   $81,$55,$00,$00,$01,$01,$01,$00 ; C1A6 81 55 00 00 01 01 01 00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00 ; C1AE 00 81 00 00 02 02 02 00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00 ; C1B6 C1 69 00 00 00 11 11 00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00 ; C1BE 00 0A 00 00 00 12 12 00
; Opmode
Opmode: .byte   $80,$B1,$BF,$BF,$BF,$B1,$A3,$BF ; C1C6 80 B1 BF BF BF B1 A3 BF
        .byte   $8B,$B1,$A3,$BF,$BF,$B1,$A3,$BF ; C1CE 8B B1 A3 BF BF B1 A3 BF
        .byte   $9E,$B1,$BF,$BF,$BF,$B1,$A3,$BF ; C1D6 9E B1 BF BF BF B1 A3 BF
        .byte   $81,$B1,$BF,$BF,$BF,$B1,$A3,$BF ; C1DE 81 B1 BF BF BF B1 A3 BF
        .byte   $AC,$A2,$BF,$BF,$A4,$A2,$B2,$BF ; C1E6 AC A2 BF BF A4 A2 B2 BF
        .byte   $8D,$A2,$B2,$BF,$A4,$A2,$B2,$BF ; C1EE 8D A2 B2 BF A4 A2 B2 BF
        .byte   $9D,$A2,$BF,$BF,$BF,$A2,$B2,$BF ; C1F6 9D A2 BF BF BF A2 B2 BF
        .byte   $90,$A2,$BF,$BF,$BF,$A2,$B2,$BF ; C1FE 90 A2 BF BF BF A2 B2 BF
        .byte   $8E,$A9,$BF,$BF,$BF,$A9,$B0,$BF ; C206 8E A9 BF BF BF A9 B0 BF
        .byte   $8A,$A9,$B0,$BF,$AB,$A9,$B0,$BF ; C20E 8A A9 B0 BF AB A9 B0 BF
        .byte   $9F,$A9,$BF,$BF,$BF,$A9,$B0,$BF ; C216 9F A9 BF BF BF A9 B0 BF
        .byte   $83,$A9,$BF,$BF,$BF,$A9,$B0,$BF ; C21E 83 A9 BF BF BF A9 B0 BF
        .byte   $8F,$A1,$BF,$BF,$BF,$A1,$B3,$BF ; C226 8F A1 BF BF BF A1 B3 BF
        .byte   $8C,$A1,$B3,$BF,$AB,$A1,$B3,$BF ; C22E 8C A1 B3 BF AB A1 B3 BF
        .byte   $A0,$A1,$BF,$BF,$BF,$A1,$B3,$BF ; C236 A0 A1 BF BF BF A1 B3 BF
        .byte   $92,$A1,$BF,$BF,$BF,$A1,$B3,$BF ; C23E 92 A1 BF BF BF A1 B3 BF
        .byte   $BF,$B5,$BF,$BF,$B7,$B5,$B6,$BF ; C246 BF B5 BF BF B7 B5 B6 BF
        .byte   $86,$BF,$96,$BF,$B7,$B5,$B6,$BF ; C24E 86 BF 96 BF B7 B5 B6 BF
        .byte   $99,$B5,$BF,$BF,$B7,$B5,$B6,$BF ; C256 99 B5 BF BF B7 B5 B6 BF
        .byte   $98,$B5,$97,$BF,$BF,$B5,$BF,$BF ; C25E 98 B5 97 BF BF B5 BF BF
        .byte   $AF,$AD,$AE,$BF,$AF,$AD,$AE,$BF ; C266 AF AD AE BF AF AD AE BF
        .byte   $94,$AD,$93,$BF,$AF,$AD,$AE,$BF ; C26E 94 AD 93 BF AF AD AE BF
        .byte   $9A,$AD,$BF,$BF,$AF,$AD,$AE,$BF ; C276 9A AD BF BF AF AD AE BF
        .byte   $84,$AD,$95,$BF,$AF,$AD,$AE,$BF ; C27E 84 AD 95 BF AF AD AE BF
        .byte   $A7,$A5,$BF,$BF,$A7,$A5,$A8,$BF ; C286 A7 A5 BF BF A7 A5 A8 BF
        .byte   $88,$A5,$85,$BF,$A7,$A5,$A8,$BF ; C28E 88 A5 85 BF A7 A5 A8 BF
        .byte   $9C,$A5,$BF,$BF,$BF,$A5,$A8,$BF ; C296 9C A5 BF BF BF A5 A8 BF
        .byte   $82,$A5,$BF,$BF,$BF,$A5,$A8,$BF ; C29E 82 A5 BF BF BF A5 A8 BF
        .byte   $A6,$B4,$BF,$BF,$A6,$B4,$AA,$BF ; C2A6 A6 B4 BF BF A6 B4 AA BF
        .byte   $87,$B4,$89,$BF,$A6,$B4,$AA,$BF ; C2AE 87 B4 89 BF A6 B4 AA BF
        .byte   $9B,$B4,$BF,$BF,$BF,$B4,$AA,$BF ; C2B6 9B B4 BF BF BF B4 AA BF
        .byte   $91,$B4,$BF,$BF,$BF,$B4,$AA,$BF ; C2BE 91 B4 BF BF BF B4 AA BF
; ----------------------------------------------------------------------------
; Commands
CommandsTable:
        .byte   "QUI"                           ; C2C6 51 55 49
        .byte   $D4                             ; C2C9 D4
        .byte   "LOA"                           ; C2CA 4C 4F 41
        .byte   $C4                             ; C2CD C4
        .byte   "DESA"                          ; C2CE 44 45 53 41
        .byte   $D3                             ; C2D2 D3
        .byte   "LDESA"                         ; C2D3 4C 44 45 53 41
        .byte   $D3                             ; C2D8 D3
        .byte   "DUM"                           ; C2D9 44 55 4D
        .byte   $D0                             ; C2DC D0
        .byte   "LDUM"                          ; C2DD 4C 44 55 4D
        .byte   $D0                             ; C2E1 D0
        .byte   "LIS"                           ; C2E2 4C 49 53
        .byte   $D4                             ; C2E5 D4
        .byte   "LLIS"                          ; C2E6 4C 4C 49 53
        .byte   $D4                             ; C2EA D4
        .byte   "RENU"                          ; C2EB 52 45 4E 55
        .byte   $CD                             ; C2EF CD
        .byte   "DI"                            ; C2F0 44 49
        .byte   $D2                             ; C2F2 D2
        .byte   "LDI"                           ; C2F3 4C 44 49
        .byte   $D2                             ; C2F6 D2
        .byte   "SAVE"                          ; C2F7 53 41 56 45
        .byte   $D5                             ; C2FB D5
        .byte   "SAVE"                          ; C2FC 53 41 56 45
        .byte   $CF                             ; C300 CF
        .byte   "SAVE"                          ; C301 53 41 56 45
        .byte   $CD                             ; C305 CD
        .byte   "SAV"                           ; C306 53 41 56
        .byte   $C5                             ; C309 C5
        .byte   "ASSE"                          ; C30A 41 53 53 45
        .byte   $CD                             ; C30E CD
        .byte   "LASSE"                         ; C30F 4C 41 53 53 45
        .byte   $CD                             ; C314 CD
        .byte   "SYOL"                          ; C315 53 59 4F 4C
        .byte   $C4                             ; C319 C4
        .byte   "SYDE"                          ; C31A 53 59 44 45
        .byte   $C6                             ; C31E C6
        .byte   "SYTA"                          ; C31F 53 59 54 41
        .byte   $C2                             ; C323 C2
        .byte   "LSYTA"                         ; C324 4C 53 59 54 41
        .byte   $C2                             ; C329 C2
        .byte   "MODI"                          ; C32A 4D 4F 44 49
        .byte   $C6                             ; C32E C6
        .byte   "?DE"                           ; C32F 3F 44 45
        .byte   $C3                             ; C332 C3
        .byte   "?HE"                           ; C333 3F 48 45
        .byte   $D8                             ; C336 D8
        .byte   "?BI"                           ; C337 3F 42 49
        .byte   $CE                             ; C33A CE
        .byte   "?CA"                           ; C33B 3F 43 41
        .byte   $D2                             ; C33E D2
        .byte   "VRE"                           ; C33F 56 52 45
        .byte   $C7                             ; C342 C7
        .byte   "TRAC"                          ; C343 54 52 41 43
        .byte   $C5                             ; C347 C5
        .byte   "MOV"                           ; C348 4D 4F 56
        .byte   $C5                             ; C34B C5
        .byte   "DELBA"                         ; C34C 44 45 4C 42 41
        .byte   $CB                             ; C351 CB
        .byte   "DELET"                         ; C352 44 45 4C 45 54
        .byte   $C5                             ; C357 C5
        .byte   "DE"                            ; C358 44 45
        .byte   $CC                             ; C35A CC
        .byte   "MERG"                          ; C35B 4D 45 52 47
        .byte   $C5                             ; C35F C5
        .byte   "SEE"                           ; C360 53 45 45
        .byte   $CB                             ; C363 CB
        .byte   "CHANG"                         ; C364 43 48 41 4E 47
        .byte   $C5                             ; C369 C5
        .byte   "OL"                            ; C36A 4F 4C
        .byte   $C4                             ; C36C C4
        .byte   "NE"                            ; C36D 4E 45
        .byte   $D7                             ; C36F D7
        .byte   "BAN"                           ; C370 42 41 4E
        .byte   $CB                             ; C373 CB
        .byte   "CAL"                           ; C374 43 41 4C
        .byte   $CC                             ; C377 CC
        .byte   "EX"                            ; C378 45 58
        .byte   $D4                             ; C37A D4
        .byte   "BYTE"                          ; C37B 42 59 54 45
        .byte   $D3                             ; C37F D3
        .byte   "MINA"                          ; C380 4D 49 4E 41
        .byte   $D3                             ; C384 D3
        .byte   "BACKU"                         ; C385 42 41 43 4B 55
        .byte   $D0                             ; C38A D0
        .byte   "INI"                           ; C38B 49 4E 49
        .byte   $D4                             ; C38E D4
        .byte   "DPAG"                          ; C38F 44 50 41 47
        .byte   $C5                             ; C393 C5
        .byte   "FPAG"                          ; C394 46 50 41 47
        .byte   $C5                             ; C398 C5
        .byte   "SLIGN"                         ; C399 53 4C 49 47 4E
        .byte   $C5                             ; C39E C5
        .byte   "QWERT"                         ; C39F 51 57 45 52 54
        .byte   $D9                             ; C3A4 D9
        .byte   "AZERT"                         ; C3A5 41 5A 45 52 54
        .byte   $D9                             ; C3AA D9
        .byte   "FRENC"                         ; C3AB 46 52 45 4E 43
        .byte   $C8                             ; C3B0 C8
        .byte   "ACCSE"                         ; C3B1 41 43 43 53 45
        .byte   $D4                             ; C3B6 D4
        .byte   "ACCOF"                         ; C3B7 41 43 43 4F 46
        .byte   $C6                             ; C3BC C6
        .byte   "TEX"                           ; C3BD 54 45 58
        .byte   $D4                             ; C3C0 D4
        .byte   "HIRE"                          ; C3C1 48 49 52 45
        .byte   $D3,$00                         ; C3C5 D3 00
; ----------------------------------------------------------------------------
; Commands Addresses
CommandsAddr:
        .word   QUIT-1                          ; C3C7 60 D0
        .word   LOAD-1                          ; C3C9 C7 D1
        .word   DESAS-1                         ; C3CB B8 D2
        .word   LDESAS-1                        ; C3CD BB D2
        .word   DUMP-1                          ; C3CF CF D2
        .word   LDUMP-1                         ; C3D1 D2 D2
        .word   LIST-1                          ; C3D3 4A D5
        .word   LLIST-1                         ; C3D5 4F D5
        .word   RENUM-1                         ; C3D7 88 D5
        .word   DIR-1                           ; C3D9 8D D6
        .word   LDIR-1                          ; C3DB 90 D6
        .word   SAVEU-1                         ; C3DD B1 D6
        .word   SAVEO-1                         ; C3DF B4 D6
        .word   SAVEM-1                         ; C3E1 B7 D6
        .word   SAVE-1                          ; C3E3 AE D6
        .word   ASSEM-1                         ; C3E5 06 DC
        .word   LASSEM-1                        ; C3E7 09 DC
        .word   SYOLD-1                         ; C3E9 36 E0
        .word   SYDEF-1                         ; C3EB 58 E0
        .word   SYTAB-1                         ; C3ED 5E E1
        .word   LSYTAB-1                        ; C3EF 61 E1
        .word   MODIF-1                         ; C3F1 E7 E7
        .word   QDEC-1                          ; C3F3 CF E1
        .word   QHEX-1                          ; C3F5 FB E1
        .word   QBIN-1                          ; C3F7 DE E1
        .word   QCAR-1                          ; C3F9 18 E2
        .word   VREG-1                          ; C3FB 57 E2
        .word   TRACE-1                         ; C3FD 14 EA
        .word   MOVE-1                          ; C3FF 09 E4
        .word   DELBAK-1                        ; C401 57 D7
        .word   DELETE-1                        ; C403 3C D6
        .word   DEL-1                           ; C405 39 D7
        .word   MERGE-1                         ; C407 09 E5
        .word   SEEK-1                          ; C409 93 EE
        .word   CHANGE-1                        ; C40B 49 EF
        .word   OLD-1                           ; C40D A1 E2
        .word   NEW-1                           ; C40F 34 D1
        .word   BANK-1                          ; C411 2B D3
        .word   CALL-1                          ; C413 E2 E2
        .word   EXT-1                           ; C415 64 D7
        .word   BYTES-1                         ; C417 33 E3
        .word   MINAS-1                         ; C419 13 ED
        .word   BACKUP-1                        ; C41B C0 D7
        .word   INIT-1                          ; C41D DA D7
        .word   DPAGE-1                         ; C41F 7D E3
        .word   FPAGE-1                         ; C421 8C E3
        .word   SLIGNE-1                        ; C423 64 E3
        .word   QWERTY-1                        ; C425 53 E5
        .word   AZERTY-1                        ; C427 56 E5
        .word   FRENCH-1                        ; C429 59 E5
        .word   ACCSET-1                        ; C42B 5C E5
        .word   ACCOFF-1                        ; C42D 5F E5
        .word   TEXT-1                          ; C42F 04 F0
        .word   HIRES-1                         ; C431 0C F0
; ----------------------------------------------------------------------------
; Error Messages
ErrMsgs:.byte   "Erreur de syntaxe"             ; C433 45 72 72 65 75 72 20 64
                                                ; C43B 65 20 73 79 6E 74 61 78
                                                ; C443 65
        .byte   $00                             ; C444 00
        .byte   "Fichier inexistant"            ; C445 46 69 63 68 69 65 72 20
                                                ; C44D 69 6E 65 78 69 73 74 61
                                                ; C455 6E 74
        .byte   $00                             ; C457 00
        .byte   "Erreur I/O"                    ; C458 45 72 72 65 75 72 20 49
                                                ; C460 2F 4F
        .byte   $00                             ; C462 00
        .byte   "Fichier existant"              ; C463 46 69 63 68 69 65 72 20
                                                ; C46B 65 78 69 73 74 61 6E 74
        .byte   $00                             ; C473 00
        .byte   "Plus de place disque"          ; C474 50 6C 75 73 20 64 65 20
                                                ; C47C 70 6C 61 63 65 20 64 69
                                                ; C484 73 71 75 65
        .byte   $00                             ; C488 00
        .byte   "Disquette protegee"            ; C489 44 69 73 71 75 65 74 74
                                                ; C491 65 20 70 72 6F 74 65 67
                                                ; C499 65 65
        .byte   $00                             ; C49B 00
        .byte   "Erreur de type"                ; C49C 45 72 72 65 75 72 20 64
                                                ; C4A4 65 20 74 79 70 65
        .byte   $00                             ; C4AA 00
        .byte   "Format inconnu"                ; C4AB 46 6F 72 6D 61 74 20 69
                                                ; C4B3 6E 63 6F 6E 6E 75
        .byte   $00                             ; C4B9 00
        .byte   "Pas de DOS"                    ; C4BA 50 61 73 20 64 65 20 44
                                                ; C4C2 4F 53
        .byte   $00                             ; C4C4 00
        .byte   "Nom de fichier incorrect"      ; C4C5 4E 6F 6D 20 64 65 20 66
                                                ; C4CD 69 63 68 69 65 72 20 69
                                                ; C4D5 6E 63 6F 72 72 65 63 74
        .byte   $00                             ; C4DD 00
        .byte   "Lecteur non connecte"          ; C4DE 4C 65 63 74 65 75 72 20
                                                ; C4E6 6E 6F 6E 20 63 6F 6E 6E
                                                ; C4EE 65 63 74 65
        .byte   $00                             ; C4F2 00
        .byte   "Valeur illegale"               ; C4F3 56 61 6C 65 75 72 20 69
                                                ; C4FB 6C 6C 65 67 61 6C 65
        .byte   $00                             ; C502 00
        .byte   "Valeur hors limites"           ; C503 56 61 6C 65 75 72 20 68
                                                ; C50B 6F 72 73 20 6C 69 6D 69
                                                ; C513 74 65 73
        .byte   $00                             ; C516 00
        .byte   "Memoire pleine"                ; C517 4D 65 6D 6F 69 72 65 20
                                                ; C51F 70 6C 65 69 6E 65
        .byte   $00                             ; C525 00
        .byte   "Mnemonique non defini"         ; C526 4D 6E 65 6D 6F 6E 69 71
                                                ; C52E 75 65 20 6E 6F 6E 20 64
                                                ; C536 65 66 69 6E 69
        .byte   $00                             ; C53B 00
        .byte   "Etiquette illegale"            ; C53C 45 74 69 71 75 65 74 74
                                                ; C544 65 20 69 6C 6C 65 67 61
                                                ; C54C 6C 65
        .byte   $00                             ; C54E 00
        .byte   "Etiquette en double"           ; C54F 45 74 69 71 75 65 74 74
                                                ; C557 65 20 65 6E 20 64 6F 75
                                                ; C55F 62 6C 65
        .byte   $00                             ; C562 00
        .byte   "Symbole non defini"            ; C563 53 79 6D 62 6F 6C 65 20
                                                ; C56B 6E 6F 6E 20 64 65 66 69
                                                ; C573 6E 69
        .byte   $00                             ; C575 00
        .byte   "Branchement hors limites"      ; C576 42 72 61 6E 63 68 65 6D
                                                ; C57E 65 6E 74 20 68 6F 72 73
                                                ; C586 20 6C 69 6D 69 74 65 73
        .byte   $00                             ; C58E 00
        .byte   "Mode adressage illegal"        ; C58F 4D 6F 64 65 20 61 64 72
                                                ; C597 65 73 73 61 67 65 20 69
                                                ; C59F 6C 6C 65 67 61 6C
        .byte   $00                             ; C5A5 00
        .byte   "ORG non defini"                ; C5A6 4F 52 47 20 6E 6F 6E 20
                                                ; C5AE 64 65 66 69 6E 69
        .byte   $00                             ; C5B4 00
        .byte   "ORG deja defini"               ; C5B5 4F 52 47 20 64 65 6A 61
                                                ; C5BD 20 64 65 66 69 6E 69
        .byte   $00                             ; C5C4 00
        .byte   "Pile erronee"                  ; C5C5 50 69 6C 65 20 65 72 72
                                                ; C5CD 6F 6E 65 65
        .byte   $00                             ; C5D1 00
        .byte   "Code inconnu"                  ; C5D2 43 6F 64 65 20 69 6E 63
                                                ; C5DA 6F 6E 6E 75
        .byte   $00                             ; C5DE 00
        .byte   "Wildcards non autorisees"      ; C5DF 57 69 6C 64 63 61 72 64
                                                ; C5E7 73 20 6E 6F 6E 20 61 75
                                                ; C5EF 74 6F 72 69 73 65 65 73
        .byte   $00                             ; C5F7 00
        .byte   "Symboles globaux detruits"     ; C5F8 53 79 6D 62 6F 6C 65 73
                                                ; C600 20 67 6C 6F 62 61 75 78
                                                ; C608 20 64 65 74 72 75 69 74
                                                ; C610 73
        .byte   $00                             ; C611 00
        .byte   "Erreur format imprimante"      ; C612 45 72 72 65 75 72 20 66
                                                ; C61A 6F 72 6D 61 74 20 69 6D
                                                ; C622 70 72 69 6D 61 6E 74 65
        .byte   $00                             ; C62A 00
; Messages divers
Registers_str:
        .byte   "AA YY XX PP  NV~BDIZC"         ; C62B 41 41 20 59 59 20 58 58
                                                ; C633 20 50 50 20 20 4E 56 7E
                                                ; C63B 42 44 49 5A 43
        .byte   $00                             ; C640 00
Source_str:
        .byte   "Prgm.Source: "                 ; C641 50 72 67 6D 2E 53 6F 75
                                                ; C649 72 63 65 3A 20
        .byte   $00                             ; C64E 00
Objet_str:
        .byte   "Prgm.Objet : "                 ; C64F 50 72 67 6D 2E 4F 62 6A
                                                ; C657 65 74 20 3A 20
        .byte   $00                             ; C65C 00
Symboles_str:
        .byte   "Symboles   : "                 ; C65D 53 79 6D 62 6F 6C 65 73
                                                ; C665 20 20 20 3A 20
        .byte   $00                             ; C66A 00
Locaux_str:
        .byte   "locaux"                        ; C66B 6C 6F 63 61 75 78
        .byte   $00                             ; C671 00
Globaux_str:
        .byte   "globaux"                       ; C672 67 6C 6F 62 61 75 78
        .byte   $00                             ; C679 00
Moniteur_str:
        .byte   "moniteur"                      ; C67A 6D 6F 6E 69 74 65 75 72
        .byte   $00                             ; C682 00
Assemblage_str:
        .byte   $82                             ; C683 82
        .byte   "Assemblage"                    ; C684 41 73 73 65 6D 62 6C 61
                                                ; C68C 67 65
        .byte   $00                             ; C68E 00
O_N_str:.byte   "?(O/N):"                       ; C68F 3F 28 4F 2F 4E 29 3A
        .byte   $00                             ; C696 00
Trace_str:
        .byte   $82                             ; C697 82
        .byte   "TRACE"                         ; C698 54 52 41 43 45
        .byte   $00                             ; C69D 00
PasPas_str:
        .byte   $82                             ; C69E 82
        .byte   "PAS A PAS"                     ; C69F 50 41 53 20 41 20 50 41
                                                ; C6A7 53
        .byte   $00                             ; C6A8 00
Exec_str:
        .byte   $82                             ; C6A9 82
        .byte   "EXEC"                          ; C6AA 45 58 45 43
        .byte   $00                             ; C6AE 00
Pile_str:
        .byte   $82                             ; C6AF 82
        .byte   "Pile"                          ; C6B0 50 69 6C 65
        .byte   $00                             ; C6B4 00
Banque_str:
        .byte   $83                             ; C6B5 83
        .byte   "Banque "                       ; C6B6 42 61 6E 71 75 65 20
        .byte   $00                             ; C6BD 00
MAJ_min_str:
        .byte   "MAJ min"                       ; C6BE 4D 41 4A 20 6D 69 6E
        .byte   $00                             ; C6C5 00
Fmt_str:.byte   "Fmt="                          ; C6C6 46 6D 74 3D
        .byte   $00                             ; C6CA 00
Saut_str:
        .byte   "Saut="                         ; C6CB 53 61 75 74 3D
        .byte   $00                             ; C6D0 00
Ligne_str:
        .byte   "Ligne="                        ; C6D1 4C 69 67 6E 65 3D
        .byte   $00                             ; C6D7 00
Occurences_str:
        .byte   $7F                             ; C6D8 7F
        .byte   "Occurences:"                   ; C6D9 4F 63 63 75 72 65 6E 63
                                                ; C6E1 65 73 3A
        .byte   $00                             ; C6E4 00
Menu_str:
        .byte   $0A,$0D                         ; C6E5 0A 0D
        .byte   " 1- HYPER-BASIC"               ; C6E7 20 31 2D 20 48 59 50 45
                                                ; C6EF 52 2D 42 41 53 49 43
        .byte   $0A,$0D                         ; C6F6 0A 0D
        .byte   " 2- TELE-ASS"                  ; C6F8 20 32 2D 20 54 45 4C 45
                                                ; C700 2D 41 53 53
        .byte   $0A,$0D                         ; C704 0A 0D
        .byte   "Votre choix:"                  ; C706 56 6F 74 72 65 20 63 68
                                                ; C70E 6F 69 78 3A
        .byte   $00,$00,$00,$00                 ; C712 00 00 00 00
; ----------------------------------------------------------------------------
LC716:  pha                                     ; C716 48
        cmp     #$A0                            ; C717 C9 A0
        bcs     LC728                           ; C719 B0 0D
        pla                                     ; C71B 68
        pha                                     ; C71C 48
        cmp     #$80                            ; C71D C9 80
        bcs     LC726                           ; C71F B0 05
        cmp     #$20                            ; C721 C9 20
        bcc     LC726                           ; C723 90 01
        .byte   $2C                             ; C725 2C
LC726:  lda     #" "                            ; C726 A9 20
LC728:  BRK_TELEMON XWR0                             ; C728 00 10
        pla                                     ; C72A 68
        rts                                     ; C72B 60

; ----------------------------------------------------------------------------
; Display Y spaces
DispYSpace:
        pha                                     ; C72C 48
LC72D:  jsr     DispSpace                       ; C72D 20 35 C7
        dey                                     ; C730 88
        bne     LC72D                           ; C731 D0 FA
        pla                                     ; C733 68
        rts                                     ; C734 60

; ----------------------------------------------------------------------------
; Display a space
DispSpace:
        lda     #" "                            ; C735 A9 20
        BRK_TELEMON XWR0                             ; C737 00 10
        rts                                     ; C739 60

; ----------------------------------------------------------------------------
; Display 6502 registers
DispRegs:
        ldy     #$08                            ; C73A A0 08
        jsr     DispYSpace                      ; C73C 20 2C C7
        lda     #<Registers_str                 ; C73F A9 2B
        ldy     #>Registers_str                 ; C741 A0 C6
        BRK_TELEMON XWSTR0                             ; C743 00 14
        jsr     LC763                           ; C745 20 63 C7
        ldy     #$08                            ; C748 A0 08
        jsr     DispYSpace                      ; C74A 20 2C C7
        ldy     #$03                            ; C74D A0 03
LC74F:  lda     HRS1+1,y                        ; C74F B9 4E 00
        jsr     DispByte                        ; C752 20 92 C7
        jsr     DispSpace                       ; C755 20 35 C7
        dey                                     ; C758 88
        bpl     LC74F                           ; C759 10 F4
        jsr     DispSpace                       ; C75B 20 35 C7
        lda     HRS1+1                          ; C75E A5 4E
        jsr     DispBitStr                      ; C760 20 A1 C7
LC763:  BRK_TELEMON XCRLF                             ; C763 00 25
        rts                                     ; C765 60

; ----------------------------------------------------------------------------
LC766:  ldy     #$00                            ; C766 A0 00
        jsr     LC7BA                           ; C768 20 BA C7
        ldy     #$FF                            ; C76B A0 FF
LC76D:  iny                                     ; C76D C8
        lda     BUFTRV+2,y                      ; C76E B9 02 01
        sta     BUFTRV,y                        ; C771 99 00 01
        bne     LC76D                           ; C774 D0 F7
        jmp     DispString                      ; C776 4C 7C C7

; ----------------------------------------------------------------------------
LC779:  jsr     LC7BA                           ; C779 20 BA C7
; Display string from bottom of the stack
DispString:
        pha                                     ; C77C 48
        tya                                     ; C77D 98
        pha                                     ; C77E 48
        txa                                     ; C77F 8A
        pha                                     ; C780 48
        lda     #<BUFTRV                        ; C781 A9 00
        ldy     #>BUFTRV                        ; C783 A0 01
        BRK_TELEMON XWSTR0                             ; C785 00 14
        pla                                     ; C787 68
        tax                                     ; C788 AA
        pla                                     ; C789 68
        tay                                     ; C78A A8
        pla                                     ; C78B 68
        rts                                     ; C78C 60

; ----------------------------------------------------------------------------
; Display hexa word from bottom of the stack
DispWord:
        jsr     PutYAHexa                       ; C78D 20 CD C7
        beq     DispString                      ; C790 F0 EA
; Display hexa byte from bottom of the stack
DispByte:
        jsr     PutHexa                         ; C792 20 D9 C7
        jmp     DispString                      ; C795 4C 7C C7

; ----------------------------------------------------------------------------
        pha                                     ; C798 48
        tya                                     ; C799 98
        jsr     PutBitStr                       ; C79A 20 FE C7
        jsr     DispString                      ; C79D 20 7C C7
        pla                                     ; C7A0 68
; Display bit string representation of ACC
DispBitStr:
        jsr     PutBitStr                       ; C7A1 20 FE C7
        jmp     DispString                      ; C7A4 4C 7C C7

; ----------------------------------------------------------------------------
LC7A7:  pha                                     ; C7A7 48
        tya                                     ; C7A8 98
        pha                                     ; C7A9 48
        lda     #$00                            ; C7AA A9 00
        ldy     #$01                            ; C7AC A0 01
        sta     TR5                             ; C7AE 85 11
        sty     TR6                             ; C7B0 84 12
        lda     #$20                            ; C7B2 A9 20
        sta     DEFAFF                          ; C7B4 85 14
        pla                                     ; C7B6 68
        tay                                     ; C7B7 A8
        pla                                     ; C7B8 68
        rts                                     ; C7B9 60

; ----------------------------------------------------------------------------
LC7BA:  stx     VARAPL                          ; C7BA 86 D0
        ldx     #$03                            ; C7BC A2 03
        jsr     LC7A7                           ; C7BE 20 A7 C7
        BRK_TELEMON XBINDX                             ; C7C1 00 28
        ldx     VARAPL                          ; C7C3 A6 D0
        ldy     #$05                            ; C7C5 A0 05
        lda     #$00                            ; C7C7 A9 00
        sta     BUFTRV,y                        ; C7C9 99 00 01
        rts                                     ; C7CC 60

; ----------------------------------------------------------------------------
; Put hexa string representation of YA at bottom of the stack
PutYAHexa:
        ldx     #$00                            ; C7CD A2 00
        pha                                     ; C7CF 48
        tya                                     ; C7D0 98
        jsr     PushHexa                        ; C7D1 20 ED C7
        pla                                     ; C7D4 68
        jsr     PushHexa                        ; C7D5 20 ED C7
        rts                                     ; C7D8 60

; ----------------------------------------------------------------------------
; Put hexa string representation of ACC at bottom of the stack
PutHexa:sta     VARAPL                          ; C7D9 85 D0
        pha                                     ; C7DB 48
        tya                                     ; C7DC 98
        pha                                     ; C7DD 48
        txa                                     ; C7DE 8A
        pha                                     ; C7DF 48
        ldx     #$00                            ; C7E0 A2 00
        lda     VARAPL                          ; C7E2 A5 D0
        jsr     PushHexa                        ; C7E4 20 ED C7
        pla                                     ; C7E7 68
        tax                                     ; C7E8 AA
        pla                                     ; C7E9 68
        tay                                     ; C7EA A8
        pla                                     ; C7EB 68
        rts                                     ; C7EC 60

; ----------------------------------------------------------------------------
; Append hexa string representation of ACC at bottom of the stack
PushHexa:
        BRK_TELEMON XHEXA                             ; C7ED 00 2A
        sta     BUFTRV,x                        ; C7EF 9D 00 01
        inx                                     ; C7F2 E8
        tya                                     ; C7F3 98
        sta     BUFTRV,x                        ; C7F4 9D 00 01
        inx                                     ; C7F7 E8
        lda     #$00                            ; C7F8 A9 00
        sta     BUFTRV,x                        ; C7FA 9D 00 01
        rts                                     ; C7FD 60

; ----------------------------------------------------------------------------
; Put bit string representation of ACC at bottom of the stack
PutBitStr:
        sta     VARAPL                          ; C7FE 85 D0
        pha                                     ; C800 48
        txa                                     ; C801 8A
        pha                                     ; C802 48
        ldx     #$08                            ; C803 A2 08
        lda     #$00                            ; C805 A9 00
        beq     LC811                           ; C807 F0 08
LC809:  lda     #$30                            ; C809 A9 30
        lsr     VARAPL                          ; C80B 46 D0
        bcc     LC811                           ; C80D 90 02
        adc     #$00                            ; C80F 69 00
LC811:  sta     BUFTRV,x                        ; C811 9D 00 01
        dex                                     ; C814 CA
        bpl     LC809                           ; C815 10 F2
        pla                                     ; C817 68
        tax                                     ; C818 AA
        pla                                     ; C819 68
        rts                                     ; C81A 60

; ----------------------------------------------------------------------------
; Display error number X
DispErrorX:
        pha                                     ; C81B 48
        tya                                     ; C81C 98
        pha                                     ; C81D 48
        lda     #<ErrMsgs                       ; C81E A9 33
        sta     TR0                             ; C820 85 0C
        lda     #>ErrMsgs                       ; C822 A9 C4
        sta     TR1                             ; C824 85 0D
        bne     LC83A                           ; C826 D0 12
LC828:  iny                                     ; C828 C8
LC829:  lda     (TR0),y                         ; C829 B1 0C
        bne     LC828                           ; C82B D0 FB
        iny                                     ; C82D C8
        tya                                     ; C82E 98
        clc                                     ; C82F 18
        adc     TR0                             ; C830 65 0C
        sta     TR0                             ; C832 85 0C
        lda     TR1                             ; C834 A5 0D
        adc     #$00                            ; C836 69 00
        sta     TR1                             ; C838 85 0D
LC83A:  ldy     #$00                            ; C83A A0 00
        lda     (TR0),y                         ; C83C B1 0C
        beq     LC84F                           ; C83E F0 0F
        dex                                     ; C840 CA
        bpl     LC829                           ; C841 10 E6
        lda     TR0                             ; C843 A5 0C
        ldy     TR1                             ; C845 A4 0D
        ldx     #$02                            ; C847 A2 02
        jsr     LC88B                           ; C849 20 8B C8
        jsr     LC857                           ; C84C 20 57 C8
LC84F:  pla                                     ; C84F 68
        tay                                     ; C850 A8
        pla                                     ; C851 68
LC852:  rts                                     ; C852 60

; ----------------------------------------------------------------------------
LC853:  lda     #$00                            ; C853 A9 00
        ldy     #$01                            ; C855 A0 01
LC857:  bit     FLGTEL                          ; C857 2C 0D 02
        bmi     LC852                           ; C85A 30 F6
        pha                                     ; C85C 48
        tya                                     ; C85D 98
        pha                                     ; C85E 48
        lda     SCRX                            ; C85F AD 20 02
        sta     VARAPL                          ; C862 85 D0
        lda     SCRY                            ; C864 AD 24 02
        sta     VARAPL+1                        ; C867 85 D1
        txa                                     ; C869 8A
        tay                                     ; C86A A8
        lda     #$00                            ; C86B A9 00
        jsr     LC879                           ; C86D 20 79 C8
        pla                                     ; C870 68
        tay                                     ; C871 A8
        pla                                     ; C872 68
        BRK_TELEMON XWSTR0                             ; C873 00 14
        lda     VARAPL+1                        ; C875 A5 D1
        ldy     VARAPL                          ; C877 A4 D0
LC879:  pha                                     ; C879 48
        lda     #$1F                            ; C87A A9 1F
        BRK_TELEMON XWR0                             ; C87C 00 10
        pla                                     ; C87E 68
        clc                                     ; C87F 18
        adc     #$40                            ; C880 69 40
        BRK_TELEMON XWR0                             ; C882 00 10
        tya                                     ; C884 98
        clc                                     ; C885 18
        adc     #$40                            ; C886 69 40
        BRK_TELEMON XWR0                             ; C888 00 10
LC88A:  rts                                     ; C88A 60

; ----------------------------------------------------------------------------
LC88B:  bit     FLGTEL                          ; C88B 2C 0D 02
        bmi     LC88A                           ; C88E 30 FA
        pha                                     ; C890 48
        tya                                     ; C891 98
        pha                                     ; C892 48
        txa                                     ; C893 8A
        pha                                     ; C894 48
        lda     SCRY                            ; C895 AD 24 02
        pha                                     ; C898 48
        lda     SCRX                            ; C899 AD 20 02
        pha                                     ; C89C 48
        lda     #$00                            ; C89D A9 00
        ldy     #$01                            ; C89F A0 01
        jsr     LC879                           ; C8A1 20 79 C8
        lda     #CAN                            ; C8A4 A9 18
        BRK_TELEMON XWR0                             ; C8A6 00 10
        pla                                     ; C8A8 68
        tay                                     ; C8A9 A8
        pla                                     ; C8AA 68
        jsr     LC879                           ; C8AB 20 79 C8
        pla                                     ; C8AE 68
        tax                                     ; C8AF AA
        pla                                     ; C8B0 68
        tay                                     ; C8B1 A8
        pla                                     ; C8B2 68
        rts                                     ; C8B3 60

; ----------------------------------------------------------------------------
LC8B4:  BRK_TELEMON XRD0                             ; C8B4 00 08
        bcs     LC8CF                           ; C8B6 B0 17
        cmp     #$1B                            ; C8B8 C9 1B
        beq     LC8D0                           ; C8BA F0 14
        cmp     #$03                            ; C8BC C9 03
        beq     LC8D0                           ; C8BE F0 10
        cmp     #" "                            ; C8C0 C9 20
        bne     LC8CF                           ; C8C2 D0 0B
        jsr     GetKey                          ; C8C4 20 D1 C8
        cmp     #$1B                            ; C8C7 C9 1B
        beq     LC8D0                           ; C8C9 F0 05
        cmp     #$03                            ; C8CB C9 03
        beq     LC8D0                           ; C8CD F0 01
LC8CF:  clc                                     ; C8CF 18
LC8D0:  rts                                     ; C8D0 60

; ----------------------------------------------------------------------------
; Attend un caractère au clavier
GetKey: ldx     #$00                            ; C8D1 A2 00
        BRK_TELEMON XCSSCR                             ; C8D3 00 35
        BRK_TELEMON XRDW0                             ; C8D5 00 0C
        pha                                     ; C8D7 48
        BRK_TELEMON XCOSCR                             ; C8D8 00 34
        pla                                     ; C8DA 68
        rts                                     ; C8DB 60

; ----------------------------------------------------------------------------
LC8DC:  bit     FLGTEL                          ; C8DC 2C 0D 02
        bmi     LC8D0                           ; C8DF 30 EF
        jsr     LC88B                           ; C8E1 20 8B C8
        pha                                     ; C8E4 48
        tya                                     ; C8E5 98
        pha                                     ; C8E6 48
        txa                                     ; C8E7 8A
        pha                                     ; C8E8 48
        lda     DEFBNK                          ; C8E9 AD E0 04
        jsr     DispBank                        ; C8EC 20 F5 C8
        pla                                     ; C8EF 68
        tax                                     ; C8F0 AA
        pla                                     ; C8F1 68
        tay                                     ; C8F2 A8
        pla                                     ; C8F3 68
        rts                                     ; C8F4 60

; ----------------------------------------------------------------------------
; Display 'Banque ' + bank number ACC
DispBank:
        pha                                     ; C8F5 48
        lda     SCRX                            ; C8F6 AD 20 02
        sta     VARAPL                          ; C8F9 85 D0
        lda     SCRY                            ; C8FB AD 24 02
        sta     VARAPL+1                        ; C8FE 85 D1
        lda     #$00                            ; C900 A9 00
        ldy     #$0F                            ; C902 A0 0F
        jsr     LC879                           ; C904 20 79 C8
        lda     #<Banque_str                    ; C907 A9 B5
        ldy     #>Banque_str                    ; C909 A0 C6
        BRK_TELEMON XWSTR0                             ; C90B 00 14
        pla                                     ; C90D 68
        clc                                     ; C90E 18
        adc     #$30                            ; C90F 69 30
        BRK_TELEMON XWR0                             ; C911 00 10
        lda     VARAPL+1                        ; C913 A5 D1
        ldy     VARAPL                          ; C915 A4 D0
        jmp     LC879                           ; C917 4C 79 C8

; ----------------------------------------------------------------------------
LC91A:  cmp     #$2E                            ; C91A C9 2E
        bcc     LC933                           ; C91C 90 15
        sbc     #$3A                            ; C91E E9 3A
        sec                                     ; C920 38
        sbc     #$C6                            ; C921 E9 C6
        bcc     LC92A                           ; C923 90 05
        rts                                     ; C925 60

; ----------------------------------------------------------------------------
LC926:  cmp     #$2E                            ; C926 C9 2E
        beq     LC933                           ; C928 F0 09
LC92A:  cmp     #$3F                            ; C92A C9 3F
        bcc     LC933                           ; C92C 90 05
        sbc     #$7B                            ; C92E E9 7B
        sec                                     ; C930 38
        sbc     #$85                            ; C931 E9 85
LC933:  rts                                     ; C933 60

; ----------------------------------------------------------------------------
LC934:  ldy     #$FE                            ; C934 A0 FE
        sty     VARAPL+2                        ; C936 84 D2
        iny                                     ; C938 C8
        lda     #$00                            ; C939 A9 00
        sta     VARAPL+5                        ; C93B 85 D5
        lda     BUFEDT,x                        ; C93D BD 90 05
        beq     LC9AF                           ; C940 F0 6D
        cmp     #$27                            ; C942 C9 27
        beq     LC9AD                           ; C944 F0 67
        jsr     MnemonicLookup                  ; C946 20 CD C9
        bmi     LC9AF                           ; C949 30 64
        jsr     LC926                           ; C94B 20 26 C9
        bcc     LC980                           ; C94E 90 30
        dex                                     ; C950 CA
LC951:  inx                                     ; C951 E8
        lda     BUFEDT,x                        ; C952 BD 90 05
        cmp     #$20                            ; C955 C9 20
        bne     LC95D                           ; C957 D0 04
        ror     VARAPL+6                        ; C959 66 D6
        bmi     LC951                           ; C95B 30 F4
LC95D:  bit     VARAPL+6                        ; C95D 24 D6
        bmi     LC986                           ; C95F 30 25
        jsr     LC91A                           ; C961 20 1A C9
        bcc     LC980                           ; C964 90 1A
        pha                                     ; C966 48
        inc     VARAPL+5                        ; C967 E6 D5
        lda     VARAPL+5                        ; C969 A5 D5
        cmp     #$06                            ; C96B C9 06
        bcc     LC971                           ; C96D 90 02
        ror     VARAPL+6                        ; C96F 66 D6
LC971:  pla                                     ; C971 68
        iny                                     ; C972 C8
        sta     BUFEDT,y                        ; C973 99 90 05
        lda     BUFEDT,y                        ; C976 B9 90 05
        bne     LC951                           ; C979 D0 D6
LC97B:  txa                                     ; C97B 8A
        ldx     #$0E                            ; C97C A2 0E
        bne     LC983                           ; C97E D0 03
LC980:  txa                                     ; C980 8A
        ldx     #$0F                            ; C981 A2 0F
LC983:  tay                                     ; C983 A8
        clc                                     ; C984 18
        rts                                     ; C985 60

; ----------------------------------------------------------------------------
LC986:  jsr     MnemonicLookup                  ; C986 20 CD C9
        bpl     LC97B                           ; C989 10 F0
        bmi     LC9AF                           ; C98B 30 22
LC98D:  inx                                     ; C98D E8
        lda     BUFEDT,x                        ; C98E BD 90 05
        bit     VARAPL+5                        ; C991 24 D5
        bmi     LC9AF                           ; C993 30 1A
        cmp     #'"'                            ; C995 C9 22
        bne     LC9A1                           ; C997 D0 08
        pha                                     ; C999 48
        lda     VARAPL+5                        ; C99A A5 D5
        eor     #$40                            ; C99C 49 40
        sta     VARAPL+5                        ; C99E 85 D5
        pla                                     ; C9A0 68
LC9A1:  bit     VARAPL+5                        ; C9A1 24 D5
        bvs     LC9AF                           ; C9A3 70 0A
        cmp     #" "                            ; C9A5 C9 20
        beq     LC98D                           ; C9A7 F0 E4
        cmp     #"'"                            ; C9A9 C9 27
        bne     LC9AF                           ; C9AB D0 02
LC9AD:  ror     VARAPL+5                        ; C9AD 66 D5
LC9AF:  iny                                     ; C9AF C8
        sta     BUFEDT,y                        ; C9B0 99 90 05
        lda     BUFEDT,y                        ; C9B3 B9 90 05
        bpl     LC9BA                           ; C9B6 10 02
        sta     (VARAPL+1),y                    ; C9B8 91 D1
LC9BA:  bne     LC98D                           ; C9BA D0 D1
        iny                                     ; C9BC C8
        sec                                     ; C9BD 38
        rts                                     ; C9BE 60

; ----------------------------------------------------------------------------
; Converti un caractère alpha minuscule en MAJUSCULE
min_MAJ:cmp     #$61                            ; C9BF C9 61
        bcc     LC9CC                           ; C9C1 90 09
        sbc     #$7B                            ; C9C3 E9 7B
        sec                                     ; C9C5 38
        sbc     #$85                            ; C9C6 E9 85
        bcc     LC9CC                           ; C9C8 90 02
        sbc     #$20                            ; C9CA E9 20
LC9CC:  rts                                     ; C9CC 60

; ----------------------------------------------------------------------------
; Recherche une instruction dans la table des mnemoniques
MnemonicLookup:
        clc                                     ; C9CD 18
        lda     #<MnemonicsTable                ; C9CE A9 03
        adc     #$FF                            ; C9D0 69 FF
        sta     VARAPL+8                        ; C9D2 85 D8
        lda     #>MnemonicsTable                ; C9D4 A9 C0
        adc     #$FF                            ; C9D6 69 FF
        sta     VARAPL+9                        ; C9D8 85 D9
; Recherche une chaine dans une table. Entrée avec X = offset dans le buffer
; d'entrée
TableLookup:
        sty     VARAPL                          ; C9DA 84 D0
        ldy     #$00                            ; C9DC A0 00
        sty     VARAPL+6                        ; C9DE 84 D6
        stx     VARAPL+1                        ; C9E0 86 D1
        dex                                     ; C9E2 CA
LC9E3:  inx                                     ; C9E3 E8
        inc     VARAPL+8                        ; C9E4 E6 D8
        bne     LC9EA                           ; C9E6 D0 02
        inc     VARAPL+9                        ; C9E8 E6 D9
LC9EA:  lda     BUFEDT,x                        ; C9EA BD 90 05
        jsr     min_MAJ                         ; C9ED 20 BF C9
        sec                                     ; C9F0 38
        sbc     (VARAPL+8),y                    ; C9F1 F1 D8
        beq     LC9E3                           ; C9F3 F0 EE
        cmp     #$80                            ; C9F5 C9 80
        beq     LCA12                           ; C9F7 F0 19
        ldx     VARAPL+1                        ; C9F9 A6 D1
        inc     VARAPL+6                        ; C9FB E6 D6
LC9FD:  lda     (VARAPL+8),y                    ; C9FD B1 D8
        php                                     ; C9FF 08
        inc     VARAPL+8                        ; CA00 E6 D8
        bne     LCA06                           ; CA02 D0 02
        inc     VARAPL+9                        ; CA04 E6 D9
LCA06:  plp                                     ; CA06 28
        bpl     LC9FD                           ; CA07 10 F4
        lda     (VARAPL+8),y                    ; CA09 B1 D8
        bne     LC9EA                           ; CA0B D0 DD
        lda     BUFEDT,x                        ; CA0D BD 90 05
        sta     VARAPL+6                        ; CA10 85 D6
LCA12:  ora     VARAPL+6                        ; CA12 05 D6
        pha                                     ; CA14 48
        ora     #$40                            ; CA15 09 40
        sta     VARAPL+2                        ; CA17 85 D2
        ldy     VARAPL                          ; CA19 A4 D0
        pla                                     ; CA1B 68
        rts                                     ; CA1C 60

; ----------------------------------------------------------------------------
; Recherche une commande dans la table des commandes
CommandLookup:
        clc                                     ; CA1D 18
        lda     #<CommandsTable                 ; CA1E A9 C6
        adc     #$FF                            ; CA20 69 FF
        sta     VARAPL+8                        ; CA22 85 D8
        lda     #>CommandsTable                 ; CA24 A9 C2
        adc     #$FF                            ; CA26 69 FF
        sta     VARAPL+9                        ; CA28 85 D9
        jmp     TableLookup                     ; CA2A 4C DA C9

; ----------------------------------------------------------------------------
; Saute les premiers espaces dans BUFEDT
SkipSpaces:
        ldx     #$FF                            ; CA2D A2 FF
LCA2F:  inx                                     ; CA2F E8
LCA30:  lda     BUFEDT,x                        ; CA30 BD 90 05
        beq     LCA39                           ; CA33 F0 04
        cmp     #" "                            ; CA35 C9 20
        beq     LCA2F                           ; CA37 F0 F6
LCA39:  rts                                     ; CA39 60

; ----------------------------------------------------------------------------
; Put mnemonic number ACC at bottom of the stack
PutMnemo:
        sty     VARAPL                          ; CA3A 84 D0
        stx     VARAPL+1                        ; CA3C 86 D1
        and     #$7F                            ; CA3E 29 7F
        pha                                     ; CA40 48
        sta     VARAPL+2                        ; CA41 85 D2
        asl                                     ; CA43 0A
        adc     VARAPL+2                        ; CA44 65 D2
        tay                                     ; CA46 A8
        dey                                     ; CA47 88
        ldx     #$FF                            ; CA48 A2 FF
LCA4A:  inx                                     ; CA4A E8
        iny                                     ; CA4B C8
        lda     MnemonicsTable,y                ; CA4C B9 03 C0
        pha                                     ; CA4F 48
        and     #$7F                            ; CA50 29 7F
        sta     BUFTRV,x                        ; CA52 9D 00 01
        pla                                     ; CA55 68
        bpl     LCA4A                           ; CA56 10 F2
        lda     #$00                            ; CA58 A9 00
        inx                                     ; CA5A E8
        sta     BUFTRV,x                        ; CA5B 9D 00 01
        ldy     VARAPL                          ; CA5E A4 D0
        ldx     VARAPL+1                        ; CA60 A6 D1
        pla                                     ; CA62 68
        rts                                     ; CA63 60

; ----------------------------------------------------------------------------
; Decode opcode in ACC
DecodeOpc:
        sta     HRS3+1                          ; CA64 85 52
        tay                                     ; CA66 A8
        pha                                     ; CA67 48
        lda     Oplen,y                         ; CA68 B9 C6 C0
        sta     INDIC0                          ; CA6B 85 55
        and     #$03                            ; CA6D 29 03
        sta     INDIC0+1                        ; CA6F 85 56
        tax                                     ; CA71 AA
        lda     Opmode,y                        ; CA72 B9 C6 C1
        sta     INDIC2                          ; CA75 85 57
        pla                                     ; CA77 68
        rts                                     ; CA78 60

; ----------------------------------------------------------------------------
LCA79:  sta     VARAPL                          ; CA79 85 D0
        ldy     #$00                            ; CA7B A0 00
LCA7D:  lda     Opmode,y                        ; CA7D B9 C6 C1
        cmp     INDIC2                          ; CA80 C5 57
        bne     LCA8B                           ; CA82 D0 07
        lda     Oplen,y                         ; CA84 B9 C6 C0
        cmp     VARAPL                          ; CA87 C5 D0
        beq     LCA8F                           ; CA89 F0 04
LCA8B:  iny                                     ; CA8B C8
        bne     LCA7D                           ; CA8C D0 EF
        clc                                     ; CA8E 18
LCA8F:  tya                                     ; CA8F 98
        rts                                     ; CA90 60

; ----------------------------------------------------------------------------
LCA91:  pha                                     ; CA91 48
        tya                                     ; CA92 98
        pha                                     ; CA93 48
        ldx     #$11                            ; CA94 A2 11
        stx     VARAPL+1                        ; CA96 86 D1
        stx     VARAPL+5                        ; CA98 86 D5
        ldx     #$09                            ; CA9A A2 09
        ldy     #$02                            ; CA9C A0 02
LCA9E:  iny                                     ; CA9E C8
        lda     (VARAPL+12),y                   ; CA9F B1 DC
        beq     LCADB                           ; CAA1 F0 38
        bmi     LCAAF                           ; CAA3 30 0A
        cmp     #"'"                            ; CAA5 C9 27
        bne     LCA9E                           ; CAA7 D0 F5
        ldx     #$07                            ; CAA9 A2 07
        stx     VARAPL+1                        ; CAAB 86 D1
        bne     LCAD2                           ; CAAD D0 23
LCAAF:  iny                                     ; CAAF C8
        lda     (VARAPL+12),y                   ; CAB0 B1 DC
        beq     LCADB                           ; CAB2 F0 27
        cmp     #'"'                            ; CAB4 C9 22
        bne     LCAC0                           ; CAB6 D0 08
        pha                                     ; CAB8 48
        lda     VARAPL+5                        ; CAB9 A5 D5
        eor     #$80                            ; CABB 49 80
        sta     VARAPL+5                        ; CABD 85 D5
        pla                                     ; CABF 68
LCAC0:  cmp     #"'"                            ; CAC0 C9 27
        beq     LCAC9                           ; CAC2 F0 05
LCAC4:  dex                                     ; CAC4 CA
        inc     VARAPL+1                        ; CAC5 E6 D1
        bne     LCAAF                           ; CAC7 D0 E6
LCAC9:  bit     VARAPL+5                        ; CAC9 24 D5
        bmi     LCAC4                           ; CACB 30 F7
LCACD:  inc     VARAPL+1                        ; CACD E6 D1
        dex                                     ; CACF CA
        bpl     LCACD                           ; CAD0 10 FB
LCAD2:  lda     (VARAPL+12),y                   ; CAD2 B1 DC
        beq     LCADB                           ; CAD4 F0 05
        inc     VARAPL+1                        ; CAD6 E6 D1
        iny                                     ; CAD8 C8
        bne     LCAD2                           ; CAD9 D0 F7
LCADB:  lda     VARAPL+1                        ; CADB A5 D1
        cmp     #"'"                            ; CADD C9 27
        bcc     LCAEF                           ; CADF 90 0E
        pha                                     ; CAE1 48
        lda     #VT                             ; CAE2 A9 0B
        BRK_TELEMON XWR0                             ; CAE4 00 10
        pla                                     ; CAE6 68
        cmp     #"N"                            ; CAE7 C9 4E
        bcc     LCAEF                           ; CAE9 90 04
        lda     #VT                             ; CAEB A9 0B
        BRK_TELEMON XWR0                             ; CAED 00 10
LCAEF:  pla                                     ; CAEF 68
        tay                                     ; CAF0 A8
        pla                                     ; CAF1 68
LCAF2:  pha                                     ; CAF2 48
        lda     #$7F                            ; CAF3 A9 7F
        BRK_TELEMON XWR0                             ; CAF5 00 10
        pla                                     ; CAF7 68
LCAF8:  jsr     LC779                           ; CAF8 20 79 C7
        jsr     DispSpace                       ; CAFB 20 35 C7
        ldy     #$03                            ; CAFE A0 03
        ldx     #$06                            ; CB00 A2 06
        stx     VARAPL+5                        ; CB02 86 D5
LCB04:  lda     (VARAPL+12),y                   ; CB04 B1 DC
        beq     LCB59                           ; CB06 F0 51
        bmi     LCB10                           ; CB08 30 06
        BRK_TELEMON XWR0                             ; CB0A 00 10
        dex                                     ; CB0C CA
        iny                                     ; CB0D C8
        bne     LCB04                           ; CB0E D0 F4
LCB10:  jsr     DispSpace                       ; CB10 20 35 C7
        dex                                     ; CB13 CA
        bpl     LCB10                           ; CB14 10 FA
        lda     (VARAPL+12),y                   ; CB16 B1 DC
        and     #$7F                            ; CB18 29 7F
        cmp     #$40                            ; CB1A C9 40
        bcc     LCB20                           ; CB1C 90 02
        lda     #$40                            ; CB1E A9 40
LCB20:  jsr     PutMnemo                        ; CB20 20 3A CA
        jsr     DispString                      ; CB23 20 7C C7
        jsr     DispSpace                       ; CB26 20 35 C7
        ldx     #$09                            ; CB29 A2 09
LCB2B:  iny                                     ; CB2B C8
        lda     (VARAPL+12),y                   ; CB2C B1 DC
        beq     LCB59                           ; CB2E F0 29
        cmp     #'"'                            ; CB30 C9 22
        bne     LCB3C                           ; CB32 D0 08
        pha                                     ; CB34 48
        lda     VARAPL+5                        ; CB35 A5 D5
        eor     #$80                            ; CB37 49 80
        sta     VARAPL+5                        ; CB39 85 D5
        pla                                     ; CB3B 68
LCB3C:  cmp     #"'"                            ; CB3C C9 27
        beq     LCB46                           ; CB3E F0 06
LCB40:  dex                                     ; CB40 CA
        BRK_TELEMON XWR0                             ; CB41 00 10
        jmp     LCB2B                           ; CB43 4C 2B CB

; ----------------------------------------------------------------------------
LCB46:  bit     VARAPL+5                        ; CB46 24 D5
        bmi     LCB40                           ; CB48 30 F6
LCB4A:  jsr     DispSpace                       ; CB4A 20 35 C7
        dex                                     ; CB4D CA
        bpl     LCB4A                           ; CB4E 10 FA
LCB50:  lda     (VARAPL+12),y                   ; CB50 B1 DC
        beq     LCB59                           ; CB52 F0 05
        BRK_TELEMON XWR0                             ; CB54 00 10
        iny                                     ; CB56 C8
        bne     LCB50                           ; CB57 D0 F7
LCB59:  rts                                     ; CB59 60

; ----------------------------------------------------------------------------
LCB5A:  pha                                     ; CB5A 48
        BRK_TELEMON XCRLF                             ; CB5B 00 25
        pla                                     ; CB5D 68
        bit     XLPRBI                          ; CB5E 24 48
        bpl     LCB59                           ; CB60 10 F7
        pha                                     ; CB62 48
        inc     LPRY                            ; CB63 EE 87 02
        lda     LPRY                            ; CB66 AD 87 02
        cmp     LPRSY                           ; CB69 CD 8B 02
        bcc     LCB87                           ; CB6C 90 19
        pla                                     ; CB6E 68
LCB6F:  bit     XLPRBI                          ; CB6F 24 48
        bpl     LCB59                           ; CB71 10 E6
        pha                                     ; CB73 48
        sec                                     ; CB74 38
        lda     LPRFY                           ; CB75 AD 89 02
        sbc     LPRY                            ; CB78 ED 87 02
        sta     LPRY                            ; CB7B 8D 87 02
        beq     LCB87                           ; CB7E F0 07
LCB80:  BRK_TELEMON XCRLF                             ; CB80 00 25
        dec     LPRY                            ; CB82 CE 87 02
        bne     LCB80                           ; CB85 D0 F9
LCB87:  pla                                     ; CB87 68
        rts                                     ; CB88 60

; ----------------------------------------------------------------------------
LCB89:  ldy     #$00                            ; CB89 A0 00
        clc                                     ; CB8B 18
        lda     (VARAPL+12),y                   ; CB8C B1 DC
        adc     VARAPL+12                       ; CB8E 65 DC
        sta     VARAPL+12                       ; CB90 85 DC
        lda     VARAPL+13                       ; CB92 A5 DD
        adc     #$00                            ; CB94 69 00
        sta     VARAPL+13                       ; CB96 85 DD
LCB98:  ldy     #$00                            ; CB98 A0 00
        sec                                     ; CB9A 38
        lda     (VARAPL+12),y                   ; CB9B B1 DC
        beq     LCBA9                           ; CB9D F0 0A
        lda     VARAPL+13                       ; CB9F A5 DD
        cmp     SCEFIN+1                        ; CBA1 C5 5F
        bne     LCBA9                           ; CBA3 D0 04
        lda     VARAPL+12                       ; CBA5 A5 DC
        cmp     SCEFIN                          ; CBA7 C5 5E
LCBA9:  rts                                     ; CBA9 60

; ----------------------------------------------------------------------------
LCBAA:  jsr     LCC04                           ; CBAA 20 04 CC
        bcc     LCBB5                           ; CBAD 90 06
        jsr     LCB89                           ; CBAF 20 89 CB
        bcc     LCBB6                           ; CBB2 90 02
        clc                                     ; CBB4 18
LCBB5:  rts                                     ; CBB5 60

; ----------------------------------------------------------------------------
LCBB6:  iny                                     ; CBB6 C8
        lda     (VARAPL+12),y                   ; CBB7 B1 DC
        pha                                     ; CBB9 48
        iny                                     ; CBBA C8
        lda     (VARAPL+12),y                   ; CBBB B1 DC
        tay                                     ; CBBD A8
        pla                                     ; CBBE 68
        sec                                     ; CBBF 38
        rts                                     ; CBC0 60

; ----------------------------------------------------------------------------
LCBC1:  sta     RES                             ; CBC1 85 00
        sty     RES+1                           ; CBC3 84 01
        lda     SCEDEB                          ; CBC5 A5 5C
        sta     VARAPL+12                       ; CBC7 85 DC
        lda     SCEDEB+1                        ; CBC9 A5 5D
        sta     VARAPL+13                       ; CBCB 85 DD
        ldy     #$01                            ; CBCD A0 01
        lda     (VARAPL+12),y                   ; CBCF B1 DC
        sta     RESB                            ; CBD1 85 02
        iny                                     ; CBD3 C8
        lda     (VARAPL+12),y                   ; CBD4 B1 DC
        sta     RESB+1                          ; CBD6 85 03
        cmp     RES+1                           ; CBD8 C5 01
        bne     LCBE0                           ; CBDA D0 04
        lda     RESB                            ; CBDC A5 02
        cmp     RES                             ; CBDE C5 00
LCBE0:  bcc     LCBE4                           ; CBE0 90 02
        clc                                     ; CBE2 18
        rts                                     ; CBE3 60

; ----------------------------------------------------------------------------
LCBE4:  jsr     LCB89                           ; CBE4 20 89 CB
        bcs     LCC00                           ; CBE7 B0 17
        iny                                     ; CBE9 C8
        lda     (VARAPL+12),y                   ; CBEA B1 DC
        pha                                     ; CBEC 48
        iny                                     ; CBED C8
        lda     (VARAPL+12),y                   ; CBEE B1 DC
        tay                                     ; CBF0 A8
        pla                                     ; CBF1 68
        cpy     RES+1                           ; CBF2 C4 01
        bne     LCBF8                           ; CBF4 D0 02
        cmp     RES                             ; CBF6 C5 00
LCBF8:  bcs     LCC00                           ; CBF8 B0 06
        sta     RESB                            ; CBFA 85 02
        sty     RESB+1                          ; CBFC 84 03
        bne     LCBE4                           ; CBFE D0 E4
LCC00:  lda     RESB                            ; CC00 A5 02
        ldy     RESB+1                          ; CC02 A4 03
LCC04:  sta     RES                             ; CC04 85 00
        sty     RES+1                           ; CC06 84 01
        lda     SCEDEB                          ; CC08 A5 5C
        ldy     SCEDEB+1                        ; CC0A A4 5D
        sta     VARAPL+12                       ; CC0C 85 DC
        sty     VARAPL+13                       ; CC0E 84 DD
        jsr     LCB98                           ; CC10 20 98 CB
        bcs     LCC2B                           ; CC13 B0 16
LCC15:  ldy     #$02                            ; CC15 A0 02
        lda     RES+1                           ; CC17 A5 01
        cmp     (VARAPL+12),y                   ; CC19 D1 DC
        bne     LCC24                           ; CC1B D0 07
        dey                                     ; CC1D 88
        lda     RES                             ; CC1E A5 00
        cmp     (VARAPL+12),y                   ; CC20 D1 DC
        beq     LCC2C                           ; CC22 F0 08
LCC24:  bcc     LCC2B                           ; CC24 90 05
        jsr     LCB89                           ; CC26 20 89 CB
        bcc     LCC15                           ; CC29 90 EA
LCC2B:  clc                                     ; CC2B 18
LCC2C:  lda     RES                             ; CC2C A5 00
        ldy     RES+1                           ; CC2E A4 01
        rts                                     ; CC30 60

; ----------------------------------------------------------------------------
LCC31:  lda     VARAPL+3                        ; CC31 A5 D3
        ldy     VARAPL+4                        ; CC33 A4 D4
        jmp     LCC04                           ; CC35 4C 04 CC

; ----------------------------------------------------------------------------
LCC38:  lda     Ptr1                            ; CC38 AD EE 04
        ldy     Ptr1+1                          ; CC3B AC EF 04
        sta     Proc1+1                         ; CC3E 8D E3 04
        sty     Proc1+2                         ; CC41 8C E4 04
        rts                                     ; CC44 60

; ----------------------------------------------------------------------------
LCC45:  lda     Proc1+1                         ; CC45 AD E3 04
        bne     LCC4D                           ; CC48 D0 03
        dec     Proc1+2                         ; CC4A CE E4 04
LCC4D:  dec     Proc1+1                         ; CC4D CE E3 04
        jmp     LCC5B                           ; CC50 4C 5B CC

; ----------------------------------------------------------------------------
LCC53:  inc     Proc1+1                         ; CC53 EE E3 04
        bne     LCC5B                           ; CC56 D0 03
        inc     Proc1+2                         ; CC58 EE E4 04
LCC5B:  lda     #$E2                            ; CC5B A9 E2
        sta     VEXBNK+1                        ; CC5D 8D 15 04
        lda     #$04                            ; CC60 A9 04
        sta     VEXBNK+2                        ; CC62 8D 16 04
        lda     BNKSAV                          ; CC65 AD E1 04
        sta     BNKCIB                          ; CC68 8D 17 04
LCC6B:  sei                                     ; CC6B 78
        jsr     EXBNK                           ; CC6C 20 0C 04
        cli                                     ; CC6F 58
        rts                                     ; CC70 60

; ----------------------------------------------------------------------------
LCC71:  pha                                     ; CC71 48
        lda     Proc1+1                         ; CC72 AD E3 04
        sta     Proc1+5                         ; CC75 8D E7 04
        lda     Proc1+2                         ; CC78 AD E4 04
        sta     Proc1+6                         ; CC7B 8D E8 04
        lda     #$E6                            ; CC7E A9 E6
        sta     VEXBNK+1                        ; CC80 8D 15 04
        lda     #$04                            ; CC83 A9 04
        sta     VEXBNK+2                        ; CC85 8D 16 04
        lda     BNKSAV                          ; CC88 AD E1 04
        sta     BNKCIB                          ; CC8B 8D 17 04
        pla                                     ; CC8E 68
        jmp     LCC6B                           ; CC8F 4C 6B CC

; ----------------------------------------------------------------------------
LCC92:  ldx     Ptr2                            ; CC92 AE F0 04
        lda     Ptr2+1                          ; CC95 AD F1 04
        cmp     Proc1+2                         ; CC98 CD E4 04
        bne     LCCA0                           ; CC9B D0 03
        cpx     Proc1+1                         ; CC9D EC E3 04
LCCA0:  rts                                     ; CCA0 60

; ----------------------------------------------------------------------------
LCCA1:  clc                                     ; CCA1 18
        lda     Proc1+1                         ; CCA2 AD E3 04
        adc     VARAPL+14                       ; CCA5 65 DE
        sta     Proc1+1                         ; CCA7 8D E3 04
        lda     Proc1+2                         ; CCAA AD E4 04
        adc     VARAPL+15                       ; CCAD 65 DF
        sta     Proc1+2                         ; CCAF 8D E4 04
        rts                                     ; CCB2 60

; ----------------------------------------------------------------------------
LCCB3:  clc                                     ; CCB3 18
        lda     Proc1+9                         ; CCB4 AD EB 04
        adc     VARAPL+14                       ; CCB7 65 DE
        sta     Proc1+9                         ; CCB9 8D EB 04
        lda     Proc1+10                        ; CCBC AD EC 04
        adc     VARAPL+15                       ; CCBF 65 DF
        sta     Proc1+10                        ; CCC1 8D EC 04
        rts                                     ; CCC4 60

; ----------------------------------------------------------------------------
LCCC5:  lda     Ptr3                            ; CCC5 AD F2 04
        ldy     Ptr3+1                          ; CCC8 AC F3 04
        sta     Proc1+9                         ; CCCB 8D EB 04
        sty     Proc1+10                        ; CCCE 8C EC 04
        rts                                     ; CCD1 60

; ----------------------------------------------------------------------------
LCCD2:  inc     Proc1+9                         ; CCD2 EE EB 04
        bne     LCCDA                           ; CCD5 D0 03
        inc     Proc1+10                        ; CCD7 EE EC 04
LCCDA:  rts                                     ; CCDA 60

; ----------------------------------------------------------------------------
LCCDB:  pha                                     ; CCDB 48
        lda     #$EA                            ; CCDC A9 EA
        sta     VEXBNK+1                        ; CCDE 8D 15 04
        lda     #$04                            ; CCE1 A9 04
        sta     VEXBNK+2                        ; CCE3 8D 16 04
        lda     BNKSAV                          ; CCE6 AD E1 04
        sta     BNKCIB                          ; CCE9 8D 17 04
        pla                                     ; CCEC 68
        jmp     LCC6B                           ; CCED 4C 6B CC

; ----------------------------------------------------------------------------
LCCF0:  ldx     #$00                            ; CCF0 A2 00
        stx     VARAPL+3                        ; CCF2 86 D3
        stx     VARAPL+4                        ; CCF4 86 D4
LCCF6:  sbc     #$2F                            ; CCF6 E9 2F
        sta     VARAPL+5                        ; CCF8 85 D5
        lda     VARAPL+4                        ; CCFA A5 D4
        cmp     #$1A                            ; CCFC C9 1A
        bcs     LCD46                           ; CCFE B0 46
        sta     VARAPL+6                        ; CD00 85 D6
        lda     VARAPL+3                        ; CD02 A5 D3
        asl                                     ; CD04 0A
        rol     VARAPL+6                        ; CD05 26 D6
        asl                                     ; CD07 0A
        rol     VARAPL+6                        ; CD08 26 D6
        adc     VARAPL+3                        ; CD0A 65 D3
        sta     VARAPL+3                        ; CD0C 85 D3
        lda     VARAPL+6                        ; CD0E A5 D6
        adc     VARAPL+4                        ; CD10 65 D4
        sta     VARAPL+4                        ; CD12 85 D4
        asl     VARAPL+3                        ; CD14 06 D3
        rol     VARAPL+4                        ; CD16 26 D4
        bcs     LCD46                           ; CD18 B0 2C
        lda     VARAPL+3                        ; CD1A A5 D3
        adc     VARAPL+5                        ; CD1C 65 D5
        sta     VARAPL+3                        ; CD1E 85 D3
        bcc     LCD26                           ; CD20 90 04
        inc     VARAPL+4                        ; CD22 E6 D4
        beq     LCD46                           ; CD24 F0 20
LCD26:  jsr     CharGet                         ; CD26 20 E2 00
        bcc     LCCF6                           ; CD29 90 CB
LCD2B:  rts                                     ; CD2B 60

; ----------------------------------------------------------------------------
; Saisie d'un nombre en binaire (%011011), maxi 2 octets
EvalBinWord:
        ldx     #$00                            ; CD2C A2 00
        stx     VARAPL+3                        ; CD2E 86 D3
        stx     VARAPL+4                        ; CD30 86 D4
LCD32:  jsr     CharGet                         ; CD32 20 E2 00
        bcs     LCD2B                           ; CD35 B0 F4
        cmp     #"1"                            ; CD37 C9 31
        beq     LCD40                           ; CD39 F0 05
        cmp     #"0"                            ; CD3B C9 30
        bne     LCD2B                           ; CD3D D0 EC
        clc                                     ; CD3F 18
LCD40:  rol     VARAPL+3                        ; CD40 26 D3
        rol     VARAPL+4                        ; CD42 26 D4
        bcc     LCD32                           ; CD44 90 EC
LCD46:  ldx     #$0C                            ; CD46 A2 0C
        clc                                     ; CD48 18
        rts                                     ; CD49 60

; ----------------------------------------------------------------------------
LCD4A:  ldx     #$00                            ; CD4A A2 00
        stx     VARAPL+3                        ; CD4C 86 D3
        stx     VARAPL+4                        ; CD4E 86 D4
        beq     LCD62                           ; CD50 F0 10
LCD52:  ldx     #$03                            ; CD52 A2 03
        asl                                     ; CD54 0A
        asl                                     ; CD55 0A
        asl                                     ; CD56 0A
        asl                                     ; CD57 0A
LCD58:  asl                                     ; CD58 0A
        rol     VARAPL+3                        ; CD59 26 D3
        rol     VARAPL+4                        ; CD5B 26 D4
        bcs     LCD46                           ; CD5D B0 E7
        dex                                     ; CD5F CA
        bpl     LCD58                           ; CD60 10 F6
LCD62:  jsr     CharGet                         ; CD62 20 E2 00
        jsr     LCD6E                           ; CD65 20 6E CD
        bcc     LCD52                           ; CD68 90 E8
        jsr     CharGot                         ; CD6A 20 E8 00
        rts                                     ; CD6D 60

; ----------------------------------------------------------------------------
LCD6E:  jsr     min_MAJ                         ; CD6E 20 BF C9
        cmp     #$80                            ; CD71 C9 80
        bcs     LCD86                           ; CD73 B0 11
        ora     #$80                            ; CD75 09 80
        eor     #$B0                            ; CD77 49 B0
        cmp     #$0A                            ; CD79 C9 0A
        bcc     LCD86                           ; CD7B 90 09
        adc     #$88                            ; CD7D 69 88
        cmp     #$FA                            ; CD7F C9 FA
        bcs     LCD85                           ; CD81 B0 02
        sec                                     ; CD83 38
        .byte   $24                             ; CD84 24
LCD85:  clc                                     ; CD85 18
LCD86:  rts                                     ; CD86 60

; ----------------------------------------------------------------------------
LCD87:  tya                                     ; CD87 98
        pha                                     ; CD88 48
        jsr     CharGot                         ; CD89 20 E8 00
        bcs     LCD94                           ; CD8C B0 06
        jsr     LCCF0                           ; CD8E 20 F0 CC
        jmp     LCDD3                           ; CD91 4C D3 CD

; ----------------------------------------------------------------------------
LCD94:  ldx     TXTPTR+1                        ; CD94 A6 EA
        cpx     #$05                            ; CD96 E0 05
        bne     LCD9E                           ; CD98 D0 04
        cmp     #"#"                            ; CD9A C9 23
        beq     LCDA2                           ; CD9C F0 04
LCD9E:  cmp     #"$"                            ; CD9E C9 24
        bne     LCDB1                           ; CDA0 D0 0F
LCDA2:  ldy     #$01                            ; CDA2 A0 01
        lda     (TXTPTR),y                      ; CDA4 B1 E9
        jsr     LCD6E                           ; CDA6 20 6E CD
        bcs     LCDDC                           ; CDA9 B0 31
        jsr     LCD4A                           ; CDAB 20 4A CD
        jmp     LCDD3                           ; CDAE 4C D3 CD

; ----------------------------------------------------------------------------
LCDB1:  cmp     #"%"                            ; CDB1 C9 25
        bne     LCDC7                           ; CDB3 D0 12
        ldy     #$01                            ; CDB5 A0 01
        lda     (TXTPTR),y                      ; CDB7 B1 E9
        cmp     #"0"                            ; CDB9 C9 30
        beq     LCDC1                           ; CDBB F0 04
        cmp     #"1"                            ; CDBD C9 31
        bne     LCDDC                           ; CDBF D0 1B
LCDC1:  jsr     EvalBinWord                     ; CDC1 20 2C CD
        jmp     LCDD3                           ; CDC4 4C D3 CD

; ----------------------------------------------------------------------------
LCDC7:  jsr     LC926                           ; CDC7 20 26 C9
        bcs     LCDD0                           ; CDCA B0 04
        ldx     #$00                            ; CDCC A2 00
        beq     LCDDE                           ; CDCE F0 0E
LCDD0:  jsr     SymLookup                       ; CDD0 20 77 CE
LCDD3:  bcc     LCDDE                           ; CDD3 90 09
        pla                                     ; CDD5 68
        tay                                     ; CDD6 A8
        jsr     CharGot                         ; CDD7 20 E8 00
        sec                                     ; CDDA 38
        rts                                     ; CDDB 60

; ----------------------------------------------------------------------------
LCDDC:  ldx     #$0B                            ; CDDC A2 0B
LCDDE:  pla                                     ; CDDE 68
        tay                                     ; CDDF A8
        jsr     CharGot                         ; CDE0 20 E8 00
        clc                                     ; CDE3 18
        rts                                     ; CDE4 60

; ----------------------------------------------------------------------------
; Find symbol in local symbol table, return C=1 + symbol address in VARAPL+3 if
; found
LocSymLookup:
        ldx     #$00                            ; CDE5 A2 00
        stx     VARAPL+5                        ; CDE7 86 D5
        ldx     VARAPL2+17                      ; CDE9 A6 FC
        stx     VARAPL+1                        ; CDEB 86 D1
        ldx     VARAPL2+18                      ; CDED A6 FD
        stx     VARAPL+2                        ; CDEF 86 D2
        ldx     VARAPL2+15                      ; CDF1 A6 FA
        stx     VARAPL+12                       ; CDF3 86 DC
        lda     VARAPL2+16                      ; CDF5 A5 FB
        sta     VARAPL+13                       ; CDF7 85 DD
        bne     LCE2A                           ; CDF9 D0 2F
LCDFB:  ldy     #$FF                            ; CDFB A0 FF
LCDFD:  iny                                     ; CDFD C8
        cpy     #$06                            ; CDFE C0 06
        beq     LCE37                           ; CE00 F0 35
        lda     (TXTPTR),y                      ; CE02 B1 E9
        bit     VARAPL+5                        ; CE04 24 D5
        bpl     LCE0B                           ; CE06 10 03
        jsr     min_MAJ                         ; CE08 20 BF C9
LCE0B:  cmp     (VARAPL+12),y                   ; CE0B D1 DC
        beq     LCDFD                           ; CE0D F0 EE
        lda     (VARAPL+12),y                   ; CE0F B1 DC
        cmp     #" "                            ; CE11 C9 20
        bne     LCE1C                           ; CE13 D0 07
        lda     (TXTPTR),y                      ; CE15 B1 E9
        jsr     LC91A                           ; CE17 20 1A C9
        bcc     LCE37                           ; CE1A 90 1B
LCE1C:  clc                                     ; CE1C 18
        lda     VARAPL+12                       ; CE1D A5 DC
        adc     #$08                            ; CE1F 69 08
        sta     VARAPL+12                       ; CE21 85 DC
        tax                                     ; CE23 AA
        lda     VARAPL+13                       ; CE24 A5 DD
        adc     #$00                            ; CE26 69 00
        sta     VARAPL+13                       ; CE28 85 DD
LCE2A:  cmp     VARAPL+2                        ; CE2A C5 D2
        bne     LCE30                           ; CE2C D0 02
        cpx     VARAPL+1                        ; CE2E E4 D1
LCE30:  bcc     LCDFB                           ; CE30 90 C9
        ldx     #$11                            ; CE32 A2 11
        clc                                     ; CE34 18
        bcc     LCE46                           ; CE35 90 0F
LCE37:  jsr     IncTXTPTR                       ; CE37 20 85 CE
        ldy     #$06                            ; CE3A A0 06
        lda     (VARAPL+12),y                   ; CE3C B1 DC
        sta     VARAPL+3                        ; CE3E 85 D3
        iny                                     ; CE40 C8
        lda     (VARAPL+12),y                   ; CE41 B1 DC
        sta     VARAPL+4                        ; CE43 85 D4
        sec                                     ; CE45 38
LCE46:  ldy     #$00                            ; CE46 A0 00
        lda     (TXTPTR),y                      ; CE48 B1 E9
        rts                                     ; CE4A 60

; ----------------------------------------------------------------------------
; Find symbol in global symbol table, return C=1 + symbol address in VARAPL+3
; if found
GlobSymLookup:
        ldx     #$00                            ; CE4B A2 00
        stx     VARAPL+5                        ; CE4D 86 D5
        ldx     VARAPL2+11                      ; CE4F A6 F6
        stx     VARAPL+1                        ; CE51 86 D1
        ldx     VARAPL2+12                      ; CE53 A6 F7
        stx     VARAPL+2                        ; CE55 86 D2
        ldx     VARAPL2+9                       ; CE57 A6 F4
        stx     VARAPL+12                       ; CE59 86 DC
        lda     VARAPL2+10                      ; CE5B A5 F5
        sta     VARAPL+13                       ; CE5D 85 DD
        bne     LCE2A                           ; CE5F D0 C9
; Find symbol in monitor symbol table, return C=1 + symbol address in VARAPL+3
; if found
MonSymLookup:
        ldx     #$80                            ; CE61 A2 80
        stx     VARAPL+5                        ; CE63 86 D5
        ldx     #<SymbolTableEnd                ; CE65 A2 C8
        stx     VARAPL+1                        ; CE67 86 D1
        ldx     #>SymbolTableEnd                ; CE69 A2 FF
        stx     VARAPL+2                        ; CE6B 86 D2
        ldx     #<SymbolTable                   ; CE6D A2 18
        stx     VARAPL+12                       ; CE6F 86 DC
        lda     #>SymbolTable                   ; CE71 A9 F0
        sta     VARAPL+13                       ; CE73 85 DD
        bne     LCE2A                           ; CE75 D0 B3
; Find symbol in global, local, monitor symbol table, return C=1 + symbol
; address in VARAPL+3 if found
SymLookup:
        jsr     GlobSymLookup                   ; CE77 20 4B CE
        bcs     LCE84                           ; CE7A B0 08
        jsr     LocSymLookup                    ; CE7C 20 E5 CD
        bcs     LCE84                           ; CE7F B0 03
        jsr     MonSymLookup                    ; CE81 20 61 CE
LCE84:  rts                                     ; CE84 60

; ----------------------------------------------------------------------------
; Add Y to TXTPTR
IncTXTPTR:
        tya                                     ; CE85 98
        clc                                     ; CE86 18
        adc     TXTPTR                          ; CE87 65 E9
        sta     TXTPTR                          ; CE89 85 E9
        bcc     LCE8F                           ; CE8B 90 02
        inc     TXTPTR+1                        ; CE8D E6 EA
LCE8F:  rts                                     ; CE8F 60

; ----------------------------------------------------------------------------
LCE90:  cmp     #'"'                            ; CE90 C9 22
        bne     LCEB3                           ; CE92 D0 1F
        sty     VARAPL                          ; CE94 84 D0
        ldy     #$01                            ; CE96 A0 01
        lda     (TXTPTR),y                      ; CE98 B1 E9
        beq     SyntaxErr                       ; CE9A F0 62
        sta     VARAPL+3                        ; CE9C 85 D3
        iny                                     ; CE9E C8
        lda     (TXTPTR),y                      ; CE9F B1 E9
        cmp     #'"'                            ; CEA1 C9 22
        bne     LCEA6                           ; CEA3 D0 01
        iny                                     ; CEA5 C8
LCEA6:  jsr     IncTXTPTR                       ; CEA6 20 85 CE
        ldy     VARAPL                          ; CEA9 A4 D0
        ldx     #$00                            ; CEAB A2 00
        stx     VARAPL+4                        ; CEAD 86 D4
        jsr     CharGot                         ; CEAF 20 E8 00
        rts                                     ; CEB2 60

; ----------------------------------------------------------------------------
LCEB3:  cmp     #"<"                            ; CEB3 C9 3C
        bne     LCEC4                           ; CEB5 D0 0D
        jsr     CharGet                         ; CEB7 20 E2 00
        jsr     LCD87                           ; CEBA 20 87 CD
        bcc     LCF03                           ; CEBD 90 44
        ldx     #$00                            ; CEBF A2 00
        stx     VARAPL+4                        ; CEC1 86 D4
        rts                                     ; CEC3 60

; ----------------------------------------------------------------------------
LCEC4:  cmp     #">"                            ; CEC4 C9 3E
        bne     LCED9                           ; CEC6 D0 11
        jsr     CharGet                         ; CEC8 20 E2 00
        jsr     LCD87                           ; CECB 20 87 CD
        bcc     LCF03                           ; CECE 90 33
        ldx     VARAPL+4                        ; CED0 A6 D4
        stx     VARAPL+3                        ; CED2 86 D3
        ldx     #$00                            ; CED4 A2 00
        stx     VARAPL+4                        ; CED6 86 D4
        rts                                     ; CED8 60

; ----------------------------------------------------------------------------
LCED9:  jsr     LCD87                           ; CED9 20 87 CD
        bcc     LCF03                           ; CEDC 90 25
        rts                                     ; CEDE 60

; ----------------------------------------------------------------------------
; Evalue une expression
EvalExpr:
        jsr     LCE90                           ; CEDF 20 90 CE
        ldx     VARAPL+3                        ; CEE2 A6 D3
        stx     VARAPL+14                       ; CEE4 86 DE
        ldx     VARAPL+4                        ; CEE6 A6 D4
        stx     VARAPL+15                       ; CEE8 86 DF
LCEEA:  cmp     #"+"                            ; CEEA C9 2B
        bne     LCEF4                           ; CEEC D0 06
        jsr     EvalSomme                       ; CEEE 20 06 CF
        bne     LCEEA                           ; CEF1 D0 F7
LCEF3:  rts                                     ; CEF3 60

; ----------------------------------------------------------------------------
LCEF4:  cmp     #"-"                            ; CEF4 C9 2D
        bne     LCEF3                           ; CEF6 D0 FB
        jsr     EvalDifference                  ; CEF8 20 1E CF
        jmp     LCEEA                           ; CEFB 4C EA CE

; ----------------------------------------------------------------------------
; Err $00
SyntaxErr:
        ldx     #$00                            ; CEFE A2 00
        .byte   $2C                             ; CF00 2C
; Err $0C
OutOfRangeValErr:
        ldx     #$0C                            ; CF01 A2 0C
LCF03:  jmp     LCF98                           ; CF03 4C 98 CF

; ----------------------------------------------------------------------------
; Evalue une somme
EvalSomme:
        jsr     CharGet                         ; CF06 20 E2 00
        jsr     LCE90                           ; CF09 20 90 CE
        pha                                     ; CF0C 48
        clc                                     ; CF0D 18
        lda     VARAPL+14                       ; CF0E A5 DE
        adc     VARAPL+3                        ; CF10 65 D3
        sta     VARAPL+14                       ; CF12 85 DE
        lda     VARAPL+15                       ; CF14 A5 DF
        adc     VARAPL+4                        ; CF16 65 D4
        sta     VARAPL+15                       ; CF18 85 DF
        pla                                     ; CF1A 68
        bcs     OutOfRangeValErr                ; CF1B B0 E4
        rts                                     ; CF1D 60

; ----------------------------------------------------------------------------
; Evalue une différence
EvalDifference:
        jsr     CharGet                         ; CF1E 20 E2 00
        jsr     LCE90                           ; CF21 20 90 CE
        pha                                     ; CF24 48
        sec                                     ; CF25 38
        lda     VARAPL+14                       ; CF26 A5 DE
        sbc     VARAPL+3                        ; CF28 E5 D3
        sta     VARAPL+14                       ; CF2A 85 DE
        lda     VARAPL+15                       ; CF2C A5 DF
        sbc     VARAPL+4                        ; CF2E E5 D4
        sta     VARAPL+15                       ; CF30 85 DF
        pla                                     ; CF32 68
        bcc     OutOfRangeValErr                ; CF33 90 CC
        rts                                     ; CF35 60

; ----------------------------------------------------------------------------
LCF36:  pla                                     ; CF36 68
        tay                                     ; CF37 A8
        pla                                     ; CF38 68
        ldx     #$FE                            ; CF39 A2 FE
        txs                                     ; CF3B 9A
        pha                                     ; CF3C 48
        tya                                     ; CF3D 98
        pha                                     ; CF3E 48
        rts                                     ; CF3F 60

; ----------------------------------------------------------------------------
LCF40:  clc                                     ; CF40 18
        lda     SCEDEB                          ; CF41 A5 5C
        adc     #$FF                            ; CF43 69 FF
        sta     TXTPTR                          ; CF45 85 E9
        lda     SCEDEB+1                        ; CF47 A5 5D
        adc     #$FF                            ; CF49 69 FF
        sta     TXTPTR+1                        ; CF4B 85 EA
        ldy     #$00                            ; CF4D A0 00
        tya                                     ; CF4F 98
        sta     (TXTPTR),y                      ; CF50 91 E9
        rts                                     ; CF52 60

; ----------------------------------------------------------------------------
; Set TXTPTR = BUFEDT+X
SetTXTPTR:
        clc                                     ; CF53 18
        txa                                     ; CF54 8A
        adc     #<BUFEDT                        ; CF55 69 90
        sta     TXTPTR                          ; CF57 85 E9
        lda     #>BUFEDT                        ; CF59 A9 05
        adc     #$00                            ; CF5B 69 00
        sta     TXTPTR+1                        ; CF5D 85 EA
        rts                                     ; CF5F 60

; ----------------------------------------------------------------------------
LCF60:  lda     #<BUFEDT                        ; CF60 A9 90
        sta     TR0                             ; CF62 85 0C
        lda     #>BUFEDT                        ; CF64 A9 05
        sta     TR1                             ; CF66 85 0D
        lda     VARAPL+16                       ; CF68 A5 E0
        sta     RES                             ; CF6A 85 00
        lda     VARAPL+17                       ; CF6C A5 E1
        sta     RES+1                           ; CF6E 85 01
        tya                                     ; CF70 98
        BRK_TELEMON XINSER                             ; CF71 00 2E
; Initialise les pointeurs de la table des symboles locaux
LocTblInit:
        lda     SCEFIN                          ; CF73 A5 5E
        ldy     SCEFIN+1                        ; CF75 A4 5F
        sta     VARAPL2+15                      ; CF77 85 FA
        sta     VARAPL2+17                      ; CF79 85 FC
        sty     VARAPL2+16                      ; CF7B 84 FB
        sty     VARAPL2+18                      ; CF7D 84 FD
        rts                                     ; CF7F 60

; ----------------------------------------------------------------------------
LCF80:  lda     #XLPR                           ; CF80 A9 8E
        BRK_TELEMON XCL0                             ; CF82 00 04
        lda     #XSCR                           ; CF84 A9 88
        BRK_TELEMON XOP0                             ; CF86 00 00
        lda     #$00                            ; CF88 A9 00
        sta     XLPRBI                          ; CF8A 85 48
        rts                                     ; CF8C 60

; ----------------------------------------------------------------------------
LCF8D:  BRK_TELEMON XTSTLP                             ; CF8D 00 1E
        lda     #XSCR                           ; CF8F A9 88
        BRK_TELEMON XCL0                             ; CF91 00 04
        lda     #XLPR                           ; CF93 A9 8E
        BRK_TELEMON XOP0                             ; CF95 00 00
        rts                                     ; CF97 60

; ----------------------------------------------------------------------------
LCF98:  txa                                     ; CF98 8A
        pha                                     ; CF99 48
        jsr     LCF80                           ; CF9A 20 80 CF
        pla                                     ; CF9D 68
        tax                                     ; CF9E AA
        jsr     DispErrorX                      ; CF9F 20 1B C8
        jsr     LCF36                           ; CFA2 20 36 CF
        lda     VARAPL2+8                       ; CFA5 A5 F3
        bne     LCFB8                           ; CFA7 D0 0F
        lda     #>BUFEDT                        ; CFA9 A9 05
        cmp     TXTPTR+1                        ; CFAB C5 EA
        bne     LCFC2                           ; CFAD D0 13
        sec                                     ; CFAF 38
        lda     TXTPTR                          ; CFB0 A5 E9
        sbc     #<BUFEDT                        ; CFB2 E9 90
        tax                                     ; CFB4 AA
        jmp     LCFC4                           ; CFB5 4C C4 CF

; ----------------------------------------------------------------------------
LCFB8:  lda     VARAPL+16                       ; CFB8 A5 E0
        ldy     VARAPL+17                       ; CFBA A4 E1
        jsr     LCC04                           ; CFBC 20 04 CC
        jsr     LCAF2                           ; CFBF 20 F2 CA
LCFC2:  ldx     #$06                            ; CFC2 A2 06
LCFC4:  ldy     #$80                            ; CFC4 A0 80
        bmi     LCFD2                           ; CFC6 30 0A
LCFC8:  jsr     LCB5A                           ; CFC8 20 5A CB
LCFCB:  jsr     LCF80                           ; CFCB 20 80 CF
        ldx     #$00                            ; CFCE A2 00
        ldy     #$00                            ; CFD0 A0 00
LCFD2:  lda     #$6E                            ; CFD2 A9 6E
        BRK_TELEMON XEDT                             ; CFD4 00 2D
        pha                                     ; CFD6 48
        lda     RES                             ; CFD7 A5 00
        sta     VARAPL+16                       ; CFD9 85 E0
        lda     RES+1                           ; CFDB A5 01
        sta     VARAPL+17                       ; CFDD 85 E1
        pla                                     ; CFDF 68
        jsr     LC8DC                           ; CFE0 20 DC C8
        stx     VARAPL2+8                       ; CFE3 86 F3
        cpx     #$00                            ; CFE5 E0 00
        bne     LD010                           ; CFE7 D0 27
        cmp     #$0D                            ; CFE9 C9 0D
        bne     LCFCB                           ; CFEB D0 DE
        jsr     SkipSpaces                      ; CFED 20 2D CA
        beq     LCFCB                           ; CFF0 F0 D9
        jsr     CommandLookup                   ; CFF2 20 1D CA
        bmi     ExecCmd                         ; CFF5 30 09
        jsr     SetTXTPTR                       ; CFF7 20 53 CF
        jsr     CharGot                         ; CFFA 20 E8 00
        jmp     LD1BA                           ; CFFD 4C BA D1

; ----------------------------------------------------------------------------
; Execute command number ACC
ExecCmd:asl                                     ; D000 0A
        tay                                     ; D001 A8
        jsr     SetTXTPTR                       ; D002 20 53 CF
        lda     CommandsAddr+1,y                ; D005 B9 C8 C3
        pha                                     ; D008 48
        lda     CommandsAddr,y                  ; D009 B9 C7 C3
        pha                                     ; D00C 48
        jmp     CharGet                         ; D00D 4C E2 00

; ----------------------------------------------------------------------------
LD010:  cmp     #$03                            ; D010 C9 03
        beq     LCFCB                           ; D012 F0 B7
        cmp     #$0A                            ; D014 C9 0A
        bne     LD027                           ; D016 D0 0F
        lda     VARAPL+16                       ; D018 A5 E0
        ldy     VARAPL+17                       ; D01A A4 E1
        jsr     LCBAA                           ; D01C 20 AA CB
        bcc     LCFCB                           ; D01F 90 AA
        jsr     LCAF2                           ; D021 20 F2 CA
        jmp     LCFC2                           ; D024 4C C2 CF

; ----------------------------------------------------------------------------
LD027:  cmp     #$0B                            ; D027 C9 0B
        bne     LD040                           ; D029 D0 15
        BRK_TELEMON XWR0                             ; D02B 00 10
        lda     #CR                             ; D02D A9 0D
        BRK_TELEMON XWR0                             ; D02F 00 10
        lda     VARAPL+16                       ; D031 A5 E0
        ldy     VARAPL+17                       ; D033 A4 E1
        jsr     LCBC1                           ; D035 20 C1 CB
        bcc     LCFCB                           ; D038 90 91
        jsr     LCA91                           ; D03A 20 91 CA
        jmp     LCFC2                           ; D03D 4C C2 CF

; ----------------------------------------------------------------------------
LD040:  ldy     #$00                            ; D040 A0 00
        jsr     LCA30                           ; D042 20 30 CA
        beq     LD04C                           ; D045 F0 05
        jsr     LC934                           ; D047 20 34 C9
        bcc     LD052                           ; D04A 90 06
LD04C:  jsr     LCF60                           ; D04C 20 60 CF
        jmp     LCFCB                           ; D04F 4C CB CF

; ----------------------------------------------------------------------------
LD052:  lda     #VT                             ; D052 A9 0B
        BRK_TELEMON XWR0                             ; D054 00 10
        jsr     DispErrorX                      ; D056 20 1B C8
        tax                                     ; D059 AA
        jmp     LCFC4                           ; D05A 4C C4 CF

; ----------------------------------------------------------------------------
LD05D:  BRK_TELEMON XWR0                             ; D05D 00 10
        BRK_TELEMON XCRLF                             ; D05F 00 25
; QUIT: sortie du moniteur, retour au basic par JMP $C000
QUIT:   jsr     Clear                           ; D061 20 20 D1
        jsr     LC88B                           ; D064 20 8B C8
        ldx     #$06                            ; D067 A2 06
        lda     #$E6                            ; D069 A9 E6
        ldy     #$FF                            ; D06B A0 FF
        jmp     LD27E                           ; D06D 4C 7E D2

; ----------------------------------------------------------------------------
; teleass_start
teleass_start:
        lda     #<Menu_str                      ; D070 A9 E5
        ldy     #>Menu_str                      ; D072 A0 C6
        BRK_TELEMON XWSTR0                             ; D074 00 14
LD076:  jsr     GetKey                          ; D076 20 D1 C8
        cmp     #"1"                            ; D079 C9 31
        beq     LD05D                           ; D07B F0 E0
        cmp     #"2"                            ; D07D C9 32
        bne     LD076                           ; D07F D0 F5
        BRK_TELEMON XWR0                             ; D081 00 10
        BRK_TELEMON XCRLF                             ; D083 00 25
        lda     #$07                            ; D085 A9 07
        sta     DEFBNK                          ; D087 8D E0 04
        lda     #$00                            ; D08A A9 00
        sta     SCEDEB                          ; D08C 85 5C
        sta     LPRY                            ; D08E 8D 87 02
        lda     #$08                            ; D091 A9 08
        sta     SCEDEB+1                        ; D093 85 5D
        lda     #$00                            ; D095 A9 00
        sta     VARAPL2+9                       ; D097 85 F4
        sta     VARAPL2+11                      ; D099 85 F6
        lda     #$FF                            ; D09B A9 FF
        sta     VARAPL2+13                      ; D09D 85 F8
        lda     #$30                            ; D09F A9 30
        sta     VARAPL2+10                      ; D0A1 85 F5
        sta     VARAPL2+12                      ; D0A3 85 F7
        lda     #$3F                            ; D0A5 A9 3F
        sta     VARAPL2+14                      ; D0A7 85 F9
        jsr     Clear                           ; D0A9 20 20 D1
        lda     #$42                            ; D0AC A9 42
        sta     LPRFY                           ; D0AE 8D 89 02
        sta     LPRSY                           ; D0B1 8D 8B 02
Warm_start:
        jsr     LocTblInit                      ; D0B4 20 73 CF
        ldx     #$10                            ; D0B7 A2 10
LD0B9:  lda     _CharGet,x                      ; D0B9 BD F0 D0
        sta     CharGet,x                       ; D0BC 95 E2
        dex                                     ; D0BE CA
        bpl     LD0B9                           ; D0BF 10 F8
        ldy     #$0B                            ; D0C1 A0 0B
LD0C3:  lda     _Proc1,y                        ; D0C3 B9 01 D1
        sta     Proc1,y                         ; D0C6 99 E2 04
        dey                                     ; D0C9 88
        bpl     LD0C3                           ; D0CA 10 F7
        tya                                     ; D0CC 98
        iny                                     ; D0CD C8
        sta     (TXTPTR),y                      ; D0CE 91 E9
        lda     FLGSCR                          ; D0D0 AD 48 02
        ora     #$90                            ; D0D3 09 90
        sta     FLGSCR                          ; D0D5 8D 48 02
        lda     V2DRA                           ; D0D8 AD 21 03
        and     #$07                            ; D0DB 29 07
        sta     VNMI                            ; D0DD 8D F4 02
        lda     #<Warm_start                    ; D0E0 A9 B4
        sta     VNMI+1                          ; D0E2 8D F5 02
        lda     #>Warm_start                    ; D0E5 A9 D0
        sta     VNMI+2                          ; D0E7 8D F6 02
        jsr     LC8DC                           ; D0EA 20 DC C8
        jmp     LCFCB                           ; D0ED 4C CB CF

; ----------------------------------------------------------------------------
; Prends le caractère suivant en sautant les espaces (Copié en VARAPL+18)
_CharGet:
        inc     TXTPTR                          ; D0F0 E6 E9
        bne     _CharGot                        ; D0F2 D0 02
        inc     TXTPTR+1                        ; D0F4 E6 EA
; Prends le caractère courant
_CharGot:
        lda     teleass_irq_vector+1            ; D0F6 AD FF FF
        cmp     #" "                            ; D0F9 C9 20
        beq     _CharGet                        ; D0FB F0 F3
        jsr     LD10D                           ; D0FD 20 0D D1
        rts                                     ; D100 60

; ----------------------------------------------------------------------------
; Trouver un meilleur nom (cf $04E2)
_Proc1: lda     teleass_irq_vector+1            ; D101 AD FF FF
        rts                                     ; D104 60

; ----------------------------------------------------------------------------
        sta     teleass_irq_vector+1            ; D105 8D FF FF
        rts                                     ; D108 60

; ----------------------------------------------------------------------------
        sta     teleass_irq_vector+1            ; D109 8D FF FF
        rts                                     ; D10C 60

; ----------------------------------------------------------------------------
LD10D:  cmp     #$00                            ; D10D C9 00
        beq     LD11F                           ; D10F F0 0E
        cmp     #"'"                            ; D111 C9 27
        beq     LD11F                           ; D113 F0 0A
        cmp     #"9"+1                            ; D115 C9 3A
        bcs     LD11F                           ; D117 B0 06
        sec                                     ; D119 38
        sbc     #$30                            ; D11A E9 30
        sec                                     ; D11C 38
        sbc     #$D0                            ; D11D E9 D0
LD11F:  rts                                     ; D11F 60

; ----------------------------------------------------------------------------
; Efface le programme et initialise les pointeurs de la table des symboles
; locaux
Clear:  ldy     #$00                            ; D120 A0 00
        tya                                     ; D122 98
        sta     (SCEDEB),y                      ; D123 91 5C
        clc                                     ; D125 18
        lda     SCEDEB                          ; D126 A5 5C
        adc     #$01                            ; D128 69 01
        sta     SCEFIN                          ; D12A 85 5E
        lda     SCEDEB+1                        ; D12C A5 5D
        adc     #$00                            ; D12E 69 00
        sta     SCEFIN+1                        ; D130 85 5F
        jmp     LocTblInit                      ; D132 4C 73 CF

; ----------------------------------------------------------------------------
; NEW : efface le programme source en mémoire
NEW:    tax                                     ; D135 AA
        bne     SyntaxErr1                      ; D136 D0 69
        jsr     Clear                           ; D138 20 20 D1
        jmp     LCFCB                           ; D13B 4C CB CF

; ----------------------------------------------------------------------------
LD13E:  ldy     #$00                            ; D13E A0 00
        cmp     #'"'                            ; D140 C9 22
        bne     LD14A                           ; D142 D0 06
        jsr     CharGet                         ; D144 20 E2 00
        tax                                     ; D147 AA
        beq     SyntaxErr1                      ; D148 F0 57
LD14A:  lda     TXTPTR                          ; D14A A5 E9
        pha                                     ; D14C 48
        lda     TXTPTR+1                        ; D14D A5 EA
        pha                                     ; D14F 48
LD150:  lda     (TXTPTR),y                      ; D150 B1 E9
        beq     LD161                           ; D152 F0 0D
        cmp     #","                            ; D154 C9 2C
        beq     LD161                           ; D156 F0 09
        cmp     #'"'                            ; D158 C9 22
        beq     LD161                           ; D15A F0 05
        iny                                     ; D15C C8
        bne     LD150                           ; D15D D0 F1
        beq     SyntaxErr1                      ; D15F F0 40
LD161:  tya                                     ; D161 98
        tax                                     ; D162 AA
        lda     (TXTPTR),y                      ; D163 B1 E9
        cmp     #'"'                            ; D165 C9 22
        bne     LD16A                           ; D167 D0 01
        iny                                     ; D169 C8
LD16A:  jsr     IncTXTPTR                       ; D16A 20 85 CE
        pla                                     ; D16D 68
        tay                                     ; D16E A8
        pla                                     ; D16F 68
        BRK_TELEMON XNOMFI                             ; D170 00 24
        txa                                     ; D172 8A
        bmi     FileNameErr                     ; D173 30 2F
        ldy     BUFNOM                          ; D175 AC 17 05
        lda     TABDRV,y                        ; D178 B9 08 02
        beq     DriveErr                        ; D17B F0 21
        sty     DRIVE                           ; D17D 8C 00 05
        txa                                     ; D180 8A
        rts                                     ; D181 60

; ----------------------------------------------------------------------------
LD182:  tax                                     ; D182 AA
        beq     SyntaxErr1                      ; D183 F0 1C
        ldx     #$00                            ; D185 A2 00
        stx     VSALO0                          ; D187 8E 28 05
        stx     VSALO1                          ; D18A 8E 29 05
        jsr     LD13E                           ; D18D 20 3E D1
        beq     SyntaxErr1                      ; D190 F0 0F
        php                                     ; D192 08
        cpx     #$02                            ; D193 E0 02
        beq     LD19B                           ; D195 F0 04
        plp                                     ; D197 28
        php                                     ; D198 08
        bcs     WildCardErr                     ; D199 B0 0C
LD19B:  plp                                     ; D19B 28
        dex                                     ; D19C CA
        rts                                     ; D19D 60

; ----------------------------------------------------------------------------
; Err $0A
DriveErr:
        ldx     #$0A                            ; D19E A2 0A
        .byte   $2C                             ; D1A0 2C
; Err $00
SyntaxErr1:
        ldx     #$00                            ; D1A1 A2 00
        .byte   $2C                             ; D1A3 2C
; Err $09
FileNameErr:
        ldx     #$09                            ; D1A4 A2 09
        .byte   $2C                             ; D1A6 2C
; Err $18
WildCardErr:
        ldx     #$18                            ; D1A7 A2 18
LD1A9:  jmp     LCF98                           ; D1A9 4C 98 CF

; ----------------------------------------------------------------------------
; Evalue une ','
EvalComma:
        cmp     #","                            ; D1AC C9 2C
        bne     SyntaxErr1                      ; D1AE D0 F1
        jsr     CharGet                         ; D1B0 20 E2 00
        jsr     min_MAJ                         ; D1B3 20 BF C9
        tax                                     ; D1B6 AA
        beq     SyntaxErr1                      ; D1B7 F0 E8
        rts                                     ; D1B9 60

; ----------------------------------------------------------------------------
LD1BA:  jsr     LD182                           ; D1BA 20 82 D1
        beq     LD1CD                           ; D1BD F0 0E
        jsr     CharGot                         ; D1BF 20 E8 00
        tax                                     ; D1C2 AA
        bne     SyntaxErr1                      ; D1C3 D0 DC
        jmp     LCFCB                           ; D1C5 4C CB CF

; ----------------------------------------------------------------------------
; LOAD ''NF'' (,A EN) (,V) (,N) : chargement d'un fichier (A EN->force
; l'adresse de chargement, V->affiche les adresses de début et fin, N->force le
; chargement sans exécution)
LOAD:   jsr     LD182                           ; D1C8 20 82 D1
        bne     FileNameErr                     ; D1CB D0 D7
LD1CD:  jsr     CharGot                         ; D1CD 20 E8 00
        tax                                     ; D1D0 AA
LD1D1:  beq     LD208                           ; D1D1 F0 35
        jsr     EvalComma                       ; D1D3 20 AC D1
        cmp     #"V"                            ; D1D6 C9 56
        bne     LD1ED                           ; D1D8 D0 13
        lda     #$40                            ; D1DA A9 40
LD1DC:  pha                                     ; D1DC 48
        lda     VSALO0                          ; D1DD AD 28 05
        bne     LD1A9                           ; D1E0 D0 C7
        pla                                     ; D1E2 68
        sta     VSALO0                          ; D1E3 8D 28 05
        jsr     CharGet                         ; D1E6 20 E2 00
        tax                                     ; D1E9 AA
        jmp     LD1D1                           ; D1EA 4C D1 D1

; ----------------------------------------------------------------------------
LD1ED:  cmp     #"N"                            ; D1ED C9 4E
        bne     LD1F5                           ; D1EF D0 04
        lda     #$80                            ; D1F1 A9 80
        bne     LD1DC                           ; D1F3 D0 E7
LD1F5:  cmp     #"A"                            ; D1F5 C9 41
        bne     SyntaxErr1                      ; D1F7 D0 A8
        lda     VSALO1                          ; D1F9 AD 29 05
        bne     SyntaxErr1                      ; D1FC D0 A3
        lda     #$80                            ; D1FE A9 80
        sta     VSALO1                          ; D200 8D 29 05
        jsr     LD273                           ; D203 20 73 D2
        bne     LD1D1                           ; D206 D0 C9
LD208:  lda     #<XLOAD                         ; D208 A9 62
        ldy     #>XLOAD                         ; D20A A0 FF
        jsr     EXBNK0ERR                       ; D20C 20 5E D2
        bit     FTYPE                           ; D20F 2C 2C 05
        bpl     LD226                           ; D212 10 12
        bit     VSALO0                          ; D214 2C 28 05
        bvs     LD226                           ; D217 70 0D
        lda     INPIS                           ; D219 AD 2D 05
        ldy     INSEC                           ; D21C AC 2E 05
        sta     SCEDEB                          ; D21F 85 5C
        sty     SCEDEB+1                        ; D221 84 5D
        jsr     LD229                           ; D223 20 29 D2
LD226:  jmp     LCFCB                           ; D226 4C CB CF

; ----------------------------------------------------------------------------
LD229:  lda     PARPIS                          ; D229 AD 2F 05
        ldy     PARSEC                          ; D22C AC 30 05
        sta     SCEFIN                          ; D22F 85 5E
        sty     SCEFIN+1                        ; D231 84 5F
        jsr     LocTblInit                      ; D233 20 73 CF
LD236:  cpy     VARAPL2+10                      ; D236 C4 F5
        bcc     LD266                           ; D238 90 2C
        bne     LD240                           ; D23A D0 04
        cmp     VARAPL2+9                       ; D23C C5 F4
        bcc     LD266                           ; D23E 90 26
LD240:  sta     VARAPL2+9                       ; D240 85 F4
        sty     VARAPL2+10                      ; D242 84 F5
        sta     VARAPL2+11                      ; D244 85 F6
        sty     VARAPL2+12                      ; D246 84 F7
        sta     VARAPL2+13                      ; D248 85 F8
        iny                                     ; D24A C8
        sty     VARAPL2+14                      ; D24B 84 F9
        ldx     #$19                            ; D24D A2 19
        jmp     DispErrorX                      ; D24F 4C 1B C8

; ----------------------------------------------------------------------------
LD252:  jsr     EXBNK0ERR                       ; D252 20 5E D2
        jmp     LCFCB                           ; D255 4C CB CF

; ----------------------------------------------------------------------------
LD258:  ldx     ERRNB                           ; D258 AE 12 05
        jmp     LCF98                           ; D25B 4C 98 CF

; ----------------------------------------------------------------------------
; Exécute une routine en banque 0 et affiche le code d'erreur
EXBNK0ERR:
        jsr     EXBNK0                          ; D25E 20 8A D2
        ldx     ERRNB                           ; D261 AE 12 05
        bne     LD258                           ; D264 D0 F2
LD266:  rts                                     ; D266 60

; ----------------------------------------------------------------------------
LD267:  jsr     CharGet                         ; D267 20 E2 00
; Evalue un mot, résulat dans AY. Si Z=1 on a évalué un octet
EvalWord:
        jsr     EvalExpr                        ; D26A 20 DF CE
        tax                                     ; D26D AA
        lda     VARAPL+14                       ; D26E A5 DE
        ldy     VARAPL+15                       ; D270 A4 DF
        rts                                     ; D272 60

; ----------------------------------------------------------------------------
LD273:  jsr     LD267                           ; D273 20 67 D2
        sta     INPIS                           ; D276 8D 2D 05
        sty     INSEC                           ; D279 8C 2E 05
        txa                                     ; D27C 8A
        rts                                     ; D27D 60

; ----------------------------------------------------------------------------
LD27E:  sta     VEXBNK+1                        ; D27E 8D 15 04
        sty     VEXBNK+2                        ; D281 8C 16 04
        stx     BNKCIB                          ; D284 8E 17 04
        jmp     EXBNK                           ; D287 4C 0C 04

; ----------------------------------------------------------------------------
; Exécute une routine en banque 0 (adresse en AY)
EXBNK0: php                                     ; D28A 08
        sta     VEXBNK+1                        ; D28B 8D 15 04
        sty     VEXBNK+2                        ; D28E 8C 16 04
        lda     #$00                            ; D291 A9 00
        sta     BNKCIB                          ; D293 8D 17 04
        sta     ERRNB                           ; D296 8D 12 05
        txa                                     ; D299 8A
        tsx                                     ; D29A BA
        dex                                     ; D29B CA
        dex                                     ; D29C CA
        dex                                     ; D29D CA
        dex                                     ; D29E CA
        stx     SAVES                           ; D29F 8E 13 05
        tax                                     ; D2A2 AA
        jsr     EXBNK                           ; D2A3 20 0C 04
        plp                                     ; D2A6 28
        rts                                     ; D2A7 60

; ----------------------------------------------------------------------------
LD2A8:  jsr     LCC92                           ; D2A8 20 92 CC
        bcs     LD2B0                           ; D2AB B0 03
        sec                                     ; D2AD 38
        bcs     LD2B3                           ; D2AE B0 03
LD2B0:  jsr     LC8B4                           ; D2B0 20 B4 C8
LD2B3:  php                                     ; D2B3 08
        jsr     LCB5A                           ; D2B4 20 5A CB
        plp                                     ; D2B7 28
        rts                                     ; D2B8 60

; ----------------------------------------------------------------------------
; (L)DESAS adrdeb (,adrfin) (B val) : désassemble le programme à partir de
; l'adresse adrdeb de la banque indiquée, ou celle par défaut, jusqu'à adrfin si
; précisée
DESAS:  ldy     #$00                            ; D2B9 A0 00
        .byte   $2C                             ; D2BB 2C
LDESAS: ldy     #$80                            ; D2BC A0 80
        sty     XLPRBI                          ; D2BE 84 48
        jsr     LD368                           ; D2C0 20 68 D3
LD2C3:  jsr     LD3CB                           ; D2C3 20 CB D3
        jsr     LCC53                           ; D2C6 20 53 CC
        jsr     LD2A8                           ; D2C9 20 A8 D2
        bcc     LD2C3                           ; D2CC 90 F5
        bcs     LD2E2                           ; D2CE B0 12
; (L)DUMP adrdeb (,adrfin) (,B val) : affiche un dump de la mémoire depuis
; l'adress adrdeb de la banque indiquée, ou celle par défaut, jusqu'à adrfin  si
; précisée
DUMP:   ldy     #$00                            ; D2D0 A0 00
        .byte   $2C                             ; D2D2 2C
LDUMP:  ldy     #$80                            ; D2D3 A0 80
        sty     XLPRBI                          ; D2D5 84 48
        jsr     LD368                           ; D2D7 20 68 D3
LD2DA:  jsr     LD2E8                           ; D2DA 20 E8 D2
        jsr     LD2A8                           ; D2DD 20 A8 D2
        bcc     LD2DA                           ; D2E0 90 F8
LD2E2:  jsr     LC8DC                           ; D2E2 20 DC C8
        jmp     LCFCB                           ; D2E5 4C CB CF

; ----------------------------------------------------------------------------
LD2E8:  lda     Proc1+1                         ; D2E8 AD E3 04
        ldy     Proc1+2                         ; D2EB AC E4 04
        sta     VARAPL+8                        ; D2EE 85 D8
        sty     VARAPL+9                        ; D2F0 84 D9
        jsr     DispWord                        ; D2F2 20 8D C7
        jsr     DispSpace                       ; D2F5 20 35 C7
        jsr     DispSpace                       ; D2F8 20 35 C7
        ldy     #$08                            ; D2FB A0 08
        sty     VARAPL+10                       ; D2FD 84 DA
        sty     VARAPL+11                       ; D2FF 84 DB
LD301:  jsr     LCC5B                           ; D301 20 5B CC
        jsr     DispByte                        ; D304 20 92 C7
        jsr     DispSpace                       ; D307 20 35 C7
        jsr     LCC53                           ; D30A 20 53 CC
        dec     VARAPL+10                       ; D30D C6 DA
        bne     LD301                           ; D30F D0 F0
        jsr     DispSpace                       ; D311 20 35 C7
        lda     VARAPL+8                        ; D314 A5 D8
        sta     Proc1+1                         ; D316 8D E3 04
        lda     VARAPL+9                        ; D319 A5 D9
        sta     Proc1+2                         ; D31B 8D E4 04
LD31E:  jsr     LCC5B                           ; D31E 20 5B CC
        jsr     LC716                           ; D321 20 16 C7
        jsr     LCC53                           ; D324 20 53 CC
        dec     VARAPL+11                       ; D327 C6 DB
        bne     LD31E                           ; D329 D0 F3
        rts                                     ; D32B 60

; ----------------------------------------------------------------------------
; BANK (val) : sélectionne la banque par défaut (0 à 7, 0 par défaut)
BANK:   tax                                     ; D32C AA
        bne     LD334                           ; D32D D0 05
        jsr     LD356                           ; D32F 20 56 D3
        beq     LD339                           ; D332 F0 05
LD334:  jsr     LD349                           ; D334 20 49 D3
        bne     SyntaxErr2                      ; D337 D0 27
LD339:  stx     DEFBNK                          ; D339 8E E0 04
        jmp     LCFCB                           ; D33C 4C CB CF

; ----------------------------------------------------------------------------
LD33F:  jsr     EvalComma                       ; D33F 20 AC D1
LD342:  cmp     #"B"                            ; D342 C9 42
        bne     SyntaxErr2                      ; D344 D0 1A
LD346:  jsr     CharGet                         ; D346 20 E2 00
LD349:  jsr     EvalExpr                        ; D349 20 DF CE
        ldx     VARAPL+14                       ; D34C A6 DE
        ldy     VARAPL+15                       ; D34E A4 DF
        bne     IllegalValErr                   ; D350 D0 11
        cpx     #$08                            ; D352 E0 08
        bcs     IllegalValErr                   ; D354 B0 0D
LD356:  pha                                     ; D356 48
        txa                                     ; D357 8A
        pha                                     ; D358 48
        jsr     DispBank                        ; D359 20 F5 C8
        pla                                     ; D35C 68
        tax                                     ; D35D AA
        pla                                     ; D35E 68
        rts                                     ; D35F 60

; ----------------------------------------------------------------------------
; Err $00
SyntaxErr2:
        ldx     #$00                            ; D360 A2 00
        .byte   $2C                             ; D362 2C
; Err $0B
IllegalValErr:
        ldx     #$0B                            ; D363 A2 0B
        jmp     LCF98                           ; D365 4C 98 CF

; ----------------------------------------------------------------------------
LD368:  jsr     EvalWord                        ; D368 20 6A D2
        sta     Proc1+1                         ; D36B 8D E3 04
        sty     Proc1+2                         ; D36E 8C E4 04
        lda     DEFBNK                          ; D371 AD E0 04
        sta     BNKSAV                          ; D374 8D E1 04
        lda     #$FF                            ; D377 A9 FF
        sta     Ptr2                            ; D379 8D F0 04
        sta     Ptr2+1                          ; D37C 8D F1 04
        txa                                     ; D37F 8A
        beq     LD3A4                           ; D380 F0 22
        jsr     EvalComma                       ; D382 20 AC D1
        cmp     #"B"                            ; D385 C9 42
        bne     LD38F                           ; D387 D0 06
        jsr     LD346                           ; D389 20 46 D3
        jmp     LD39E                           ; D38C 4C 9E D3

; ----------------------------------------------------------------------------
LD38F:  jsr     EvalWord                        ; D38F 20 6A D2
        sta     Ptr2                            ; D392 8D F0 04
        sty     Ptr2+1                          ; D395 8C F1 04
        txa                                     ; D398 8A
        beq     LD3A4                           ; D399 F0 09
        jsr     LD33F                           ; D39B 20 3F D3
LD39E:  stx     BNKSAV                          ; D39E 8E E1 04
        tax                                     ; D3A1 AA
        bne     SyntaxErr2                      ; D3A2 D0 BC
LD3A4:  bit     XLPRBI                          ; D3A4 24 48
        bpl     LD3AB                           ; D3A6 10 03
        jsr     LCF8D                           ; D3A8 20 8D CF
LD3AB:  jmp     LCB5A                           ; D3AB 4C 5A CB

; ----------------------------------------------------------------------------
LD3AE:  clc                                     ; D3AE 18
        ldx     Proc1+1                         ; D3AF AE E3 04
        ldy     Proc1+2                         ; D3B2 AC E4 04
        inx                                     ; D3B5 E8
        bne     LD3B9                           ; D3B6 D0 01
        iny                                     ; D3B8 C8
LD3B9:  clc                                     ; D3B9 18
        txa                                     ; D3BA 8A
        adc     HRS4                            ; D3BB 65 53
        tax                                     ; D3BD AA
        ror                                     ; D3BE 6A
        eor     HRS4                            ; D3BF 45 53
        bpl     LD3CA                           ; D3C1 10 07
        lda     HRS4                            ; D3C3 A5 53
        bpl     LD3C9                           ; D3C5 10 02
        dey                                     ; D3C7 88
        rts                                     ; D3C8 60

; ----------------------------------------------------------------------------
LD3C9:  iny                                     ; D3C9 C8
LD3CA:  rts                                     ; D3CA 60

; ----------------------------------------------------------------------------
LD3CB:  lda     Proc1+1                         ; D3CB AD E3 04
        ldy     Proc1+2                         ; D3CE AC E4 04
        jsr     DispWord                        ; D3D1 20 8D C7
        jsr     DispSpace                       ; D3D4 20 35 C7
        jsr     DispSpace                       ; D3D7 20 35 C7
        jsr     LCC5B                           ; D3DA 20 5B CC
        jsr     DecodeOpc                       ; D3DD 20 64 CA
        jsr     DispByte                        ; D3E0 20 92 C7
        lda     INDIC0+1                        ; D3E3 A5 56
        beq     LD405                           ; D3E5 F0 1E
        jsr     DispSpace                       ; D3E7 20 35 C7
        jsr     LCC53                           ; D3EA 20 53 CC
        sta     HRS4                            ; D3ED 85 53
        jsr     DispByte                        ; D3EF 20 92 C7
        ldx     INDIC0+1                        ; D3F2 A6 56
        dex                                     ; D3F4 CA
        beq     LD408                           ; D3F5 F0 11
        jsr     DispSpace                       ; D3F7 20 35 C7
        jsr     LCC53                           ; D3FA 20 53 CC
        sta     HRS4+1                          ; D3FD 85 54
        jsr     DispByte                        ; D3FF 20 92 C7
        ldy     #$02                            ; D402 A0 02
        .byte   $2C                             ; D404 2C
LD405:  ldy     #$08                            ; D405 A0 08
        .byte   $2C                             ; D407 2C
LD408:  ldy     #$05                            ; D408 A0 05
        jsr     DispYSpace                      ; D40A 20 2C C7
        lda     INDIC2                          ; D40D A5 57
        jsr     PutMnemo                        ; D40F 20 3A CA
        jsr     DispString                      ; D412 20 7C C7
        jsr     DispSpace                       ; D415 20 35 C7
        lda     INDIC0                          ; D418 A5 55
        beq     LD481                           ; D41A F0 65
        cmp     #$C1                            ; D41C C9 C1
        bne     LD42D                           ; D41E D0 0D
        lda     #"$"                            ; D420 A9 24
        BRK_TELEMON XWR0                             ; D422 00 10
        jsr     LD3AE                           ; D424 20 AE D3
        txa                                     ; D427 8A
        jsr     DispWord                        ; D428 20 8D C7
        beq     LD481                           ; D42B F0 54
LD42D:  bit     INDIC0                          ; D42D 24 55
        bpl     LD435                           ; D42F 10 04
        lda     #"#"                            ; D431 A9 23
        bne     LD439                           ; D433 D0 04
LD435:  bvc     LD43B                           ; D435 50 04
        lda     #"("                            ; D437 A9 28
LD439:  BRK_TELEMON XWR0                             ; D439 00 10
LD43B:  lda     #"$"                            ; D43B A9 24
        BRK_TELEMON XWR0                             ; D43D 00 10
        ldx     INDIC0+1                        ; D43F A6 56
        lda     HRS4                            ; D441 A5 53
        ldy     HRS4+1                          ; D443 A4 54
        dex                                     ; D445 CA
        beq     LD44D                           ; D446 F0 05
        jsr     DispWord                        ; D448 20 8D C7
        beq     LD450                           ; D44B F0 03
LD44D:  jsr     DispByte                        ; D44D 20 92 C7
LD450:  lda     INDIC0                          ; D450 A5 55
        and     #$3C                            ; D452 29 3C
        beq     LD481                           ; D454 F0 2B
        asl                                     ; D456 0A
        asl                                     ; D457 0A
        bpl     LD460                           ; D458 10 06
        pha                                     ; D45A 48
        lda     #")"                            ; D45B A9 29
        BRK_TELEMON XWR0                             ; D45D 00 10
        pla                                     ; D45F 68
LD460:  asl                                     ; D460 0A
        bpl     LD46D                           ; D461 10 0A
        pha                                     ; D463 48
        lda     #","                            ; D464 A9 2C
        BRK_TELEMON XWR0                             ; D466 00 10
        lda     #"X"                            ; D468 A9 58
        BRK_TELEMON XWR0                             ; D46A 00 10
        pla                                     ; D46C 68
LD46D:  asl                                     ; D46D 0A
        bpl     LD47A                           ; D46E 10 0A
        pha                                     ; D470 48
        lda     #","                            ; D471 A9 2C
        BRK_TELEMON XWR0                             ; D473 00 10
        lda     #"Y"                            ; D475 A9 59
        BRK_TELEMON XWR0                             ; D477 00 10
        pla                                     ; D479 68
LD47A:  asl                                     ; D47A 0A
        bpl     LD481                           ; D47B 10 04
        lda     #")"                            ; D47D A9 29
        BRK_TELEMON XWR0                             ; D47F 00 10
LD481:  rts                                     ; D481 60

; ----------------------------------------------------------------------------
LD482:  lda     SCEDEB                          ; D482 A5 5C
        sta     VARAPL+10                       ; D484 85 DA
        lda     SCEDEB+1                        ; D486 A5 5D
        sta     VARAPL+11                       ; D488 85 DB
LD48A:  ldy     #$00                            ; D48A A0 00
        lda     (VARAPL+10),y                   ; D48C B1 DA
        beq     UnknSymErr                      ; D48E F0 5F
        iny                                     ; D490 C8
        lda     (VARAPL+10),y                   ; D491 B1 DA
        sta     VARAPL+3                        ; D493 85 D3
        iny                                     ; D495 C8
        lda     (VARAPL+10),y                   ; D496 B1 DA
        sta     VARAPL+4                        ; D498 85 D4
        iny                                     ; D49A C8
        lda     (VARAPL+10),y                   ; D49B B1 DA
        beq     LD4C6                           ; D49D F0 27
        bmi     LD4C6                           ; D49F 30 25
        cmp     #$27                            ; D4A1 C9 27
        beq     LD4C6                           ; D4A3 F0 21
        lda     VARAPL+10                       ; D4A5 A5 DA
        pha                                     ; D4A7 48
        lda     VARAPL+11                       ; D4A8 A5 DB
        pha                                     ; D4AA 48
        tya                                     ; D4AB 98
        clc                                     ; D4AC 18
        adc     VARAPL+10                       ; D4AD 65 DA
        sta     VARAPL+10                       ; D4AF 85 DA
        bcc     LD4B5                           ; D4B1 90 02
        inc     VARAPL+11                       ; D4B3 E6 DB
LD4B5:  ldy     #$FF                            ; D4B5 A0 FF
LD4B7:  iny                                     ; D4B7 C8
        lda     (VARAPL+10),y                   ; D4B8 B1 DA
        bmi     LD4D6                           ; D4BA 30 1A
        cmp     (TXTPTR),y                      ; D4BC D1 E9
        beq     LD4B7                           ; D4BE F0 F7
LD4C0:  pla                                     ; D4C0 68
        sta     VARAPL+11                       ; D4C1 85 DB
        pla                                     ; D4C3 68
        sta     VARAPL+10                       ; D4C4 85 DA
LD4C6:  ldy     #$00                            ; D4C6 A0 00
        clc                                     ; D4C8 18
        lda     (VARAPL+10),y                   ; D4C9 B1 DA
        adc     VARAPL+10                       ; D4CB 65 DA
        sta     VARAPL+10                       ; D4CD 85 DA
        bcc     LD4D3                           ; D4CF 90 02
        inc     VARAPL+11                       ; D4D1 E6 DB
LD4D3:  jmp     LD48A                           ; D4D3 4C 8A D4

; ----------------------------------------------------------------------------
LD4D6:  cpy     #$06                            ; D4D6 C0 06
        beq     LD4EA                           ; D4D8 F0 10
        lda     (TXTPTR),y                      ; D4DA B1 E9
        beq     LD4EA                           ; D4DC F0 0C
        cmp     #"-"                            ; D4DE C9 2D
        beq     LD4EA                           ; D4E0 F0 08
        cmp     #","                            ; D4E2 C9 2C
        beq     LD4EA                           ; D4E4 F0 04
        cmp     #" "                            ; D4E6 C9 20
        bne     LD4C0                           ; D4E8 D0 D6
LD4EA:  pla                                     ; D4EA 68
        pla                                     ; D4EB 68
        jmp     IncTXTPTR                       ; D4EC 4C 85 CE

; ----------------------------------------------------------------------------
; Err $11
UnknSymErr:
        ldx     #$11                            ; D4EF A2 11
        jmp     LCF98                           ; D4F1 4C 98 CF

; ----------------------------------------------------------------------------
LD4F4:  lda     #$00                            ; D4F4 A9 00
        sta     VARAPL+3                        ; D4F6 85 D3
        sta     VARAPL+4                        ; D4F8 85 D4
        jsr     LCC31                           ; D4FA 20 31 CC
        jsr     CharGot                         ; D4FD 20 E8 00
        tax                                     ; D500 AA
        beq     LD53F                           ; D501 F0 3C
        bcc     LD50F                           ; D503 90 0A
        cmp     #"-"                            ; D505 C9 2D
        beq     LD521                           ; D507 F0 18
        jsr     LD482                           ; D509 20 82 D4
        jmp     LD514                           ; D50C 4C 14 D5

; ----------------------------------------------------------------------------
LD50F:  jsr     LCCF0                           ; D50F 20 F0 CC
        bcc     LD534                           ; D512 90 20
LD514:  jsr     LCC31                           ; D514 20 31 CC
        jsr     CharGot                         ; D517 20 E8 00
        tax                                     ; D51A AA
        beq     LD53F                           ; D51B F0 22
        cmp     #"-"                            ; D51D C9 2D
        bne     LD531                           ; D51F D0 10
LD521:  jsr     CharGet                         ; D521 20 E2 00
        tax                                     ; D524 AA
        beq     LD53F                           ; D525 F0 18
        bcs     LD535                           ; D527 B0 0C
        jsr     LCCF0                           ; D529 20 F0 CC
        bcc     LD534                           ; D52C 90 06
        tax                                     ; D52E AA
        beq     LD546                           ; D52F F0 15
LD531:  ldx     #$00                            ; D531 A2 00
        clc                                     ; D533 18
LD534:  rts                                     ; D534 60

; ----------------------------------------------------------------------------
LD535:  jsr     LD482                           ; D535 20 82 D4
        jsr     CharGot                         ; D538 20 E8 00
        tax                                     ; D53B AA
        bne     LD531                           ; D53C D0 F3
        rts                                     ; D53E 60

; ----------------------------------------------------------------------------
LD53F:  ldx     #$FF                            ; D53F A2 FF
        stx     VARAPL+4                        ; D541 86 D4
        dex                                     ; D543 CA
        stx     VARAPL+3                        ; D544 86 D3
LD546:  sec                                     ; D546 38
        rts                                     ; D547 60

; ----------------------------------------------------------------------------
LD548:  jmp     LCF98                           ; D548 4C 98 CF

; ----------------------------------------------------------------------------
; (L)LIST (numdeb) (-) (numfin) : liste le source du fichier en mémoire. numdeb
; et numfin sont soit des n° de ligne en décimal, soit des étiquettes
LIST:   BRK_TELEMON XCRLF                             ; D54B 00 25
        lda     #$00                            ; D54D A9 00
        .byte   $2C                             ; D54F 2C
LLIST:  lda     #$80                            ; D550 A9 80
        sta     XLPRBI                          ; D552 85 48
        jsr     LD4F4                           ; D554 20 F4 D4
        bcc     LD548                           ; D557 90 EF
        jsr     LCB98                           ; D559 20 98 CB
        bcs     LD586                           ; D55C B0 28
        bit     XLPRBI                          ; D55E 24 48
        bpl     LD565                           ; D560 10 03
        jsr     LCF8D                           ; D562 20 8D CF
LD565:  ldy     #$01                            ; D565 A0 01
        lda     (VARAPL+12),y                   ; D567 B1 DC
        tax                                     ; D569 AA
        iny                                     ; D56A C8
        lda     (VARAPL+12),y                   ; D56B B1 DC
        cmp     VARAPL+4                        ; D56D C5 D4
        bne     LD575                           ; D56F D0 04
        cpx     VARAPL+3                        ; D571 E4 D3
        beq     LD577                           ; D573 F0 02
LD575:  bcs     LD586                           ; D575 B0 0F
LD577:  tay                                     ; D577 A8
        txa                                     ; D578 8A
        jsr     LCAF2                           ; D579 20 F2 CA
        jsr     LD2B0                           ; D57C 20 B0 D2
        bcs     LD586                           ; D57F B0 05
        jsr     LCB89                           ; D581 20 89 CB
        bcc     LD565                           ; D584 90 DF
LD586:  jmp     LCFCB                           ; D586 4C CB CF

; ----------------------------------------------------------------------------
; RENUM (num1) (,pas) (,numdeb) (,numfin) : renumérotation des lignes de numdeb
; à numfin avec 'num1' nouvelle 1ère ligne et 'pas' l'incrément. numdeb et
; numfin peuvent être des n° de lignes en décimal ou des étiquettes
RENUM:  pha                                     ; D589 48
        ldx     #$FF                            ; D58A A2 FF
        stx     DECTRV                          ; D58C 86 0A
        stx     DECTRV+1                        ; D58E 86 0B
        inx                                     ; D590 E8
        stx     DECCIB                          ; D591 86 08
        stx     DECCIB+1                        ; D593 86 09
        stx     DECDEB+1                        ; D595 86 05
        stx     DECFIN+1                        ; D597 86 07
        ldx     #$0A                            ; D599 A2 0A
        stx     DECDEB                          ; D59B 86 04
        stx     DECFIN                          ; D59D 86 06
        ldy     #$00                            ; D59F A0 00
        pla                                     ; D5A1 68
        beq     LD5E7                           ; D5A2 F0 43
LD5A4:  cmp     #","                            ; D5A4 C9 2C
        beq     LD5DF                           ; D5A6 F0 37
        sty     VARAPL+7                        ; D5A8 84 D7
        jsr     CharGot                         ; D5AA 20 E8 00
        bcc     LD5BC                           ; D5AD 90 0D
        cpy     #$02                            ; D5AF C0 02
        beq     SyntaxErr3                      ; D5B1 F0 27
        jsr     LD482                           ; D5B3 20 82 D4
        jsr     CharGot                         ; D5B6 20 E8 00
        jmp     LD5C1                           ; D5B9 4C C1 D5

; ----------------------------------------------------------------------------
LD5BC:  jsr     LCCF0                           ; D5BC 20 F0 CC
        bcc     LD5DC                           ; D5BF 90 1B
LD5C1:  pha                                     ; D5C1 48
        ldy     VARAPL+7                        ; D5C2 A4 D7
        cpy     #$07                            ; D5C4 C0 07
        bcs     SyntaxErr3                      ; D5C6 B0 12
        lda     VARAPL+3                        ; D5C8 A5 D3
        sta     DECDEB,y                        ; D5CA 99 04 00
        iny                                     ; D5CD C8
        lda     VARAPL+4                        ; D5CE A5 D4
        sta     DECDEB,y                        ; D5D0 99 04 00
        pla                                     ; D5D3 68
        beq     LD5E7                           ; D5D4 F0 11
        cmp     #","                            ; D5D6 C9 2C
        beq     LD5E0                           ; D5D8 F0 06
; Err $00
SyntaxErr3:
        ldx     #$00                            ; D5DA A2 00
LD5DC:  jmp     LCF98                           ; D5DC 4C 98 CF

; ----------------------------------------------------------------------------
LD5DF:  iny                                     ; D5DF C8
LD5E0:  iny                                     ; D5E0 C8
        jsr     CharGet                         ; D5E1 20 E2 00
        tax                                     ; D5E4 AA
        bne     LD5A4                           ; D5E5 D0 BD
LD5E7:  lda     DECFIN                          ; D5E7 A5 06
        ora     DECFIN+1                        ; D5E9 05 07
        bne     LD5F1                           ; D5EB D0 04
        lda     #$0A                            ; D5ED A9 0A
        sta     DECFIN                          ; D5EF 85 06
LD5F1:  lda     DECTRV                          ; D5F1 A5 0A
        ldy     DECTRV+1                        ; D5F3 A4 0B
        jsr     LCC04                           ; D5F5 20 04 CC
        lda     VARAPL+12                       ; D5F8 A5 DC
        sta     DECTRV                          ; D5FA 85 0A
        lda     VARAPL+13                       ; D5FC A5 DD
        sta     DECTRV+1                        ; D5FE 85 0B
        lda     DECCIB                          ; D600 A5 08
        ldy     DECCIB+1                        ; D602 A4 09
        jsr     LCC04                           ; D604 20 04 CC
        jsr     LCB98                           ; D607 20 98 CB
        bcs     LD63A                           ; D60A B0 2E
        ldy     #$00                            ; D60C A0 00
LD60E:  lda     DECTRV+1                        ; D60E A5 0B
        cmp     VARAPL+13                       ; D610 C5 DD
        bne     LD618                           ; D612 D0 04
        lda     DECTRV                          ; D614 A5 0A
        cmp     VARAPL+12                       ; D616 C5 DC
LD618:  bcc     LD63A                           ; D618 90 20
        iny                                     ; D61A C8
        lda     DECDEB                          ; D61B A5 04
        sta     (VARAPL+12),y                   ; D61D 91 DC
        pha                                     ; D61F 48
        iny                                     ; D620 C8
        lda     DECDEB+1                        ; D621 A5 05
        sta     (VARAPL+12),y                   ; D623 91 DC
        tay                                     ; D625 A8
        clc                                     ; D626 18
        pla                                     ; D627 68
        adc     DECFIN                          ; D628 65 06
        sta     DECDEB                          ; D62A 85 04
        tya                                     ; D62C 98
        adc     DECFIN+1                        ; D62D 65 07
        sta     DECDEB+1                        ; D62F 85 05
        ldx     #$0C                            ; D631 A2 0C
        bcs     LD5DC                           ; D633 B0 A7
        jsr     LCB89                           ; D635 20 89 CB
        bne     LD60E                           ; D638 D0 D4
LD63A:  jmp     LCFCB                           ; D63A 4C CB CF

; ----------------------------------------------------------------------------
; DELETE (numdeb) (-) (numfin) : supprime les lignes numdeb à numfin. numdeb et
;  numfin peuvent être des n° de ligne en décimal ou des étiquettes
DELETE: tax                                     ; D63D AA
        bne     LD643                           ; D63E D0 03
        jmp     NEW                             ; D640 4C 35 D1

; ----------------------------------------------------------------------------
LD643:  jsr     LD4F4                           ; D643 20 F4 D4
        bcc     LD5DC                           ; D646 90 94
        lda     VARAPL+12                       ; D648 A5 DC
        sta     DECCIB                          ; D64A 85 08
        lda     VARAPL+13                       ; D64C A5 DD
        sta     DECCIB+1                        ; D64E 85 09
        inc     VARAPL+3                        ; D650 E6 D3
        bne     LD656                           ; D652 D0 02
        inc     VARAPL+4                        ; D654 E6 D4
LD656:  jsr     LCC31                           ; D656 20 31 CC
        lda     VARAPL+12                       ; D659 A5 DC
        sta     DECDEB                          ; D65B 85 04
        lda     VARAPL+13                       ; D65D A5 DD
        sta     DECDEB+1                        ; D65F 85 05
        lda     SCEFIN                          ; D661 A5 5E
        sta     DECFIN                          ; D663 85 06
        lda     SCEFIN+1                        ; D665 A5 5F
        sta     DECFIN+1                        ; D667 85 07
        BRK_TELEMON XDECAL                             ; D669 00 18
        lda     SCEDEB                          ; D66B A5 5C
        sta     VARAPL+12                       ; D66D 85 DC
        lda     SCEDEB+1                        ; D66F A5 5D
        sta     VARAPL+13                       ; D671 85 DD
        ldy     #$00                            ; D673 A0 00
        lda     (VARAPL+12),y                   ; D675 B1 DC
        beq     LD67E                           ; D677 F0 05
LD679:  jsr     LCB89                           ; D679 20 89 CB
        bcc     LD679                           ; D67C 90 FB
LD67E:  clc                                     ; D67E 18
        lda     VARAPL+12                       ; D67F A5 DC
        adc     #$01                            ; D681 69 01
        sta     SCEFIN                          ; D683 85 5E
        lda     VARAPL+13                       ; D685 A5 DD
        adc     #$00                            ; D687 69 00
        sta     SCEFIN+1                        ; D689 85 5F
        jmp     LCFCB                           ; D68B 4C CB CF

; ----------------------------------------------------------------------------
; (L)DIR (''NFA'') : affiche le contenu de la disquette
DIR:    ldx     #$00                            ; D68E A2 00
        .byte   $2C                             ; D690 2C
LDIR:   ldx     #$80                            ; D691 A2 80
        stx     XLPRBI                          ; D693 86 48
        jsr     LD13E                           ; D695 20 3E D1
        jsr     CharGot                         ; D698 20 E8 00
        tax                                     ; D69B AA
        bne     LD6AC                           ; D69C D0 0E
        bit     XLPRBI                          ; D69E 24 48
        bpl     LD6A5                           ; D6A0 10 03
        jsr     LCF8D                           ; D6A2 20 8D CF
LD6A5:  lda     #<XDIRN                         ; D6A5 A9 56
        ldy     #>XDIRN                         ; D6A7 A0 FF
        jmp     LD252                           ; D6A9 4C 52 D2

; ----------------------------------------------------------------------------
LD6AC:  jmp     SyntaxErr1                      ; D6AC 4C A1 D1

; ----------------------------------------------------------------------------
; SAVE ''NF'' (,A EN, E EN, (,T EN)) : sauvegarde d'un fichier (cf Stratsed)
SAVE:   ldx     #$80                            ; D6AF A2 80
        .byte   $2C                             ; D6B1 2C
; SAVEU ''NF'' (,A EN, E EN, (,T EN)) : sauvegarde d'un fichier (cf Stratsed)
SAVEU:  ldx     #$C0                            ; D6B2 A2 C0
        .byte   $2C                             ; D6B4 2C
; SAVEO ''NF'' (,A EN, E EN, (,T EN)) : sauvegarde d'un fichier (cf Stratsed)
SAVEO:  ldx     #$00                            ; D6B5 A2 00
        .byte   $2C                             ; D6B7 2C
; SAVEM ''NF'' (,A EN, E EN, (,T EN)) : sauvegarde d'un fichier (cf Stratsed)
SAVEM:  ldx     #$40                            ; D6B8 A2 40
        stx     VSALO0                          ; D6BA 8E 28 05
        ldx     #$80                            ; D6BD A2 80
        stx     FTYPE                           ; D6BF 8E 2C 05
        ldx     SCEDEB                          ; D6C2 A6 5C
        stx     INPIS                           ; D6C4 8E 2D 05
        ldx     SCEDEB+1                        ; D6C7 A6 5D
        stx     INSEC                           ; D6C9 8E 2E 05
        ldx     SCEFIN                          ; D6CC A6 5E
        stx     PARPIS                          ; D6CE 8E 2F 05
        ldx     SCEFIN+1                        ; D6D1 A6 5F
        stx     PARSEC                          ; D6D3 8E 30 05
        ldx     #$00                            ; D6D6 A2 00
        stx     EXSALO                          ; D6D8 8E 31 05
        stx     EXSALO+1                        ; D6DB 8E 32 05
        tax                                     ; D6DE AA
        beq     LD737                           ; D6DF F0 56
        jsr     LD13E                           ; D6E1 20 3E D1
        bcs     WildCardErr1                    ; D6E4 B0 4C
        beq     LD6AC                           ; D6E6 F0 C4
        dex                                     ; D6E8 CA
        bne     LD735                           ; D6E9 D0 4A
        jsr     CharGot                         ; D6EB 20 E8 00
        tax                                     ; D6EE AA
        beq     LD72B                           ; D6EF F0 3A
        jsr     EvalComma                       ; D6F1 20 AC D1
        cmp     #"A"                            ; D6F4 C9 41
        bne     LD6AC                           ; D6F6 D0 B4
        lda     #$40                            ; D6F8 A9 40
        sta     FTYPE                           ; D6FA 8D 2C 05
        jsr     LD273                           ; D6FD 20 73 D2
        jsr     EvalComma                       ; D700 20 AC D1
        cmp     #"E"                            ; D703 C9 45
        bne     LD6AC                           ; D705 D0 A5
        jsr     LD267                           ; D707 20 67 D2
        sta     PARPIS                          ; D70A 8D 2F 05
        sty     PARSEC                          ; D70D 8C 30 05
        txa                                     ; D710 8A
        beq     LD72B                           ; D711 F0 18
        jsr     EvalComma                       ; D713 20 AC D1
        cmp     #"T"                            ; D716 C9 54
        bne     LD6AC                           ; D718 D0 92
        lda     #$41                            ; D71A A9 41
        sta     FTYPE                           ; D71C 8D 2C 05
        jsr     LD267                           ; D71F 20 67 D2
        sta     EXSALO                          ; D722 8D 31 05
        sty     EXSALO+1                        ; D725 8C 32 05
        txa                                     ; D728 8A
        bne     LD6AC                           ; D729 D0 81
LD72B:  lda     #<XSAVE                         ; D72B A9 6B
        ldy     #>XSAVE                         ; D72D A0 FF
        jmp     LD252                           ; D72F 4C 52 D2

; ----------------------------------------------------------------------------
; Err $18
WildCardErr1:
        ldx     #$18                            ; D732 A2 18
        .byte   $2C                             ; D734 2C
LD735:  ldx     #$09                            ; D735 A2 09
LD737:  jmp     LCF98                           ; D737 4C 98 CF

; ----------------------------------------------------------------------------
; DEL ''NFA'' : détruit un fichier (cf Stratsed)
DEL:    tax                                     ; D73A AA
        beq     SyntaxErr4                      ; D73B F0 5C
        jsr     LD13E                           ; D73D 20 3E D1
        pha                                     ; D740 48
        jsr     CharGot                         ; D741 20 E8 00
        tax                                     ; D744 AA
        bne     SyntaxErr4                      ; D745 D0 52
        pla                                     ; D747 68
        tax                                     ; D748 AA
        beq     SyntaxErr4                      ; D749 F0 4E
        dex                                     ; D74B CA
        bne     LD735                           ; D74C D0 E7
        lda     #<XDELN                         ; D74E A9 4D
        ldy     #>XDELN                         ; D750 A0 FF
        jsr     EXBNK0ERR                       ; D752 20 5E D2
        jmp     LCFC8                           ; D755 4C C8 CF

; ----------------------------------------------------------------------------
; DELBAK : détruit tous les fichiers avec une extension '.BAK'
DELBAK: tax                                     ; D758 AA
        bne     SyntaxErr4                      ; D759 D0 3E
        lda     #<XDELBK                        ; D75B A9 4A
        ldy     #>XDELBK                        ; D75D A0 FF
        jsr     EXBNK0ERR                       ; D75F 20 5E D2
        jmp     LCFC8                           ; D762 4C C8 CF

; ----------------------------------------------------------------------------
; EXT (''ext'') : affiche ou modifie l'extension par défaut (3 caractères maxi)
;
EXT:    tax                                     ; D765 AA
        bne     GetEXTparam                     ; D766 D0 13
        lda     #$7F                            ; D768 A9 7F
        BRK_TELEMON XWR0                             ; D76A 00 10
        ldy     #$00                            ; D76C A0 00
LD76E:  lda     EXTDEF,y                        ; D76E B9 5D 05
        BRK_TELEMON XWR0                             ; D771 00 10
        iny                                     ; D773 C8
        cpy     #$03                            ; D774 C0 03
        bne     LD76E                           ; D776 D0 F6
        jmp     LCFC8                           ; D778 4C C8 CF

; ----------------------------------------------------------------------------
GetEXTparam:
        cmp     #'"'                            ; D77B C9 22
        bne     LD784                           ; D77D D0 05
        ldy     #$01                            ; D77F A0 01
        jsr     IncTXTPTR                       ; D781 20 85 CE
LD784:  ldy     #$FF                            ; D784 A0 FF
LD786:  iny                                     ; D786 C8
        lda     (TXTPTR),y                      ; D787 B1 E9
        beq     SetEXT                          ; D789 F0 16
        cmp     #'"'                            ; D78B C9 22
        beq     SetEXT                          ; D78D F0 12
        jsr     min_MAJ                         ; D78F 20 BF C9
        sta     BUFTRV,y                        ; D792 99 00 01
        cpy     #$03                            ; D795 C0 03
        bne     LD786                           ; D797 D0 ED
; Err $00
SyntaxErr4:
        ldx     #$00                            ; D799 A2 00
        .byte   $2C                             ; D79B 2C
; Err $09
FileNameErr1:
        ldx     #$09                            ; D79C A2 09
        jmp     LCF98                           ; D79E 4C 98 CF

; ----------------------------------------------------------------------------
SetEXT: cpy     #$03                            ; D7A1 C0 03
        bne     FileNameErr1                    ; D7A3 D0 F7
        cmp     #'"'                            ; D7A5 C9 22
        bne     LD7AA                           ; D7A7 D0 01
        iny                                     ; D7A9 C8
LD7AA:  jsr     IncTXTPTR                       ; D7AA 20 85 CE
        jsr     CharGot                         ; D7AD 20 E8 00
        tax                                     ; D7B0 AA
        bne     SyntaxErr4                      ; D7B1 D0 E6
        ldy     #$02                            ; D7B3 A0 02
LD7B5:  lda     BUFTRV,y                        ; D7B5 B9 00 01
        sta     EXTDEF,y                        ; D7B8 99 5D 05
        dey                                     ; D7BB 88
        bpl     LD7B5                           ; D7BC 10 F7
        jmp     LCFCB                           ; D7BE 4C CB CF

; ----------------------------------------------------------------------------
; BACKUP : copie l'intégralité de la disquette (cf Stratsed)
BACKUP: tax                                     ; D7C1 AA
        bne     SyntaxErr4                      ; D7C2 D0 D5
        sta     BUFNOM                          ; D7C4 8D 17 05
        lda     TABDRV+1                        ; D7C7 AD 09 02
        beq     LD7CE                           ; D7CA F0 02
        lda     #$01                            ; D7CC A9 01
LD7CE:  sta     BUFNOM+1                        ; D7CE 8D 18 05
        lda     #<XBKP                          ; D7D1 A9 59
        ldy     #$FF                            ; D7D3 A0 FF
        jsr     EXBNK0ERR                       ; D7D5 20 5E D2
        jmp     LCFC8                           ; D7D8 4C C8 CF

; ----------------------------------------------------------------------------
; INIT : initialise et formatte une disquette (cf Stratsed)
INIT:   tax                                     ; D7DB AA
        bne     SyntaxErr4                      ; D7DC D0 BB
        sta     PARPIS                          ; D7DE 8D 2F 05
        sta     PARSEC                          ; D7E1 8D 30 05
        lda     #<XINITI                        ; D7E4 A9 5C
        ldy     #>XINITI                        ; D7E6 A0 FF
        jsr     EXBNK0ERR                       ; D7E8 20 5E D2
        jmp     LCFC8                           ; D7EB 4C C8 CF

; ----------------------------------------------------------------------------
LD7EE:  ldy     #$00                            ; D7EE A0 00
LD7F0:  lda     (TXTPTR),y                      ; D7F0 B1 E9
        beq     LD805                           ; D7F2 F0 11
        iny                                     ; D7F4 C8
        bne     LD7F0                           ; D7F5 D0 F9
        jmp     LD805                           ; D7F7 4C 05 D8

; ----------------------------------------------------------------------------
LD7FA:  ldy     #$01                            ; D7FA A0 01
        lda     (TXTPTR),y                      ; D7FC B1 E9
        sta     VARAPL+16                       ; D7FE 85 E0
        iny                                     ; D800 C8
        lda     (TXTPTR),y                      ; D801 B1 E9
        sta     VARAPL+17                       ; D803 85 E1
LD805:  iny                                     ; D805 C8
LD806:  jsr     IncTXTPTR                       ; D806 20 85 CE
        ldy     #$00                            ; D809 A0 00
        lda     (TXTPTR),y                      ; D80B B1 E9
        rts                                     ; D80D 60

; ----------------------------------------------------------------------------
LD80E:  lda     Ptr1+1                          ; D80E AD EF 04
        bne     OrgDefErr                       ; D811 D0 3C
        jsr     CharGet                         ; D813 20 E2 00
        jsr     LCD87                           ; D816 20 87 CD
        bcc     LD85D                           ; D819 90 42
        lda     VARAPL+3                        ; D81B A5 D3
        sta     Ptr1                            ; D81D 8D EE 04
        lda     VARAPL+4                        ; D820 A5 D4
        sta     Ptr1+1                          ; D822 8D EF 04
        beq     IllegalValErr2                  ; D825 F0 19
LD827:  ldy     #$00                            ; D827 A0 00
        lda     (TXTPTR),y                      ; D829 B1 E9
        beq     LD831                           ; D82B F0 04
        cmp     #"'"                            ; D82D C9 27
        bne     SyntaxErr5                      ; D82F D0 0C
LD831:  rts                                     ; D831 60

; ----------------------------------------------------------------------------
LD832:  ldy     #$00                            ; D832 A0 00
LD834:  lda     (TXTPTR),y                      ; D834 B1 E9
        beq     SyntaxErr5                      ; D836 F0 05
        bmi     LD806                           ; D838 30 CC
        iny                                     ; D83A C8
        bne     LD834                           ; D83B D0 F7
; Err $00
SyntaxErr5:
        ldx     #$00                            ; D83D A2 00
        .byte   $2C                             ; D83F 2C
; Err $0B
IllegalValErr2:
        ldx     #$0B                            ; D840 A2 0B
        .byte   $2C                             ; D842 2C
; Err $0C
OutOfRangeValErr1:
        ldx     #$0C                            ; D843 A2 0C
        .byte   $2C                             ; D845 2C
; Err $0D
MemFullErr:
        ldx     #$0D                            ; D846 A2 0D
        .byte   $2C                             ; D848 2C
; Err $0F (inutilisé?)
IllegalLabErr:
        ldx     #$0F                            ; D849 A2 0F
        .byte   $2C                             ; D84B 2C
; Err $10
LabelDefErr:
        ldx     #$10                            ; D84C A2 10
        .byte   $2C                             ; D84E 2C
; Err $15
OrgDefErr:
        ldx     #$15                            ; D84F A2 15
        .byte   $2C                             ; D851 2C
; Err $11 (inutilisé?)
UnknSymErr1:
        ldx     #$11                            ; D852 A2 11
        .byte   $2C                             ; D854 2C
; Err $12
OutOfRangeBraErr2:
        ldx     #$12                            ; D855 A2 12
        .byte   $2C                             ; D857 2C
; Err $13
IllegalAddrModErr:
        ldx     #$13                            ; D858 A2 13
        .byte   $2C                             ; D85A 2C
; Err $14
UnknOrgErr:
        ldx     #$14                            ; D85B A2 14
LD85D:  jmp     LCF98                           ; D85D 4C 98 CF

; ----------------------------------------------------------------------------
LD860:  jsr     LocSymLookup                    ; D860 20 E5 CD
        bcs     LabelDefErr                     ; D863 B0 E7
        bit     HRSY                            ; D865 24 47
        bpl     LD891                           ; D867 10 28
        cmp     #"."                            ; D869 C9 2E
        beq     LD891                           ; D86B F0 24
LD86D:  jsr     GlobSymLookup                   ; D86D 20 4B CE
        bcs     LD8C6                           ; D870 B0 54
        lda     VARAPL2+11                      ; D872 A5 F6
        adc     #$08                            ; D874 69 08
        tax                                     ; D876 AA
        lda     VARAPL2+12                      ; D877 A5 F7
        adc     #$00                            ; D879 69 00
        cmp     VARAPL2+14                      ; D87B C5 F9
        bne     LD881                           ; D87D D0 02
        cpx     VARAPL2+13                      ; D87F E4 F8
LD881:  bcs     MemFullErr                      ; D881 B0 C3
        stx     VARAPL2+11                      ; D883 86 F6
        sta     VARAPL2+12                      ; D885 85 F7
        stx     VARAPL+1                        ; D887 86 D1
        sta     VARAPL+2                        ; D889 85 D2
        lda     #$00                            ; D88B A9 00
        sta     (VARAPL+1),y                    ; D88D 91 D1
        beq     LD8AF                           ; D88F F0 1E
LD891:  clc                                     ; D891 18
        lda     VARAPL2+17                      ; D892 A5 FC
        adc     #$08                            ; D894 69 08
        tax                                     ; D896 AA
        lda     VARAPL2+18                      ; D897 A5 FD
        adc     #$00                            ; D899 69 00
        cmp     VARAPL2+10                      ; D89B C5 F5
        bne     LD8A1                           ; D89D D0 02
        cpx     VARAPL2+9                       ; D89F E4 F4
LD8A1:  bcs     MemFullErr                      ; D8A1 B0 A3
        stx     VARAPL2+17                      ; D8A3 86 FC
        sta     VARAPL2+18                      ; D8A5 85 FD
        stx     VARAPL+1                        ; D8A7 86 D1
        sta     VARAPL+2                        ; D8A9 85 D2
        lda     #$00                            ; D8AB A9 00
        sta     (VARAPL+1),y                    ; D8AD 91 D1
LD8AF:  lda     (TXTPTR),y                      ; D8AF B1 E9
        sta     (VARAPL+12),y                   ; D8B1 91 DC
        bmi     LD8B8                           ; D8B3 30 03
        iny                                     ; D8B5 C8
        bne     LD8AF                           ; D8B6 D0 F7
LD8B8:  jsr     IncTXTPTR                       ; D8B8 20 85 CE
LD8BB:  cpy     #$06                            ; D8BB C0 06
        bcs     LD8C6                           ; D8BD B0 07
        lda     #$20                            ; D8BF A9 20
        sta     (VARAPL+12),y                   ; D8C1 91 DC
        iny                                     ; D8C3 C8
        bne     LD8BB                           ; D8C4 D0 F5
LD8C6:  ldy     #$06                            ; D8C6 A0 06
        lda     #$55                            ; D8C8 A9 55
        sta     (VARAPL+12),y                   ; D8CA 91 DC
        iny                                     ; D8CC C8
        sta     (VARAPL+12),y                   ; D8CD 91 DC
        ldy     #$00                            ; D8CF A0 00
        lda     (TXTPTR),y                      ; D8D1 B1 E9
        rts                                     ; D8D3 60

; ----------------------------------------------------------------------------
LD8D4:  ldy     #$06                            ; D8D4 A0 06
        cmp     #$BC                            ; D8D6 C9 BC
        beq     LD8EC                           ; D8D8 F0 12
        cmp     #$B9                            ; D8DA C9 B9
        beq     LD8EC                           ; D8DC F0 0E
        pha                                     ; D8DE 48
        lda     Proc1+1                         ; D8DF AD E3 04
        sta     (VARAPL+12),y                   ; D8E2 91 DC
        iny                                     ; D8E4 C8
        lda     Proc1+2                         ; D8E5 AD E4 04
        sta     (VARAPL+12),y                   ; D8E8 91 DC
        pla                                     ; D8EA 68
        rts                                     ; D8EB 60

; ----------------------------------------------------------------------------
LD8EC:  lda     VARAPL+12                       ; D8EC A5 DC
        pha                                     ; D8EE 48
        lda     VARAPL+13                       ; D8EF A5 DD
        pha                                     ; D8F1 48
        jsr     CharGet                         ; D8F2 20 E2 00
        jsr     EvalExpr                        ; D8F5 20 DF CE
        pla                                     ; D8F8 68
        sta     VARAPL+13                       ; D8F9 85 DD
        pla                                     ; D8FB 68
        sta     VARAPL+12                       ; D8FC 85 DC
        ldy     #$06                            ; D8FE A0 06
        lda     VARAPL+14                       ; D900 A5 DE
        sta     (VARAPL+12),y                   ; D902 91 DC
        iny                                     ; D904 C8
        lda     VARAPL+15                       ; D905 A5 DF
        sta     (VARAPL+12),y                   ; D907 91 DC
        jmp     LD827                           ; D909 4C 27 D8

; ----------------------------------------------------------------------------
LD90C:  jmp     SyntaxErr5                      ; D90C 4C 3D D8

; ----------------------------------------------------------------------------
LD90F:  jmp     IllegalValErr2                  ; D90F 4C 40 D8

; ----------------------------------------------------------------------------
LD912:  jsr     CharGet                         ; D912 20 E2 00
        ldx     #$FF                            ; D915 A2 FF
        tay                                     ; D917 A8
        beq     LD91E                           ; D918 F0 04
        cmp     #"'"                            ; D91A C9 27
        bne     LD922                           ; D91C D0 04
LD91E:  lda     #$00                            ; D91E A9 00
        beq     LD996                           ; D920 F0 74
LD922:  cmp     #"#"                            ; D922 C9 23
        bne     LD936                           ; D924 D0 10
        jsr     CharGet                         ; D926 20 E2 00
        jsr     EvalExpr                        ; D929 20 DF CE
        ldx     VARAPL+15                       ; D92C A6 DF
        bne     LD90F                           ; D92E D0 DF
        ldx     #$81                            ; D930 A2 81
        stx     INDIC0                          ; D932 86 55
        bne     LD97F                           ; D934 D0 49
LD936:  ldx     #$01                            ; D936 A2 01
        stx     INDIC0                          ; D938 86 55
        cmp     #"("                            ; D93A C9 28
        bne     LD946                           ; D93C D0 08
        lda     #$40                            ; D93E A9 40
        jsr     LD9A0                           ; D940 20 A0 D9
        jsr     CharGet                         ; D943 20 E2 00
LD946:  jsr     EvalExpr                        ; D946 20 DF CE
        cmp     #")"                            ; D949 C9 29
        bne     LD955                           ; D94B D0 08
        lda     #$20                            ; D94D A9 20
        jsr     LD9A0                           ; D94F 20 A0 D9
        jsr     CharGet                         ; D952 20 E2 00
LD955:  cmp     #","                            ; D955 C9 2C
        bne     LD97F                           ; D957 D0 26
        jsr     CharGet                         ; D959 20 E2 00
        cmp     #"X"                            ; D95C C9 58
        bne     LD967                           ; D95E D0 07
        lda     #$10                            ; D960 A9 10
        jsr     LD9A0                           ; D962 20 A0 D9
        bne     LD970                           ; D965 D0 09
LD967:  cmp     #"Y"                            ; D967 C9 59
        bne     LD90C                           ; D969 D0 A1
        lda     #$08                            ; D96B A9 08
        jsr     LD9A0                           ; D96D 20 A0 D9
LD970:  jsr     CharGet                         ; D970 20 E2 00
        cmp     #")"                            ; D973 C9 29
        bne     LD97F                           ; D975 D0 08
        lda     #$04                            ; D977 A9 04
        jsr     LD9A0                           ; D979 20 A0 D9
        jsr     CharGet                         ; D97C 20 E2 00
LD97F:  jsr     LD827                           ; D97F 20 27 D8
        ldx     #$00                            ; D982 A2 00
        lda     INDIC0                          ; D984 A5 55
        jsr     LCA79                           ; D986 20 79 CA
        bcc     LD98F                           ; D989 90 04
        ldy     VARAPL+15                       ; D98B A4 DF
        beq     LD99B                           ; D98D F0 0C
LD98F:  inx                                     ; D98F E8
        lda     INDIC0                          ; D990 A5 55
        and     #$FE                            ; D992 29 FE
        ora     #$02                            ; D994 09 02
LD996:  jsr     LCA79                           ; D996 20 79 CA
        bcc     LD99D                           ; D999 90 02
LD99B:  inx                                     ; D99B E8
        rts                                     ; D99C 60

; ----------------------------------------------------------------------------
LD99D:  jmp     IllegalAddrModErr               ; D99D 4C 58 D8

; ----------------------------------------------------------------------------
LD9A0:  ora     INDIC0                          ; D9A0 05 55
        sta     INDIC0                          ; D9A2 85 55
        rts                                     ; D9A4 60

; ----------------------------------------------------------------------------
LD9A5:  jsr     CharGet                         ; D9A5 20 E2 00
        cmp     #"+"                            ; D9A8 C9 2B
        bne     LD9B1                           ; D9AA D0 05
        jsr     EvalSomme                       ; D9AC 20 06 CF
        bcc     LD9BD                           ; D9AF 90 0C
LD9B1:  cmp     #"-"                            ; D9B1 C9 2D
        bne     LD9BA                           ; D9B3 D0 05
        jsr     EvalDifference                  ; D9B5 20 1E CF
        bcs     LD9BD                           ; D9B8 B0 03
LD9BA:  jsr     EvalExpr                        ; D9BA 20 DF CE
LD9BD:  jmp     LD827                           ; D9BD 4C 27 D8

; ----------------------------------------------------------------------------
LD9C0:  clc                                     ; D9C0 18
        lda     Proc1+1                         ; D9C1 AD E3 04
        adc     #$02                            ; D9C4 69 02
        sta     VARAPL+14                       ; D9C6 85 DE
        sta     VARAPL+8                        ; D9C8 85 D8
        lda     Proc1+2                         ; D9CA AD E4 04
        adc     #$00                            ; D9CD 69 00
        sta     VARAPL+15                       ; D9CF 85 DF
        sta     VARAPL+9                        ; D9D1 85 D9
        jsr     LD9A5                           ; D9D3 20 A5 D9
        sec                                     ; D9D6 38
        lda     VARAPL+14                       ; D9D7 A5 DE
        sbc     VARAPL+8                        ; D9D9 E5 D8
        sta     VARAPL+14                       ; D9DB 85 DE
        lda     VARAPL+15                       ; D9DD A5 DF
        sbc     VARAPL+9                        ; D9DF E5 D9
        beq     LD9EE                           ; D9E1 F0 0B
        cmp     #$FF                            ; D9E3 C9 FF
        bne     LD9EB                           ; D9E5 D0 04
        lda     VARAPL+14                       ; D9E7 A5 DE
        bmi     LD9F2                           ; D9E9 30 07
LD9EB:  jmp     OutOfRangeBraErr2               ; D9EB 4C 55 D8

; ----------------------------------------------------------------------------
LD9EE:  lda     VARAPL+14                       ; D9EE A5 DE
        bmi     LD9EB                           ; D9F0 30 F9
LD9F2:  lda     #$C1                            ; D9F2 A9 C1
        jsr     LCA79                           ; D9F4 20 79 CA
        ldx     #$01                            ; D9F7 A2 01
        rts                                     ; D9F9 60

; ----------------------------------------------------------------------------
LD9FA:  ldy     #$00                            ; D9FA A0 00
LD9FC:  jsr     CharGet                         ; D9FC 20 E2 00
        iny                                     ; D9FF C8
        jsr     EvalExpr                        ; DA00 20 DF CE
        pha                                     ; DA03 48
        lda     VARAPL+15                       ; DA04 A5 DF
        jsr     LCCDB                           ; DA06 20 DB CC
        jsr     LCCD2                           ; DA09 20 D2 CC
        lda     VARAPL+14                       ; DA0C A5 DE
        jsr     LCCDB                           ; DA0E 20 DB CC
        jsr     LCCD2                           ; DA11 20 D2 CC
        pla                                     ; DA14 68
        beq     LDA57                           ; DA15 F0 40
        cmp     #"'"                            ; DA17 C9 27
        bne     LD9FC                           ; DA19 D0 E1
        beq     LDA57                           ; DA1B F0 3A
LDA1D:  ldy     #$00                            ; DA1D A0 00
LDA1F:  jsr     CharGet                         ; DA1F 20 E2 00
        iny                                     ; DA22 C8
        jsr     EvalExpr                        ; DA23 20 DF CE
        pha                                     ; DA26 48
        lda     VARAPL+14                       ; DA27 A5 DE
        jsr     LCCDB                           ; DA29 20 DB CC
        jsr     LCCD2                           ; DA2C 20 D2 CC
        lda     VARAPL+15                       ; DA2F A5 DF
        jsr     LCCDB                           ; DA31 20 DB CC
        jsr     LCCD2                           ; DA34 20 D2 CC
        pla                                     ; DA37 68
        beq     LDA57                           ; DA38 F0 1D
        cmp     #"'"                            ; DA3A C9 27
        bne     LDA1F                           ; DA3C D0 E1
        beq     LDA57                           ; DA3E F0 17
LDA40:  ldy     #$00                            ; DA40 A0 00
LDA42:  jsr     CharGet                         ; DA42 20 E2 00
        iny                                     ; DA45 C8
        jsr     EvalExpr                        ; DA46 20 DF CE
        tax                                     ; DA49 AA
        beq     LDA57                           ; DA4A F0 0B
        cmp     #"'"                            ; DA4C C9 27
        beq     LDA57                           ; DA4E F0 07
        cmp     #","                            ; DA50 C9 2C
        beq     LDA42                           ; DA52 F0 EE
LDA54:  jmp     SyntaxErr5                      ; DA54 4C 3D D8

; ----------------------------------------------------------------------------
LDA57:  tya                                     ; DA57 98
        asl                                     ; DA58 0A
        sta     VARAPL+14                       ; DA59 85 DE
LDA5B:  lda     #$00                            ; DA5B A9 00
        sta     VARAPL+15                       ; DA5D 85 DF
        jmp     LCCA1                           ; DA5F 4C A1 CC

; ----------------------------------------------------------------------------
LDA62:  ldy     #$00                            ; DA62 A0 00
LDA64:  jsr     CharGet                         ; DA64 20 E2 00
        cmp     #'"'                            ; DA67 C9 22
        beq     LDA84                           ; DA69 F0 19
        iny                                     ; DA6B C8
        jsr     EvalExpr                        ; DA6C 20 DF CE
        pha                                     ; DA6F 48
        lda     VARAPL+15                       ; DA70 A5 DF
        beq     LDA77                           ; DA72 F0 03
        jmp     OutOfRangeValErr1               ; DA74 4C 43 D8

; ----------------------------------------------------------------------------
LDA77:  pla                                     ; DA77 68
        beq     LDAA0                           ; DA78 F0 26
LDA7A:  cmp     #"'"                            ; DA7A C9 27
        beq     LDAA0                           ; DA7C F0 22
        cmp     #","                            ; DA7E C9 2C
        beq     LDA64                           ; DA80 F0 E2
        bne     LDA54                           ; DA82 D0 D0
LDA84:  dey                                     ; DA84 88
        sty     VARAPL                          ; DA85 84 D0
        ldy     #$00                            ; DA87 A0 00
LDA89:  iny                                     ; DA89 C8
        inc     VARAPL                          ; DA8A E6 D0
        lda     (TXTPTR),y                      ; DA8C B1 E9
        beq     LDA95                           ; DA8E F0 05
        cmp     #'"'                            ; DA90 C9 22
        bne     LDA89                           ; DA92 D0 F5
        iny                                     ; DA94 C8
LDA95:  jsr     IncTXTPTR                       ; DA95 20 85 CE
        ldy     VARAPL                          ; DA98 A4 D0
        jsr     CharGot                         ; DA9A 20 E8 00
        tax                                     ; DA9D AA
        bne     LDA7A                           ; DA9E D0 DA
LDAA0:  sty     VARAPL+14                       ; DAA0 84 DE
        beq     LDA5B                           ; DAA2 F0 B7
LDAA4:  ldy     #$00                            ; DAA4 A0 00
LDAA6:  jsr     CharGet                         ; DAA6 20 E2 00
        cmp     #'"'                            ; DAA9 C9 22
        beq     LDAC3                           ; DAAB F0 16
        iny                                     ; DAAD C8
        jsr     EvalExpr                        ; DAAE 20 DF CE
        pha                                     ; DAB1 48
        lda     VARAPL+14                       ; DAB2 A5 DE
        jsr     LCCDB                           ; DAB4 20 DB CC
        jsr     LCCD2                           ; DAB7 20 D2 CC
        pla                                     ; DABA 68
        beq     LDAA0                           ; DABB F0 E3
LDABD:  cmp     #"'"                            ; DABD C9 27
        bne     LDAA6                           ; DABF D0 E5
        beq     LDAA0                           ; DAC1 F0 DD
LDAC3:  dey                                     ; DAC3 88
        sty     VARAPL                          ; DAC4 84 D0
        ldy     #$00                            ; DAC6 A0 00
LDAC8:  iny                                     ; DAC8 C8
        inc     VARAPL                          ; DAC9 E6 D0
        lda     (TXTPTR),y                      ; DACB B1 E9
        beq     LDADD                           ; DACD F0 0E
        cmp     #'"'                            ; DACF C9 22
        beq     LDADC                           ; DAD1 F0 09
        jsr     LCCDB                           ; DAD3 20 DB CC
        jsr     LCCD2                           ; DAD6 20 D2 CC
        jmp     LDAC8                           ; DAD9 4C C8 DA

; ----------------------------------------------------------------------------
LDADC:  iny                                     ; DADC C8
LDADD:  jsr     IncTXTPTR                       ; DADD 20 85 CE
        ldy     VARAPL                          ; DAE0 A4 D0
        jsr     CharGot                         ; DAE2 20 E8 00
        tax                                     ; DAE5 AA
        bne     LDABD                           ; DAE6 D0 D5
        beq     LDAA0                           ; DAE8 F0 B6
LDAEA:  jsr     CharGet                         ; DAEA 20 E2 00
        jsr     EvalExpr                        ; DAED 20 DF CE
        jsr     LD827                           ; DAF0 20 27 D8
        jmp     LCCA1                           ; DAF3 4C A1 CC

; ----------------------------------------------------------------------------
LDAF6:  lda     Proc1+1                         ; DAF6 AD E3 04
        ldy     Proc1+2                         ; DAF9 AC E4 04
        jsr     DispWord                        ; DAFC 20 8D C7
        jsr     LDAEA                           ; DAFF 20 EA DA
        ldy     #$08                            ; DB02 A0 08
        .byte   $2C                             ; DB04 2C
LDB05:  ldy     #$0C                            ; DB05 A0 0C
        jsr     DispYSpace                      ; DB07 20 2C C7
        rts                                     ; DB0A 60

; ----------------------------------------------------------------------------
LDB0B:  lda     Proc1+1                         ; DB0B AD E3 04
        ldy     Proc1+2                         ; DB0E AC E4 04
        jsr     DispWord                        ; DB11 20 8D C7
        jsr     DispSpace                       ; DB14 20 35 C7
        ldy     #$FF                            ; DB17 A0 FF
LDB19:  iny                                     ; DB19 C8
        lda     HRS3+1,y                        ; DB1A B9 52 00
        jsr     DispByte                        ; DB1D 20 92 C7
        jsr     LCC53                           ; DB20 20 53 CC
        dec     INDIC0+1                        ; DB23 C6 56
        bpl     LDB19                           ; DB25 10 F2
        jsr     DispSpace                       ; DB27 20 35 C7
LDB2A:  cpy     #$02                            ; DB2A C0 02
        beq     LDB37                           ; DB2C F0 09
        jsr     DispSpace                       ; DB2E 20 35 C7
        jsr     DispSpace                       ; DB31 20 35 C7
        iny                                     ; DB34 C8
        bne     LDB2A                           ; DB35 D0 F3
LDB37:  rts                                     ; DB37 60

; ----------------------------------------------------------------------------
LDB38:  pha                                     ; DB38 48
        tya                                     ; DB39 98
        pha                                     ; DB3A 48
        lda     Proc1+1                         ; DB3B AD E3 04
        ldy     Proc1+2                         ; DB3E AC E4 04
        jsr     DispWord                        ; DB41 20 8D C7
        jsr     DispSpace                       ; DB44 20 35 C7
        pla                                     ; DB47 68
        tay                                     ; DB48 A8
        pla                                     ; DB49 68
        jsr     DispWord                        ; DB4A 20 8D C7
        jsr     LCC53                           ; DB4D 20 53 CC
        jsr     LCC53                           ; DB50 20 53 CC
        ldy     #$03                            ; DB53 A0 03
LDB55:  bit     VARAPL+7                        ; DB55 24 D7
        bmi     LDB6E                           ; DB57 30 15
        jsr     DispYSpace                      ; DB59 20 2C C7
        sec                                     ; DB5C 38
        ror     VARAPL+7                        ; DB5D 66 D7
        lda     VARAPL+10                       ; DB5F A5 DA
        sta     VARAPL+12                       ; DB61 85 DC
        lda     VARAPL+11                       ; DB63 A5 DB
        sta     VARAPL+13                       ; DB65 85 DD
        lda     VARAPL+16                       ; DB67 A5 E0
        ldy     VARAPL+17                       ; DB69 A4 E1
        jsr     LCAF8                           ; DB6B 20 F8 CA
LDB6E:  jsr     LD2B0                           ; DB6E 20 B0 D2
        bcs     LDB74                           ; DB71 B0 01
        rts                                     ; DB73 60

; ----------------------------------------------------------------------------
LDB74:  jmp     LCFCB                           ; DB74 4C CB CF

; ----------------------------------------------------------------------------
LDB77:  pha                                     ; DB77 48
        lda     Proc1+1                         ; DB78 AD E3 04
        ldy     Proc1+2                         ; DB7B AC E4 04
        jsr     DispWord                        ; DB7E 20 8D C7
        jsr     DispSpace                       ; DB81 20 35 C7
        pla                                     ; DB84 68
        jsr     DispByte                        ; DB85 20 92 C7
        jsr     LCC53                           ; DB88 20 53 CC
        ldy     #$05                            ; DB8B A0 05
        bne     LDB55                           ; DB8D D0 C6
LDB8F:  lda     #$00                            ; DB8F A9 00
        sta     VARAPL+7                        ; DB91 85 D7
LDB93:  jsr     CharGet                         ; DB93 20 E2 00
        jsr     EvalExpr                        ; DB96 20 DF CE
        pha                                     ; DB99 48
        ldy     VARAPL+14                       ; DB9A A4 DE
        lda     VARAPL+15                       ; DB9C A5 DF
        jsr     LDB38                           ; DB9E 20 38 DB
        pla                                     ; DBA1 68
        beq     LDBA8                           ; DBA2 F0 04
        cmp     #"'"                            ; DBA4 C9 27
        bne     LDB93                           ; DBA6 D0 EB
LDBA8:  rts                                     ; DBA8 60

; ----------------------------------------------------------------------------
LDBA9:  lda     #$00                            ; DBA9 A9 00
        sta     VARAPL+7                        ; DBAB 85 D7
        ldy     #$FF                            ; DBAD A0 FF
LDBAF:  iny                                     ; DBAF C8
        jsr     CharGet                         ; DBB0 20 E2 00
        jsr     EvalExpr                        ; DBB3 20 DF CE
        pha                                     ; DBB6 48
        lda     VARAPL+14                       ; DBB7 A5 DE
        ldy     VARAPL+15                       ; DBB9 A4 DF
        jsr     LDB38                           ; DBBB 20 38 DB
        pla                                     ; DBBE 68
        beq     LDBC5                           ; DBBF F0 04
        cmp     #"'"                            ; DBC1 C9 27
        bne     LDBAF                           ; DBC3 D0 EA
LDBC5:  rts                                     ; DBC5 60

; ----------------------------------------------------------------------------
LDBC6:  lda     #$00                            ; DBC6 A9 00
        sta     VARAPL+7                        ; DBC8 85 D7
LDBCA:  jsr     CharGet                         ; DBCA 20 E2 00
        cmp     #'"'                            ; DBCD C9 22
        beq     LDBE2                           ; DBCF F0 11
        jsr     EvalExpr                        ; DBD1 20 DF CE
        pha                                     ; DBD4 48
        lda     VARAPL+14                       ; DBD5 A5 DE
        jsr     LDB77                           ; DBD7 20 77 DB
        pla                                     ; DBDA 68
LDBDB:  beq     LDBE1                           ; DBDB F0 04
        cmp     #"'"                            ; DBDD C9 27
        bne     LDBCA                           ; DBDF D0 E9
LDBE1:  rts                                     ; DBE1 60

; ----------------------------------------------------------------------------
LDBE2:  ldy     #$00                            ; DBE2 A0 00
LDBE4:  iny                                     ; DBE4 C8
        lda     (TXTPTR),y                      ; DBE5 B1 E9
        beq     LDBF7                           ; DBE7 F0 0E
        cmp     #'"'                            ; DBE9 C9 22
        beq     LDBF6                           ; DBEB F0 09
        sty     VARAPL+6                        ; DBED 84 D6
        jsr     LDB77                           ; DBEF 20 77 DB
        ldy     VARAPL+6                        ; DBF2 A4 D6
        bne     LDBE4                           ; DBF4 D0 EE
LDBF6:  iny                                     ; DBF6 C8
LDBF7:  jsr     IncTXTPTR                       ; DBF7 20 85 CE
        jsr     CharGot                         ; DBFA 20 E8 00
        tax                                     ; DBFD AA
        bne     LDBDB                           ; DBFE D0 DB
        rts                                     ; DC00 60

; ----------------------------------------------------------------------------
LDC01:  jmp     IllegalValErr2                  ; DC01 4C 40 D8

; ----------------------------------------------------------------------------
LDC04:  jmp     SyntaxErr5                      ; DC04 4C 3D D8

; ----------------------------------------------------------------------------
; (L)ASSEM (adrdeb) (,G) (,L) (,S) : assemble le programme en mémoire. adrdeb
; indique l'adresse physique à laquelle le programme est assemblé en mémoire.
; L'adresse d'origine du programme assemblé doit être indiquée par une directive
; ORG dans le
ASSEM:  ldx     #$00                            ; DC07 A2 00
        .byte   $2C                             ; DC09 2C
LASSEM: ldx     #$80                            ; DC0A A2 80
        stx     XLPRBI                          ; DC0C 86 48
        ldx     #$00                            ; DC0E A2 00
        stx     Ptr3                            ; DC10 8E F2 04
        stx     Ptr3+1                          ; DC13 8E F3 04
        stx     Ptr1                            ; DC16 8E EE 04
        stx     Ptr1+1                          ; DC19 8E EF 04
        stx     HRSX40                          ; DC1C 86 49
        stx     HRSY                            ; DC1E 86 47
        stx     HRSX6                           ; DC20 86 4A
        ldx     DEFBNK                          ; DC22 AE E0 04
        stx     BNKSAV                          ; DC25 8E E1 04
        pha                                     ; DC28 48
        txa                                     ; DC29 8A
        jsr     DispBank                        ; DC2A 20 F5 C8
        pla                                     ; DC2D 68
        beq     LDC64                           ; DC2E F0 34
        cmp     #","                            ; DC30 C9 2C
        beq     LDC46                           ; DC32 F0 12
        jsr     EvalWord                        ; DC34 20 6A D2
        beq     LDC01                           ; DC37 F0 C8
        sta     Ptr3                            ; DC39 8D F2 04
        sty     Ptr3+1                          ; DC3C 8C F3 04
        txa                                     ; DC3F 8A
        jmp     LDC46                           ; DC40 4C 46 DC

; ----------------------------------------------------------------------------
LDC43:  jsr     CharGet                         ; DC43 20 E2 00
LDC46:  tax                                     ; DC46 AA
        beq     LDC64                           ; DC47 F0 1B
        jsr     EvalComma                       ; DC49 20 AC D1
        cmp     #"L"                            ; DC4C C9 4C
        bne     LDC54                           ; DC4E D0 04
        ror     HRSX40                          ; DC50 66 49
        bmi     LDC43                           ; DC52 30 EF
LDC54:  cmp     #"G"                            ; DC54 C9 47
        bne     LDC5C                           ; DC56 D0 04
        ror     HRSY                            ; DC58 66 47
        bmi     LDC43                           ; DC5A 30 E7
LDC5C:  cmp     #"S"                            ; DC5C C9 53
        bne     LDC04                           ; DC5E D0 A4
        ror     HRSX6                           ; DC60 66 4A
        bmi     LDC43                           ; DC62 30 DF
LDC64:  bit     HRSY                            ; DC64 24 47
        bmi     LDC70                           ; DC66 30 08
        lda     VARAPL2+9                       ; DC68 A5 F4
        sta     VARAPL2+11                      ; DC6A 85 F6
        lda     VARAPL2+10                      ; DC6C A5 F5
        sta     VARAPL2+12                      ; DC6E 85 F7
LDC70:  jsr     LCF40                           ; DC70 20 40 CF
        lda     VARAPL2+15                      ; DC73 A5 FA
        sta     VARAPL2+17                      ; DC75 85 FC
        lda     VARAPL2+16                      ; DC77 A5 FB
        sta     VARAPL2+18                      ; DC79 85 FD
        sta     VARAPL2+8                       ; DC7B 85 F3
LDC7D:  jsr     LD7EE                           ; DC7D 20 EE D7
        beq     LDC97                           ; DC80 F0 15
        jsr     LD7FA                           ; DC82 20 FA D7
        bmi     LDC8E                           ; DC85 30 07
        cmp     #"'"                            ; DC87 C9 27
        beq     LDC7D                           ; DC89 F0 F2
        jsr     LD860                           ; DC8B 20 60 D8
LDC8E:  cmp     #$BC                            ; DC8E C9 BC
        bne     LDC7D                           ; DC90 D0 EB
        jsr     LD80E                           ; DC92 20 0E D8
        beq     LDC7D                           ; DC95 F0 E6
LDC97:  lda     Ptr1+1                          ; DC97 AD EF 04
        bne     LDCA4                           ; DC9A D0 08
        ldx     #$14                            ; DC9C A2 14
        jsr     DispErrorX                      ; DC9E 20 1B C8
        jmp     LCFCB                           ; DCA1 4C CB CF

; ----------------------------------------------------------------------------
LDCA4:  lda     Ptr3+1                          ; DCA4 AD F3 04
        bne     LDCB5                           ; DCA7 D0 0C
        lda     Ptr1                            ; DCA9 AD EE 04
        sta     Ptr3                            ; DCAC 8D F2 04
        lda     Ptr1+1                          ; DCAF AD EF 04
        sta     Ptr3+1                          ; DCB2 8D F3 04
LDCB5:  jsr     LCF40                           ; DCB5 20 40 CF
        jsr     LCC38                           ; DCB8 20 38 CC
LDCBB:  jsr     LD7EE                           ; DCBB 20 EE D7
        bne     LDCC3                           ; DCBE D0 03
        jmp     LDD44                           ; DCC0 4C 44 DD

; ----------------------------------------------------------------------------
LDCC3:  jsr     LD7FA                           ; DCC3 20 FA D7
        bmi     LDCD6                           ; DCC6 30 0E
        cmp     #$27                            ; DCC8 C9 27
        beq     LDCBB                           ; DCCA F0 EF
        jsr     SymLookup                       ; DCCC 20 77 CE
        jsr     LD8D4                           ; DCCF 20 D4 D8
        beq     LDCBB                           ; DCD2 F0 E7
        ldy     #$00                            ; DCD4 A0 00
LDCD6:  lda     (TXTPTR),y                      ; DCD6 B1 E9
        sta     INDIC2                          ; DCD8 85 57
        cmp     #$80                            ; DCDA C9 80
        beq     LDD30                           ; DCDC F0 52
        cmp     #$99                            ; DCDE C9 99
        bcs     LDCEA                           ; DCE0 B0 08
        jsr     CharGet                         ; DCE2 20 E2 00
        jsr     LD827                           ; DCE5 20 27 D8
        beq     LDD3E                           ; DCE8 F0 54
LDCEA:  cmp     #$A1                            ; DCEA C9 A1
        bcs     LDCF9                           ; DCEC B0 0B
        lda     #$00                            ; DCEE A9 00
        sta     VARAPL+14                       ; DCF0 85 DE
        sta     VARAPL+15                       ; DCF2 85 DF
        jsr     LD9A5                           ; DCF4 20 A5 D9
        beq     LDD3B                           ; DCF7 F0 42
LDCF9:  cmp     #$B9                            ; DCF9 C9 B9
        bne     LDD00                           ; DCFB D0 03
LDCFD:  jmp     SyntaxErr5                      ; DCFD 4C 3D D8

; ----------------------------------------------------------------------------
LDD00:  cmp     #$BC                            ; DD00 C9 BC
        beq     LDCBB                           ; DD02 F0 B7
        cmp     #$B8                            ; DD04 C9 B8
        bne     LDD0E                           ; DD06 D0 06
        jsr     LDA62                           ; DD08 20 62 DA
        jmp     LDCBB                           ; DD0B 4C BB DC

; ----------------------------------------------------------------------------
LDD0E:  cmp     #$BA                            ; DD0E C9 BA
        bne     LDD18                           ; DD10 D0 06
        jsr     LDA40                           ; DD12 20 40 DA
        jmp     LDCBB                           ; DD15 4C BB DC

; ----------------------------------------------------------------------------
LDD18:  cmp     #$BD                            ; DD18 C9 BD
        bne     LDD22                           ; DD1A D0 06
        jsr     LDA40                           ; DD1C 20 40 DA
        jmp     LDCBB                           ; DD1F 4C BB DC

; ----------------------------------------------------------------------------
LDD22:  cmp     #$BB                            ; DD22 C9 BB
        bne     LDD2C                           ; DD24 D0 06
        jsr     LDAEA                           ; DD26 20 EA DA
        jmp     LDCBB                           ; DD29 4C BB DC

; ----------------------------------------------------------------------------
LDD2C:  cmp     #$B8                            ; DD2C C9 B8
        bcs     LDCFD                           ; DD2E B0 CD
LDD30:  jsr     LD912                           ; DD30 20 12 D9
        beq     LDD3E                           ; DD33 F0 09
        dex                                     ; DD35 CA
        beq     LDD3B                           ; DD36 F0 03
        jsr     LCC53                           ; DD38 20 53 CC
LDD3B:  jsr     LCC53                           ; DD3B 20 53 CC
LDD3E:  jsr     LCC53                           ; DD3E 20 53 CC
        jmp     LDCBB                           ; DD41 4C BB DC

; ----------------------------------------------------------------------------
LDD44:  BRK_TELEMON XCRLF                             ; DD44 00 25
        lda     #<Source_str                    ; DD46 A9 41
        ldy     #>Source_str                    ; DD48 A0 C6
        BRK_TELEMON XWSTR0                             ; DD4A 00 14
        lda     SCEDEB                          ; DD4C A5 5C
        ldy     SCEDEB+1                        ; DD4E A4 5D
        jsr     DispWord                        ; DD50 20 8D C7
        jsr     DispSpace                       ; DD53 20 35 C7
        lda     VARAPL2+17                      ; DD56 A5 FC
        ldy     VARAPL2+18                      ; DD58 A4 FD
        jsr     DispWord                        ; DD5A 20 8D C7
        BRK_TELEMON XCRLF                             ; DD5D 00 25
        lda     #<Objet_str                     ; DD5F A9 4F
        ldy     #>Objet_str                     ; DD61 A0 C6
        BRK_TELEMON XWSTR0                             ; DD63 00 14
        lda     Ptr3                            ; DD65 AD F2 04
        ldy     Ptr3+1                          ; DD68 AC F3 04
        jsr     DispWord                        ; DD6B 20 8D C7
        jsr     DispSpace                       ; DD6E 20 35 C7
        sec                                     ; DD71 38
        lda     Proc1+1                         ; DD72 AD E3 04
        sbc     Ptr1                            ; DD75 ED EE 04
        sta     VARAPL+1                        ; DD78 85 D1
        lda     Proc1+2                         ; DD7A AD E4 04
        sbc     Ptr1+1                          ; DD7D ED EF 04
        sta     VARAPL+2                        ; DD80 85 D2
        clc                                     ; DD82 18
        lda     Ptr3                            ; DD83 AD F2 04
        adc     VARAPL+1                        ; DD86 65 D1
        pha                                     ; DD88 48
        lda     Ptr3+1                          ; DD89 AD F3 04
        adc     VARAPL+2                        ; DD8C 65 D2
        tay                                     ; DD8E A8
        pla                                     ; DD8F 68
        jsr     DispWord                        ; DD90 20 8D C7
        jsr     DispSpace                       ; DD93 20 35 C7
        BRK_TELEMON XCRLF                             ; DD96 00 25
        jsr     LE013                           ; DD98 20 13 E0
        lda     #<Assemblage_str+1              ; DD9B A9 84
        ldy     #>Assemblage_str+1              ; DD9D A0 C6
        BRK_TELEMON XWSTR0                             ; DD9F 00 14
        lda     #<O_N_str                       ; DDA1 A9 8F
        ldy     #>O_N_str                       ; DDA3 A0 C6
        BRK_TELEMON XWSTR0                             ; DDA5 00 14
LDDA7:  jsr     GetKey                          ; DDA7 20 D1 C8
        jsr     min_MAJ                         ; DDAA 20 BF C9
        cmp     #"O"                            ; DDAD C9 4F
        beq     LDDBA                           ; DDAF F0 09
        cmp     #"N"                            ; DDB1 C9 4E
        bne     LDDA7                           ; DDB3 D0 F2
        BRK_TELEMON XWR0                             ; DDB5 00 10
        jmp     LCFC8                           ; DDB7 4C C8 CF

; ----------------------------------------------------------------------------
LDDBA:  BRK_TELEMON XWR0                             ; DDBA 00 10
        BRK_TELEMON XCRLF                             ; DDBC 00 25
        jsr     LCF40                           ; DDBE 20 40 CF
        jsr     LCC38                           ; DDC1 20 38 CC
        jsr     LCCC5                           ; DDC4 20 C5 CC
LDDC7:  jsr     LD7EE                           ; DDC7 20 EE D7
        beq     LDE4A                           ; DDCA F0 7E
        jsr     LD7FA                           ; DDCC 20 FA D7
        bmi     LDDD8                           ; DDCF 30 07
        cmp     #"'"                            ; DDD1 C9 27
        beq     LDDC7                           ; DDD3 F0 F2
        jsr     LD832                           ; DDD5 20 32 D8
LDDD8:  sta     INDIC2                          ; DDD8 85 57
        cmp     #$80                            ; DDDA C9 80
        beq     LDE26                           ; DDDC F0 48
        cmp     #$B9                            ; DDDE C9 B9
        beq     LDDC7                           ; DDE0 F0 E5
        cmp     #$BC                            ; DDE2 C9 BC
        beq     LDDC7                           ; DDE4 F0 E1
        cmp     #$99                            ; DDE6 C9 99
        bcs     LDDF2                           ; DDE8 B0 08
        lda     #$00                            ; DDEA A9 00
        tax                                     ; DDEC AA
        jsr     LCA79                           ; DDED 20 79 CA
        bcs     LDE29                           ; DDF0 B0 37
LDDF2:  cmp     #$A1                            ; DDF2 C9 A1
        bcs     LDDFB                           ; DDF4 B0 05
        jsr     LD9C0                           ; DDF6 20 C0 D9
        bne     LDE29                           ; DDF9 D0 2E
LDDFB:  cmp     #$B8                            ; DDFB C9 B8
        bne     LDE05                           ; DDFD D0 06
        jsr     LDAA4                           ; DDFF 20 A4 DA
        jmp     LDDC7                           ; DE02 4C C7 DD

; ----------------------------------------------------------------------------
LDE05:  cmp     #$BA                            ; DE05 C9 BA
        bne     LDE0F                           ; DE07 D0 06
        jsr     LD9FA                           ; DE09 20 FA D9
        jmp     LDDC7                           ; DE0C 4C C7 DD

; ----------------------------------------------------------------------------
LDE0F:  cmp     #$BD                            ; DE0F C9 BD
        bne     LDE19                           ; DE11 D0 06
        jsr     LDA1D                           ; DE13 20 1D DA
        jmp     LDDC7                           ; DE16 4C C7 DD

; ----------------------------------------------------------------------------
LDE19:  cmp     #$BB                            ; DE19 C9 BB
        bne     LDE26                           ; DE1B D0 09
        jsr     LDAEA                           ; DE1D 20 EA DA
        jsr     LCCB3                           ; DE20 20 B3 CC
        jmp     LDDC7                           ; DE23 4C C7 DD

; ----------------------------------------------------------------------------
LDE26:  jsr     LD912                           ; DE26 20 12 D9
LDE29:  sta     HRS3+1                          ; DE29 85 52
        stx     INDIC0+1                        ; DE2B 86 56
        lda     VARAPL+14                       ; DE2D A5 DE
        sta     HRS4                            ; DE2F 85 53
        lda     VARAPL+15                       ; DE31 A5 DF
        sta     HRS4+1                          ; DE33 85 54
        ldy     #$FF                            ; DE35 A0 FF
LDE37:  iny                                     ; DE37 C8
        lda     HRS3+1,y                        ; DE38 B9 52 00
        jsr     LCCDB                           ; DE3B 20 DB CC
        jsr     LCCD2                           ; DE3E 20 D2 CC
        jsr     LCC53                           ; DE41 20 53 CC
        dex                                     ; DE44 CA
        bpl     LDE37                           ; DE45 10 F0
        jmp     LDDC7                           ; DE47 4C C7 DD

; ----------------------------------------------------------------------------
LDE4A:  bit     XLPRBI                          ; DE4A 24 48
        bpl     LDE51                           ; DE4C 10 03
        jsr     LCF8D                           ; DE4E 20 8D CF
LDE51:  bit     HRSX40                          ; DE51 24 49
        bmi     LDE58                           ; DE53 30 03
        jmp     LDEF4                           ; DE55 4C F4 DE

; ----------------------------------------------------------------------------
LDE58:  jsr     LCB5A                           ; DE58 20 5A CB
        jsr     LCF40                           ; DE5B 20 40 CF
        jsr     LCC38                           ; DE5E 20 38 CC
LDE61:  jsr     LD7EE                           ; DE61 20 EE D7
        bne     LDE69                           ; DE64 D0 03
        jmp     LDEF4                           ; DE66 4C F4 DE

; ----------------------------------------------------------------------------
LDE69:  lda     TXTPTR                          ; DE69 A5 E9
        sta     VARAPL+10                       ; DE6B 85 DA
        lda     TXTPTR+1                        ; DE6D A5 EA
        sta     VARAPL+11                       ; DE6F 85 DB
        jsr     LD7FA                           ; DE71 20 FA D7
        bmi     LDE83                           ; DE74 30 0D
        cmp     #"'"                            ; DE76 C9 27
        bne     LDE80                           ; DE78 D0 06
LDE7A:  jsr     LDB05                           ; DE7A 20 05 DB
        jmp     LDEDD                           ; DE7D 4C DD DE

; ----------------------------------------------------------------------------
LDE80:  jsr     LD832                           ; DE80 20 32 D8
LDE83:  sta     INDIC2                          ; DE83 85 57
        cmp     #$80                            ; DE85 C9 80
        beq     LDECB                           ; DE87 F0 42
        cmp     #$B9                            ; DE89 C9 B9
        beq     LDE7A                           ; DE8B F0 ED
        cmp     #$BC                            ; DE8D C9 BC
        beq     LDE7A                           ; DE8F F0 E9
        cmp     #$99                            ; DE91 C9 99
        bcs     LDE9D                           ; DE93 B0 08
        lda     #$00                            ; DE95 A9 00
        tax                                     ; DE97 AA
        jsr     LCA79                           ; DE98 20 79 CA
        bcs     LDECE                           ; DE9B B0 31
LDE9D:  cmp     #$A1                            ; DE9D C9 A1
        bcs     LDEA6                           ; DE9F B0 05
        jsr     LD9C0                           ; DEA1 20 C0 D9
        bne     LDECE                           ; DEA4 D0 28
LDEA6:  cmp     #$B8                            ; DEA6 C9 B8
        bne     LDEAF                           ; DEA8 D0 05
        jsr     LDBC6                           ; DEAA 20 C6 DB
        beq     LDE61                           ; DEAD F0 B2
LDEAF:  cmp     #$BA                            ; DEAF C9 BA
        bne     LDEB8                           ; DEB1 D0 05
        jsr     LDBA9                           ; DEB3 20 A9 DB
        beq     LDE61                           ; DEB6 F0 A9
LDEB8:  cmp     #$BD                            ; DEB8 C9 BD
        bne     LDEC1                           ; DEBA D0 05
        jsr     LDB8F                           ; DEBC 20 8F DB
        beq     LDE61                           ; DEBF F0 A0
LDEC1:  cmp     #$BB                            ; DEC1 C9 BB
        bne     LDECB                           ; DEC3 D0 06
        jsr     LDAF6                           ; DEC5 20 F6 DA
        jmp     LDEDD                           ; DEC8 4C DD DE

; ----------------------------------------------------------------------------
LDECB:  jsr     LD912                           ; DECB 20 12 D9
LDECE:  sta     HRS3+1                          ; DECE 85 52
        stx     INDIC0+1                        ; DED0 86 56
        lda     VARAPL+14                       ; DED2 A5 DE
        sta     HRS4                            ; DED4 85 53
        lda     VARAPL+15                       ; DED6 A5 DF
        sta     HRS4+1                          ; DED8 85 54
        jsr     LDB0B                           ; DEDA 20 0B DB
LDEDD:  lda     VARAPL+10                       ; DEDD A5 DA
        sta     VARAPL+12                       ; DEDF 85 DC
        lda     VARAPL+11                       ; DEE1 A5 DB
        sta     VARAPL+13                       ; DEE3 85 DD
        lda     VARAPL+16                       ; DEE5 A5 E0
        ldy     VARAPL+17                       ; DEE7 A4 E1
        jsr     LCAF8                           ; DEE9 20 F8 CA
        jsr     LD2B0                           ; DEEC 20 B0 D2
        bcs     LDF04                           ; DEEF B0 13
        jmp     LDE61                           ; DEF1 4C 61 DE

; ----------------------------------------------------------------------------
LDEF4:  bit     HRSX6                           ; DEF4 24 4A
        bpl     LDF04                           ; DEF6 10 0C
        jsr     LCB5A                           ; DEF8 20 5A CB
        jsr     DispLocSym                      ; DEFB 20 0A DF
        jsr     LCB5A                           ; DEFE 20 5A CB
        jsr     DispGlobSym                     ; DF01 20 31 DF
LDF04:  jsr     LCB6F                           ; DF04 20 6F CB
        jmp     LCFCB                           ; DF07 4C CB CF

; ----------------------------------------------------------------------------
; C65D 'Symboles :'/ C66B 'locaux'
DispLocSym:
        lda     #<Symboles_str                  ; DF0A A9 5D
        ldy     #>Symboles_str                  ; DF0C A0 C6
        BRK_TELEMON XWSTR0                             ; DF0E 00 14
        lda     #<Locaux_str                    ; DF10 A9 6B
        ldy     #>Locaux_str                    ; DF12 A0 C6
        BRK_TELEMON XWSTR0                             ; DF14 00 14
        lda     VARAPL2+15                      ; DF16 A5 FA
        sta     Ptr1                            ; DF18 8D EE 04
        sta     VARAPL+12                       ; DF1B 85 DC
        lda     VARAPL2+16                      ; DF1D A5 FB
        sta     Ptr1+1                          ; DF1F 8D EF 04
        sta     VARAPL+13                       ; DF22 85 DD
        lda     VARAPL2+17                      ; DF24 A5 FC
        sta     Ptr2                            ; DF26 8D F0 04
        lda     VARAPL2+18                      ; DF29 A5 FD
        sta     Ptr2+1                          ; DF2B 8D F1 04
        jmp     DispSymTbl                      ; DF2E 4C 7C DF

; ----------------------------------------------------------------------------
; C65D 'Symboles :'/ C672 'globaux'
DispGlobSym:
        lda     #<Symboles_str                  ; DF31 A9 5D
        ldy     #>Symboles_str                  ; DF33 A0 C6
        BRK_TELEMON XWSTR0                             ; DF35 00 14
        lda     #<Globaux_str                   ; DF37 A9 72
        ldy     #>Globaux_str                   ; DF39 A0 C6
        BRK_TELEMON XWSTR0                             ; DF3B 00 14
        lda     VARAPL2+9                       ; DF3D A5 F4
        sta     Ptr1                            ; DF3F 8D EE 04
        sta     VARAPL+12                       ; DF42 85 DC
        lda     VARAPL2+10                      ; DF44 A5 F5
        sta     Ptr1+1                          ; DF46 8D EF 04
        sta     VARAPL+13                       ; DF49 85 DD
        lda     VARAPL2+11                      ; DF4B A5 F6
        sta     Ptr2                            ; DF4D 8D F0 04
        lda     VARAPL2+12                      ; DF50 A5 F7
        sta     Ptr2+1                          ; DF52 8D F1 04
        jmp     DispSymTbl                      ; DF55 4C 7C DF

; ----------------------------------------------------------------------------
; C65D 'Symboles :'/ C67A 'moniteur'
DispMonSym:
        lda     #<Symboles_str                  ; DF58 A9 5D
        ldy     #>Symboles_str                  ; DF5A A0 C6
        BRK_TELEMON XWSTR0                             ; DF5C 00 14
        lda     #<Moniteur_str                  ; DF5E A9 7A
        ldy     #>Moniteur_str                  ; DF60 A0 C6
        BRK_TELEMON XWSTR0                             ; DF62 00 14
        lda     #<SymbolTable                   ; DF64 A9 18
        sta     Ptr1                            ; DF66 8D EE 04
        sta     VARAPL+12                       ; DF69 85 DC
        lda     #>SymbolTable                   ; DF6B A9 F0
        sta     Ptr1+1                          ; DF6D 8D EF 04
        sta     VARAPL+13                       ; DF70 85 DD
        lda     #$C8                            ; DF72 A9 C8
        sta     Ptr2                            ; DF74 8D F0 04
        lda     #$FF                            ; DF77 A9 FF
        sta     Ptr2+1                          ; DF79 8D F1 04
; VARAPL+12: Adr debut de la table, VARAPL+1: Finde la table
DispSymTbl:
        jsr     LCB5A                           ; DF7C 20 5A CB
        lda     #$03                            ; DF7F A9 03
        sta     VARAPL+5                        ; DF81 85 D5
        sta     VARAPL+6                        ; DF83 85 D6
        lda     #$2E                            ; DF85 A9 2E
        sta     VARAPL+7                        ; DF87 85 D7
LDF89:  lda     VARAPL+13                       ; DF89 A5 DD
        cmp     Ptr2+1                          ; DF8B CD F1 04
        bne     LDF95                           ; DF8E D0 05
        lda     VARAPL+12                       ; DF90 A5 DC
        cmp     Ptr2                            ; DF92 CD F0 04
LDF95:  bcc     LDFC3                           ; DF95 90 2C
        bit     VARAPL+6                        ; DF97 24 D6
        bpl     LE002                           ; DF99 10 67
        lda     VARAPL+7                        ; DF9B A5 D7
        cmp     #"."                            ; DF9D C9 2E
        bne     LDFA7                           ; DF9F D0 06
        lda     #$5B                            ; DFA1 A9 5B
        sta     VARAPL+7                        ; DFA3 85 D7
        bne     LDFB7                           ; DFA5 D0 10
LDFA7:  inc     VARAPL+7                        ; DFA7 E6 D7
        lda     VARAPL+7                        ; DFA9 A5 D7
        cmp     #"Z"+1                            ; DFAB C9 5B
        beq     LE002                           ; DFAD F0 53
        cmp     #$7B                            ; DFAF C9 7B
        bne     LDFB7                           ; DFB1 D0 04
        lda     #$3F                            ; DFB3 A9 3F
        sta     VARAPL+7                        ; DFB5 85 D7
LDFB7:  lda     Ptr1                            ; DFB7 AD EE 04
        sta     VARAPL+12                       ; DFBA 85 DC
        lda     Ptr1+1                          ; DFBC AD EF 04
        sta     VARAPL+13                       ; DFBF 85 DD
        lsr     VARAPL+6                        ; DFC1 46 D6
LDFC3:  ldy     #$00                            ; DFC3 A0 00
        lda     (VARAPL+12),y                   ; DFC5 B1 DC
        cmp     VARAPL+7                        ; DFC7 C5 D7
        beq     LDFDD                           ; DFC9 F0 12
        sec                                     ; DFCB 38
        ror     VARAPL+6                        ; DFCC 66 D6
LDFCE:  clc                                     ; DFCE 18
        lda     VARAPL+12                       ; DFCF A5 DC
        adc     #$08                            ; DFD1 69 08
        sta     VARAPL+12                       ; DFD3 85 DC
        lda     VARAPL+13                       ; DFD5 A5 DD
        adc     #$00                            ; DFD7 69 00
        sta     VARAPL+13                       ; DFD9 85 DD
        bcc     LDF89                           ; DFDB 90 AC
LDFDD:  lda     (VARAPL+12),y                   ; DFDD B1 DC
        BRK_TELEMON XWR0                             ; DFDF 00 10
        iny                                     ; DFE1 C8
        cpy     #$06                            ; DFE2 C0 06
        bne     LDFDD                           ; DFE4 D0 F7
        jsr     DispSpace                       ; DFE6 20 35 C7
        lda     (VARAPL+12),y                   ; DFE9 B1 DC
        pha                                     ; DFEB 48
        iny                                     ; DFEC C8
        lda     (VARAPL+12),y                   ; DFED B1 DC
        tay                                     ; DFEF A8
        pla                                     ; DFF0 68
        jsr     DispWord                        ; DFF1 20 8D C7
        dec     VARAPL+5                        ; DFF4 C6 D5
        bne     LE00A                           ; DFF6 D0 12
        ldx     #$03                            ; DFF8 A2 03
        stx     VARAPL+5                        ; DFFA 86 D5
        jsr     LD2B0                           ; DFFC 20 B0 D2
        bcc     LDFCE                           ; DFFF 90 CD
        rts                                     ; E001 60

; ----------------------------------------------------------------------------
LE002:  php                                     ; E002 08
        jsr     LCB5A                           ; E003 20 5A CB
        plp                                     ; E006 28
        bcc     LDFCE                           ; E007 90 C5
        rts                                     ; E009 60

; ----------------------------------------------------------------------------
LE00A:  jsr     DispSpace                       ; E00A 20 35 C7
        jsr     DispSpace                       ; E00D 20 35 C7
        jmp     LDFCE                           ; E010 4C CE DF

; ----------------------------------------------------------------------------
LE013:  lda     #<Symboles_str                  ; E013 A9 5D
        ldy     #>Symboles_str                  ; E015 A0 C6
        BRK_TELEMON XWSTR0                             ; E017 00 14
        lda     VARAPL2+9                       ; E019 A5 F4
        ldy     VARAPL2+10                      ; E01B A4 F5
        jsr     DispWord                        ; E01D 20 8D C7
        jsr     DispSpace                       ; E020 20 35 C7
        lda     VARAPL2+11                      ; E023 A5 F6
        ldy     VARAPL2+12                      ; E025 A4 F7
        jsr     DispWord                        ; E027 20 8D C7
        jsr     DispSpace                       ; E02A 20 35 C7
        lda     VARAPL2+13                      ; E02D A5 F8
        ldy     VARAPL2+14                      ; E02F A4 F9
        jsr     DispWord                        ; E031 20 8D C7
        BRK_TELEMON XCRLF                             ; E034 00 25
        rts                                     ; E036 60

; ----------------------------------------------------------------------------
; SYOLD (adrdeb, adrlim) : retrouve les symboles globaux (après sauvegarde et
; rechargement par exemple) et réinitialise les adresses de début et limite de
; la table (valeurs par défaut sinon: $3000, $3FFF)
SYOLD:  ldx     VARAPL2+9                       ; E037 A6 F4
        ldy     VARAPL2+10                      ; E039 A4 F5
        stx     Ptr1                            ; E03B 8E EE 04
        sty     Ptr1+1                          ; E03E 8C EF 04
        ldx     VARAPL2+13                      ; E041 A6 F8
        ldy     VARAPL2+14                      ; E043 A4 F9
        stx     Ptr2                            ; E045 8E F0 04
        sty     Ptr2+1                          ; E048 8C F1 04
        tax                                     ; E04B AA
        beq     LE053                           ; E04C F0 05
        jsr     LE090                           ; E04E 20 90 E0
        bne     LE08A                           ; E051 D0 37
LE053:  jsr     LE0AB                           ; E053 20 AB E0
        jmp     LE07D                           ; E056 4C 7D E0

; ----------------------------------------------------------------------------
; SYDEF (adrdeb, adrlim (,C)) : sans option, donne les adresses de la table des
; symboles Globaux, sinon déplace cette table en adrdeb et fixe sa limite à
; ardlim. L'option C permet de recopier à partir de adrdeb les symboles globaux
; existants, sinon
SYDEF:  ldx     #$00                            ; E059 A2 00
        stx     VARAPL+7                        ; E05B 86 D7
        tax                                     ; E05D AA
        beq     LE080                           ; E05E F0 20
        jsr     LE090                           ; E060 20 90 E0
        beq     LE074                           ; E063 F0 0F
        jsr     EvalComma                       ; E065 20 AC D1
        cmp     #"C"                            ; E068 C9 43
        bne     LE08A                           ; E06A D0 1E
        ror     VARAPL+7                        ; E06C 66 D7
        jsr     CharGet                         ; E06E 20 E2 00
        tax                                     ; E071 AA
        bne     LE08A                           ; E072 D0 16
LE074:  jsr     LE0AB                           ; E074 20 AB E0
        BRK_TELEMON XDECAL                             ; E077 00 18
        bit     VARAPL+7                        ; E079 24 D7
        bpl     LE080                           ; E07B 10 03
LE07D:  jsr     LE107                           ; E07D 20 07 E1
LE080:  lda     #$7F                            ; E080 A9 7F
        BRK_TELEMON XWR0                             ; E082 00 10
        jsr     LE013                           ; E084 20 13 E0
        jmp     LCFC8                           ; E087 4C C8 CF

; ----------------------------------------------------------------------------
LE08A:  jmp     SyntaxErr5                      ; E08A 4C 3D D8

; ----------------------------------------------------------------------------
LE08D:  jmp     OutOfRangeValErr1               ; E08D 4C 43 D8

; ----------------------------------------------------------------------------
LE090:  tax                                     ; E090 AA
        beq     LE08A                           ; E091 F0 F7
        jsr     EvalWord                        ; E093 20 6A D2
        sta     Ptr1                            ; E096 8D EE 04
        sty     Ptr1+1                          ; E099 8C EF 04
        cpx     #$2C                            ; E09C E0 2C
        bne     LE08A                           ; E09E D0 EA
        jsr     LD267                           ; E0A0 20 67 D2
        sta     Ptr2                            ; E0A3 8D F0 04
        sty     Ptr2+1                          ; E0A6 8C F1 04
        txa                                     ; E0A9 8A
        rts                                     ; E0AA 60

; ----------------------------------------------------------------------------
LE0AB:  sec                                     ; E0AB 38
        lda     Ptr2                            ; E0AC AD F0 04
        sbc     Ptr1                            ; E0AF ED EE 04
        sta     DECTRV                          ; E0B2 85 0A
        lda     Ptr2+1                          ; E0B4 AD F1 04
        tay                                     ; E0B7 A8
        sbc     Ptr1+1                          ; E0B8 ED EF 04
        sta     DECTRV+1                        ; E0BB 85 0B
        bcc     LE08A                           ; E0BD 90 CB
        ora     DECTRV                          ; E0BF 05 0A
        beq     LE08A                           ; E0C1 F0 C7
        sec                                     ; E0C3 38
        lda     VARAPL2+9                       ; E0C4 A5 F4
        sta     DECDEB                          ; E0C6 85 04
        adc     DECTRV                          ; E0C8 65 0A
        sta     DECFIN                          ; E0CA 85 06
        lda     VARAPL2+10                      ; E0CC A5 F5
        sta     DECDEB+1                        ; E0CE 85 05
        adc     DECTRV+1                        ; E0D0 65 0B
        sta     DECFIN+1                        ; E0D2 85 07
        ldx     Ptr1                            ; E0D4 AE EE 04
        lda     Ptr1+1                          ; E0D7 AD EF 04
        stx     DECCIB                          ; E0DA 86 08
        sta     DECCIB+1                        ; E0DC 85 09
        cmp     SCEFIN+1                        ; E0DE C5 5F
        bcc     LE08D                           ; E0E0 90 AB
        cpy     #$B4                            ; E0E2 C0 B4
        bcc     LE0ED                           ; E0E4 90 07
        bne     LE08D                           ; E0E6 D0 A5
        ldy     Ptr2                            ; E0E8 AC F0 04
        bne     LE08D                           ; E0EB D0 A0
LE0ED:  jsr     LocTblInit                      ; E0ED 20 73 CF
        lda     Ptr2                            ; E0F0 AD F0 04
        ldy     Ptr2+1                          ; E0F3 AC F1 04
        sta     VARAPL2+13                      ; E0F6 85 F8
        sty     VARAPL2+14                      ; E0F8 84 F9
        lda     DECCIB                          ; E0FA A5 08
        ldy     DECCIB+1                        ; E0FC A4 09
        sta     VARAPL2+9                       ; E0FE 85 F4
        sta     VARAPL2+11                      ; E100 85 F6
        sty     VARAPL2+10                      ; E102 84 F5
        sty     VARAPL2+12                      ; E104 84 F7
        rts                                     ; E106 60

; ----------------------------------------------------------------------------
LE107:  ldy     VARAPL2+13                      ; E107 A4 F8
        ldx     VARAPL2+14                      ; E109 A6 F9
        sty     DECFIN                          ; E10B 84 06
        stx     DECFIN+1                        ; E10D 86 07
        ldy     VARAPL2+9                       ; E10F A4 F4
        ldx     VARAPL2+10                      ; E111 A6 F5
LE113:  sty     DECDEB                          ; E113 84 04
        stx     DECDEB+1                        ; E115 86 05
        cpx     DECFIN+1                        ; E117 E4 07
        bne     LE11D                           ; E119 D0 02
        cpy     DECFIN                          ; E11B C4 06
LE11D:  bcs     LE14E                           ; E11D B0 2F
        ldy     #$00                            ; E11F A0 00
        lda     (DECDEB),y                      ; E121 B1 04
        beq     LE14E                           ; E123 F0 29
        jsr     LC926                           ; E125 20 26 C9
        bcc     LE14E                           ; E128 90 24
LE12A:  iny                                     ; E12A C8
        cpy     #$06                            ; E12B C0 06
        beq     LE141                           ; E12D F0 12
        lda     (DECDEB),y                      ; E12F B1 04
        jsr     LC91A                           ; E131 20 1A C9
        bcs     LE12A                           ; E134 B0 F4
LE136:  lda     (DECDEB),y                      ; E136 B1 04
        cmp     #" "                            ; E138 C9 20
        bne     LE14E                           ; E13A D0 12
        iny                                     ; E13C C8
        cpy     #$06                            ; E13D C0 06
        bne     LE136                           ; E13F D0 F5
LE141:  clc                                     ; E141 18
        lda     DECDEB                          ; E142 A5 04
        adc     #$08                            ; E144 69 08
        tay                                     ; E146 A8
        lda     DECDEB+1                        ; E147 A5 05
        adc     #$00                            ; E149 69 00
        tax                                     ; E14B AA
        bcc     LE113                           ; E14C 90 C5
LE14E:  ldy     #$00                            ; E14E A0 00
        tya                                     ; E150 98
        sta     (DECDEB),y                      ; E151 91 04
        lda     DECDEB                          ; E153 A5 04
        sta     VARAPL2+11                      ; E155 85 F6
        lda     DECDEB+1                        ; E157 A5 05
        sta     VARAPL2+12                      ; E159 85 F7
        rts                                     ; E15B 60

; ----------------------------------------------------------------------------
LE15C:  jmp     SyntaxErr5                      ; E15C 4C 3D D8

; ----------------------------------------------------------------------------
; (L)SYTAB (,L) (,G) (,M) : liste la table des symboles (L)ocaux, (G)lobaux ou
; (M)oniteur par ordre alphabétique. Par défaut seule la table (G)lobale est
; affichée
SYTAB:  ldy     #$00                            ; E15F A0 00
        .byte   $2C                             ; E161 2C
LSYTAB: ldy     #$80                            ; E162 A0 80
        sty     XLPRBI                          ; E164 84 48
        ldy     #$40                            ; E166 A0 40
        sty     VARAPL+11                       ; E168 84 DB
        tax                                     ; E16A AA
        beq     LE1A6                           ; E16B F0 39
        ldy     #$00                            ; E16D A0 00
        sty     VARAPL+11                       ; E16F 84 DB
        lda     TXTPTR                          ; E171 A5 E9
        bne     LE177                           ; E173 D0 02
        dec     TXTPTR+1                        ; E175 C6 EA
LE177:  dec     TXTPTR                          ; E177 C6 E9
LE179:  jsr     CharGet                         ; E179 20 E2 00
        tax                                     ; E17C AA
        beq     LE1A6                           ; E17D F0 27
        jsr     EvalComma                       ; E17F 20 AC D1
        cmp     #"L"                            ; E182 C9 4C
        bne     LE18E                           ; E184 D0 08
        lda     VARAPL+11                       ; E186 A5 DB
        ora     #$80                            ; E188 09 80
        sta     VARAPL+11                       ; E18A 85 DB
        bne     LE179                           ; E18C D0 EB
LE18E:  cmp     #"G"                            ; E18E C9 47
        bne     LE19A                           ; E190 D0 08
        lda     VARAPL+11                       ; E192 A5 DB
        ora     #$40                            ; E194 09 40
        sta     VARAPL+11                       ; E196 85 DB
        bne     LE179                           ; E198 D0 DF
LE19A:  cmp     #"M"                            ; E19A C9 4D
        bne     LE15C                           ; E19C D0 BE
        lda     VARAPL+11                       ; E19E A5 DB
        ora     #$01                            ; E1A0 09 01
        sta     VARAPL+11                       ; E1A2 85 DB
        bne     LE179                           ; E1A4 D0 D3
LE1A6:  bit     XLPRBI                          ; E1A6 24 48
        bpl     LE1AD                           ; E1A8 10 03
        jsr     LCF8D                           ; E1AA 20 8D CF
LE1AD:  bit     VARAPL+11                       ; E1AD 24 DB
        bpl     LE1B7                           ; E1AF 10 06
        jsr     LCB5A                           ; E1B1 20 5A CB
        jsr     DispLocSym                      ; E1B4 20 0A DF
LE1B7:  bit     VARAPL+11                       ; E1B7 24 DB
        bvc     LE1C1                           ; E1B9 50 06
        jsr     LCB5A                           ; E1BB 20 5A CB
        jsr     DispGlobSym                     ; E1BE 20 31 DF
LE1C1:  lda     VARAPL+11                       ; E1C1 A5 DB
        and     #$01                            ; E1C3 29 01
        beq     LE1CD                           ; E1C5 F0 06
        jsr     LCB5A                           ; E1C7 20 5A CB
        jsr     DispMonSym                      ; E1CA 20 58 DF
LE1CD:  jmp     LCFCB                           ; E1CD 4C CB CF

; ----------------------------------------------------------------------------
; ?DEC val | ?DEC (adr) : conversion de val ou du contenu de adr en décimal
QDEC:   jsr     LE22D                           ; E1D0 20 2D E2
        pha                                     ; E1D3 48
        lda     #$7F                            ; E1D4 A9 7F
        BRK_TELEMON XWR0                             ; E1D6 00 10
        pla                                     ; E1D8 68
        jsr     LC779                           ; E1D9 20 79 C7
        jmp     LE1F9                           ; E1DC 4C F9 E1

; ----------------------------------------------------------------------------
; ?BIN val | ?BIN (adr) : conversion de val ou du contenu de adr en binaire
QBIN:   jsr     LE22D                           ; E1DF 20 2D E2
        php                                     ; E1E2 08
        pha                                     ; E1E3 48
        lda     #$7F                            ; E1E4 A9 7F
        BRK_TELEMON XWR0                             ; E1E6 00 10
        lda     #"%"                            ; E1E8 A9 25
        BRK_TELEMON XWR0                             ; E1EA 00 10
        pla                                     ; E1EC 68
        plp                                     ; E1ED 28
        beq     LE1F6                           ; E1EE F0 06
        pha                                     ; E1F0 48
        tya                                     ; E1F1 98
        jsr     DispBitStr                      ; E1F2 20 A1 C7
        pla                                     ; E1F5 68
LE1F6:  jsr     DispBitStr                      ; E1F6 20 A1 C7
LE1F9:  jmp     LCFC8                           ; E1F9 4C C8 CF

; ----------------------------------------------------------------------------
; ?HEX val | ?HEX (adr) : conversion de val ou du contenu de adr en hexadécimal
;
QHEX:   jsr     LE22D                           ; E1FC 20 2D E2
        php                                     ; E1FF 08
        pha                                     ; E200 48
        lda     #$7F                            ; E201 A9 7F
        BRK_TELEMON XWR0                             ; E203 00 10
        lda     #"$"                            ; E205 A9 24
        BRK_TELEMON XWR0                             ; E207 00 10
        pla                                     ; E209 68
        plp                                     ; E20A 28
        beq     LE213                           ; E20B F0 06
        jsr     DispWord                        ; E20D 20 8D C7
        jmp     LE1F9                           ; E210 4C F9 E1

; ----------------------------------------------------------------------------
LE213:  jsr     DispByte                        ; E213 20 92 C7
        jmp     LE1F9                           ; E216 4C F9 E1

; ----------------------------------------------------------------------------
; ?CAR val | ?CAR (adr) : conversion de val ou du contenu de adr en caractère
; ASCII
QCAR:   jsr     LE22D                           ; E219 20 2D E2
        bne     LE263                           ; E21C D0 45
        pha                                     ; E21E 48
        lda     #$7F                            ; E21F A9 7F
        BRK_TELEMON XWR0                             ; E221 00 10
        jsr     DispSpace                       ; E223 20 35 C7
        pla                                     ; E226 68
        jsr     LC716                           ; E227 20 16 C7
        jmp     LE1F9                           ; E22A 4C F9 E1

; ----------------------------------------------------------------------------
LE22D:  ldx     #$00                            ; E22D A2 00
        stx     VARAPL+7                        ; E22F 86 D7
        cmp     #"("                            ; E231 C9 28
        bne     LE23A                           ; E233 D0 05
        ror     VARAPL+7                        ; E235 66 D7
        jsr     CharGet                         ; E237 20 E2 00
LE23A:  jsr     EvalExpr                        ; E23A 20 DF CE
        bit     VARAPL+7                        ; E23D 24 D7
        bpl     LE250                           ; E23F 10 0F
        cmp     #")"                            ; E241 C9 29
        bne     LE260                           ; E243 D0 1B
        ldy     #$00                            ; E245 A0 00
        lda     (VARAPL+14),y                   ; E247 B1 DE
        sta     VARAPL+14                       ; E249 85 DE
        sty     VARAPL+15                       ; E24B 84 DF
        jsr     CharGet                         ; E24D 20 E2 00
LE250:  tax                                     ; E250 AA
        bne     LE260                           ; E251 D0 0D
        lda     VARAPL+14                       ; E253 A5 DE
        ldy     VARAPL+15                       ; E255 A4 DF
        rts                                     ; E257 60

; ----------------------------------------------------------------------------
; VREG (,A val) (,Y val) (,X val) (,P val) : affiche ou modifie le contenu des
; registres du 6502
VREG:   tax                                     ; E258 AA
        beq     LE266                           ; E259 F0 0B
        jsr     EvalSetReg                      ; E25B 20 6E E2
        bcs     VREG                            ; E25E B0 F8
LE260:  jmp     SyntaxErr5                      ; E260 4C 3D D8

; ----------------------------------------------------------------------------
LE263:  jmp     OutOfRangeValErr1               ; E263 4C 43 D8

; ----------------------------------------------------------------------------
LE266:  BRK_TELEMON XCRLF                             ; E266 00 25
        jsr     DispRegs                        ; E268 20 3A C7
        jmp     LCFC8                           ; E26B 4C C8 CF

; ----------------------------------------------------------------------------
; Evalue une affectation pour un registre (A,X,Y,P), sortie: C=1 -> Ok
EvalSetReg:
        jsr     EvalComma                       ; E26E 20 AC D1
        cmp     #"A"                            ; E271 C9 41
        beq     LE283                           ; E273 F0 0E
        cmp     #"Y"                            ; E275 C9 59
        beq     LE286                           ; E277 F0 0D
        cmp     #"X"                            ; E279 C9 58
        beq     LE289                           ; E27B F0 0C
        cmp     #"P"                            ; E27D C9 50
        beq     LE28C                           ; E27F F0 0B
        clc                                     ; E281 18
        rts                                     ; E282 60

; ----------------------------------------------------------------------------
LE283:  ldy     #$04                            ; E283 A0 04
        .byte   $2C                             ; E285 2C
LE286:  ldy     #$03                            ; E286 A0 03
        .byte   $2C                             ; E288 2C
LE289:  ldy     #$02                            ; E289 A0 02
        .byte   $2C                             ; E28B 2C
LE28C:  ldy     #$01                            ; E28C A0 01
        jsr     CharGet                         ; E28E 20 E2 00
        jsr     EvalExpr                        ; E291 20 DF CE
        lda     VARAPL+15                       ; E294 A5 DF
        bne     LE263                           ; E296 D0 CB
        lda     VARAPL+14                       ; E298 A5 DE
        sta     HRS1,y                          ; E29A 99 4D 00
        jsr     CharGot                         ; E29D 20 E8 00
        sec                                     ; E2A0 38
        rts                                     ; E2A1 60

; ----------------------------------------------------------------------------
; OLD : réactive le programme source en mémoire (après un NEW)
OLD:    tax                                     ; E2A2 AA
        bne     LE260                           ; E2A3 D0 BB
        lda     SCEDEB                          ; E2A5 A5 5C
        ldy     SCEDEB+1                        ; E2A7 A4 5D
        sta     TXTPTR                          ; E2A9 85 E9
        sty     TXTPTR+1                        ; E2AB 84 EA
LE2AD:  ldy     #$03                            ; E2AD A0 03
LE2AF:  lda     (TXTPTR),y                      ; E2AF B1 E9
        beq     LE2BE                           ; E2B1 F0 0B
        iny                                     ; E2B3 C8
        bne     LE2AF                           ; E2B4 D0 F9
        ldx     #$07                            ; E2B6 A2 07
        jsr     DispErrorX                      ; E2B8 20 1B C8
        jmp     LCFCB                           ; E2BB 4C CB CF

; ----------------------------------------------------------------------------
LE2BE:  iny                                     ; E2BE C8
        tya                                     ; E2BF 98
        ldy     #$00                            ; E2C0 A0 00
        sta     (TXTPTR),y                      ; E2C2 91 E9
        tay                                     ; E2C4 A8
        jsr     IncTXTPTR                       ; E2C5 20 85 CE
        ldy     #$00                            ; E2C8 A0 00
        lda     (TXTPTR),y                      ; E2CA B1 E9
        bne     LE2AD                           ; E2CC D0 DF
        iny                                     ; E2CE C8
        jsr     IncTXTPTR                       ; E2CF 20 85 CE
        lda     TXTPTR                          ; E2D2 A5 E9
        sta     SCEFIN                          ; E2D4 85 5E
        lda     TXTPTR+1                        ; E2D6 A5 EA
        sta     SCEFIN+1                        ; E2D8 85 5F
        jsr     LocTblInit                      ; E2DA 20 73 CF
        jmp     LCFCB                           ; E2DD 4C CB CF

; ----------------------------------------------------------------------------
LE2E0:  jmp     SyntaxErr5                      ; E2E0 4C 3D D8

; ----------------------------------------------------------------------------
; CALL adrdeb (B val) (,A val) (,Y val) (,X val) (P val) : exécute la routine
; adrdeb de la banque indiquée, ou de celle par défaut, en pré-chargeant
; éventuellement les registres du 6502. Les registres peuvent aussi être
; pré-chargés
CALL:   tax                                     ; E2E3 AA
        beq     LE2E0                           ; E2E4 F0 FA
        ldx     DEFBNK                          ; E2E6 AE E0 04
        stx     BNKSAV                          ; E2E9 8E E1 04
        jsr     EvalWord                        ; E2EC 20 6A D2
        sta     VEXBNK+1                        ; E2EF 8D 15 04
        sty     VEXBNK+2                        ; E2F2 8C 16 04
        txa                                     ; E2F5 8A
LE2F6:  tax                                     ; E2F6 AA
        beq     LE307                           ; E2F7 F0 0E
        jsr     EvalSetReg                      ; E2F9 20 6E E2
        bcs     LE2F6                           ; E2FC B0 F8
        jsr     LD342                           ; E2FE 20 42 D3
        stx     BNKSAV                          ; E301 8E E1 04
        jmp     LE2F6                           ; E304 4C F6 E2

; ----------------------------------------------------------------------------
LE307:  BRK_TELEMON XCRLF                             ; E307 00 25
        jsr     DispRegs                        ; E309 20 3A C7
        lda     BNKSAV                          ; E30C AD E1 04
        sta     BNKCIB                          ; E30F 8D 17 04
        lda     HRS1+1                          ; E312 A5 4E
        pha                                     ; E314 48
        lda     HRS3                            ; E315 A5 51
        ldy     HRS2+1                          ; E317 A4 50
        ldx     HRS2                            ; E319 A6 4F
        plp                                     ; E31B 28
        jsr     EXBNK                           ; E31C 20 0C 04
        php                                     ; E31F 08
        sta     HRS3                            ; E320 85 51
        sty     HRS2+1                          ; E322 84 50
        stx     HRS2                            ; E324 86 4F
        pla                                     ; E326 68
        sta     HRS1+1                          ; E327 85 4E
        BRK_TELEMON XCRLF                             ; E329 00 25
        jsr     DispRegs                        ; E32B 20 3A C7
        jsr     LC8DC                           ; E32E 20 DC C8
        jmp     LCFCB                           ; E331 4C CB CF

; ----------------------------------------------------------------------------
; BYTES adrdeb ,val1 (,val2...) : place les valeurs val1,... en mémoire à
; partir de l'adresse adrdeb. Les valeurs sur 2 octets sont stockées en mode LSB
;,MSB (COMMANDE NON DOCUMENTEE)
BYTES:  ldx     DEFBNK                          ; E334 AE E0 04
        stx     BNKSAV                          ; E337 8E E1 04
        tax                                     ; E33A AA
        beq     LE2E0                           ; E33B F0 A3
        jsr     EvalWord                        ; E33D 20 6A D2
        sta     Proc1+9                         ; E340 8D EB 04
        sty     Proc1+10                        ; E343 8C EC 04
        txa                                     ; E346 8A
        beq     LE2E0                           ; E347 F0 97
LE349:  cmp     #","                            ; E349 C9 2C
        bne     LE37F                           ; E34B D0 32
        jsr     LD267                           ; E34D 20 67 D2
        jsr     LCCDB                           ; E350 20 DB CC
        jsr     LCCD2                           ; E353 20 D2 CC
        tya                                     ; E356 98
        beq     LE35F                           ; E357 F0 06
        jsr     LCCDB                           ; E359 20 DB CC
        jsr     LCCD2                           ; E35C 20 D2 CC
LE35F:  txa                                     ; E35F 8A
        bne     LE349                           ; E360 D0 E7
        jmp     LCFCB                           ; E362 4C CB CF

; ----------------------------------------------------------------------------
; SLIGNE : effectue un saut de ligne à chaque appui sur <RETURN>, autre touche
; arrête le processus
SLIGNE: tax                                     ; E365 AA
        bne     LE37F                           ; E366 D0 17
        dex                                     ; E368 CA
        stx     XLPRBI                          ; E369 86 48
        jsr     LCF8D                           ; E36B 20 8D CF
LE36E:  jsr     GetKey                          ; E36E 20 D1 C8
        cmp     #$0D                            ; E371 C9 0D
        beq     LE378                           ; E373 F0 03
        jmp     LCFCB                           ; E375 4C CB CF

; ----------------------------------------------------------------------------
LE378:  jsr     LCB5A                           ; E378 20 5A CB
        jmp     LE36E                           ; E37B 4C 6E E3

; ----------------------------------------------------------------------------
; DPAGE : effectue un saut de page
DPAGE:  tax                                     ; E37E AA
LE37F:  bne     LE3FF                           ; E37F D0 7E
        dex                                     ; E381 CA
        stx     XLPRBI                          ; E382 86 48
        jsr     LCF8D                           ; E384 20 8D CF
        jsr     LCB6F                           ; E387 20 6F CB
        jmp     LCFCB                           ; E38A 4C CB CF

; ----------------------------------------------------------------------------
; FPAGE (LPRFY) (,LPRSY) : affiche ou initialise le nombre de lignes par page
; (LPRFY) et le n° de ligne pour le saut de page (LPRSY)
FPAGE:  ldx     LPRFY                           ; E38D AE 89 02
        stx     INDIC2                          ; E390 86 57
        ldx     LPRSY                           ; E392 AE 8B 02
        stx     INDIC0+1                        ; E395 86 56
        tax                                     ; E397 AA
        bne     LE3CB                           ; E398 D0 31
        lda     #$7F                            ; E39A A9 7F
        BRK_TELEMON XWR0                             ; E39C 00 10
        lda     #<Fmt_str                       ; E39E A9 C6
        ldy     #>Fmt_str                       ; E3A0 A0 C6
        BRK_TELEMON XWSTR0                             ; E3A2 00 14
        lda     LPRFY                           ; E3A4 AD 89 02
        jsr     LC766                           ; E3A7 20 66 C7
        jsr     DispSpace                       ; E3AA 20 35 C7
        lda     #<Saut_str                      ; E3AD A9 CB
        ldy     #>Saut_str                      ; E3AF A0 C6
        BRK_TELEMON XWSTR0                             ; E3B1 00 14
        lda     LPRSY                           ; E3B3 AD 8B 02
        jsr     LC766                           ; E3B6 20 66 C7
        jsr     DispSpace                       ; E3B9 20 35 C7
        lda     #<Ligne_str                     ; E3BC A9 D1
        ldy     #>Ligne_str                     ; E3BE A0 C6
        BRK_TELEMON XWSTR0                             ; E3C0 00 14
        lda     LPRY                            ; E3C2 AD 87 02
        jsr     LC766                           ; E3C5 20 66 C7
        jmp     LCFC8                           ; E3C8 4C C8 CF

; ----------------------------------------------------------------------------
LE3CB:  cmp     #","                            ; E3CB C9 2C
        beq     LE3DD                           ; E3CD F0 0E
        jsr     EvalWord                        ; E3CF 20 6A D2
        bne     LE402                           ; E3D2 D0 2E
        sta     INDIC2                          ; E3D4 85 57
        txa                                     ; E3D6 8A
        beq     LE3E7                           ; E3D7 F0 0E
        cmp     #","                            ; E3D9 C9 2C
        bne     LE3FF                           ; E3DB D0 22
LE3DD:  jsr     LD267                           ; E3DD 20 67 D2
        bne     LE402                           ; E3E0 D0 20
        sta     INDIC0+1                        ; E3E2 85 56
        txa                                     ; E3E4 8A
        bne     LE3FF                           ; E3E5 D0 18
LE3E7:  lda     INDIC2                          ; E3E7 A5 57
        cmp     INDIC0+1                        ; E3E9 C5 56
        bcc     PrinterFormatErr                ; E3EB 90 18
        lda     #$00                            ; E3ED A9 00
        sta     LPRY                            ; E3EF 8D 87 02
        lda     INDIC0+1                        ; E3F2 A5 56
        sta     LPRSY                           ; E3F4 8D 8B 02
        lda     INDIC2                          ; E3F7 A5 57
        sta     LPRFY                           ; E3F9 8D 89 02
        jmp     LCFCB                           ; E3FC 4C CB CF

; ----------------------------------------------------------------------------
LE3FF:  jmp     SyntaxErr5                      ; E3FF 4C 3D D8

; ----------------------------------------------------------------------------
LE402:  jmp     OutOfRangeValErr1               ; E402 4C 43 D8

; ----------------------------------------------------------------------------
; Err $1A
PrinterFormatErr:
        ldx     #$1A                            ; E405 A2 1A
        jmp     LCF98                           ; E407 4C 98 CF

; ----------------------------------------------------------------------------
; MOVE adrdeb ,adrfin (, B val1) , adrcib (, B val2) : déplace un bloc mémoire
; de adrdeb inclus à adrfin exclus vers adrcib. Si pas de banque précisée:
; banque par défaut
MOVE:   ldx     DEFBNK                          ; E40A AE E0 04
        stx     Proc2                           ; E40D 8E F4 04
        stx     Proc2+1                         ; E410 8E F5 04
        jsr     EvalWord                        ; E413 20 6A D2
        sta     DECDEB                          ; E416 85 04
        sty     DECDEB+1                        ; E418 84 05
        cpx     #","                            ; E41A E0 2C
        bne     LE3FF                           ; E41C D0 E1
        jsr     LD267                           ; E41E 20 67 D2
        sta     DECFIN                          ; E421 85 06
        sty     DECFIN+1                        ; E423 84 07
        txa                                     ; E425 8A
        jsr     EvalComma                       ; E426 20 AC D1
        cmp     #"B"                            ; E429 C9 42
        bne     LE43A                           ; E42B D0 0D
        jsr     LD346                           ; E42D 20 46 D3
        stx     Proc2                           ; E430 8E F4 04
        cmp     #","                            ; E433 C9 2C
        bne     LE3FF                           ; E435 D0 C8
        jsr     CharGet                         ; E437 20 E2 00
LE43A:  jsr     EvalWord                        ; E43A 20 6A D2
        sta     DECCIB                          ; E43D 85 08
        sty     DECCIB+1                        ; E43F 84 09
        txa                                     ; E441 8A
        beq     LE44D                           ; E442 F0 09
        jsr     LD33F                           ; E444 20 3F D3
        stx     Proc2+1                         ; E447 8E F5 04
        tax                                     ; E44A AA
        bne     LE3FF                           ; E44B D0 B2
LE44D:  lda     Proc2                           ; E44D AD F4 04
        ldy     Proc2+1                         ; E450 AC F5 04
        sta     RES                             ; E453 85 00
        sty     RES+1                           ; E455 84 01
        jsr     LE460                           ; E457 20 60 E4
        jsr     LC8DC                           ; E45A 20 DC C8
        jmp     LCFCB                           ; E45D 4C CB CF

; ----------------------------------------------------------------------------
LE460:  pha                                     ; E460 48
        txa                                     ; E461 8A
        pha                                     ; E462 48
        tya                                     ; E463 98
        pha                                     ; E464 48
        ldy     #$1B                            ; E465 A0 1B
LE467:  lda     LE4EE,y                         ; E467 B9 EE E4
        sta     BUFTRV,y                        ; E46A 99 00 01
        dey                                     ; E46D 88
        bpl     LE467                           ; E46E 10 F7
        lda     V2DRA                           ; E470 AD 21 03
        and     #$F8                            ; E473 29 F8
        pha                                     ; E475 48
        ora     RES                             ; E476 05 00
        sta     RES                             ; E478 85 00
        pla                                     ; E47A 68
        ora     RES+1                           ; E47B 05 01
        sta     RES+1                           ; E47D 85 01
        sec                                     ; E47F 38
        lda     DECFIN                          ; E480 A5 06
        sbc     DECDEB                          ; E482 E5 04
        tay                                     ; E484 A8
        lda     DECFIN+1                        ; E485 A5 07
        sbc     DECDEB+1                        ; E487 E5 05
        tax                                     ; E489 AA
        bcc     LE4C6                           ; E48A 90 3A
        stx     DECTRV+1                        ; E48C 86 0B
        lda     DECCIB                          ; E48E A5 08
        cmp     DECDEB                          ; E490 C5 04
        lda     DECCIB+1                        ; E492 A5 09
        sbc     DECDEB+1                        ; E494 E5 05
        bcs     LE4CC                           ; E496 B0 34
        tya                                     ; E498 98
        eor     #$FF                            ; E499 49 FF
        adc     #$01                            ; E49B 69 01
        tay                                     ; E49D A8
        sta     DECTRV                          ; E49E 85 0A
        bcc     LE4A5                           ; E4A0 90 03
        dex                                     ; E4A2 CA
        inc     DECFIN+1                        ; E4A3 E6 07
LE4A5:  sec                                     ; E4A5 38
        lda     DECCIB                          ; E4A6 A5 08
        sbc     DECTRV                          ; E4A8 E5 0A
        sta     DECCIB                          ; E4AA 85 08
        bcs     LE4B0                           ; E4AC B0 02
        dec     DECCIB+1                        ; E4AE C6 09
LE4B0:  clc                                     ; E4B0 18
        lda     DECFIN+1                        ; E4B1 A5 07
        sbc     DECTRV+1                        ; E4B3 E5 0B
        sta     DECFIN+1                        ; E4B5 85 07
        inx                                     ; E4B7 E8
LE4B8:  jsr     BUFTRV                          ; E4B8 20 00 01
        iny                                     ; E4BB C8
        bne     LE4B8                           ; E4BC D0 FA
        inc     DECFIN+1                        ; E4BE E6 07
        inc     DECCIB+1                        ; E4C0 E6 09
        dex                                     ; E4C2 CA
        bne     LE4B8                           ; E4C3 D0 F3
LE4C5:  sec                                     ; E4C5 38
LE4C6:  pla                                     ; E4C6 68
        tay                                     ; E4C7 A8
        pla                                     ; E4C8 68
        tax                                     ; E4C9 AA
        pla                                     ; E4CA 68
        rts                                     ; E4CB 60

; ----------------------------------------------------------------------------
LE4CC:  txa                                     ; E4CC 8A
        clc                                     ; E4CD 18
        adc     DECDEB+1                        ; E4CE 65 05
        sta     DECDEB+1                        ; E4D0 85 05
        txa                                     ; E4D2 8A
        clc                                     ; E4D3 18
        adc     DECCIB+1                        ; E4D4 65 09
        sta     DECCIB+1                        ; E4D6 85 09
        lda     #$04                            ; E4D8 A9 04
        sta     BUFTRV+12                       ; E4DA 8D 0C 01
        inx                                     ; E4DD E8
LE4DE:  dey                                     ; E4DE 88
        jsr     BUFTRV                          ; E4DF 20 00 01
        tya                                     ; E4E2 98
        bne     LE4DE                           ; E4E3 D0 F9
        dec     DECDEB+1                        ; E4E5 C6 05
        dec     DECCIB+1                        ; E4E7 C6 09
        dex                                     ; E4E9 CA
        bne     LE4DE                           ; E4EA D0 F2
        beq     LE4C5                           ; E4EC F0 D7
LE4EE:  php                                     ; E4EE 08
        sei                                     ; E4EF 78
        lda     V2DRA                           ; E4F0 AD 21 03
        pha                                     ; E4F3 48
        lda     RES                             ; E4F4 A5 00
        sta     V2DRA                           ; E4F6 8D 21 03
        lda     (DECFIN),y                      ; E4F9 B1 06
        pha                                     ; E4FB 48
        lda     RES+1                           ; E4FC A5 01
        sta     V2DRA                           ; E4FE 8D 21 03
        pla                                     ; E501 68
        sta     (DECCIB),y                      ; E502 91 08
        pla                                     ; E504 68
        sta     V2DRA                           ; E505 8D 21 03
        plp                                     ; E508 28
        rts                                     ; E509 60

; ----------------------------------------------------------------------------
; MERGE ''NF'' : ajoute le fichier source ''NF'' à la suite du programme en
; mémoire et renumérote les lignes
MERGE:  jsr     LD182                           ; E50A 20 82 D1
        bne     FileNameErr2                    ; E50D D0 3D
        jsr     CharGot                         ; E50F 20 E8 00
        tax                                     ; E512 AA
        bne     SyntaxErr6                      ; E513 D0 3A
        lda     SCEDEB                          ; E515 A5 5C
        pha                                     ; E517 48
        sta     VARAPL+12                       ; E518 85 DC
        lda     SCEDEB+1                        ; E51A A5 5D
        pha                                     ; E51C 48
        sta     VARAPL+13                       ; E51D 85 DD
        lda     (VARAPL+12),y                   ; E51F B1 DC
        beq     LE528                           ; E521 F0 05
LE523:  jsr     LCB89                           ; E523 20 89 CB
        bcc     LE523                           ; E526 90 FB
LE528:  lda     VARAPL+12                       ; E528 A5 DC
        sta     INPIS                           ; E52A 8D 2D 05
        lda     VARAPL+13                       ; E52D A5 DD
        sta     INSEC                           ; E52F 8D 2E 05
        lda     #$80                            ; E532 A9 80
        sta     VSALO1                          ; E534 8D 29 05
        lda     #<XLOAD                         ; E537 A9 62
        ldy     #>XLOAD                         ; E539 A0 FF
        jsr     EXBNK0ERR                       ; E53B 20 5E D2
        pla                                     ; E53E 68
        sta     SCEDEB+1                        ; E53F 85 5D
        pla                                     ; E541 68
        sta     SCEDEB                          ; E542 85 5C
        jsr     LD229                           ; E544 20 29 D2
        lda     #$00                            ; E547 A9 00
        jmp     RENUM                           ; E549 4C 89 D5

; ----------------------------------------------------------------------------
; Err $09
FileNameErr2:
        ldx     #$09                            ; E54C A2 09
        .byte   $2C                             ; E54E 2C
; Err $00
SyntaxErr6:
        ldx     #$00                            ; E54F A2 00
        jmp     LCF98                           ; E551 4C 98 CF

; ----------------------------------------------------------------------------
; QWERTY : idem BASIC
QWERTY: lda     #$00                            ; E554 A9 00
        .byte   $2C                             ; E556 2C
; AZERTY : idem BASIC
AZERTY: lda     #$01                            ; E557 A9 01
        .byte   $2C                             ; E559 2C
; FRENCH : idem BASIC
FRENCH: lda     #$02                            ; E55A A9 02
        .byte   $2C                             ; E55C 2C
; ACCSET : idem BASIC
ACCSET: lda     #$04                            ; E55D A9 04
        .byte   $2C                             ; E55F 2C
; ACCOFF : idem BASIC
ACCOFF: lda     #$05                            ; E560 A9 05
        pha                                     ; E562 48
        jsr     CharGot                         ; E563 20 E8 00
        tax                                     ; E566 AA
        bne     SyntaxErr6                      ; E567 D0 E6
        pla                                     ; E569 68
        BRK_TELEMON XGOKBD                             ; E56A 00 52
        jmp     LCFCB                           ; E56C 4C CB CF

; ----------------------------------------------------------------------------
LE56F:  lda     Proc1+1                         ; E56F AD E3 04
        ldy     Proc1+2                         ; E572 AC E4 04
        jsr     PutYAHexa                       ; E575 20 CD C7
        lda     #$00                            ; E578 A9 00
        sta     BUFTRV+5                        ; E57A 8D 05 01
        ldx     #$03                            ; E57D A2 03
LE57F:  lda     BUFTRV,x                        ; E57F BD 00 01
        ora     #$80                            ; E582 09 80
        sta     BUFTRV+1,x                      ; E584 9D 01 01
        dex                                     ; E587 CA
        bpl     LE57F                           ; E588 10 F5
        lda     #$83                            ; E58A A9 83
        sta     BUFTRV                          ; E58C 8D 00 01
        ldx     #$02                            ; E58F A2 02
        jmp     LC853                           ; E591 4C 53 C8

; ----------------------------------------------------------------------------
LE594:  BRK_TELEMON XWR0                             ; E594 00 10
LE596:  lda     #$00                            ; E596 A9 00
        sta     BUFTRV+8                        ; E598 8D 08 01
        ldx     #$06                            ; E59B A2 06
LE59D:  lda     #$00                            ; E59D A9 00
        cpx     #$03                            ; E59F E0 03
        beq     LE5AD                           ; E5A1 F0 0A
        ror                                     ; E5A3 6A
        sta     VARAPL                          ; E5A4 85 D0
        lda     FLGKBD                          ; E5A6 AD 75 02
        and     #$80                            ; E5A9 29 80
        eor     VARAPL                          ; E5AB 45 D0
LE5AD:  ora     MAJ_min_str,x                   ; E5AD 1D BE C6
        sta     BUFTRV+1,x                      ; E5B0 9D 01 01
        dex                                     ; E5B3 CA
        bpl     LE59D                           ; E5B4 10 E7
        lda     #$86                            ; E5B6 A9 86
        sta     BUFTRV                          ; E5B8 8D 00 01
        ldx     #$20                            ; E5BB A2 20
        jmp     LC853                           ; E5BD 4C 53 C8

; ----------------------------------------------------------------------------
LE5C0:  stx     Ptr3                            ; E5C0 8E F2 04
        sta     Ptr3+1                          ; E5C3 8D F3 04
        stx     Proc1+1                         ; E5C6 8E E3 04
        sta     Proc1+2                         ; E5C9 8D E4 04
        lda     #$01                            ; E5CC A9 01
        ldy     #$00                            ; E5CE A0 00
        jsr     LC879                           ; E5D0 20 79 C8
LE5D3:  jsr     LD2E8                           ; E5D3 20 E8 D2
        lda     SCRY                            ; E5D6 AD 24 02
        cmp     SCRFY                           ; E5D9 CD 34 02
        beq     LE5E3                           ; E5DC F0 05
        BRK_TELEMON XCRLF                             ; E5DE 00 25
        jmp     LE5D3                           ; E5E0 4C D3 E5

; ----------------------------------------------------------------------------
LE5E3:  lda     Ptr3                            ; E5E3 AD F2 04
        sta     Ptr1                            ; E5E6 8D EE 04
        sta     Proc1+1                         ; E5E9 8D E3 04
        lda     Ptr3+1                          ; E5EC AD F3 04
        sta     Ptr1+1                          ; E5EF 8D EF 04
        sta     Proc1+2                         ; E5F2 8D E4 04
        lda     VARAPL+8                        ; E5F5 A5 D8
        sta     Ptr2                            ; E5F7 8D F0 04
        lda     VARAPL+9                        ; E5FA A5 D9
        sta     Ptr2+1                          ; E5FC 8D F1 04
        ldy     #$1F                            ; E5FF A0 1F
        bit     HRSX6                           ; E601 24 4A
        bmi     LE60B                           ; E603 30 06
        lda     #$00                            ; E605 A9 00
        sta     HRSX6                           ; E607 85 4A
        ldy     #$06                            ; E609 A0 06
LE60B:  lda     #$01                            ; E60B A9 01
        jsr     LC879                           ; E60D 20 79 C8
LE610:  lda     #$02                            ; E610 A9 02
        .byte   $2C                             ; E612 2C
LE613:  lda     #$20                            ; E613 A9 20
        ldy     #$05                            ; E615 A0 05
        sta     (ADSCR),y                       ; E617 91 26
        rts                                     ; E619 60

; ----------------------------------------------------------------------------
LE61A:  lda     HRSX6                           ; E61A A5 4A
        eor     #$80                            ; E61C 49 80
        and     #$80                            ; E61E 29 80
        sta     HRSX6                           ; E620 85 4A
        bmi     LE634                           ; E622 30 10
        lda     FLGKBD                          ; E624 AD 75 02
        ora     #$80                            ; E627 09 80
        sta     FLGKBD                          ; E629 8D 75 02
        lda     FLGSCR                          ; E62C AD 48 02
        and     #$DF                            ; E62F 29 DF
        sta     FLGSCR                          ; E631 8D 48 02
LE634:  jsr     LE596                           ; E634 20 96 E5
LE637:  pha                                     ; E637 48
        lda     SCRX                            ; E638 AD 20 02
        cmp     #$1E                            ; E63B C9 1E
        bcs     LE65D                           ; E63D B0 1E
        sec                                     ; E63F 38
        sbc     #$06                            ; E640 E9 06
        sta     VARAPL                          ; E642 85 D0
        ldx     #$08                            ; E644 A2 08
        lda     #$00                            ; E646 A9 00
LE648:  asl     VARAPL                          ; E648 06 D0
        rol                                     ; E64A 2A
        cmp     #$03                            ; E64B C9 03
        bcc     LE653                           ; E64D 90 04
        sbc     #$03                            ; E64F E9 03
        inc     VARAPL                          ; E651 E6 D0
LE653:  dex                                     ; E653 CA
        bne     LE648                           ; E654 D0 F2
        clc                                     ; E656 18
        lda     VARAPL                          ; E657 A5 D0
        adc     #$1F                            ; E659 69 1F
        bcc     LE666                           ; E65B 90 09
LE65D:  sbc     #$1F                            ; E65D E9 1F
        sta     VARAPL                          ; E65F 85 D0
        asl                                     ; E661 0A
        adc     VARAPL                          ; E662 65 D0
        adc     #$06                            ; E664 69 06
LE666:  tay                                     ; E666 A8
        lda     SCRY                            ; E667 AD 24 02
        jsr     LC879                           ; E66A 20 79 C8
        pla                                     ; E66D 68
        rts                                     ; E66E 60

; ----------------------------------------------------------------------------
LE66F:  lda     #HT                             ; E66F A9 09
LE671:  BRK_TELEMON XWR0                             ; E671 00 10
        bit     HRSX6                           ; E673 24 4A
        bpl     LE683                           ; E675 10 0C
        jsr     LCC53                           ; E677 20 53 CC
        lda     SCRX                            ; E67A AD 20 02
        cmp     SCRFX                           ; E67D CD 2C 02
        beq     LE69A                           ; E680 F0 18
LE682:  rts                                     ; E682 60

; ----------------------------------------------------------------------------
LE683:  bvc     LE68F                           ; E683 50 0A
        jsr     LCC53                           ; E685 20 53 CC
        lda     #HT                             ; E688 A9 09
        BRK_TELEMON XWR0                             ; E68A 00 10
        lda     #$00                            ; E68C A9 00
        .byte   $2C                             ; E68E 2C
LE68F:  lda     #$40                            ; E68F A9 40
        sta     HRSX6                           ; E691 85 4A
        lda     SCRX                            ; E693 AD 20 02
        cmp     #$1D                            ; E696 C9 1D
        bcc     LE682                           ; E698 90 E8
LE69A:  jsr     LE6A0                           ; E69A 20 A0 E6
        jmp     LE6BE                           ; E69D 4C BE E6

; ----------------------------------------------------------------------------
LE6A0:  lda     Ptr3                            ; E6A0 AD F2 04
        sta     Proc1+1                         ; E6A3 8D E3 04
        lda     Ptr3+1                          ; E6A6 AD F3 04
        sta     Proc1+2                         ; E6A9 8D E4 04
        ldy     #$1F                            ; E6AC A0 1F
        bit     HRSX6                           ; E6AE 24 4A
        bmi     LE6B8                           ; E6B0 30 06
        lda     #$00                            ; E6B2 A9 00
        sta     HRSX6                           ; E6B4 85 4A
        ldy     #$06                            ; E6B6 A0 06
LE6B8:  lda     SCRY                            ; E6B8 AD 24 02
        jmp     LC879                           ; E6BB 4C 79 C8

; ----------------------------------------------------------------------------
LE6BE:  lda     SCRX                            ; E6BE AD 20 02
        pha                                     ; E6C1 48
        lda     SCRY                            ; E6C2 AD 24 02
        cmp     SCRFY                           ; E6C5 CD 34 02
        php                                     ; E6C8 08
        clc                                     ; E6C9 18
        lda     Ptr3                            ; E6CA AD F2 04
        adc     #$08                            ; E6CD 69 08
        sta     Ptr3                            ; E6CF 8D F2 04
        bcc     LE6D7                           ; E6D2 90 03
        inc     Ptr3+1                          ; E6D4 EE F3 04
LE6D7:  clc                                     ; E6D7 18
        lda     Proc1+1                         ; E6D8 AD E3 04
        adc     #$08                            ; E6DB 69 08
        sta     Proc1+1                         ; E6DD 8D E3 04
        bcc     LE6E5                           ; E6E0 90 03
        inc     Proc1+2                         ; E6E2 EE E4 04
LE6E5:  jsr     LE613                           ; E6E5 20 13 E6
        lda     #$0A                            ; E6E8 A9 0A
        BRK_TELEMON XWR0                             ; E6EA 00 10
        jsr     LE610                           ; E6EC 20 10 E6
        plp                                     ; E6EF 28
        beq     LE6F4                           ; E6F0 F0 02
        pla                                     ; E6F2 68
        rts                                     ; E6F3 60

; ----------------------------------------------------------------------------
LE6F4:  jsr     LE7C2                           ; E6F4 20 C2 E7
        lda     Ptr3                            ; E6F7 AD F2 04
        sta     Ptr2                            ; E6FA 8D F0 04
        lda     Ptr3+1                          ; E6FD AD F3 04
        sta     Ptr2+1                          ; E700 8D F1 04
        clc                                     ; E703 18
        lda     Ptr1                            ; E704 AD EE 04
        adc     #$08                            ; E707 69 08
        sta     Ptr1                            ; E709 8D EE 04
        bcc     LE711                           ; E70C 90 03
        inc     Ptr1+1                          ; E70E EE EF 04
LE711:  pla                                     ; E711 68
        tay                                     ; E712 A8
        lda     SCRY                            ; E713 AD 24 02
        jmp     LC879                           ; E716 4C 79 C8

; ----------------------------------------------------------------------------
LE719:  lda     #BS                             ; E719 A9 08
        BRK_TELEMON XWR0                             ; E71B 00 10
        bit     HRSX6                           ; E71D 24 4A
        bpl     LE72C                           ; E71F 10 0B
        jsr     LCC45                           ; E721 20 45 CC
        lda     SCRX                            ; E724 AD 20 02
        cmp     #$1E                            ; E727 C9 1E
        beq     LE743                           ; E729 F0 18
LE72B:  rts                                     ; E72B 60

; ----------------------------------------------------------------------------
LE72C:  bvs     LE738                           ; E72C 70 0A
        jsr     LCC45                           ; E72E 20 45 CC
        lda     #BS                             ; E731 A9 08
        BRK_TELEMON XWR0                             ; E733 00 10
        lda     #$40                            ; E735 A9 40
        .byte   $2C                             ; E737 2C
LE738:  lda     #$00                            ; E738 A9 00
        sta     HRSX6                           ; E73A 85 4A
        lda     SCRX                            ; E73C AD 20 02
        cmp     #$06                            ; E73F C9 06
        bcs     LE72B                           ; E741 B0 E8
LE743:  jsr     LE749                           ; E743 20 49 E7
        jmp     LE769                           ; E746 4C 69 E7

; ----------------------------------------------------------------------------
LE749:  clc                                     ; E749 18
        lda     Ptr3                            ; E74A AD F2 04
        adc     #$07                            ; E74D 69 07
        sta     Proc1+1                         ; E74F 8D E3 04
        bcc     LE757                           ; E752 90 03
        inc     Proc1+2                         ; E754 EE E4 04
LE757:  ldy     #$26                            ; E757 A0 26
        bit     HRSX6                           ; E759 24 4A
        bmi     LE763                           ; E75B 30 06
        lda     #$40                            ; E75D A9 40
        sta     HRSX6                           ; E75F 85 4A
        ldy     #$1C                            ; E761 A0 1C
LE763:  lda     SCRY                            ; E763 AD 24 02
        jmp     LC879                           ; E766 4C 79 C8

; ----------------------------------------------------------------------------
LE769:  lda     SCRX                            ; E769 AD 20 02
        pha                                     ; E76C 48
        lda     SCRY                            ; E76D AD 24 02
        cmp     SCRDY                           ; E770 CD 30 02
        php                                     ; E773 08
        sec                                     ; E774 38
        lda     Ptr3                            ; E775 AD F2 04
        sbc     #$08                            ; E778 E9 08
        sta     Ptr3                            ; E77A 8D F2 04
        bcs     LE782                           ; E77D B0 03
        dec     Ptr3+1                          ; E77F CE F3 04
LE782:  sec                                     ; E782 38
        lda     Proc1+1                         ; E783 AD E3 04
        sbc     #$08                            ; E786 E9 08
        sta     Proc1+1                         ; E788 8D E3 04
        bcs     LE790                           ; E78B B0 03
        dec     Proc1+2                         ; E78D CE E4 04
LE790:  jsr     LE613                           ; E790 20 13 E6
        lda     #VT                             ; E793 A9 0B
        BRK_TELEMON XWR0                             ; E795 00 10
        jsr     LE610                           ; E797 20 10 E6
        plp                                     ; E79A 28
        beq     LE7A2                           ; E79B F0 05
        pla                                     ; E79D 68
        jsr     LE610                           ; E79E 20 10 E6
        rts                                     ; E7A1 60

; ----------------------------------------------------------------------------
LE7A2:  jsr     LE7C2                           ; E7A2 20 C2 E7
        lda     Ptr3                            ; E7A5 AD F2 04
        ldy     Ptr3+1                          ; E7A8 AC F3 04
        sta     Ptr1                            ; E7AB 8D EE 04
        sty     Ptr1+1                          ; E7AE 8C EF 04
        sec                                     ; E7B1 38
        lda     Ptr2                            ; E7B2 AD F0 04
        sbc     #$08                            ; E7B5 E9 08
        sta     Ptr2                            ; E7B7 8D F0 04
        bcs     LE7BF                           ; E7BA B0 03
        dec     Ptr2+1                          ; E7BC CE F1 04
LE7BF:  jmp     LE711                           ; E7BF 4C 11 E7

; ----------------------------------------------------------------------------
LE7C2:  lda     Proc1+1                         ; E7C2 AD E3 04
        pha                                     ; E7C5 48
        lda     Proc1+2                         ; E7C6 AD E4 04
        pha                                     ; E7C9 48
        lda     Ptr3                            ; E7CA AD F2 04
        ldy     Ptr3+1                          ; E7CD AC F3 04
        sta     Proc1+1                         ; E7D0 8D E3 04
        sty     Proc1+2                         ; E7D3 8C E4 04
        jsr     LD2E8                           ; E7D6 20 E8 D2
        pla                                     ; E7D9 68
        sta     Proc1+2                         ; E7DA 8D E4 04
        pla                                     ; E7DD 68
        sta     Proc1+1                         ; E7DE 8D E3 04
        jsr     LE610                           ; E7E1 20 10 E6
        rts                                     ; E7E4 60

; ----------------------------------------------------------------------------
LE7E5:  jmp     SyntaxErr5                      ; E7E5 4C 3D D8

; ----------------------------------------------------------------------------
; MODIF adrdeb (,B val) : modification pleine page de la mémoire à partir de
; l'adresse adrdeb de la banque indiquée ou celle par défaut
MODIF:  ldx     DEFBNK                          ; E7E8 AE E0 04
        stx     BNKSAV                          ; E7EB 8E E1 04
        jsr     EvalWord                        ; E7EE 20 6A D2
        sta     Ptr3                            ; E7F1 8D F2 04
        sty     Ptr3+1                          ; E7F4 8C F3 04
        txa                                     ; E7F7 8A
        beq     LE803                           ; E7F8 F0 09
        jsr     LD33F                           ; E7FA 20 3F D3
        stx     BNKSAV                          ; E7FD 8E E1 04
        tax                                     ; E800 AA
        bne     LE7E5                           ; E801 D0 E2
LE803:  lda     #FF                             ; E803 A9 0C
        BRK_TELEMON XWR0                             ; E805 00 10
LE807:  lda     #$00                            ; E807 A9 00
        sta     HRSX6                           ; E809 85 4A
        lda     FLGKBD                          ; E80B AD 75 02
        ora     #$80                            ; E80E 09 80
        sta     FLGKBD                          ; E810 8D 75 02
        jsr     LE596                           ; E813 20 96 E5
        ldx     Ptr3                            ; E816 AE F2 04
        lda     Ptr3+1                          ; E819 AD F3 04
LE81C:  jsr     LE5C0                           ; E81C 20 C0 E5
LE81F:  jsr     LE56F                           ; E81F 20 6F E5
LE822:  jsr     GetKey                          ; E822 20 D1 C8
        cmp     #" "                            ; E825 C9 20
        bcs     LE82C                           ; E827 B0 03
        jmp     LE8B0                           ; E829 4C B0 E8

; ----------------------------------------------------------------------------
LE82C:  bit     HRSX6                           ; E82C 24 4A
        bpl     LE862                           ; E82E 10 32
        jsr     LCC71                           ; E830 20 71 CC
        jsr     LCC5B                           ; E833 20 5B CC
        jsr     LE637                           ; E836 20 37 E6
        pha                                     ; E839 48
        lda     FLGSCR                          ; E83A AD 48 02
        tax                                     ; E83D AA
        and     #$DF                            ; E83E 29 DF
        sta     FLGSCR                          ; E840 8D 48 02
        txa                                     ; E843 8A
        asl                                     ; E844 0A
        asl                                     ; E845 0A
        and     #$80                            ; E846 29 80
        sta     VARAPL+1                        ; E848 85 D1
        pla                                     ; E84A 68
        pha                                     ; E84B 48
        ora     VARAPL+1                        ; E84C 05 D1
        jsr     DispByte                        ; E84E 20 92 C7
        stx     FLGSCR                          ; E851 8E 48 02
        lda     #BS                             ; E854 A9 08
        BRK_TELEMON XWR0                             ; E856 00 10
        pla                                     ; E858 68
        jsr     LE637                           ; E859 20 37 E6
        jsr     LE671                           ; E85C 20 71 E6
        jmp     LE81F                           ; E85F 4C 1F E8

; ----------------------------------------------------------------------------
LE862:  jsr     LCD6E                           ; E862 20 6E CD
        bcs     LE8AB                           ; E865 B0 44
        and     #$0F                            ; E867 29 0F
        bit     HRSX6                           ; E869 24 4A
        bvs     LE871                           ; E86B 70 04
        asl                                     ; E86D 0A
        asl                                     ; E86E 0A
        asl                                     ; E86F 0A
        asl                                     ; E870 0A
LE871:  sta     VARAPL                          ; E871 85 D0
        jsr     LCC5B                           ; E873 20 5B CC
        bit     HRSX6                           ; E876 24 4A
        bvc     LE87D                           ; E878 50 03
        and     #$F0                            ; E87A 29 F0
        .byte   $2C                             ; E87C 2C
LE87D:  and     #$0F                            ; E87D 29 0F
        ora     VARAPL                          ; E87F 05 D0
        jsr     LCC71                           ; E881 20 71 CC
        jsr     LCC5B                           ; E884 20 5B CC
        jsr     LE637                           ; E887 20 37 E6
        jsr     LC716                           ; E88A 20 16 C7
        pha                                     ; E88D 48
        lda     #BS                             ; E88E A9 08
        BRK_TELEMON XWR0                             ; E890 00 10
        pla                                     ; E892 68
        jsr     LE637                           ; E893 20 37 E6
        jsr     DispByte                        ; E896 20 92 C7
        lda     #BS                             ; E899 A9 08
        BRK_TELEMON XWR0                             ; E89B 00 10
        bit     HRSX6                           ; E89D 24 4A
        bvs     LE8A5                           ; E89F 70 04
        lda     #BS                             ; E8A1 A9 08
        BRK_TELEMON XWR0                             ; E8A3 00 10
LE8A5:  jsr     LE66F                           ; E8A5 20 6F E6
        jmp     LE81F                           ; E8A8 4C 1F E8

; ----------------------------------------------------------------------------
LE8AB:  BRK_TELEMON XOUPS                             ; E8AB 00 42
        jmp     LE822                           ; E8AD 4C 22 E8

; ----------------------------------------------------------------------------
LE8B0:  lsr     KBDSHT                          ; E8B0 4E 78 02
        bcc     LE8FB                           ; E8B3 90 46
        cmp     #LF                             ; E8B5 C9 0A
        bne     LE8C8                           ; E8B7 D0 0F
        clc                                     ; E8B9 18
        lda     Ptr2                            ; E8BA AD F0 04
        adc     #$08                            ; E8BD 69 08
        tax                                     ; E8BF AA
        lda     Ptr2+1                          ; E8C0 AD F1 04
        adc     #$00                            ; E8C3 69 00
        jmp     LE81C                           ; E8C5 4C 1C E8

; ----------------------------------------------------------------------------
LE8C8:  cmp     #VT                             ; E8C8 C9 0B
        bne     LE8DA                           ; E8CA D0 0E
        lda     Ptr1                            ; E8CC AD EE 04
        sbc     #$D8                            ; E8CF E9 D8
        tax                                     ; E8D1 AA
        lda     Ptr1+1                          ; E8D2 AD EF 04
        sbc     #$00                            ; E8D5 E9 00
        jmp     LE81C                           ; E8D7 4C 1C E8

; ----------------------------------------------------------------------------
LE8DA:  cmp     #BS                             ; E8DA C9 08
        bne     LE8E4                           ; E8DC D0 06
        jsr     LE6A0                           ; E8DE 20 A0 E6
        jmp     LE81F                           ; E8E1 4C 1F E8

; ----------------------------------------------------------------------------
LE8E4:  cmp     #HT                             ; E8E4 C9 09
        bne     LE8EE                           ; E8E6 D0 06
        jsr     LE749                           ; E8E8 20 49 E7
        jmp     LE81F                           ; E8EB 4C 1F E8

; ----------------------------------------------------------------------------
LE8EE:  cmp     #CR                             ; E8EE C9 0D
        bne     LE8AB                           ; E8F0 D0 B9
        jsr     LE6A0                           ; E8F2 20 A0 E6
        jsr     LE769                           ; E8F5 20 69 E7
        jmp     LE81F                           ; E8F8 4C 1F E8

; ----------------------------------------------------------------------------
LE8FB:  cmp     #HT                             ; E8FB C9 09
        bne     LE905                           ; E8FD D0 06
        jsr     LE66F                           ; E8FF 20 6F E6
        jmp     LE81F                           ; E902 4C 1F E8

; ----------------------------------------------------------------------------
LE905:  cmp     #BS                             ; E905 C9 08
        bne     LE90F                           ; E907 D0 06
        jsr     LE719                           ; E909 20 19 E7
        jmp     LE81F                           ; E90C 4C 1F E8

; ----------------------------------------------------------------------------
LE90F:  cmp     #VT                             ; E90F C9 0B
        bne     LE919                           ; E911 D0 06
        jsr     LE769                           ; E913 20 69 E7
        jmp     LE81F                           ; E916 4C 1F E8

; ----------------------------------------------------------------------------
LE919:  cmp     #LF                             ; E919 C9 0A
        bne     LE923                           ; E91B D0 06
        jsr     LE6BE                           ; E91D 20 BE E6
        jmp     LE81F                           ; E920 4C 1F E8

; ----------------------------------------------------------------------------
LE923:  cmp     #CR                             ; E923 C9 0D
        bne     LE930                           ; E925 D0 09
        jsr     LE6A0                           ; E927 20 A0 E6
        jsr     LE6BE                           ; E92A 20 BE E6
        jmp     LE81F                           ; E92D 4C 1F E8

; ----------------------------------------------------------------------------
LE930:  cmp     #CTRL_A                            ; E930 C9 01
        bne     LE93A                           ; E932 D0 06
        jsr     LE61A                           ; E934 20 1A E6
        jmp     LE822                           ; E937 4C 22 E8

; ----------------------------------------------------------------------------
LE93A:  cmp     #CTRL_V                            ; E93A C9 16
        bne     LE943                           ; E93C D0 05
        BRK_TELEMON XWR0                             ; E93E 00 10
        jmp     LE822                           ; E940 4C 22 E8

; ----------------------------------------------------------------------------
LE943:  cmp     #CTRL_T                            ; E943 C9 14
        bne     LE94D                           ; E945 D0 06
        jsr     LE594                           ; E947 20 94 E5
        jmp     LE822                           ; E94A 4C 22 E8

; ----------------------------------------------------------------------------
LE94D:  cmp     #CTRL_L                            ; E94D C9 0C
        bne     LE95A                           ; E94F D0 09
        ldx     Ptr1                            ; E951 AE EE 04
        lda     Ptr1+1                          ; E954 AD EF 04
        jmp     LE81C                           ; E957 4C 1C E8

; ----------------------------------------------------------------------------
LE95A:  cmp     #CTRL_B                            ; E95A C9 02
        bne     LE991                           ; E95C D0 33
        ldy     #$17                            ; E95E A0 17
        lda     #$00                            ; E960 A9 00
        jsr     LC879                           ; E962 20 79 C8
LE965:  jsr     GetKey                          ; E965 20 D1 C8
        cmp     #ESC                            ; E968 C9 1B
        beq     LE991                           ; E96A F0 25
        cmp     #"0"                            ; E96C C9 30
        bcc     LE965                           ; E96E 90 F5
        pha                                     ; E970 48
        BRK_TELEMON XWR0                             ; E971 00 10
        lda     #BS                             ; E973 A9 08
        BRK_TELEMON XWR0                             ; E975 00 10
        pla                                     ; E977 68
        sec                                     ; E978 38
        sbc     #$30                            ; E979 E9 30
        cmp     #$08                            ; E97B C9 08
        bcs     LE965                           ; E97D B0 E6
        sta     BNKSAV                          ; E97F 8D E1 04
        lda     Ptr1                            ; E982 AD EE 04
        sta     Ptr3                            ; E985 8D F2 04
        lda     Ptr1+1                          ; E988 AD EF 04
        sta     Ptr3+1                          ; E98B 8D F3 04
        jmp     LE807                           ; E98E 4C 07 E8

; ----------------------------------------------------------------------------
LE991:  cmp     #CTRL_C                            ; E991 C9 03
        beq     LE99C                           ; E993 F0 07
        cmp     #ESC                            ; E995 C9 1B
        beq     LE99C                           ; E997 F0 03
        jmp     LE8AB                           ; E999 4C AB E8

; ----------------------------------------------------------------------------
LE99C:  jsr     LC8DC                           ; E99C 20 DC C8
        lda     SCRFY                           ; E99F AD 34 02
        ldy     #$00                            ; E9A2 A0 00
        jsr     LC879                           ; E9A4 20 79 C8
        jmp     LCFC8                           ; E9A7 4C C8 CF

; ----------------------------------------------------------------------------
LE9AA:  lda     #<Pile_str                      ; E9AA A9 AF
        ldy     #>Pile_str                      ; E9AC A0 C6
        ldx     #$21                            ; E9AE A2 21
        jsr     LC857                           ; E9B0 20 57 C8
        lda     #FF                             ; E9B3 A9 0C
        BRK_TELEMON XWR0                             ; E9B5 00 10
        lda     #<Scr0InitTbl                  ; E9B7 A9 E8
        ldy     #>Scr0InitTbl                  ; E9B9 A0 E9
        ldx     #$00                            ; E9BB A2 00
        BRK_TELEMON XSCRSE                             ; E9BD 00 36
        lda     #<Scr1InitTbl                  ; E9BF A9 EE
        ldy     #>Scr1InitTbl                  ; E9C1 A0 E9
        ldx     #$01                            ; E9C3 A2 01
        BRK_TELEMON XSCRSE                             ; E9C5 00 36
        lda     #<Scr2InitTbl                  ; E9C7 A9 F4
        ldy     #>Scr2InitTbl                  ; E9C9 A0 E9
        ldx     #$02                            ; E9CB A2 02
        BRK_TELEMON XSCRSE                             ; E9CD 00 36
        lda     #XSCR                           ; E9CF A9 88
        BRK_TELEMON XOP0                             ; E9D1 00 00
        lda     #XSC1                           ; E9D3 A9 89
        BRK_TELEMON XOP1                             ; E9D5 00 01
        lda     #XSC2                           ; E9D7 A9 8A
        BRK_TELEMON XOP2                             ; E9D9 00 02
        ldx     #$00                            ; E9DB A2 00
        BRK_TELEMON XCOSCR                             ; E9DD 00 34
        ldx     #$01                            ; E9DF A2 01
        BRK_TELEMON XCOSCR                             ; E9E1 00 34
        ldx     #$02                            ; E9E3 A2 02
        BRK_TELEMON XCOSCR                             ; E9E5 00 34
        rts                                     ; E9E7 60

; ----------------------------------------------------------------------------
; Table d'initialisation écran 0
Scr0InitTbl:
        .byte   $00                             ; E9E8 00
        .byte   $1D                             ; E9E9 1D
        .byte   $01                             ; E9EA 01
        .byte   $17                             ; E9EB 17
        .byte   $80                             ; E9EC 80
        .byte   $BB                             ; E9ED BB
; Table d'initialisation écran 1
Scr1InitTbl:
        .byte   $07                             ; E9EE 07
        .byte   $1D                             ; E9EF 1D
        .byte   $19                             ; E9F0 19
        .byte   $1B                             ; E9F1 1B
        .byte   $80                             ; E9F2 80
        .byte   $BB                             ; E9F3 BB
; Table d'initialisation écran 2
Scr2InitTbl:
        .byte   $1F                             ; E9F4 1F
        .byte   $27                             ; E9F5 27
        .byte   $01                             ; E9F6 01
        .byte   $1B                             ; E9F7 1B
        .byte   $80                             ; E9F8 80
        .byte   $BB                             ; E9F9 BB
; Table d'initialisation écran 0 bis
Scr0bInitTbl:
        .byte   $00                             ; E9FA 00
        .byte   $27                             ; E9FB 27
        .byte   $01                             ; E9FC 01
        .byte   $1B                             ; E9FD 1B
        .byte   $80                             ; E9FE 80
        .byte   $BB                             ; E9FF BB
; Trouver un meilleur nom
Table1: .byte   $07                             ; EA00 07
        .byte   $04                             ; EA01 04
        .byte   $02                             ; EA02 02
LEA03:  ldy     #$05                            ; EA03 A0 05
LEA05:  lda     LEA0F,y                         ; EA05 B9 0F EA
        sta     Proc2,y                         ; EA08 99 F4 04
        dey                                     ; EA0B 88
        bpl     LEA05                           ; EA0C 10 F7
        rts                                     ; EA0E 60

; ----------------------------------------------------------------------------
LEA0F:  beq     LEA13                           ; EA0F F0 02
        clc                                     ; EA11 18
        rts                                     ; EA12 60

; ----------------------------------------------------------------------------
LEA13:  sec                                     ; EA13 38
        rts                                     ; EA14 60

; ----------------------------------------------------------------------------
; TRACE adrdeb (,S adrstop) (,E) (,H) (,N) (,A val) (...) (,B val) : exécute
; une routine en mode trace
TRACE:  jsr     LEA03                           ; EA15 20 03 EA
        ldx     #$40                            ; EA18 A2 40
        stx     Ptr3                            ; EA1A 8E F2 04
        stx     XLPRBI                          ; EA1D 86 48
        ldx     DEFBNK                          ; EA1F AE E0 04
        stx     BNKSAV                          ; EA22 8E E1 04
        ldx     #$FE                            ; EA25 A2 FE
        txs                                     ; EA27 9A
        stx     HRS1                            ; EA28 86 4D
        inx                                     ; EA2A E8
        stx     Ptr2                            ; EA2B 8E F0 04
        stx     Ptr2+1                          ; EA2E 8E F1 04
        jsr     EvalWord                        ; EA31 20 6A D2
        sta     Proc1+1                         ; EA34 8D E3 04
        sty     Proc1+2                         ; EA37 8C E4 04
LEA3A:  txa                                     ; EA3A 8A
LEA3B:  tax                                     ; EA3B AA
        beq     LEA7C                           ; EA3C F0 3E
        jsr     EvalSetReg                      ; EA3E 20 6E E2
        bcs     LEA3B                           ; EA41 B0 F8
        cmp     #"S"                            ; EA43 C9 53
        bne     LEA53                           ; EA45 D0 0C
        jsr     LD267                           ; EA47 20 67 D2
        sta     Ptr2                            ; EA4A 8D F0 04
        sty     Ptr2+1                          ; EA4D 8C F1 04
        jmp     LEA3A                           ; EA50 4C 3A EA

; ----------------------------------------------------------------------------
LEA53:  cmp     #"E"                            ; EA53 C9 45
        bne     LEA60                           ; EA55 D0 09
        ror     Ptr3                            ; EA57 6E F2 04
LEA5A:  jsr     CharGet                         ; EA5A 20 E2 00
        jmp     LEA3B                           ; EA5D 4C 3B EA

; ----------------------------------------------------------------------------
LEA60:  cmp     #"H"                            ; EA60 C9 48
        bne     LEA6B                           ; EA62 D0 07
        lda     #$00                            ; EA64 A9 00
        sta     Ptr3                            ; EA66 8D F2 04
        beq     LEA5A                           ; EA69 F0 EF
LEA6B:  cmp     #"N"                            ; EA6B C9 4E
        bne     LEA73                           ; EA6D D0 04
        ror     XLPRBI                          ; EA6F 66 48
        bmi     LEA5A                           ; EA71 30 E7
LEA73:  jsr     LD342                           ; EA73 20 42 D3
        stx     BNKSAV                          ; EA76 8E E1 04
        jmp     LEA3B                           ; EA79 4C 3B EA

; ----------------------------------------------------------------------------
LEA7C:  jsr     LECD7                           ; EA7C 20 D7 EC
        lda     Ptr3                            ; EA7F AD F2 04
        ora     XLPRBI                          ; EA82 05 48
        bmi     LEA89                           ; EA84 30 03
        jsr     LE9AA                           ; EA86 20 AA E9
LEA89:  jsr     LCC92                           ; EA89 20 92 CC
        bcs     LEAA0                           ; EA8C B0 12
LEA8E:  bit     Ptr3                            ; EA8E 2C F2 04
        php                                     ; EA91 08
        lda     #$00                            ; EA92 A9 00
        sta     Ptr3                            ; EA94 8D F2 04
        plp                                     ; EA97 28
        bpl     LEA9D                           ; EA98 10 03
        jsr     LE9AA                           ; EA9A 20 AA E9
LEA9D:  jsr     LECD7                           ; EA9D 20 D7 EC
LEAA0:  jsr     LC8B4                           ; EAA0 20 B4 C8
        bcs     LEA8E                           ; EAA3 B0 E9
        bit     Ptr3                            ; EAA5 2C F2 04
        bpl     LEABE                           ; EAA8 10 14
        jsr     LCC5B                           ; EAAA 20 5B CC
        jsr     DecodeOpc                       ; EAAD 20 64 CA
        ldy     #$00                            ; EAB0 A0 00
LEAB2:  dex                                     ; EAB2 CA
        bmi     LEAE0                           ; EAB3 30 2B
        jsr     LCC53                           ; EAB5 20 53 CC
        sta     HRS4,y                          ; EAB8 99 53 00
        iny                                     ; EABB C8
        bne     LEAB2                           ; EABC D0 F4
LEABE:  jsr     LECF3                           ; EABE 20 F3 EC
        lda     Ptr3                            ; EAC1 AD F2 04
        bne     LEAE0                           ; EAC4 D0 1A
        cli                                     ; EAC6 58
LEAC7:  jsr     GetKey                          ; EAC7 20 D1 C8
        cmp     #" "                            ; EACA C9 20
        beq     LEAE0                           ; EACC F0 12
        cmp     #$1B                            ; EACE C9 1B
        beq     LEB3A                           ; EAD0 F0 68
        cmp     #$03                            ; EAD2 C9 03
        beq     LEB3A                           ; EAD4 F0 64
        cmp     #CR                             ; EAD6 C9 0D
        bne     LEAC7                           ; EAD8 D0 ED
        lda     HRS3+1                          ; EADA A5 52
        cmp     #" "                            ; EADC C9 20
        beq     LEAF6                           ; EADE F0 16
LEAE0:  lda     HRS3+1                          ; EAE0 A5 52
        beq     LEAF6                           ; EAE2 F0 12
        lda     INDIC0                          ; EAE4 A5 55
        cmp     #$C1                            ; EAE6 C9 C1
        bne     LEAF1                           ; EAE8 D0 07
        jsr     LEB5F                           ; EAEA 20 5F EB
        bcs     LEA89                           ; EAED B0 9A
        bcc     LEB34                           ; EAEF 90 43
LEAF1:  jsr     TraceJMP                        ; EAF1 20 79 EB
        bcs     LEA89                           ; EAF4 B0 93
LEAF6:  lda     #$EA                            ; EAF6 A9 EA
        sta     Proc1+9                         ; EAF8 8D EB 04
        sta     Proc1+10                        ; EAFB 8D EC 04
        ldx     INDIC0+1                        ; EAFE A6 56
LEB00:  lda     HRS3+1,x                        ; EB00 B5 52
        sta     Proc1+8,x                       ; EB02 9D EA 04
        dex                                     ; EB05 CA
        bpl     LEB00                           ; EB06 10 F8
        lda     BNKSAV                          ; EB08 AD E1 04
        sta     BNKCIB                          ; EB0B 8D 17 04
        lda     #$EA                            ; EB0E A9 EA
        sta     VEXBNK+1                        ; EB10 8D 15 04
        lda     #$04                            ; EB13 A9 04
        sta     VEXBNK+2                        ; EB15 8D 16 04
        lda     HRS1+1                          ; EB18 A5 4E
        pha                                     ; EB1A 48
        lda     HRS3                            ; EB1B A5 51
        ldy     HRS2+1                          ; EB1D A4 50
        ldx     HRS2                            ; EB1F A6 4F
        plp                                     ; EB21 28
        jsr     EXBNK                           ; EB22 20 0C 04
        php                                     ; EB25 08
        sta     HRS3                            ; EB26 85 51
        sty     HRS2+1                          ; EB28 84 50
        stx     HRS2                            ; EB2A 86 4F
        pla                                     ; EB2C 68
        sta     HRS1+1                          ; EB2D 85 4E
        tsx                                     ; EB2F BA
        stx     HRS1                            ; EB30 86 4D
        cli                                     ; EB32 58
        cld                                     ; EB33 D8
LEB34:  jsr     LCC53                           ; EB34 20 53 CC
        jmp     LEA89                           ; EB37 4C 89 EA

; ----------------------------------------------------------------------------
LEB3A:  bit     Ptr3                            ; EB3A 2C F2 04
        bpl     LEB44                           ; EB3D 10 05
        BRK_TELEMON XCRLF                             ; EB3F 00 25
        jsr     DispRegs                        ; EB41 20 3A C7
LEB44:  jsr     LCF36                           ; EB44 20 36 CF
        cli                                     ; EB47 58
        cld                                     ; EB48 D8
        lda     Ptr3                            ; EB49 AD F2 04
        beq     LEB51                           ; EB4C F0 03
        jsr     GetKey                          ; EB4E 20 D1 C8
LEB51:  lda     #<Scr0bInitTbl                 ; EB51 A9 FA
        ldy     #>Scr0bInitTbl                 ; EB53 A0 E9
        ldx     #$00                            ; EB55 A2 00
        BRK_TELEMON XSCRSE                             ; EB57 00 36
        jsr     LC8DC                           ; EB59 20 DC C8
        jmp     Warm_start                      ; EB5C 4C B4 D0

; ----------------------------------------------------------------------------
LEB5F:  lda     HRS3+1                          ; EB5F A5 52
        sta     Proc2                           ; EB61 8D F4 04
        lda     HRS1+1                          ; EB64 A5 4E
        pha                                     ; EB66 48
        plp                                     ; EB67 28
        jsr     Proc2                           ; EB68 20 F4 04
        bcs     LEB6E                           ; EB6B B0 01
        rts                                     ; EB6D 60

; ----------------------------------------------------------------------------
LEB6E:  jsr     LD3AE                           ; EB6E 20 AE D3
        stx     Proc1+1                         ; EB71 8E E3 04
        sty     Proc1+2                         ; EB74 8C E4 04
        sec                                     ; EB77 38
        rts                                     ; EB78 60

; ----------------------------------------------------------------------------
; Trace instruction JMP
TraceJMP:
        pla                                     ; EB79 68
        sta     Ptr1                            ; EB7A 8D EE 04
        pla                                     ; EB7D 68
        sta     Ptr1+1                          ; EB7E 8D EF 04
        lda     HRS3+1                          ; EB81 A5 52
        cmp     #$4C                            ; EB83 C9 4C
        bne     TraceJMPind                     ; EB85 D0 07
        lda     HRS4                            ; EB87 A5 53
        ldy     HRS4+1                          ; EB89 A4 54
        jmp     LEBBB                           ; EB8B 4C BB EB

; ----------------------------------------------------------------------------
; Trace instruction JMP ()
TraceJMPind:
        cmp     #$6C                            ; EB8E C9 6C
        bne     TraceJSR                        ; EB90 D0 16
        lda     HRS4                            ; EB92 A5 53
        ldy     HRS4+1                          ; EB94 A4 54
        sta     Proc1+1                         ; EB96 8D E3 04
        sty     Proc1+2                         ; EB99 8C E4 04
        jsr     LCC5B                           ; EB9C 20 5B CC
        tax                                     ; EB9F AA
        jsr     LCC53                           ; EBA0 20 53 CC
        tay                                     ; EBA3 A8
        txa                                     ; EBA4 8A
        jmp     LEBBB                           ; EBA5 4C BB EB

; ----------------------------------------------------------------------------
; Trace instruction JSR
TraceJSR:
        cmp     #$20                            ; EBA8 C9 20
        bne     TraceRTI                        ; EBAA D0 18
        lda     Proc1+2                         ; EBAC AD E4 04
        pha                                     ; EBAF 48
        lda     Proc1+1                         ; EBB0 AD E3 04
        pha                                     ; EBB3 48
        lda     HRS4                            ; EBB4 A5 53
        ldy     HRS4+1                          ; EBB6 A4 54
LEBB8:  tsx                                     ; EBB8 BA
        stx     HRS1                            ; EBB9 86 4D
LEBBB:  sta     Proc1+1                         ; EBBB 8D E3 04
        sty     Proc1+2                         ; EBBE 8C E4 04
        jmp     LEC2C                           ; EBC1 4C 2C EC

; ----------------------------------------------------------------------------
; Trace instruction RTI
TraceRTI:
        cmp     #$40                            ; EBC4 C9 40
        bne     TraceRTS                        ; EBC6 D0 10
        tsx                                     ; EBC8 BA
        cpx     #$FC                            ; EBC9 E0 FC
        bcs     LEBE1                           ; EBCB B0 14
        pla                                     ; EBCD 68
        sta     HRS1+1                          ; EBCE 85 4E
        pla                                     ; EBD0 68
        tax                                     ; EBD1 AA
        pla                                     ; EBD2 68
        tay                                     ; EBD3 A8
        txa                                     ; EBD4 8A
        jmp     LEBB8                           ; EBD5 4C B8 EB

; ----------------------------------------------------------------------------
; Trace instruction RTS
TraceRTS:
        cmp     #$60                            ; EBD8 C9 60
        bne     TracePLA                        ; EBDA D0 18
        tsx                                     ; EBDC BA
        cpx     #$FD                            ; EBDD E0 FD
        bcc     LEBE9                           ; EBDF 90 08
LEBE1:  cpx     #$FE                            ; EBE1 E0 FE
        beq     LEC50                           ; EBE3 F0 6B
LEBE5:  ldx     #$16                            ; EBE5 A2 16
        bne     LEC3E                           ; EBE7 D0 55
LEBE9:  pla                                     ; EBE9 68
        sta     Proc1+1                         ; EBEA 8D E3 04
        pla                                     ; EBED 68
        sta     Proc1+2                         ; EBEE 8D E4 04
        jmp     LEC26                           ; EBF1 4C 26 EC

; ----------------------------------------------------------------------------
; Trace instruction PLA
TracePLA:
        cmp     #$68                            ; EBF4 C9 68
        bne     TracePLP                        ; EBF6 D0 0F
        tsx                                     ; EBF8 BA
        cpx     #$FE                            ; EBF9 E0 FE
        bcs     LEBE5                           ; EBFB B0 E8
        pla                                     ; EBFD 68
        php                                     ; EBFE 08
        sta     HRS3                            ; EBFF 85 51
        pla                                     ; EC01 68
        sta     HRS1+1                          ; EC02 85 4E
        jmp     LEC26                           ; EC04 4C 26 EC

; ----------------------------------------------------------------------------
; Trace instruction PLP
TracePLP:
        cmp     #$28                            ; EC07 C9 28
        bne     TracePHA                        ; EC09 D0 0A
        cpx     #$FE                            ; EC0B E0 FE
        bcs     LEBE5                           ; EC0D B0 D6
        pla                                     ; EC0F 68
        sta     HRS1+1                          ; EC10 85 4E
        jmp     LEC26                           ; EC12 4C 26 EC

; ----------------------------------------------------------------------------
; Trace instruction PHA
TracePHA:
        cmp     #$48                            ; EC15 C9 48
        bne     TracePHP                        ; EC17 D0 06
        lda     HRS3                            ; EC19 A5 51
        pha                                     ; EC1B 48
        jmp     LEC26                           ; EC1C 4C 26 EC

; ----------------------------------------------------------------------------
; Trace instruction PHP
TracePHP:
        cmp     #$08                            ; EC1F C9 08
        bne     LEC36                           ; EC21 D0 13
        lda     HRS1+1                          ; EC23 A5 4E
        pha                                     ; EC25 48
LEC26:  tsx                                     ; EC26 BA
        stx     HRS1                            ; EC27 86 4D
        jsr     LCC53                           ; EC29 20 53 CC
LEC2C:  sec                                     ; EC2C 38
LEC2D:  lda     Ptr1+1                          ; EC2D AD EF 04
        pha                                     ; EC30 48
        lda     Ptr1                            ; EC31 AD EE 04
        pha                                     ; EC34 48
        rts                                     ; EC35 60

; ----------------------------------------------------------------------------
LEC36:  lda     INDIC2                          ; EC36 A5 57
        cmp     #$B8                            ; EC38 C9 B8
        bcc     LEC2D                           ; EC3A 90 F1
        ldx     #$17                            ; EC3C A2 17
LEC3E:  jsr     DispErrorX                      ; EC3E 20 1B C8
        bit     Ptr3                            ; EC41 2C F2 04
        bpl     LEC50                           ; EC44 10 0A
LEC46:  jsr     LCC45                           ; EC46 20 45 CC
        dec     INDIC0+1                        ; EC49 C6 56
        bpl     LEC46                           ; EC4B 10 F9
        jsr     LD3CB                           ; EC4D 20 CB D3
LEC50:  jmp     LEB3A                           ; EC50 4C 3A EB

; ----------------------------------------------------------------------------
LEC53:  lda     #$0C                            ; EC53 A9 0C
        BRK_TELEMON XWR1                             ; EC55 00 11
        lda     #<Registers_str                 ; EC57 A9 2B
        ldy     #>Registers_str                 ; EC59 A0 C6
        BRK_TELEMON XWSTR1                             ; EC5B 00 15
        lda     #$0A                            ; EC5D A9 0A
        BRK_TELEMON XWR1                             ; EC5F 00 11
        lda     #$0D                            ; EC61 A9 0D
        BRK_TELEMON XWR1                             ; EC63 00 11
        ldy     #$03                            ; EC65 A0 03
LEC67:  lda     HRS1+1,y                        ; EC67 B9 4E 00
        jsr     PutHexa                         ; EC6A 20 D9 C7
        jsr     LEC80                           ; EC6D 20 80 EC
        lda     #$20                            ; EC70 A9 20
        BRK_TELEMON XWR1                             ; EC72 00 11
        dey                                     ; EC74 88
        bpl     LEC67                           ; EC75 10 F0
        lda     #$20                            ; EC77 A9 20
        BRK_TELEMON XWR1                             ; EC79 00 11
        lda     HRS1+1                          ; EC7B A5 4E
        jsr     PutBitStr                       ; EC7D 20 FE C7
LEC80:  pha                                     ; EC80 48
        tya                                     ; EC81 98
        pha                                     ; EC82 48
        txa                                     ; EC83 8A
        pha                                     ; EC84 48
        lda     #<BUFTRV                        ; EC85 A9 00
        ldy     #>BUFTRV                        ; EC87 A0 01
        BRK_TELEMON XWSTR1                             ; EC89 00 15
        pla                                     ; EC8B 68
        tax                                     ; EC8C AA
        pla                                     ; EC8D 68
        tay                                     ; EC8E A8
        pla                                     ; EC8F 68
        rts                                     ; EC90 60

; ----------------------------------------------------------------------------
LEC91:  lda     #$0C                            ; EC91 A9 0C
        BRK_TELEMON XWR2                             ; EC93 00 12
        ldy     #$FE                            ; EC95 A0 FE
LEC97:  lda     #$0A                            ; EC97 A9 0A
        BRK_TELEMON XWR2                             ; EC99 00 12
        lda     #$0D                            ; EC9B A9 0D
        BRK_TELEMON XWR2                             ; EC9D 00 12
        tya                                     ; EC9F 98
        pha                                     ; ECA0 48
        ldy     #$01                            ; ECA1 A0 01
        jsr     PutYAHexa                       ; ECA3 20 CD C7
        jsr     LECC6                           ; ECA6 20 C6 EC
        pla                                     ; ECA9 68
        tay                                     ; ECAA A8
        cmp     HRS1                            ; ECAB C5 4D
        beq     LECC1                           ; ECAD F0 12
        lda     #$20                            ; ECAF A9 20
        BRK_TELEMON XWR2                             ; ECB1 00 12
        lda     BUFTRV,y                        ; ECB3 B9 00 01
        jsr     PutHexa                         ; ECB6 20 D9 C7
        jsr     LECC6                           ; ECB9 20 C6 EC
        dey                                     ; ECBC 88
        cpy     #$E4                            ; ECBD C0 E4
        bne     LEC97                           ; ECBF D0 D6
LECC1:  lda     #$7F                            ; ECC1 A9 7F
        BRK_TELEMON XWR2                             ; ECC3 00 12
        rts                                     ; ECC5 60

; ----------------------------------------------------------------------------
LECC6:  pha                                     ; ECC6 48
        tya                                     ; ECC7 98
        pha                                     ; ECC8 48
        txa                                     ; ECC9 8A
        pha                                     ; ECCA 48
        lda     #<BUFTRV                        ; ECCB A9 00
        ldy     #>BUFTRV                        ; ECCD A0 01
        BRK_TELEMON XWSTR2                             ; ECCF 00 16
        pla                                     ; ECD1 68
        tax                                     ; ECD2 AA
        pla                                     ; ECD3 68
        tay                                     ; ECD4 A8
        pla                                     ; ECD5 68
        rts                                     ; ECD6 60

; ----------------------------------------------------------------------------
LECD7:  bit     Ptr3                            ; ECD7 2C F2 04
        bmi     LECE4                           ; ECDA 30 08
        bvs     LECEA                           ; ECDC 70 0C
        lda     #<PasPas_str                    ; ECDE A9 9E
        ldy     #>PasPas_str                    ; ECE0 A0 C6
        bne     LECEE                           ; ECE2 D0 0A
LECE4:  lda     #<Exec_str                      ; ECE4 A9 A9
        ldy     #>Exec_str                      ; ECE6 A0 C6
        bne     LECEE                           ; ECE8 D0 04
LECEA:  lda     #<Trace_str                     ; ECEA A9 97
        ldy     #>Trace_str                     ; ECEC A0 C6
LECEE:  ldx     #$02                            ; ECEE A2 02
        jmp     LC857                           ; ECF0 4C 57 C8

; ----------------------------------------------------------------------------
LECF3:  bit     Ptr3                            ; ECF3 2C F2 04
        bmi     LED07                           ; ECF6 30 0F
        bit     XLPRBI                          ; ECF8 24 48
        bmi     LED02                           ; ECFA 30 06
        jsr     LEC53                           ; ECFC 20 53 EC
        jsr     LEC91                           ; ECFF 20 91 EC
LED02:  BRK_TELEMON XCRLF                             ; ED02 00 25
        jsr     LD3CB                           ; ED04 20 CB D3
LED07:  rts                                     ; ED07 60

; ----------------------------------------------------------------------------
LED08:  lda     #<Assemblage_str                ; ED08 A9 83
        ldy     #>Assemblage_str                ; ED0A A0 C6
        ldx     #$04                            ; ED0C A2 04
        jmp     LC857                           ; ED0E 4C 57 C8

; ----------------------------------------------------------------------------
LED11:  jmp     SyntaxErr5                      ; ED11 4C 3D D8

; ----------------------------------------------------------------------------
; MINAS adrdeb : mini-assembleur ligne par ligne. Fin par saisie d'une ligne
; vide
MINAS:  tax                                     ; ED14 AA
        beq     LED11                           ; ED15 F0 FA
        jsr     EvalWord                        ; ED17 20 6A D2
        sta     Proc1+1                         ; ED1A 8D E3 04
        sta     Proc1+9                         ; ED1D 8D EB 04
        sty     Proc1+2                         ; ED20 8C E4 04
        sty     Proc1+10                        ; ED23 8C EC 04
        txa                                     ; ED26 8A
        bne     LED11                           ; ED27 D0 E8
        jsr     LED08                           ; ED29 20 08 ED
LED2C:  BRK_TELEMON XCRLF                             ; ED2C 00 25
LED2E:  ldx     #$00                            ; ED2E A2 00
        ldy     #$00                            ; ED30 A0 00
        lda     #$6E                            ; ED32 A9 6E
        BRK_TELEMON XEDT                             ; ED34 00 2D
        cmp     #$03                            ; ED36 C9 03
        bne     LED40                           ; ED38 D0 06
LED3A:  jsr     LC8DC                           ; ED3A 20 DC C8
        jmp     LCFCB                           ; ED3D 4C CB CF

; ----------------------------------------------------------------------------
LED40:  cmp     #$0D                            ; ED40 C9 0D
        bne     LED2C                           ; ED42 D0 E8
        stx     VARAPL2+8                       ; ED44 86 F3
        cpx     #$00                            ; ED46 E0 00
        bne     IllegalLabErr2                  ; ED48 D0 46
        jsr     LC8DC                           ; ED4A 20 DC C8
        jsr     LED08                           ; ED4D 20 08 ED
        jsr     SkipSpaces                      ; ED50 20 2D CA
        beq     LED3A                           ; ED53 F0 E5
        jsr     LC934                           ; ED55 20 34 C9
        bcc     LED95                           ; ED58 90 3B
        lda     #<BUFEDT                        ; ED5A A9 90
        sta     TXTPTR                          ; ED5C 85 E9
        lda     #>BUFEDT                        ; ED5E A9 05
        sta     TXTPTR+1                        ; ED60 85 EA
        jsr     CharGot                         ; ED62 20 E8 00
        ldy     #$00                            ; ED65 A0 00
        lda     (TXTPTR),y                      ; ED67 B1 E9
        bmi     LED79                           ; ED69 30 0E
        cmp     #"'"                            ; ED6B C9 27
        beq     LED2E                           ; ED6D F0 BF
        jsr     LD86D                           ; ED6F 20 6D D8
        jsr     LD8D4                           ; ED72 20 D4 D8
        beq     LED2C                           ; ED75 F0 B5
        ldy     #$00                            ; ED77 A0 00
LED79:  lda     (TXTPTR),y                      ; ED79 B1 E9
        sta     INDIC2                          ; ED7B 85 57
        cmp     #$80                            ; ED7D C9 80
        beq     LEDDC                           ; ED7F F0 5B
        cmp     #$99                            ; ED81 C9 99
        bcs     LED9C                           ; ED83 B0 17
        lda     #$00                            ; ED85 A9 00
        tax                                     ; ED87 AA
        jsr     LCA79                           ; ED88 20 79 CA
        bcs     LEDDF                           ; ED8B B0 52
        ldx     #$13                            ; ED8D A2 13
        .byte   $2C                             ; ED8F 2C
; Err $0F
IllegalLabErr2:
        ldx     #$0F                            ; ED90 A2 0F
        .byte   $2C                             ; ED92 2C
; Err $00
SyntaxErr7:
        ldx     #$00                            ; ED93 A2 00
LED95:  lda     #$00                            ; ED95 A9 00
        sta     VARAPL2+8                       ; ED97 85 F3
        jmp     LCF98                           ; ED99 4C 98 CF

; ----------------------------------------------------------------------------
LED9C:  cmp     #$A1                            ; ED9C C9 A1
        bcs     LEDA5                           ; ED9E B0 05
        jsr     LD9C0                           ; EDA0 20 C0 D9
        bne     LEDDF                           ; EDA3 D0 3A
LEDA5:  cmp     #$B9                            ; EDA5 C9 B9
        beq     SyntaxErr7                      ; EDA7 F0 EA
        cmp     #$BC                            ; EDA9 C9 BC
        beq     SyntaxErr7                      ; EDAB F0 E6
        cmp     #$B8                            ; EDAD C9 B8
        bne     LEDB7                           ; EDAF D0 06
        jsr     LEE35                           ; EDB1 20 35 EE
        jmp     LED2C                           ; EDB4 4C 2C ED

; ----------------------------------------------------------------------------
LEDB7:  cmp     #$BA                            ; EDB7 C9 BA
        bne     LEDC1                           ; EDB9 D0 06
        jsr     LEE6B                           ; EDBB 20 6B EE
        jmp     LED2C                           ; EDBE 4C 2C ED

; ----------------------------------------------------------------------------
LEDC1:  cmp     #$BD                            ; EDC1 C9 BD
        bne     LEDCB                           ; EDC3 D0 06
        jsr     LEE7A                           ; EDC5 20 7A EE
        jmp     LED2C                           ; EDC8 4C 2C ED

; ----------------------------------------------------------------------------
LEDCB:  cmp     #$BB                            ; EDCB C9 BB
        bne     LEDD8                           ; EDCD D0 09
        jsr     LDAEA                           ; EDCF 20 EA DA
        jsr     LCCB3                           ; EDD2 20 B3 CC
        jmp     LED2C                           ; EDD5 4C 2C ED

; ----------------------------------------------------------------------------
LEDD8:  cmp     #$B8                            ; EDD8 C9 B8
        bcs     SyntaxErr7                      ; EDDA B0 B7
LEDDC:  jsr     LD912                           ; EDDC 20 12 D9
LEDDF:  sta     HRS3+1                          ; EDDF 85 52
        stx     INDIC0+1                        ; EDE1 86 56
        lda     VARAPL+14                       ; EDE3 A5 DE
        sta     HRS4                            ; EDE5 85 53
        lda     VARAPL+15                       ; EDE7 A5 DF
        sta     HRS4+1                          ; EDE9 85 54
        ldy     #$FF                            ; EDEB A0 FF
LEDED:  iny                                     ; EDED C8
        lda     HRS3+1,y                        ; EDEE B9 52 00
        jsr     LCCDB                           ; EDF1 20 DB CC
        jsr     LCCD2                           ; EDF4 20 D2 CC
        dex                                     ; EDF7 CA
        bpl     LEDED                           ; EDF8 10 F3
        lda     #$7F                            ; EDFA A9 7F
        BRK_TELEMON XWR0                             ; EDFC 00 10
        jsr     LD3CB                           ; EDFE 20 CB D3
        jsr     LCC53                           ; EE01 20 53 CC
        jmp     LED2C                           ; EE04 4C 2C ED

; ----------------------------------------------------------------------------
LEE07:  lda     Proc1+1                         ; EE07 AD E3 04
        sta     Ptr1                            ; EE0A 8D EE 04
        lda     Proc1+2                         ; EE0D AD E4 04
        sta     Ptr1+1                          ; EE10 8D EF 04
        lda     TXTPTR                          ; EE13 A5 E9
        sta     Ptr2                            ; EE15 8D F0 04
        lda     TXTPTR+1                        ; EE18 A5 EA
        sta     Ptr2+1                          ; EE1A 8D F1 04
        rts                                     ; EE1D 60

; ----------------------------------------------------------------------------
LEE1E:  lda     Ptr1                            ; EE1E AD EE 04
        sta     Proc1+1                         ; EE21 8D E3 04
        lda     Ptr1+1                          ; EE24 AD EF 04
        sta     Proc1+2                         ; EE27 8D E4 04
        lda     Ptr2                            ; EE2A AD F0 04
        sta     TXTPTR                          ; EE2D 85 E9
        lda     Ptr2+1                          ; EE2F AD F1 04
        sta     TXTPTR+1                        ; EE32 85 EA
        rts                                     ; EE34 60

; ----------------------------------------------------------------------------
LEE35:  jsr     LEE07                           ; EE35 20 07 EE
        jsr     LDA62                           ; EE38 20 62 DA
        jsr     LEE1E                           ; EE3B 20 1E EE
        jsr     LDAA4                           ; EE3E 20 A4 DA
LEE41:  lda     #$7F                            ; EE41 A9 7F
        BRK_TELEMON XWR0                             ; EE43 00 10
        sec                                     ; EE45 38
        lda     Proc1+1                         ; EE46 AD E3 04
        sbc     Ptr1                            ; EE49 ED EE 04
        sta     VARAPL+6                        ; EE4C 85 D6
        lda     Ptr1                            ; EE4E AD EE 04
        sta     VARAPL+10                       ; EE51 85 DA
        ldy     Ptr1+1                          ; EE53 AC EF 04
        sty     VARAPL+11                       ; EE56 84 DB
        jsr     DispWord                        ; EE58 20 8D C7
        ldy     #$00                            ; EE5B A0 00
LEE5D:  jsr     DispSpace                       ; EE5D 20 35 C7
        lda     (VARAPL+10),y                   ; EE60 B1 DA
        jsr     DispByte                        ; EE62 20 92 C7
        iny                                     ; EE65 C8
        cpy     VARAPL+6                        ; EE66 C4 D6
        bcc     LEE5D                           ; EE68 90 F3
        rts                                     ; EE6A 60

; ----------------------------------------------------------------------------
LEE6B:  jsr     LEE07                           ; EE6B 20 07 EE
        jsr     LDA40                           ; EE6E 20 40 DA
        jsr     LEE1E                           ; EE71 20 1E EE
        jsr     LD9FA                           ; EE74 20 FA D9
        jmp     LEE41                           ; EE77 4C 41 EE

; ----------------------------------------------------------------------------
LEE7A:  jsr     LEE07                           ; EE7A 20 07 EE
        jsr     LDA40                           ; EE7D 20 40 DA
        jsr     LEE1E                           ; EE80 20 1E EE
        jsr     LDA1D                           ; EE83 20 1D DA
        jmp     LEE41                           ; EE86 4C 41 EE

; ----------------------------------------------------------------------------
LEE89:  pha                                     ; EE89 48
        lda     #<Occurences_str                ; EE8A A9 D8
        ldy     #>Occurences_str                ; EE8C A0 C6
        BRK_TELEMON XWSTR0                             ; EE8E 00 14
        pla                                     ; EE90 68
        jmp     LC766                           ; EE91 4C 66 C7

; ----------------------------------------------------------------------------
; SEEK ''chaine'' (,L) : recherche la chiane entre double-quotes et indique le
; nombre d'occurences. Si l'option 'L' est précisée, affiche aussi les lignes
; correspondantes
SEEK:   ldx     #$00                            ; EE94 A2 00
        stx     XLPRBI                          ; EE96 86 48
        jsr     EvalString                      ; EE98 20 14 EF
        beq     LEEAC                           ; EE9B F0 0F
        jsr     EvalComma                       ; EE9D 20 AC D1
        cmp     #"L"                            ; EEA0 C9 4C
        bne     LEF17                           ; EEA2 D0 73
        ror     XLPRBI                          ; EEA4 66 48
        jsr     CharGet                         ; EEA6 20 E2 00
        tax                                     ; EEA9 AA
        bne     LEF17                           ; EEAA D0 6B
LEEAC:  sta     HRSX6                           ; EEAC 85 4A
        lda     SCEDEB                          ; EEAE A5 5C
        sta     TXTPTR                          ; EEB0 85 E9
        lda     SCEDEB+1                        ; EEB2 A5 5D
        sta     TXTPTR+1                        ; EEB4 85 EA
LEEB6:  ldy     #$00                            ; EEB6 A0 00
        sty     HRSX40                          ; EEB8 84 49
        lda     (TXTPTR),y                      ; EEBA B1 E9
        beq     LEF0C                           ; EEBC F0 4E
        ldy     #$03                            ; EEBE A0 03
LEEC0:  lda     (TXTPTR),y                      ; EEC0 B1 E9
        beq     LEEE1                           ; EEC2 F0 1D
        sty     HRSY                            ; EEC4 84 47
        ldx     #$00                            ; EEC6 A2 00
LEEC8:  lda     BUFEDT,x                        ; EEC8 BD 90 05
        beq     LEEDA                           ; EECB F0 0D
        cmp     (TXTPTR),y                      ; EECD D1 E9
        beq     LEED6                           ; EECF F0 05
        ldy     HRSY                            ; EED1 A4 47
        iny                                     ; EED3 C8
        bne     LEEC0                           ; EED4 D0 EA
LEED6:  iny                                     ; EED6 C8
        inx                                     ; EED7 E8
        bne     LEEC8                           ; EED8 D0 EE
LEEDA:  inc     HRSX6                           ; EEDA E6 4A
        sec                                     ; EEDC 38
        ror     HRSX40                          ; EEDD 66 49
        bmi     LEEC0                           ; EEDF 30 DF
LEEE1:  bit     XLPRBI                          ; EEE1 24 48
        bpl     LEF05                           ; EEE3 10 20
        bit     HRSX40                          ; EEE5 24 49
        bpl     LEF05                           ; EEE7 10 1C
        lda     TXTPTR                          ; EEE9 A5 E9
        ldy     TXTPTR+1                        ; EEEB A4 EA
        sta     VARAPL+12                       ; EEED 85 DC
        sty     VARAPL+13                       ; EEEF 84 DD
        ldy     #$01                            ; EEF1 A0 01
        lda     (TXTPTR),y                      ; EEF3 B1 E9
        pha                                     ; EEF5 48
        iny                                     ; EEF6 C8
        lda     (TXTPTR),y                      ; EEF7 B1 E9
        tay                                     ; EEF9 A8
        pla                                     ; EEFA 68
        jsr     LCAF2                           ; EEFB 20 F2 CA
        jsr     LC8B4                           ; EEFE 20 B4 C8
        bcs     LEF11                           ; EF01 B0 0E
        BRK_TELEMON XCRLF                             ; EF03 00 25
LEF05:  iny                                     ; EF05 C8
        jsr     IncTXTPTR                       ; EF06 20 85 CE
        jmp     LEEB6                           ; EF09 4C B6 EE

; ----------------------------------------------------------------------------
LEF0C:  lda     HRSX6                           ; EF0C A5 4A
        jsr     LEE89                           ; EF0E 20 89 EE
LEF11:  jmp     LCFC8                           ; EF11 4C C8 CF

; ----------------------------------------------------------------------------
; Evalue une chaine entre double quotes
EvalString:
        tax                                     ; EF14 AA
        cmp     #'"'                            ; EF15 C9 22
LEF17:  bne     SyntaxErr8                      ; EF17 D0 0F
        ldx     #$00                            ; EF19 A2 00
        ldy     #$01                            ; EF1B A0 01
        lda     (TXTPTR),y                      ; EF1D B1 E9
        beq     LEF25                           ; EF1F F0 04
        cmp     #'"'                            ; EF21 C9 22
        bne     LEF2D                           ; EF23 D0 08
LEF25:  jsr     IncTXTPTR                       ; EF25 20 85 CE
; Err $00
SyntaxErr8:
        ldx     #$00                            ; EF28 A2 00
        jmp     LCF98                           ; EF2A 4C 98 CF

; ----------------------------------------------------------------------------
LEF2D:  lda     (TXTPTR),y                      ; EF2D B1 E9
        sta     BUFEDT,x                        ; EF2F 9D 90 05
        beq     LEF42                           ; EF32 F0 0E
        cmp     #'"'                            ; EF34 C9 22
        beq     LEF3C                           ; EF36 F0 04
        iny                                     ; EF38 C8
        inx                                     ; EF39 E8
        bne     LEF2D                           ; EF3A D0 F1
LEF3C:  lda     #$00                            ; EF3C A9 00
        sta     BUFEDT-1,y                      ; EF3E 99 8F 05
        iny                                     ; EF41 C8
LEF42:  jsr     IncTXTPTR                       ; EF42 20 85 CE
        jsr     CharGot                         ; EF45 20 E8 00
        tax                                     ; EF48 AA
        rts                                     ; EF49 60

; ----------------------------------------------------------------------------
; CHANGE ''chaine1'',''chaine2'' : remplace toutes les occurences de chaine1
; par chaine2. Les chaines peuvent contenir des double-quotes
CHANGE: jsr     EvalString                      ; EF4A 20 14 EF
        beq     SyntaxErr8                      ; EF4D F0 D9
        cmp     #","                            ; EF4F C9 2C
        bne     SyntaxErr8                      ; EF51 D0 D5
        jsr     CharGet                         ; EF53 20 E2 00
        cmp     #'"'                            ; EF56 C9 22
        bne     SyntaxErr8                      ; EF58 D0 CE
        ldy     #$01                            ; EF5A A0 01
LEF5C:  lda     (TXTPTR),y                      ; EF5C B1 E9
        sta     BUFTRV-1,y                      ; EF5E 99 FF 00
        beq     LEF70                           ; EF61 F0 0D
        cmp     #'"'                            ; EF63 C9 22
        beq     LEF6A                           ; EF65 F0 03
        iny                                     ; EF67 C8
        bne     LEF5C                           ; EF68 D0 F2
LEF6A:  lda     #$00                            ; EF6A A9 00
        sta     BUFTRV-1,y                      ; EF6C 99 FF 00
        iny                                     ; EF6F C8
LEF70:  jsr     IncTXTPTR                       ; EF70 20 85 CE
        jsr     CharGot                         ; EF73 20 E8 00
        tax                                     ; EF76 AA
        bne     SyntaxErr8                      ; EF77 D0 AF
        sta     VARAPL+6                        ; EF79 85 D6
        lda     SCEDEB                          ; EF7B A5 5C
        ldy     SCEDEB+1                        ; EF7D A4 5D
        sta     DECDEB                          ; EF7F 85 04
        sty     DECDEB+1                        ; EF81 84 05
        sta     Proc1+9                         ; EF83 8D EB 04
        sty     Proc1+10                        ; EF86 8C EC 04
        lda     SCEFIN                          ; EF89 A5 5E
        ldy     SCEFIN+1                        ; EF8B A4 5F
        sta     DECFIN                          ; EF8D 85 06
        sty     DECFIN+1                        ; EF8F 84 07
        sta     DECCIB                          ; EF91 85 08
        sty     DECCIB+1                        ; EF93 84 09
        sta     TXTPTR                          ; EF95 85 E9
        sty     TXTPTR+1                        ; EF97 84 EA
        BRK_TELEMON XDECAL                             ; EF99 00 18
LEF9B:  ldy     #$00                            ; EF9B A0 00
        lda     (TXTPTR),y                      ; EF9D B1 E9
        beq     LEFEF                           ; EF9F F0 4E
LEFA1:  lda     (TXTPTR),y                      ; EFA1 B1 E9
        jsr     Proc1+8                         ; EFA3 20 EA 04
        jsr     LCCD2                           ; EFA6 20 D2 CC
        iny                                     ; EFA9 C8
        cpy     #$03                            ; EFAA C0 03
        bne     LEFA1                           ; EFAC D0 F3
LEFAE:  lda     (TXTPTR),y                      ; EFAE B1 E9
        beq     LEFE2                           ; EFB0 F0 30
        sty     VARAPL+5                        ; EFB2 84 D5
        ldx     #$00                            ; EFB4 A2 00
LEFB6:  lda     BUFEDT,x                        ; EFB6 BD 90 05
        beq     LEFD0                           ; EFB9 F0 15
        cmp     (TXTPTR),y                      ; EFBB D1 E9
        beq     LEFCC                           ; EFBD F0 0D
        ldy     VARAPL+5                        ; EFBF A4 D5
        lda     (TXTPTR),y                      ; EFC1 B1 E9
        jsr     Proc1+8                         ; EFC3 20 EA 04
        jsr     LCCD2                           ; EFC6 20 D2 CC
        iny                                     ; EFC9 C8
        bne     LEFAE                           ; EFCA D0 E2
LEFCC:  iny                                     ; EFCC C8
        inx                                     ; EFCD E8
        bne     LEFB6                           ; EFCE D0 E6
LEFD0:  ldx     #$00                            ; EFD0 A2 00
        inc     VARAPL+6                        ; EFD2 E6 D6
LEFD4:  lda     BUFTRV,x                        ; EFD4 BD 00 01
        beq     LEFAE                           ; EFD7 F0 D5
        jsr     Proc1+8                         ; EFD9 20 EA 04
        jsr     LCCD2                           ; EFDC 20 D2 CC
        inx                                     ; EFDF E8
        bne     LEFD4                           ; EFE0 D0 F2
LEFE2:  jsr     Proc1+8                         ; EFE2 20 EA 04
        jsr     LCCD2                           ; EFE5 20 D2 CC
        iny                                     ; EFE8 C8
        jsr     IncTXTPTR                       ; EFE9 20 85 CE
        jmp     LEF9B                           ; EFEC 4C 9B EF

; ----------------------------------------------------------------------------
LEFEF:  jsr     Proc1+8                         ; EFEF 20 EA 04
        lda     TXTPTR                          ; EFF2 A5 E9
        ldy     TXTPTR+1                        ; EFF4 A4 EA
        jsr     LD236                           ; EFF6 20 36 D2
        lda     VARAPL+6                        ; EFF9 A5 D6
        jsr     LEE89                           ; EFFB 20 89 EE
        BRK_TELEMON XCRLF                             ; EFFE 00 25
        lda     #$00                            ; F000 A9 00
        jmp     OLD                             ; F002 4C A2 E2

; ----------------------------------------------------------------------------
; TEXT : passe en mode TEXT (COMMANDE NON DOCUMENTEE)
TEXT:   tax                                     ; F005 AA
        bne     LF015                           ; F006 D0 0D
        BRK_TELEMON XTEXT                             ; F008 00 19
        jmp     LCFCB                           ; F00A 4C CB CF

; ----------------------------------------------------------------------------
; HIRES : passe en mode HIRES  (COMMANDE NON DOCUMENTEE)
HIRES:  tax                                     ; F00D AA
        bne     LF015                           ; F00E D0 05
        BRK_TELEMON XHIRES                             ; F010 00 1A
        jmp     LCFCB                           ; F012 4C CB CF

; ----------------------------------------------------------------------------
LF015:  jmp     LCF98                           ; F015 4C 98 CF

; ----------------------------------------------------------------------------
SymbolTable:
        .byte   "ACC1E "                        ; F018 41 43 43 31 45 20
; ----------------------------------------------------------------------------
        .word   $0060                           ; F01E 60 00
; ----------------------------------------------------------------------------
        .byte   "ACC1EX"                        ; F020 41 43 43 31 45 58
; ----------------------------------------------------------------------------
        .word   $0066                           ; F026 66 00
; ----------------------------------------------------------------------------
        .byte   "ACC1J "                        ; F028 41 43 43 31 4A 20
; ----------------------------------------------------------------------------
        .word   $0067                           ; F02E 67 00
; ----------------------------------------------------------------------------
        .byte   "ACC1M "                        ; F030 41 43 43 31 4D 20
; ----------------------------------------------------------------------------
        .word   $0061                           ; F036 61 00
; ----------------------------------------------------------------------------
        .byte   "ACC1S "                        ; F038 41 43 43 31 53 20
; ----------------------------------------------------------------------------
        .word   $0065                           ; F03E 65 00
; ----------------------------------------------------------------------------
        .byte   "ACC2E "                        ; F040 41 43 43 32 45 20
; ----------------------------------------------------------------------------
        .word   $0068                           ; F046 68 00
; ----------------------------------------------------------------------------
        .byte   "ACC2M "                        ; F048 41 43 43 32 4D 20
; ----------------------------------------------------------------------------
        .word   $0069                           ; F04E 69 00
; ----------------------------------------------------------------------------
        .byte   "ACC2S "                        ; F050 41 43 43 32 53 20
; ----------------------------------------------------------------------------
        .word   $006D                           ; F056 6D 00
; ----------------------------------------------------------------------------
        .byte   "ACC3  "                        ; F058 41 43 43 33 20 20
; ----------------------------------------------------------------------------
        .word   $006F                           ; F05E 6F 00
; ----------------------------------------------------------------------------
        .byte   "ACC4E "                        ; F060 41 43 43 34 45 20
; ----------------------------------------------------------------------------
        .word   $0073                           ; F066 73 00
; ----------------------------------------------------------------------------
        .byte   "ACC4M "                        ; F068 41 43 43 34 4D 20
; ----------------------------------------------------------------------------
        .word   $0074                           ; F06E 74 00
; ----------------------------------------------------------------------------
        .byte   "ACC5E "                        ; F070 41 43 43 35 45 20
; ----------------------------------------------------------------------------
        .word   $0078                           ; F076 78 00
; ----------------------------------------------------------------------------
        .byte   "ACC5M "                        ; F078 41 43 43 35 4D 20
; ----------------------------------------------------------------------------
        .word   $0079                           ; F07E 79 00
; ----------------------------------------------------------------------------
        .byte   "ACC6  "                        ; F080 41 43 43 36 20 20
; ----------------------------------------------------------------------------
        .word   $0080                           ; F086 80 00
; ----------------------------------------------------------------------------
        .byte   "ACCPS "                        ; F088 41 43 43 50 53 20
; ----------------------------------------------------------------------------
        .word   $006E                           ; F08E 6E 00
; ----------------------------------------------------------------------------
        .byte   "ACIACR"                        ; F090 41 43 49 41 43 52
; ----------------------------------------------------------------------------
        .word   $031E                           ; F096 1E 03
; ----------------------------------------------------------------------------
        .byte   "ACIACT"                        ; F098 41 43 49 41 43 54
; ----------------------------------------------------------------------------
        .word   $031F                           ; F09E 1F 03
; ----------------------------------------------------------------------------
        .byte   "ACIADR"                        ; F0A0 41 43 49 41 44 52
; ----------------------------------------------------------------------------
        .word   $031C                           ; F0A6 1C 03
; ----------------------------------------------------------------------------
        .byte   "ACIASR"                        ; F0A8 41 43 49 41 53 52
; ----------------------------------------------------------------------------
        .word   $031D                           ; F0AE 1D 03
; ----------------------------------------------------------------------------
        .byte   "ACK   "                        ; F0B0 41 43 4B 20 20 20
; ----------------------------------------------------------------------------
        .word   $0006                           ; F0B6 06 00
; ----------------------------------------------------------------------------
        .byte   "ADASC "                        ; F0B8 41 44 41 53 43 20
; ----------------------------------------------------------------------------
        .word   $002E                           ; F0BE 2E 00
; ----------------------------------------------------------------------------
        .byte   "ADATR "                        ; F0C0 41 44 41 54 52 20
; ----------------------------------------------------------------------------
        .word   $0030                           ; F0C6 30 00
; ----------------------------------------------------------------------------
        .byte   "ADCLK "                        ; F0C8 41 44 43 4C 4B 20
; ----------------------------------------------------------------------------
        .word   $0040                           ; F0CE 40 00
; ----------------------------------------------------------------------------
        .byte   "ADENT "                        ; F0D0 41 44 45 4E 54 20
; ----------------------------------------------------------------------------
        .word   $0004                           ; F0D6 04 00
; ----------------------------------------------------------------------------
        .byte   "ADHRS "                        ; F0D8 41 44 48 52 53 20
; ----------------------------------------------------------------------------
        .word   $004B                           ; F0DE 4B 00
; ----------------------------------------------------------------------------
        .byte   "ADIOB "                        ; F0E0 41 44 49 4F 42 20
; ----------------------------------------------------------------------------
        .word   $02BE                           ; F0E6 BE 02
; ----------------------------------------------------------------------------
        .byte   "ADKBD "                        ; F0E8 41 44 4B 42 44 20
; ----------------------------------------------------------------------------
        .word   $002A                           ; F0EE 2A 00
; ----------------------------------------------------------------------------
        .byte   "ADMEN "                        ; F0F0 41 44 4D 45 4E 20
; ----------------------------------------------------------------------------
        .word   $0069                           ; F0F6 69 00
; ----------------------------------------------------------------------------
        .byte   "ADPS  "                        ; F0F8 41 44 50 53 20 20
; ----------------------------------------------------------------------------
        .word   $0008                           ; F0FE 08 00
; ----------------------------------------------------------------------------
        .byte   "ADSCR "                        ; F100 41 44 53 43 52 20
; ----------------------------------------------------------------------------
        .word   $0026                           ; F106 26 00
; ----------------------------------------------------------------------------
        .byte   "ADSCRH"                        ; F108 41 44 53 43 52 48
; ----------------------------------------------------------------------------
        .word   $021C                           ; F10E 1C 02
; ----------------------------------------------------------------------------
        .byte   "ADSCRL"                        ; F110 41 44 53 43 52 4C
; ----------------------------------------------------------------------------
        .word   $0218                           ; F116 18 02
; ----------------------------------------------------------------------------
        .byte   "ADTMP "                        ; F118 41 44 54 4D 50 20
; ----------------------------------------------------------------------------
        .word   $0006                           ; F11E 06 00
; ----------------------------------------------------------------------------
        .byte   "ADTR  "                        ; F120 41 44 54 52 20 20
; ----------------------------------------------------------------------------
        .word   $000A                           ; F126 0A 00
; ----------------------------------------------------------------------------
        .byte   "ADVDT "                        ; F128 41 44 56 44 54 20
; ----------------------------------------------------------------------------
        .word   $002C                           ; F12E 2C 00
; ----------------------------------------------------------------------------
        .byte   "BARBRE"                        ; F130 42 41 52 42 52 45
; ----------------------------------------------------------------------------
        .word   $4000                           ; F136 00 40
; ----------------------------------------------------------------------------
        .byte   "BEL   "                        ; F138 42 45 4C 20 20 20
; ----------------------------------------------------------------------------
        .word   $0007                           ; F13E 07 00
; ----------------------------------------------------------------------------
        .byte   "BITMFC"                        ; F140 42 49 54 4D 46 43
; ----------------------------------------------------------------------------
        .word   $0544                           ; F146 44 05
; ----------------------------------------------------------------------------
        .byte   "BNKCIB"                        ; F148 42 4E 4B 43 49 42
; ----------------------------------------------------------------------------
        .word   $0417                           ; F14E 17 04
; ----------------------------------------------------------------------------
        .byte   "BNKST "                        ; F150 42 4E 4B 53 54 20
; ----------------------------------------------------------------------------
        .word   $0200                           ; F156 00 02
; ----------------------------------------------------------------------------
        .byte   "BS    "                        ; F158 42 53 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $0008                           ; F15E 08 00
; ----------------------------------------------------------------------------
        .byte   "BUF1  "                        ; F160 42 55 46 31 20 20
; ----------------------------------------------------------------------------
        .word   $C100                           ; F166 00 C1
; ----------------------------------------------------------------------------
        .byte   "BUF2  "                        ; F168 42 55 46 32 20 20
; ----------------------------------------------------------------------------
        .word   $C200                           ; F16E 00 C2
; ----------------------------------------------------------------------------
        .byte   "BUF2B "                        ; F170 42 55 46 32 42 20
; ----------------------------------------------------------------------------
        .word   $C300                           ; F176 00 C3
; ----------------------------------------------------------------------------
        .byte   "BUF3  "                        ; F178 42 55 46 33 20 20
; ----------------------------------------------------------------------------
        .word   $C400                           ; F17E 00 C4
; ----------------------------------------------------------------------------
        .byte   "BUFBIP"                        ; F180 42 55 46 42 49 50
; ----------------------------------------------------------------------------
        .word   $0100                           ; F186 00 01
; ----------------------------------------------------------------------------
        .byte   "BUFBIS"                        ; F188 42 55 46 42 49 53
; ----------------------------------------------------------------------------
        .word   $0101                           ; F18E 01 01
; ----------------------------------------------------------------------------
        .byte   "BUFBUF"                        ; F190 42 55 46 42 55 46
; ----------------------------------------------------------------------------
        .word   $C080                           ; F196 80 C0
; ----------------------------------------------------------------------------
        .byte   "BUFC0 "                        ; F198 42 55 46 43 30 20
; ----------------------------------------------------------------------------
        .word   $053B                           ; F19E 3B 05
; ----------------------------------------------------------------------------
        .byte   "BUFEDT"                        ; F1A0 42 55 46 45 44 54
; ----------------------------------------------------------------------------
        .word   $0590                           ; F1A6 90 05
; ----------------------------------------------------------------------------
        .byte   "BUFNOM"                        ; F1A8 42 55 46 4E 4F 4D
; ----------------------------------------------------------------------------
        .word   $0517                           ; F1AE 17 05
; ----------------------------------------------------------------------------
        .byte   "BUFROU"                        ; F1B0 42 55 46 52 4F 55
; ----------------------------------------------------------------------------
        .word   $C500                           ; F1B6 00 C5
; ----------------------------------------------------------------------------
        .byte   "BUFTRV"                        ; F1B8 42 55 46 54 52 56
; ----------------------------------------------------------------------------
        .word   $0100                           ; F1BE 00 01
; ----------------------------------------------------------------------------
        .byte   "BUFTXT"                        ; F1C0 42 55 46 54 58 54
; ----------------------------------------------------------------------------
        .word   $8000                           ; F1C6 00 80
; ----------------------------------------------------------------------------
        .byte   "BVDTAS"                        ; F1C8 42 56 44 54 41 53
; ----------------------------------------------------------------------------
        .word   $9000                           ; F1CE 00 90
; ----------------------------------------------------------------------------
        .byte   "BVDTAT"                        ; F1D0 42 56 44 54 41 54
; ----------------------------------------------------------------------------
        .word   $9400                           ; F1D6 00 94
; ----------------------------------------------------------------------------
        .byte   "CAN   "                        ; F1D8 43 41 4E 20 20 20
; ----------------------------------------------------------------------------
        .word   $0018                           ; F1DE 18 00
; ----------------------------------------------------------------------------
        .byte   "CDRIVE"                        ; F1E0 43 44 52 49 56 45
; ----------------------------------------------------------------------------
        .word   $0314                           ; F1E6 14 03
; ----------------------------------------------------------------------------
        .byte   "CR    "                        ; F1E8 43 52 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $000D                           ; F1EE 0D 00
; ----------------------------------------------------------------------------
        .byte   "CSRND "                        ; F1F0 43 53 52 4E 44 20
; ----------------------------------------------------------------------------
        .word   $02EF                           ; F1F6 EF 02
; ----------------------------------------------------------------------------
        .byte   "CURSCR"                        ; F1F8 43 55 52 53 43 52
; ----------------------------------------------------------------------------
        .word   $024C                           ; F1FE 4C 02
; ----------------------------------------------------------------------------
        .byte   "DC1   "                        ; F200 44 43 31 20 20 20
; ----------------------------------------------------------------------------
        .word   $0011                           ; F206 11 00
; ----------------------------------------------------------------------------
        .byte   "DC2   "                        ; F208 44 43 32 20 20 20
; ----------------------------------------------------------------------------
        .word   $0012                           ; F20E 12 00
; ----------------------------------------------------------------------------
        .byte   "DC3   "                        ; F210 44 43 33 20 20 20
; ----------------------------------------------------------------------------
        .word   $0013                           ; F216 13 00
; ----------------------------------------------------------------------------
        .byte   "DC4   "                        ; F218 44 43 34 20 20 20
; ----------------------------------------------------------------------------
        .word   $0014                           ; F21E 14 00
; ----------------------------------------------------------------------------
        .byte   "DECCIB"                        ; F220 44 45 43 43 49 42
; ----------------------------------------------------------------------------
        .word   $0008                           ; F226 08 00
; ----------------------------------------------------------------------------
        .byte   "DECDEB"                        ; F228 44 45 43 44 45 42
; ----------------------------------------------------------------------------
        .word   $0004                           ; F22E 04 00
; ----------------------------------------------------------------------------
        .byte   "DECFIN"                        ; F230 44 45 43 46 49 4E
; ----------------------------------------------------------------------------
        .word   $0006                           ; F236 06 00
; ----------------------------------------------------------------------------
        .byte   "DECREP"                        ; F238 44 45 43 52 45 50
; ----------------------------------------------------------------------------
        .word   $0537                           ; F23E 37 05
; ----------------------------------------------------------------------------
        .byte   "DECRES"                        ; F240 44 45 43 52 45 53
; ----------------------------------------------------------------------------
        .word   $0538                           ; F246 38 05
; ----------------------------------------------------------------------------
        .byte   "DECTRV"                        ; F248 44 45 43 54 52 56
; ----------------------------------------------------------------------------
        .word   $000A                           ; F24E 0A 00
; ----------------------------------------------------------------------------
        .byte   "DEFAFF"                        ; F250 44 45 46 41 46 46
; ----------------------------------------------------------------------------
        .word   $0014                           ; F256 14 00
; ----------------------------------------------------------------------------
        .byte   "DESALO"                        ; F258 44 45 53 41 4C 4F
; ----------------------------------------------------------------------------
        .word   $052D                           ; F25E 2D 05
; ----------------------------------------------------------------------------
        .byte   "DLE   "                        ; F260 44 4C 45 20 20 20
; ----------------------------------------------------------------------------
        .word   $0010                           ; F266 10 00
; ----------------------------------------------------------------------------
        .byte   "DRIVE "                        ; F268 44 52 49 56 45 20
; ----------------------------------------------------------------------------
        .word   $0500                           ; F26E 00 05
; ----------------------------------------------------------------------------
        .byte   "DRVDEF"                        ; F270 44 52 56 44 45 46
; ----------------------------------------------------------------------------
        .word   $020C                           ; F276 0C 02
; ----------------------------------------------------------------------------
        .byte   "EM    "                        ; F278 45 4D 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $0019                           ; F27E 19 00
; ----------------------------------------------------------------------------
        .byte   "ENQ   "                        ; F280 45 4E 51 20 20 20
; ----------------------------------------------------------------------------
        .word   $0005                           ; F286 05 00
; ----------------------------------------------------------------------------
        .byte   "EOT   "                        ; F288 45 4F 54 20 20 20
; ----------------------------------------------------------------------------
        .word   $0004                           ; F28E 04 00
; ----------------------------------------------------------------------------
        .byte   "ERRFDC"                        ; F290 45 52 52 46 44 43
; ----------------------------------------------------------------------------
        .word   $050E                           ; F296 0E 05
; ----------------------------------------------------------------------------
        .byte   "ERRFLG"                        ; F298 45 52 52 46 4C 47
; ----------------------------------------------------------------------------
        .word   $050F                           ; F29E 0F 05
; ----------------------------------------------------------------------------
        .byte   "ERRNB "                        ; F2A0 45 52 52 4E 42 20
; ----------------------------------------------------------------------------
        .word   $0512                           ; F2A6 12 05
; ----------------------------------------------------------------------------
        .byte   "ERRVEC"                        ; F2A8 45 52 52 56 45 43
; ----------------------------------------------------------------------------
        .word   $0510                           ; F2AE 10 05
; ----------------------------------------------------------------------------
        .byte   "ESCAPE"                        ; F2B0 45 53 43 41 50 45
; ----------------------------------------------------------------------------
        .word   $001B                           ; F2B6 1B 00
; ----------------------------------------------------------------------------
        .byte   "ETB   "                        ; F2B8 45 54 42 20 20 20
; ----------------------------------------------------------------------------
        .word   $0017                           ; F2BE 17 00
; ----------------------------------------------------------------------------
        .byte   "ETX   "                        ; F2C0 45 54 58 20 20 20
; ----------------------------------------------------------------------------
        .word   $0003                           ; F2C6 03 00
; ----------------------------------------------------------------------------
        .byte   "EXBNK "                        ; F2C8 45 58 42 4E 4B 20
; ----------------------------------------------------------------------------
        .word   $040C                           ; F2CE 0C 04
; ----------------------------------------------------------------------------
        .byte   "EXSALO"                        ; F2D0 45 58 53 41 4C 4F
; ----------------------------------------------------------------------------
        .word   $0531                           ; F2D6 31 05
; ----------------------------------------------------------------------------
        .byte   "EXTDEF"                        ; F2D8 45 58 54 44 45 46
; ----------------------------------------------------------------------------
        .word   $055D                           ; F2DE 5D 05
; ----------------------------------------------------------------------------
        .byte   "FDCCR "                        ; F2E0 46 44 43 43 52 20
; ----------------------------------------------------------------------------
        .word   $0310                           ; F2E6 10 03
; ----------------------------------------------------------------------------
        .byte   "FDCDR "                        ; F2E8 46 44 43 44 52 20
; ----------------------------------------------------------------------------
        .word   $0313                           ; F2EE 13 03
; ----------------------------------------------------------------------------
        .byte   "FDCDRQ"                        ; F2F0 46 44 43 44 52 51
; ----------------------------------------------------------------------------
        .word   $0318                           ; F2F6 18 03
; ----------------------------------------------------------------------------
        .byte   "FDCSR "                        ; F2F8 46 44 43 53 52 20
; ----------------------------------------------------------------------------
        .word   $0312                           ; F2FE 12 03
; ----------------------------------------------------------------------------
        .byte   "FDCTR "                        ; F300 46 44 43 54 52 20
; ----------------------------------------------------------------------------
        .word   $0311                           ; F306 11 03
; ----------------------------------------------------------------------------
        .byte   "FF    "                        ; F308 46 46 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $000C                           ; F30E 0C 00
; ----------------------------------------------------------------------------
        .byte   "FICLON"                        ; F310 46 49 43 4C 4F 4E
; ----------------------------------------------------------------------------
        .word   $054A                           ; F316 4A 05
; ----------------------------------------------------------------------------
        .byte   "FICNUM"                        ; F318 46 49 43 4E 55 4D
; ----------------------------------------------------------------------------
        .word   $0548                           ; F31E 48 05
; ----------------------------------------------------------------------------
        .byte   "FICTYP"                        ; F320 46 49 43 54 59 50
; ----------------------------------------------------------------------------
        .word   $0547                           ; F326 47 05
; ----------------------------------------------------------------------------
        .byte   "FISALO"                        ; F328 46 49 53 41 4C 4F
; ----------------------------------------------------------------------------
        .word   $052F                           ; F32E 2F 05
; ----------------------------------------------------------------------------
        .byte   "FLDT0 "                        ; F330 46 4C 44 54 30 20
; ----------------------------------------------------------------------------
        .word   $0074                           ; F336 74 00
; ----------------------------------------------------------------------------
        .byte   "FLDT1 "                        ; F338 46 4C 44 54 31 20
; ----------------------------------------------------------------------------
        .word   $0075                           ; F33E 75 00
; ----------------------------------------------------------------------------
        .byte   "FLDT2 "                        ; F340 46 4C 44 54 32 20
; ----------------------------------------------------------------------------
        .word   $0076                           ; F346 76 00
; ----------------------------------------------------------------------------
        .byte   "FLERR "                        ; F348 46 4C 45 52 52 20
; ----------------------------------------------------------------------------
        .word   $008B                           ; F34E 8B 00
; ----------------------------------------------------------------------------
        .byte   "FLGCLK"                        ; F350 46 4C 47 43 4C 4B
; ----------------------------------------------------------------------------
        .word   $0214                           ; F356 14 02
; ----------------------------------------------------------------------------
        .byte   "FLGJCK"                        ; F358 46 4C 47 4A 43 4B
; ----------------------------------------------------------------------------
        .word   $028C                           ; F35E 8C 02
; ----------------------------------------------------------------------------
        .byte   "FLGKBD"                        ; F360 46 4C 47 4B 42 44
; ----------------------------------------------------------------------------
        .word   $0275                           ; F366 75 02
; ----------------------------------------------------------------------------
        .byte   "FLGLPR"                        ; F368 46 4C 47 4C 50 52
; ----------------------------------------------------------------------------
        .word   $028A                           ; F36E 8A 02
; ----------------------------------------------------------------------------
        .byte   "FLGMEN"                        ; F370 46 4C 47 4D 45 4E
; ----------------------------------------------------------------------------
        .word   $0068                           ; F376 68 00
; ----------------------------------------------------------------------------
        .byte   "FLGSCR"                        ; F378 46 4C 47 53 43 52
; ----------------------------------------------------------------------------
        .word   $0248                           ; F37E 48 02
; ----------------------------------------------------------------------------
        .byte   "FLGTEL"                        ; F380 46 4C 47 54 45 4C
; ----------------------------------------------------------------------------
        .word   $020D                           ; F386 0D 02
; ----------------------------------------------------------------------------
        .byte   "FLGVD0"                        ; F388 46 4C 47 56 44 30
; ----------------------------------------------------------------------------
        .word   $003C                           ; F38E 3C 00
; ----------------------------------------------------------------------------
        .byte   "FLGVD1"                        ; F390 46 4C 47 56 44 31
; ----------------------------------------------------------------------------
        .word   $003D                           ; F396 3D 00
; ----------------------------------------------------------------------------
        .byte   "FLINT "                        ; F398 46 4C 49 4E 54 20
; ----------------------------------------------------------------------------
        .word   $0088                           ; F39E 88 00
; ----------------------------------------------------------------------------
        .byte   "FLSGN "                        ; F3A0 46 4C 53 47 4E 20
; ----------------------------------------------------------------------------
        .word   $008A                           ; F3A6 8A 00
; ----------------------------------------------------------------------------
        .byte   "FLSVS "                        ; F3A8 46 4C 53 56 53 20
; ----------------------------------------------------------------------------
        .word   $0089                           ; F3AE 89 00
; ----------------------------------------------------------------------------
        .byte   "FLSVY "                        ; F3B0 46 4C 53 56 59 20
; ----------------------------------------------------------------------------
        .word   $0077                           ; F3B6 77 00
; ----------------------------------------------------------------------------
        .byte   "FLTR0 "                        ; F3B8 46 4C 54 52 30 20
; ----------------------------------------------------------------------------
        .word   $007D                           ; F3BE 7D 00
; ----------------------------------------------------------------------------
        .byte   "FLTR1 "                        ; F3C0 46 4C 54 52 31 20
; ----------------------------------------------------------------------------
        .word   $007E                           ; F3C6 7E 00
; ----------------------------------------------------------------------------
        .byte   "FS    "                        ; F3C8 46 53 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $001C                           ; F3CE 1C 00
; ----------------------------------------------------------------------------
        .byte   "FTYPE "                        ; F3D0 46 54 59 50 45 20
; ----------------------------------------------------------------------------
        .word   $052C                           ; F3D6 2C 05
; ----------------------------------------------------------------------------
        .byte   "GS    "                        ; F3D8 47 53 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $001D                           ; F3DE 1D 00
; ----------------------------------------------------------------------------
        .byte   "HRS1  "                        ; F3E0 48 52 53 31 20 20
; ----------------------------------------------------------------------------
        .word   $004D                           ; F3E6 4D 00
; ----------------------------------------------------------------------------
        .byte   "HRS2  "                        ; F3E8 48 52 53 32 20 20
; ----------------------------------------------------------------------------
        .word   $004F                           ; F3EE 4F 00
; ----------------------------------------------------------------------------
        .byte   "HRS3  "                        ; F3F0 48 52 53 33 20 20
; ----------------------------------------------------------------------------
        .word   $0051                           ; F3F6 51 00
; ----------------------------------------------------------------------------
        .byte   "HRS4  "                        ; F3F8 48 52 53 34 20 20
; ----------------------------------------------------------------------------
        .word   $0053                           ; F3FE 53 00
; ----------------------------------------------------------------------------
        .byte   "HRS5  "                        ; F400 48 52 53 35 20 20
; ----------------------------------------------------------------------------
        .word   $0055                           ; F406 55 00
; ----------------------------------------------------------------------------
        .byte   "HRSERR"                        ; F408 48 52 53 45 52 52
; ----------------------------------------------------------------------------
        .word   $02AB                           ; F40E AB 02
; ----------------------------------------------------------------------------
        .byte   "HRSFB "                        ; F410 48 52 53 46 42 20
; ----------------------------------------------------------------------------
        .word   $0057                           ; F416 57 00
; ----------------------------------------------------------------------------
        .byte   "HRSPAT"                        ; F418 48 52 53 50 41 54
; ----------------------------------------------------------------------------
        .word   $02AA                           ; F41E AA 02
; ----------------------------------------------------------------------------
        .byte   "HRSX  "                        ; F420 48 52 53 58 20 20
; ----------------------------------------------------------------------------
        .word   $0046                           ; F426 46 00
; ----------------------------------------------------------------------------
        .byte   "HRSX40"                        ; F428 48 52 53 58 34 30
; ----------------------------------------------------------------------------
        .word   $0049                           ; F42E 49 00
; ----------------------------------------------------------------------------
        .byte   "HRSX6 "                        ; F430 48 52 53 58 36 20
; ----------------------------------------------------------------------------
        .word   $004A                           ; F436 4A 00
; ----------------------------------------------------------------------------
        .byte   "HRSY  "                        ; F438 48 52 53 59 20 20
; ----------------------------------------------------------------------------
        .word   $0047                           ; F43E 47 00
; ----------------------------------------------------------------------------
        .byte   "HT    "                        ; F440 48 54 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $0009                           ; F446 09 00
; ----------------------------------------------------------------------------
        .byte   "INDFCB"                        ; F448 49 4E 44 46 43 42
; ----------------------------------------------------------------------------
        .word   $0546                           ; F44E 46 05
; ----------------------------------------------------------------------------
        .byte   "INDIC0"                        ; F450 49 4E 44 49 43 30
; ----------------------------------------------------------------------------
        .word   $0055                           ; F456 55 00
; ----------------------------------------------------------------------------
        .byte   "INDIC1"                        ; F458 49 4E 44 49 43 31
; ----------------------------------------------------------------------------
        .word   $02AA                           ; F45E AA 02
; ----------------------------------------------------------------------------
        .byte   "INDIC2"                        ; F460 49 4E 44 49 43 32
; ----------------------------------------------------------------------------
        .word   $0057                           ; F466 57 00
; ----------------------------------------------------------------------------
        .byte   "INPIS "                        ; F468 49 4E 50 49 53 20
; ----------------------------------------------------------------------------
        .word   $052D                           ; F46E 2D 05
; ----------------------------------------------------------------------------
        .byte   "INSEC "                        ; F470 49 4E 53 45 43 20
; ----------------------------------------------------------------------------
        .word   $052E                           ; F476 2E 05
; ----------------------------------------------------------------------------
        .byte   "IOTAB0"                        ; F478 49 4F 54 41 42 30
; ----------------------------------------------------------------------------
        .word   $02AE                           ; F47E AE 02
; ----------------------------------------------------------------------------
        .byte   "IOTAB1"                        ; F480 49 4F 54 41 42 31
; ----------------------------------------------------------------------------
        .word   $02B2                           ; F486 B2 02
; ----------------------------------------------------------------------------
        .byte   "IOTAB2"                        ; F488 49 4F 54 41 42 32
; ----------------------------------------------------------------------------
        .word   $02B6                           ; F48E B6 02
; ----------------------------------------------------------------------------
        .byte   "IOTAB3"                        ; F490 49 4F 54 41 42 33
; ----------------------------------------------------------------------------
        .word   $02BA                           ; F496 BA 02
; ----------------------------------------------------------------------------
        .byte   "IRQSVA"                        ; F498 49 52 51 53 56 41
; ----------------------------------------------------------------------------
        .word   $0021                           ; F49E 21 00
; ----------------------------------------------------------------------------
        .byte   "IRQSVX"                        ; F4A0 49 52 51 53 56 58
; ----------------------------------------------------------------------------
        .word   $0022                           ; F4A6 22 00
; ----------------------------------------------------------------------------
        .byte   "IRQSVY"                        ; F4A8 49 52 51 53 56 59
; ----------------------------------------------------------------------------
        .word   $0023                           ; F4AE 23 00
; ----------------------------------------------------------------------------
        .byte   "JCDVAL"                        ; F4B0 4A 43 44 56 41 4C
; ----------------------------------------------------------------------------
        .word   $028E                           ; F4B6 8E 02
; ----------------------------------------------------------------------------
        .byte   "JCGVAL"                        ; F4B8 4A 43 47 56 41 4C
; ----------------------------------------------------------------------------
        .word   $028D                           ; F4BE 8D 02
; ----------------------------------------------------------------------------
        .byte   "JCKTAB"                        ; F4C0 4A 43 4B 54 41 42
; ----------------------------------------------------------------------------
        .word   $029D                           ; F4C6 9D 02
; ----------------------------------------------------------------------------
        .byte   "LF    "                        ; F4C8 4C 46 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $000A                           ; F4CE 0A 00
; ----------------------------------------------------------------------------
        .byte   "KBDCOL"                        ; F4D0 4B 42 44 43 4F 4C
; ----------------------------------------------------------------------------
        .word   $0268                           ; F4D6 68 02
; ----------------------------------------------------------------------------
        .byte   "KBDCR "                        ; F4D8 4B 42 44 43 52 20
; ----------------------------------------------------------------------------
        .word   $0344                           ; F4DE 44 03
; ----------------------------------------------------------------------------
        .byte   "KBDCTC"                        ; F4E0 4B 42 44 43 54 43
; ----------------------------------------------------------------------------
        .word   $027E                           ; F4E6 7E 02
; ----------------------------------------------------------------------------
        .byte   "KBDDR "                        ; F4E8 4B 42 44 44 52 20
; ----------------------------------------------------------------------------
        .word   $0343                           ; F4EE 43 03
; ----------------------------------------------------------------------------
        .byte   "KBDFCT"                        ; F4F0 4B 42 44 46 43 54
; ----------------------------------------------------------------------------
        .word   $0276                           ; F4F6 76 02
; ----------------------------------------------------------------------------
        .byte   "KBDKEY"                        ; F4F8 4B 42 44 4B 45 59
; ----------------------------------------------------------------------------
        .word   $0279                           ; F4FE 79 02
; ----------------------------------------------------------------------------
        .byte   "KBDSHT"                        ; F500 4B 42 44 53 48 54
; ----------------------------------------------------------------------------
        .word   $0278                           ; F506 78 02
; ----------------------------------------------------------------------------
        .byte   "KBDSR "                        ; F508 4B 42 44 53 52 20
; ----------------------------------------------------------------------------
        .word   $0342                           ; F50E 42 03
; ----------------------------------------------------------------------------
        .byte   "KBDVRL"                        ; F510 4B 42 44 56 52 4C
; ----------------------------------------------------------------------------
        .word   $0273                           ; F516 73 02
; ----------------------------------------------------------------------------
        .byte   "KBDVRR"                        ; F518 4B 42 44 56 52 52
; ----------------------------------------------------------------------------
        .word   $0272                           ; F51E 72 02
; ----------------------------------------------------------------------------
        .byte   "KORAM "                        ; F520 4B 4F 52 41 4D 20
; ----------------------------------------------------------------------------
        .word   $020F                           ; F526 0F 02
; ----------------------------------------------------------------------------
        .byte   "KOROM "                        ; F528 4B 4F 52 4F 4D 20
; ----------------------------------------------------------------------------
        .word   $020E                           ; F52E 0E 02
; ----------------------------------------------------------------------------
        .byte   "LOCRE "                        ; F530 4C 4F 43 52 45 20
; ----------------------------------------------------------------------------
        .word   $0533                           ; F536 33 05
; ----------------------------------------------------------------------------
        .byte   "LOCREB"                        ; F538 4C 4F 43 52 45 42
; ----------------------------------------------------------------------------
        .word   $0535                           ; F53E 35 05
; ----------------------------------------------------------------------------
        .byte   "LOSALO"                        ; F540 4C 4F 53 41 4C 4F
; ----------------------------------------------------------------------------
        .word   $052A                           ; F546 2A 05
; ----------------------------------------------------------------------------
        .byte   "LPRFX "                        ; F548 4C 50 52 46 58 20
; ----------------------------------------------------------------------------
        .word   $0288                           ; F54E 88 02
; ----------------------------------------------------------------------------
        .byte   "LPRFY "                        ; F550 4C 50 52 46 59 20
; ----------------------------------------------------------------------------
        .word   $0289                           ; F556 89 02
; ----------------------------------------------------------------------------
        .byte   "LPRSY "                        ; F558 4C 50 52 53 59 20
; ----------------------------------------------------------------------------
        .word   $028B                           ; F55E 8B 02
; ----------------------------------------------------------------------------
        .byte   "LPRVEC"                        ; F560 4C 50 52 56 45 43
; ----------------------------------------------------------------------------
        .word   $024E                           ; F566 4E 02
; ----------------------------------------------------------------------------
        .byte   "LPRX  "                        ; F568 4C 50 52 58 20 20
; ----------------------------------------------------------------------------
        .word   $0286                           ; F56E 86 02
; ----------------------------------------------------------------------------
        .byte   "LPRY  "                        ; F570 4C 50 52 59 20 20
; ----------------------------------------------------------------------------
        .word   $0287                           ; F576 87 02
; ----------------------------------------------------------------------------
        .byte   "MEN   "                        ; F578 4D 45 4E 20 20 20
; ----------------------------------------------------------------------------
        .word   $0060                           ; F57E 60 00
; ----------------------------------------------------------------------------
        .byte   "MENDDX"                        ; F580 4D 45 4E 44 44 58
; ----------------------------------------------------------------------------
        .word   $0061                           ; F586 61 00
; ----------------------------------------------------------------------------
        .byte   "MENDDY"                        ; F588 4D 45 4E 44 44 59
; ----------------------------------------------------------------------------
        .word   $0062                           ; F58E 62 00
; ----------------------------------------------------------------------------
        .byte   "MENDFY"                        ; F590 4D 45 4E 44 46 59
; ----------------------------------------------------------------------------
        .word   $0063                           ; F596 63 00
; ----------------------------------------------------------------------------
        .byte   "MENDY "                        ; F598 4D 45 4E 44 59 20
; ----------------------------------------------------------------------------
        .word   $0066                           ; F59E 66 00
; ----------------------------------------------------------------------------
        .byte   "MENFY "                        ; F5A0 4D 45 4E 46 59 20
; ----------------------------------------------------------------------------
        .word   $0067                           ; F5A6 67 00
; ----------------------------------------------------------------------------
        .byte   "MENLX "                        ; F5A8 4D 45 4E 4C 58 20
; ----------------------------------------------------------------------------
        .word   $0065                           ; F5AE 65 00
; ----------------------------------------------------------------------------
        .byte   "MENX  "                        ; F5B0 4D 45 4E 58 20 20
; ----------------------------------------------------------------------------
        .word   $0064                           ; F5B6 64 00
; ----------------------------------------------------------------------------
        .byte   "NAK   "                        ; F5B8 4E 41 4B 20 20 20
; ----------------------------------------------------------------------------
        .word   $0015                           ; F5BE 15 00
; ----------------------------------------------------------------------------
        .byte   "NBCRE "                        ; F5C0 4E 42 43 52 45 20
; ----------------------------------------------------------------------------
        .word   $0539                           ; F5C6 39 05
; ----------------------------------------------------------------------------
        .byte   "NBFIC "                        ; F5C8 4E 42 46 49 43 20
; ----------------------------------------------------------------------------
        .word   $0549                           ; F5CE 49 05
; ----------------------------------------------------------------------------
        .byte   "NUL   "                        ; F5D0 4E 55 4C 20 20 20
; ----------------------------------------------------------------------------
        .word   $0000                           ; F5D6 00 00
; ----------------------------------------------------------------------------
        .byte   "PARPIS"                        ; F5D8 50 41 52 50 49 53
; ----------------------------------------------------------------------------
        .word   $052F                           ; F5DE 2F 05
; ----------------------------------------------------------------------------
        .byte   "PARSEC"                        ; F5E0 50 41 52 53 45 43
; ----------------------------------------------------------------------------
        .word   $0530                           ; F5E6 30 05
; ----------------------------------------------------------------------------
        .byte   "PISCAT"                        ; F5E8 50 49 53 43 41 54
; ----------------------------------------------------------------------------
        .word   $BFE8                           ; F5EE E8 BF
; ----------------------------------------------------------------------------
        .byte   "PISTE "                        ; F5F0 50 49 53 54 45 20
; ----------------------------------------------------------------------------
        .word   $0501                           ; F5F6 01 05
; ----------------------------------------------------------------------------
        .byte   "POSNMP"                        ; F5F8 50 4F 53 4E 4D 50
; ----------------------------------------------------------------------------
        .word   $0514                           ; F5FE 14 05
; ----------------------------------------------------------------------------
        .byte   "POSNMS"                        ; F600 50 4F 53 4E 4D 53
; ----------------------------------------------------------------------------
        .word   $0515                           ; F606 15 05
; ----------------------------------------------------------------------------
        .byte   "POSNMX"                        ; F608 50 4F 53 4E 4D 58
; ----------------------------------------------------------------------------
        .word   $0516                           ; F60E 16 05
; ----------------------------------------------------------------------------
        .byte   "REP   "                        ; F610 52 45 50 20 20 20
; ----------------------------------------------------------------------------
        .word   $0012                           ; F616 12 00
; ----------------------------------------------------------------------------
        .byte   "RES   "                        ; F618 52 45 53 20 20 20
; ----------------------------------------------------------------------------
        .word   $0000                           ; F61E 00 00
; ----------------------------------------------------------------------------
        .byte   "RESB  "                        ; F620 52 45 53 42 20 20
; ----------------------------------------------------------------------------
        .word   $0002                           ; F626 02 00
; ----------------------------------------------------------------------------
        .byte   "RS    "                        ; F628 52 53 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $001E                           ; F62E 1E 00
; ----------------------------------------------------------------------------
        .byte   "RS232C"                        ; F630 52 53 32 33 32 43
; ----------------------------------------------------------------------------
        .word   $005A                           ; F636 5A 00
; ----------------------------------------------------------------------------
        .byte   "RS232T"                        ; F638 52 53 32 33 32 54
; ----------------------------------------------------------------------------
        .word   $0059                           ; F63E 59 00
; ----------------------------------------------------------------------------
        .byte   "RWBUF "                        ; F640 52 57 42 55 46 20
; ----------------------------------------------------------------------------
        .word   $0503                           ; F646 03 05
; ----------------------------------------------------------------------------
        .byte   "RWTS  "                        ; F648 52 57 54 53 20 20
; ----------------------------------------------------------------------------
        .word   $054F                           ; F64E 4F 05
; ----------------------------------------------------------------------------
        .byte   "SAVES "                        ; F650 53 41 56 45 53 20
; ----------------------------------------------------------------------------
        .word   $0513                           ; F656 13 05
; ----------------------------------------------------------------------------
        .byte   "SCEDEB"                        ; F658 53 43 45 44 45 42
; ----------------------------------------------------------------------------
        .word   $005C                           ; F65E 5C 00
; ----------------------------------------------------------------------------
        .byte   "SCEFIN"                        ; F660 53 43 45 46 49 4E
; ----------------------------------------------------------------------------
        .word   $005E                           ; F666 5E 00
; ----------------------------------------------------------------------------
        .byte   "SCRBAH"                        ; F668 53 43 52 42 41 48
; ----------------------------------------------------------------------------
        .word   $023C                           ; F66E 3C 02
; ----------------------------------------------------------------------------
        .byte   "SCRBAL"                        ; F670 53 43 52 42 41 4C
; ----------------------------------------------------------------------------
        .word   $0238                           ; F676 38 02
; ----------------------------------------------------------------------------
        .byte   "SCRCF "                        ; F678 53 43 52 43 46 20
; ----------------------------------------------------------------------------
        .word   $0244                           ; F67E 44 02
; ----------------------------------------------------------------------------
        .byte   "SCRCT "                        ; F680 53 43 52 43 54 20
; ----------------------------------------------------------------------------
        .word   $0240                           ; F686 40 02
; ----------------------------------------------------------------------------
        .byte   "SCRDX "                        ; F688 53 43 52 44 58 20
; ----------------------------------------------------------------------------
        .word   $0228                           ; F68E 28 02
; ----------------------------------------------------------------------------
        .byte   "SCRDY "                        ; F690 53 43 52 44 59 20
; ----------------------------------------------------------------------------
        .word   $0230                           ; F696 30 02
; ----------------------------------------------------------------------------
        .byte   "SCRFX "                        ; F698 53 43 52 46 58 20
; ----------------------------------------------------------------------------
        .word   $022C                           ; F69E 2C 02
; ----------------------------------------------------------------------------
        .byte   "SCRFY "                        ; F6A0 53 43 52 46 59 20
; ----------------------------------------------------------------------------
        .word   $0234                           ; F6A6 34 02
; ----------------------------------------------------------------------------
        .byte   "SCRHIR"                        ; F6A8 53 43 52 48 49 52
; ----------------------------------------------------------------------------
        .word   $025C                           ; F6AE 5C 02
; ----------------------------------------------------------------------------
        .byte   "SCRNB "                        ; F6B0 53 43 52 4E 42 20
; ----------------------------------------------------------------------------
        .word   $0028                           ; F6B6 28 00
; ----------------------------------------------------------------------------
        .byte   "SCRTRA"                        ; F6B8 53 43 52 54 52 41
; ----------------------------------------------------------------------------
        .word   $0262                           ; F6BE 62 02
; ----------------------------------------------------------------------------
        .byte   "SCRTXT"                        ; F6C0 53 43 52 54 58 54
; ----------------------------------------------------------------------------
        .word   $0256                           ; F6C6 56 02
; ----------------------------------------------------------------------------
        .byte   "SCRX  "                        ; F6C8 53 43 52 58 20 20
; ----------------------------------------------------------------------------
        .word   $0220                           ; F6CE 20 02
; ----------------------------------------------------------------------------
        .byte   "SCRY  "                        ; F6D0 53 43 52 59 20 20
; ----------------------------------------------------------------------------
        .word   $0224                           ; F6D6 24 02
; ----------------------------------------------------------------------------
        .byte   "SECTEU"                        ; F6D8 53 45 43 54 45 55
; ----------------------------------------------------------------------------
        .word   $0502                           ; F6DE 02 05
; ----------------------------------------------------------------------------
        .byte   "SEP   "                        ; F6E0 53 45 50 20 20 20
; ----------------------------------------------------------------------------
        .word   $0013                           ; F6E6 13 00
; ----------------------------------------------------------------------------
        .byte   "SGDPAR"                        ; F6E8 53 47 44 50 41 52
; ----------------------------------------------------------------------------
        .word   $0340                           ; F6EE 40 03
; ----------------------------------------------------------------------------
        .byte   "SGDPDR"                        ; F6F0 53 47 44 50 44 52
; ----------------------------------------------------------------------------
        .word   $0341                           ; F6F6 41 03
; ----------------------------------------------------------------------------
        .byte   "SI    "                        ; F6F8 53 49 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $000F                           ; F6FE 0F 00
; ----------------------------------------------------------------------------
        .byte   "SO    "                        ; F700 53 4F 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $000E                           ; F706 0E 00
; ----------------------------------------------------------------------------
        .byte   "SOH   "                        ; F708 53 4F 48 20 20 20
; ----------------------------------------------------------------------------
        .word   $0001                           ; F70E 01 00
; ----------------------------------------------------------------------------
        .byte   "STX   "                        ; F710 53 54 58 20 20 20
; ----------------------------------------------------------------------------
        .word   $0002                           ; F716 02 00
; ----------------------------------------------------------------------------
        .byte   "SUB   "                        ; F718 53 55 42 20 20 20
; ----------------------------------------------------------------------------
        .word   $001A                           ; F71E 1A 00
; ----------------------------------------------------------------------------
        .byte   "SYN   "                        ; F720 53 59 4E 20 20 20
; ----------------------------------------------------------------------------
        .word   $0016                           ; F726 16 00
; ----------------------------------------------------------------------------
        .byte   "TABDBH"                        ; F728 54 41 42 44 42 48
; ----------------------------------------------------------------------------
        .word   $9C80                           ; F72E 80 9C
; ----------------------------------------------------------------------------
        .byte   "TABDRV"                        ; F730 54 41 42 44 52 56
; ----------------------------------------------------------------------------
        .word   $0208                           ; F736 08 02
; ----------------------------------------------------------------------------
        .byte   "TAMPFC"                        ; F738 54 41 4D 50 46 43
; ----------------------------------------------------------------------------
        .word   $0542                           ; F73E 42 05
; ----------------------------------------------------------------------------
        .byte   "TIMED "                        ; F740 54 49 4D 45 44 20
; ----------------------------------------------------------------------------
        .word   $0210                           ; F746 10 02
; ----------------------------------------------------------------------------
        .byte   "TIMEH "                        ; F748 54 49 4D 45 48 20
; ----------------------------------------------------------------------------
        .word   $0213                           ; F74E 13 02
; ----------------------------------------------------------------------------
        .byte   "TIMEM "                        ; F750 54 49 4D 45 4D 20
; ----------------------------------------------------------------------------
        .word   $0212                           ; F756 12 02
; ----------------------------------------------------------------------------
        .byte   "TIMES "                        ; F758 54 49 4D 45 53 20
; ----------------------------------------------------------------------------
        .word   $0211                           ; F75E 11 02
; ----------------------------------------------------------------------------
        .byte   "TIMEUD"                        ; F760 54 49 4D 45 55 44
; ----------------------------------------------------------------------------
        .word   $0044                           ; F766 44 00
; ----------------------------------------------------------------------------
        .byte   "TIMEUS"                        ; F768 54 49 4D 45 55 53
; ----------------------------------------------------------------------------
        .word   $0042                           ; F76E 42 00
; ----------------------------------------------------------------------------
        .byte   "TR0   "                        ; F770 54 52 30 20 20 20
; ----------------------------------------------------------------------------
        .word   $000C                           ; F776 0C 00
; ----------------------------------------------------------------------------
        .byte   "TR1   "                        ; F778 54 52 31 20 20 20
; ----------------------------------------------------------------------------
        .word   $000D                           ; F77E 0D 00
; ----------------------------------------------------------------------------
        .byte   "TR2   "                        ; F780 54 52 32 20 20 20
; ----------------------------------------------------------------------------
        .word   $000E                           ; F786 0E 00
; ----------------------------------------------------------------------------
        .byte   "TR3   "                        ; F788 54 52 33 20 20 20
; ----------------------------------------------------------------------------
        .word   $000F                           ; F78E 0F 00
; ----------------------------------------------------------------------------
        .byte   "TR4   "                        ; F790 54 52 34 20 20 20
; ----------------------------------------------------------------------------
        .word   $0010                           ; F796 10 00
; ----------------------------------------------------------------------------
        .byte   "TR5   "                        ; F798 54 52 35 20 20 20
; ----------------------------------------------------------------------------
        .word   $0011                           ; F79E 11 00
; ----------------------------------------------------------------------------
        .byte   "TR6   "                        ; F7A0 54 52 36 20 20 20
; ----------------------------------------------------------------------------
        .word   $0012                           ; F7A6 12 00
; ----------------------------------------------------------------------------
        .byte   "TR7   "                        ; F7A8 54 52 37 20 20 20
; ----------------------------------------------------------------------------
        .word   $0013                           ; F7AE 13 00
; ----------------------------------------------------------------------------
        .byte   "US    "                        ; F7B0 55 53 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $001F                           ; F7B6 1F 00
; ----------------------------------------------------------------------------
        .byte   "V1ACR "                        ; F7B8 56 31 41 43 52 20
; ----------------------------------------------------------------------------
        .word   $030B                           ; F7BE 0B 03
; ----------------------------------------------------------------------------
        .byte   "V1DDRA"                        ; F7C0 56 31 44 44 52 41
; ----------------------------------------------------------------------------
        .word   $0303                           ; F7C6 03 03
; ----------------------------------------------------------------------------
        .byte   "V1DDRB"                        ; F7C8 56 31 44 44 52 42
; ----------------------------------------------------------------------------
        .word   $0302                           ; F7CE 02 03
; ----------------------------------------------------------------------------
        .byte   "V1DRA "                        ; F7D0 56 31 44 52 41 20
; ----------------------------------------------------------------------------
        .word   $0301                           ; F7D6 01 03
; ----------------------------------------------------------------------------
        .byte   "V1DRAB"                        ; F7D8 56 31 44 52 41 42
; ----------------------------------------------------------------------------
        .word   $030F                           ; F7DE 0F 03
; ----------------------------------------------------------------------------
        .byte   "V1DRB "                        ; F7E0 56 31 44 52 42 20
; ----------------------------------------------------------------------------
        .word   $0300                           ; F7E6 00 03
; ----------------------------------------------------------------------------
        .byte   "V1IER "                        ; F7E8 56 31 49 45 52 20
; ----------------------------------------------------------------------------
        .word   $030E                           ; F7EE 0E 03
; ----------------------------------------------------------------------------
        .byte   "V1IFR "                        ; F7F0 56 31 49 46 52 20
; ----------------------------------------------------------------------------
        .word   $030D                           ; F7F6 0D 03
; ----------------------------------------------------------------------------
        .byte   "V1PCR "                        ; F7F8 56 31 50 43 52 20
; ----------------------------------------------------------------------------
        .word   $030C                           ; F7FE 0C 03
; ----------------------------------------------------------------------------
        .byte   "V1SR  "                        ; F800 56 31 53 52 20 20
; ----------------------------------------------------------------------------
        .word   $030A                           ; F806 0A 03
; ----------------------------------------------------------------------------
        .byte   "V1T1  "                        ; F808 56 31 54 31 20 20
; ----------------------------------------------------------------------------
        .word   $0304                           ; F80E 04 03
; ----------------------------------------------------------------------------
        .byte   "V1T1L "                        ; F810 56 31 54 31 4C 20
; ----------------------------------------------------------------------------
        .word   $0306                           ; F816 06 03
; ----------------------------------------------------------------------------
        .byte   "V1T2  "                        ; F818 56 31 54 32 20 20
; ----------------------------------------------------------------------------
        .word   $0308                           ; F81E 08 03
; ----------------------------------------------------------------------------
        .byte   "V2ACR "                        ; F820 56 32 41 43 52 20
; ----------------------------------------------------------------------------
        .word   $032B                           ; F826 2B 03
; ----------------------------------------------------------------------------
        .byte   "V2DDRA"                        ; F828 56 32 44 44 52 41
; ----------------------------------------------------------------------------
        .word   $0323                           ; F82E 23 03
; ----------------------------------------------------------------------------
        .byte   "V2DDRB"                        ; F830 56 32 44 44 52 42
; ----------------------------------------------------------------------------
        .word   $0322                           ; F836 22 03
; ----------------------------------------------------------------------------
        .byte   "V2DRA "                        ; F838 56 32 44 52 41 20
; ----------------------------------------------------------------------------
        .word   $0321                           ; F83E 21 03
; ----------------------------------------------------------------------------
        .byte   "V2DRAB"                        ; F840 56 32 44 52 41 42
; ----------------------------------------------------------------------------
        .word   $032F                           ; F846 2F 03
; ----------------------------------------------------------------------------
        .byte   "V2DRB "                        ; F848 56 32 44 52 42 20
; ----------------------------------------------------------------------------
        .word   $0320                           ; F84E 20 03
; ----------------------------------------------------------------------------
        .byte   "V2IER "                        ; F850 56 32 49 45 52 20
; ----------------------------------------------------------------------------
        .word   $032E                           ; F856 2E 03
; ----------------------------------------------------------------------------
        .byte   "V2IFR "                        ; F858 56 32 49 46 52 20
; ----------------------------------------------------------------------------
        .word   $032D                           ; F85E 2D 03
; ----------------------------------------------------------------------------
        .byte   "V2PCR "                        ; F860 56 32 50 43 52 20
; ----------------------------------------------------------------------------
        .word   $032C                           ; F866 2C 03
; ----------------------------------------------------------------------------
        .byte   "V2SR  "                        ; F868 56 32 53 52 20 20
; ----------------------------------------------------------------------------
        .word   $032A                           ; F86E 2A 03
; ----------------------------------------------------------------------------
        .byte   "V2T1  "                        ; F870 56 32 54 31 20 20
; ----------------------------------------------------------------------------
        .word   $0324                           ; F876 24 03
; ----------------------------------------------------------------------------
        .byte   "V2T1L "                        ; F878 56 32 54 31 4C 20
; ----------------------------------------------------------------------------
        .word   $0326                           ; F87E 26 03
; ----------------------------------------------------------------------------
        .byte   "V2T2  "                        ; F880 56 32 54 32 20 20
; ----------------------------------------------------------------------------
        .word   $0328                           ; F886 28 03
; ----------------------------------------------------------------------------
        .byte   "VAPLIC"                        ; F888 56 41 50 4C 49 43
; ----------------------------------------------------------------------------
        .word   $02FD                           ; F88E FD 02
; ----------------------------------------------------------------------------
        .byte   "VARAPL"                        ; F890 56 41 52 41 50 4C
; ----------------------------------------------------------------------------
        .word   $00D0                           ; F896 D0 00
; ----------------------------------------------------------------------------
        .byte   "VARLNB"                        ; F898 56 41 52 4C 4E 42
; ----------------------------------------------------------------------------
        .word   $0560                           ; F89E 60 05
; ----------------------------------------------------------------------------
        .byte   "VARLNG"                        ; F8A0 56 41 52 4C 4E 47
; ----------------------------------------------------------------------------
        .word   $008C                           ; F8A6 8C 00
; ----------------------------------------------------------------------------
        .byte   "VARMNB"                        ; F8A8 56 41 52 4D 4E 42
; ----------------------------------------------------------------------------
        .word   $0060                           ; F8AE 60 00
; ----------------------------------------------------------------------------
        .byte   "VCRE0 "                        ; F8B0 56 43 52 45 30 20
; ----------------------------------------------------------------------------
        .word   $053A                           ; F8B6 3A 05
; ----------------------------------------------------------------------------
        .byte   "VDTASC"                        ; F8B8 56 44 54 41 53 43
; ----------------------------------------------------------------------------
        .word   $0033                           ; F8BE 33 00
; ----------------------------------------------------------------------------
        .byte   "VDTATR"                        ; F8C0 56 44 54 41 54 52
; ----------------------------------------------------------------------------
        .word   $0034                           ; F8C6 34 00
; ----------------------------------------------------------------------------
        .byte   "VDTDES"                        ; F8C8 56 44 54 44 45 53
; ----------------------------------------------------------------------------
        .word   $9C00                           ; F8CE 00 9C
; ----------------------------------------------------------------------------
        .byte   "VDTFT "                        ; F8D0 56 44 54 46 54 20
; ----------------------------------------------------------------------------
        .word   $0035                           ; F8D6 35 00
; ----------------------------------------------------------------------------
        .byte   "VDTGX "                        ; F8D8 56 44 54 47 58 20
; ----------------------------------------------------------------------------
        .word   $003A                           ; F8DE 3A 00
; ----------------------------------------------------------------------------
        .byte   "VDTGY "                        ; F8E0 56 44 54 47 59 20
; ----------------------------------------------------------------------------
        .word   $003B                           ; F8E6 3B 00
; ----------------------------------------------------------------------------
        .byte   "VDTPAR"                        ; F8E8 56 44 54 50 41 52
; ----------------------------------------------------------------------------
        .word   $0032                           ; F8EE 32 00
; ----------------------------------------------------------------------------
        .byte   "VDTPIL"                        ; F8F0 56 44 54 50 49 4C
; ----------------------------------------------------------------------------
        .word   $0282                           ; F8F6 82 02
; ----------------------------------------------------------------------------
        .byte   "VDTX  "                        ; F8F8 56 44 54 58 20 20
; ----------------------------------------------------------------------------
        .word   $0038                           ; F8FE 38 00
; ----------------------------------------------------------------------------
        .byte   "VDTY  "                        ; F900 56 44 54 59 20 20
; ----------------------------------------------------------------------------
        .word   $0039                           ; F906 39 00
; ----------------------------------------------------------------------------
        .byte   "VEXBNK"                        ; F908 56 45 58 42 4E 4B
; ----------------------------------------------------------------------------
        .word   $0414                           ; F90E 14 04
; ----------------------------------------------------------------------------
        .byte   "VIRQ  "                        ; F910 56 49 52 51 20 20
; ----------------------------------------------------------------------------
        .word   $02FA                           ; F916 FA 02
; ----------------------------------------------------------------------------
        .byte   "VNMI  "                        ; F918 56 4E 4D 49 20 20
; ----------------------------------------------------------------------------
        .word   $02F4                           ; F91E F4 02
; ----------------------------------------------------------------------------
        .byte   "VSALO0"                        ; F920 56 53 41 4C 4F 30
; ----------------------------------------------------------------------------
        .word   $0528                           ; F926 28 05
; ----------------------------------------------------------------------------
        .byte   "VSALO1"                        ; F928 56 53 41 4C 4F 31
; ----------------------------------------------------------------------------
        .word   $0529                           ; F92E 29 05
; ----------------------------------------------------------------------------
        .byte   "VT    "                        ; F930 56 54 20 20 20 20
; ----------------------------------------------------------------------------
        .word   $000B                           ; F936 0B 00
; ----------------------------------------------------------------------------
        .byte   "XA1A2 "                        ; F938 58 41 31 41 32 20
; ----------------------------------------------------------------------------
        .word   $007E                           ; F93E 7E 00
; ----------------------------------------------------------------------------
        .byte   "XA1AFF"                        ; F940 58 41 31 41 46 46
; ----------------------------------------------------------------------------
        .word   $002B                           ; F946 2B 00
; ----------------------------------------------------------------------------
        .byte   "XA1DEC"                        ; F948 58 41 31 44 45 43
; ----------------------------------------------------------------------------
        .word   $0068                           ; F94E 68 00
; ----------------------------------------------------------------------------
        .byte   "XA1IAY"                        ; F950 58 41 31 49 41 59
; ----------------------------------------------------------------------------
        .word   $0082                           ; F956 82 00
; ----------------------------------------------------------------------------
        .byte   "XA1MA2"                        ; F958 58 41 31 4D 41 32
; ----------------------------------------------------------------------------
        .word   $006C                           ; F95E 6C 00
; ----------------------------------------------------------------------------
        .byte   "XA1PA2"                        ; F960 58 41 31 50 41 32
; ----------------------------------------------------------------------------
        .word   $006A                           ; F966 6A 00
; ----------------------------------------------------------------------------
        .byte   "XA1XY "                        ; F968 58 41 31 58 59 20
; ----------------------------------------------------------------------------
        .word   $0083                           ; F96E 83 00
; ----------------------------------------------------------------------------
        .byte   "XA2A1 "                        ; F970 58 41 32 41 31 20
; ----------------------------------------------------------------------------
        .word   $007F                           ; F976 7F 00
; ----------------------------------------------------------------------------
        .byte   "XA2DA1"                        ; F978 58 41 32 44 41 31
; ----------------------------------------------------------------------------
        .word   $006D                           ; F97E 6D 00
; ----------------------------------------------------------------------------
        .byte   "XA2EA1"                        ; F980 58 41 32 45 41 31
; ----------------------------------------------------------------------------
        .word   $006E                           ; F986 6E 00
; ----------------------------------------------------------------------------
        .byte   "XA2NA1"                        ; F988 58 41 32 4E 41 31
; ----------------------------------------------------------------------------
        .word   $006B                           ; F98E 6B 00
; ----------------------------------------------------------------------------
        .byte   "XAA1  "                        ; F990 58 41 41 31 20 20
; ----------------------------------------------------------------------------
        .word   $0084                           ; F996 84 00
; ----------------------------------------------------------------------------
        .byte   "XABOX "                        ; F998 58 41 42 4F 58 20
; ----------------------------------------------------------------------------
        .word   $0095                           ; F99E 95 00
; ----------------------------------------------------------------------------
        .byte   "XADNXT"                        ; F9A0 58 41 44 4E 58 54
; ----------------------------------------------------------------------------
        .word   $0085                           ; F9A6 85 00
; ----------------------------------------------------------------------------
        .byte   "XADRES"                        ; F9A8 58 41 44 52 45 53
; ----------------------------------------------------------------------------
        .word   $0022                           ; F9AE 22 00
; ----------------------------------------------------------------------------
        .byte   "XALLKB"                        ; F9B0 58 41 4C 4C 4B 42
; ----------------------------------------------------------------------------
        .word   $0050                           ; F9B6 50 00
; ----------------------------------------------------------------------------
        .byte   "XAPPEN"                        ; F9B8 58 41 50 50 45 4E
; ----------------------------------------------------------------------------
        .word   $FF26                           ; F9BE 26 FF
; ----------------------------------------------------------------------------
        .byte   "XATN  "                        ; F9C0 58 41 54 4E 20 20
; ----------------------------------------------------------------------------
        .word   $0073                           ; F9C6 73 00
; ----------------------------------------------------------------------------
        .byte   "XAYA1 "                        ; F9C8 58 41 59 41 31 20
; ----------------------------------------------------------------------------
        .word   $0081                           ; F9CE 81 00
; ----------------------------------------------------------------------------
        .byte   "XBINDX"                        ; F9D0 58 42 49 4E 44 58
; ----------------------------------------------------------------------------
        .word   $0028                           ; F9D6 28 00
; ----------------------------------------------------------------------------
        .byte   "XBKP  "                        ; F9D8 58 42 4B 50 20 20
; ----------------------------------------------------------------------------
        .word   $FF59                           ; F9DE 59 FF
; ----------------------------------------------------------------------------
        .byte   "XBOX  "                        ; F9E0 58 42 4F 58 20 20
; ----------------------------------------------------------------------------
        .word   $0094                           ; F9E6 94 00
; ----------------------------------------------------------------------------
        .byte   "XBUCA "                        ; F9E8 58 42 55 43 41 20
; ----------------------------------------------------------------------------
        .word   $FF86                           ; F9EE 86 FF
; ----------------------------------------------------------------------------
        .byte   "XBUSY "                        ; F9F0 58 42 55 53 59 20
; ----------------------------------------------------------------------------
        .word   $005A                           ; F9F6 5A 00
; ----------------------------------------------------------------------------
        .byte   "XCABU "                        ; F9F8 58 43 41 42 55 20
; ----------------------------------------------------------------------------
        .word   $FF83                           ; F9FE 83 FF
; ----------------------------------------------------------------------------
        .byte   "XCHAR "                        ; FA00 58 43 48 41 52 20
; ----------------------------------------------------------------------------
        .word   $0097                           ; FA06 97 00
; ----------------------------------------------------------------------------
        .byte   "XCIRCL"                        ; FA08 58 43 49 52 43 4C
; ----------------------------------------------------------------------------
        .word   $008F                           ; FA0E 8F 00
; ----------------------------------------------------------------------------
        .byte   "XCL0  "                        ; FA10 58 43 4C 30 20 20
; ----------------------------------------------------------------------------
        .word   $0004                           ; FA16 04 00
; ----------------------------------------------------------------------------
        .byte   "XCL1  "                        ; FA18 58 43 4C 31 20 20
; ----------------------------------------------------------------------------
        .word   $0005                           ; FA1E 05 00
; ----------------------------------------------------------------------------
        .byte   "XCL2  "                        ; FA20 58 43 4C 32 20 20
; ----------------------------------------------------------------------------
        .word   $0006                           ; FA26 06 00
; ----------------------------------------------------------------------------
        .byte   "XCL3  "                        ; FA28 58 43 4C 33 20 20
; ----------------------------------------------------------------------------
        .word   $0007                           ; FA2E 07 00
; ----------------------------------------------------------------------------
        .byte   "XCLCLK"                        ; FA30 58 43 4C 43 4C 4B
; ----------------------------------------------------------------------------
        .word   $003D                           ; FA36 3D 00
; ----------------------------------------------------------------------------
        .byte   "XCLOSE"                        ; FA38 58 43 4C 4F 53 45
; ----------------------------------------------------------------------------
        .word   $FF1D                           ; FA3E 1D FF
; ----------------------------------------------------------------------------
        .byte   "XCONSO"                        ; FA40 58 43 4F 4E 53 4F
; ----------------------------------------------------------------------------
        .word   $005D                           ; FA46 5D 00
; ----------------------------------------------------------------------------
        .byte   "XCOPY "                        ; FA48 58 43 4F 50 59 20
; ----------------------------------------------------------------------------
        .word   $FF38                           ; FA4E 38 FF
; ----------------------------------------------------------------------------
        .byte   "XCOS  "                        ; FA50 58 43 4F 53 20 20
; ----------------------------------------------------------------------------
        .word   $0071                           ; FA56 71 00
; ----------------------------------------------------------------------------
        .byte   "XCOSCR"                        ; FA58 58 43 4F 53 43 52
; ----------------------------------------------------------------------------
        .word   $0034                           ; FA5E 34 00
; ----------------------------------------------------------------------------
        .byte   "XCREAY"                        ; FA60 58 43 52 45 41 59
; ----------------------------------------------------------------------------
        .word   $FF71                           ; FA66 71 FF
; ----------------------------------------------------------------------------
        .byte   "XCRLF "                        ; FA68 58 43 52 4C 46 20
; ----------------------------------------------------------------------------
        .word   $0025                           ; FA6E 25 00
; ----------------------------------------------------------------------------
        .byte   "XCSSCR"                        ; FA70 58 43 53 53 43 52
; ----------------------------------------------------------------------------
        .word   $0035                           ; FA76 35 00
; ----------------------------------------------------------------------------
        .byte   "XCURMO"                        ; FA78 58 43 55 52 4D 4F
; ----------------------------------------------------------------------------
        .word   $0091                           ; FA7E 91 00
; ----------------------------------------------------------------------------
        .byte   "XCURSE"                        ; FA80 58 43 55 52 53 45
; ----------------------------------------------------------------------------
        .word   $0090                           ; FA86 90 00
; ----------------------------------------------------------------------------
        .byte   "XDECA1"                        ; FA88 58 44 45 43 41 31
; ----------------------------------------------------------------------------
        .word   $0069                           ; FA8E 69 00
; ----------------------------------------------------------------------------
        .byte   "XDECAL"                        ; FA90 58 44 45 43 41 4C
; ----------------------------------------------------------------------------
        .word   $0018                           ; FA96 18 00
; ----------------------------------------------------------------------------
        .byte   "XDECAY"                        ; FA98 58 44 45 43 41 59
; ----------------------------------------------------------------------------
        .word   $0026                           ; FA9E 26 00
; ----------------------------------------------------------------------------
        .byte   "XDECIM"                        ; FAA0 58 44 45 43 49 4D
; ----------------------------------------------------------------------------
        .word   $0029                           ; FAA6 29 00
; ----------------------------------------------------------------------------
        .byte   "XDECON"                        ; FAA8 58 44 45 43 4F 4E
; ----------------------------------------------------------------------------
        .word   $0065                           ; FAAE 65 00
; ----------------------------------------------------------------------------
        .byte   "XDEFBU"                        ; FAB0 58 44 45 46 42 55
; ----------------------------------------------------------------------------
        .word   $0059                           ; FAB6 59 00
; ----------------------------------------------------------------------------
        .byte   "XDEFLO"                        ; FAB8 58 44 45 46 4C 4F
; ----------------------------------------------------------------------------
        .word   $FF68                           ; FABE 68 FF
; ----------------------------------------------------------------------------
        .byte   "XDEFSA"                        ; FAC0 58 44 45 46 53 41
; ----------------------------------------------------------------------------
        .word   $FF65                           ; FAC6 65 FF
; ----------------------------------------------------------------------------
        .byte   "XDEG  "                        ; FAC8 58 44 45 47 20 20
; ----------------------------------------------------------------------------
        .word   $007A                           ; FACE 7A 00
; ----------------------------------------------------------------------------
        .byte   "XDELBK"                        ; FAD0 58 44 45 4C 42 4B
; ----------------------------------------------------------------------------
        .word   $FF4A                           ; FAD6 4A FF
; ----------------------------------------------------------------------------
        .byte   "XDELN "                        ; FAD8 58 44 45 4C 4E 20
; ----------------------------------------------------------------------------
        .word   $FF4D                           ; FADE 4D FF
; ----------------------------------------------------------------------------
        .byte   "XDETSE"                        ; FAE0 58 44 45 54 53 45
; ----------------------------------------------------------------------------
        .word   $FF74                           ; FAE6 74 FF
; ----------------------------------------------------------------------------
        .byte   "XDIRN "                        ; FAE8 58 44 49 52 4E 20
; ----------------------------------------------------------------------------
        .word   $FF56                           ; FAEE 56 FF
; ----------------------------------------------------------------------------
        .byte   "XDIVIS"                        ; FAF0 58 44 49 56 49 53
; ----------------------------------------------------------------------------
        .word   $0023                           ; FAF6 23 00
; ----------------------------------------------------------------------------
        .byte   "XDNAME"                        ; FAF8 58 44 4E 41 4D 45
; ----------------------------------------------------------------------------
        .word   $FF3B                           ; FAFE 3B FF
; ----------------------------------------------------------------------------
        .byte   "XDRAWA"                        ; FB00 58 44 52 41 57 41
; ----------------------------------------------------------------------------
        .word   $008D                           ; FB06 8D 00
; ----------------------------------------------------------------------------
        .byte   "XDRAWR"                        ; FB08 58 44 52 41 57 52
; ----------------------------------------------------------------------------
        .word   $008E                           ; FB0E 8E 00
; ----------------------------------------------------------------------------
        .byte   "XECRBU"                        ; FB10 58 45 43 52 42 55
; ----------------------------------------------------------------------------
        .word   $0054                           ; FB16 54 00
; ----------------------------------------------------------------------------
        .byte   "XECRPR"                        ; FB18 58 45 43 52 50 52
; ----------------------------------------------------------------------------
        .word   $0033                           ; FB1E 33 00
; ----------------------------------------------------------------------------
        .byte   "XEDT  "                        ; FB20 58 45 44 54 20 20
; ----------------------------------------------------------------------------
        .word   $002D                           ; FB26 2D 00
; ----------------------------------------------------------------------------
        .byte   "XEDTIN"                        ; FB28 58 45 44 54 49 4E
; ----------------------------------------------------------------------------
        .word   $0032                           ; FB2E 32 00
; ----------------------------------------------------------------------------
        .byte   "XEFFHI"                        ; FB30 58 45 46 46 48 49
; ----------------------------------------------------------------------------
        .word   $001B                           ; FB36 1B 00
; ----------------------------------------------------------------------------
        .byte   "XEPSG "                        ; FB38 58 45 50 53 47 20
; ----------------------------------------------------------------------------
        .word   $0041                           ; FB3E 41 00
; ----------------------------------------------------------------------------
        .byte   "XERREU"                        ; FB40 58 45 52 52 45 55
; ----------------------------------------------------------------------------
        .word   $FF5F                           ; FB46 5F FF
; ----------------------------------------------------------------------------
        .byte   "XERVEC"                        ; FB48 58 45 52 56 45 43
; ----------------------------------------------------------------------------
        .word   $FF32                           ; FB4E 32 FF
; ----------------------------------------------------------------------------
        .byte   "XESAVE"                        ; FB50 58 45 53 41 56 45
; ----------------------------------------------------------------------------
        .word   $FF35                           ; FB56 35 FF
; ----------------------------------------------------------------------------
        .byte   "XEXP  "                        ; FB58 58 45 58 50 20 20
; ----------------------------------------------------------------------------
        .word   $0074                           ; FB5E 74 00
; ----------------------------------------------------------------------------
        .byte   "XEXPLO"                        ; FB60 58 45 58 50 4C 4F
; ----------------------------------------------------------------------------
        .word   $009C                           ; FB66 9C 00
; ----------------------------------------------------------------------------
        .byte   "XFIELD"                        ; FB68 58 46 49 45 4C 44
; ----------------------------------------------------------------------------
        .word   $054C                           ; FB6E 4C 05
; ----------------------------------------------------------------------------
        .byte   "XFILL "                        ; FB70 58 46 49 4C 4C 20
; ----------------------------------------------------------------------------
        .word   $0096                           ; FB76 96 00
; ----------------------------------------------------------------------------
        .byte   "XFILLM"                        ; FB78 58 46 49 4C 4C 4D
; ----------------------------------------------------------------------------
        .word   $001C                           ; FB7E 1C 00
; ----------------------------------------------------------------------------
        .byte   "XFORMA"                        ; FB80 58 46 4F 52 4D 41
; ----------------------------------------------------------------------------
        .word   $FF44                           ; FB86 44 FF
; ----------------------------------------------------------------------------
        .byte   "XFST  "                        ; FB88 58 46 53 54 20 20
; ----------------------------------------------------------------------------
        .word   $FF11                           ; FB8E 11 FF
; ----------------------------------------------------------------------------
        .byte   "XGOKBD"                        ; FB90 58 47 4F 4B 42 44
; ----------------------------------------------------------------------------
        .word   $0052                           ; FB96 52 00
; ----------------------------------------------------------------------------
        .byte   "XHCHRS"                        ; FB98 58 48 43 48 52 53
; ----------------------------------------------------------------------------
        .word   $004C                           ; FB9E 4C 00
; ----------------------------------------------------------------------------
        .byte   "XHCSCR"                        ; FBA0 58 48 43 53 43 52
; ----------------------------------------------------------------------------
        .word   $004A                           ; FBA6 4A 00
; ----------------------------------------------------------------------------
        .byte   "XHCVDT"                        ; FBA8 58 48 43 56 44 54
; ----------------------------------------------------------------------------
        .word   $004B                           ; FBAE 4B 00
; ----------------------------------------------------------------------------
        .byte   "XHEXA "                        ; FBB0 58 48 45 58 41 20
; ----------------------------------------------------------------------------
        .word   $002A                           ; FBB6 2A 00
; ----------------------------------------------------------------------------
        .byte   "XHIRES"                        ; FBB8 58 48 49 52 45 53
; ----------------------------------------------------------------------------
        .word   $001A                           ; FBBE 1A 00
; ----------------------------------------------------------------------------
        .byte   "XHRSSE"                        ; FBC0 58 48 52 53 53 45
; ----------------------------------------------------------------------------
        .word   $008C                           ; FBC6 8C 00
; ----------------------------------------------------------------------------
        .byte   "XINIBU"                        ; FBC8 58 49 4E 49 42 55
; ----------------------------------------------------------------------------
        .word   $0058                           ; FBCE 58 00
; ----------------------------------------------------------------------------
        .byte   "XINITI"                        ; FBD0 58 49 4E 49 54 49
; ----------------------------------------------------------------------------
        .word   $FF5C                           ; FBD6 5C FF
; ----------------------------------------------------------------------------
        .byte   "XINK  "                        ; FBD8 58 49 4E 4B 20 20
; ----------------------------------------------------------------------------
        .word   $0093                           ; FBDE 93 00
; ----------------------------------------------------------------------------
        .byte   "XINSER"                        ; FBE0 58 49 4E 53 45 52
; ----------------------------------------------------------------------------
        .word   $002E                           ; FBE6 2E 00
; ----------------------------------------------------------------------------
        .byte   "XINT  "                        ; FBE8 58 49 4E 54 20 20
; ----------------------------------------------------------------------------
        .word   $007B                           ; FBEE 7B 00
; ----------------------------------------------------------------------------
        .byte   "XINTEG"                        ; FBF0 58 49 4E 54 45 47
; ----------------------------------------------------------------------------
        .word   $0086                           ; FBF6 86 00
; ----------------------------------------------------------------------------
        .byte   "XIYAA1"                        ; FBF8 58 49 59 41 41 31
; ----------------------------------------------------------------------------
        .word   $0080                           ; FBFE 80 00
; ----------------------------------------------------------------------------
        .byte   "XJUMP "                        ; FC00 58 4A 55 4D 50 20
; ----------------------------------------------------------------------------
        .word   $FF2C                           ; FC06 2C FF
; ----------------------------------------------------------------------------
        .byte   "XKBD  "                        ; FC08 58 4B 42 44 20 20
; ----------------------------------------------------------------------------
        .word   $0080                           ; FC0E 80 00
; ----------------------------------------------------------------------------
        .byte   "XKBDAS"                        ; FC10 58 4B 42 44 41 53
; ----------------------------------------------------------------------------
        .word   $0051                           ; FC16 51 00
; ----------------------------------------------------------------------------
        .byte   "XLGBUF"                        ; FC18 58 4C 47 42 55 46
; ----------------------------------------------------------------------------
        .word   $FF2F                           ; FC1E 2F FF
; ----------------------------------------------------------------------------
        .byte   "XLIBSE"                        ; FC20 58 4C 49 42 53 45
; ----------------------------------------------------------------------------
        .word   $FF77                           ; FC26 77 FF
; ----------------------------------------------------------------------------
        .byte   "XLIGNE"                        ; FC28 58 4C 49 47 4E 45
; ----------------------------------------------------------------------------
        .word   $0064                           ; FC2E 64 00
; ----------------------------------------------------------------------------
        .byte   "XLISBU"                        ; FC30 58 4C 49 53 42 55
; ----------------------------------------------------------------------------
        .word   $0055                           ; FC36 55 00
; ----------------------------------------------------------------------------
        .byte   "XLN   "                        ; FC38 58 4C 4E 20 20 20
; ----------------------------------------------------------------------------
        .word   $0075                           ; FC3E 75 00
; ----------------------------------------------------------------------------
        .byte   "XLOAD "                        ; FC40 58 4C 4F 41 44 20
; ----------------------------------------------------------------------------
        .word   $FF62                           ; FC46 62 FF
; ----------------------------------------------------------------------------
        .byte   "XLOG  "                        ; FC48 58 4C 4F 47 20 20
; ----------------------------------------------------------------------------
        .word   $0076                           ; FC4E 76 00
; ----------------------------------------------------------------------------
        .byte   "XLPCRL"                        ; FC50 58 4C 50 43 52 4C
; ----------------------------------------------------------------------------
        .word   $0049                           ; FC56 49 00
; ----------------------------------------------------------------------------
        .byte   "XLPR  "                        ; FC58 58 4C 50 52 20 20
; ----------------------------------------------------------------------------
        .word   $008E                           ; FC5E 8E 00
; ----------------------------------------------------------------------------
        .byte   "XLPRBI"                        ; FC60 58 4C 50 52 42 49
; ----------------------------------------------------------------------------
        .word   $0048                           ; FC66 48 00
; ----------------------------------------------------------------------------
        .byte   "XMDE  "                        ; FC68 58 4D 44 45 20 20
; ----------------------------------------------------------------------------
        .word   $0082                           ; FC6E 82 00
; ----------------------------------------------------------------------------
        .byte   "XMDS  "                        ; FC70 58 4D 44 53 20 20
; ----------------------------------------------------------------------------
        .word   $008F                           ; FC76 8F 00
; ----------------------------------------------------------------------------
        .byte   "XMENU "                        ; FC78 58 4D 45 4E 55 20
; ----------------------------------------------------------------------------
        .word   $002C                           ; FC7E 2C 00
; ----------------------------------------------------------------------------
        .byte   "XMERGE"                        ; FC80 58 4D 45 52 47 45
; ----------------------------------------------------------------------------
        .word   $FF0E                           ; FC86 0E FF
; ----------------------------------------------------------------------------
        .byte   "XMIE  "                        ; FC88 58 4D 49 45 20 20
; ----------------------------------------------------------------------------
        .word   $0084                           ; FC8E 84 00
; ----------------------------------------------------------------------------
        .byte   "XMINMA"                        ; FC90 58 4D 49 4E 4D 41
; ----------------------------------------------------------------------------
        .word   $001F                           ; FC96 1F 00
; ----------------------------------------------------------------------------
        .byte   "XMIS  "                        ; FC98 58 4D 49 53 20 20
; ----------------------------------------------------------------------------
        .word   $008C                           ; FC9E 8C 00
; ----------------------------------------------------------------------------
        .byte   "XMLOAD"                        ; FCA0 58 4D 4C 4F 41 44
; ----------------------------------------------------------------------------
        .word   $0060                           ; FCA6 60 00
; ----------------------------------------------------------------------------
        .byte   "XMOUT "                        ; FCA8 58 4D 4F 55 54 20
; ----------------------------------------------------------------------------
        .word   $0066                           ; FCAE 66 00
; ----------------------------------------------------------------------------
        .byte   "XMSAVE"                        ; FCB0 58 4D 53 41 56 45
; ----------------------------------------------------------------------------
        .word   $0061                           ; FCB6 61 00
; ----------------------------------------------------------------------------
        .byte   "XMUL40"                        ; FCB8 58 4D 55 4C 34 30
; ----------------------------------------------------------------------------
        .word   $0020                           ; FCBE 20 00
; ----------------------------------------------------------------------------
        .byte   "XMULT "                        ; FCC0 58 4D 55 4C 54 20
; ----------------------------------------------------------------------------
        .word   $0021                           ; FCC6 21 00
; ----------------------------------------------------------------------------
        .byte   "XMUSIC"                        ; FCC8 58 4D 55 53 49 43
; ----------------------------------------------------------------------------
        .word   $0045                           ; FCCE 45 00
; ----------------------------------------------------------------------------
        .byte   "XNA1  "                        ; FCD0 58 4E 41 31 20 20
; ----------------------------------------------------------------------------
        .word   $006F                           ; FCD6 6F 00
; ----------------------------------------------------------------------------
        .byte   "XNOMDE"                        ; FCD8 58 4E 4F 4D 44 45
; ----------------------------------------------------------------------------
        .word   $FF6E                           ; FCDE 6E FF
; ----------------------------------------------------------------------------
        .byte   "XNOMFI"                        ; FCE0 58 4E 4F 4D 46 49
; ----------------------------------------------------------------------------
        .word   $0024                           ; FCE6 24 00
; ----------------------------------------------------------------------------
        .byte   "XOP0  "                        ; FCE8 58 4F 50 30 20 20
; ----------------------------------------------------------------------------
        .word   $0000                           ; FCEE 00 00
; ----------------------------------------------------------------------------
        .byte   "XOP1  "                        ; FCF0 58 4F 50 31 20 20
; ----------------------------------------------------------------------------
        .word   $0001                           ; FCF6 01 00
; ----------------------------------------------------------------------------
        .byte   "XOP2  "                        ; FCF8 58 4F 50 32 20 20
; ----------------------------------------------------------------------------
        .word   $0002                           ; FCFE 02 00
; ----------------------------------------------------------------------------
        .byte   "XOP3  "                        ; FD00 58 4F 50 33 20 20
; ----------------------------------------------------------------------------
        .word   $0003                           ; FD06 03 00
; ----------------------------------------------------------------------------
        .byte   "XOPEN "                        ; FD08 58 4F 50 45 4E 20
; ----------------------------------------------------------------------------
        .word   $FF1A                           ; FD0E 1A FF
; ----------------------------------------------------------------------------
        .byte   "XOUPS "                        ; FD10 58 4F 55 50 53 20
; ----------------------------------------------------------------------------
        .word   $0042                           ; FD16 42 00
; ----------------------------------------------------------------------------
        .byte   "XPAPER"                        ; FD18 58 50 41 50 45 52
; ----------------------------------------------------------------------------
        .word   $0092                           ; FD1E 92 00
; ----------------------------------------------------------------------------
        .byte   "XPBUF1"                        ; FD20 58 50 42 55 46 31
; ----------------------------------------------------------------------------
        .word   $FFA4                           ; FD26 A4 FF
; ----------------------------------------------------------------------------
        .byte   "XPI   "                        ; FD28 58 50 49 20 20 20
; ----------------------------------------------------------------------------
        .word   $007C                           ; FD2E 7C 00
; ----------------------------------------------------------------------------
        .byte   "XPING "                        ; FD30 58 50 49 4E 47 20
; ----------------------------------------------------------------------------
        .word   $009D                           ; FD36 9D 00
; ----------------------------------------------------------------------------
        .byte   "XPLAY "                        ; FD38 58 50 4C 41 59 20
; ----------------------------------------------------------------------------
        .word   $0043                           ; FD3E 43 00
; ----------------------------------------------------------------------------
        .byte   "XPMAP "                        ; FD40 58 50 4D 41 50 20
; ----------------------------------------------------------------------------
        .word   $FFA7                           ; FD46 A7 FF
; ----------------------------------------------------------------------------
        .byte   "XPROT "                        ; FD48 58 50 52 4F 54 20
; ----------------------------------------------------------------------------
        .word   $FF50                           ; FD4E 50 FF
; ----------------------------------------------------------------------------
        .byte   "XPRSEC"                        ; FD50 58 50 52 53 45 43
; ----------------------------------------------------------------------------
        .word   $FFA1                           ; FD56 A1 FF
; ----------------------------------------------------------------------------
        .byte   "XPUT  "                        ; FD58 58 50 55 54 20 20
; ----------------------------------------------------------------------------
        .word   $FF23                           ; FD5E 23 FF
; ----------------------------------------------------------------------------
        .byte   "XRAD  "                        ; FD60 58 52 41 44 20 20
; ----------------------------------------------------------------------------
        .word   $0079                           ; FD66 79 00
; ----------------------------------------------------------------------------
        .byte   "XRAND "                        ; FD68 58 52 41 4E 44 20
; ----------------------------------------------------------------------------
        .word   $007D                           ; FD6E 7D 00
; ----------------------------------------------------------------------------
        .byte   "XRD0  "                        ; FD70 58 52 44 30 20 20
; ----------------------------------------------------------------------------
        .word   $0008                           ; FD76 08 00
; ----------------------------------------------------------------------------
        .byte   "XRD1  "                        ; FD78 58 52 44 31 20 20
; ----------------------------------------------------------------------------
        .word   $0009                           ; FD7E 09 00
; ----------------------------------------------------------------------------
        .byte   "XRD2  "                        ; FD80 58 52 44 32 20 20
; ----------------------------------------------------------------------------
        .word   $000A                           ; FD86 0A 00
; ----------------------------------------------------------------------------
        .byte   "XRD3  "                        ; FD88 58 52 44 33 20 20
; ----------------------------------------------------------------------------
        .word   $000B                           ; FD8E 0B 00
; ----------------------------------------------------------------------------
        .byte   "XRDW0 "                        ; FD90 58 52 44 57 30 20
; ----------------------------------------------------------------------------
        .word   $000C                           ; FD96 0C 00
; ----------------------------------------------------------------------------
        .byte   "XRDW1 "                        ; FD98 58 52 44 57 31 20
; ----------------------------------------------------------------------------
        .word   $000D                           ; FD9E 0D 00
; ----------------------------------------------------------------------------
        .byte   "XRDW2 "                        ; FDA0 58 52 44 57 32 20
; ----------------------------------------------------------------------------
        .word   $000E                           ; FDA6 0E 00
; ----------------------------------------------------------------------------
        .byte   "XRDW3 "                        ; FDA8 58 52 44 57 33 20
; ----------------------------------------------------------------------------
        .word   $000F                           ; FDAE 0F 00
; ----------------------------------------------------------------------------
        .byte   "XREN  "                        ; FDB0 58 52 45 4E 20 20
; ----------------------------------------------------------------------------
        .word   $FF47                           ; FDB6 47 FF
; ----------------------------------------------------------------------------
        .byte   "XREWIN"                        ; FDB8 58 52 45 57 49 4E
; ----------------------------------------------------------------------------
        .word   $FF29                           ; FDBE 29 FF
; ----------------------------------------------------------------------------
        .byte   "XRING "                        ; FDC0 58 52 49 4E 47 20
; ----------------------------------------------------------------------------
        .word   $0062                           ; FDC6 62 00
; ----------------------------------------------------------------------------
        .byte   "XRND  "                        ; FDC8 58 52 4E 44 20 20
; ----------------------------------------------------------------------------
        .word   $0077                           ; FDCE 77 00
; ----------------------------------------------------------------------------
        .byte   "XRSE  "                        ; FDD0 58 52 53 45 20 20
; ----------------------------------------------------------------------------
        .word   $0083                           ; FDD6 83 00
; ----------------------------------------------------------------------------
        .byte   "XRSS  "                        ; FDD8 58 52 53 53 20 20
; ----------------------------------------------------------------------------
        .word   $0090                           ; FDDE 90 00
; ----------------------------------------------------------------------------
        .byte   "XRWTS "                        ; FDE0 58 52 57 54 53 20
; ----------------------------------------------------------------------------
        .word   $FFAA                           ; FDE6 AA FF
; ----------------------------------------------------------------------------
        .byte   "XSAVE "                        ; FDE8 58 53 41 56 45 20
; ----------------------------------------------------------------------------
        .word   $FF6B                           ; FDEE 6B FF
; ----------------------------------------------------------------------------
        .byte   "XSAY  "                        ; FDF0 58 53 41 59 20 20
; ----------------------------------------------------------------------------
        .word   $FF8F                           ; FDF6 8F FF
; ----------------------------------------------------------------------------
        .byte   "XSBUF1"                        ; FDF8 58 53 42 55 46 31
; ----------------------------------------------------------------------------
        .word   $FF92                           ; FDFE 92 FF
; ----------------------------------------------------------------------------
        .byte   "XSBUF2"                        ; FE00 58 53 42 55 46 32
; ----------------------------------------------------------------------------
        .word   $FF95                           ; FE06 95 FF
; ----------------------------------------------------------------------------
        .byte   "XSBUF3"                        ; FE08 58 53 42 55 46 33
; ----------------------------------------------------------------------------
        .word   $FF98                           ; FE0E 98 FF
; ----------------------------------------------------------------------------
        .byte   "XSC1  "                        ; FE10 58 53 43 31 20 20
; ----------------------------------------------------------------------------
        .word   $0089                           ; FE16 89 00
; ----------------------------------------------------------------------------
        .byte   "XSC2  "                        ; FE18 58 53 43 32 20 20
; ----------------------------------------------------------------------------
        .word   $008A                           ; FE1E 8A 00
; ----------------------------------------------------------------------------
        .byte   "XSC3  "                        ; FE20 58 53 43 33 20 20
; ----------------------------------------------------------------------------
        .word   $008B                           ; FE26 8B 00
; ----------------------------------------------------------------------------
        .byte   "XSCAT "                        ; FE28 58 53 43 41 54 20
; ----------------------------------------------------------------------------
        .word   $FF9B                           ; FE2E 9B FF
; ----------------------------------------------------------------------------
        .byte   "XSCELG"                        ; FE30 58 53 43 45 4C 47
; ----------------------------------------------------------------------------
        .word   $002F                           ; FE36 2F 00
; ----------------------------------------------------------------------------
        .byte   "XSCHAR"                        ; FE38 58 53 43 48 41 52
; ----------------------------------------------------------------------------
        .word   $0098                           ; FE3E 98 00
; ----------------------------------------------------------------------------
        .byte   "XSCR  "                        ; FE40 58 53 43 52 20 20
; ----------------------------------------------------------------------------
        .word   $0088                           ; FE46 88 00
; ----------------------------------------------------------------------------
        .byte   "XSCRNE"                        ; FE48 58 53 43 52 4E 45
; ----------------------------------------------------------------------------
        .word   $0039                           ; FE4E 39 00
; ----------------------------------------------------------------------------
        .byte   "XSCROB"                        ; FE50 58 53 43 52 4F 42
; ----------------------------------------------------------------------------
        .word   $0038                           ; FE56 38 00
; ----------------------------------------------------------------------------
        .byte   "XSCROH"                        ; FE58 58 53 43 52 4F 48
; ----------------------------------------------------------------------------
        .word   $0037                           ; FE5E 37 00
; ----------------------------------------------------------------------------
        .byte   "XSCRSE"                        ; FE60 58 53 43 52 53 45
; ----------------------------------------------------------------------------
        .word   $0036                           ; FE66 36 00
; ----------------------------------------------------------------------------
        .byte   "XSDUMP"                        ; FE68 58 53 44 55 4D 50
; ----------------------------------------------------------------------------
        .word   $005C                           ; FE6E 5C 00
; ----------------------------------------------------------------------------
        .byte   "XSHOOT"                        ; FE70 58 53 48 4F 4F 54
; ----------------------------------------------------------------------------
        .word   $0047                           ; FE76 47 00
; ----------------------------------------------------------------------------
        .byte   "XSIN  "                        ; FE78 58 53 49 4E 20 20
; ----------------------------------------------------------------------------
        .word   $0070                           ; FE7E 70 00
; ----------------------------------------------------------------------------
        .byte   "XSLOAD"                        ; FE80 58 53 4C 4F 41 44
; ----------------------------------------------------------------------------
        .word   $005E                           ; FE86 5E 00
; ----------------------------------------------------------------------------
        .byte   "XSONPS"                        ; FE88 58 53 4F 4E 50 53
; ----------------------------------------------------------------------------
        .word   $0040                           ; FE8E 40 00
; ----------------------------------------------------------------------------
        .byte   "XSOUND"                        ; FE90 58 53 4F 55 4E 44
; ----------------------------------------------------------------------------
        .word   $0044                           ; FE96 44 00
; ----------------------------------------------------------------------------
        .byte   "XSOUT "                        ; FE98 58 53 4F 55 54 20
; ----------------------------------------------------------------------------
        .word   $0067                           ; FE9E 67 00
; ----------------------------------------------------------------------------
        .byte   "XSPUT "                        ; FEA0 58 53 50 55 54 20
; ----------------------------------------------------------------------------
        .word   $FF14                           ; FEA6 14 FF
; ----------------------------------------------------------------------------
        .byte   "XSQR  "                        ; FEA8 58 53 51 52 20 20
; ----------------------------------------------------------------------------
        .word   $0078                           ; FEAE 78 00
; ----------------------------------------------------------------------------
        .byte   "XSSAVE"                        ; FEB0 58 53 53 41 56 45
; ----------------------------------------------------------------------------
        .word   $005F                           ; FEB6 5F 00
; ----------------------------------------------------------------------------
        .byte   "XSTAKE"                        ; FEB8 58 53 54 41 4B 45
; ----------------------------------------------------------------------------
        .word   $FF17                           ; FEBE 17 FF
; ----------------------------------------------------------------------------
        .byte   "XSTATU"                        ; FEC0 58 53 54 41 54 55
; ----------------------------------------------------------------------------
        .word   $FF3E                           ; FEC6 3E FF
; ----------------------------------------------------------------------------
        .byte   "XSVSEC"                        ; FEC8 58 53 56 53 45 43
; ----------------------------------------------------------------------------
        .word   $FF8C                           ; FECE 8C FF
; ----------------------------------------------------------------------------
        .byte   "XTAKE "                        ; FED0 58 54 41 4B 45 20
; ----------------------------------------------------------------------------
        .word   $FF20                           ; FED6 20 FF
; ----------------------------------------------------------------------------
        .byte   "XTAN  "                        ; FED8 58 54 41 4E 20 20
; ----------------------------------------------------------------------------
        .word   $0072                           ; FEDE 72 00
; ----------------------------------------------------------------------------
        .byte   "XTEXT "                        ; FEE0 58 54 45 58 54 20
; ----------------------------------------------------------------------------
        .word   $0019                           ; FEE6 19 00
; ----------------------------------------------------------------------------
        .byte   "XTRVCA"                        ; FEE8 58 54 52 56 43 41
; ----------------------------------------------------------------------------
        .word   $FF7A                           ; FEEE 7A FF
; ----------------------------------------------------------------------------
        .byte   "XTRVNM"                        ; FEF0 58 54 52 56 4E 4D
; ----------------------------------------------------------------------------
        .word   $FF7D                           ; FEF6 7D FF
; ----------------------------------------------------------------------------
        .byte   "XTRVNX"                        ; FEF8 58 54 52 56 4E 58
; ----------------------------------------------------------------------------
        .word   $FF80                           ; FEFE 80 FF
; ----------------------------------------------------------------------------
        .byte   "XTSTBU"                        ; FF00 58 54 53 54 42 55
; ----------------------------------------------------------------------------
        .word   $0056                           ; FF06 56 00
; ----------------------------------------------------------------------------
        .byte   "XTSTLP"                        ; FF08 58 54 53 54 4C 50
; ----------------------------------------------------------------------------
        .word   $001E                           ; FF0E 1E 00
; ----------------------------------------------------------------------------
        .byte   "XUNPRO"                        ; FF10 58 55 4E 50 52 4F
; ----------------------------------------------------------------------------
        .word   $FF53                           ; FF16 53 FF
; ----------------------------------------------------------------------------
        .byte   "XUPDAT"                        ; FF18 58 55 50 44 41 54
; ----------------------------------------------------------------------------
        .word   $FF41                           ; FF1E 41 FF
; ----------------------------------------------------------------------------
        .byte   "XUS1  "                        ; FF20 58 55 53 31 20 20
; ----------------------------------------------------------------------------
        .word   $0086                           ; FF26 86 00
; ----------------------------------------------------------------------------
        .byte   "XUS2  "                        ; FF28 58 55 53 32 20 20
; ----------------------------------------------------------------------------
        .word   $0087                           ; FF2E 87 00
; ----------------------------------------------------------------------------
        .byte   "XUS3  "                        ; FF30 58 55 53 33 20 20
; ----------------------------------------------------------------------------
        .word   $0094                           ; FF36 94 00
; ----------------------------------------------------------------------------
        .byte   "XUS4  "                        ; FF38 58 55 53 34 20 20
; ----------------------------------------------------------------------------
        .word   $0095                           ; FF3E 95 00
; ----------------------------------------------------------------------------
        .byte   "XUS6  "                        ; FF40 58 55 53 36 20 20
; ----------------------------------------------------------------------------
        .word   $0096                           ; FF46 96 00
; ----------------------------------------------------------------------------
        .byte   "XUS7  "                        ; FF48 58 55 53 37 20 20
; ----------------------------------------------------------------------------
        .word   $0097                           ; FF4E 97 00
; ----------------------------------------------------------------------------
        .byte   "XVBUF1"                        ; FF50 58 56 42 55 46 31
; ----------------------------------------------------------------------------
        .word   $FF89                           ; FF56 89 FF
; ----------------------------------------------------------------------------
        .byte   "XVDT  "                        ; FF58 58 56 44 54 20 20
; ----------------------------------------------------------------------------
        .word   $0091                           ; FF5E 91 00
; ----------------------------------------------------------------------------
        .byte   "XVIDBU"                        ; FF60 58 56 49 44 42 55
; ----------------------------------------------------------------------------
        .word   $0057                           ; FF66 57 00
; ----------------------------------------------------------------------------
        .byte   "XWCXFI"                        ; FF68 58 57 43 58 46 49
; ----------------------------------------------------------------------------
        .word   $0063                           ; FF6E 63 00
; ----------------------------------------------------------------------------
        .byte   "XWR0  "                        ; FF70 58 57 52 30 20 20
; ----------------------------------------------------------------------------
        .word   $0010                           ; FF76 10 00
; ----------------------------------------------------------------------------
        .byte   "XWR1  "                        ; FF78 58 57 52 31 20 20
; ----------------------------------------------------------------------------
        .word   $0011                           ; FF7E 11 00
; ----------------------------------------------------------------------------
        .byte   "XWR2  "                        ; FF80 58 57 52 32 20 20
; ----------------------------------------------------------------------------
        .word   $0012                           ; FF86 12 00
; ----------------------------------------------------------------------------
        .byte   "XWR3  "                        ; FF88 58 57 52 33 20 20
; ----------------------------------------------------------------------------
        .word   $0013                           ; FF8E 13 00
; ----------------------------------------------------------------------------
        .byte   "XWRCLK"                        ; FF90 58 57 52 43 4C 4B
; ----------------------------------------------------------------------------
        .word   $003E                           ; FF96 3E 00
; ----------------------------------------------------------------------------
        .byte   "XWSTR0"                        ; FF98 58 57 53 54 52 30
; ----------------------------------------------------------------------------
        .word   $0014                           ; FF9E 14 00
; ----------------------------------------------------------------------------
        .byte   "XWSTR1"                        ; FFA0 58 57 53 54 52 31
; ----------------------------------------------------------------------------
        .word   $0015                           ; FFA6 15 00
; ----------------------------------------------------------------------------
        .byte   "XWSTR2"                        ; FFA8 58 57 53 54 52 32
; ----------------------------------------------------------------------------
        .word   $0016                           ; FFAE 16 00
; ----------------------------------------------------------------------------
        .byte   "XWSTR3"                        ; FFB0 58 57 53 54 52 33
; ----------------------------------------------------------------------------
        .word   $0017                           ; FFB6 17 00
; ----------------------------------------------------------------------------
        .byte   "XZAP  "                        ; FFB8 58 5A 41 50 20 20
; ----------------------------------------------------------------------------
        .word   $0046                           ; FFBE 46 00
; ----------------------------------------------------------------------------
        .byte   "ZADCHA"                        ; FFC0 5A 41 44 43 48 41
; ----------------------------------------------------------------------------
        .word   $001D                           ; FFC6 1D 00
; ----------------------------------------------------------------------------
SymbolTableEnd:
        .byte   $00                             ; FFC8 00
; Copyrights
teleass_signature:
        .byte   "TELEASS V1.0a"                 ; FFC9 54 45 4C 45 41 53 53 20
                                                ; FFD1 56 31 2E 30 61
        .byte   $0A,$0D                         ; FFD6 0A 0D
        .byte   "(c) 1987 ORIC International"   ; FFD8 28 63 29 20 31 39 38 37
                                                ; FFE0 20 4F 52 49 43 20 49 6E
                                                ; FFE8 74 65 72 6E 61 74 69 6F
                                                ; FFF0 6E 61 6C
        .byte   $0A,$0D,$0A,$0D,$00             ; FFF3 0A 0D 0A 0D 00
; ----------------------------------------------------------------------------
; Copyrights address
signature_address:
        .word   teleass_signature               ; FFF8 C9 FF
; ----------------------------------------------------------------------------
; Version + ROM Type
ROMDEF: .byte   $0A,$EF                         ; FFFA 0A EF
; ----------------------------------------------------------------------------
; RESET
teleass_reset:
        .word   teleass_start                   ; FFFC 70 D0
; ----------------------------------------------------------------------------
; IRQ Vector
teleass_irq_vector:
        .word   $02FA                           ; FFFE FA 02
