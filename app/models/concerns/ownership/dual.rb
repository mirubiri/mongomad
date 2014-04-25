module Ownership::Dual
  extend ActiveSupport::Concern
  included do
    raise 'You cannot include Ownership::Dual having included Ownership::Single' if self < Ownership::Single
    include Mongoid::Document
    field :user_ids,type:Array
  end
end