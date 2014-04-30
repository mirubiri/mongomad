module Ownership::Single
  extend ActiveSupport::Concern
  included do
    raise 'You cannot include Ownership::Single having included Ownership::Dual' if self < Ownership::Dual
    include Mongoid::Document
    field :user_id
  end
end