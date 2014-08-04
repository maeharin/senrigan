describe Senrigan::Resource::Jsp do
  let(:root_path) { Pathname.new File.expand_path('../../jsp', __FILE__) }
  let(:file_path) { Pathname.new File.expand_path('../../jsp/top.jsp', __FILE__) }
  let(:label) { file_path.realpath.relative_path_from(root_path.realpath) }
  let(:jsp) { Senrigan::Resource::Jsp.new(file_path, root_path) }

  it "should be realpath" do
    expect(jsp.name).to eq file_path.realpath.to_s
  end

  it "should be realative path from root path" do
    expect(jsp.label).to eq label
  end

  it "should be label and black" do
    expected = {
      label: label,
      color: "black"
    }
    expect(jsp.options).to eq expected
  end

  it "should be override mode" do
    expect(jsp.override?).to be true
  end

  describe "#next_resources" do
    it "should be empty hash if not parsed yet" do
      expect(jsp.next_resources).to eq Hash.new
    end

    it "should be included jsp if parsed"
  end
end
