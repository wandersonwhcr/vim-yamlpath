require 'yamlpath'

describe YAMLPath do
  describe "#path" do
    let(:empty)  { File.read("./spec/fixtures/empty.yaml")  }
    let(:scalar) { File.read("./spec/fixtures/scalar.yaml") }

    it "returns root for empty file" do
      expect(YAMLPath.path(empty)).to eql(".")
    end

    it "returns root for scalar" do
      expect(YAMLPath.path(scalar)).to eql(".")
    end
  end
end
