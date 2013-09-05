require 'spec_helper'

describe User do
  let (:user) { Fabricate.build(:user) }

  # Relations
  it { should have_many :requests }
  it { should have_many(:sent_offers).of_type(Offer) }
  it { should have_many(:received_offers).of_type(Offer) }
  it { should have_and_belong_to_many :negotiations }
  it { should have_and_belong_to_many :deals }
  it { should embed_one :profile }
  it { should embed_many :items }

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
    specify { expect(user.sheet).to be_a_kind_of(UserSheet) }
    specify { expect(user.sheet.first_name).to eq user.profile.first_name }
    specify { expect(user.sheet.last_name).to eq user.profile.last_name }
    specify { expect(user.sheet.nick).to eq user.nick }
    specify { expect(user.sheet.user_sheet_container).to eq nil }
    xit 'expect an user photo'
    xit 'expect a location reference'
  end
end
