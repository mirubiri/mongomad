shared_examples "object_generator" do |attributes|
  describe ".generate(params)" do
    it 'instantiates a new #{described_class.name}' do
      new_instance.should be_new_record
    end

    it 'is not an instance method' do
      new_instance.should_not respond_to(:generate)
    end

    attributes.each do |attribute|
      it "sets #{attribute} to params[:#{attribute}]" do
        new_instance.send(attribute).should eq params[attribute.to_sym]
      end
    end
  end
end
