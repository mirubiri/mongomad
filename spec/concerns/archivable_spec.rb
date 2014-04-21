require 'spec_helper'

class Test::Archivable
	include Mongoid::Document
	include Archivable
end

describe Archivable do
  subject { Test::Archivable.new }
  it { should have_field(:archived).of_type(Boolean).with_default_value_of(true) }

  describe 'default_scope' do
  	it 'retrives only elements with archived = false' do
  		expect(subject.default_scoping.call.selector).to eq({"archived"=>false})
  	end
  end
end