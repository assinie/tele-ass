; da65 V2.17 - Git 334e30c
; Created:    2018-05-11 20:13:32
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
XLPRBI          = $0048
HRSX40          = $0049
HRSX6           = $004A
HRS1            = $004D
HRS2            = $004F
HRS3            = $0051
HRS4            = $0053
INDIC0          = $0055
INDIC2          = $0057
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
LPRFY           = $0289
LPRSY           = $028B
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
DEFBNK          = $04E0
Proc1           = $04E2
Ptr1            = $04EE
Ptr2            = $04F0
Flags           = $04F2
Proc2           = $04F4
DRIVE           = $0500
ERRNB           = $0512
SAVES           = $0513
BUFNOM          = $0517
VSALO0          = $0528
VSALO1          = $0529
FTYPE           = $052C
INPIS           = $052D
INSEC           = $052E
PARPIS          = $052F
PARSEC          = $0530
EXSALO          = $0531
EXTDEF          = $055D
BUFEDT          = $0590
; ----------------------------------------------------------------------------
        jmp     teleass_start

; ----------------------------------------------------------------------------
; Mnemonics
Mnemonics:
        .byte   "BR"
        .byte   $CB
        .byte   "CL"
        .byte   $C3
        .byte   "CL"
        .byte   $C4
        .byte   "CL"
        .byte   $C9
        .byte   "CL"
        .byte   $D6
        .byte   "DE"
        .byte   $D8
        .byte   "DE"
        .byte   $D9
        .byte   "IN"
        .byte   $D8
        .byte   "IN"
        .byte   $D9
        .byte   "NO"
        .byte   $D0
        .byte   "PH"
        .byte   $C1
        .byte   "PH"
        .byte   $D0
        .byte   "PL"
        .byte   $C1
        .byte   "PL"
        .byte   $D0
        .byte   "RT"
        .byte   $C9
        .byte   "RT"
        .byte   $D3
        .byte   "SE"
        .byte   $C3
        .byte   "SE"
        .byte   $C4
        .byte   "SE"
        .byte   $C9
        .byte   "TA"
        .byte   $D8
        .byte   "TA"
        .byte   $D9
        .byte   "TS"
        .byte   $D8
        .byte   "TX"
        .byte   $C1
        .byte   "TX"
        .byte   $D3
        .byte   "TY"
        .byte   $C1
        .byte   "BC"
        .byte   $C3
        .byte   "BC"
        .byte   $D3
        .byte   "BE"
        .byte   $D1
        .byte   "BN"
        .byte   $C5
        .byte   "BM"
        .byte   $C9
        .byte   "BP"
        .byte   $CC
        .byte   "BV"
        .byte   $C3
        .byte   "BV"
        .byte   $D3
        .byte   "AD"
        .byte   $C3
        .byte   "AN"
        .byte   $C4
        .byte   "AS"
        .byte   $CC
        .byte   "BI"
        .byte   $D4
        .byte   "CM"
        .byte   $D0
        .byte   "CP"
        .byte   $D8
        .byte   "CP"
        .byte   $D9
        .byte   "DE"
        .byte   $C3
        .byte   "EO"
        .byte   $D2
        .byte   "IN"
        .byte   $C3
        .byte   "JM"
        .byte   $D0
        .byte   "JS"
        .byte   $D2
        .byte   "LD"
        .byte   $C1
        .byte   "LD"
        .byte   $D8
        .byte   "LD"
        .byte   $D9
        .byte   "LS"
        .byte   $D2
        .byte   "OR"
        .byte   $C1
        .byte   "RO"
        .byte   $CC
        .byte   "RO"
        .byte   $D2
        .byte   "SB"
        .byte   $C3
        .byte   "ST"
        .byte   $C1
        .byte   "ST"
        .byte   $D8
        .byte   "ST"
        .byte   $D9
; Pseudo Operations
PseudoOps:
        .byte   "BY"
        .byte   $D4
        .byte   "EQ"
        .byte   $D5
        .byte   "DB"
        .byte   $D4
        .byte   "RE"
        .byte   $D3
        .byte   "OR"
        .byte   $C7
        .byte   "WR"
        .byte   $C4
        .byte   "??"
        .byte   $BF
        .byte   "??"
        .byte   $BF
        .byte   "??"
        .byte   $BF
; ----------------------------------------------------------------------------
; Oplen
Oplen:  .byte   $01,$55,$00,$00,$00,$01,$01,$00
        .byte   $00,$81,$00,$00,$00,$02,$02,$00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00
        .byte   $02,$55,$00,$00,$01,$01,$01,$00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00
        .byte   $00,$55,$00,$00,$00,$01,$01,$00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00
        .byte   $00,$55,$00,$00,$00,$01,$01,$00
        .byte   $00,$81,$00,$00,$62,$02,$02,$00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00
        .byte   $00,$55,$00,$00,$01,$01,$01,$00
        .byte   $00,$00,$00,$00,$02,$02,$02,$00
        .byte   $C1,$69,$00,$00,$11,$11,$09,$00
        .byte   $00,$0A,$00,$00,$00,$12,$00,$00
        .byte   $81,$55,$81,$00,$01,$01,$01,$00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00
        .byte   $C1,$69,$00,$00,$11,$11,$09,$00
        .byte   $00,$0A,$00,$00,$12,$12,$0A,$00
        .byte   $81,$55,$00,$00,$01,$01,$01,$00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00
        .byte   $81,$55,$00,$00,$01,$01,$01,$00
        .byte   $00,$81,$00,$00,$02,$02,$02,$00
        .byte   $C1,$69,$00,$00,$00,$11,$11,$00
        .byte   $00,$0A,$00,$00,$00,$12,$12,$00
; Opmode
Opmode: .byte   $80,$B1,$BF,$BF,$BF,$B1,$A3,$BF
        .byte   $8B,$B1,$A3,$BF,$BF,$B1,$A3,$BF
        .byte   $9E,$B1,$BF,$BF,$BF,$B1,$A3,$BF
        .byte   $81,$B1,$BF,$BF,$BF,$B1,$A3,$BF
        .byte   $AC,$A2,$BF,$BF,$A4,$A2,$B2,$BF
        .byte   $8D,$A2,$B2,$BF,$A4,$A2,$B2,$BF
        .byte   $9D,$A2,$BF,$BF,$BF,$A2,$B2,$BF
        .byte   $90,$A2,$BF,$BF,$BF,$A2,$B2,$BF
        .byte   $8E,$A9,$BF,$BF,$BF,$A9,$B0,$BF
        .byte   $8A,$A9,$B0,$BF,$AB,$A9,$B0,$BF
        .byte   $9F,$A9,$BF,$BF,$BF,$A9,$B0,$BF
        .byte   $83,$A9,$BF,$BF,$BF,$A9,$B0,$BF
        .byte   $8F,$A1,$BF,$BF,$BF,$A1,$B3,$BF
        .byte   $8C,$A1,$B3,$BF,$AB,$A1,$B3,$BF
        .byte   $A0,$A1,$BF,$BF,$BF,$A1,$B3,$BF
        .byte   $92,$A1,$BF,$BF,$BF,$A1,$B3,$BF
        .byte   $BF,$B5,$BF,$BF,$B7,$B5,$B6,$BF
        .byte   $86,$BF,$96,$BF,$B7,$B5,$B6,$BF
        .byte   $99,$B5,$BF,$BF,$B7,$B5,$B6,$BF
        .byte   $98,$B5,$97,$BF,$BF,$B5,$BF,$BF
        .byte   $AF,$AD,$AE,$BF,$AF,$AD,$AE,$BF
        .byte   $94,$AD,$93,$BF,$AF,$AD,$AE,$BF
        .byte   $9A,$AD,$BF,$BF,$AF,$AD,$AE,$BF
        .byte   $84,$AD,$95,$BF,$AF,$AD,$AE,$BF
        .byte   $A7,$A5,$BF,$BF,$A7,$A5,$A8,$BF
        .byte   $88,$A5,$85,$BF,$A7,$A5,$A8,$BF
        .byte   $9C,$A5,$BF,$BF,$BF,$A5,$A8,$BF
        .byte   $82,$A5,$BF,$BF,$BF,$A5,$A8,$BF
        .byte   $A6,$B4,$BF,$BF,$A6,$B4,$AA,$BF
        .byte   $87,$B4,$89,$BF,$A6,$B4,$AA,$BF
        .byte   $9B,$B4,$BF,$BF,$BF,$B4,$AA,$BF
        .byte   $91,$B4,$BF,$BF,$BF,$B4,$AA,$BF
; ----------------------------------------------------------------------------
; Commands
CommandsTable:
        .byte   "QUI"
        .byte   $D4
        .byte   "LOA"
        .byte   $C4
        .byte   "DESA"
        .byte   $D3
        .byte   "LDESA"
        .byte   $D3
        .byte   "DUM"
        .byte   $D0
        .byte   "LDUM"
        .byte   $D0
        .byte   "LIS"
        .byte   $D4
        .byte   "LLIS"
        .byte   $D4
        .byte   "RENU"
        .byte   $CD
        .byte   "DI"
        .byte   $D2
        .byte   "LDI"
        .byte   $D2
        .byte   "SAVE"
        .byte   $D5
        .byte   "SAVE"
        .byte   $CF
        .byte   "SAVE"
        .byte   $CD
        .byte   "SAV"
        .byte   $C5
        .byte   "ASSE"
        .byte   $CD
        .byte   "LASSE"
        .byte   $CD
        .byte   "SYOL"
        .byte   $C4
        .byte   "SYDE"
        .byte   $C6
        .byte   "SYTA"
        .byte   $C2
        .byte   "LSYTA"
        .byte   $C2
        .byte   "MODI"
        .byte   $C6
        .byte   "?DE"
        .byte   $C3
        .byte   "?HE"
        .byte   $D8
        .byte   "?BI"
        .byte   $CE
        .byte   "?CA"
        .byte   $D2
        .byte   "VRE"
        .byte   $C7
        .byte   "TRAC"
        .byte   $C5
        .byte   "MOV"
        .byte   $C5
        .byte   "DELBA"
        .byte   $CB
        .byte   "DELET"
        .byte   $C5
        .byte   "DE"
        .byte   $CC
        .byte   "MERG"
        .byte   $C5
        .byte   "SEE"
        .byte   $CB
        .byte   "CHANG"
        .byte   $C5
        .byte   "OL"
        .byte   $C4
        .byte   "NE"
        .byte   $D7
        .byte   "BAN"
        .byte   $CB
        .byte   "CAL"
        .byte   $CC
        .byte   "EX"
        .byte   $D4
        .byte   "BYTE"
        .byte   $D3
        .byte   "MINA"
        .byte   $D3
        .byte   "BACKU"
        .byte   $D0
        .byte   "INI"
        .byte   $D4
        .byte   "DPAG"
        .byte   $C5
        .byte   "FPAG"
        .byte   $C5
        .byte   "SLIGN"
        .byte   $C5
        .byte   "QWERT"
        .byte   $D9
        .byte   "AZERT"
        .byte   $D9
        .byte   "FRENC"
        .byte   $C8
        .byte   "ACCSE"
        .byte   $D4
        .byte   "ACCOF"
        .byte   $C6
        .byte   "TEX"
        .byte   $D4
        .byte   "HIRE"
        .byte   $D3,$00
; ----------------------------------------------------------------------------
; Commands Addresses
CommandsAddr:
        .word   QUIT-1
        .word   LOAD-1
        .word   DESAS-1
        .word   LDESAS-1
        .word   DUMP-1
        .word   LDUMP-1
        .word   LIST-1
        .word   LLIST-1
        .word   RENUM-1
        .word   DIR-1
        .word   LDIR-1
        .word   SAVEU-1
        .word   SAVEO-1
        .word   SAVEM-1
        .word   SAVE-1
        .word   ASSEM-1
        .word   LASSEM-1
        .word   SYOLD-1
        .word   SYDEF-1
        .word   SYTAB-1
        .word   LSYTAB-1
        .word   MODIF-1
        .word   QDEC-1
        .word   QHEX-1
        .word   QBIN-1
        .word   QCAR-1
        .word   VREG-1
        .word   TRACE-1
        .word   MOVE-1
        .word   DELBAK-1
        .word   DELETE-1
        .word   DEL-1
        .word   MERGE-1
        .word   SEEK-1
        .word   CHANGE-1
        .word   OLD-1
        .word   NEW-1
        .word   BANK-1
        .word   CALL-1
        .word   EXT-1
        .word   BYTE-1
        .word   MINAS-1
        .word   BACKUP-1
        .word   INIT-1
        .word   DPAGE-1
        .word   FPAGE-1
        .word   SLIGNE-1
        .word   QWERTY-1
        .word   AZERTY-1
        .word   FRENCH-1
        .word   ACCSET-1
        .word   ACCOFF-1
        .word   TEXT-1
        .word   HIRES-1
; ----------------------------------------------------------------------------
; Error Messages
ErrMsgs:.byte   "Erreur de syntaxe"


        .byte   $00
        .byte   "Fichier inexistant"


        .byte   $00
        .byte   "Erreur I/O"

        .byte   $00
        .byte   "Fichier existant"

        .byte   $00
        .byte   "Plus de place disque"


        .byte   $00
        .byte   "Disquette protegee"


        .byte   $00
        .byte   "Erreur de type"

        .byte   $00
        .byte   "Format inconnu"

        .byte   $00
        .byte   "Pas de DOS"

        .byte   $00
        .byte   "Nom de fichier incorrect"


        .byte   $00
        .byte   "Lecteur non connecte"


        .byte   $00
        .byte   "Valeur illegale"

        .byte   $00
        .byte   "Valeur hors limites"


        .byte   $00
        .byte   "Memoire pleine"

        .byte   $00
        .byte   "Mnemonique non defini"


        .byte   $00
        .byte   "Etiquette illegale"


        .byte   $00
        .byte   "Etiquette en double"


        .byte   $00
        .byte   "Symbole non defini"


        .byte   $00
        .byte   "Branchement hors limites"


        .byte   $00
        .byte   "Mode adressage illegal"


        .byte   $00
        .byte   "ORG non defini"

        .byte   $00
        .byte   "ORG deja defini"

        .byte   $00
        .byte   "Pile erronee"

        .byte   $00
        .byte   "Code inconnu"

        .byte   $00
        .byte   "Wildcards non autorisees"


        .byte   $00
        .byte   "Symboles globaux detruits"



        .byte   $00
        .byte   "Erreur format imprimante"


        .byte   $00
; Messages divers
Registers_str:
        .byte   "AA YY XX PP  NV~BDIZC"


        .byte   $00
Source_str:
        .byte   "Prgm.Source: "

        .byte   $00
Objet_str:
        .byte   "Prgm.Objet : "

        .byte   $00
Symboles_str:
        .byte   "Symboles   : "

        .byte   $00
Locaux_str:
        .byte   "locaux"
        .byte   $00
Globaux_str:
        .byte   "globaux"
        .byte   $00
Moniteur_str:
        .byte   "moniteur"
        .byte   $00
Assemblage_str:
        .byte   $82
        .byte   "Assemblage"

        .byte   $00
O_N_str:.byte   "?(O/N):"
        .byte   $00
Trace_str:
        .byte   $82
        .byte   "TRACE"
        .byte   $00
PasPas_str:
        .byte   $82
        .byte   "PAS A PAS"

        .byte   $00
Exec_str:
        .byte   $82
        .byte   "EXEC"
        .byte   $00
Pile_str:
        .byte   $82
        .byte   "Pile"
        .byte   $00
Banque_str:
        .byte   $83
        .byte   "Banque "
        .byte   $00
MAJ_min_str:
        .byte   "MAJ min"
        .byte   $00
Fmt_str:.byte   "Fmt="
        .byte   $00
Saut_str:
        .byte   "Saut="
        .byte   $00
Ligne_str:
        .byte   "Ligne="
        .byte   $00
Occurences_str:
        .byte   $7F
        .byte   "Occurences:"

        .byte   $00
Menu_str:
        .byte   $0A,$0D
        .byte   " 1- HYPER-BASIC"

        .byte   $0A,$0D
        .byte   " 2- TELE-ASS"

        .byte   $0A,$0D
        .byte   "Votre choix:"

        .byte   $00,$00,$00,$00
; ----------------------------------------------------------------------------
LC716:  pha
        cmp     #$A0
        bcs     LC728
        pla
        pha
        cmp     #$80
        bcs     LC726
        cmp     #$20
        bcc     LC726
        .byte   $2C
LC726:  lda     #$20
LC728:  BRK_TELEMON XWR0
        pla
        rts

; ----------------------------------------------------------------------------
; Display Y spaces
DispYSpace:
        pha
LC72D:  jsr     DispSpace
        dey
        bne     LC72D
        pla
        rts

; ----------------------------------------------------------------------------
; Display a space
DispSpace:
        lda     #$20
        BRK_TELEMON XWR0
        rts

; ----------------------------------------------------------------------------
; Display 6502 registers
DispRegs:
        ldy     #$08
        jsr     DispYSpace
        lda     #<Registers_str
        ldy     #>Registers_str
        BRK_TELEMON XWSTR0
        jsr     LC763
        ldy     #$08
        jsr     DispYSpace
        ldy     #$03
LC74F:  lda     HRS1+1,y
        jsr     DispByte
        jsr     DispSpace
        dey
        bpl     LC74F
        jsr     DispSpace
        lda     HRS1+1
        jsr     DispBitStr
LC763:  BRK_TELEMON XCRLF
        rts

; ----------------------------------------------------------------------------
LC766:  ldy     #$00
        jsr     LC7BA
        ldy     #$FF
LC76D:  iny
        lda     BUFTRV+2,y
        sta     BUFTRV,y
        bne     LC76D
        jmp     DispString

; ----------------------------------------------------------------------------
LC779:  jsr     LC7BA
; Display string from bottom of the stack
DispString:
        pha
        tya
        pha
        txa
        pha
        lda     #<BUFTRV
        ldy     #>BUFTRV
        BRK_TELEMON XWSTR0
        pla
        tax
        pla
        tay
        pla
        rts

; ----------------------------------------------------------------------------
; Display hexa word from bottom of the stack
DispWord:
        jsr     PutYAHexa
        beq     DispString
; Display hexa byte from bottom of the stack
DispByte:
        jsr     PutHexa
        jmp     DispString

; ----------------------------------------------------------------------------
        pha
        tya
        jsr     PutBitStr
        jsr     DispString
        pla
; Display bit string representation of ACC
DispBitStr:
        jsr     PutBitStr
        jmp     DispString

; ----------------------------------------------------------------------------
LC7A7:  pha
        tya
        pha
        lda     #$00
        ldy     #$01
        sta     TR5
        sty     TR6
        lda     #$20
        sta     DEFAFF
        pla
        tay
        pla
        rts

; ----------------------------------------------------------------------------
LC7BA:  stx     VARAPL
        ldx     #$03
        jsr     LC7A7
        BRK_TELEMON XBINDX
        ldx     VARAPL
        ldy     #$05
        lda     #$00
        sta     BUFTRV,y
        rts

; ----------------------------------------------------------------------------
; Put hexa string representation of YA at bottom of the stack
PutYAHexa:
        ldx     #$00
        pha
        tya
        jsr     PushHexa
        pla
        jsr     PushHexa
        rts

; ----------------------------------------------------------------------------
; Put hexa string representation of ACC at bottom of the stack
PutHexa:sta     VARAPL
        pha
        tya
        pha
        txa
        pha
        ldx     #$00
        lda     VARAPL
        jsr     PushHexa
        pla
        tax
        pla
        tay
        pla
        rts

; ----------------------------------------------------------------------------
; Append hexa string representation of ACC at bottom of the stack
PushHexa:
        BRK_TELEMON XHEXA
        sta     BUFTRV,x
        inx
        tya
        sta     BUFTRV,x
        inx
        lda     #$00
        sta     BUFTRV,x
        rts

; ----------------------------------------------------------------------------
; Put bit string representation of ACC at bottom of the stack
PutBitStr:
        sta     VARAPL
        pha
        txa
        pha
        ldx     #$08
        lda     #$00
        beq     LC811
LC809:  lda     #$30
        lsr     VARAPL
        bcc     LC811
        adc     #$00
LC811:  sta     BUFTRV,x
        dex
        bpl     LC809
        pla
        tax
        pla
        rts

; ----------------------------------------------------------------------------
; Display error number X
DispErrorX:
        pha
        tya
        pha
        lda     #$33
        sta     TR0
        lda     #$C4
        sta     TR1
        bne     LC83A
LC828:  iny
LC829:  lda     (TR0),y
        bne     LC828
        iny
        tya
        clc
        adc     TR0
        sta     TR0
        lda     TR1
        adc     #$00
        sta     TR1
LC83A:  ldy     #$00
        lda     (TR0),y
        beq     LC84F
        dex
        bpl     LC829
        lda     TR0
        ldy     TR1
        ldx     #$02
        jsr     LC88B
        jsr     LC857
LC84F:  pla
        tay
        pla
LC852:  rts

; ----------------------------------------------------------------------------
LC853:  lda     #$00
        ldy     #$01
LC857:  bit     FLGTEL
        bmi     LC852
        pha
        tya
        pha
        lda     SCRX
        sta     VARAPL
        lda     SCRY
        sta     VARAPL+1
        txa
        tay
        lda     #$00
        jsr     LC879
        pla
        tay
        pla
        BRK_TELEMON XWSTR0
        lda     VARAPL+1
        ldy     VARAPL
LC879:  pha
        lda     #$1F
        BRK_TELEMON XWR0
        pla
        clc
        adc     #$40
        BRK_TELEMON XWR0
        tya
        clc
        adc     #$40
        BRK_TELEMON XWR0
LC88A:  rts

; ----------------------------------------------------------------------------
LC88B:  bit     FLGTEL
        bmi     LC88A
        pha
        tya
        pha
        txa
        pha
        lda     SCRY
        pha
        lda     SCRX
        pha
        lda     #$00
        ldy     #$01
        jsr     LC879
        lda     #$18
        BRK_TELEMON XWR0
        pla
        tay
        pla
        jsr     LC879
        pla
        tax
        pla
        tay
        pla
        rts

; ----------------------------------------------------------------------------
LC8B4:  BRK_TELEMON XRD0
        bcs     LC8CF
        cmp     #$1B
        beq     LC8D0
        cmp     #$03
        beq     LC8D0
        cmp     #$20
        bne     LC8CF
        jsr     LC8D1
        cmp     #$1B
        beq     LC8D0
        cmp     #$03
        beq     LC8D0
LC8CF:  clc
LC8D0:  rts

; ----------------------------------------------------------------------------
LC8D1:  ldx     #$00
        BRK_TELEMON XCSSCR
        BRK_TELEMON XRDW0
        pha
        BRK_TELEMON XCOSCR
        pla
        rts

; ----------------------------------------------------------------------------
LC8DC:  bit     FLGTEL
        bmi     LC8D0
        jsr     LC88B
        pha
        tya
        pha
        txa
        pha
        lda     DEFBNK
        jsr     DispBank
        pla
        tax
        pla
        tay
        pla
        rts

; ----------------------------------------------------------------------------
; Display 'Banque ' + bank number ACC
DispBank:
        pha
        lda     SCRX
        sta     VARAPL
        lda     SCRY
        sta     VARAPL+1
        lda     #$00
        ldy     #$0F
        jsr     LC879
        lda     #<Banque_str
        ldy     #>Banque_str
        BRK_TELEMON XWSTR0
        pla
        clc
        adc     #$30
        BRK_TELEMON XWR0
        lda     VARAPL+1
        ldy     VARAPL
        jmp     LC879

; ----------------------------------------------------------------------------
LC91A:  cmp     #$2E
        bcc     LC933
        sbc     #$3A
        sec
        sbc     #$C6
        bcc     LC92A
        rts

; ----------------------------------------------------------------------------
LC926:  cmp     #$2E
        beq     LC933
LC92A:  cmp     #$3F
        bcc     LC933
        sbc     #$7B
        sec
        sbc     #$85
LC933:  rts

; ----------------------------------------------------------------------------
LC934:  ldy     #$FE
        sty     VARAPL+2
        iny
        lda     #$00
        sta     VARAPL+5
        lda     BUFEDT,x
        beq     LC9AF
        cmp     #$27
        beq     LC9AD
        jsr     LC9CD
        bmi     LC9AF
        jsr     LC926
        bcc     LC980
        dex
LC951:  inx
        lda     BUFEDT,x
        cmp     #$20
        bne     LC95D
        ror     VARAPL+6
        bmi     LC951
LC95D:  bit     VARAPL+6
        bmi     LC986
        jsr     LC91A
        bcc     LC980
        pha
        inc     VARAPL+5
        lda     VARAPL+5
        cmp     #$06
        bcc     LC971
        ror     VARAPL+6
LC971:  pla
        iny
        sta     BUFEDT,y
        lda     BUFEDT,y
        bne     LC951
LC97B:  txa
        ldx     #$0E
        bne     LC983
LC980:  txa
        ldx     #$0F
LC983:  tay
        clc
        rts

; ----------------------------------------------------------------------------
LC986:  jsr     LC9CD
        bpl     LC97B
        bmi     LC9AF
LC98D:  inx
        lda     BUFEDT,x
        bit     VARAPL+5
        bmi     LC9AF
        cmp     #$22
        bne     LC9A1
        pha
        lda     VARAPL+5
        eor     #$40
        sta     VARAPL+5
        pla
LC9A1:  bit     VARAPL+5
        bvs     LC9AF
        cmp     #$20
        beq     LC98D
        cmp     #$27
        bne     LC9AF
LC9AD:  ror     VARAPL+5
LC9AF:  iny
        sta     BUFEDT,y
        lda     BUFEDT,y
        bpl     LC9BA
        sta     (VARAPL+1),y
LC9BA:  bne     LC98D
        iny
        sec
        rts

; ----------------------------------------------------------------------------
LC9BF:  cmp     #$61
        bcc     LC9CC
        sbc     #$7B
        sec
        sbc     #$85
        bcc     LC9CC
        sbc     #$20
LC9CC:  rts

; ----------------------------------------------------------------------------
LC9CD:  clc
        lda     #$03
        adc     #$FF
        sta     VARAPL+8
        lda     #$C0
        adc     #$FF
        sta     VARAPL+9
LC9DA:  sty     VARAPL
        ldy     #$00
        sty     VARAPL+6
        stx     VARAPL+1
        dex
LC9E3:  inx
        inc     VARAPL+8
        bne     LC9EA
        inc     VARAPL+9
LC9EA:  lda     BUFEDT,x
        jsr     LC9BF
        sec
        sbc     (VARAPL+8),y
        beq     LC9E3
        cmp     #$80
        beq     LCA12
        ldx     VARAPL+1
        inc     VARAPL+6
LC9FD:  lda     (VARAPL+8),y
        php
        inc     VARAPL+8
        bne     LCA06
        inc     VARAPL+9
LCA06:  plp
        bpl     LC9FD
        lda     (VARAPL+8),y
        bne     LC9EA
        lda     BUFEDT,x
        sta     VARAPL+6
LCA12:  ora     VARAPL+6
        pha
        ora     #$40
        sta     VARAPL+2
        ldy     VARAPL
        pla
        rts

; ----------------------------------------------------------------------------
LCA1D:  clc
        lda     #>MAJ_min_str+4
        adc     #$FF
        sta     VARAPL+8
        lda     #<MAJ_min_str+4
        adc     #$FF
        sta     VARAPL+9
        jmp     LC9DA

; ----------------------------------------------------------------------------
LCA2D:  ldx     #$FF
LCA2F:  inx
LCA30:  lda     BUFEDT,x
        beq     LCA39
        cmp     #$20
        beq     LCA2F
LCA39:  rts

; ----------------------------------------------------------------------------
; Put mnemonic number ACC at bottom of the stack
PutMnemo:
        sty     VARAPL
        stx     VARAPL+1
        and     #$7F
        pha
        sta     VARAPL+2
        asl
        adc     VARAPL+2
        tay
        dey
        ldx     #$FF
