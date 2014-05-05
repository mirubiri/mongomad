class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :goods

  field :composer_id
  field :receiver_id

  def composer_goods
    goods.where(user_id:composer_id).to_a
  end

  def receiver_goods
    goods.where(user_id:receiver_id).to_a
  end

  def composer_goods=(items)
    goods<<items.map { |item| item.to_product }
  end

  alias_method :receiver_goods=,:composer_goods=
end
