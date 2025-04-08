require 'yamlpath'

describe YAMLPath do
  describe "Path" do
    let(:empty)             { File.read("./spec/fixtures/empty.yaml")             }
    let(:scalar)            { File.read("./spec/fixtures/scalar.yaml")            }
    let(:mapping_simple)    { File.read("./spec/fixtures/mapping_simple.yaml")    }
    let(:mapping_multiple)  { File.read("./spec/fixtures/mapping_multiple.yaml")  }
    let(:mapping_nested)    { File.read("./spec/fixtures/mapping_nested.yaml")    }
    let(:mapping_sequence)  { File.read("./spec/fixtures/mapping_sequence.yaml")  }
    let(:sequence_simple)   { File.read("./spec/fixtures/sequence_simple.yaml")   }
    let(:sequence_multiple) { File.read("./spec/fixtures/sequence_multiple.yaml") }
    let(:sequence_nested)   { File.read("./spec/fixtures/sequence_nested.yaml")   }
    let(:sequence_mapping)  { File.read("./spec/fixtures/sequence_mapping.yaml")  }
    let(:k8s_deployment)    { File.read("./spec/fixtures/k8s_deployment.yaml")    }
    let(:invalid)           { File.read("./spec/fixtures/invalid.yaml")           }

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

    it "returns nested key for nested mapping on line 2", :mapping => true do
      expect(YAMLPath.path(mapping_nested, 2)).to eql(".a.b")
    end

    it "returns key for simple sequence", :sequence => true do
      expect(YAMLPath.path(sequence_simple, 1)).to eql(".[0]")
    end

    it "returns first key for multiple sequence on line 1", :sequence => true do
      expect(YAMLPath.path(sequence_multiple, 1)).to eql(".[0]")
    end

    it "returns second key for multiple sequence on line 2", :sequence => true do
      expect(YAMLPath.path(sequence_multiple, 2)).to eql(".[1]")
    end

    it "returns first key for nested sequence on line 1", :sequence => true do
      expect(YAMLPath.path(sequence_nested, 1)).to eql(".[0][0]")
    end

    it "returns second key for nested sequence on line 2", :sequence => true do
      expect(YAMLPath.path(sequence_nested, 2)).to eql(".[0][1]")
    end

    it "returns last element from mapping sequence", :mapping => true, :sequence => true do
      expect(YAMLPath.path(mapping_sequence, 5)).to eql(".c[1]")
    end

    it "returns last element from sequence mapping", :sequence => true, :mapping => true do
      expect(YAMLPath.path(sequence_mapping, 5)).to eql(".[1].d.g")
    end

    it "retrieves k8s deployment affinity node on-demand", :k8s => true do
      expect(YAMLPath.path(k8s_deployment, 47)).to eql(".spec.template.spec.affinity.nodeAffinity.requiredDuringSchedulingIgnoredDuringExecution.nodeSelectorTerms[1].matchExpressions[0].values[1]")
    end

    it "retrieves k8s deployment tolerations on-demand", :k8s => true do
      expect(YAMLPath.path(k8s_deployment, 63)).to eql(".spec.template.spec.tolerations[1].value")
    end

    it "handles invalid syntax", :syntax => true do
      expect(YAMLPath.path(invalid, 1)).to include("line 2 column 1")
    end

    it "uses vim bindings to retrieve current buffer and line", :vim => true do
      window = double("Vim::Window.current")
      buffer = double("Vim::Buffer.current")

      allow(window).to receive(:cursor).and_return([2, 5])
      allow(buffer).to receive(:count).and_return(2)
      allow(buffer).to receive(:[]).with(1).and_return("a:")
      allow(buffer).to receive(:[]).with(2).and_return("  b: c")

      expect(YAMLPath.vim(window, buffer)).to eql(".a.b")
    end
  end
end