LCA4A:  inx
        iny
        lda     Mnemonics,y
        pha
        and     #$7F
        sta     BUFTRV,x
        pla
        bpl     LCA4A
        lda     #$00
        inx
        sta     BUFTRV,x
        ldy     VARAPL
        ldx     VARAPL+1
        pla
        rts

; ----------------------------------------------------------------------------
; Decode opcode in ACC
DecodeOpc:
        sta     HRS3+1
        tay
        pha
        lda     Oplen,y
        sta     INDIC0
        and     #$03
        sta     INDIC0+1
        tax
        lda     Opmode,y
        sta     INDIC2
        pla
        rts

; ----------------------------------------------------------------------------
LCA79:  sta     VARAPL
        ldy     #$00
LCA7D:  lda     Opmode,y
        cmp     INDIC2
        bne     LCA8B
        lda     Oplen,y
        cmp     VARAPL
        beq     LCA8F
LCA8B:  iny
        bne     LCA7D
        clc
LCA8F:  tya
        rts

; ----------------------------------------------------------------------------
LCA91:  pha
        tya
        pha
        ldx     #$11
        stx     VARAPL+1
        stx     VARAPL+5
        ldx     #$09
        ldy     #$02
LCA9E:  iny
        lda     (VARAPL+12),y
        beq     LCADB
        bmi     LCAAF
        cmp     #$27
        bne     LCA9E
        ldx     #$07
        stx     VARAPL+1
        bne     LCAD2
LCAAF:  iny
        lda     (VARAPL+12),y
        beq     LCADB
        cmp     #$22
        bne     LCAC0
        pha
        lda     VARAPL+5
        eor     #$80
        sta     VARAPL+5
        pla
LCAC0:  cmp     #$27
        beq     LCAC9
LCAC4:  dex
        inc     VARAPL+1
        bne     LCAAF
LCAC9:  bit     VARAPL+5
        bmi     LCAC4
LCACD:  inc     VARAPL+1
        dex
        bpl     LCACD
LCAD2:  lda     (VARAPL+12),y
        beq     LCADB
        inc     VARAPL+1
        iny
        bne     LCAD2
LCADB:  lda     VARAPL+1
        cmp     #$27
        bcc     LCAEF
        pha
        lda     #$0B
        BRK_TELEMON XWR0
        pla
        cmp     #$4E
        bcc     LCAEF
        lda     #$0B
        BRK_TELEMON XWR0
LCAEF:  pla
        tay
        pla
LCAF2:  pha
        lda     #$7F
        BRK_TELEMON XWR0
        pla
LCAF8:  jsr     LC779
        jsr     DispSpace
        ldy     #$03
        ldx     #$06
        stx     VARAPL+5
LCB04:  lda     (VARAPL+12),y
        beq     LCB59
        bmi     LCB10
        BRK_TELEMON XWR0
        dex
        iny
        bne     LCB04
LCB10:  jsr     DispSpace
        dex
        bpl     LCB10
        lda     (VARAPL+12),y
        and     #$7F
        cmp     #$40
        bcc     LCB20
        lda     #$40
LCB20:  jsr     PutMnemo
        jsr     DispString
        jsr     DispSpace
        ldx     #$09
LCB2B:  iny
        lda     (VARAPL+12),y
        beq     LCB59
        cmp     #$22
        bne     LCB3C
        pha
        lda     VARAPL+5
        eor     #$80
        sta     VARAPL+5
        pla
LCB3C:  cmp     #$27
        beq     LCB46
LCB40:  dex
        BRK_TELEMON XWR0
        jmp     LCB2B

; ----------------------------------------------------------------------------
LCB46:  bit     VARAPL+5
        bmi     LCB40
LCB4A:  jsr     DispSpace
        dex
        bpl     LCB4A
LCB50:  lda     (VARAPL+12),y
        beq     LCB59
        BRK_TELEMON XWR0
        iny
        bne     LCB50
LCB59:  rts

; ----------------------------------------------------------------------------
LCB5A:  pha
        BRK_TELEMON XCRLF
        pla
        bit     XLPRBI
        bpl     LCB59
        pha
        inc     LPRY
        lda     LPRY
        cmp     LPRSY
        bcc     LCB87
        pla
LCB6F:  bit     XLPRBI
        bpl     LCB59
        pha
        sec
        lda     LPRFY
        sbc     LPRY
        sta     LPRY
        beq     LCB87
LCB80:  BRK_TELEMON XCRLF
        dec     LPRY
        bne     LCB80
LCB87:  pla
        rts

; ----------------------------------------------------------------------------
LCB89:  ldy     #$00
        clc
        lda     (VARAPL+12),y
        adc     VARAPL+12
        sta     VARAPL+12
        lda     VARAPL+13
        adc     #$00
        sta     VARAPL+13
LCB98:  ldy     #$00
        sec
        lda     (VARAPL+12),y
        beq     LCBA9
        lda     VARAPL+13
        cmp     SCEFIN+1
        bne     LCBA9
        lda     VARAPL+12
        cmp     SCEFIN
LCBA9:  rts

; ----------------------------------------------------------------------------
LCBAA:  jsr     LCC04
        bcc     LCBB5
        jsr     LCB89
        bcc     LCBB6
        clc
LCBB5:  rts

; ----------------------------------------------------------------------------
LCBB6:  iny
        lda     (VARAPL+12),y
        pha
        iny
        lda     (VARAPL+12),y
        tay
        pla
        sec
        rts

; ----------------------------------------------------------------------------
LCBC1:  sta     RES
        sty     RES+1
        lda     SCEDEB
        sta     VARAPL+12
        lda     SCEDEB+1
        sta     VARAPL+13
        ldy     #$01
        lda     (VARAPL+12),y
        sta     RESB
        iny
        lda     (VARAPL+12),y
        sta     RESB+1
        cmp     RES+1
        bne     LCBE0
        lda     RESB
        cmp     RES
LCBE0:  bcc     LCBE4
        clc
        rts

; ----------------------------------------------------------------------------
LCBE4:  jsr     LCB89
        bcs     LCC00
        iny
        lda     (VARAPL+12),y
        pha
        iny
        lda     (VARAPL+12),y
        tay
        pla
        cpy     RES+1
        bne     LCBF8
        cmp     RES
LCBF8:  bcs     LCC00
        sta     RESB
        sty     RESB+1
        bne     LCBE4
LCC00:  lda     RESB
        ldy     RESB+1
LCC04:  sta     RES
        sty     RES+1
        lda     SCEDEB
        ldy     SCEDEB+1
        sta     VARAPL+12
        sty     VARAPL+13
        jsr     LCB98
        bcs     LCC2B
LCC15:  ldy     #$02
        lda     RES+1
        cmp     (VARAPL+12),y
        bne     LCC24
        dey
        lda     RES
        cmp     (VARAPL+12),y
        beq     LCC2C
LCC24:  bcc     LCC2B
        jsr     LCB89
        bcc     LCC15
LCC2B:  clc
LCC2C:  lda     RES
        ldy     RES+1
        rts

; ----------------------------------------------------------------------------
LCC31:  lda     VARAPL+3
        ldy     VARAPL+4
        jmp     LCC04

; ----------------------------------------------------------------------------
LCC38:  lda     Ptr1
        ldy     Ptr1+1
        sta     Proc1+1
        sty     Proc1+2
        rts

; ----------------------------------------------------------------------------
LCC45:  lda     Proc1+1
        bne     LCC4D
        dec     Proc1+2
LCC4D:  dec     Proc1+1
        jmp     LCC5B

; ----------------------------------------------------------------------------
LCC53:  inc     Proc1+1
        bne     LCC5B
        inc     Proc1+2
LCC5B:  lda     #$E2
        sta     VEXBNK+1
        lda     #$04
        sta     VEXBNK+2
        lda     $04E1
        sta     BNKCIB
LCC6B:  sei
        jsr     EXBNK
        cli
        rts

; ----------------------------------------------------------------------------
LCC71:  pha
        lda     Proc1+1
        sta     Proc1+5
        lda     Proc1+2
        sta     Proc1+6
        lda     #$E6
        sta     VEXBNK+1
        lda     #$04
        sta     VEXBNK+2
        lda     $04E1
        sta     BNKCIB
        pla
        jmp     LCC6B

; ----------------------------------------------------------------------------
LCC92:  ldx     Ptr2
        lda     Ptr2+1
        cmp     Proc1+2
        bne     LCCA0
        cpx     Proc1+1
LCCA0:  rts

; ----------------------------------------------------------------------------
LCCA1:  clc
        lda     Proc1+1
        adc     VARAPL+14
        sta     Proc1+1
        lda     Proc1+2
        adc     VARAPL+15
        sta     Proc1+2
        rts

; ----------------------------------------------------------------------------
LCCB3:  clc
        lda     Proc1+9
        adc     VARAPL+14
        sta     Proc1+9
        lda     Proc1+10
        adc     VARAPL+15
        sta     Proc1+10
        rts

; ----------------------------------------------------------------------------
LCCC5:  lda     Flags
        ldy     $04F3
        sta     Proc1+9
        sty     Proc1+10
        rts

; ----------------------------------------------------------------------------
LCCD2:  inc     Proc1+9
        bne     LCCDA
        inc     Proc1+10
LCCDA:  rts

; ----------------------------------------------------------------------------
LCCDB:  pha
        lda     #$EA
        sta     VEXBNK+1
        lda     #$04
        sta     VEXBNK+2
        lda     $04E1
        sta     BNKCIB
        pla
        jmp     LCC6B

; ----------------------------------------------------------------------------
LCCF0:  ldx     #$00
        stx     VARAPL+3
        stx     VARAPL+4
LCCF6:  sbc     #$2F
        sta     VARAPL+5
        lda     VARAPL+4
        cmp     #$1A
        bcs     LCD46
        sta     VARAPL+6
        lda     VARAPL+3
        asl
        rol     VARAPL+6
        asl
        rol     VARAPL+6
        adc     VARAPL+3
        sta     VARAPL+3
        lda     VARAPL+6
        adc     VARAPL+4
        sta     VARAPL+4
        asl     VARAPL+3
        rol     VARAPL+4
        bcs     LCD46
        lda     VARAPL+3
        adc     VARAPL+5
        sta     VARAPL+3
        bcc     LCD26
        inc     VARAPL+4
        beq     LCD46
LCD26:  jsr     CharGet
        bcc     LCCF6
LCD2B:  rts

; ----------------------------------------------------------------------------
LCD2C:  ldx     #$00
        stx     VARAPL+3
        stx     VARAPL+4
LCD32:  jsr     CharGet
        bcs     LCD2B
        cmp     #$31
        beq     LCD40
        cmp     #$30
        bne     LCD2B
        clc
LCD40:  rol     VARAPL+3
        rol     VARAPL+4
        bcc     LCD32
LCD46:  ldx     #$0C
        clc
        rts

; ----------------------------------------------------------------------------
LCD4A:  ldx     #$00
        stx     VARAPL+3
        stx     VARAPL+4
        beq     LCD62
LCD52:  ldx     #$03
        asl
        asl
        asl
        asl
LCD58:  asl
        rol     VARAPL+3
        rol     VARAPL+4
        bcs     LCD46
        dex
        bpl     LCD58
LCD62:  jsr     CharGet
        jsr     LCD6E
        bcc     LCD52
        jsr     CharGot
        rts

; ----------------------------------------------------------------------------
LCD6E:  jsr     LC9BF
        cmp     #$80
        bcs     LCD86
        ora     #$80
        eor     #$B0
        cmp     #$0A
        bcc     LCD86
        adc     #$88
        cmp     #$FA
        bcs     LCD85
        sec
        .byte   $24
LCD85:  clc
LCD86:  rts

; ----------------------------------------------------------------------------
LCD87:  tya
        pha
        jsr     CharGot
        bcs     LCD94
        jsr     LCCF0
        jmp     LCDD3

; ----------------------------------------------------------------------------
LCD94:  ldx     TXTPTR+1
        cpx     #$05
        bne     LCD9E
        cmp     #$23
        beq     LCDA2
LCD9E:  cmp     #$24
        bne     LCDB1
LCDA2:  ldy     #$01
        lda     (TXTPTR),y
        jsr     LCD6E
        bcs     LCDDC
        jsr     LCD4A
        jmp     LCDD3

; ----------------------------------------------------------------------------
LCDB1:  cmp     #$25
        bne     LCDC7
        ldy     #$01
        lda     (TXTPTR),y
        cmp     #$30
        beq     LCDC1
        cmp     #$31
        bne     LCDDC
LCDC1:  jsr     LCD2C
        jmp     LCDD3

; ----------------------------------------------------------------------------
LCDC7:  jsr     LC926
        bcs     LCDD0
        ldx     #$00
        beq     LCDDE
LCDD0:  jsr     SymLookup
LCDD3:  bcc     LCDDE
        pla
        tay
        jsr     CharGot
        sec
        rts

; ----------------------------------------------------------------------------
LCDDC:  ldx     #$0B
LCDDE:  pla
        tay
        jsr     CharGot
        clc
        rts

; ----------------------------------------------------------------------------
; Find symbol in local symbol table, return C=1 + symbol address in VARAPL+3 if found
LocSymLookup:
        ldx     #$00
        stx     VARAPL+5
        ldx     VARAPL2+17
        stx     VARAPL+1
        ldx     VARAPL2+18
        stx     VARAPL+2
        ldx     VARAPL2+15
        stx     VARAPL+12
        lda     VARAPL2+16
        sta     VARAPL+13
        bne     LCE2A
LCDFB:  ldy     #$FF
LCDFD:  iny
        cpy     #$06
        beq     LCE37
        lda     (TXTPTR),y
        bit     VARAPL+5
        bpl     LCE0B
        jsr     LC9BF
LCE0B:  cmp     (VARAPL+12),y
        beq     LCDFD
        lda     (VARAPL+12),y
        cmp     #$20
        bne     LCE1C
        lda     (TXTPTR),y
        jsr     LC91A
        bcc     LCE37
LCE1C:  clc
        lda     VARAPL+12
        adc     #$08
        sta     VARAPL+12
        tax
        lda     VARAPL+13
        adc     #$00
        sta     VARAPL+13
LCE2A:  cmp     VARAPL+2
        bne     LCE30
        cpx     VARAPL+1
LCE30:  bcc     LCDFB
        ldx     #$11
        clc
        bcc     LCE46
LCE37:  jsr     IncTXTPTR
        ldy     #$06
        lda     (VARAPL+12),y
        sta     VARAPL+3
        iny
        lda     (VARAPL+12),y
        sta     VARAPL+4
        sec
LCE46:  ldy     #$00
        lda     (TXTPTR),y
        rts

; ----------------------------------------------------------------------------
; Find symbol in global symbol table, return C=1 + symbol address in VARAPL+3 if found
GlobSymLookup:
        ldx     #$00
        stx     VARAPL+5
        ldx     VARAPL2+11
        stx     VARAPL+1
        ldx     VARAPL2+12
        stx     VARAPL+2
        ldx     VARAPL2+9
        stx     VARAPL+12
        lda     VARAPL2+10
        sta     VARAPL+13
        bne     LCE2A
; Find symbol in monitor symbol table, return C=1 + symbol address in VARAPL+3 if found
MonSymLookup:
        ldx     #$80
        stx     VARAPL+5
        ldx     #<SymbolTableEnd
        stx     VARAPL+1
        ldx     #>SymbolTableEnd
        stx     VARAPL+2
        ldx     #<SymbolTable
        stx     VARAPL+12
        lda     #>SymbolTable
        sta     VARAPL+13
        bne     LCE2A
; Find symbol in global, local, monitor symbol table, return C=1 + symbol address in VARAPL+3 if found
SymLookup:
        jsr     GlobSymLookup
        bcs     LCE84
        jsr     LocSymLookup
        bcs     LCE84
        jsr     MonSymLookup
LCE84:  rts

; ----------------------------------------------------------------------------
; Add Y to TXTPTR
IncTXTPTR:
        tya
        clc
        adc     TXTPTR
        sta     TXTPTR
        bcc     LCE8F
        inc     TXTPTR+1
LCE8F:  rts

; ----------------------------------------------------------------------------
LCE90:  cmp     #$22
        bne     LCEB3
        sty     VARAPL
        ldy     #$01
        lda     (TXTPTR),y
        beq     SyntaxErr
        sta     VARAPL+3
        iny
        lda     (TXTPTR),y
        cmp     #$22
        bne     LCEA6
        iny
LCEA6:  jsr     IncTXTPTR
        ldy     VARAPL
        ldx     #$00
        stx     VARAPL+4
        jsr     CharGot
        rts

; ----------------------------------------------------------------------------
LCEB3:  cmp     #$3C
        bne     LCEC4
        jsr     CharGet
        jsr     LCD87
        bcc     OutOfRangeValErr
        ldx     #$00
        stx     VARAPL+4
        rts

; ----------------------------------------------------------------------------
LCEC4:  cmp     #$3E
        bne     LCED9
        jsr     CharGet
        jsr     LCD87
        bcc     OutOfRangeValErr
        ldx     VARAPL+4
        stx     VARAPL+3
        ldx     #$00
        stx     VARAPL+4
        rts

; ----------------------------------------------------------------------------
LCED9:  jsr     LCD87
        bcc     OutOfRangeValErr
        rts

; ----------------------------------------------------------------------------
LCEDF:  jsr     LCE90
        ldx     VARAPL+3
        stx     VARAPL+14
        ldx     VARAPL+4
        stx     VARAPL+15
LCEEA:  cmp     #$2B
        bne     LCEF4
        jsr     LCF06
        bne     LCEEA
LCEF3:  rts

; ----------------------------------------------------------------------------
LCEF4:  cmp     #$2D
        bne     LCEF3
        jsr     LCF1E
        jmp     LCEEA

; ----------------------------------------------------------------------------
; Err $00
SyntaxErr:
        ldx     #$00
        .byte   $2C
LCF01:  ldx     #$0C
; Err $0C
OutOfRangeValErr:
        jmp     LCF98

; ----------------------------------------------------------------------------
LCF06:  jsr     CharGet
        jsr     LCE90
        pha
        clc
        lda     VARAPL+14
        adc     VARAPL+3
        sta     VARAPL+14
        lda     VARAPL+15
        adc     VARAPL+4
        sta     VARAPL+15
        pla
        bcs     LCF01
        rts

; ----------------------------------------------------------------------------
LCF1E:  jsr     CharGet
        jsr     LCE90
        pha
        sec
        lda     VARAPL+14
        sbc     VARAPL+3
        sta     VARAPL+14
        lda     VARAPL+15
        sbc     VARAPL+4
        sta     VARAPL+15
        pla
        bcc     LCF01
        rts

; ----------------------------------------------------------------------------
LCF36:  pla
        tay
        pla
        ldx     #$FE
        txs
        pha
        tya
        pha
        rts

; ----------------------------------------------------------------------------
LCF40:  clc
        lda     SCEDEB
        adc     #$FF
        sta     TXTPTR
        lda     SCEDEB+1
        adc     #$FF
        sta     TXTPTR+1
        ldy     #$00
        tya
        sta     (TXTPTR),y
        rts

; ----------------------------------------------------------------------------
; Set TXTPTR = BUFEDT+X
SetTXTPTR:
        clc
        txa
        adc     #$90
        sta     TXTPTR
        lda     #$05
        adc     #$00
        sta     TXTPTR+1
        rts

; ----------------------------------------------------------------------------
LCF60:  lda     #$90
        sta     TR0
        lda     #$05
        sta     TR1
        lda     VARAPL+16
        sta     RES
        lda     VARAPL+17
        sta     RES+1
        tya
        BRK_TELEMON XINSER
; Initialise les pointeurs de la table des symboles locaux
LocTblInit:
        lda     SCEFIN
        ldy     SCEFIN+1
        sta     VARAPL2+15
        sta     VARAPL2+17
        sty     VARAPL2+16
        sty     VARAPL2+18
        rts

; ----------------------------------------------------------------------------
LCF80:  lda     #XLPR
        BRK_TELEMON XCL0
        lda     #XSCR
        BRK_TELEMON XOP0
        lda     #$00
        sta     XLPRBI
        rts

; ----------------------------------------------------------------------------
LCF8D:  BRK_TELEMON XTSTLP
        lda     #XSCR
        BRK_TELEMON XCL0
        lda     #XLPR
        BRK_TELEMON XOP0
        rts

; ----------------------------------------------------------------------------
LCF98:  txa
        pha
        jsr     LCF80
        pla
        tax
        jsr     DispErrorX
        jsr     LCF36
        lda     VARAPL2+8
        bne     LCFB8
        lda     #$05
        cmp     TXTPTR+1
        bne     LCFC2
        sec
        lda     TXTPTR
        sbc     #$90
        tax
        jmp     LCFC4

; ----------------------------------------------------------------------------
LCFB8:  lda     VARAPL+16
        ldy     VARAPL+17
        jsr     LCC04
        jsr     LCAF2
LCFC2:  ldx     #$06
LCFC4:  ldy     #$80
        bmi     LCFD2
LCFC8:  jsr     LCB5A
LCFCB:  jsr     LCF80
        ldx     #$00
        ldy     #$00
LCFD2:  lda     #$6E
        BRK_TELEMON XEDT
        pha
        lda     RES
        sta     VARAPL+16
        lda     RES+1
        sta     VARAPL+17
        pla
        jsr     LC8DC
        stx     VARAPL2+8
        cpx     #$00
        bne     LD010
        cmp     #$0D
        bne     LCFCB
        jsr     LCA2D
        beq     LCFCB
        jsr     LCA1D
        bmi     ExecCmd
        jsr     SetTXTPTR
        jsr     CharGot
        jmp     LD1BA

; ----------------------------------------------------------------------------
; Execute command number ACC
ExecCmd:asl
        tay
        jsr     SetTXTPTR
        lda     CommandsAddr+1,y
        pha
        lda     CommandsAddr,y
        pha
        jmp     CharGet

; ----------------------------------------------------------------------------
LD010:  cmp     #$03
        beq     LCFCB
        cmp     #$0A
        bne     LD027
        lda     VARAPL+16
        ldy     VARAPL+17
        jsr     LCBAA
        bcc     LCFCB
        jsr     LCAF2
        jmp     LCFC2

; ----------------------------------------------------------------------------
LD027:  cmp     #$0B
        bne     LD040
        BRK_TELEMON XWR0
        lda     #$0D
        BRK_TELEMON XWR0
        lda     VARAPL+16
        ldy     VARAPL+17
        jsr     LCBC1
        bcc     LCFCB
        jsr     LCA91
        jmp     LCFC2

; ----------------------------------------------------------------------------
LD040:  ldy     #$00
        jsr     LCA30
        beq     LD04C
        jsr     LC934
        bcc     LD052
LD04C:  jsr     LCF60
        jmp     LCFCB

; ----------------------------------------------------------------------------
LD052:  lda     #$0B
        BRK_TELEMON XWR0
        jsr     DispErrorX
        tax
        jmp     LCFC4

; ----------------------------------------------------------------------------
LD05D:  BRK_TELEMON XWR0
        BRK_TELEMON XCRLF
QUIT:   jsr     Clear
        jsr     LC88B
        ldx     #$06
        lda     #$E6
        ldy     #$FF
        jmp     LD27E

; ----------------------------------------------------------------------------
; teleass_start
teleass_start:
        lda     #<Menu_str
        ldy     #>Menu_str
        BRK_TELEMON XWSTR0
LD076:  jsr     LC8D1
        cmp     #$31
        beq     LD05D
        cmp     #$32
        bne     LD076
        BRK_TELEMON XWR0
        BRK_TELEMON XCRLF
        lda     #$07
        sta     DEFBNK
        lda     #$00
        sta     SCEDEB
        sta     LPRY
        lda     #$08
        sta     SCEDEB+1
        lda     #$00
        sta     VARAPL2+9
        sta     VARAPL2+11
        lda     #$FF
        sta     VARAPL2+13
        lda     #$30
        sta     VARAPL2+10
        sta     VARAPL2+12
        lda     #$3F
        sta     VARAPL2+14
        jsr     Clear
        lda     #$42
        sta     LPRFY
        sta     LPRSY
Warm_start:
        jsr     LocTblInit
        ldx     #$10
LD0B9:  lda     _CharGet,x
        sta     CharGet,x
        dex
        bpl     LD0B9
        ldy     #$0B
LD0C3:  lda     _Proc1,y
        sta     Proc1,y
        dey
        bpl     LD0C3
        tya
        iny
        sta     (TXTPTR),y
        lda     FLGSCR
        ora     #$90
        sta     FLGSCR
        lda     V2DRA
        and     #$07
        sta     VNMI
        lda     #<Warm_start
        sta     VNMI+1
        lda     #>Warm_start
        sta     VNMI+2
        jsr     LC8DC
        jmp     LCFCB

; ----------------------------------------------------------------------------
; Prends le caractère suivant en sautant les espaces (Copié en VARAPL+18)
_CharGet:
        inc     TXTPTR
        bne     _CharGot
        inc     TXTPTR+1
; Prends le caractère courant
_CharGot:
        lda     teleass_irq_vector+1
        cmp     #$20
        beq     _CharGet
        jsr     LD10D
        rts

; ----------------------------------------------------------------------------
; Trouver un meilleur nom (cf $04E2)
_Proc1: lda     teleass_irq_vector+1
        rts

; ----------------------------------------------------------------------------
        sta     teleass_irq_vector+1
        rts

; ----------------------------------------------------------------------------
        sta     teleass_irq_vector+1
        rts

; ----------------------------------------------------------------------------
LD10D:  cmp     #$00
        beq     LD11F
        cmp     #$27
        beq     LD11F
        cmp     #$3A
        bcs     LD11F
        sec
        sbc     #$30
        sec
        sbc     #$D0
LD11F:  rts

; ----------------------------------------------------------------------------
; Efface le programme et initialise les pointeurs de la table des symboles locaux
Clear:  ldy     #$00
        tya
        sta     (SCEDEB),y
        clc
        lda     SCEDEB
        adc     #$01
        sta     SCEFIN
        lda     SCEDEB+1
        adc     #$00
        sta     SCEFIN+1
        jmp     LocTblInit

; ----------------------------------------------------------------------------
NEW:    tax
        bne     SyntaxErr1
        jsr     Clear
        jmp     LCFCB

; ----------------------------------------------------------------------------
LD13E:  ldy     #$00
        cmp     #$22
        bne     LD14A
        jsr     CharGet
        tax
        beq     SyntaxErr1
LD14A:  lda     TXTPTR
        pha
        lda     TXTPTR+1
        pha
LD150:  lda     (TXTPTR),y
        beq     LD161
        cmp     #$2C
        beq     LD161
        cmp     #$22
        beq     LD161
        iny
        bne     LD150
        beq     SyntaxErr1
LD161:  tya
        tax
        lda     (TXTPTR),y
        cmp     #$22
        bne     LD16A
        iny
LD16A:  jsr     IncTXTPTR
        pla
        tay
        pla
        BRK_TELEMON XNOMFI
        txa
        bmi     FileNameErr
        ldy     BUFNOM
        lda     TABDRV,y
        beq     DriveErr
        sty     DRIVE
        txa
        rts

; ----------------------------------------------------------------------------
LD182:  tax
        beq     SyntaxErr1
        ldx     #$00
        stx     VSALO0
        stx     VSALO1
        jsr     LD13E
        beq     SyntaxErr1
        php
        cpx     #$02
        beq     LD19B
        plp
        php
        bcs     WildCardErr
LD19B:  plp
        dex
        rts

; ----------------------------------------------------------------------------
; Err $0A
DriveErr:
        ldx     #$0A
        .byte   $2C
; Err $00
SyntaxErr1:
        ldx     #$00
        .byte   $2C
; Err $09
FileNameErr:
        ldx     #$09
        .byte   $2C
; Err $18
WildCardErr:
        ldx     #$18
LD1A9:  jmp     LCF98

; ----------------------------------------------------------------------------
LD1AC:  cmp     #$2C
        bne     SyntaxErr1
        jsr     CharGet
        jsr     LC9BF
        tax
        beq     SyntaxErr1
        rts

; ----------------------------------------------------------------------------
LD1BA:  jsr     LD182
        beq     LD1CD
        jsr     CharGot
        tax
        bne     SyntaxErr1
        jmp     LCFCB

