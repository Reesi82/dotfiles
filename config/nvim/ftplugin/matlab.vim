setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal foldmethod=manual

" Octave tmux integration
let g:ScreenImpl = "Tmux"
" Open an Octavee shell.
noremap <buffer> <LocalLeader>p :ScreenShell octave-cli<CR>
" Close whichever shell is running.
noremap <buffer> <LocalLeader>q :ScreenQuit<CR>
" Send current line to octave and move to next line.
noremap <buffer> <LocalLeader>b V:ScreenSend<CR>j
" Send visual selection to octave and move to next line.
noremap <buffer> <LocalLeader>v :ScreenSend<CR>`>0j
" Send file to octave
noremap <buffer> <LocalLeader>f maggVG:ScreenSend<CR>`a
"Run File
nnoremap <buffer> <F5>
                        \ :call g:ScreenShellSend(expand('%:r'))<CR>
nnoremap <buffer> <LocalLeader>r
                        \ :call g:ScreenShellSend(expand('%:r'))<CR>

" Send a <CR> to octave.
noremap <buffer> <LocalLeader>a :call g:ScreenShellSend("\r")<CR>

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
