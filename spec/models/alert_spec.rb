require 'spec_helper'

describe Alert do
  xit 'should include a way of tracking new search results'
 # Relations
  it { should belong_to :user }

  # Attributes
  it { should have_field :text }
  it { should have_field :location }
end