; ----------------------------------------------------------------------------
LOAD:   jsr     LD182
        bne     FileNameErr
LD1CD:  jsr     CharGot
        tax
LD1D1:  beq     LD208
        jsr     LD1AC
        cmp     #$56
        bne     LD1ED
        lda     #$40
LD1DC:  pha
        lda     VSALO0
        bne     LD1A9
        pla
        sta     VSALO0
        jsr     CharGet
        tax
        jmp     LD1D1

; ----------------------------------------------------------------------------
LD1ED:  cmp     #$4E
        bne     LD1F5
        lda     #$80
        bne     LD1DC
LD1F5:  cmp     #$41
        bne     SyntaxErr1
        lda     VSALO1
        bne     SyntaxErr1
        lda     #$80
        sta     VSALO1
        jsr     LD273
        bne     LD1D1
LD208:  lda     #<XLOAD
        ldy     #>XLOAD
        jsr     EXBNK0ERR
        bit     FTYPE
        bpl     LD226
        bit     VSALO0
        bvs     LD226
        lda     INPIS
        ldy     INSEC
        sta     SCEDEB
        sty     SCEDEB+1
        jsr     LD229
LD226:  jmp     LCFCB

; ----------------------------------------------------------------------------
LD229:  lda     PARPIS
        ldy     PARSEC
        sta     SCEFIN
        sty     SCEFIN+1
        jsr     LocTblInit
LD236:  cpy     VARAPL2+10
        bcc     LD266
        bne     LD240
        cmp     VARAPL2+9
        bcc     LD266
LD240:  sta     VARAPL2+9
        sty     VARAPL2+10
        sta     VARAPL2+11
        sty     VARAPL2+12
        sta     VARAPL2+13
        iny
        sty     VARAPL2+14
        ldx     #$19
        jmp     DispErrorX

; ----------------------------------------------------------------------------
LD252:  jsr     EXBNK0ERR
        jmp     LCFCB

; ----------------------------------------------------------------------------
LD258:  ldx     ERRNB
        jmp     LCF98

; ----------------------------------------------------------------------------
; Exécute une routine en banque 0 et affiche le code d'erreur
EXBNK0ERR:
        jsr     EXBNK0
        ldx     ERRNB
        bne     LD258
LD266:  rts

; ----------------------------------------------------------------------------
LD267:  jsr     CharGet
LD26A:  jsr     LCEDF
        tax
        lda     VARAPL+14
        ldy     VARAPL+15
        rts

; ----------------------------------------------------------------------------
LD273:  jsr     LD267
        sta     INPIS
        sty     INSEC
        txa
        rts

; ----------------------------------------------------------------------------
LD27E:  sta     VEXBNK+1
        sty     VEXBNK+2
        stx     BNKCIB
        jmp     EXBNK

; ----------------------------------------------------------------------------
; Exécute une routine en banque 0 (adresse en AY)
EXBNK0: php
        sta     VEXBNK+1
        sty     VEXBNK+2
        lda     #$00
        sta     BNKCIB
        sta     ERRNB
        txa
        tsx
        dex
        dex
        dex
        dex
        stx     SAVES
        tax
        jsr     EXBNK
        plp
        rts

; ----------------------------------------------------------------------------
LD2A8:  jsr     LCC92
        bcs     LD2B0
        sec
        bcs     LD2B3
LD2B0:  jsr     LC8B4
LD2B3:  php
        jsr     LCB5A
        plp
        rts

; ----------------------------------------------------------------------------
DESAS:  ldy     #$00
        .byte   $2C
LDESAS: ldy     #$80
        sty     XLPRBI
        jsr     LD368
LD2C3:  jsr     LD3CB
        jsr     LCC53
        jsr     LD2A8
        bcc     LD2C3
        bcs     LD2E2
DUMP:   ldy     #$00
        .byte   $2C
LDUMP:  ldy     #$80
        sty     XLPRBI
        jsr     LD368
LD2DA:  jsr     LD2E8
        jsr     LD2A8
        bcc     LD2DA
LD2E2:  jsr     LC8DC
        jmp     LCFCB

; ----------------------------------------------------------------------------
LD2E8:  lda     Proc1+1
        ldy     Proc1+2
        sta     VARAPL+8
        sty     VARAPL+9
        jsr     DispWord
        jsr     DispSpace
        jsr     DispSpace
        ldy     #$08
        sty     VARAPL+10
        sty     VARAPL+11
LD301:  jsr     LCC5B
        jsr     DispByte
        jsr     DispSpace
        jsr     LCC53
        dec     VARAPL+10
        bne     LD301
        jsr     DispSpace
        lda     VARAPL+8
        sta     Proc1+1
        lda     VARAPL+9
        sta     Proc1+2
LD31E:  jsr     LCC5B
        jsr     LC716
        jsr     LCC53
        dec     VARAPL+11
        bne     LD31E
        rts

; ----------------------------------------------------------------------------
BANK:   tax
        bne     LD334
        jsr     LD356
        beq     LD339
LD334:  jsr     LD349
        bne     SyntaxErr2
LD339:  stx     DEFBNK
        jmp     LCFCB

; ----------------------------------------------------------------------------
LD33F:  jsr     LD1AC
LD342:  cmp     #$42
        bne     SyntaxErr2
LD346:  jsr     CharGet
LD349:  jsr     LCEDF
        ldx     VARAPL+14
        ldy     VARAPL+15
        bne     IllegalValErr
        cpx     #$08
        bcs     IllegalValErr
LD356:  pha
        txa
        pha
        jsr     DispBank
        pla
        tax
        pla
        rts

; ----------------------------------------------------------------------------
; Err $00
SyntaxErr2:
        ldx     #$00
        .byte   $2C
; Err $0B
IllegalValErr:
        ldx     #$0B
        jmp     LCF98

; ----------------------------------------------------------------------------
LD368:  jsr     LD26A
        sta     Proc1+1
        sty     Proc1+2
        lda     DEFBNK
        sta     $04E1
        lda     #$FF
        sta     Ptr2
        sta     Ptr2+1
        txa
        beq     LD3A4
        jsr     LD1AC
        cmp     #$42
        bne     LD38F
        jsr     LD346
        jmp     LD39E

; ----------------------------------------------------------------------------
LD38F:  jsr     LD26A
        sta     Ptr2
        sty     Ptr2+1
        txa
        beq     LD3A4
        jsr     LD33F
LD39E:  stx     $04E1
        tax
        bne     SyntaxErr2
LD3A4:  bit     XLPRBI
        bpl     LD3AB
        jsr     LCF8D
LD3AB:  jmp     LCB5A

; ----------------------------------------------------------------------------
LD3AE:  clc
        ldx     Proc1+1
        ldy     Proc1+2
        inx
        bne     LD3B9
        iny
LD3B9:  clc
        txa
        adc     HRS4
        tax
        ror
        eor     HRS4
        bpl     LD3CA
        lda     HRS4
        bpl     LD3C9
        dey
        rts

; ----------------------------------------------------------------------------
LD3C9:  iny
LD3CA:  rts

; ----------------------------------------------------------------------------
LD3CB:  lda     Proc1+1
        ldy     Proc1+2
        jsr     DispWord
        jsr     DispSpace
        jsr     DispSpace
        jsr     LCC5B
        jsr     DecodeOpc
        jsr     DispByte
        lda     INDIC0+1
        beq     LD405
        jsr     DispSpace
        jsr     LCC53
        sta     HRS4
        jsr     DispByte
        ldx     INDIC0+1
        dex
        beq     LD408
        jsr     DispSpace
        jsr     LCC53
        sta     HRS4+1
        jsr     DispByte
        ldy     #$02
        .byte   $2C
LD405:  ldy     #$08
        .byte   $2C
LD408:  ldy     #$05
        jsr     DispYSpace
        lda     INDIC2
        jsr     PutMnemo
        jsr     DispString
        jsr     DispSpace
        lda     INDIC0
        beq     LD481
        cmp     #$C1
        bne     LD42D
        lda     #$24
        BRK_TELEMON XWR0
        jsr     LD3AE
        txa
        jsr     DispWord
        beq     LD481
LD42D:  bit     INDIC0
        bpl     LD435
        lda     #$23
        bne     LD439
LD435:  bvc     LD43B
        lda     #$28
LD439:  BRK_TELEMON XWR0
LD43B:  lda     #$24
        BRK_TELEMON XWR0
        ldx     INDIC0+1
        lda     HRS4
        ldy     HRS4+1
        dex
        beq     LD44D
        jsr     DispWord
        beq     LD450
LD44D:  jsr     DispByte
LD450:  lda     INDIC0
        and     #$3C
        beq     LD481
        asl
        asl
        bpl     LD460
        pha
        lda     #$29
        BRK_TELEMON XWR0
        pla
LD460:  asl
        bpl     LD46D
        pha
        lda     #$2C
        BRK_TELEMON XWR0
        lda     #$58
        BRK_TELEMON XWR0
        pla
LD46D:  asl
        bpl     LD47A
        pha
        lda     #$2C
        BRK_TELEMON XWR0
        lda     #$59
        BRK_TELEMON XWR0
        pla
LD47A:  asl
        bpl     LD481
        lda     #$29
        BRK_TELEMON XWR0
LD481:  rts

; ----------------------------------------------------------------------------
LD482:  lda     SCEDEB
        sta     VARAPL+10
        lda     SCEDEB+1
        sta     VARAPL+11
LD48A:  ldy     #$00
        lda     (VARAPL+10),y
        beq     UnknSymErr
        iny
        lda     (VARAPL+10),y
        sta     VARAPL+3
        iny
        lda     (VARAPL+10),y
        sta     VARAPL+4
        iny
        lda     (VARAPL+10),y
        beq     LD4C6
        bmi     LD4C6
        cmp     #$27
        beq     LD4C6
        lda     VARAPL+10
        pha
        lda     VARAPL+11
        pha
        tya
        clc
        adc     VARAPL+10
        sta     VARAPL+10
        bcc     LD4B5
        inc     VARAPL+11
LD4B5:  ldy     #$FF
LD4B7:  iny
        lda     (VARAPL+10),y
        bmi     LD4D6
        cmp     (TXTPTR),y
        beq     LD4B7
LD4C0:  pla
        sta     VARAPL+11
        pla
        sta     VARAPL+10
LD4C6:  ldy     #$00
        clc
        lda     (VARAPL+10),y
        adc     VARAPL+10
        sta     VARAPL+10
        bcc     LD4D3
        inc     VARAPL+11
LD4D3:  jmp     LD48A

; ----------------------------------------------------------------------------
LD4D6:  cpy     #$06
        beq     LD4EA
        lda     (TXTPTR),y
        beq     LD4EA
        cmp     #$2D
        beq     LD4EA
        cmp     #$2C
        beq     LD4EA
        cmp     #$20
        bne     LD4C0
LD4EA:  pla
        pla
        jmp     IncTXTPTR

; ----------------------------------------------------------------------------
; Err $11
UnknSymErr:
        ldx     #$11
        jmp     LCF98

; ----------------------------------------------------------------------------
LD4F4:  lda     #$00
        sta     VARAPL+3
        sta     VARAPL+4
        jsr     LCC31
        jsr     CharGot
        tax
        beq     LD53F
        bcc     LD50F
        cmp     #$2D
        beq     LD521
        jsr     LD482
        jmp     LD514

; ----------------------------------------------------------------------------
LD50F:  jsr     LCCF0
        bcc     LD534
LD514:  jsr     LCC31
        jsr     CharGot
        tax
        beq     LD53F
        cmp     #$2D
        bne     LD531
LD521:  jsr     CharGet
        tax
        beq     LD53F
        bcs     LD535
        jsr     LCCF0
        bcc     LD534
        tax
        beq     LD546
LD531:  ldx     #$00
        clc
LD534:  rts

; ----------------------------------------------------------------------------
LD535:  jsr     LD482
        jsr     CharGot
        tax
        bne     LD531
        rts

; ----------------------------------------------------------------------------
LD53F:  ldx     #$FF
        stx     VARAPL+4
        dex
        stx     VARAPL+3
LD546:  sec
        rts

; ----------------------------------------------------------------------------
LD548:  jmp     LCF98

; ----------------------------------------------------------------------------
LIST:   BRK_TELEMON XCRLF
        lda     #$00
        .byte   $2C
LLIST:  lda     #$80
        sta     XLPRBI
        jsr     LD4F4
        bcc     LD548
        jsr     LCB98
        bcs     LD586
        bit     XLPRBI
        bpl     LD565
        jsr     LCF8D
LD565:  ldy     #$01
        lda     (VARAPL+12),y
        tax
        iny
        lda     (VARAPL+12),y
        cmp     VARAPL+4
        bne     LD575
        cpx     VARAPL+3
        beq     LD577
LD575:  bcs     LD586
LD577:  tay
        txa
        jsr     LCAF2
        jsr     LD2B0
        bcs     LD586
        jsr     LCB89
        bcc     LD565
LD586:  jmp     LCFCB

; ----------------------------------------------------------------------------
RENUM:  pha
        ldx     #$FF
        stx     DECTRV
        stx     DECTRV+1
        inx
        stx     DECCIB
        stx     DECCIB+1
        stx     DECDEB+1
        stx     DECFIN+1
        ldx     #$0A
        stx     DECDEB
        stx     DECFIN
        ldy     #$00
        pla
        beq     LD5E7
LD5A4:  cmp     #$2C
        beq     LD5DF
        sty     VARAPL+7
        jsr     CharGot
        bcc     LD5BC
        cpy     #$02
        beq     SyntaxErr3
        jsr     LD482
        jsr     CharGot
        jmp     LD5C1

; ----------------------------------------------------------------------------
LD5BC:  jsr     LCCF0
        bcc     LD5DC
LD5C1:  pha
        ldy     VARAPL+7
        cpy     #$07
        bcs     SyntaxErr3
        lda     VARAPL+3
        sta     DECDEB,y
        iny
        lda     VARAPL+4
        sta     DECDEB,y
        pla
        beq     LD5E7
        cmp     #$2C
        beq     LD5E0
; Err $00
SyntaxErr3:
        ldx     #$00
LD5DC:  jmp     LCF98

; ----------------------------------------------------------------------------
LD5DF:  iny
LD5E0:  iny
        jsr     CharGet
        tax
        bne     LD5A4
LD5E7:  lda     DECFIN
        ora     DECFIN+1
        bne     LD5F1
        lda     #$0A
        sta     DECFIN
LD5F1:  lda     DECTRV
        ldy     DECTRV+1
        jsr     LCC04
        lda     VARAPL+12
        sta     DECTRV
        lda     VARAPL+13
        sta     DECTRV+1
        lda     DECCIB
        ldy     DECCIB+1
        jsr     LCC04
        jsr     LCB98
        bcs     LD63A
        ldy     #$00
LD60E:  lda     DECTRV+1
        cmp     VARAPL+13
        bne     LD618
        lda     DECTRV
        cmp     VARAPL+12
LD618:  bcc     LD63A
        iny
        lda     DECDEB
        sta     (VARAPL+12),y
        pha
        iny
        lda     DECDEB+1
        sta     (VARAPL+12),y
        tay
        clc
        pla
        adc     DECFIN
        sta     DECDEB
        tya
        adc     DECFIN+1
        sta     DECDEB+1
        ldx     #$0C
        bcs     LD5DC
        jsr     LCB89
        bne     LD60E
LD63A:  jmp     LCFCB

; ----------------------------------------------------------------------------
DELETE: tax
        bne     LD643
        jmp     NEW

; ----------------------------------------------------------------------------
LD643:  jsr     LD4F4
        bcc     LD5DC
        lda     VARAPL+12
        sta     DECCIB
        lda     VARAPL+13
        sta     DECCIB+1
        inc     VARAPL+3
        bne     LD656
        inc     VARAPL+4
LD656:  jsr     LCC31
        lda     VARAPL+12
        sta     DECDEB
        lda     VARAPL+13
        sta     DECDEB+1
        lda     SCEFIN
        sta     DECFIN
        lda     SCEFIN+1
        sta     DECFIN+1
        BRK_TELEMON XDECAL
        lda     SCEDEB
        sta     VARAPL+12
        lda     SCEDEB+1
        sta     VARAPL+13
        ldy     #$00
        lda     (VARAPL+12),y
        beq     LD67E
LD679:  jsr     LCB89
        bcc     LD679
LD67E:  clc
        lda     VARAPL+12
        adc     #$01
        sta     SCEFIN
        lda     VARAPL+13
        adc     #$00
        sta     SCEFIN+1
        jmp     LCFCB

; ----------------------------------------------------------------------------
DIR:    ldx     #$00
        .byte   $2C
LDIR:   ldx     #$80
        stx     XLPRBI
        jsr     LD13E
        jsr     CharGot
        tax
        bne     LD6AC
        bit     XLPRBI
        bpl     LD6A5
        jsr     LCF8D
LD6A5:  lda     #<XDIRN
        ldy     #>XDIRN
        jmp     LD252

; ----------------------------------------------------------------------------
LD6AC:  jmp     SyntaxErr1

; ----------------------------------------------------------------------------
SAVE:   ldx     #$80
        .byte   $2C
SAVEU:  ldx     #$C0
        .byte   $2C
SAVEO:  ldx     #$00
        .byte   $2C
SAVEM:  ldx     #$40
        stx     VSALO0
        ldx     #$80
        stx     FTYPE
        ldx     SCEDEB
        stx     INPIS
        ldx     SCEDEB+1
        stx     INSEC
        ldx     SCEFIN
        stx     PARPIS
        ldx     SCEFIN+1
        stx     PARSEC
        ldx     #$00
        stx     EXSALO
        stx     EXSALO+1
        tax
        beq     LD737
        jsr     LD13E
        bcs     WildCardErr1
        beq     LD6AC
        dex
        bne     LD735
        jsr     CharGot
        tax
        beq     LD72B
        jsr     LD1AC
        cmp     #$41
        bne     LD6AC
        lda     #$40
        sta     FTYPE
        jsr     LD273
        jsr     LD1AC
        cmp     #$45
        bne     LD6AC
        jsr     LD267
        sta     PARPIS
        sty     PARSEC
        txa
        beq     LD72B
        jsr     LD1AC
        cmp     #$54
        bne     LD6AC
        lda     #$41
        sta     FTYPE
        jsr     LD267
        sta     EXSALO
        sty     EXSALO+1
        txa
        bne     LD6AC
LD72B:  lda     #<XSAVE
        ldy     #>XSAVE
        jmp     LD252

; ----------------------------------------------------------------------------
; Err $18
WildCardErr1:
        ldx     #$18
        .byte   $2C
LD735:  ldx     #$09
LD737:  jmp     LCF98

; ----------------------------------------------------------------------------
DEL:    tax
        beq     SyntaxErr4
        jsr     LD13E
        pha
        jsr     CharGot
        tax
        bne     SyntaxErr4
        pla
        tax
        beq     SyntaxErr4
        dex
        bne     LD735
        lda     #<XDELN
        ldy     #>XDELN
        jsr     EXBNK0ERR
        jmp     LCFC8

; ----------------------------------------------------------------------------
DELBAK: tax
        bne     SyntaxErr4
        lda     #<XDELBK
        ldy     #>XDELBK
        jsr     EXBNK0ERR
        jmp     LCFC8

; ----------------------------------------------------------------------------
EXT:    tax
        bne     GetEXTparam
        lda     #$7F
        BRK_TELEMON XWR0
        ldy     #$00
LD76E:  lda     EXTDEF,y
        BRK_TELEMON XWR0
        iny
        cpy     #$03
        bne     LD76E
        jmp     LCFC8

; ----------------------------------------------------------------------------
GetEXTparam:
        cmp     #$22
        bne     LD784
        ldy     #$01
        jsr     IncTXTPTR
LD784:  ldy     #$FF
LD786:  iny
        lda     (TXTPTR),y
        beq     SetEXT
        cmp     #$22
        beq     SetEXT
        jsr     LC9BF
        sta     BUFTRV,y
        cpy     #$03
        bne     LD786
; Err $00
SyntaxErr4:
        ldx     #$00
        .byte   $2C
; Err $09
FileNameErr1:
        ldx     #$09
        jmp     LCF98

; ----------------------------------------------------------------------------
SetEXT: cpy     #$03
        bne     FileNameErr1
        cmp     #$22
        bne     LD7AA
        iny
LD7AA:  jsr     IncTXTPTR
        jsr     CharGot
        tax
        bne     SyntaxErr4
        ldy     #$02
LD7B5:  lda     BUFTRV,y
        sta     EXTDEF,y
        dey
        bpl     LD7B5
        jmp     LCFCB

; ----------------------------------------------------------------------------
BACKUP: tax
        bne     SyntaxErr4
        sta     BUFNOM
        lda     TABDRV+1
        beq     LD7CE
        lda     #$01
LD7CE:  sta     BUFNOM+1
        lda     #<XBKP
        ldy     #$FF
        jsr     EXBNK0ERR
        jmp     LCFC8

; ----------------------------------------------------------------------------
INIT:   tax
        bne     SyntaxErr4
        sta     PARPIS
        sta     PARSEC
        lda     #<XINITI
        ldy     #>XINITI
        jsr     EXBNK0ERR
        jmp     LCFC8

; ----------------------------------------------------------------------------
LD7EE:  ldy     #$00
LD7F0:  lda     (TXTPTR),y
        beq     LD805
        iny
        bne     LD7F0
        jmp     LD805

; ----------------------------------------------------------------------------
LD7FA:  ldy     #$01
        lda     (TXTPTR),y
        sta     VARAPL+16
        iny
        lda     (TXTPTR),y
        sta     VARAPL+17
LD805:  iny
LD806:  jsr     IncTXTPTR
        ldy     #$00
        lda     (TXTPTR),y
        rts

; ----------------------------------------------------------------------------
LD80E:  lda     Ptr1+1
        bne     OrgDefErr
        jsr     CharGet
        jsr     LCD87
        bcc     LD85D
        lda     VARAPL+3
        sta     Ptr1
        lda     VARAPL+4
        sta     Ptr1+1
        beq     IllegalValErr2
LD827:  ldy     #$00
        lda     (TXTPTR),y
        beq     LD831
        cmp     #$27
        bne     SyntaxErr5
LD831:  rts

; ----------------------------------------------------------------------------
LD832:  ldy     #$00
LD834:  lda     (TXTPTR),y
        beq     SyntaxErr5
        bmi     LD806
        iny
        bne     LD834
; Err $00
SyntaxErr5:
        ldx     #$00
        .byte   $2C
; Err $0B
IllegalValErr2:
        ldx     #$0B
        .byte   $2C
; Err $0C
OutOfRangeValErr1:
        ldx     #$0C
        .byte   $2C
; Err $0D
MemFullErr:
        ldx     #$0D
        .byte   $2C
; Err $0F (inutilisé?)
IllegalLabErr:
        ldx     #$0F
        .byte   $2C
; Err $10
LabelDefErr:
        ldx     #$10
        .byte   $2C
; Err $15
OrgDefErr:
        ldx     #$15
        .byte   $2C
; Err $11 (inutilisé?)
UnknSymErr1:
        ldx     #$11
        .byte   $2C
; Err $12
OutOfRangeBraErr2:
        ldx     #$12
        .byte   $2C
; Err $13
IllegalAddrModErr:
        ldx     #$13
        .byte   $2C
; Err $14
UnknOrgErr:
        ldx     #$14
LD85D:  jmp     LCF98

; ----------------------------------------------------------------------------
LD860:  jsr     LocSymLookup
        bcs     LabelDefErr
        bit     HRSY
        bpl     LD891
        cmp     #$2E
        beq     LD891
LD86D:  jsr     GlobSymLookup
        bcs     LD8C6
        lda     VARAPL2+11
        adc     #$08
        tax
        lda     VARAPL2+12
        adc     #$00
        cmp     VARAPL2+14
        bne     LD881
        cpx     VARAPL2+13
LD881:  bcs     MemFullErr
        stx     VARAPL2+11
        sta     VARAPL2+12
        stx     VARAPL+1
        sta     VARAPL+2
        lda     #$00
        sta     (VARAPL+1),y
        beq     LD8AF
LD891:  clc
        lda     VARAPL2+17
        adc     #$08
        tax
        lda     VARAPL2+18
        adc     #$00
        cmp     VARAPL2+10
        bne     LD8A1
        cpx     VARAPL2+9
LD8A1:  bcs     MemFullErr
        stx     VARAPL2+17
        sta     VARAPL2+18
        stx     VARAPL+1
        sta     VARAPL+2
        lda     #$00
        sta     (VARAPL+1),y
LD8AF:  lda     (TXTPTR),y
        sta     (VARAPL+12),y
        bmi     LD8B8
        iny
        bne     LD8AF
LD8B8:  jsr     IncTXTPTR
LD8BB:  cpy     #$06
        bcs     LD8C6
        lda     #$20
        sta     (VARAPL+12),y
        iny
        bne     LD8BB
LD8C6:  ldy     #$06
        lda     #$55
        sta     (VARAPL+12),y
        iny
        sta     (VARAPL+12),y
        ldy     #$00
        lda     (TXTPTR),y
        rts

; ----------------------------------------------------------------------------
LD8D4:  ldy     #$06
        cmp     #$BC
        beq     LD8EC
        cmp     #$B9
        beq     LD8EC
        pha
        lda     Proc1+1
        sta     (VARAPL+12),y
        iny
        lda     Proc1+2
        sta     (VARAPL+12),y
        pla
        rts

; ----------------------------------------------------------------------------
LD8EC:  lda     VARAPL+12
        pha
        lda     VARAPL+13
        pha
        jsr     CharGet
        jsr     LCEDF
        pla
        sta     VARAPL+13
        pla
        sta     VARAPL+12
        ldy     #$06
        lda     VARAPL+14
        sta     (VARAPL+12),y
        iny
        lda     VARAPL+15
        sta     (VARAPL+12),y
        jmp     LD827

; ----------------------------------------------------------------------------
LD90C:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
LD90F:  jmp     IllegalValErr2

; ----------------------------------------------------------------------------
LD912:  jsr     CharGet
        ldx     #$FF
        tay
        beq     LD91E
        cmp     #$27
        bne     LD922
LD91E:  lda     #$00
        beq     LD996
LD922:  cmp     #$23
        bne     LD936
        jsr     CharGet
        jsr     LCEDF
        ldx     VARAPL+15
        bne     LD90F
        ldx     #$81
        stx     INDIC0
        bne     LD97F
LD936:  ldx     #$01
        stx     INDIC0
        cmp     #$28
        bne     LD946
        lda     #$40
        jsr     LD9A0
        jsr     CharGet
LD946:  jsr     LCEDF
        cmp     #$29
        bne     LD955
        lda     #$20
        jsr     LD9A0
        jsr     CharGet
LD955:  cmp     #$2C
        bne     LD97F
        jsr     CharGet
        cmp     #$58
        bne     LD967
        lda     #$10
        jsr     LD9A0
        bne     LD970
LD967:  cmp     #$59
        bne     LD90C
        lda     #$08
        jsr     LD9A0
LD970:  jsr     CharGet
        cmp     #$29
        bne     LD97F
        lda     #$04
        jsr     LD9A0
        jsr     CharGet
LD97F:  jsr     LD827
        ldx     #$00
        lda     INDIC0
        jsr     LCA79
        bcc     LD98F
        ldy     VARAPL+15
        beq     LD99B
LD98F:  inx
        lda     INDIC0
        and     #$FE
        ora     #$02
LD996:  jsr     LCA79
        bcc     LD99D
LD99B:  inx
        rts

; ----------------------------------------------------------------------------
LD99D:  jmp     IllegalAddrModErr

; ----------------------------------------------------------------------------
LD9A0:  ora     INDIC0
        sta     INDIC0
        rts

; ----------------------------------------------------------------------------
LD9A5:  jsr     CharGet
        cmp     #$2B
        bne     LD9B1
        jsr     LCF06
        bcc     LD9BD
LD9B1:  cmp     #$2D
        bne     LD9BA
        jsr     LCF1E
        bcs     LD9BD
LD9BA:  jsr     LCEDF
LD9BD:  jmp     LD827

