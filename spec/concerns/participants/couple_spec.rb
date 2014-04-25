require 'spec_helper'

class TestParticipantsCouple
	include Participants::Couple
end

describe 'Participants::Single' do
	subject(:klass) { TestParticipantsCouple }

	it { should have_field(:user_ids).of_type(Array) }

	it 'raise error if Participants::Single is included' do
		expect { klass.include Participants::Single }.to raise_error
	end
end