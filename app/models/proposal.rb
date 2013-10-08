class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :goods

  field :composer_id, type:Moped::BSON::ObjectId
  field :receiver_id, type:Moped::BSON::ObjectId

  validates_presence_of :composer_id, :receiver_id

  validate :check_composer_goods, :check_receiver_goods, :check_goods_owner, :check_duplicate_goods, :check_multiple_cash

  def left(owner_id)
    goods.where(owner_id:owner_id)
  end

  def right(owner_id)
    goods.where(:owner_id.ne => owner_id)
  end

  def cash?
    goods.type(Cash).exists?
  end

  private
  def check_composer_goods
    errors.add(:goods, "Composer should have at least one good") unless left(composer_id).count > 0
  end

  def check_receiver_goods
    errors.add(:goods, "Receiver should have at least one good") unless left(receiver_id).count > 0
  end

  def check_goods_owner
    errors.add(:goods, "All goods should be owned by composer or receiver") unless goods.or({owner_id:composer_id}, {owner_id:receiver_id}).size == goods.size
  end

  def check_duplicate_goods
    errors.add(:goods, "Proposal should not have duplicated good") unless goods.distinct(:id).size == goods.size
  end

  def check_multiple_cash
    errors.add(:goods, "Proposal should have only one cash") if goods.type(Cash).size > 1
  end
end
