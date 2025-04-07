require 'yamlpath'

describe YAMLPath do
  describe "#path" do
    let(:empty) { File.read("./spec/fixtures/empty.yaml") }
    it "returns root" do
      expect(YAMLPath.path(empty)).to eql(".")
    end
  end
end
