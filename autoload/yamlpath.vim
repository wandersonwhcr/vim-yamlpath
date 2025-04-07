if exists('*yamlpath#hello')
  finish
endif

ruby << RUBY
class YAMLPath
  def self.hello()
    print "Hello, World"
  end
end
RUBY

function! yamlpath#hello()
  :ruby YAMLPath.hello()
endfunction
