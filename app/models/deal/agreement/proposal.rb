class Deal::Agreement::Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :agreement, class_name: "Deal::Agreement"
  embeds_one  :composer,  class_name: "Deal::Agreement::Proposal::Composer", cascade_callbacks: true
  embeds_one  :receiver,  class_name: "Deal::Agreement::Proposal::Receiver", cascade_callbacks: true
  embeds_one  :money,     class_name: "Deal::Agreement::Proposal::Money", cascade_callbacks: true

  validates :agreement,
            :composer,
            :receiver,
            :money,
            presence: true
end
