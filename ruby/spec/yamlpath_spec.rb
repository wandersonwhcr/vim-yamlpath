require 'yamlpath'

describe YAMLPath do
  describe "#path" do
    let(:empty)            { File.read("./spec/fixtures/empty.yaml")            }
    let(:scalar)           { File.read("./spec/fixtures/scalar.yaml")           }
    let(:mapping_simple)   { File.read("./spec/fixtures/mapping_simple.yaml")   }
    let(:mapping_multiple) { File.read("./spec/fixtures/mapping_multiple.yaml") }
    let(:mapping_nested)   { File.read("./spec/fixtures/mapping_nested.yaml") }

    it "returns root for empty file", :empty => true do
      expect(YAMLPath.path(empty, 1)).to eql(".")
    end

    it "returns root for scalar", :scalar => true do
      expect(YAMLPath.path(scalar, 1)).to eql(".")
    end

    it "returns key for simple mapping", :mapping => true do
      expect(YAMLPath.path(mapping_simple, 1)).to eql(".a")
    end

    it "returns first key for multiple mapping on line 1", :mapping => true do
      expect(YAMLPath.path(mapping_multiple, 1)).to eql(".a")
    end

    it "returns second key for multiple mapping on line 2", :mapping => true do
      expect(YAMLPath.path(mapping_multiple, 2)).to eql(".c")
    end

    it "returns first key for nested mapping on line 1", :mapping => true do
      expect(YAMLPath.path(mapping_nested, 1)).to eql(".a")
    end

    it "returns nested key for nested mapping on line 2", :mapping => true, :current => true do
      expect(YAMLPath.path(mapping_nested, 2)).to eql(".a.b")
    end
  end
end
