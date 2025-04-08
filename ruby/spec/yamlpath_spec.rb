require 'yamlpath'

describe YAMLPath do
  describe "#path" do
    let(:empty)          { File.read("./spec/fixtures/empty.yaml")          }
    let(:scalar)         { File.read("./spec/fixtures/scalar.yaml")         }
    let(:mapping_simple) { File.read("./spec/fixtures/mapping_simple.yaml") }

    it "returns root for empty file", :empty => true do
      expect(YAMLPath.path(empty)).to eql(".")
    end

    it "returns root for scalar", :scalar => true do
      expect(YAMLPath.path(scalar)).to eql(".")
    end

    it "returns key for simple mapping", :mapping => true, :current => true do
      expect(YAMLPath.path(mapping_simple)).to eql(".a")
    end
  end
end
