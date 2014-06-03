require 'rails_helper'

describe Good, :type => :model do
  # Modules

  # Relations
  it { is_expected.to be_embedded_in :proposal }

  # Attributes
  it { is_expected.to have_field(:user_id).of_type(Moped::BSON::ObjectId) }
  it { is_expected.to be_timestamped_document }

  # Validations
  it { is_expected.not_to validate_presence_of :proposal }
end
