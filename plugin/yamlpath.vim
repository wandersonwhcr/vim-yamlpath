if exists("g:loaded_yamlpath")
  finish
endif
let g:loaded_yamlpath = 1

autocmd CursorMoved *.yaml call yamlpath#vim()