; ----------------------------------------------------------------------------
LD9C0:  clc
        lda     Proc1+1
        adc     #$02
        sta     VARAPL+14
        sta     VARAPL+8
        lda     Proc1+2
        adc     #$00
        sta     VARAPL+15
        sta     VARAPL+9
        jsr     LD9A5
        sec
        lda     VARAPL+14
        sbc     VARAPL+8
        sta     VARAPL+14
        lda     VARAPL+15
        sbc     VARAPL+9
        beq     LD9EE
        cmp     #$FF
        bne     LD9EB
        lda     VARAPL+14
        bmi     LD9F2
LD9EB:  jmp     OutOfRangeBraErr2

; ----------------------------------------------------------------------------
LD9EE:  lda     VARAPL+14
        bmi     LD9EB
LD9F2:  lda     #$C1
        jsr     LCA79
        ldx     #$01
        rts

; ----------------------------------------------------------------------------
LD9FA:  ldy     #$00
LD9FC:  jsr     CharGet
        iny
        jsr     LCEDF
        pha
        lda     VARAPL+15
        jsr     LCCDB
        jsr     LCCD2
        lda     VARAPL+14
        jsr     LCCDB
        jsr     LCCD2
        pla
        beq     LDA57
        cmp     #$27
        bne     LD9FC
        beq     LDA57
LDA1D:  ldy     #$00
LDA1F:  jsr     CharGet
        iny
        jsr     LCEDF
        pha
        lda     VARAPL+14
        jsr     LCCDB
        jsr     LCCD2
        lda     VARAPL+15
        jsr     LCCDB
        jsr     LCCD2
        pla
        beq     LDA57
        cmp     #$27
        bne     LDA1F
        beq     LDA57
LDA40:  ldy     #$00
LDA42:  jsr     CharGet
        iny
        jsr     LCEDF
        tax
        beq     LDA57
        cmp     #$27
        beq     LDA57
        cmp     #$2C
        beq     LDA42
LDA54:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
LDA57:  tya
        asl
        sta     VARAPL+14
LDA5B:  lda     #$00
        sta     VARAPL+15
        jmp     LCCA1

; ----------------------------------------------------------------------------
LDA62:  ldy     #$00
LDA64:  jsr     CharGet
        cmp     #$22
        beq     LDA84
        iny
        jsr     LCEDF
        pha
        lda     VARAPL+15
        beq     LDA77
        jmp     OutOfRangeValErr1

; ----------------------------------------------------------------------------
LDA77:  pla
        beq     LDAA0
LDA7A:  cmp     #$27
        beq     LDAA0
        cmp     #$2C
        beq     LDA64
        bne     LDA54
LDA84:  dey
        sty     VARAPL
        ldy     #$00
LDA89:  iny
        inc     VARAPL
        lda     (TXTPTR),y
        beq     LDA95
        cmp     #$22
        bne     LDA89
        iny
LDA95:  jsr     IncTXTPTR
        ldy     VARAPL
        jsr     CharGot
        tax
        bne     LDA7A
LDAA0:  sty     VARAPL+14
        beq     LDA5B
LDAA4:  ldy     #$00
LDAA6:  jsr     CharGet
        cmp     #$22
        beq     LDAC3
        iny
        jsr     LCEDF
        pha
        lda     VARAPL+14
        jsr     LCCDB
        jsr     LCCD2
        pla
        beq     LDAA0
LDABD:  cmp     #$27
        bne     LDAA6
        beq     LDAA0
LDAC3:  dey
        sty     VARAPL
        ldy     #$00
LDAC8:  iny
        inc     VARAPL
        lda     (TXTPTR),y
        beq     LDADD
        cmp     #$22
        beq     LDADC
        jsr     LCCDB
        jsr     LCCD2
        jmp     LDAC8

; ----------------------------------------------------------------------------
LDADC:  iny
LDADD:  jsr     IncTXTPTR
        ldy     VARAPL
        jsr     CharGot
        tax
        bne     LDABD
        beq     LDAA0
LDAEA:  jsr     CharGet
        jsr     LCEDF
        jsr     LD827
        jmp     LCCA1

; ----------------------------------------------------------------------------
LDAF6:  lda     Proc1+1
        ldy     Proc1+2
        jsr     DispWord
        jsr     LDAEA
        ldy     #$08
        .byte   $2C
LDB05:  ldy     #$0C
        jsr     DispYSpace
        rts

; ----------------------------------------------------------------------------
LDB0B:  lda     Proc1+1
        ldy     Proc1+2
        jsr     DispWord
        jsr     DispSpace
        ldy     #$FF
LDB19:  iny
        lda     HRS3+1,y
        jsr     DispByte
        jsr     LCC53
        dec     INDIC0+1
        bpl     LDB19
        jsr     DispSpace
LDB2A:  cpy     #$02
        beq     LDB37
        jsr     DispSpace
        jsr     DispSpace
        iny
        bne     LDB2A
LDB37:  rts

; ----------------------------------------------------------------------------
LDB38:  pha
        tya
        pha
        lda     Proc1+1
        ldy     Proc1+2
        jsr     DispWord
        jsr     DispSpace
        pla
        tay
        pla
        jsr     DispWord
        jsr     LCC53
        jsr     LCC53
        ldy     #$03
LDB55:  bit     VARAPL+7
        bmi     LDB6E
        jsr     DispYSpace
        sec
        ror     VARAPL+7
        lda     VARAPL+10
        sta     VARAPL+12
        lda     VARAPL+11
        sta     VARAPL+13
        lda     VARAPL+16
        ldy     VARAPL+17
        jsr     LCAF8
LDB6E:  jsr     LD2B0
        bcs     LDB74
        rts

; ----------------------------------------------------------------------------
LDB74:  jmp     LCFCB

; ----------------------------------------------------------------------------
LDB77:  pha
        lda     Proc1+1
        ldy     Proc1+2
        jsr     DispWord
        jsr     DispSpace
        pla
        jsr     DispByte
        jsr     LCC53
        ldy     #$05
        bne     LDB55
LDB8F:  lda     #$00
        sta     VARAPL+7
LDB93:  jsr     CharGet
        jsr     LCEDF
        pha
        ldy     VARAPL+14
        lda     VARAPL+15
        jsr     LDB38
        pla
        beq     LDBA8
        cmp     #$27
        bne     LDB93
LDBA8:  rts

; ----------------------------------------------------------------------------
LDBA9:  lda     #$00
        sta     VARAPL+7
        ldy     #$FF
LDBAF:  iny
        jsr     CharGet
        jsr     LCEDF
        pha
        lda     VARAPL+14
        ldy     VARAPL+15
        jsr     LDB38
        pla
        beq     LDBC5
        cmp     #$27
        bne     LDBAF
LDBC5:  rts

; ----------------------------------------------------------------------------
LDBC6:  lda     #$00
        sta     VARAPL+7
LDBCA:  jsr     CharGet
        cmp     #$22
        beq     LDBE2
        jsr     LCEDF
        pha
        lda     VARAPL+14
        jsr     LDB77
        pla
LDBDB:  beq     LDBE1
        cmp     #$27
        bne     LDBCA
LDBE1:  rts

; ----------------------------------------------------------------------------
LDBE2:  ldy     #$00
LDBE4:  iny
        lda     (TXTPTR),y
        beq     LDBF7
        cmp     #$22
        beq     LDBF6
        sty     VARAPL+6
        jsr     LDB77
        ldy     VARAPL+6
        bne     LDBE4
LDBF6:  iny
LDBF7:  jsr     IncTXTPTR
        jsr     CharGot
        tax
        bne     LDBDB
        rts

; ----------------------------------------------------------------------------
LDC01:  jmp     IllegalValErr2

; ----------------------------------------------------------------------------
LDC04:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
ASSEM:  ldx     #$00
        .byte   $2C
LASSEM: ldx     #$80
        stx     XLPRBI
        ldx     #$00
        stx     Flags
        stx     $04F3
        stx     Ptr1
        stx     Ptr1+1
        stx     HRSX40
        stx     HRSY
        stx     HRSX6
        ldx     DEFBNK
        stx     $04E1
        pha
        txa
        jsr     DispBank
        pla
        beq     LDC64
        cmp     #$2C
        beq     LDC46
        jsr     LD26A
        beq     LDC01
        sta     Flags
        sty     $04F3
        txa
        jmp     LDC46

; ----------------------------------------------------------------------------
LDC43:  jsr     CharGet
LDC46:  tax
        beq     LDC64
        jsr     LD1AC
        cmp     #$4C
        bne     LDC54
        ror     HRSX40
        bmi     LDC43
LDC54:  cmp     #$47
        bne     LDC5C
        ror     HRSY
        bmi     LDC43
LDC5C:  cmp     #$53
        bne     LDC04
        ror     HRSX6
        bmi     LDC43
LDC64:  bit     HRSY
        bmi     LDC70
        lda     VARAPL2+9
        sta     VARAPL2+11
        lda     VARAPL2+10
        sta     VARAPL2+12
LDC70:  jsr     LCF40
        lda     VARAPL2+15
        sta     VARAPL2+17
        lda     VARAPL2+16
        sta     VARAPL2+18
        sta     VARAPL2+8
LDC7D:  jsr     LD7EE
        beq     LDC97
        jsr     LD7FA
        bmi     LDC8E
        cmp     #$27
        beq     LDC7D
        jsr     LD860
LDC8E:  cmp     #$BC
        bne     LDC7D
        jsr     LD80E
        beq     LDC7D
LDC97:  lda     Ptr1+1
        bne     LDCA4
        ldx     #$14
        jsr     DispErrorX
        jmp     LCFCB

; ----------------------------------------------------------------------------
LDCA4:  lda     $04F3
        bne     LDCB5
        lda     Ptr1
        sta     Flags
        lda     Ptr1+1
        sta     $04F3
LDCB5:  jsr     LCF40
        jsr     LCC38
LDCBB:  jsr     LD7EE
        bne     LDCC3
        jmp     LDD44

; ----------------------------------------------------------------------------
LDCC3:  jsr     LD7FA
        bmi     LDCD6
        cmp     #$27
        beq     LDCBB
        jsr     SymLookup
        jsr     LD8D4
        beq     LDCBB
        ldy     #$00
LDCD6:  lda     (TXTPTR),y
        sta     INDIC2
        cmp     #$80
        beq     LDD30
        cmp     #$99
        bcs     LDCEA
        jsr     CharGet
        jsr     LD827
        beq     LDD3E
LDCEA:  cmp     #$A1
        bcs     LDCF9
        lda     #$00
        sta     VARAPL+14
        sta     VARAPL+15
        jsr     LD9A5
        beq     LDD3B
LDCF9:  cmp     #$B9
        bne     LDD00
LDCFD:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
LDD00:  cmp     #$BC
        beq     LDCBB
        cmp     #$B8
        bne     LDD0E
        jsr     LDA62
        jmp     LDCBB

; ----------------------------------------------------------------------------
LDD0E:  cmp     #$BA
        bne     LDD18
        jsr     LDA40
        jmp     LDCBB

; ----------------------------------------------------------------------------
LDD18:  cmp     #$BD
        bne     LDD22
        jsr     LDA40
        jmp     LDCBB

; ----------------------------------------------------------------------------
LDD22:  cmp     #$BB
        bne     LDD2C
        jsr     LDAEA
        jmp     LDCBB

; ----------------------------------------------------------------------------
LDD2C:  cmp     #$B8
        bcs     LDCFD
LDD30:  jsr     LD912
        beq     LDD3E
        dex
        beq     LDD3B
        jsr     LCC53
LDD3B:  jsr     LCC53
LDD3E:  jsr     LCC53
        jmp     LDCBB

; ----------------------------------------------------------------------------
LDD44:  BRK_TELEMON XCRLF
        lda     #<Source_str
        ldy     #>Source_str
        BRK_TELEMON XWSTR0
        lda     SCEDEB
        ldy     SCEDEB+1
        jsr     DispWord
        jsr     DispSpace
        lda     VARAPL2+17
        ldy     VARAPL2+18
        jsr     DispWord
        BRK_TELEMON XCRLF
        lda     #<Objet_str
        ldy     #>Objet_str
        BRK_TELEMON XWSTR0
        lda     Flags
        ldy     $04F3
        jsr     DispWord
        jsr     DispSpace
        sec
        lda     Proc1+1
        sbc     Ptr1
        sta     VARAPL+1
        lda     Proc1+2
        sbc     Ptr1+1
        sta     VARAPL+2
        clc
        lda     Flags
        adc     VARAPL+1
        pha
        lda     $04F3
        adc     VARAPL+2
        tay
        pla
        jsr     DispWord
        jsr     DispSpace
        BRK_TELEMON XCRLF
        jsr     LE013
        lda     #<Assemblage_str+1
        ldy     #>Assemblage_str+1
        BRK_TELEMON XWSTR0
        lda     #<O_N_str
        ldy     #>O_N_str
        BRK_TELEMON XWSTR0
LDDA7:  jsr     LC8D1
        jsr     LC9BF
        cmp     #$4F
        beq     LDDBA
        cmp     #$4E
        bne     LDDA7
        BRK_TELEMON XWR0
        jmp     LCFC8

; ----------------------------------------------------------------------------
LDDBA:  BRK_TELEMON XWR0
        BRK_TELEMON XCRLF
        jsr     LCF40
        jsr     LCC38
        jsr     LCCC5
LDDC7:  jsr     LD7EE
        beq     LDE4A
        jsr     LD7FA
        bmi     LDDD8
        cmp     #$27
        beq     LDDC7
        jsr     LD832
LDDD8:  sta     INDIC2
        cmp     #$80
        beq     LDE26
        cmp     #$B9
        beq     LDDC7
        cmp     #$BC
        beq     LDDC7
        cmp     #$99
        bcs     LDDF2
        lda     #$00
        tax
        jsr     LCA79
        bcs     LDE29
LDDF2:  cmp     #$A1
        bcs     LDDFB
        jsr     LD9C0
        bne     LDE29
LDDFB:  cmp     #$B8
        bne     LDE05
        jsr     LDAA4
        jmp     LDDC7

; ----------------------------------------------------------------------------
LDE05:  cmp     #$BA
        bne     LDE0F
        jsr     LD9FA
        jmp     LDDC7

; ----------------------------------------------------------------------------
LDE0F:  cmp     #$BD
        bne     LDE19
        jsr     LDA1D
        jmp     LDDC7

; ----------------------------------------------------------------------------
LDE19:  cmp     #$BB
        bne     LDE26
        jsr     LDAEA
        jsr     LCCB3
        jmp     LDDC7

; ----------------------------------------------------------------------------
LDE26:  jsr     LD912
LDE29:  sta     HRS3+1
        stx     INDIC0+1
        lda     VARAPL+14
        sta     HRS4
        lda     VARAPL+15
        sta     HRS4+1
        ldy     #$FF
LDE37:  iny
        lda     HRS3+1,y
        jsr     LCCDB
        jsr     LCCD2
        jsr     LCC53
        dex
        bpl     LDE37
        jmp     LDDC7

; ----------------------------------------------------------------------------
LDE4A:  bit     XLPRBI
        bpl     LDE51
        jsr     LCF8D
LDE51:  bit     HRSX40
        bmi     LDE58
        jmp     LDEF4

; ----------------------------------------------------------------------------
LDE58:  jsr     LCB5A
        jsr     LCF40
        jsr     LCC38
LDE61:  jsr     LD7EE
        bne     LDE69
        jmp     LDEF4

; ----------------------------------------------------------------------------
LDE69:  lda     TXTPTR
        sta     VARAPL+10
        lda     TXTPTR+1
        sta     VARAPL+11
        jsr     LD7FA
        bmi     LDE83
        cmp     #$27
        bne     LDE80
LDE7A:  jsr     LDB05
        jmp     LDEDD

; ----------------------------------------------------------------------------
LDE80:  jsr     LD832
LDE83:  sta     INDIC2
        cmp     #$80
        beq     LDECB
        cmp     #$B9
        beq     LDE7A
        cmp     #$BC
        beq     LDE7A
        cmp     #$99
        bcs     LDE9D
        lda     #$00
        tax
        jsr     LCA79
        bcs     LDECE
LDE9D:  cmp     #$A1
        bcs     LDEA6
        jsr     LD9C0
        bne     LDECE
LDEA6:  cmp     #$B8
        bne     LDEAF
        jsr     LDBC6
        beq     LDE61
LDEAF:  cmp     #$BA
        bne     LDEB8
        jsr     LDBA9
        beq     LDE61
LDEB8:  cmp     #$BD
        bne     LDEC1
        jsr     LDB8F
        beq     LDE61
LDEC1:  cmp     #$BB
        bne     LDECB
        jsr     LDAF6
        jmp     LDEDD

; ----------------------------------------------------------------------------
LDECB:  jsr     LD912
LDECE:  sta     HRS3+1
        stx     INDIC0+1
        lda     VARAPL+14
        sta     HRS4
        lda     VARAPL+15
        sta     HRS4+1
        jsr     LDB0B
LDEDD:  lda     VARAPL+10
        sta     VARAPL+12
        lda     VARAPL+11
        sta     VARAPL+13
        lda     VARAPL+16
        ldy     VARAPL+17
        jsr     LCAF8
        jsr     LD2B0
        bcs     LDF04
        jmp     LDE61

; ----------------------------------------------------------------------------
LDEF4:  bit     HRSX6
        bpl     LDF04
        jsr     LCB5A
        jsr     DispLocSym
        jsr     LCB5A
        jsr     DispGlobSym
LDF04:  jsr     LCB6F
        jmp     LCFCB

; ----------------------------------------------------------------------------
; C65D 'Symboles :'/ C66B 'locaux'
DispLocSym:
        lda     #<Symboles_str
        ldy     #>Symboles_str
        BRK_TELEMON XWSTR0
        lda     #<Locaux_str
        ldy     #>Locaux_str
        BRK_TELEMON XWSTR0
        lda     VARAPL2+15
        sta     Ptr1
        sta     VARAPL+12
        lda     VARAPL2+16
        sta     Ptr1+1
        sta     VARAPL+13
        lda     VARAPL2+17
        sta     Ptr2
        lda     VARAPL2+18
        sta     Ptr2+1
        jmp     DispSymTbl

; ----------------------------------------------------------------------------
; C65D 'Symboles :'/ C672 'globaux'
DispGlobSym:
        lda     #<Symboles_str
        ldy     #>Symboles_str
        BRK_TELEMON XWSTR0
        lda     #<Globaux_str
        ldy     #>Globaux_str
        BRK_TELEMON XWSTR0
        lda     VARAPL2+9
        sta     Ptr1
        sta     VARAPL+12
        lda     VARAPL2+10
        sta     Ptr1+1
        sta     VARAPL+13
        lda     VARAPL2+11
        sta     Ptr2
        lda     VARAPL2+12
        sta     Ptr2+1
        jmp     DispSymTbl

; ----------------------------------------------------------------------------
; C65D 'Symboles :'/ C67A 'moniteur'
DispMonSym:
        lda     #<Symboles_str
        ldy     #>Symboles_str
        BRK_TELEMON XWSTR0
        lda     #<Moniteur_str
        ldy     #>Moniteur_str
        BRK_TELEMON XWSTR0
        lda     #<SymbolTable
        sta     Ptr1
        sta     VARAPL+12
        lda     #>SymbolTable
        sta     Ptr1+1
        sta     VARAPL+13
        lda     #$C8
        sta     Ptr2
        lda     #$FF
        sta     Ptr2+1
; VARAPL+12: Adr debut de la table, VARAPL+1: Finde la table
DispSymTbl:
        jsr     LCB5A
        lda     #$03
        sta     VARAPL+5
        sta     VARAPL+6
        lda     #$2E
        sta     VARAPL+7
LDF89:  lda     VARAPL+13
        cmp     Ptr2+1
        bne     LDF95
        lda     VARAPL+12
        cmp     Ptr2
LDF95:  bcc     LDFC3
        bit     VARAPL+6
        bpl     LE002
        lda     VARAPL+7
        cmp     #$2E
        bne     LDFA7
        lda     #$5B
        sta     VARAPL+7
        bne     LDFB7
LDFA7:  inc     VARAPL+7
        lda     VARAPL+7
        cmp     #$5B
        beq     LE002
        cmp     #$7B
        bne     LDFB7
        lda     #$3F
        sta     VARAPL+7
LDFB7:  lda     Ptr1
        sta     VARAPL+12
        lda     Ptr1+1
        sta     VARAPL+13
        lsr     VARAPL+6
LDFC3:  ldy     #$00
        lda     (VARAPL+12),y
        cmp     VARAPL+7
        beq     LDFDD
        sec
        ror     VARAPL+6
LDFCE:  clc
        lda     VARAPL+12
        adc     #$08
        sta     VARAPL+12
        lda     VARAPL+13
        adc     #$00
        sta     VARAPL+13
        bcc     LDF89
LDFDD:  lda     (VARAPL+12),y
        BRK_TELEMON XWR0
        iny
        cpy     #$06
        bne     LDFDD
        jsr     DispSpace
        lda     (VARAPL+12),y
        pha
        iny
        lda     (VARAPL+12),y
        tay
        pla
        jsr     DispWord
        dec     VARAPL+5
        bne     LE00A
        ldx     #$03
        stx     VARAPL+5
        jsr     LD2B0
        bcc     LDFCE
        rts

; ----------------------------------------------------------------------------
LE002:  php
        jsr     LCB5A
        plp
        bcc     LDFCE
        rts

; ----------------------------------------------------------------------------
LE00A:  jsr     DispSpace
        jsr     DispSpace
        jmp     LDFCE

; ----------------------------------------------------------------------------
LE013:  lda     #<Symboles_str
        ldy     #>Symboles_str
        BRK_TELEMON XWSTR0
        lda     VARAPL2+9
        ldy     VARAPL2+10
        jsr     DispWord
        jsr     DispSpace
        lda     VARAPL2+11
        ldy     VARAPL2+12
        jsr     DispWord
        jsr     DispSpace
        lda     VARAPL2+13
        ldy     VARAPL2+14
        jsr     DispWord
        BRK_TELEMON XCRLF
        rts

; ----------------------------------------------------------------------------
SYOLD:  ldx     VARAPL2+9
        ldy     VARAPL2+10
        stx     Ptr1
        sty     Ptr1+1
        ldx     VARAPL2+13
        ldy     VARAPL2+14
        stx     Ptr2
        sty     Ptr2+1
        tax
        beq     LE053
        jsr     LE090
        bne     LE08A
LE053:  jsr     LE0AB
        jmp     LE07D

; ----------------------------------------------------------------------------
SYDEF:  ldx     #$00
        stx     VARAPL+7
        tax
        beq     LE080
        jsr     LE090
        beq     LE074
        jsr     LD1AC
        cmp     #$43
        bne     LE08A
        ror     VARAPL+7
        jsr     CharGet
        tax
        bne     LE08A
LE074:  jsr     LE0AB
        BRK_TELEMON XDECAL
        bit     VARAPL+7
        bpl     LE080
LE07D:  jsr     LE107
LE080:  lda     #$7F
        BRK_TELEMON XWR0
        jsr     LE013
        jmp     LCFC8

; ----------------------------------------------------------------------------
LE08A:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
LE08D:  jmp     OutOfRangeValErr1

; ----------------------------------------------------------------------------
LE090:  tax
        beq     LE08A
        jsr     LD26A
        sta     Ptr1
        sty     Ptr1+1
        cpx     #$2C
        bne     LE08A
        jsr     LD267
        sta     Ptr2
        sty     Ptr2+1
        txa
        rts

; ----------------------------------------------------------------------------
LE0AB:  sec
        lda     Ptr2
        sbc     Ptr1
        sta     DECTRV
        lda     Ptr2+1
        tay
        sbc     Ptr1+1
        sta     DECTRV+1
        bcc     LE08A
        ora     DECTRV
        beq     LE08A
        sec
        lda     VARAPL2+9
        sta     DECDEB
        adc     DECTRV
        sta     DECFIN
        lda     VARAPL2+10
        sta     DECDEB+1
        adc     DECTRV+1
        sta     DECFIN+1
        ldx     Ptr1
        lda     Ptr1+1
        stx     DECCIB
        sta     DECCIB+1
        cmp     SCEFIN+1
        bcc     LE08D
        cpy     #$B4
        bcc     LE0ED
        bne     LE08D
        ldy     Ptr2
        bne     LE08D
LE0ED:  jsr     LocTblInit
        lda     Ptr2
        ldy     Ptr2+1
        sta     VARAPL2+13
        sty     VARAPL2+14
        lda     DECCIB
        ldy     DECCIB+1
        sta     VARAPL2+9
        sta     VARAPL2+11
        sty     VARAPL2+10
        sty     VARAPL2+12
        rts

; ----------------------------------------------------------------------------
LE107:  ldy     VARAPL2+13
        ldx     VARAPL2+14
        sty     DECFIN
        stx     DECFIN+1
        ldy     VARAPL2+9
        ldx     VARAPL2+10
LE113:  sty     DECDEB
        stx     DECDEB+1
        cpx     DECFIN+1
        bne     LE11D
        cpy     DECFIN
LE11D:  bcs     LE14E
        ldy     #$00
        lda     (DECDEB),y
        beq     LE14E
        jsr     LC926
        bcc     LE14E
LE12A:  iny
        cpy     #$06
        beq     LE141
        lda     (DECDEB),y
        jsr     LC91A
        bcs     LE12A
LE136:  lda     (DECDEB),y
        cmp     #$20
        bne     LE14E
        iny
        cpy     #$06
        bne     LE136
LE141:  clc
        lda     DECDEB
        adc     #$08
        tay
        lda     DECDEB+1
        adc     #$00
        tax
        bcc     LE113
LE14E:  ldy     #$00
        tya
        sta     (DECDEB),y
        lda     DECDEB
        sta     VARAPL2+11
        lda     DECDEB+1
        sta     VARAPL2+12
        rts

; ----------------------------------------------------------------------------
LE15C:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
SYTAB:  ldy     #$00
        .byte   $2C
LSYTAB: ldy     #$80
        sty     XLPRBI
        ldy     #$40
        sty     VARAPL+11
        tax
        beq     LE1A6
        ldy     #$00
        sty     VARAPL+11
        lda     TXTPTR
        bne     LE177
        dec     TXTPTR+1
LE177:  dec     TXTPTR
LE179:  jsr     CharGet
        tax
        beq     LE1A6
        jsr     LD1AC
        cmp     #$4C
        bne     LE18E
        lda     VARAPL+11
        ora     #$80
        sta     VARAPL+11
        bne     LE179
LE18E:  cmp     #$47
        bne     LE19A
        lda     VARAPL+11
        ora     #$40
        sta     VARAPL+11
        bne     LE179
LE19A:  cmp     #$4D
        bne     LE15C
        lda     VARAPL+11
        ora     #$01
        sta     VARAPL+11
        bne     LE179
LE1A6:  bit     XLPRBI
        bpl     LE1AD
        jsr     LCF8D
LE1AD:  bit     VARAPL+11
        bpl     LE1B7
        jsr     LCB5A
        jsr     DispLocSym
LE1B7:  bit     VARAPL+11
        bvc     LE1C1
        jsr     LCB5A
        jsr     DispGlobSym
LE1C1:  lda     VARAPL+11
        and     #$01
        beq     LE1CD
        jsr     LCB5A
        jsr     DispMonSym
LE1CD:  jmp     LCFCB

; ----------------------------------------------------------------------------
QDEC:   jsr     LE22D
        pha
        lda     #$7F
        BRK_TELEMON XWR0
        pla
        jsr     LC779
        jmp     LE1F9

; ----------------------------------------------------------------------------
QBIN:   jsr     LE22D
        php
        pha
        lda     #$7F
        BRK_TELEMON XWR0
        lda     #$25
        BRK_TELEMON XWR0
        pla
        plp
        beq     LE1F6
        pha
        tya
        jsr     DispBitStr
        pla
LE1F6:  jsr     DispBitStr
LE1F9:  jmp     LCFC8

; ----------------------------------------------------------------------------
QHEX:   jsr     LE22D
        php
        pha
        lda     #$7F
        BRK_TELEMON XWR0
        lda     #$24
        BRK_TELEMON XWR0
        pla
        plp
        beq     LE213
        jsr     DispWord
        jmp     LE1F9

