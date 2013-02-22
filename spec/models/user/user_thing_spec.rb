require 'spec_helper'

describe User::Thing do
  let(:thing) { Fabricate.build(:user_with_things).things.last }
  let(:thing_params) { params_for_thing(thing) }

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:stock).of_type(Integer) }
    it { should have_field(:image_name).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :stock }
    it { should validate_presence_of :image_name }
    it { should validate_numericality_of(:stock).to_allow(nil: false,
                                                          only_integer: true,
                                                          greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(thing.valid?).to eq true }

    it 'Creates one user' do
      expect { thing.save }.to change{ User.count }.by(1)
    end
  end

  describe 'On save' do
    it 'Uploads an image' do
      thing.save
      File.exist?(File.new(thing.image.path)).should eq true
    end
  end

  describe '.generate(thing_params=[])' do
    it 'generates a valid thing given correct parameters' do
      User::Thing.generate(thing_params).should be_valid
    end

    it 'returns a thing corresponding to the given params' do
      User::Thing.generate(thing_params).should be_like thing
    end
  end

  describe '#publish' do
    context 'When thing is valid' do
      it 'returns true' do
        thing.publish.should eq true
      end

      it 'adds the thing to things for user' do
        thing.user.things << thing
        thing.publish
        User.find(thing.user).things.should include(thing)
      end
    end

    context 'When thing is not valid' do
      before { thing.should_receive(:save).and_return(false) }

      it 'returns false' do
        thing.publish.should eq false
      end

      it 'does not add the thing to things for user' do
        thing.user.things << thing
        thing.publish
        User.find(thing.user).things.should_not include(thing)
      end
    end

    context 'When thing is published' do
      before do
        thing.user.things << thing
        thing.publish
      end

      it 'returns true' do
        thing.publish.should eq true
      end

      it 'does not create a new thing' do
        expect { thing.publish }.to_not change { thing.count }
      end
    end
  end

  describe '#unpublish' do
    before do
      thing.publish
      thing.unpublish
    end

    context 'When thing is saved' do
      it 'returns true' do
        thing.unpublish.should eq true
      end

      it 'removes the thing from things for user' do
        User.find(thing.user).things.should_not include(thing)
      end

      it 'does not remove image' do
        thing.image.file.should be_exists
      end
    end

    context 'When thing is not saved' do
      it 'returns true' do
        thing.unpublish.should eq true
      end
    end
  end

  describe '#alter_contents(thing_params=[])' do
    after { thing.alter_contents(thing_params) }

    it 'does not change user from thing' do
      expect { thing.alter_contents(thing_params) }.to_not change {thing._id}
    end

    it 'changes name with value of params[:name]' do
      thing.should_receive(:name).with(thing_params[:name])
    end

    it 'changes description with value of params[:description]' do
      thing.should_receive(:description).with(thing_params[:description])
    end

    it 'changes stock with value of params[:stock]' do
      thing.should_receive(:stock).with(thing_params[:stock])
    end

    it 'changes image_name with value of params[:image_name]' do
      thing.should_receive(:image_name).with(thing_params[:image_name])
    end

    specify { expect { thing.alter_contents(thing_params) }.to eq true }
  end

  describe '#self_update' do
    it 'calls reload if persisted' do
      thing.publish
      thing.should_receive(:reload)
      thing.self_update
    end

    it 'does not call reload if not persisted' do
      thing.should_not_receive(:reload)
      thing.self_update
    end

    it 'returns self if self_update success' do
      thing.self_update.should eq thing
    end

    it 'raise error if self_update fails' do
      expect { thing.self_update }.to raise_error
    end
  end
end
