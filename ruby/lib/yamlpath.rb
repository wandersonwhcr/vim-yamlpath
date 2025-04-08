require 'yaml'

class YAMLPath
  def self.hello()
    print "Hello, World"
  end

  def self.traverse(node, line)
    result = []

    case node
    when YAML::Nodes::Mapping
      node.children.each_slice(2) do |key, value|
        if key.start_line <= line and line <= value.end_line
          result << "." + key.value
          if value.start_line <= line and line <= value.end_line
            result += traverse(value, line)
          end
        end
      end
    when YAML::Nodes::Sequence
      node.children.each_with_index do |child, i|
        if child.start_line <= line and line <= child.end_line
          result << "[" + i.to_s + "]"
          result += traverse(child, line)
        end
      end
    end

    return result
  end

  def self.path(content, line)
    if not document = YAML.parse(content)
      return "."
    end

    return "." + traverse(document.children.first, line - 1).join().gsub(/^\./, "")
  end
end
