if exists('*yamlpath#vim')
  finish
endif

:ruby $LOAD_PATH << File.expand_path("../ruby/lib", Vim::evaluate("expand('<sfile>:p:h')"))

rubyfile yamlpath.rb

function! yamlpath#vim()
  :ruby print YAMLPath.vim(Vim::Window.current, Vim::Buffer.current)
endfunction
