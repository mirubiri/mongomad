require 'rails_helper'

describe Attachment::Image do
  # Relations
  it { is_expected.to be_embedded_in :attachable }

  # Attributes
  it { is_expected.to have_field(:main).of_type(Mongoid::Boolean) }
  it { is_expected.to have_field(:h).of_type(Integer) }
  it { is_expected.to have_field(:w).of_type(Integer) }
  it { is_expected.to have_field(:x).of_type(Integer) }
  it { is_expected.to have_field(:y).of_type(Integer) }

  # Factories
end