; ----------------------------------------------------------------------------
LE213:  jsr     DispByte
        jmp     LE1F9

; ----------------------------------------------------------------------------
QCAR:   jsr     LE22D
        bne     LE263
        pha
        lda     #$7F
        BRK_TELEMON XWR0
        jsr     DispSpace
        pla
        jsr     LC716
        jmp     LE1F9

; ----------------------------------------------------------------------------
LE22D:  ldx     #$00
        stx     VARAPL+7
        cmp     #$28
        bne     LE23A
        ror     VARAPL+7
        jsr     CharGet
LE23A:  jsr     LCEDF
        bit     VARAPL+7
        bpl     LE250
        cmp     #$29
        bne     LE260
        ldy     #$00
        lda     (VARAPL+14),y
        sta     VARAPL+14
        sty     VARAPL+15
        jsr     CharGet
LE250:  tax
        bne     LE260
        lda     VARAPL+14
        ldy     VARAPL+15
        rts

; ----------------------------------------------------------------------------
VREG:   tax
        beq     LE266
        jsr     LE26E
        bcs     VREG
LE260:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
LE263:  jmp     OutOfRangeValErr1

; ----------------------------------------------------------------------------
LE266:  BRK_TELEMON XCRLF
        jsr     DispRegs
        jmp     LCFC8

; ----------------------------------------------------------------------------
LE26E:  jsr     LD1AC
        cmp     #$41
        beq     LE283
        cmp     #$59
        beq     LE286
        cmp     #$58
        beq     LE289
        cmp     #$50
        beq     LE28C
        clc
        rts

; ----------------------------------------------------------------------------
LE283:  ldy     #$04
        .byte   $2C
LE286:  ldy     #$03
        .byte   $2C
LE289:  ldy     #$02
        .byte   $2C
LE28C:  ldy     #$01
        jsr     CharGet
        jsr     LCEDF
        lda     VARAPL+15
        bne     LE263
        lda     VARAPL+14
        sta     HRS1,y
        jsr     CharGot
        sec
        rts

; ----------------------------------------------------------------------------
OLD:    tax
        bne     LE260
        lda     SCEDEB
        ldy     SCEDEB+1
        sta     TXTPTR
        sty     TXTPTR+1
LE2AD:  ldy     #$03
LE2AF:  lda     (TXTPTR),y
        beq     LE2BE
        iny
        bne     LE2AF
        ldx     #$07
        jsr     DispErrorX
        jmp     LCFCB

; ----------------------------------------------------------------------------
LE2BE:  iny
        tya
        ldy     #$00
        sta     (TXTPTR),y
        tay
        jsr     IncTXTPTR
        ldy     #$00
        lda     (TXTPTR),y
        bne     LE2AD
        iny
        jsr     IncTXTPTR
        lda     TXTPTR
        sta     SCEFIN
        lda     TXTPTR+1
        sta     SCEFIN+1
        jsr     LocTblInit
        jmp     LCFCB

; ----------------------------------------------------------------------------
LE2E0:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
CALL:   tax
        beq     LE2E0
        ldx     DEFBNK
        stx     $04E1
        jsr     LD26A
        sta     VEXBNK+1
        sty     VEXBNK+2
        txa
LE2F6:  tax
        beq     LE307
        jsr     LE26E
        bcs     LE2F6
        jsr     LD342
        stx     $04E1
        jmp     LE2F6

; ----------------------------------------------------------------------------
LE307:  BRK_TELEMON XCRLF
        jsr     DispRegs
        lda     $04E1
        sta     BNKCIB
        lda     HRS1+1
        pha
        lda     HRS3
        ldy     HRS2+1
        ldx     HRS2
        plp
        jsr     EXBNK
        php
        sta     HRS3
        sty     HRS2+1
        stx     HRS2
        pla
        sta     HRS1+1
        BRK_TELEMON XCRLF
        jsr     DispRegs
        jsr     LC8DC
        jmp     LCFCB

; ----------------------------------------------------------------------------
BYTE:   ldx     DEFBNK
        stx     $04E1
        tax
        beq     LE2E0
        jsr     LD26A
        sta     Proc1+9
        sty     Proc1+10
        txa
        beq     LE2E0
LE349:  cmp     #$2C
        bne     LE37F
        jsr     LD267
        jsr     LCCDB
        jsr     LCCD2
        tya
        beq     LE35F
        jsr     LCCDB
        jsr     LCCD2
LE35F:  txa
        bne     LE349
        jmp     LCFCB

; ----------------------------------------------------------------------------
SLIGNE: tax
        bne     LE37F
        dex
        stx     XLPRBI
        jsr     LCF8D
LE36E:  jsr     LC8D1
        cmp     #$0D
        beq     LE378
        jmp     LCFCB

; ----------------------------------------------------------------------------
LE378:  jsr     LCB5A
        jmp     LE36E

; ----------------------------------------------------------------------------
DPAGE:  tax
LE37F:  bne     LE3FF
        dex
        stx     XLPRBI
        jsr     LCF8D
        jsr     LCB6F
        jmp     LCFCB

; ----------------------------------------------------------------------------
FPAGE:  ldx     LPRFY
        stx     INDIC2
        ldx     LPRSY
        stx     INDIC0+1
        tax
        bne     LE3CB
        lda     #$7F
        BRK_TELEMON XWR0
        lda     #<Fmt_str
        ldy     #>Fmt_str
        BRK_TELEMON XWSTR0
        lda     LPRFY
        jsr     LC766
        jsr     DispSpace
        lda     #<Saut_str
        ldy     #>Saut_str
        BRK_TELEMON XWSTR0
        lda     LPRSY
        jsr     LC766
        jsr     DispSpace
        lda     #<Ligne_str
        ldy     #>Ligne_str
        BRK_TELEMON XWSTR0
        lda     LPRY
        jsr     LC766
        jmp     LCFC8

; ----------------------------------------------------------------------------
LE3CB:  cmp     #$2C
        beq     LE3DD
        jsr     LD26A
        bne     LE402
        sta     INDIC2
        txa
        beq     LE3E7
        cmp     #$2C
        bne     LE3FF
LE3DD:  jsr     LD267
        bne     LE402
        sta     INDIC0+1
        txa
        bne     LE3FF
LE3E7:  lda     INDIC2
        cmp     INDIC0+1
        bcc     PrinterFormatErr
        lda     #$00
        sta     LPRY
        lda     INDIC0+1
        sta     LPRSY
        lda     INDIC2
        sta     LPRFY
        jmp     LCFCB

; ----------------------------------------------------------------------------
LE3FF:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
LE402:  jmp     OutOfRangeValErr1

; ----------------------------------------------------------------------------
; Err $1A
PrinterFormatErr:
        ldx     #$1A
        jmp     LCF98

; ----------------------------------------------------------------------------
MOVE:   ldx     DEFBNK
        stx     Proc2
        stx     Proc2+1
        jsr     LD26A
        sta     DECDEB
        sty     DECDEB+1
        cpx     #$2C
        bne     LE3FF
        jsr     LD267
        sta     DECFIN
        sty     DECFIN+1
        txa
        jsr     LD1AC
        cmp     #$42
        bne     LE43A
        jsr     LD346
        stx     Proc2
        cmp     #$2C
        bne     LE3FF
        jsr     CharGet
LE43A:  jsr     LD26A
        sta     DECCIB
        sty     DECCIB+1
        txa
        beq     LE44D
        jsr     LD33F
        stx     Proc2+1
        tax
        bne     LE3FF
LE44D:  lda     Proc2
        ldy     Proc2+1
        sta     RES
        sty     RES+1
        jsr     LE460
        jsr     LC8DC
        jmp     LCFCB

; ----------------------------------------------------------------------------
LE460:  pha
        txa
        pha
        tya
        pha
        ldy     #$1B
LE467:  lda     LE4EE,y
        sta     BUFTRV,y
        dey
        bpl     LE467
        lda     V2DRA
        and     #$F8
        pha
        ora     RES
        sta     RES
        pla
        ora     RES+1
        sta     RES+1
        sec
        lda     DECFIN
        sbc     DECDEB
        tay
        lda     DECFIN+1
        sbc     DECDEB+1
        tax
        bcc     LE4C6
        stx     DECTRV+1
        lda     DECCIB
        cmp     DECDEB
        lda     DECCIB+1
        sbc     DECDEB+1
        bcs     LE4CC
        tya
        eor     #$FF
        adc     #$01
        tay
        sta     DECTRV
        bcc     LE4A5
        dex
        inc     DECFIN+1
LE4A5:  sec
        lda     DECCIB
        sbc     DECTRV
        sta     DECCIB
        bcs     LE4B0
        dec     DECCIB+1
LE4B0:  clc
        lda     DECFIN+1
        sbc     DECTRV+1
        sta     DECFIN+1
        inx
LE4B8:  jsr     BUFTRV
        iny
        bne     LE4B8
        inc     DECFIN+1
        inc     DECCIB+1
        dex
        bne     LE4B8
LE4C5:  sec
LE4C6:  pla
        tay
        pla
        tax
        pla
        rts

; ----------------------------------------------------------------------------
LE4CC:  txa
        clc
        adc     DECDEB+1
        sta     DECDEB+1
        txa
        clc
        adc     DECCIB+1
        sta     DECCIB+1
        lda     #$04
        sta     BUFTRV+12
        inx
LE4DE:  dey
        jsr     BUFTRV
        tya
        bne     LE4DE
        dec     DECDEB+1
        dec     DECCIB+1
        dex
        bne     LE4DE
        beq     LE4C5
LE4EE:  php
        sei
        lda     V2DRA
        pha
        lda     RES
        sta     V2DRA
        lda     (DECFIN),y
        pha
        lda     RES+1
        sta     V2DRA
        pla
        sta     (DECCIB),y
        pla
        sta     V2DRA
        plp
        rts

; ----------------------------------------------------------------------------
MERGE:  jsr     LD182
        bne     FileNameErr2
        jsr     CharGot
        tax
        bne     SyntaxErr6
        lda     SCEDEB
        pha
        sta     VARAPL+12
        lda     SCEDEB+1
        pha
        sta     VARAPL+13
        lda     (VARAPL+12),y
        beq     LE528
LE523:  jsr     LCB89
        bcc     LE523
LE528:  lda     VARAPL+12
        sta     INPIS
        lda     VARAPL+13
        sta     INSEC
        lda     #$80
        sta     VSALO1
        lda     #<XLOAD
        ldy     #>XLOAD
        jsr     EXBNK0ERR
        pla
        sta     SCEDEB+1
        pla
        sta     SCEDEB
        jsr     LD229
        lda     #$00
        jmp     RENUM

; ----------------------------------------------------------------------------
; Err $09
FileNameErr2:
        ldx     #$09
        .byte   $2C
; Err $00
SyntaxErr6:
        ldx     #$00
        jmp     LCF98

; ----------------------------------------------------------------------------
QWERTY: lda     #$00
        .byte   $2C
AZERTY: lda     #$01
        .byte   $2C
FRENCH: lda     #$02
        .byte   $2C
ACCSET: lda     #$04
        .byte   $2C
ACCOFF: lda     #$05
        pha
        jsr     CharGot
        tax
        bne     SyntaxErr6
        pla
        BRK_TELEMON XGOKBD
        jmp     LCFCB

; ----------------------------------------------------------------------------
LE56F:  lda     Proc1+1
        ldy     Proc1+2
        jsr     PutYAHexa
        lda     #$00
        sta     BUFTRV+5
        ldx     #$03
LE57F:  lda     BUFTRV,x
        ora     #$80
        sta     BUFTRV+1,x
        dex
        bpl     LE57F
        lda     #$83
        sta     BUFTRV
        ldx     #$02
        jmp     LC853

; ----------------------------------------------------------------------------
LE594:  BRK_TELEMON XWR0
LE596:  lda     #$00
        sta     BUFTRV+8
        ldx     #$06
LE59D:  lda     #$00
        cpx     #$03
        beq     LE5AD
        ror
        sta     VARAPL
        lda     FLGKBD
        and     #$80
        eor     VARAPL
LE5AD:  ora     MAJ_min_str,x
        sta     BUFTRV+1,x
        dex
        bpl     LE59D
        lda     #$86
        sta     BUFTRV
        ldx     #$20
        jmp     LC853

; ----------------------------------------------------------------------------
LE5C0:  stx     Flags
        sta     $04F3
        stx     Proc1+1
        sta     Proc1+2
        lda     #$01
        ldy     #$00
        jsr     LC879
LE5D3:  jsr     LD2E8
        lda     SCRY
        cmp     SCRFY
        beq     LE5E3
        BRK_TELEMON XCRLF
        jmp     LE5D3

; ----------------------------------------------------------------------------
LE5E3:  lda     Flags
        sta     Ptr1
        sta     Proc1+1
        lda     $04F3
        sta     Ptr1+1
        sta     Proc1+2
        lda     VARAPL+8
        sta     Ptr2
        lda     VARAPL+9
        sta     Ptr2+1
        ldy     #$1F
        bit     HRSX6
        bmi     LE60B
        lda     #$00
        sta     HRSX6
        ldy     #$06
LE60B:  lda     #$01
        jsr     LC879
LE610:  lda     #$02
        .byte   $2C
LE613:  lda     #$20
        ldy     #$05
        sta     (ADSCR),y
        rts

; ----------------------------------------------------------------------------
LE61A:  lda     HRSX6
        eor     #$80
        and     #$80
        sta     HRSX6
        bmi     LE634
        lda     FLGKBD
        ora     #$80
        sta     FLGKBD
        lda     FLGSCR
        and     #$DF
        sta     FLGSCR
LE634:  jsr     LE596
LE637:  pha
        lda     SCRX
        cmp     #$1E
        bcs     LE65D
        sec
        sbc     #$06
        sta     VARAPL
        ldx     #$08
        lda     #$00
LE648:  asl     VARAPL
        rol
        cmp     #$03
        bcc     LE653
        sbc     #$03
        inc     VARAPL
LE653:  dex
        bne     LE648
        clc
        lda     VARAPL
        adc     #$1F
        bcc     LE666
LE65D:  sbc     #$1F
        sta     VARAPL
        asl
        adc     VARAPL
        adc     #$06
LE666:  tay
        lda     SCRY
        jsr     LC879
        pla
        rts

; ----------------------------------------------------------------------------
LE66F:  lda     #$09
LE671:  BRK_TELEMON XWR0
        bit     HRSX6
        bpl     LE683
        jsr     LCC53
        lda     SCRX
        cmp     SCRFX
        beq     LE69A
LE682:  rts

; ----------------------------------------------------------------------------
LE683:  bvc     LE68F
        jsr     LCC53
        lda     #$09
        BRK_TELEMON XWR0
        lda     #$00
        .byte   $2C
LE68F:  lda     #$40
        sta     HRSX6
        lda     SCRX
        cmp     #$1D
        bcc     LE682
LE69A:  jsr     LE6A0
        jmp     LE6BE

; ----------------------------------------------------------------------------
LE6A0:  lda     Flags
        sta     Proc1+1
        lda     $04F3
        sta     Proc1+2
        ldy     #$1F
        bit     HRSX6
        bmi     LE6B8
        lda     #$00
        sta     HRSX6
        ldy     #$06
LE6B8:  lda     SCRY
        jmp     LC879

; ----------------------------------------------------------------------------
LE6BE:  lda     SCRX
        pha
        lda     SCRY
        cmp     SCRFY
        php
        clc
        lda     Flags
        adc     #$08
        sta     Flags
        bcc     LE6D7
        inc     $04F3
LE6D7:  clc
        lda     Proc1+1
        adc     #$08
        sta     Proc1+1
        bcc     LE6E5
        inc     Proc1+2
LE6E5:  jsr     LE613
        lda     #$0A
        BRK_TELEMON XWR0
        jsr     LE610
        plp
        beq     LE6F4
        pla
        rts

; ----------------------------------------------------------------------------
LE6F4:  jsr     LE7C2
        lda     Flags
        sta     Ptr2
        lda     $04F3
        sta     Ptr2+1
        clc
        lda     Ptr1
        adc     #$08
        sta     Ptr1
        bcc     LE711
        inc     Ptr1+1
LE711:  pla
        tay
        lda     SCRY
        jmp     LC879

; ----------------------------------------------------------------------------
LE719:  lda     #$08
        BRK_TELEMON XWR0
        bit     HRSX6
        bpl     LE72C
        jsr     LCC45
        lda     SCRX
        cmp     #$1E
        beq     LE743
LE72B:  rts

; ----------------------------------------------------------------------------
LE72C:  bvs     LE738
        jsr     LCC45
        lda     #$08
        BRK_TELEMON XWR0
        lda     #$40
        .byte   $2C
LE738:  lda     #$00
        sta     HRSX6
        lda     SCRX
        cmp     #$06
        bcs     LE72B
LE743:  jsr     LE749
        jmp     LE769

; ----------------------------------------------------------------------------
LE749:  clc
        lda     Flags
        adc     #$07
        sta     Proc1+1
        bcc     LE757
        inc     Proc1+2
LE757:  ldy     #$26
        bit     HRSX6
        bmi     LE763
        lda     #$40
        sta     HRSX6
        ldy     #$1C
LE763:  lda     SCRY
        jmp     LC879

; ----------------------------------------------------------------------------
LE769:  lda     SCRX
        pha
        lda     SCRY
        cmp     SCRDY
        php
        sec
        lda     Flags
        sbc     #$08
        sta     Flags
        bcs     LE782
        dec     $04F3
LE782:  sec
        lda     Proc1+1
        sbc     #$08
        sta     Proc1+1
        bcs     LE790
        dec     Proc1+2
LE790:  jsr     LE613
        lda     #$0B
        BRK_TELEMON XWR0
        jsr     LE610
        plp
        beq     LE7A2
        pla
        jsr     LE610
        rts

; ----------------------------------------------------------------------------
LE7A2:  jsr     LE7C2
        lda     Flags
        ldy     $04F3
        sta     Ptr1
        sty     Ptr1+1
        sec
        lda     Ptr2
        sbc     #$08
        sta     Ptr2
        bcs     LE7BF
        dec     Ptr2+1
LE7BF:  jmp     LE711

; ----------------------------------------------------------------------------
LE7C2:  lda     Proc1+1
        pha
        lda     Proc1+2
        pha
        lda     Flags
        ldy     $04F3
        sta     Proc1+1
        sty     Proc1+2
        jsr     LD2E8
        pla
        sta     Proc1+2
        pla
        sta     Proc1+1
        jsr     LE610
        rts

; ----------------------------------------------------------------------------
LE7E5:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
MODIF:  ldx     DEFBNK
        stx     $04E1
        jsr     LD26A
        sta     Flags
        sty     $04F3
        txa
        beq     LE803
        jsr     LD33F
        stx     $04E1
        tax
        bne     LE7E5
LE803:  lda     #$0C
        BRK_TELEMON XWR0
LE807:  lda     #$00
        sta     HRSX6
        lda     FLGKBD
        ora     #$80
        sta     FLGKBD
        jsr     LE596
        ldx     Flags
        lda     $04F3
LE81C:  jsr     LE5C0
LE81F:  jsr     LE56F
LE822:  jsr     LC8D1
        cmp     #$20
        bcs     LE82C
        jmp     LE8B0

; ----------------------------------------------------------------------------
LE82C:  bit     HRSX6
        bpl     LE862
        jsr     LCC71
        jsr     LCC5B
        jsr     LE637
        pha
        lda     FLGSCR
        tax
        and     #$DF
        sta     FLGSCR
        txa
        asl
        asl
        and     #$80
        sta     VARAPL+1
        pla
        pha
        ora     VARAPL+1
        jsr     DispByte
        stx     FLGSCR
        lda     #$08
        BRK_TELEMON XWR0
        pla
        jsr     LE637
        jsr     LE671
        jmp     LE81F

; ----------------------------------------------------------------------------
LE862:  jsr     LCD6E
        bcs     LE8AB
        and     #$0F
        bit     HRSX6
        bvs     LE871
        asl
        asl
        asl
        asl
LE871:  sta     VARAPL
        jsr     LCC5B
        bit     HRSX6
        bvc     LE87D
        and     #$F0
        .byte   $2C
LE87D:  and     #$0F
        ora     VARAPL
        jsr     LCC71
        jsr     LCC5B
        jsr     LE637
        jsr     LC716
        pha
        lda     #$08
        BRK_TELEMON XWR0
        pla
        jsr     LE637
        jsr     DispByte
        lda     #$08
        BRK_TELEMON XWR0
        bit     HRSX6
        bvs     LE8A5
        lda     #$08
        BRK_TELEMON XWR0
LE8A5:  jsr     LE66F
        jmp     LE81F

; ----------------------------------------------------------------------------
LE8AB:  BRK_TELEMON XOUPS
        jmp     LE822

; ----------------------------------------------------------------------------
LE8B0:  lsr     KBDSHT
        bcc     LE8FB
        cmp     #$0A
        bne     LE8C8
        clc
        lda     Ptr2
        adc     #$08
        tax
        lda     Ptr2+1
        adc     #$00
        jmp     LE81C

; ----------------------------------------------------------------------------
LE8C8:  cmp     #$0B
        bne     LE8DA
        lda     Ptr1
        sbc     #$D8
        tax
        lda     Ptr1+1
        sbc     #$00
        jmp     LE81C

; ----------------------------------------------------------------------------
LE8DA:  cmp     #$08
        bne     LE8E4
        jsr     LE6A0
        jmp     LE81F

; ----------------------------------------------------------------------------
LE8E4:  cmp     #$09
        bne     LE8EE
        jsr     LE749
        jmp     LE81F

; ----------------------------------------------------------------------------
LE8EE:  cmp     #$0D
        bne     LE8AB
        jsr     LE6A0
        jsr     LE769
        jmp     LE81F

; ----------------------------------------------------------------------------
LE8FB:  cmp     #$09
        bne     LE905
        jsr     LE66F
        jmp     LE81F

; ----------------------------------------------------------------------------
LE905:  cmp     #$08
        bne     LE90F
        jsr     LE719
        jmp     LE81F

; ----------------------------------------------------------------------------
LE90F:  cmp     #$0B
        bne     LE919
        jsr     LE769
        jmp     LE81F

; ----------------------------------------------------------------------------
LE919:  cmp     #$0A
        bne     LE923
        jsr     LE6BE
        jmp     LE81F

; ----------------------------------------------------------------------------
LE923:  cmp     #$0D
        bne     LE930
        jsr     LE6A0
        jsr     LE6BE
        jmp     LE81F

; ----------------------------------------------------------------------------
LE930:  cmp     #$01
        bne     LE93A
        jsr     LE61A
        jmp     LE822

; ----------------------------------------------------------------------------
LE93A:  cmp     #$16
        bne     LE943
        BRK_TELEMON XWR0
        jmp     LE822

; ----------------------------------------------------------------------------
LE943:  cmp     #$14
        bne     LE94D
        jsr     LE594
        jmp     LE822

; ----------------------------------------------------------------------------
LE94D:  cmp     #$0C
        bne     LE95A
        ldx     Ptr1
        lda     Ptr1+1
        jmp     LE81C

; ----------------------------------------------------------------------------
LE95A:  cmp     #$02
        bne     LE991
        ldy     #$17
        lda     #$00
        jsr     LC879
LE965:  jsr     LC8D1
        cmp     #$1B
        beq     LE991
        cmp     #$30
        bcc     LE965
        pha
        BRK_TELEMON XWR0
        lda     #$08
        BRK_TELEMON XWR0
        pla
        sec
        sbc     #$30
        cmp     #$08
        bcs     LE965
        sta     $04E1
        lda     Ptr1
        sta     Flags
        lda     Ptr1+1
        sta     $04F3
        jmp     LE807

; ----------------------------------------------------------------------------
LE991:  cmp     #$03
        beq     LE99C
        cmp     #$1B
        beq     LE99C
        jmp     LE8AB

; ----------------------------------------------------------------------------
LE99C:  jsr     LC8DC
        lda     SCRFY
        ldy     #$00
        jsr     LC879
        jmp     LCFC8

; ----------------------------------------------------------------------------
LE9AA:  lda     #<Pile_str
        ldy     #>Pile_str
        ldx     #$21
        jsr     LC857
        lda     #$0C
        BRK_TELEMON XWR0
        lda     #<Chan0InitTbl
        ldy     #>Chan0InitTbl
        ldx     #$00
        BRK_TELEMON XSCRSE
        lda     #<Chan1InitTbl
        ldy     #>Chan1InitTbl
        ldx     #$01
        BRK_TELEMON XSCRSE
        lda     #<Chan2InitTbl
        ldy     #>Chan2InitTbl
        ldx     #$02
        BRK_TELEMON XSCRSE
        lda     #XSCR
        BRK_TELEMON XOP0
        lda     #XSC1
        BRK_TELEMON XOP1
        lda     #XSC2
        BRK_TELEMON XOP2
        ldx     #$00
        BRK_TELEMON XCOSCR
        ldx     #$01
        BRK_TELEMON XCOSCR
        ldx     #$02
        BRK_TELEMON XCOSCR
        rts

; ----------------------------------------------------------------------------
; Table d'initialisation écran 0
Chan0InitTbl:
        .byte   $00
        .byte   $1D
        .byte   $01
        .byte   $17
        .byte   $80
        .byte   $BB
; Table d'initialisation écran 1
Chan1InitTbl:
        .byte   $07
        .byte   $1D
        .byte   $19
        .byte   $1B
        .byte   $80
        .byte   $BB
; Table d'initialisation écran 2
Chan2InitTbl:
        .byte   $1F
        .byte   $27
        .byte   $01
        .byte   $1B
        .byte   $80
        .byte   $BB
; Table d'initialisation écran 0 bis
Chan0bInitTbl:
        .byte   $00
        .byte   $27
        .byte   $01
        .byte   $1B
        .byte   $80
        .byte   $BB
; Trouver un meilleur nom
Table1: .byte   $07
        .byte   $04
        .byte   $02
LEA03:  ldy     #$05
LEA05:  lda     LEA0F,y
        sta     Proc2,y
        dey
        bpl     LEA05
        rts

; ----------------------------------------------------------------------------
LEA0F:  beq     LEA13
        clc
        rts

; ----------------------------------------------------------------------------
LEA13:  sec
        rts

; ----------------------------------------------------------------------------
TRACE:  jsr     LEA03
        ldx     #$40
        stx     Flags
        stx     XLPRBI
        ldx     DEFBNK
        stx     $04E1
        ldx     #$FE
        txs
        stx     HRS1
        inx
        stx     Ptr2
        stx     Ptr2+1
        jsr     LD26A
        sta     Proc1+1
        sty     Proc1+2
LEA3A:  txa
LEA3B:  tax
        beq     LEA7C
        jsr     LE26E
        bcs     LEA3B
        cmp     #$53
        bne     LEA53
        jsr     LD267
        sta     Ptr2
        sty     Ptr2+1
        jmp     LEA3A

; ----------------------------------------------------------------------------
LEA53:  cmp     #$45
        bne     LEA60
        ror     Flags
LEA5A:  jsr     CharGet
        jmp     LEA3B

; ----------------------------------------------------------------------------
LEA60:  cmp     #$48
        bne     LEA6B
        lda     #$00
        sta     Flags
        beq     LEA5A
LEA6B:  cmp     #$4E
        bne     LEA73
        ror     XLPRBI
        bmi     LEA5A
LEA73:  jsr     LD342
        stx     $04E1
        jmp     LEA3B

; ----------------------------------------------------------------------------
LEA7C:  jsr     LECD7
        lda     Flags
        ora     XLPRBI
        bmi     LEA89
        jsr     LE9AA
LEA89:  jsr     LCC92
        bcs     LEAA0
LEA8E:  bit     Flags
        php
        lda     #$00
        sta     Flags
        plp
        bpl     LEA9D
        jsr     LE9AA
LEA9D:  jsr     LECD7
LEAA0:  jsr     LC8B4
        bcs     LEA8E
        bit     Flags
        bpl     LEABE
        jsr     LCC5B
        jsr     DecodeOpc
        ldy     #$00
