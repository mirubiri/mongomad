shared_examples ".generate" do |changeable_attributes|
  describe ".generate(params)" do
    it 'instantiates a new object' do
      new_instance.should be_new_record
    end

    it 'is not an instance method' do
      new_instance.should_not respond_to(:generate)
    end

    changeable_attributes.each do |attribute|
      it "sets #{attribute} to params[:#{attribute}]" do
        new_instance.send(attribute).should eq params[attribute.to_sym]
      end
    end

    it "can only change #{changeable_attributes}" do
      changeable_attributes<<'_id'
      new_instance.changes.keys.sort.should eq changeable_attributes.sort
    end
  end
end
