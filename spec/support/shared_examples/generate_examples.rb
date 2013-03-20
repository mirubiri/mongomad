shared_examples ".generate" do |attributes|
  describe ".generate(params)" do
    it 'instantiates a new object' do
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

    it "can only change #{attributes}" do
      attributes<<'_id'
      attributes.sort.should eq new_instance.changes.keys.sort
    end
  end
end
