require 'spec_helper'

describe Thing do
  # let(:user) { Fabricate(:user_with_things) }
  # let(:thing) { user.things.last }

  # describe 'Includes' do
  #   xit 'include ImageManager::ImageHolder'
  # end

  describe 'Relations' do
    it { should be_embedded_in :user }
    it { should embed_one :sheet }
  end

  # describe 'Attributes' do
      it { should be_timestamped_document }
  #   it { should accept_nested_attributes_for :sheet }
  #   it { should have_field(:stock).of_type(Integer) }
  # end

  describe 'Validations' do
    it { should_not validate_presence_of :user }
    it { should validate_presence_of :sheet }
  #   it { should validate_presence_of :stock }
  #   it { should validate_numericality_of(:stock).to_allow(nil: false,
  #                                                         only_integer: true,
  #                                                         greater_than_or_equal_to: 0) }
  end

  # describe 'Factories' do
  #   specify { expect(thing).to be_valid }

  #   it 'creates one user' do
  #     expect { thing.save }.to change{ User.count }.by(1)
  #   end
  # end
end
