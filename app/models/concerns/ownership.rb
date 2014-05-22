module Ownership
  extend ActiveSupport::Concern

  module ClassMethods
    def ownership(ownership)
      if ownership == :single
        include SingleMethods
        field :user_id
        embeds_one :user_sheet, as: :user_sheet_container
      end

      if ownership == :dual
        include DualMethods
        field :user_ids, type:Array,default:[]
        embeds_many :user_sheets, as: :user_sheet_container
      end
    end

    module SingleMethods
      def user
        user_sheet
      end
    end

    module DualMethods
      def users
        user_sheets
      end
    end

  end
end
