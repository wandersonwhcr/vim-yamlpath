if exists("g:loaded_yamlpath")
  finish
endif
let g:loaded_yamlpath = 1

command! -nargs=0 Hello :call yamlpath#hello()
