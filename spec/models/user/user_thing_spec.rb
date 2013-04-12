require 'spec_helper'

describe User::Thing do
  let(:user) { Fabricate(:user_with_things) }
  let(:thing) { user.things.last }

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:stock).of_type(Integer) }
    it { should have_field(:image).of_type(Object) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :stock }
    it { should validate_presence_of :image }
    it { should validate_numericality_of(:stock).to_allow(nil: false,
                                                          only_integer: true,
                                                          greater_than_or_equal_to: 0) }
  end

  describe 'Factories' do
    specify { expect(thing).to be_valid }

    it 'creates one user' do
      expect { thing.save }.to change{ User.count }.by(1)
    end
  end

  describe 'after_save' do
    it 'uploads an image' do
      thing.save
      expect(File.exist? thing.image.path).to eq true
    end
  end
end
