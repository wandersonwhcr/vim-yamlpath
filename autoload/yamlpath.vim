if exists('*yamlpath#hello')
  finish
endif

execute 'rubyfile' fnameescape(expand('<sfile>:p:h') . '/../ruby/lib/yamlpath.rb')

function! yamlpath#hello()
  :ruby YAMLPath.hello()
endfunction
