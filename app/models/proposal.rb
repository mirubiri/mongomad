class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :user_sheets
  embeds_many :goods

  field :composer_id
  field :receiver_id

  private :user_sheets,:goods

  def composer
    user_sheets.where(id:composer_id).first
  end

  def composer=(user)
    composer_id || (self.composer_id=user.id) && (user_sheets<<user.sheet)
  end

  def receiver
    user_sheets.where(id:receiver_id).first
  end

  def receiver=(user)
    receiver_id || (self.receiver_id=user.id) && (user_sheets<<user.sheet)
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
