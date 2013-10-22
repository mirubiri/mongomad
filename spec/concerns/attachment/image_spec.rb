require 'spec_helper'

describe Attachment::Image do
  # Relations
  it { should be_embedded_in :attachable }

	# Fields
	it { should have_field(:main).of_type(Boolean) }

  # Fabricator
  specify { expect(Fabricate.build(:image_face)).to be_valid }
  specify { expect(Fabricate.build(:image_product)).to be_valid }
end