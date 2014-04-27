module Ownership::Dual::Session
  extend ActiveSupport::Concern

  included do
    raise 'Ownership::Dual is required by ::Session' unless self < Ownership::Dual
  end

  def login(user_id)
    return false unless registered? user_id
    true if @logged = user_id
  end

  def logged
    @logged
  end

  def registered?(user_id)
    (self.user_ids||=[]).include? user_id.to_s
  end

  def register(user_id)
    (self.user_ids||=[]) << user_id.to_s
  end
end