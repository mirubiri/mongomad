require 'spec_helper'

describe Product do

  it 'should have one main image & two secondary images'

  # Relations
  it { should be_embedded_in :proposal }

  # Attributes
  it { should be_timestamped_document }
  it { should have_fields :name,:description }
  it { should have_field(:quantity).of_type(Integer) }
  it { should have_field(:owner).of_type(Moped::BSON::ObjectId) }
  it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }

  # Validations
  it { should_not validate_presence_of :proposal }
  it { should validate_numericality_of(:quantity).to_allow(nil: false, only_integer: true, greater_than_or_equal_to: 0) }

  # Methods
  specify '.new' do
    expect(Product.new.id).to eq nil
  end

  # Factories
  specify { expect(Fabricate.build(:product)).to be_valid }
end
