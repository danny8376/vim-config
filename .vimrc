set backspace=eol,start,indent
set cindent
set enc=utf-8
set encoding=utf-8
set fileencoding=utf-8
set hls
set nocompatible
set sw=2
set guifontset=8x16,kc15f,-*-16-*-big5-0

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

filetype plugin indent on
syntax on
highlight Comment ctermfg=darkcyan
highlight Search term=reverse ctermbg=4 ctermfg=7

set pastetoggle=<f5>



" some special config for git (?
au BufNewFile,BufRead */.git/config set noexpandtab

" liquidsoap
au BufRead,BufNewFile *.liq set filetype=liquidsoap

" some special config for bind
" first 3 => my unbutu conf, 1 => CentOS, 1 => freebsd
au BufNewFile,BufRead /etc/bind/master/*,/var/lib/bind/*,/var/named/*,/etc/named*,/etc/namedb/* call s:BindzoneCheckOwO()
au BufNewFile,BufRead */named/db.*,*/bind/db.*  call s:StarSetfOwO()
au BufNewFile,BufRead named.root        set syntax=bindzone noexpandtab tabstop=8 shiftwidth=8
au BufNewFile,BufRead *.db          call s:BindzoneCheckOwO()
func! s:BindzoneCheckOwO()
  if getline(1).getline(2).getline(3).getline(4) =~ '^; <<>> DiG [0-9.]\+ <<>>\|BIND.*named\|$ORIGIN\|$TTL\|IN\s\+SOA'
    set syntax=bindzone noexpandtab tabstop=8 shiftwidth=8
  endif
endfunc
func! s:StarSetfOwO()
  if expand("<amatch>") !~ g:ft_ignore_pat
    set syntax=bindzone noexpandtab tabstop=8 shiftwidth=8
  endif
endfunc
" config for postfix
au BufNewFile,BufRead /etc/postfix/* set noexpandtab tabstop=8 shiftwidth=8


" Smart HOME
nmap <silent><Home> :call SmartHome("n")<CR>
imap <silent><Home> <C-r>=SmartHome("i")<CR>
vmap <silent><Home> <Esc>:call SmartHome("v")<CR>
" Home Key for putty......
nmap <silent><Esc>[1~ :call SmartHome("n")<CR>
imap <silent><Esc>[1~ <C-r>=SmartHome("i")<CR>
vmap <silent><Esc>[1~ <Esc>:call SmartHome("v")<CR>

function SmartHome(mode)
  let curcol = col(".")
  "gravitate towards beginning for wrapped lines
  if curcol > indent(".") + 2
    call cursor(0, curcol - 1)
  endif
  if curcol == 1 || curcol > indent(".") + 1
    if &wrap
      normal g^
    else
      normal ^
    endif
  else
    if &wrap
      normal g0
    else
      normal 0
    endif
  endif
  if a:mode == "v"
    normal msgv`s
  endif
  return ""
endfunction