LEAB2:  dex
        bmi     LEAE0
        jsr     LCC53
        sta     HRS4,y
        iny
        bne     LEAB2
LEABE:  jsr     LECF3
        lda     Flags
        bne     LEAE0
        cli
LEAC7:  jsr     LC8D1
        cmp     #$20
        beq     LEAE0
        cmp     #$1B
        beq     LEB3A
        cmp     #$03
        beq     LEB3A
        cmp     #$0D
        bne     LEAC7
        lda     HRS3+1
        cmp     #$20
        beq     LEAF6
LEAE0:  lda     HRS3+1
        beq     LEAF6
        lda     INDIC0
        cmp     #$C1
        bne     LEAF1
        jsr     LEB5F
        bcs     LEA89
        bcc     LEB34
LEAF1:  jsr     LEB79
        bcs     LEA89
LEAF6:  lda     #$EA
        sta     Proc1+9
        sta     Proc1+10
        ldx     INDIC0+1
LEB00:  lda     HRS3+1,x
        sta     Proc1+8,x
        dex
        bpl     LEB00
        lda     $04E1
        sta     BNKCIB
        lda     #$EA
        sta     VEXBNK+1
        lda     #$04
        sta     VEXBNK+2
        lda     HRS1+1
        pha
        lda     HRS3
        ldy     HRS2+1
        ldx     HRS2
        plp
        jsr     EXBNK
        php
        sta     HRS3
        sty     HRS2+1
        stx     HRS2
        pla
        sta     HRS1+1
        tsx
        stx     HRS1
        cli
        cld
LEB34:  jsr     LCC53
        jmp     LEA89

; ----------------------------------------------------------------------------
LEB3A:  bit     Flags
        bpl     LEB44
        BRK_TELEMON XCRLF
        jsr     DispRegs
LEB44:  jsr     LCF36
        cli
        cld
        lda     Flags
        beq     LEB51
        jsr     LC8D1
LEB51:  lda     #<Chan0bInitTbl
        ldy     #>Chan0bInitTbl
        ldx     #$00
        BRK_TELEMON XSCRSE
        jsr     LC8DC
        jmp     Warm_start

; ----------------------------------------------------------------------------
LEB5F:  lda     HRS3+1
        sta     Proc2
        lda     HRS1+1
        pha
        plp
        jsr     Proc2
        bcs     LEB6E
        rts

; ----------------------------------------------------------------------------
LEB6E:  jsr     LD3AE
        stx     Proc1+1
        sty     Proc1+2
        sec
        rts

; ----------------------------------------------------------------------------
LEB79:  pla
        sta     Ptr1
        pla
        sta     Ptr1+1
        lda     HRS3+1
        cmp     #$4C
        bne     LEB8E
        lda     HRS4
        ldy     HRS4+1
        jmp     LEBBB

; ----------------------------------------------------------------------------
LEB8E:  cmp     #$6C
        bne     LEBA8
        lda     HRS4
        ldy     HRS4+1
        sta     Proc1+1
        sty     Proc1+2
        jsr     LCC5B
        tax
        jsr     LCC53
        tay
        txa
        jmp     LEBBB

; ----------------------------------------------------------------------------
LEBA8:  cmp     #$20
        bne     LEBC4
        lda     Proc1+2
        pha
        lda     Proc1+1
        pha
        lda     HRS4
        ldy     HRS4+1
LEBB8:  tsx
        stx     HRS1
LEBBB:  sta     Proc1+1
        sty     Proc1+2
        jmp     LEC2C

; ----------------------------------------------------------------------------
LEBC4:  cmp     #$40
        bne     LEBD8
        tsx
        cpx     #$FC
        bcs     LEBE1
        pla
        sta     HRS1+1
        pla
        tax
        pla
        tay
        txa
        jmp     LEBB8

; ----------------------------------------------------------------------------
LEBD8:  cmp     #$60
        bne     LEBF4
        tsx
        cpx     #$FD
        bcc     LEBE9
LEBE1:  cpx     #$FE
        beq     LEC50
LEBE5:  ldx     #$16
        bne     LEC3E
LEBE9:  pla
        sta     Proc1+1
        pla
        sta     Proc1+2
        jmp     LEC26

; ----------------------------------------------------------------------------
LEBF4:  cmp     #$68
        bne     LEC07
        tsx
        cpx     #$FE
        bcs     LEBE5
        pla
        php
        sta     HRS3
        pla
        sta     HRS1+1
        jmp     LEC26

; ----------------------------------------------------------------------------
LEC07:  cmp     #$28
        bne     LEC15
        cpx     #$FE
        bcs     LEBE5
        pla
        sta     HRS1+1
        jmp     LEC26

; ----------------------------------------------------------------------------
LEC15:  cmp     #$48
        bne     LEC1F
        lda     HRS3
        pha
        jmp     LEC26

; ----------------------------------------------------------------------------
LEC1F:  cmp     #$08
        bne     LEC36
        lda     HRS1+1
        pha
LEC26:  tsx
        stx     HRS1
        jsr     LCC53
LEC2C:  sec
LEC2D:  lda     Ptr1+1
        pha
        lda     Ptr1
        pha
        rts

; ----------------------------------------------------------------------------
LEC36:  lda     INDIC2
        cmp     #$B8
        bcc     LEC2D
        ldx     #$17
LEC3E:  jsr     DispErrorX
        bit     Flags
        bpl     LEC50
LEC46:  jsr     LCC45
        dec     INDIC0+1
        bpl     LEC46
        jsr     LD3CB
LEC50:  jmp     LEB3A

; ----------------------------------------------------------------------------
LEC53:  lda     #$0C
        BRK_TELEMON XWR1
        lda     #<Registers_str
        ldy     #>Registers_str
        BRK_TELEMON XWSTR1
        lda     #$0A
        BRK_TELEMON XWR1
        lda     #$0D
        BRK_TELEMON XWR1
        ldy     #$03
LEC67:  lda     HRS1+1,y
        jsr     PutHexa
        jsr     LEC80
        lda     #$20
        BRK_TELEMON XWR1
        dey
        bpl     LEC67
        lda     #$20
        BRK_TELEMON XWR1
        lda     HRS1+1
        jsr     PutBitStr
LEC80:  pha
        tya
        pha
        txa
        pha
        lda     #$00
        ldy     #$01
        BRK_TELEMON XWSTR1
        pla
        tax
        pla
        tay
        pla
        rts

; ----------------------------------------------------------------------------
LEC91:  lda     #$0C
        BRK_TELEMON XWR2
        ldy     #$FE
LEC97:  lda     #$0A
        BRK_TELEMON XWR2
        lda     #$0D
        BRK_TELEMON XWR2
        tya
        pha
        ldy     #$01
        jsr     PutYAHexa
        jsr     LECC6
        pla
        tay
        cmp     HRS1
        beq     LECC1
        lda     #$20
        BRK_TELEMON XWR2
        lda     BUFTRV,y
        jsr     PutHexa
        jsr     LECC6
        dey
        cpy     #$E4
        bne     LEC97
LECC1:  lda     #$7F
        BRK_TELEMON XWR2
        rts

; ----------------------------------------------------------------------------
LECC6:  pha
        tya
        pha
        txa
        pha
        lda     #$00
        ldy     #$01
        BRK_TELEMON XWSTR2
        pla
        tax
        pla
        tay
        pla
        rts

; ----------------------------------------------------------------------------
LECD7:  bit     Flags
        bmi     LECE4
        bvs     LECEA
        lda     #<PasPas_str
        ldy     #>PasPas_str
        bne     LECEE
LECE4:  lda     #<Exec_str
        ldy     #>Exec_str
        bne     LECEE
LECEA:  lda     #<Trace_str
        ldy     #>Trace_str
LECEE:  ldx     #$02
        jmp     LC857

; ----------------------------------------------------------------------------
LECF3:  bit     Flags
        bmi     LED07
        bit     XLPRBI
        bmi     LED02
        jsr     LEC53
        jsr     LEC91
LED02:  BRK_TELEMON XCRLF
        jsr     LD3CB
LED07:  rts

; ----------------------------------------------------------------------------
LED08:  lda     #<Assemblage_str
        ldy     #>Assemblage_str
        ldx     #$04
        jmp     LC857

; ----------------------------------------------------------------------------
LED11:  jmp     SyntaxErr5

; ----------------------------------------------------------------------------
MINAS:  tax
        beq     LED11
        jsr     LD26A
        sta     Proc1+1
        sta     Proc1+9
        sty     Proc1+2
        sty     Proc1+10
        txa
        bne     LED11
        jsr     LED08
LED2C:  BRK_TELEMON XCRLF
LED2E:  ldx     #$00
        ldy     #$00
        lda     #$6E
        BRK_TELEMON XEDT
        cmp     #$03
        bne     LED40
LED3A:  jsr     LC8DC
        jmp     LCFCB

; ----------------------------------------------------------------------------
LED40:  cmp     #$0D
        bne     LED2C
        stx     VARAPL2+8
        cpx     #$00
        bne     IllegalLabErr2
        jsr     LC8DC
        jsr     LED08
        jsr     LCA2D
        beq     LED3A
        jsr     LC934
        bcc     LED95
        lda     #$90
        sta     TXTPTR
        lda     #$05
        sta     TXTPTR+1
        jsr     CharGot
        ldy     #$00
        lda     (TXTPTR),y
        bmi     LED79
        cmp     #$27
        beq     LED2E
        jsr     LD86D
        jsr     LD8D4
        beq     LED2C
        ldy     #$00
LED79:  lda     (TXTPTR),y
        sta     INDIC2
        cmp     #$80
        beq     LEDDC
        cmp     #$99
        bcs     LED9C
        lda     #$00
        tax
        jsr     LCA79
        bcs     LEDDF
        ldx     #$13
        .byte   $2C
; Err $0F
IllegalLabErr2:
        ldx     #$0F
        .byte   $2C
; Err $00
SyntaxErr7:
        ldx     #$00
LED95:  lda     #$00
        sta     VARAPL2+8
        jmp     LCF98

; ----------------------------------------------------------------------------
LED9C:  cmp     #$A1
        bcs     LEDA5
        jsr     LD9C0
        bne     LEDDF
LEDA5:  cmp     #$B9
        beq     SyntaxErr7
        cmp     #$BC
        beq     SyntaxErr7
        cmp     #$B8
        bne     LEDB7
        jsr     LEE35
        jmp     LED2C

; ----------------------------------------------------------------------------
LEDB7:  cmp     #$BA
        bne     LEDC1
        jsr     LEE6B
        jmp     LED2C

; ----------------------------------------------------------------------------
LEDC1:  cmp     #$BD
        bne     LEDCB
        jsr     LEE7A
        jmp     LED2C

; ----------------------------------------------------------------------------
LEDCB:  cmp     #$BB
        bne     LEDD8
        jsr     LDAEA
        jsr     LCCB3
        jmp     LED2C

; ----------------------------------------------------------------------------
LEDD8:  cmp     #$B8
        bcs     SyntaxErr7
LEDDC:  jsr     LD912
LEDDF:  sta     HRS3+1
        stx     INDIC0+1
        lda     VARAPL+14
        sta     HRS4
        lda     VARAPL+15
        sta     HRS4+1
        ldy     #$FF
LEDED:  iny
        lda     HRS3+1,y
        jsr     LCCDB
        jsr     LCCD2
        dex
        bpl     LEDED
        lda     #$7F
        BRK_TELEMON XWR0
        jsr     LD3CB
        jsr     LCC53
        jmp     LED2C

; ----------------------------------------------------------------------------
LEE07:  lda     Proc1+1
        sta     Ptr1
        lda     Proc1+2
        sta     Ptr1+1
        lda     TXTPTR
        sta     Ptr2
        lda     TXTPTR+1
        sta     Ptr2+1
        rts

; ----------------------------------------------------------------------------
LEE1E:  lda     Ptr1
        sta     Proc1+1
        lda     Ptr1+1
        sta     Proc1+2
        lda     Ptr2
        sta     TXTPTR
        lda     Ptr2+1
        sta     TXTPTR+1
        rts

; ----------------------------------------------------------------------------
LEE35:  jsr     LEE07
        jsr     LDA62
        jsr     LEE1E
        jsr     LDAA4
LEE41:  lda     #$7F
        BRK_TELEMON XWR0
        sec
        lda     Proc1+1
        sbc     Ptr1
        sta     VARAPL+6
        lda     Ptr1
        sta     VARAPL+10
        ldy     Ptr1+1
        sty     VARAPL+11
        jsr     DispWord
        ldy     #$00
LEE5D:  jsr     DispSpace
        lda     (VARAPL+10),y
        jsr     DispByte
        iny
        cpy     VARAPL+6
        bcc     LEE5D
        rts

; ----------------------------------------------------------------------------
LEE6B:  jsr     LEE07
        jsr     LDA40
        jsr     LEE1E
        jsr     LD9FA
        jmp     LEE41

; ----------------------------------------------------------------------------
LEE7A:  jsr     LEE07
        jsr     LDA40
        jsr     LEE1E
        jsr     LDA1D
        jmp     LEE41

; ----------------------------------------------------------------------------
LEE89:  pha
        lda     #<Occurences_str
        ldy     #>Occurences_str
        BRK_TELEMON XWSTR0
        pla
        jmp     LC766

; ----------------------------------------------------------------------------
SEEK:   ldx     #$00
        stx     XLPRBI
        jsr     LEF14
        beq     LEEAC
        jsr     LD1AC
        cmp     #$4C
        bne     LEF17
        ror     XLPRBI
        jsr     CharGet
        tax
        bne     LEF17
LEEAC:  sta     HRSX6
        lda     SCEDEB
        sta     TXTPTR
        lda     SCEDEB+1
        sta     TXTPTR+1
LEEB6:  ldy     #$00
        sty     HRSX40
        lda     (TXTPTR),y
        beq     LEF0C
        ldy     #$03
LEEC0:  lda     (TXTPTR),y
        beq     LEEE1
        sty     HRSY
        ldx     #$00
LEEC8:  lda     BUFEDT,x
        beq     LEEDA
        cmp     (TXTPTR),y
        beq     LEED6
        ldy     HRSY
        iny
        bne     LEEC0
LEED6:  iny
        inx
        bne     LEEC8
LEEDA:  inc     HRSX6
        sec
        ror     HRSX40
        bmi     LEEC0
LEEE1:  bit     XLPRBI
        bpl     LEF05
        bit     HRSX40
        bpl     LEF05
        lda     TXTPTR
        ldy     TXTPTR+1
        sta     VARAPL+12
        sty     VARAPL+13
        ldy     #$01
        lda     (TXTPTR),y
        pha
        iny
        lda     (TXTPTR),y
        tay
        pla
        jsr     LCAF2
        jsr     LC8B4
        bcs     LEF11
        BRK_TELEMON XCRLF
LEF05:  iny
        jsr     IncTXTPTR
        jmp     LEEB6

; ----------------------------------------------------------------------------
LEF0C:  lda     HRSX6
        jsr     LEE89
LEF11:  jmp     LCFC8

; ----------------------------------------------------------------------------
LEF14:  tax
        cmp     #$22
LEF17:  bne     SyntaxErr8
        ldx     #$00
        ldy     #$01
        lda     (TXTPTR),y
        beq     LEF25
        cmp     #$22
        bne     LEF2D
LEF25:  jsr     IncTXTPTR
; Err $00
SyntaxErr8:
        ldx     #$00
        jmp     LCF98

; ----------------------------------------------------------------------------
LEF2D:  lda     (TXTPTR),y
        sta     BUFEDT,x
        beq     LEF42
        cmp     #$22
        beq     LEF3C
        iny
        inx
        bne     LEF2D
LEF3C:  lda     #$00
        sta     $058F,y
        iny
LEF42:  jsr     IncTXTPTR
        jsr     CharGot
        tax
        rts

; ----------------------------------------------------------------------------
CHANGE: jsr     LEF14
        beq     SyntaxErr8
        cmp     #$2C
        bne     SyntaxErr8
        jsr     CharGet
        cmp     #$22
        bne     SyntaxErr8
        ldy     #$01
LEF5C:  lda     (TXTPTR),y
        sta     $FF,y
        beq     LEF70
        cmp     #$22
        beq     LEF6A
        iny
        bne     LEF5C
LEF6A:  lda     #$00
        sta     $FF,y
        iny
LEF70:  jsr     IncTXTPTR
        jsr     CharGot
        tax
        bne     SyntaxErr8
        sta     VARAPL+6
        lda     SCEDEB
        ldy     SCEDEB+1
        sta     DECDEB
        sty     DECDEB+1
        sta     Proc1+9
        sty     Proc1+10
        lda     SCEFIN
        ldy     SCEFIN+1
        sta     DECFIN
        sty     DECFIN+1
        sta     DECCIB
        sty     DECCIB+1
        sta     TXTPTR
        sty     TXTPTR+1
        BRK_TELEMON XDECAL
LEF9B:  ldy     #$00
        lda     (TXTPTR),y
        beq     LEFEF
LEFA1:  lda     (TXTPTR),y
        jsr     Proc1+8
        jsr     LCCD2
        iny
        cpy     #$03
        bne     LEFA1
LEFAE:  lda     (TXTPTR),y
        beq     LEFE2
        sty     VARAPL+5
        ldx     #$00
LEFB6:  lda     BUFEDT,x
        beq     LEFD0
        cmp     (TXTPTR),y
        beq     LEFCC
        ldy     VARAPL+5
        lda     (TXTPTR),y
        jsr     Proc1+8
        jsr     LCCD2
        iny
        bne     LEFAE
LEFCC:  iny
        inx
        bne     LEFB6
LEFD0:  ldx     #$00
        inc     VARAPL+6
LEFD4:  lda     BUFTRV,x
        beq     LEFAE
        jsr     Proc1+8
        jsr     LCCD2
        inx
        bne     LEFD4
LEFE2:  jsr     Proc1+8
        jsr     LCCD2
        iny
        jsr     IncTXTPTR
        jmp     LEF9B

; ----------------------------------------------------------------------------
LEFEF:  jsr     Proc1+8
        lda     TXTPTR
        ldy     TXTPTR+1
        jsr     LD236
        lda     VARAPL+6
        jsr     LEE89
        BRK_TELEMON XCRLF
        lda     #$00
        jmp     OLD

; ----------------------------------------------------------------------------
TEXT:   tax
        bne     LF015
        BRK_TELEMON XTEXT
        jmp     LCFCB

; ----------------------------------------------------------------------------
HIRES:  tax
        bne     LF015
        BRK_TELEMON XHIRES
        jmp     LCFCB

; ----------------------------------------------------------------------------
LF015:  jmp     LCF98

; ----------------------------------------------------------------------------
SymbolTable:
        .byte   "ACC1E "
; ----------------------------------------------------------------------------
        .word   $0060
; ----------------------------------------------------------------------------
        .byte   "ACC1EX"
; ----------------------------------------------------------------------------
        .word   $0066
; ----------------------------------------------------------------------------
        .byte   "ACC1J "
; ----------------------------------------------------------------------------
        .word   $0067
; ----------------------------------------------------------------------------
        .byte   "ACC1M "
; ----------------------------------------------------------------------------
        .word   $0061
; ----------------------------------------------------------------------------
        .byte   "ACC1S "
; ----------------------------------------------------------------------------
        .word   $0065
; ----------------------------------------------------------------------------
        .byte   "ACC2E "
; ----------------------------------------------------------------------------
        .word   $0068
; ----------------------------------------------------------------------------
        .byte   "ACC2M "
; ----------------------------------------------------------------------------
        .word   $0069
; ----------------------------------------------------------------------------
        .byte   "ACC2S "
; ----------------------------------------------------------------------------
        .word   $006D
; ----------------------------------------------------------------------------
        .byte   "ACC3  "
; ----------------------------------------------------------------------------
        .word   $006F
; ----------------------------------------------------------------------------
        .byte   "ACC4E "
; ----------------------------------------------------------------------------
        .word   $0073
; ----------------------------------------------------------------------------
        .byte   "ACC4M "
; ----------------------------------------------------------------------------
        .word   $0074
; ----------------------------------------------------------------------------
        .byte   "ACC5E "
; ----------------------------------------------------------------------------
        .word   $0078
; ----------------------------------------------------------------------------
        .byte   "ACC5M "
; ----------------------------------------------------------------------------
        .word   $0079
; ----------------------------------------------------------------------------
        .byte   "ACC6  "
; ----------------------------------------------------------------------------
        .word   $0080
; ----------------------------------------------------------------------------
        .byte   "ACCPS "
; ----------------------------------------------------------------------------
        .word   $006E
; ----------------------------------------------------------------------------
        .byte   "ACIACR"
; ----------------------------------------------------------------------------
        .word   $031E
; ----------------------------------------------------------------------------
        .byte   "ACIACT"
; ----------------------------------------------------------------------------
        .word   $031F
; ----------------------------------------------------------------------------
        .byte   "ACIADR"
; ----------------------------------------------------------------------------
        .word   $031C
; ----------------------------------------------------------------------------
        .byte   "ACIASR"
; ----------------------------------------------------------------------------
        .word   $031D
; ----------------------------------------------------------------------------
        .byte   "ACK   "
; ----------------------------------------------------------------------------
        .word   $0006
; ----------------------------------------------------------------------------
        .byte   "ADASC "
; ----------------------------------------------------------------------------
        .word   $002E
; ----------------------------------------------------------------------------
        .byte   "ADATR "
; ----------------------------------------------------------------------------
        .word   $0030
; ----------------------------------------------------------------------------
        .byte   "ADCLK "
; ----------------------------------------------------------------------------
        .word   $0040
; ----------------------------------------------------------------------------
        .byte   "ADENT "
; ----------------------------------------------------------------------------
        .word   $0004
; ----------------------------------------------------------------------------
        .byte   "ADHRS "
; ----------------------------------------------------------------------------
        .word   $004B
; ----------------------------------------------------------------------------
        .byte   "ADIOB "
; ----------------------------------------------------------------------------
        .word   $02BE
; ----------------------------------------------------------------------------
        .byte   "ADKBD "
; ----------------------------------------------------------------------------
        .word   $002A
; ----------------------------------------------------------------------------
        .byte   "ADMEN "
; ----------------------------------------------------------------------------
        .word   $0069
; ----------------------------------------------------------------------------
        .byte   "ADPS  "
; ----------------------------------------------------------------------------
        .word   $0008
; ----------------------------------------------------------------------------
        .byte   "ADSCR "
; ----------------------------------------------------------------------------
        .word   $0026
; ----------------------------------------------------------------------------
        .byte   "ADSCRH"
; ----------------------------------------------------------------------------
        .word   $021C
; ----------------------------------------------------------------------------
        .byte   "ADSCRL"
; ----------------------------------------------------------------------------
        .word   $0218
; ----------------------------------------------------------------------------
        .byte   "ADTMP "
; ----------------------------------------------------------------------------
        .word   $0006
; ----------------------------------------------------------------------------
        .byte   "ADTR  "
; ----------------------------------------------------------------------------
        .word   $000A
; ----------------------------------------------------------------------------
        .byte   "ADVDT "
; ----------------------------------------------------------------------------
        .word   $002C
; ----------------------------------------------------------------------------
        .byte   "BARBRE"
; ----------------------------------------------------------------------------
        .word   $4000
; ----------------------------------------------------------------------------
        .byte   "BEL   "
; ----------------------------------------------------------------------------
        .word   $0007
; ----------------------------------------------------------------------------
        .byte   "BITMFC"
; ----------------------------------------------------------------------------
        .word   $0544
; ----------------------------------------------------------------------------
        .byte   "BNKCIB"
; ----------------------------------------------------------------------------
        .word   $0417
; ----------------------------------------------------------------------------
        .byte   "BNKST "
; ----------------------------------------------------------------------------
        .word   $0200
; ----------------------------------------------------------------------------
        .byte   "BS    "
; ----------------------------------------------------------------------------
        .word   $0008
; ----------------------------------------------------------------------------
        .byte   "BUF1  "
; ----------------------------------------------------------------------------
        .word   $C100
; ----------------------------------------------------------------------------
        .byte   "BUF2  "
; ----------------------------------------------------------------------------
        .word   $C200
; ----------------------------------------------------------------------------
        .byte   "BUF2B "
; ----------------------------------------------------------------------------
        .word   $C300
; ----------------------------------------------------------------------------
        .byte   "BUF3  "
; ----------------------------------------------------------------------------
        .word   $C400
; ----------------------------------------------------------------------------
        .byte   "BUFBIP"
; ----------------------------------------------------------------------------
        .word   $0100
; ----------------------------------------------------------------------------
        .byte   "BUFBIS"
; ----------------------------------------------------------------------------
        .word   $0101
; ----------------------------------------------------------------------------
        .byte   "BUFBUF"
; ----------------------------------------------------------------------------
        .word   $C080
; ----------------------------------------------------------------------------
        .byte   "BUFC0 "
; ----------------------------------------------------------------------------
        .word   $053B
; ----------------------------------------------------------------------------
        .byte   "BUFEDT"
; ----------------------------------------------------------------------------
        .word   $0590
; ----------------------------------------------------------------------------
        .byte   "BUFNOM"
; ----------------------------------------------------------------------------
        .word   $0517
; ----------------------------------------------------------------------------
        .byte   "BUFROU"
; ----------------------------------------------------------------------------
        .word   $C500
; ----------------------------------------------------------------------------
        .byte   "BUFTRV"
; ----------------------------------------------------------------------------
        .word   $0100
; ----------------------------------------------------------------------------
        .byte   "BUFTXT"
; ----------------------------------------------------------------------------
        .word   $8000
; ----------------------------------------------------------------------------
        .byte   "BVDTAS"
; ----------------------------------------------------------------------------
        .word   $9000
; ----------------------------------------------------------------------------
        .byte   "BVDTAT"
; ----------------------------------------------------------------------------
        .word   $9400
; ----------------------------------------------------------------------------
        .byte   "CAN   "
; ----------------------------------------------------------------------------
        .word   $0018
; ----------------------------------------------------------------------------
        .byte   "CDRIVE"
; ----------------------------------------------------------------------------
        .word   $0314
; ----------------------------------------------------------------------------
        .byte   "CR    "
; ----------------------------------------------------------------------------
        .word   $000D
; ----------------------------------------------------------------------------
        .byte   "CSRND "
; ----------------------------------------------------------------------------
        .word   $02EF
; ----------------------------------------------------------------------------
        .byte   "CURSCR"
; ----------------------------------------------------------------------------
        .word   $024C
; ----------------------------------------------------------------------------
        .byte   "DC1   "
; ----------------------------------------------------------------------------
        .word   $0011
; ----------------------------------------------------------------------------
        .byte   "DC2   "
; ----------------------------------------------------------------------------
        .word   $0012
; ----------------------------------------------------------------------------
        .byte   "DC3   "
; ----------------------------------------------------------------------------
        .word   $0013
; ----------------------------------------------------------------------------
        .byte   "DC4   "
; ----------------------------------------------------------------------------
        .word   $0014
; ----------------------------------------------------------------------------
        .byte   "DECCIB"
; ----------------------------------------------------------------------------
        .word   $0008
; ----------------------------------------------------------------------------
        .byte   "DECDEB"
; ----------------------------------------------------------------------------
        .word   $0004
; ----------------------------------------------------------------------------
        .byte   "DECFIN"
; ----------------------------------------------------------------------------
        .word   $0006
; ----------------------------------------------------------------------------
        .byte   "DECREP"
; ----------------------------------------------------------------------------
        .word   $0537
; ----------------------------------------------------------------------------
        .byte   "DECRES"
; ----------------------------------------------------------------------------
        .word   $0538
; ----------------------------------------------------------------------------
        .byte   "DECTRV"
; ----------------------------------------------------------------------------
        .word   $000A
; ----------------------------------------------------------------------------
        .byte   "DEFAFF"
; ----------------------------------------------------------------------------
        .word   $0014
; ----------------------------------------------------------------------------
        .byte   "DESALO"
; ----------------------------------------------------------------------------
        .word   $052D
; ----------------------------------------------------------------------------
        .byte   "DLE   "
; ----------------------------------------------------------------------------
        .word   $0010
; ----------------------------------------------------------------------------
        .byte   "DRIVE "
