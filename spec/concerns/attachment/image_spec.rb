require 'spec_helper'

describe Attachment::Image do
  # Relations
  it { should be_embedded_in :attachable }

  # Attributes
  it { should have_field(:main).of_type(Boolean) }
  it { should have_field(:height).of_type(Integer) }
  it { should have_field(:width).of_type(Integer) }
  it { should have_field(:x).of_type(Integer) }
  it { should have_field(:y).of_type(Integer) }

  # Factories
  specify { expect(Fabricate.build(:image_face)).to be_valid }
  specify { expect(Fabricate.build(:image_product)).to be_valid }
end
