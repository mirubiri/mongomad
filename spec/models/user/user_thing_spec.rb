require 'spec_helper'

describe User::Thing do
  let(:thing) do
    Fabricate.build(:user_with_things).things.last
  end

  describe 'Relations' do
    it { should be_embedded_in :user }
  end

  describe 'Attributes' do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
    it { should have_field(:stock).of_type(Integer) }
    it { should have_field(:image_name).of_type(Object) }
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
    specify { expect(thing.valid?).to be_true, "Is not valid because #{thing.errors}" }

    it 'Creates one user' do
      expect { thing.save }.to change{ User.count }.by(1)
    end
  end

  describe 'On save' do
    it 'Uploads an image' do
      thing.save
      File.exist?(File.new(thing.image.path)).should be_true
    end
  end

=begin
  # Funciones PUBLICAS necesarias (debatidas en el fuego de campamento)

  update_thing(hash) -> actualiza los datos de una cosa con los recibidos en el hash
=end
end
