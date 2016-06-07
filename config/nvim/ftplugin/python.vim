au BufNewFile,BufRead *.py setlocal tabstop=4
    
au BufNewFile,BufRead *.py setlocal softtabstop=4
    
au BufNewFile,BufRead *.py setlocal shiftwidth=4
    
au BufNewFile,BufRead *.py setlocal textwidth=79
    
au BufNewFile,BufRead *.py setlocal expandtab
    
au BufNewFile,BufRead *.py setlocal autoindent
    
au BufNewFile,BufRead *.py setlocal fileformat=unix
    
au BufNewFile,BufRead *.py setlocal foldmethod=indent

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" IPython3 tmux integration
let g:ScreenImpl = "Tmux"
" Open an IPython3 shell.
noremap <buffer> <LocalLeader>p :IPython<CR>
" Close whichever shell is running.
noremap <buffer> <LocalLeader>q :ScreenQuit<CR>
" Send current line to python and move to next line.
noremap <buffer> <LocalLeader>b V:ScreenSend<CR>j
" Send visual selection to python and move to next line.
noremap <buffer> <LocalLeader>v :ScreenSend<CR>`>0j
" Send a <CR> to ipython.
noremap <buffer> <LocalLeader>a :call g:ScreenShellSend("\r")<CR>
" Clear the screen.
noremap <buffer> <LocalLeader>L
                        \ :call g:ScreenShellSend('!clear')<CR>
" Start a time  block to execute code in.
noremap <buffer> <LocalLeader>t
                        \ :call g:ScreenShellSend('%%time')<CR>
" Start a timeit block to execute code in.
noremap <buffer> <LocalLeader>tt
                        \ :call g:ScreenShellSend('%%timeit')<CR>
" Start a debugger repl to execute code in.
noremap <buffer> <LocalLeader>db
                        \ :call g:ScreenShellSend('%%debug')<CR>
" Start a profiling block to execute code in.
noremap <buffer> <LocalLeader>pr
                        \ :call g:ScreenShellSend('%%prun')<CR>
" Print the current working directory.
noremap <buffer> <LocalLeader>gw
                        \ :call g:ScreenShellSend('!pwd')<CR>
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
" Get `?` help for visual selected word.
function! GetHelpMagic()
        let foo_tmp =  GetVisual()
        let w = "?".foo_tmp
        :call g:ScreenShellSend(w)
endfunction
noremap <buffer> <LocalLeader>dc :call GetHelpMagic()<CR>

" Get len help for word under cursor.
function! GetLen()
        let w = "len(" . expand("<cword>") . ")"
        :call g:ScreenShellSend(w)
        echo  w
endfunction
noremap <buffer> <LocalLeader>l :call GetLen()<CR>
"
" run file
nnoremap <buffer> <leader>v :silent exec '!python' shellescape(@%, 1)<cr>
nnoremap <buffer> <F5>
                        \ :call g:ScreenShellSend("%run ".expand('%:t'))<CR>
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
