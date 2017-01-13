au bufnewfile,bufread *.r setlocal tabstop=4
au bufnewfile,bufread *.r setlocal softtabstop=4
au bufnewfile,bufread *.r setlocal shiftwidth=4
au bufnewfile,bufread *.r setlocal textwidth=79
au bufnewfile,bufread *.r setlocal expandtab
au bufnewfile,bufread *.r setlocal autoindent
au bufnewfile,bufread *.r setlocal fileformat=unix
au bufnewfile,bufread *.r setlocal foldmethod=manual


" " octave tmux integration
" let g:screenimpl = "tmux"
" " open an octavee shell.
" noremap <buffer> <localleader>p :ScreenShell R<cr>
" " close whichever shell is running.
" noremap <buffer> <localleader>q :ScreenQuit<cr>
" " send current line to octave and move to next line.
" noremap <buffer> <localleader>b V:ScreenSend<cr>j
" " send visual selection to octave and move to next line.
" noremap <buffer> <localleader>v :ScreenSend<cr>`>0j
" " send file to octave
" noremap <buffer> <localleader>f maggvg:ScreenSend<cr>`a
" "run file
" nnoremap <buffer> <f5>
                        " \ :call g:ScreenShellSend('source("'.expand('%:t').'", print.eval=TRUE)')<cr>

" " send a <cr> to octave.
" noremap <buffer> <localleader>a :call g:ScreenShellSend("\r")<cr>

" "   misc functinons
" " gets the selected text in visual mode
" function! GetVisual()
        " " Why is this not a built-in Vim script function?!
        " let [lnum1, col1] = getpos("'<")[1:2]
        " let [lnum2, col2] = getpos("'>")[1:2]
        " let lines = getline(lnum1, lnum2)
        " let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
        " let lines[0] = lines[0][col1 - 1:]
        " return join(lines, "\n")
" endfunction
