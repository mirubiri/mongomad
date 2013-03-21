shared_examples "#alter_contents" do |alterable_attributes|
  before { instance.save }

  context "When #{described_class} is saved" do
    alterable_attributes.each do |attribute|
      it "alter #{attribute} value to params[:#{attribute}]" do
        instance.alter_contents(params)
        instance.send(attribute).should eq params[attribute.to_sym]
      end
    end

    it "can only alter #{alterable_attributes}" do
      instance.stub(:save)
      instance.alter_contents(params)
      alterable_attributes.sort.should eq instance.changes.keys.sort
    end

    it "returns true if changed correctly" do
      instance.alter_contents(params).should eq true
    end

    it "saves changes" do
      instance.should_receive(:save)
      instance.alter_contents(params)
    end
  end

  context "When #{described_class} is not saved" do
    let(:unsaved_instance) { instance.clone }
    it "returns false" do
      unsaved_instance.alter_contents(params).should eq false
    end

    it "do not saves #{described_class}" do
      unsaved_instance.alter_contents(params)
      unsaved_instance.should_not be_persisted
    end

    it "do not make any changes in #{described_class}" do
      unchanged_instance=unsaved_instance.clone
      unsaved_instance._id=unchanged_instance._id
      unsaved_instance.alter_contents(params)
      unchanged_instance.changes.should eq unsaved_instance.changes
    end
  end
end