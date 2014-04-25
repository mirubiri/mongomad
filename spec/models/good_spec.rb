require 'spec_helper'

describe Good do
  # Modules
  it { should include_module Attachment::Images }

  # Relations
  it { should be_embedded_in :proposal }

  # Attributes
  it { should have_field(:user_id).of_type(Moped::BSON::ObjectId) }
  it { should be_timestamped_document }

  # Validations
  it { should_not validate_presence_of :proposal }
end
