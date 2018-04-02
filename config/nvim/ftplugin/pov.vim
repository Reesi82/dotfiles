" IPython3 tmux integration
let g:ScreenImpl = "Tmux"
" Open a shell.
noremap <buffer> <LocalLeader>p :ScreenShell<CR>
" Close whichever shell is running.
noremap <buffer> <LocalLeader>q :ScreenQuit<CR>
" Set working directory to current file's folder.
function! SetWD()
        let wd = '!cd ' . expand('%:p:h')
        :call g:ScreenShellSend(wd)
endfunction
noremap <buffer> <LocalLeader>sw :call SetWD()<CR>
" Get ipython help for word under cursor. Complement it with Shift + K.
function! GetHelp()
        let w = expand("<cword>") . "??"
        :call g:ScreenShellSend(w)
endfunction
noremap <buffer> <LocalLeader>h :call GetHelp()<CR>
" Get `dir` help for word under cursor.
function! GetDir()
        let w = "dir(" . expand("<cword>") . ")"
        :call g:ScreenShellSend(w)
endfunction
noremap <buffer> <LocalLeader>d :call GetDir()<CR>

" Get len help for word under cursor.
function! GetLen()
        let w = "len(" . expand("<cword>") . ")"
        :call g:ScreenShellSend(w)
        echo  w
endfunction
noremap <buffer> <LocalLeader>l :call GetLen()<CR>
"
nnoremap <buffer> <F5>
                        \ :call g:ScreenShellSend("povray ".expand('%:t'))<CR>

nnoremap <buffer> <F6>
                        \ :call g:ScreenShellSend("povray ".expand('%:r'."ini"))<CR>
"   misc functinons
" gets the selected text in visual mode
function! GetVisual()
        " Why is this not a built-in Vim script function?!
        let [lnum1, col1] = getpos("'<")[1:2]
        let [lnum2, col2] = getpos("'>")[1:2]
        let lines = getline(lnum1, lnum2)
        let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
        let lines[0] = lines[0][col1 - 1:]
        return join(lines, "\n")
endfunction
