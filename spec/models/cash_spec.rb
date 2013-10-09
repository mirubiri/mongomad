require 'spec_helper'

describe Cash do
  specify { Cash.should < Good }
  let(:cash) { Fabricate.build(:cash) }

  it 'should have an image representing money an divise'
  # Relations
  it { should be_embedded_in :proposal}

  # Validations

  it { should validate_presence_of :_money }
  it { should_not validate_presence_of :owner_id }

  # Fields
  it { should have_field(:_money).of_type(Money) }
  it { should_not have_field(:owner_id).of_type(Moped::BSON::ObjectId) }

  # Methods
  specify '.new' do
    expect(Cash.new.id).to eq nil
  end

  # Fabricator
  specify { expect(Fabricate.build(:cash)).to be_valid }
end
