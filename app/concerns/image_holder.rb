module ImageHolder
  extend ActiveSupport::Concern

  included do
    field :attachments,type:Hash
  end
end