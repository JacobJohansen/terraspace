describe Terraspace::Terraform::Args::Builder do
  let(:builder) do
    builder = described_class.new(mod, name)
    builder.instance_variable_set(:@file, file) # override @file for spec
    builder
  end
  let(:file) { fixture("terraform/cli/args.rb") }
  let(:mod) { double(:mod).as_null_object }

  context "apply" do
    let(:name) { "apply" }
    it "build creates the @commands structure" do
      commands = builder.build
      expect(commands.keys).to include("apply")
    end

    it "args" do
      builder.build
      expect(builder.args).to eq(["-lock-timeout=20m"])
    end

    it "var_files" do
      builder.build
      allow(builder).to receive(:var_file_exist?).and_return(true)
      expect(builder.var_files).to eq(["-var-file=a.tfvars", "-var-file=b.tfvars"])
    end
  end
end
