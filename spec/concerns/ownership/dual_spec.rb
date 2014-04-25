require 'spec_helper'

class TestOwnershipDual
	include Ownership::Dual
end

describe 'Ownership::Dual' do
	subject(:klass) { TestOwnershipDual }

	it { should have_field(:user_ids).of_type(Array) }

	it 'raise error if Ownership::Single is included' do
		expect { klass.include Ownership::Single }.to raise_error
	end
end