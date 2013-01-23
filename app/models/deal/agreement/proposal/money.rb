class Deal::Agreement::Proposal::Money
  include Mongoid::Document

  embedded_in :proposal, class_name: "Deal::Agreement::Proposal"

  field :user_id,  type: Moped::BSON::ObjectId
  field :quantity, type: Integer, default: 0

  validates :quantity,
            :proposal,
            presence: true

  validates :quantity,
            allow_nil: false,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0 }
end
