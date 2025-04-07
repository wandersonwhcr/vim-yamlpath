if exists('*yamlpath#hello')
  finish
endif

:ruby $LOAD_PATH << File.expand_path("../ruby/lib", Vim::evaluate("expand('<sfile>:p:h')"))

rubyfile yamlpath.rb

function! yamlpath#hello()
  :ruby YAMLPath.hello()
endfunction
