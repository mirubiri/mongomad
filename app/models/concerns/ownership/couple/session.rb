module Ownership::Dual::Session
  extend ActiveSupport::Concern

  included do
    raise 'Ownership::Dual is required by ::Session' unless self < Ownership::Dual
  end

  def login(user_id)
    return false unless participant?(user_id)
    true if @logged = user_id
  end

  def logged
    @logged
  end

  def participant?(user_id)
    user_ids.try(:include?,user_id.to_s)
  end
end