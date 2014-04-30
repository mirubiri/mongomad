module Ownership::Dual::Session
  extend ActiveSupport::Concern

  included do
    raise 'Ownership::Dual is required by ::Session' unless self < Ownership::Dual
  end

  def login(user)
    return false unless registered? user
    true if @logged = user.id
  end

  def logged_user
    @logged
  end

  def registered?(user)
    (self.user_ids||=[]).include? user.id
  end

  def register(user)
    (self.user_ids||=[]) << user.id
    user_sheets << user.sheet
  end
end