" Vim syntax file
" Language:	MOS 65816 assembler
" By: Dagen Brock <dagenbrock@gmail.com>
" Creation date: 2012-11-25
" Version 0.01
" See README for original attribution and

" Remove any old syntax stuff hanging about
syn clear
syn case ignore
"
" registers
syn keyword asm65Reg x y a

" opcodes:

syn keyword asm65Op  adc and asl bit brk clc cld cli clv cmp cpx cpy dec dex dey eor inc inx iny  lda ldx ldy lsr nop ora pha php pla plp rol ror rti rts sbc sec sed sei sta stx sty tax tay tsx txa txs tya 
syn keyword asm65c02Op phx plx phy ply stz trb tsb 
syn keyword asm65816Op cop mvn mvp pea pei per phb phd phk plb pld rep rtl sep stp tcd tcs tdc tsc txy tyx wai wdm xba xbc ldal stal jmpl cmpl

syn keyword asm65Branch bcc bcs beq bmi bne bpl bvc bvs jmp jsr
" blt/bge/etc are really a merlin equivalents... maybe change to its own thing, but it's fine here for now
syn keyword asm65c02Branch bra blt bge tda tad swa tsa tas
syn keyword asm65816Branch brl 

" Atari 800XL 'Sally' undocumented opcodes
" mnemonics taken from Trevin Beattie's 'Atari Technical Information' page
" at "http://www.xmission.com/~trevin/atari/atari.shtml"
syn keyword asmSallyUndoc anc arr asr asx ax7 axe brk dcp jam las lax rla rra sax slo sre sx7 sy7 xea xs7
" IF YOU ARE DOING ATARI, UNCOMMENT THIS.  IT IS COMMENTED OUT SO THAT IT
" DOESN'T CONFLICT WITH THE 65816 RULES ABOVE.
"syn keyword asmSallyUndoc php

" Merlin 8/16 pseudo ops and commands
syn keyword asmMerlinPseudoOps mx mac eom pmc <<< >>> 
syn keyword asmMerlinSettings xc typ lst equz equ dw asc ds db da dw ddb dfb adr adrl hex str rev fls inv dci tr skp ttl pag lstdo dat cyc ast dum dend dsk var use obj rel exp dfb sav do fin kbd err chk if else ent ext

syn match asmLabel		"^[a-z_][a-z0-9_]*"
syn match asmComment		";.*$" contains=asmTodo
syn match asmComment		"^\*.*$" contains=asmTodo
syn match asmMerlinLocal ":[a-z_][a-z0-9_]*"
syn match asmMerlinVariable "][a-z_][a-z0-9_]*"
syn keyword asmTodo	contained todo fixme xxx warning danger note notice bug author date
syn region asmString		start=+"+ skip=+\\"+ end=+"+
syn keyword asmSettings		opt org typ

syn match decNumber	"\<\d\+\>"
syn match hexNumber	"\$\x\+\>" " 'bug', but adding \< doesn't behave!
syn match binNumber	"%[01]\+\>" 
syn match asmImmediate	"#\$\x\+\>"
syn match asmImmediate	"#\d\+\>"
syn match asmImmediate	"<\$\x\+\>"
syn match asmImmediate	"<\d\+\>"
syn match asmImmediate	">\$\x\+\>"
syn match asmImmediate	">\d\+\>"
syn match asmImmediate	"#<\$\x\+\>"
syn match asmImmediate	"#<\d\+\>"
syn match asmImmediate	"#>\$\x\+\>"
syn match asmImmediate	"#>\d\+\>"

"
"syn case match
if !exists("did_asm65_syntax_inits")
  let did_rgb_asm_syntax_inits = 1

  " The default methods for highlighting.  Can be overridden later
  hi link asmLabel	Label
  hi link asmString	String
  hi link asmComment	Comment
  hi link asmSettings	Statement
  hi link asmMerlinSettings	Statement
  hi link asm65Op Statement
  hi link asm65c02Op Statement
  hi link asm65816Op Statement
  hi link asmSallyUndoc Special
  hi link asmMerlinPseudoOps Special
  hi link asmMerlinLocal Function 
  hi link asmMerlinVariable Type 
  hi link asm65Reg Identifier
  hi link asm65Branch Conditional
  hi link asm65c02Branch Conditional
  hi link asm65816Branch Conditional
  hi link asmTodo Debug

  hi link asmImmediate Special

  hi link hexNumber	Number
  hi link binNumber	Number
  hi link decNumber	Number

  hi asmLabel ctermfg=lightcyan
  " My default color overrides:
"  hi asmSpecialComment ctermfg=red
"  hi asmIdentifier ctermfg=lightcyan
"  hi asmType ctermbg=black ctermfg=brown

endif

let b:current_syntax = "asm65816"
au BufNewFile,BufRead *.S setf asm65816

