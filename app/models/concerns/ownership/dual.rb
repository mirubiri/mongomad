module Ownership::Dual
  extend ActiveSupport::Concern
  included do
    raise 'You cannot include Ownership::Dual having included Ownership::Single' if self < Ownership::Single
    include Mongoid::Document
    include Ownership::Dual::Session
    field :user_ids,type:Array
    embeds_many :user_sheets, as: :user_sheet_container
  end
end