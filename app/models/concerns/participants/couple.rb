module Participants::Couple
  extend ActiveSupport::Concern
  included do
    raise 'You cannot include Participants::Couple having included Participants::Single' if self < Participants::Single
    include Mongoid::Document
    field :user_ids,type:Array
  end
end