; ----------------------------------------------------------------------------
        .word   $0500
; ----------------------------------------------------------------------------
        .byte   "DRVDEF"
; ----------------------------------------------------------------------------
        .word   $020C
; ----------------------------------------------------------------------------
        .byte   "EM    "
; ----------------------------------------------------------------------------
        .word   $0019
; ----------------------------------------------------------------------------
        .byte   "ENQ   "
; ----------------------------------------------------------------------------
        .word   $0005
; ----------------------------------------------------------------------------
        .byte   "EOT   "
; ----------------------------------------------------------------------------
        .word   $0004
; ----------------------------------------------------------------------------
        .byte   "ERRFDC"
; ----------------------------------------------------------------------------
        .word   $050E
; ----------------------------------------------------------------------------
        .byte   "ERRFLG"
; ----------------------------------------------------------------------------
        .word   $050F
; ----------------------------------------------------------------------------
        .byte   "ERRNB "
; ----------------------------------------------------------------------------
        .word   $0512
; ----------------------------------------------------------------------------
        .byte   "ERRVEC"
; ----------------------------------------------------------------------------
        .word   $0510
; ----------------------------------------------------------------------------
        .byte   "ESCAPE"
; ----------------------------------------------------------------------------
        .word   $001B
; ----------------------------------------------------------------------------
        .byte   "ETB   "
; ----------------------------------------------------------------------------
        .word   $0017
; ----------------------------------------------------------------------------
        .byte   "ETX   "
; ----------------------------------------------------------------------------
        .word   $0003
; ----------------------------------------------------------------------------
        .byte   "EXBNK "
; ----------------------------------------------------------------------------
        .word   $040C
; ----------------------------------------------------------------------------
        .byte   "EXSALO"
; ----------------------------------------------------------------------------
        .word   $0531
; ----------------------------------------------------------------------------
        .byte   "EXTDEF"
; ----------------------------------------------------------------------------
        .word   $055D
; ----------------------------------------------------------------------------
        .byte   "FDCCR "
; ----------------------------------------------------------------------------
        .word   $0310
; ----------------------------------------------------------------------------
        .byte   "FDCDR "
; ----------------------------------------------------------------------------
        .word   $0313
; ----------------------------------------------------------------------------
        .byte   "FDCDRQ"
; ----------------------------------------------------------------------------
        .word   $0318
; ----------------------------------------------------------------------------
        .byte   "FDCSR "
; ----------------------------------------------------------------------------
        .word   $0312
; ----------------------------------------------------------------------------
        .byte   "FDCTR "
; ----------------------------------------------------------------------------
        .word   $0311
; ----------------------------------------------------------------------------
        .byte   "FF    "
; ----------------------------------------------------------------------------
        .word   $000C
; ----------------------------------------------------------------------------
        .byte   "FICLON"
; ----------------------------------------------------------------------------
        .word   $054A
; ----------------------------------------------------------------------------
        .byte   "FICNUM"
; ----------------------------------------------------------------------------
        .word   $0548
; ----------------------------------------------------------------------------
        .byte   "FICTYP"
; ----------------------------------------------------------------------------
        .word   $0547
; ----------------------------------------------------------------------------
        .byte   "FISALO"
; ----------------------------------------------------------------------------
        .word   $052F
; ----------------------------------------------------------------------------
        .byte   "FLDT0 "
; ----------------------------------------------------------------------------
        .word   $0074
; ----------------------------------------------------------------------------
        .byte   "FLDT1 "
; ----------------------------------------------------------------------------
        .word   $0075
; ----------------------------------------------------------------------------
        .byte   "FLDT2 "
; ----------------------------------------------------------------------------
        .word   $0076
; ----------------------------------------------------------------------------
        .byte   "FLERR "
; ----------------------------------------------------------------------------
        .word   $008B
; ----------------------------------------------------------------------------
        .byte   "FLGCLK"
; ----------------------------------------------------------------------------
        .word   $0214
; ----------------------------------------------------------------------------
        .byte   "FLGJCK"
; ----------------------------------------------------------------------------
        .word   $028C
; ----------------------------------------------------------------------------
        .byte   "FLGKBD"
; ----------------------------------------------------------------------------
        .word   $0275
; ----------------------------------------------------------------------------
        .byte   "FLGLPR"
; ----------------------------------------------------------------------------
        .word   $028A
; ----------------------------------------------------------------------------
        .byte   "FLGMEN"
; ----------------------------------------------------------------------------
        .word   $0068
; ----------------------------------------------------------------------------
        .byte   "FLGSCR"
; ----------------------------------------------------------------------------
        .word   $0248
; ----------------------------------------------------------------------------
        .byte   "FLGTEL"
; ----------------------------------------------------------------------------
        .word   $020D
; ----------------------------------------------------------------------------
        .byte   "FLGVD0"
; ----------------------------------------------------------------------------
        .word   $003C
; ----------------------------------------------------------------------------
        .byte   "FLGVD1"
; ----------------------------------------------------------------------------
        .word   $003D
; ----------------------------------------------------------------------------
        .byte   "FLINT "
; ----------------------------------------------------------------------------
        .word   $0088
; ----------------------------------------------------------------------------
        .byte   "FLSGN "
; ----------------------------------------------------------------------------
        .word   $008A
; ----------------------------------------------------------------------------
        .byte   "FLSVS "
; ----------------------------------------------------------------------------
        .word   $0089
; ----------------------------------------------------------------------------
        .byte   "FLSVY "
; ----------------------------------------------------------------------------
        .word   $0077
; ----------------------------------------------------------------------------
        .byte   "FLTR0 "
; ----------------------------------------------------------------------------
        .word   $007D
; ----------------------------------------------------------------------------
        .byte   "FLTR1 "
; ----------------------------------------------------------------------------
        .word   $007E
; ----------------------------------------------------------------------------
        .byte   "FS    "
; ----------------------------------------------------------------------------
        .word   $001C
; ----------------------------------------------------------------------------
        .byte   "FTYPE "
; ----------------------------------------------------------------------------
        .word   $052C
; ----------------------------------------------------------------------------
        .byte   "GS    "
; ----------------------------------------------------------------------------
        .word   $001D
; ----------------------------------------------------------------------------
        .byte   "HRS1  "
; ----------------------------------------------------------------------------
        .word   $004D
; ----------------------------------------------------------------------------
        .byte   "HRS2  "
; ----------------------------------------------------------------------------
        .word   $004F
; ----------------------------------------------------------------------------
        .byte   "HRS3  "
; ----------------------------------------------------------------------------
        .word   $0051
; ----------------------------------------------------------------------------
        .byte   "HRS4  "
; ----------------------------------------------------------------------------
        .word   $0053
; ----------------------------------------------------------------------------
        .byte   "HRS5  "
; ----------------------------------------------------------------------------
        .word   $0055
; ----------------------------------------------------------------------------
        .byte   "HRSERR"
; ----------------------------------------------------------------------------
        .word   $02AB
; ----------------------------------------------------------------------------
        .byte   "HRSFB "
; ----------------------------------------------------------------------------
        .word   $0057
; ----------------------------------------------------------------------------
        .byte   "HRSPAT"
; ----------------------------------------------------------------------------
        .word   $02AA
; ----------------------------------------------------------------------------
        .byte   "HRSX  "
; ----------------------------------------------------------------------------
        .word   $0046
; ----------------------------------------------------------------------------
        .byte   "HRSX40"
; ----------------------------------------------------------------------------
        .word   $0049
; ----------------------------------------------------------------------------
        .byte   "HRSX6 "
; ----------------------------------------------------------------------------
        .word   $004A
; ----------------------------------------------------------------------------
        .byte   "HRSY  "
; ----------------------------------------------------------------------------
        .word   $0047
; ----------------------------------------------------------------------------
        .byte   "HT    "
; ----------------------------------------------------------------------------
        .word   $0009
; ----------------------------------------------------------------------------
        .byte   "INDFCB"
; ----------------------------------------------------------------------------
        .word   $0546
; ----------------------------------------------------------------------------
        .byte   "INDIC0"
; ----------------------------------------------------------------------------
        .word   $0055
; ----------------------------------------------------------------------------
        .byte   "INDIC1"
; ----------------------------------------------------------------------------
        .word   $02AA
; ----------------------------------------------------------------------------
        .byte   "INDIC2"
; ----------------------------------------------------------------------------
        .word   $0057
; ----------------------------------------------------------------------------
        .byte   "INPIS "
; ----------------------------------------------------------------------------
        .word   $052D
; ----------------------------------------------------------------------------
        .byte   "INSEC "
; ----------------------------------------------------------------------------
        .word   $052E
; ----------------------------------------------------------------------------
        .byte   "IOTAB0"
; ----------------------------------------------------------------------------
        .word   $02AE
; ----------------------------------------------------------------------------
        .byte   "IOTAB1"
; ----------------------------------------------------------------------------
        .word   $02B2
; ----------------------------------------------------------------------------
        .byte   "IOTAB2"
; ----------------------------------------------------------------------------
        .word   $02B6
; ----------------------------------------------------------------------------
        .byte   "IOTAB3"
; ----------------------------------------------------------------------------
        .word   $02BA
; ----------------------------------------------------------------------------
        .byte   "IRQSVA"
; ----------------------------------------------------------------------------
        .word   $0021
; ----------------------------------------------------------------------------
        .byte   "IRQSVX"
; ----------------------------------------------------------------------------
        .word   $0022
; ----------------------------------------------------------------------------
        .byte   "IRQSVY"
; ----------------------------------------------------------------------------
        .word   $0023
; ----------------------------------------------------------------------------
        .byte   "JCDVAL"
; ----------------------------------------------------------------------------
        .word   $028E
; ----------------------------------------------------------------------------
        .byte   "JCGVAL"
; ----------------------------------------------------------------------------
        .word   $028D
; ----------------------------------------------------------------------------
        .byte   "JCKTAB"
; ----------------------------------------------------------------------------
        .word   $029D
; ----------------------------------------------------------------------------
        .byte   "LF    "
; ----------------------------------------------------------------------------
        .word   $000A
; ----------------------------------------------------------------------------
        .byte   "KBDCOL"
; ----------------------------------------------------------------------------
        .word   $0268
; ----------------------------------------------------------------------------
        .byte   "KBDCR "
; ----------------------------------------------------------------------------
        .word   $0344
; ----------------------------------------------------------------------------
        .byte   "KBDCTC"
; ----------------------------------------------------------------------------
        .word   $027E
; ----------------------------------------------------------------------------
        .byte   "KBDDR "
; ----------------------------------------------------------------------------
        .word   $0343
; ----------------------------------------------------------------------------
        .byte   "KBDFCT"
; ----------------------------------------------------------------------------
        .word   $0276
; ----------------------------------------------------------------------------
        .byte   "KBDKEY"
; ----------------------------------------------------------------------------
        .word   $0279
; ----------------------------------------------------------------------------
        .byte   "KBDSHT"
; ----------------------------------------------------------------------------
        .word   $0278
; ----------------------------------------------------------------------------
        .byte   "KBDSR "
; ----------------------------------------------------------------------------
        .word   $0342
; ----------------------------------------------------------------------------
        .byte   "KBDVRL"
; ----------------------------------------------------------------------------
        .word   $0273
; ----------------------------------------------------------------------------
        .byte   "KBDVRR"
; ----------------------------------------------------------------------------
        .word   $0272
; ----------------------------------------------------------------------------
        .byte   "KORAM "
; ----------------------------------------------------------------------------
        .word   $020F
; ----------------------------------------------------------------------------
        .byte   "KOROM "
; ----------------------------------------------------------------------------
        .word   $020E
; ----------------------------------------------------------------------------
        .byte   "LOCRE "
; ----------------------------------------------------------------------------
        .word   $0533
; ----------------------------------------------------------------------------
        .byte   "LOCREB"
; ----------------------------------------------------------------------------
        .word   $0535
; ----------------------------------------------------------------------------
        .byte   "LOSALO"
; ----------------------------------------------------------------------------
        .word   $052A
; ----------------------------------------------------------------------------
        .byte   "LPRFX "
; ----------------------------------------------------------------------------
        .word   $0288
; ----------------------------------------------------------------------------
        .byte   "LPRFY "
; ----------------------------------------------------------------------------
        .word   $0289
; ----------------------------------------------------------------------------
        .byte   "LPRSY "
; ----------------------------------------------------------------------------
        .word   $028B
; ----------------------------------------------------------------------------
        .byte   "LPRVEC"
; ----------------------------------------------------------------------------
        .word   $024E
; ----------------------------------------------------------------------------
        .byte   "LPRX  "
; ----------------------------------------------------------------------------
        .word   $0286
; ----------------------------------------------------------------------------
        .byte   "LPRY  "
; ----------------------------------------------------------------------------
        .word   $0287
; ----------------------------------------------------------------------------
        .byte   "MEN   "
; ----------------------------------------------------------------------------
        .word   $0060
; ----------------------------------------------------------------------------
        .byte   "MENDDX"
; ----------------------------------------------------------------------------
        .word   $0061
; ----------------------------------------------------------------------------
        .byte   "MENDDY"
; ----------------------------------------------------------------------------
        .word   $0062
; ----------------------------------------------------------------------------
        .byte   "MENDFY"
; ----------------------------------------------------------------------------
        .word   $0063
; ----------------------------------------------------------------------------
        .byte   "MENDY "
; ----------------------------------------------------------------------------
        .word   $0066
; ----------------------------------------------------------------------------
        .byte   "MENFY "
; ----------------------------------------------------------------------------
        .word   $0067
; ----------------------------------------------------------------------------
        .byte   "MENLX "
; ----------------------------------------------------------------------------
        .word   $0065
; ----------------------------------------------------------------------------
        .byte   "MENX  "
; ----------------------------------------------------------------------------
        .word   $0064
; ----------------------------------------------------------------------------
        .byte   "NAK   "
; ----------------------------------------------------------------------------
        .word   $0015
; ----------------------------------------------------------------------------
        .byte   "NBCRE "
; ----------------------------------------------------------------------------
        .word   $0539
; ----------------------------------------------------------------------------
        .byte   "NBFIC "
; ----------------------------------------------------------------------------
        .word   $0549
; ----------------------------------------------------------------------------
        .byte   "NUL   "
; ----------------------------------------------------------------------------
        .word   $0000
; ----------------------------------------------------------------------------
        .byte   "PARPIS"
; ----------------------------------------------------------------------------
        .word   $052F
; ----------------------------------------------------------------------------
        .byte   "PARSEC"
; ----------------------------------------------------------------------------
        .word   $0530
; ----------------------------------------------------------------------------
        .byte   "PISCAT"
; ----------------------------------------------------------------------------
        .word   $BFE8
; ----------------------------------------------------------------------------
        .byte   "PISTE "
; ----------------------------------------------------------------------------
        .word   $0501
; ----------------------------------------------------------------------------
        .byte   "POSNMP"
; ----------------------------------------------------------------------------
        .word   $0514
; ----------------------------------------------------------------------------
        .byte   "POSNMS"
; ----------------------------------------------------------------------------
        .word   $0515
; ----------------------------------------------------------------------------
        .byte   "POSNMX"
; ----------------------------------------------------------------------------
        .word   $0516
; ----------------------------------------------------------------------------
        .byte   "REP   "
; ----------------------------------------------------------------------------
        .word   $0012
; ----------------------------------------------------------------------------
        .byte   "RES   "
; ----------------------------------------------------------------------------
        .word   $0000
; ----------------------------------------------------------------------------
        .byte   "RESB  "
; ----------------------------------------------------------------------------
        .word   $0002
; ----------------------------------------------------------------------------
        .byte   "RS    "
; ----------------------------------------------------------------------------
        .word   $001E
; ----------------------------------------------------------------------------
        .byte   "RS232C"
; ----------------------------------------------------------------------------
        .word   $005A
; ----------------------------------------------------------------------------
        .byte   "RS232T"
; ----------------------------------------------------------------------------
        .word   $0059
; ----------------------------------------------------------------------------
        .byte   "RWBUF "
; ----------------------------------------------------------------------------
        .word   $0503
; ----------------------------------------------------------------------------
        .byte   "RWTS  "
; ----------------------------------------------------------------------------
        .word   $054F
; ----------------------------------------------------------------------------
        .byte   "SAVES "
; ----------------------------------------------------------------------------
        .word   $0513
; ----------------------------------------------------------------------------
        .byte   "SCEDEB"
; ----------------------------------------------------------------------------
        .word   $005C
; ----------------------------------------------------------------------------
        .byte   "SCEFIN"
; ----------------------------------------------------------------------------
        .word   $005E
; ----------------------------------------------------------------------------
        .byte   "SCRBAH"
; ----------------------------------------------------------------------------
        .word   $023C
; ----------------------------------------------------------------------------
        .byte   "SCRBAL"
; ----------------------------------------------------------------------------
        .word   $0238
; ----------------------------------------------------------------------------
        .byte   "SCRCF "
; ----------------------------------------------------------------------------
        .word   $0244
; ----------------------------------------------------------------------------
        .byte   "SCRCT "
; ----------------------------------------------------------------------------
        .word   $0240
; ----------------------------------------------------------------------------
        .byte   "SCRDX "
; ----------------------------------------------------------------------------
        .word   $0228
; ----------------------------------------------------------------------------
        .byte   "SCRDY "
; ----------------------------------------------------------------------------
        .word   $0230
; ----------------------------------------------------------------------------
        .byte   "SCRFX "
; ----------------------------------------------------------------------------
        .word   $022C
; ----------------------------------------------------------------------------
        .byte   "SCRFY "
; ----------------------------------------------------------------------------
        .word   $0234
; ----------------------------------------------------------------------------
        .byte   "SCRHIR"
; ----------------------------------------------------------------------------
        .word   $025C
; ----------------------------------------------------------------------------
        .byte   "SCRNB "
; ----------------------------------------------------------------------------
        .word   $0028
; ----------------------------------------------------------------------------
        .byte   "SCRTRA"
; ----------------------------------------------------------------------------
        .word   $0262
; ----------------------------------------------------------------------------
        .byte   "SCRTXT"
; ----------------------------------------------------------------------------
        .word   $0256
; ----------------------------------------------------------------------------
        .byte   "SCRX  "
; ----------------------------------------------------------------------------
        .word   $0220
; ----------------------------------------------------------------------------
        .byte   "SCRY  "
; ----------------------------------------------------------------------------
        .word   $0224
; ----------------------------------------------------------------------------
        .byte   "SECTEU"
; ----------------------------------------------------------------------------
        .word   $0502
; ----------------------------------------------------------------------------
        .byte   "SEP   "
; ----------------------------------------------------------------------------
        .word   $0013
; ----------------------------------------------------------------------------
        .byte   "SGDPAR"
; ----------------------------------------------------------------------------
        .word   $0340
; ----------------------------------------------------------------------------
        .byte   "SGDPDR"
; ----------------------------------------------------------------------------
        .word   $0341
; ----------------------------------------------------------------------------
        .byte   "SI    "
; ----------------------------------------------------------------------------
        .word   $000F
; ----------------------------------------------------------------------------
        .byte   "SO    "
; ----------------------------------------------------------------------------
        .word   $000E
; ----------------------------------------------------------------------------
        .byte   "SOH   "
; ----------------------------------------------------------------------------
        .word   $0001
; ----------------------------------------------------------------------------
        .byte   "STX   "
; ----------------------------------------------------------------------------
        .word   $0002
; ----------------------------------------------------------------------------
        .byte   "SUB   "
; ----------------------------------------------------------------------------
        .word   $001A
; ----------------------------------------------------------------------------
        .byte   "SYN   "
; ----------------------------------------------------------------------------
        .word   $0016
; ----------------------------------------------------------------------------
        .byte   "TABDBH"
; ----------------------------------------------------------------------------
        .word   $9C80
; ----------------------------------------------------------------------------
        .byte   "TABDRV"
; ----------------------------------------------------------------------------
        .word   $0208
; ----------------------------------------------------------------------------
        .byte   "TAMPFC"
; ----------------------------------------------------------------------------
        .word   $0542
; ----------------------------------------------------------------------------
        .byte   "TIMED "
; ----------------------------------------------------------------------------
        .word   $0210
; ----------------------------------------------------------------------------
        .byte   "TIMEH "
; ----------------------------------------------------------------------------
        .word   $0213
; ----------------------------------------------------------------------------
        .byte   "TIMEM "
; ----------------------------------------------------------------------------
        .word   $0212
; ----------------------------------------------------------------------------
        .byte   "TIMES "
; ----------------------------------------------------------------------------
        .word   $0211
; ----------------------------------------------------------------------------
        .byte   "TIMEUD"
; ----------------------------------------------------------------------------
        .word   $0044
; ----------------------------------------------------------------------------
        .byte   "TIMEUS"
; ----------------------------------------------------------------------------
        .word   $0042
; ----------------------------------------------------------------------------
        .byte   "TR0   "
; ----------------------------------------------------------------------------
        .word   $000C
; ----------------------------------------------------------------------------
        .byte   "TR1   "
; ----------------------------------------------------------------------------
        .word   $000D
; ----------------------------------------------------------------------------
        .byte   "TR2   "
; ----------------------------------------------------------------------------
        .word   $000E
; ----------------------------------------------------------------------------
        .byte   "TR3   "
; ----------------------------------------------------------------------------
        .word   $000F
; ----------------------------------------------------------------------------
        .byte   "TR4   "
; ----------------------------------------------------------------------------
        .word   $0010
; ----------------------------------------------------------------------------
        .byte   "TR5   "
; ----------------------------------------------------------------------------
        .word   $0011
; ----------------------------------------------------------------------------
        .byte   "TR6   "
; ----------------------------------------------------------------------------
        .word   $0012
; ----------------------------------------------------------------------------
        .byte   "TR7   "
; ----------------------------------------------------------------------------
        .word   $0013
; ----------------------------------------------------------------------------
        .byte   "US    "
; ----------------------------------------------------------------------------
        .word   $001F
; ----------------------------------------------------------------------------
        .byte   "V1ACR "
; ----------------------------------------------------------------------------
        .word   $030B
; ----------------------------------------------------------------------------
        .byte   "V1DDRA"
; ----------------------------------------------------------------------------
        .word   $0303
; ----------------------------------------------------------------------------
        .byte   "V1DDRB"
; ----------------------------------------------------------------------------
        .word   $0302
; ----------------------------------------------------------------------------
        .byte   "V1DRA "
; ----------------------------------------------------------------------------
        .word   $0301
; ----------------------------------------------------------------------------
        .byte   "V1DRAB"
; ----------------------------------------------------------------------------
        .word   $030F
; ----------------------------------------------------------------------------
        .byte   "V1DRB "
; ----------------------------------------------------------------------------
        .word   $0300
; ----------------------------------------------------------------------------
        .byte   "V1IER "
; ----------------------------------------------------------------------------
        .word   $030E
; ----------------------------------------------------------------------------
        .byte   "V1IFR "
; ----------------------------------------------------------------------------
        .word   $030D
; ----------------------------------------------------------------------------
        .byte   "V1PCR "
; ----------------------------------------------------------------------------
        .word   $030C
; ----------------------------------------------------------------------------
        .byte   "V1SR  "
; ----------------------------------------------------------------------------
        .word   $030A
; ----------------------------------------------------------------------------
        .byte   "V1T1  "
; ----------------------------------------------------------------------------
        .word   $0304
; ----------------------------------------------------------------------------
        .byte   "V1T1L "
; ----------------------------------------------------------------------------
        .word   $0306
; ----------------------------------------------------------------------------
        .byte   "V1T2  "
; ----------------------------------------------------------------------------
        .word   $0308
; ----------------------------------------------------------------------------
        .byte   "V2ACR "
; ----------------------------------------------------------------------------
        .word   $032B
; ----------------------------------------------------------------------------
        .byte   "V2DDRA"
; ----------------------------------------------------------------------------
        .word   $0323
; ----------------------------------------------------------------------------
        .byte   "V2DDRB"
; ----------------------------------------------------------------------------
        .word   $0322
; ----------------------------------------------------------------------------
        .byte   "V2DRA "
; ----------------------------------------------------------------------------
        .word   $0321
; ----------------------------------------------------------------------------
        .byte   "V2DRAB"
; ----------------------------------------------------------------------------
        .word   $032F
; ----------------------------------------------------------------------------
        .byte   "V2DRB "
; ----------------------------------------------------------------------------
        .word   $0320
; ----------------------------------------------------------------------------
        .byte   "V2IER "
; ----------------------------------------------------------------------------
        .word   $032E
; ----------------------------------------------------------------------------
        .byte   "V2IFR "
; ----------------------------------------------------------------------------
        .word   $032D
; ----------------------------------------------------------------------------
        .byte   "V2PCR "
; ----------------------------------------------------------------------------
        .word   $032C
; ----------------------------------------------------------------------------
        .byte   "V2SR  "
; ----------------------------------------------------------------------------
        .word   $032A
; ----------------------------------------------------------------------------
        .byte   "V2T1  "
; ----------------------------------------------------------------------------
        .word   $0324
; ----------------------------------------------------------------------------
        .byte   "V2T1L "
; ----------------------------------------------------------------------------
        .word   $0326
; ----------------------------------------------------------------------------
        .byte   "V2T2  "
; ----------------------------------------------------------------------------
        .word   $0328
; ----------------------------------------------------------------------------
        .byte   "VAPLIC"
; ----------------------------------------------------------------------------
        .word   $02FD
; ----------------------------------------------------------------------------
        .byte   "VARAPL"
; ----------------------------------------------------------------------------
        .word   $00D0
; ----------------------------------------------------------------------------
        .byte   "VARLNB"
; ----------------------------------------------------------------------------
        .word   $0560
; ----------------------------------------------------------------------------
        .byte   "VARLNG"
; ----------------------------------------------------------------------------
        .word   $008C
; ----------------------------------------------------------------------------
        .byte   "VARMNB"
; ----------------------------------------------------------------------------
        .word   $0060
; ----------------------------------------------------------------------------
        .byte   "VCRE0 "
; ----------------------------------------------------------------------------
        .word   $053A
; ----------------------------------------------------------------------------
        .byte   "VDTASC"
; ----------------------------------------------------------------------------
        .word   $0033
; ----------------------------------------------------------------------------
        .byte   "VDTATR"
; ----------------------------------------------------------------------------
        .word   $0034
; ----------------------------------------------------------------------------
        .byte   "VDTDES"
; ----------------------------------------------------------------------------
        .word   $9C00
; ----------------------------------------------------------------------------
        .byte   "VDTFT "
; ----------------------------------------------------------------------------
        .word   $0035
; ----------------------------------------------------------------------------
        .byte   "VDTGX "
; ----------------------------------------------------------------------------
        .word   $003A
; ----------------------------------------------------------------------------
        .byte   "VDTGY "
; ----------------------------------------------------------------------------
        .word   $003B
; ----------------------------------------------------------------------------
        .byte   "VDTPAR"
; ----------------------------------------------------------------------------
        .word   $0032
; ----------------------------------------------------------------------------
        .byte   "VDTPIL"
; ----------------------------------------------------------------------------
        .word   $0282
; ----------------------------------------------------------------------------
        .byte   "VDTX  "
; ----------------------------------------------------------------------------
        .word   $0038
; ----------------------------------------------------------------------------
        .byte   "VDTY  "
; ----------------------------------------------------------------------------
        .word   $0039
; ----------------------------------------------------------------------------
        .byte   "VEXBNK"
; ----------------------------------------------------------------------------
        .word   $0414
; ----------------------------------------------------------------------------
        .byte   "VIRQ  "
; ----------------------------------------------------------------------------
        .word   $02FA
; ----------------------------------------------------------------------------
        .byte   "VNMI  "
; ----------------------------------------------------------------------------
        .word   $02F4
; ----------------------------------------------------------------------------
        .byte   "VSALO0"
; ----------------------------------------------------------------------------
        .word   $0528
; ----------------------------------------------------------------------------
        .byte   "VSALO1"
; ----------------------------------------------------------------------------
        .word   $0529
; ----------------------------------------------------------------------------
        .byte   "VT    "
; ----------------------------------------------------------------------------
        .word   $000B
