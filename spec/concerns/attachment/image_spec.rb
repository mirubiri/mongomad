require 'spec_helper'

describe Attachment::Image do
  # Relations
  it { should be_embedded_in :attachable }

	# Fields
	it { should have_field(:main).of_type(Boolean) }
	it { should have_field(:_id).of_type(Moped::BSON::ObjectId) }

	# Validations

	specify '.new' do
    expect(Attachment::Image.new.id).to eq nil
  end

  # Fabricator
  specify { expect(Fabricate.build(:image)).to be_valid }
end