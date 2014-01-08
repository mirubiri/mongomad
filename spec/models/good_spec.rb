require 'spec_helper'

describe Good do
  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should be_embedded_in :proposal }

  # Attributes
  it { should be_timestamped_document }

  # Validations
  it { should_not validate_presence_of :proposal }
end
