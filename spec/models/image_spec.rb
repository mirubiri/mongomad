=begin
require 'spec_helper'

describe Image do
  describe 'Attributes' do
    it { should have_field(:url).of_type(String) }
    it { should have_field(:fingerprint).of_type(String) }
    it { should have_field(:references).of_type(Integer) }
  end

  describe 'Validations' do
    it { should validate_presence_of :url }
    it { should validate_presence_of :fingerprint }
    it { should validate_presence_of :references }
    it { should validate_numericality_of(:references).to_allow(nil: false,
                                                               only_integer: true,
                                                               greater_than_or_equal_to: 0) }
  end
end
=end