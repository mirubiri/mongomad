class Proposal
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :proposal_container, polymorphic: true
  embeds_many :goods

  field :composer_id, type:Moped::BSON::ObjectId
  field :receiver_id, type:Moped::BSON::ObjectId

  validates_presence_of :composer_id, :receiver_id

  # validate :check_goods_for_composer

  def left(owner_id)
    goods.where(owner_id:owner_id)
  end

  def right(owner_id)
    goods.where(:owner_id.ne =>owner_id)
  end

  def cash?
    goods.type(Cash).exists?
  end

  # private
  # def check_goods_for_composer
  #   puts "comprobando"  # Experimentos horribles!!!
  #   puts left(composer_id)
  #   if left(composer_id) == 0 
  #     puts "adderror"
  #     errors.add(:goods, "Composer should have at least one good")
  #   end
  # end


  # before_create :set_initial_state

  # state_machine :confirmable_state, :initial => :confirmable do
  #   event :unconfirmable do
  #     transition :confirmable => :unconfirmable, :unless => :confirmed?
  #   end

  #   event :confirmable do
  #     transition :unconfirmable => :confirmable
  #   end
  # end

  # state_machine :state, :initial => nil do
  #   event :sign_receiver do
  #     transition :unsigned => :receiver_signed
  #   end

  #   event :confirm_composer do
  #     transition :receiver_signed => :composer_confirmed, :if => :confirmable?
  #   end

  #   event :confirm_receiver do
  #     transition :composer_signed => :receiver_confirmed, :if => :confirmable?
  #   end

  #   event :cancel_composer do
  #     transition [:unsigned, :composer_signed, :receiver_signed] => :composer_canceled
  #   end

  #   event :cancel_receiver do
  #     transition [:unsigned ,:composer_signed, :receiver_signed] => :receiver_canceled
  #   end
  # end

  # def user_composer
  #   negotiation && negotiation.negotiators.find(user_composer_id)
  # end

  # def user_receiver
  #   negotiation && negotiation.negotiators.find(user_receiver_id)
  # end

  # def can_sign?(user)
  #   user_receiver_id == user.id && state == 'unsigned'
  # end

  # def can_confirm?(user)
  #   (user_composer_id == user.id && state == 'receiver_signed') || (user_receiver_id == user.id && state == 'composer_signed')
  # end

  # def can_cancel?(user)
  #   state == 'unsigned' || state == 'receiver_signed' || state == 'composer_signed'
  # end

  # private
  # def set_initial_state
  #   if money.user_id == user_composer_id
  #     self.state = :unsigned
  #   else
  #     self.state = :composer_signed
  #   end
  # end
end
