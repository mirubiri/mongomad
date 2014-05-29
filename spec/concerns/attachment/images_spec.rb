require 'spec_helper'

describe Attachment::Images do
  # Variables
  let(:test_class) do
    Struct.new(nil) do
      include Mongoid::Document
      include Attachment::Images
    end
  end
  
  let(:image_one) { Fabricate.build(:image, main: true) }
  let(:image_two) { Fabricate.build(:image) }
  let(:image_three) { Fabricate.build(:image) }

  let(:image_holder) do
    test = test_class.new
    test.images << image_one
    test.images << image_two
    test.images << image_three
    test
  end

  subject { test_class }

  # Relations
  it { should embed_many :images }

  # Checks

  # Methods
  describe '#main_image' do
    it 'returns the main image' do
      expect(image_holder.main_image).to eq image_one
    end
  end
end
