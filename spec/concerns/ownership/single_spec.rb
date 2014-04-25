require 'spec_helper'

class TestOwnershipSingle
	include Ownership::Single
end

describe 'OwnershipSingle' do
	subject(:klass) { TestOwnershipSingle }

	it { should have_field :user_id }

	it 'raise error if Ownership::Dual is included' do
		expect { klass.include Ownership::Dual }.to raise_error
	end
end