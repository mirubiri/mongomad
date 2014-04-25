module Participants::Single
  extend ActiveSupport::Concern
  included do
    raise 'You cannot include Participants::Single having included Participants::Couple' if self < Participants::Couple
    include Mongoid::Document
    field :user_id
  end
end