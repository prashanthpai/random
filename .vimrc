set clipboard=unnamedplus
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab

syntax on

if has("cscope")
        set csto=0
        set cst
        set nocsverb
        " add any database in current directory
        if filereadable("cscope.out")
             cs add cscope.out
        endif
        set csverb
endif
