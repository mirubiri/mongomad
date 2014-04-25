module Participants::Couple::Session
  extend ActiveSupport::Concern

  included do
    raise 'Participants::Couple is required by ::Session' unless self < Participants::Couple
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