require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }

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
  it { should accept_nested_attributes_for :profile }
  it { should have_field(:name) }

  # Validations
  it { should validate_presence_of :profile }
  it { should validate_presence_of :name }

  # Factories
  specify { expect( Fabricate.build(:user) ).to be_valid }
end
