require 'spec_helper'

class Test::Archivable
	include Mongoid::Document
	include Archivable
end

describe Archivable do
  subject { Test::Archivable.new }
  it { should have_field(:archived).of_type(Boolean).with_default_value_of(true) }

  it 'scopes all queries to archived=false' do
  	expect(subject.default_scoping.call.selector).to eq({"archived"=>false})
  end
end