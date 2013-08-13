require 'spec_helper'

describe User do
  # Relations
  it { should have_many :requests }
  it { should have_many(:sent_offers).of_type(Offer) }
  it { should have_many(:received_offers).of_type(Offer) }
  it { should have_and_belong_to_many :negotiations }
  it { should have_and_belong_to_many :deals }
  it { should embed_one :profile }
  it { should embed_one(:sheet).of_type(UserSheet) }
  it { should embed_many :items }

  # Attributes
  it { should be_timestamped_document }
  it { should have_field(:nick) }

  # Validations
  it { should validate_presence_of :profile }
  it { should validate_presence_of :nick }

  # Factories
  specify { expect(Fabricate.build(:user)).to be_valid }
end
