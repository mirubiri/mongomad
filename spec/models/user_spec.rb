require 'spec_helper'

describe User do
  # Variables
  let (:user) { Fabricate.build(:user) }

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
  it { should have_field(:state).with_default_value_of('active') }

  # Validations
  it { should validate_presence_of :profile }
  it { should validate_presence_of :nick }
  it { should validate_inclusion_of(:state).to_allow('active','inactive') }

  # Methods
  describe '#enable' do
    context 'when user is active' do
      before(:each) { user.state = 'active' }

      it 'does not change user state' do
        expect{ user.enable }.to_not change{ user.state }
      end

      it 'returns false' do
        expect(user.enable).to eq false
      end
    end

    context 'when user is inactive' do
      before(:each) { user.state = 'inactive' }

      it 'change user state to active' do
        expect{ user.enable }.to change{ user.state }.from('inactive').to('active')
      end

      it 'returns true' do
        expect(user.enable).to eq true
      end
    end    
  end

  describe '#disable' do
    context 'when user is active' do
      before(:each) { user.state = 'active' }

      it 'change user state to inactive' do
        expect{ user.disable }.to change{ user.state }.from('active').to('inactive')
      end

      it 'returns true' do
        expect(user.disable).to eq true
      end
    end

    context 'when user is inactive' do
      before(:each) { user.state = 'inactive' }

      it 'does not change user state' do
        expect{ user.disable }.to_not change{ user.state }
      end

      it 'returns false' do
        expect(user.disable).to eq false
      end
    end    
  end

  describe '#sheet' do
    it 'returns an UserSheet filled with user id, nick, first_name, last_name, images and location coords' do
      expect(UserSheet).to receive(:new).with(nick:user.nick,
        first_name:user.profile.first_name,
        last_name:user.profile.last_name,
        images:user.profile.images,
        location:user.profile.location)
      user.sheet
    end

    specify { expect(user.sheet.id).to eq user.id }
  end

  # Factories
  specify { expect(Fabricate.build(:user)).to be_valid }
end
