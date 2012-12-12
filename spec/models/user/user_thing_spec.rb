require 'spec_helper'

describe User::Thing do
  let(:thing) { Fabricate.build(:user).things[0] }

  describe 'Relations' do
    it { should be_embedded_in :user }
    it { should embed_many(:secondary_images).of_type(User::Thing::Image) }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:stock).of_type(Integer).with_default_value_of(1) }
    it { should have_field(:main_image).of_type(String) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :stock }
    it { should validate_presence_of :main_image}
    it { should validate_numericality_of(:stock).to_allow(nil: false,
                                                          only_integer: true,
                                                          greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(thing.valid?).to be_true }
    specify { expect(thing.save).to be_true }
  end
end
