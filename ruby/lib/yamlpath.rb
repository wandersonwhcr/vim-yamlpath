require 'yaml'

class YAMLPath
  def self.hello()
    print "Hello, World"
  end

  def self.path(content)
    if not document = YAML.parse(content)
      return "."
    end

    child = document.children.first

    case child
    when YAML::Nodes::Scalar
      return "."
    end

    ".a"
  end
end
