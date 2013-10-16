require 'spec_helper'

describe Good do

	# Modules
	it { should include_module Attachment::Images }

	# Relations
  it { should be_embedded_in :proposal }
end
