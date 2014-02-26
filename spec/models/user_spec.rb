require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }
  let(:user_sheet) { Fabricate.build(:user_sheet, user:user) }

  # Relations
  it { should have_many :requests }
  it { should have_many(:sent_offers).of_type(Offer).as_inverse_of(:user_composer) }
  it { should have_many(:received_offers).of_type(Offer).as_inverse_of(:user_receiver) }
  it { should have_and_belong_to_many :negotiations }
  it { should have_and_belong_to_many :deals }
  it { should have_many :items }
  it { should have_many :alerts }
  it { should embed_one :profile }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field :nick }
  it { should have_field(:disabled).of_type(Boolean).with_default_value_of(false) }

  # Validations
  it { should validate_presence_of :profile }
  it { should validate_presence_of :nick }
  it { should validate_presence_of :disabled }

  # Methods
  describe '#enable' do
    context 'when user is active' do
      before(:each) { user.disabled = false }

      it 'does not change user disabled field' do
        expect{ user.enable }.to_not change{ user.disabled }
      end

      it 'returns false' do
        expect(user.enable).to eq false
      end
    end

    context 'when user is inactive' do
      before(:each) { user.disabled = true }

      it 'changes user disabled field to false' do
        expect{ user.enable }.to change{ user.disabled }.from(true).to(false)
      end

      it 'returns true' do
        expect(user.enable).to eq true
      end
    end
  end

  describe '#disable' do
    context 'when user is active' do
      before(:each) { user.disabled = false }

      it 'changes user disabled field to true' do
        expect{ user.disable }.to change{ user.disabled }.from(false).to(true)
      end

      it 'returns true' do
        expect(user.disable).to eq true
      end
    end

    context 'when user is inactive' do
      before(:each) { user.disabled = true }

      it 'does not change user disabled field' do
        expect{ user.disable }.to_not change{ user.disabled }
      end

      it 'returns false' do
        expect(user.disable).to eq false
      end
    end
  end

  describe '#sheet' do
    specify { expect(user.sheet._id).to eq user._id }

    it 'returns a UserSheet filled with user data' do
      expect(user.sheet).to eq user_sheet
    end
  end

  # Factories
  specify { expect(Fabricate.build(:user)).to be_valid }
end
