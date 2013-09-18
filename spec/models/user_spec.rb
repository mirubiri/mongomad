require 'spec_helper'

describe User do
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

  # Validations
  it { should validate_presence_of :profile }
  it { should validate_presence_of :nick }

  # Factories
  specify { expect(Fabricate.build(:user)).to be_valid }

  # Methods
  describe '#sheet' do
    it 'returns an UserSheet filled with user id, first_name, last_name and nick' do
      expect(UserSheet).to receive(:new).with(first_name:user.profile.first_name,last_name:user.profile.last_name,nick:user.nick)
      user.sheet
      pending 'it should include the user photo url'
      pending 'it should include the location reference'
    end
    specify { expect(user.sheet.id).to eq user.id }
  end
end
