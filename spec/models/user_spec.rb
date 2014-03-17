require 'spec_helper'

describe User do
  # Variables
  let(:user) { Fabricate.build(:user) }

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
  it { should validate_length_of(:nick).within(1..15) }

  # Validations
  it { should validate_presence_of :profile }
  it { should validate_presence_of :disabled }

  # Methods
  describe '#sheet' do
    let(:user_sheet) { Fabricate.build(:user_sheet, user:user) }
    specify { expect(user.sheet.id).to eq user.id }

    it 'returns a UserSheet filled with user data' do
      expect(user.sheet).to eq user_sheet
    end
  end

  describe '#disabled?' do
    context 'when user is enabled' do
      before(:each) { user.disabled = false }

      it 'returns false' do
        expect(user.disabled?).to eq false
      end
    end

    context 'when user is disabled' do
      before(:each) { user.disabled = true }

      it 'returns true' do
        expect(user.disabled?).to eq true
      end
    end
  end

  describe '#enable' do
    context 'when user is enabled' do
      before(:each) { user.disabled = false }

      it 'does not change user disabled field' do
        expect{ user.enable }.to_not change{ user.disabled }
      end

      it 'returns false' do
        expect(user.enable).to eq false
      end
    end

    context 'when user is disabled' do
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
    context 'when user is enabled' do
      before(:each) { user.disabled = false }

      it 'changes user disabled field to true' do
        expect{ user.disable }.to change{ user.disabled }.from(false).to(true)
      end

      it 'returns true' do
        expect(user.disable).to eq true
      end
    end

    context 'when user is disabled' do
      before(:each) { user.disabled = true }

      it 'does not change user disabled field' do
        expect{ user.disable }.to_not change{ user.disabled }
      end

      it 'returns false' do
        expect(user.disable).to eq false
      end
    end
  end

  # Factories
  specify { expect(Fabricate.build(:user)).to be_valid }
end
