" Vim global plugin for selecting inner type objects
" Last Change:	Tue Feb  1 17:23:33 SAST 2022
" Maintainer:	Boyd Kane <boydrkane@gmail.com>
" License:	    This file is licensed under the GNU-GPLv3 license

" Only load the script once
if exists("g:loaded_select_inner")
    finish
endif
let g:loaded_select_inner = 1

" Use compatibility mode, but only for this file. Save the current state of
" compatability mode for later
let s:save_cpo = &cpo
set cpo&vim

" Only define the <Plug>select_inner_a mapping if the user hasn't already
" specified a mapping like:
" ``` map ,c  <Plug>select_inner_a ```
" or similar in their vimrc
if !hasmapto('<Plug>select_inner_a')
    " In visual mode map A{ to a command called `<Plug>select_inner_a`. Raise an error
    " if this mapping of `A{` isn't unique
    vmap <unique> A{  <Plug>select_inner_a
endif

if !hasmapto('<Plug>select_inner_a')
    map <unique> <Leader>a  <Plug>select_inner_a
endif
noremap <unique> <script> <Plug>select_inner_a  <SID>Add

noremenu <script> Plugin.Add\ Correction      <SID>Add

noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>

function s:Add(from, correct)
    let to = input("type the correction for " . a:from . ": ")
    exe ":iabbrev " . a:from . " " . to
    if a:correct | exe "normal viws\<C-R>\" \b\e" | endif
    let s:count = s:count + 1
    echo s:count . " corrections now"
endfunction

if !exists(":Correct")
    command -nargs=1  Correct  :call s:Add(<q-args>, 0)
endif

" Set compatibility mode to how it was when the script was called
let &cpo = s:save_cpo

