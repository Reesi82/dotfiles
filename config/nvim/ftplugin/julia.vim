setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal foldmethod=manual

" Julia tmux integration
let g:ScreenImpl = "Tmux"
" Open an Julia shell.
noremap <buffer> <LocalLeader>p :ScreenShell julia<CR>
" Close whichever shell is running.
noremap <buffer> <LocalLeader>q :ScreenQuit<CR>
" Send current line to python and move to next line.
noremap <buffer> <LocalLeader>b V:ScreenSend<CR>j
" Send visual selection to python and move to next line.
noremap <buffer> <LocalLeader>v :ScreenSend<CR>`>0j
" Send a <CR> to ipython.
noremap <buffer> <LocalLeader>a :call g:ScreenShellSend("\r")<CR>
" Print the current working directory.
noremap <buffer> <LocalLeader>gw
                        \ :call g:ScreenShellSend('pwd()')<CR>
" Set working directory to current file's folder.
function! SetWD()
        let wd = 'cd("' . expand('%:p:h') . '")'
        :call g:ScreenShellSend(wd)
endfunction
noremap <buffer> <LocalLeader>sw :call SetWD()<CR>

" run file
nnoremap <buffer> <leader>v :silent exec '!julia' shellescape(@%, 1)<cr>
nnoremap <buffer> <F5>
                        \ :call g:ScreenShellSend('include("'.expand('%:t').'")')<CR>