; ----------------------------------------------------------------------------
        .byte   "XA1A2 "
; ----------------------------------------------------------------------------
        .word   $007E
; ----------------------------------------------------------------------------
        .byte   "XA1AFF"
; ----------------------------------------------------------------------------
        .word   $002B
; ----------------------------------------------------------------------------
        .byte   "XA1DEC"
; ----------------------------------------------------------------------------
        .word   $0068
; ----------------------------------------------------------------------------
        .byte   "XA1IAY"
; ----------------------------------------------------------------------------
        .word   $0082
; ----------------------------------------------------------------------------
        .byte   "XA1MA2"
; ----------------------------------------------------------------------------
        .word   $006C
; ----------------------------------------------------------------------------
        .byte   "XA1PA2"
; ----------------------------------------------------------------------------
        .word   $006A
; ----------------------------------------------------------------------------
        .byte   "XA1XY "
; ----------------------------------------------------------------------------
        .word   $0083
; ----------------------------------------------------------------------------
        .byte   "XA2A1 "
; ----------------------------------------------------------------------------
        .word   $007F
; ----------------------------------------------------------------------------
        .byte   "XA2DA1"
; ----------------------------------------------------------------------------
        .word   $006D
; ----------------------------------------------------------------------------
        .byte   "XA2EA1"
; ----------------------------------------------------------------------------
        .word   $006E
; ----------------------------------------------------------------------------
        .byte   "XA2NA1"
; ----------------------------------------------------------------------------
        .word   $006B
; ----------------------------------------------------------------------------
        .byte   "XAA1  "
; ----------------------------------------------------------------------------
        .word   $0084
; ----------------------------------------------------------------------------
        .byte   "XABOX "
; ----------------------------------------------------------------------------
        .word   $0095
; ----------------------------------------------------------------------------
        .byte   "XADNXT"
; ----------------------------------------------------------------------------
        .word   $0085
; ----------------------------------------------------------------------------
        .byte   "XADRES"
; ----------------------------------------------------------------------------
        .word   $0022
; ----------------------------------------------------------------------------
        .byte   "XALLKB"
; ----------------------------------------------------------------------------
        .word   $0050
; ----------------------------------------------------------------------------
        .byte   "XAPPEN"
; ----------------------------------------------------------------------------
        .word   $FF26
; ----------------------------------------------------------------------------
        .byte   "XATN  "
; ----------------------------------------------------------------------------
        .word   $0073
; ----------------------------------------------------------------------------
        .byte   "XAYA1 "
; ----------------------------------------------------------------------------
        .word   $0081
; ----------------------------------------------------------------------------
        .byte   "XBINDX"
; ----------------------------------------------------------------------------
        .word   $0028
; ----------------------------------------------------------------------------
        .byte   "XBKP  "
; ----------------------------------------------------------------------------
        .word   $FF59
; ----------------------------------------------------------------------------
        .byte   "XBOX  "
; ----------------------------------------------------------------------------
        .word   $0094
; ----------------------------------------------------------------------------
        .byte   "XBUCA "
; ----------------------------------------------------------------------------
        .word   $FF86
; ----------------------------------------------------------------------------
        .byte   "XBUSY "
; ----------------------------------------------------------------------------
        .word   $005A
; ----------------------------------------------------------------------------
        .byte   "XCABU "
; ----------------------------------------------------------------------------
        .word   $FF83
; ----------------------------------------------------------------------------
        .byte   "XCHAR "
; ----------------------------------------------------------------------------
        .word   $0097
; ----------------------------------------------------------------------------
        .byte   "XCIRCL"
; ----------------------------------------------------------------------------
        .word   $008F
; ----------------------------------------------------------------------------
        .byte   "XCL0  "
; ----------------------------------------------------------------------------
        .word   $0004
; ----------------------------------------------------------------------------
        .byte   "XCL1  "
; ----------------------------------------------------------------------------
        .word   $0005
; ----------------------------------------------------------------------------
        .byte   "XCL2  "
; ----------------------------------------------------------------------------
        .word   $0006
; ----------------------------------------------------------------------------
        .byte   "XCL3  "
; ----------------------------------------------------------------------------
        .word   $0007
; ----------------------------------------------------------------------------
        .byte   "XCLCLK"
; ----------------------------------------------------------------------------
        .word   $003D
; ----------------------------------------------------------------------------
        .byte   "XCLOSE"
; ----------------------------------------------------------------------------
        .word   $FF1D
; ----------------------------------------------------------------------------
        .byte   "XCONSO"
; ----------------------------------------------------------------------------
        .word   $005D
; ----------------------------------------------------------------------------
        .byte   "XCOPY "
; ----------------------------------------------------------------------------
        .word   $FF38
; ----------------------------------------------------------------------------
        .byte   "XCOS  "
; ----------------------------------------------------------------------------
        .word   $0071
; ----------------------------------------------------------------------------
        .byte   "XCOSCR"
; ----------------------------------------------------------------------------
        .word   $0034
; ----------------------------------------------------------------------------
        .byte   "XCREAY"
; ----------------------------------------------------------------------------
        .word   $FF71
; ----------------------------------------------------------------------------
        .byte   "XCRLF "
; ----------------------------------------------------------------------------
        .word   $0025
; ----------------------------------------------------------------------------
        .byte   "XCSSCR"
; ----------------------------------------------------------------------------
        .word   $0035
; ----------------------------------------------------------------------------
        .byte   "XCURMO"
; ----------------------------------------------------------------------------
        .word   $0091
; ----------------------------------------------------------------------------
        .byte   "XCURSE"
; ----------------------------------------------------------------------------
        .word   $0090
; ----------------------------------------------------------------------------
        .byte   "XDECA1"
; ----------------------------------------------------------------------------
        .word   $0069
; ----------------------------------------------------------------------------
        .byte   "XDECAL"
; ----------------------------------------------------------------------------
        .word   $0018
; ----------------------------------------------------------------------------
        .byte   "XDECAY"
; ----------------------------------------------------------------------------
        .word   $0026
; ----------------------------------------------------------------------------
        .byte   "XDECIM"
; ----------------------------------------------------------------------------
        .word   $0029
; ----------------------------------------------------------------------------
        .byte   "XDECON"
; ----------------------------------------------------------------------------
        .word   $0065
; ----------------------------------------------------------------------------
        .byte   "XDEFBU"
; ----------------------------------------------------------------------------
        .word   $0059
; ----------------------------------------------------------------------------
        .byte   "XDEFLO"
; ----------------------------------------------------------------------------
        .word   $FF68
; ----------------------------------------------------------------------------
        .byte   "XDEFSA"
; ----------------------------------------------------------------------------
        .word   $FF65
; ----------------------------------------------------------------------------
        .byte   "XDEG  "
; ----------------------------------------------------------------------------
        .word   $007A
; ----------------------------------------------------------------------------
        .byte   "XDELBK"
; ----------------------------------------------------------------------------
        .word   $FF4A
; ----------------------------------------------------------------------------
        .byte   "XDELN "
; ----------------------------------------------------------------------------
        .word   $FF4D
; ----------------------------------------------------------------------------
        .byte   "XDETSE"
; ----------------------------------------------------------------------------
        .word   $FF74
; ----------------------------------------------------------------------------
        .byte   "XDIRN "
; ----------------------------------------------------------------------------
        .word   $FF56
; ----------------------------------------------------------------------------
        .byte   "XDIVIS"
; ----------------------------------------------------------------------------
        .word   $0023
; ----------------------------------------------------------------------------
        .byte   "XDNAME"
; ----------------------------------------------------------------------------
        .word   $FF3B
; ----------------------------------------------------------------------------
        .byte   "XDRAWA"
; ----------------------------------------------------------------------------
        .word   $008D
; ----------------------------------------------------------------------------
        .byte   "XDRAWR"
; ----------------------------------------------------------------------------
        .word   $008E
; ----------------------------------------------------------------------------
        .byte   "XECRBU"
; ----------------------------------------------------------------------------
        .word   $0054
; ----------------------------------------------------------------------------
        .byte   "XECRPR"
; ----------------------------------------------------------------------------
        .word   $0033
; ----------------------------------------------------------------------------
        .byte   "XEDT  "
; ----------------------------------------------------------------------------
        .word   $002D
; ----------------------------------------------------------------------------
        .byte   "XEDTIN"
; ----------------------------------------------------------------------------
        .word   $0032
; ----------------------------------------------------------------------------
        .byte   "XEFFHI"
; ----------------------------------------------------------------------------
        .word   $001B
; ----------------------------------------------------------------------------
        .byte   "XEPSG "
; ----------------------------------------------------------------------------
        .word   $0041
; ----------------------------------------------------------------------------
        .byte   "XERREU"
; ----------------------------------------------------------------------------
        .word   $FF5F
; ----------------------------------------------------------------------------
        .byte   "XERVEC"
; ----------------------------------------------------------------------------
        .word   $FF32
; ----------------------------------------------------------------------------
        .byte   "XESAVE"
; ----------------------------------------------------------------------------
        .word   $FF35
; ----------------------------------------------------------------------------
        .byte   "XEXP  "
; ----------------------------------------------------------------------------
        .word   $0074
; ----------------------------------------------------------------------------
        .byte   "XEXPLO"
; ----------------------------------------------------------------------------
        .word   $009C
; ----------------------------------------------------------------------------
        .byte   "XFIELD"
; ----------------------------------------------------------------------------
        .word   $054C
; ----------------------------------------------------------------------------
        .byte   "XFILL "
; ----------------------------------------------------------------------------
        .word   $0096
; ----------------------------------------------------------------------------
        .byte   "XFILLM"
; ----------------------------------------------------------------------------
        .word   $001C
; ----------------------------------------------------------------------------
        .byte   "XFORMA"
; ----------------------------------------------------------------------------
        .word   $FF44
; ----------------------------------------------------------------------------
        .byte   "XFST  "
; ----------------------------------------------------------------------------
        .word   $FF11
; ----------------------------------------------------------------------------
        .byte   "XGOKBD"
; ----------------------------------------------------------------------------
        .word   $0052
; ----------------------------------------------------------------------------
        .byte   "XHCHRS"
; ----------------------------------------------------------------------------
        .word   $004C
; ----------------------------------------------------------------------------
        .byte   "XHCSCR"
; ----------------------------------------------------------------------------
        .word   $004A
; ----------------------------------------------------------------------------
        .byte   "XHCVDT"
; ----------------------------------------------------------------------------
        .word   $004B
; ----------------------------------------------------------------------------
        .byte   "XHEXA "
; ----------------------------------------------------------------------------
        .word   $002A
; ----------------------------------------------------------------------------
        .byte   "XHIRES"
; ----------------------------------------------------------------------------
        .word   $001A
; ----------------------------------------------------------------------------
        .byte   "XHRSSE"
; ----------------------------------------------------------------------------
        .word   $008C
; ----------------------------------------------------------------------------
        .byte   "XINIBU"
; ----------------------------------------------------------------------------
        .word   $0058
; ----------------------------------------------------------------------------
        .byte   "XINITI"
; ----------------------------------------------------------------------------
        .word   $FF5C
; ----------------------------------------------------------------------------
        .byte   "XINK  "
; ----------------------------------------------------------------------------
        .word   $0093
; ----------------------------------------------------------------------------
        .byte   "XINSER"
; ----------------------------------------------------------------------------
        .word   $002E
; ----------------------------------------------------------------------------
        .byte   "XINT  "
; ----------------------------------------------------------------------------
        .word   $007B
; ----------------------------------------------------------------------------
        .byte   "XINTEG"
; ----------------------------------------------------------------------------
        .word   $0086
; ----------------------------------------------------------------------------
        .byte   "XIYAA1"
; ----------------------------------------------------------------------------
        .word   $0080
; ----------------------------------------------------------------------------
        .byte   "XJUMP "
; ----------------------------------------------------------------------------
        .word   $FF2C
; ----------------------------------------------------------------------------
        .byte   "XKBD  "
; ----------------------------------------------------------------------------
        .word   $0080
; ----------------------------------------------------------------------------
        .byte   "XKBDAS"
; ----------------------------------------------------------------------------
        .word   $0051
; ----------------------------------------------------------------------------
        .byte   "XLGBUF"
; ----------------------------------------------------------------------------
        .word   $FF2F
; ----------------------------------------------------------------------------
        .byte   "XLIBSE"
; ----------------------------------------------------------------------------
        .word   $FF77
; ----------------------------------------------------------------------------
        .byte   "XLIGNE"
; ----------------------------------------------------------------------------
        .word   $0064
; ----------------------------------------------------------------------------
        .byte   "XLISBU"
; ----------------------------------------------------------------------------
        .word   $0055
; ----------------------------------------------------------------------------
        .byte   "XLN   "
; ----------------------------------------------------------------------------
        .word   $0075
; ----------------------------------------------------------------------------
        .byte   "XLOAD "
; ----------------------------------------------------------------------------
        .word   $FF62
; ----------------------------------------------------------------------------
        .byte   "XLOG  "
; ----------------------------------------------------------------------------
        .word   $0076
; ----------------------------------------------------------------------------
        .byte   "XLPCRL"
; ----------------------------------------------------------------------------
        .word   $0049
; ----------------------------------------------------------------------------
        .byte   "XLPR  "
; ----------------------------------------------------------------------------
        .word   $008E
; ----------------------------------------------------------------------------
        .byte   "XLPRBI"
; ----------------------------------------------------------------------------
        .word   $0048
; ----------------------------------------------------------------------------
        .byte   "XMDE  "
; ----------------------------------------------------------------------------
        .word   $0082
; ----------------------------------------------------------------------------
        .byte   "XMDS  "
; ----------------------------------------------------------------------------
        .word   $008F
; ----------------------------------------------------------------------------
        .byte   "XMENU "
; ----------------------------------------------------------------------------
        .word   $002C
; ----------------------------------------------------------------------------
        .byte   "XMERGE"
; ----------------------------------------------------------------------------
        .word   $FF0E
; ----------------------------------------------------------------------------
        .byte   "XMIE  "
; ----------------------------------------------------------------------------
        .word   $0084
; ----------------------------------------------------------------------------
        .byte   "XMINMA"
; ----------------------------------------------------------------------------
        .word   $001F
; ----------------------------------------------------------------------------
        .byte   "XMIS  "
; ----------------------------------------------------------------------------
        .word   $008C
; ----------------------------------------------------------------------------
        .byte   "XMLOAD"
; ----------------------------------------------------------------------------
        .word   $0060
; ----------------------------------------------------------------------------
        .byte   "XMOUT "
; ----------------------------------------------------------------------------
        .word   $0066
; ----------------------------------------------------------------------------
        .byte   "XMSAVE"
; ----------------------------------------------------------------------------
        .word   $0061
; ----------------------------------------------------------------------------
        .byte   "XMUL40"
; ----------------------------------------------------------------------------
        .word   $0020
; ----------------------------------------------------------------------------
        .byte   "XMULT "
; ----------------------------------------------------------------------------
        .word   $0021
; ----------------------------------------------------------------------------
        .byte   "XMUSIC"
; ----------------------------------------------------------------------------
        .word   $0045
; ----------------------------------------------------------------------------
        .byte   "XNA1  "
; ----------------------------------------------------------------------------
        .word   $006F
; ----------------------------------------------------------------------------
        .byte   "XNOMDE"
; ----------------------------------------------------------------------------
        .word   $FF6E
; ----------------------------------------------------------------------------
        .byte   "XNOMFI"
; ----------------------------------------------------------------------------
        .word   $0024
; ----------------------------------------------------------------------------
        .byte   "XOP0  "
; ----------------------------------------------------------------------------
        .word   $0000
; ----------------------------------------------------------------------------
        .byte   "XOP1  "
; ----------------------------------------------------------------------------
        .word   $0001
; ----------------------------------------------------------------------------
        .byte   "XOP2  "
; ----------------------------------------------------------------------------
        .word   $0002
; ----------------------------------------------------------------------------
        .byte   "XOP3  "
; ----------------------------------------------------------------------------
        .word   $0003
; ----------------------------------------------------------------------------
        .byte   "XOPEN "
; ----------------------------------------------------------------------------
        .word   $FF1A
; ----------------------------------------------------------------------------
        .byte   "XOUPS "
; ----------------------------------------------------------------------------
        .word   $0042
; ----------------------------------------------------------------------------
        .byte   "XPAPER"
; ----------------------------------------------------------------------------
        .word   $0092
; ----------------------------------------------------------------------------
        .byte   "XPBUF1"
; ----------------------------------------------------------------------------
        .word   $FFA4
; ----------------------------------------------------------------------------
        .byte   "XPI   "
; ----------------------------------------------------------------------------
        .word   $007C
; ----------------------------------------------------------------------------
        .byte   "XPING "
; ----------------------------------------------------------------------------
        .word   $009D
; ----------------------------------------------------------------------------
        .byte   "XPLAY "
; ----------------------------------------------------------------------------
        .word   $0043
; ----------------------------------------------------------------------------
        .byte   "XPMAP "
; ----------------------------------------------------------------------------
        .word   $FFA7
; ----------------------------------------------------------------------------
        .byte   "XPROT "
; ----------------------------------------------------------------------------
        .word   $FF50
; ----------------------------------------------------------------------------
        .byte   "XPRSEC"
; ----------------------------------------------------------------------------
        .word   $FFA1
; ----------------------------------------------------------------------------
        .byte   "XPUT  "
; ----------------------------------------------------------------------------
        .word   $FF23
; ----------------------------------------------------------------------------
        .byte   "XRAD  "
; ----------------------------------------------------------------------------
        .word   $0079
; ----------------------------------------------------------------------------
        .byte   "XRAND "
; ----------------------------------------------------------------------------
        .word   $007D
; ----------------------------------------------------------------------------
        .byte   "XRD0  "
; ----------------------------------------------------------------------------
        .word   $0008
; ----------------------------------------------------------------------------
        .byte   "XRD1  "
; ----------------------------------------------------------------------------
        .word   $0009
; ----------------------------------------------------------------------------
        .byte   "XRD2  "
; ----------------------------------------------------------------------------
        .word   $000A
; ----------------------------------------------------------------------------
        .byte   "XRD3  "
; ----------------------------------------------------------------------------
        .word   $000B
; ----------------------------------------------------------------------------
        .byte   "XRDW0 "
; ----------------------------------------------------------------------------
        .word   $000C
; ----------------------------------------------------------------------------
        .byte   "XRDW1 "
; ----------------------------------------------------------------------------
        .word   $000D
; ----------------------------------------------------------------------------
        .byte   "XRDW2 "
; ----------------------------------------------------------------------------
        .word   $000E
; ----------------------------------------------------------------------------
        .byte   "XRDW3 "
; ----------------------------------------------------------------------------
        .word   $000F
; ----------------------------------------------------------------------------
        .byte   "XREN  "
; ----------------------------------------------------------------------------
        .word   $FF47
; ----------------------------------------------------------------------------
        .byte   "XREWIN"
; ----------------------------------------------------------------------------
        .word   $FF29
; ----------------------------------------------------------------------------
        .byte   "XRING "
; ----------------------------------------------------------------------------
        .word   $0062
; ----------------------------------------------------------------------------
        .byte   "XRND  "
; ----------------------------------------------------------------------------
        .word   $0077
; ----------------------------------------------------------------------------
        .byte   "XRSE  "
; ----------------------------------------------------------------------------
        .word   $0083
; ----------------------------------------------------------------------------
        .byte   "XRSS  "
; ----------------------------------------------------------------------------
        .word   $0090
; ----------------------------------------------------------------------------
        .byte   "XRWTS "
; ----------------------------------------------------------------------------
        .word   $FFAA
; ----------------------------------------------------------------------------
        .byte   "XSAVE "
; ----------------------------------------------------------------------------
        .word   $FF6B
; ----------------------------------------------------------------------------
        .byte   "XSAY  "
; ----------------------------------------------------------------------------
        .word   $FF8F
; ----------------------------------------------------------------------------
        .byte   "XSBUF1"
; ----------------------------------------------------------------------------
        .word   $FF92
; ----------------------------------------------------------------------------
        .byte   "XSBUF2"
; ----------------------------------------------------------------------------
        .word   $FF95
; ----------------------------------------------------------------------------
        .byte   "XSBUF3"
; ----------------------------------------------------------------------------
        .word   $FF98
; ----------------------------------------------------------------------------
        .byte   "XSC1  "
; ----------------------------------------------------------------------------
        .word   $0089
; ----------------------------------------------------------------------------
        .byte   "XSC2  "
; ----------------------------------------------------------------------------
        .word   $008A
; ----------------------------------------------------------------------------
        .byte   "XSC3  "
; ----------------------------------------------------------------------------
        .word   $008B
; ----------------------------------------------------------------------------
        .byte   "XSCAT "
; ----------------------------------------------------------------------------
        .word   $FF9B
; ----------------------------------------------------------------------------
        .byte   "XSCELG"
; ----------------------------------------------------------------------------
        .word   $002F
; ----------------------------------------------------------------------------
        .byte   "XSCHAR"
; ----------------------------------------------------------------------------
        .word   $0098
; ----------------------------------------------------------------------------
        .byte   "XSCR  "
; ----------------------------------------------------------------------------
        .word   $0088
; ----------------------------------------------------------------------------
        .byte   "XSCRNE"
; ----------------------------------------------------------------------------
        .word   $0039
; ----------------------------------------------------------------------------
        .byte   "XSCROB"
; ----------------------------------------------------------------------------
        .word   $0038
; ----------------------------------------------------------------------------
        .byte   "XSCROH"
; ----------------------------------------------------------------------------
        .word   $0037
; ----------------------------------------------------------------------------
        .byte   "XSCRSE"
; ----------------------------------------------------------------------------
        .word   $0036
; ----------------------------------------------------------------------------
        .byte   "XSDUMP"
; ----------------------------------------------------------------------------
        .word   $005C
; ----------------------------------------------------------------------------
        .byte   "XSHOOT"
; ----------------------------------------------------------------------------
        .word   $0047
; ----------------------------------------------------------------------------
        .byte   "XSIN  "
; ----------------------------------------------------------------------------
        .word   $0070
; ----------------------------------------------------------------------------
        .byte   "XSLOAD"
; ----------------------------------------------------------------------------
        .word   $005E
; ----------------------------------------------------------------------------
        .byte   "XSONPS"
; ----------------------------------------------------------------------------
        .word   $0040
; ----------------------------------------------------------------------------
        .byte   "XSOUND"
; ----------------------------------------------------------------------------
        .word   $0044
; ----------------------------------------------------------------------------
        .byte   "XSOUT "
; ----------------------------------------------------------------------------
        .word   $0067
; ----------------------------------------------------------------------------
        .byte   "XSPUT "
; ----------------------------------------------------------------------------
        .word   $FF14
; ----------------------------------------------------------------------------
        .byte   "XSQR  "
; ----------------------------------------------------------------------------
        .word   $0078
; ----------------------------------------------------------------------------
        .byte   "XSSAVE"
; ----------------------------------------------------------------------------
        .word   $005F
; ----------------------------------------------------------------------------
        .byte   "XSTAKE"
; ----------------------------------------------------------------------------
        .word   $FF17
; ----------------------------------------------------------------------------
        .byte   "XSTATU"
; ----------------------------------------------------------------------------
        .word   $FF3E
; ----------------------------------------------------------------------------
        .byte   "XSVSEC"
; ----------------------------------------------------------------------------
        .word   $FF8C
; ----------------------------------------------------------------------------
        .byte   "XTAKE "
; ----------------------------------------------------------------------------
        .word   $FF20
; ----------------------------------------------------------------------------
        .byte   "XTAN  "
; ----------------------------------------------------------------------------
        .word   $0072
; ----------------------------------------------------------------------------
        .byte   "XTEXT "
; ----------------------------------------------------------------------------
        .word   $0019
; ----------------------------------------------------------------------------
        .byte   "XTRVCA"
; ----------------------------------------------------------------------------
        .word   $FF7A
; ----------------------------------------------------------------------------
        .byte   "XTRVNM"
; ----------------------------------------------------------------------------
        .word   $FF7D
; ----------------------------------------------------------------------------
        .byte   "XTRVNX"
; ----------------------------------------------------------------------------
        .word   $FF80
; ----------------------------------------------------------------------------
        .byte   "XTSTBU"
; ----------------------------------------------------------------------------
        .word   $0056
; ----------------------------------------------------------------------------
        .byte   "XTSTLP"
; ----------------------------------------------------------------------------
        .word   $001E
; ----------------------------------------------------------------------------
        .byte   "XUNPRO"
; ----------------------------------------------------------------------------
        .word   $FF53
; ----------------------------------------------------------------------------
        .byte   "XUPDAT"
; ----------------------------------------------------------------------------
        .word   $FF41
; ----------------------------------------------------------------------------
        .byte   "XUS1  "
; ----------------------------------------------------------------------------
        .word   $0086
; ----------------------------------------------------------------------------
        .byte   "XUS2  "
; ----------------------------------------------------------------------------
        .word   $0087
; ----------------------------------------------------------------------------
        .byte   "XUS3  "
; ----------------------------------------------------------------------------
        .word   $0094
; ----------------------------------------------------------------------------
        .byte   "XUS4  "
; ----------------------------------------------------------------------------
        .word   $0095
; ----------------------------------------------------------------------------
        .byte   "XUS6  "
; ----------------------------------------------------------------------------
        .word   $0096
; ----------------------------------------------------------------------------
        .byte   "XUS7  "
; ----------------------------------------------------------------------------
        .word   $0097
; ----------------------------------------------------------------------------
        .byte   "XVBUF1"
; ----------------------------------------------------------------------------
        .word   $FF89
; ----------------------------------------------------------------------------
        .byte   "XVDT  "
; ----------------------------------------------------------------------------
        .word   $0091
; ----------------------------------------------------------------------------
        .byte   "XVIDBU"
; ----------------------------------------------------------------------------
        .word   $0057
; ----------------------------------------------------------------------------
        .byte   "XWCXFI"
; ----------------------------------------------------------------------------
        .word   $0063
; ----------------------------------------------------------------------------
        .byte   "XWR0  "
; ----------------------------------------------------------------------------
        .word   $0010
; ----------------------------------------------------------------------------
        .byte   "XWR1  "
; ----------------------------------------------------------------------------
        .word   $0011
; ----------------------------------------------------------------------------
        .byte   "XWR2  "
; ----------------------------------------------------------------------------
        .word   $0012
; ----------------------------------------------------------------------------
        .byte   "XWR3  "
; ----------------------------------------------------------------------------
        .word   $0013
; ----------------------------------------------------------------------------
        .byte   "XWRCLK"
; ----------------------------------------------------------------------------
        .word   $003E
; ----------------------------------------------------------------------------
        .byte   "XWSTR0"
; ----------------------------------------------------------------------------
        .word   $0014
; ----------------------------------------------------------------------------
        .byte   "XWSTR1"
; ----------------------------------------------------------------------------
        .word   $0015
; ----------------------------------------------------------------------------
        .byte   "XWSTR2"
; ----------------------------------------------------------------------------
        .word   $0016
; ----------------------------------------------------------------------------
        .byte   "XWSTR3"
; ----------------------------------------------------------------------------
        .word   $0017
; ----------------------------------------------------------------------------
        .byte   "XZAP  "
; ----------------------------------------------------------------------------
        .word   $0046
; ----------------------------------------------------------------------------
        .byte   "ZADCHA"
; ----------------------------------------------------------------------------
        .word   $001D
; ----------------------------------------------------------------------------
SymbolTableEnd:
        .byte   $00
; Copyrights
teleass_signature:
        .byte   "TELEASS V1.0a"

        .byte   $0A,$0D
        .byte   "(c) 1987 ORIC International"



        .byte   $0A,$0D,$0A,$0D,$00
; ----------------------------------------------------------------------------
; Copyrights address
signature_address:
        .word   teleass_signature
; ----------------------------------------------------------------------------
; Version + ROM Type
ROMDEF: .byte   $0A,$EF
; ----------------------------------------------------------------------------
; RESET
teleass_reset:
        .word   teleass_start
; ----------------------------------------------------------------------------
; IRQ Vector
teleass_irq_vector:
        .word   $02FA
