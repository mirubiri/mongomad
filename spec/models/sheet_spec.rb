require 'spec_helper'

describe Sheet do
  describe 'Relations' do
    it { should be_embedded_in :sheet_container }
  end

  describe 'Attributes' do
    it { should have_fields :name,:description,:image }
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :image }
  end
end
