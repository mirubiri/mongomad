class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :goods

  field :composer_id
  field :receiver_id

  def composer
    user_sheets.where(id:composer_id).first
  end

  def composer=(user)
   self.composer_id=user.id
  end

  def receiver
    user_sheets.where(id:receiver_id).first
  end

  def receiver=(user)
    self.receiver_id=user.id
  end

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
