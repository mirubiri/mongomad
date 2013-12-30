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
  it { should embed_one :profile }
  it { should have_many :items }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:nick) }
  it { should have_field(:state).with_default_value_of('active') }

  # Validations
  it { should validate_presence_of :profile }
  it { should validate_presence_of :nick }
  it { should validate_inclusion_of(:state).to_allow('active', 'inactive') }

  # Methods
  describe '#sheet' do
    it 'returns an UserSheet filled with user id, first_name, last_name, images, nick and location coords' do
      expect(UserSheet).to receive(:new).with(first_name:user.profile.first_name,
        last_name:user.profile.last_name,
        nick:user.nick,
        location:user.profile.location,
        images:user.profile.images )
      user.sheet
    end
    specify { expect(user.sheet.id).to eq user.id }
  end

  describe '#enable' do
    context 'when user is active' do
      before{user.state='active'}

      it 'does not change user state' do
        expect{user.enable}.to_not change{user.state}
      end

      it 'returns false' do
        expect(user.enable).to eq false
      end
    end

    context 'when user is inactive' do
      before {user.state='inactive'}

      it 'change user state to active' do
        expect{user.enable}.to change{user.state}.from('inactive').to('active')
      end

      it 'returns true' do
        expect(user.enable).to eq true
      end
    end    
  end

  describe '#disable' do
    before{user.state='active'}

    context 'when user is active' do
      it 'change user state to inactive' do
        expect{user.disable}.to change{user.state}.from('active').to('inactive')
      end

      it 'returns true' do
        expect(user.disable).to eq true
      end
    end

    context 'when user is inactive' do
      before{user.state='inactive'}
      it 'does not change user state' do
        expect{user.disable}.to_not change{user.state}
      end

      it 'returns false' do
        expect(user.disable).to eq false
      end
    end    
  end

  # Factories
  specify { expect(Fabricate.build(:user)).to be_valid }
end
