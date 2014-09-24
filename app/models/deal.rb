class Deal
  include Mongoid::Document
  include Mongoid::Timestamps
  include Proposable
  include Conversation

  proposal_historic :true

  def post_message(message)
    message_poster.post_message(message)
  end

  def participant?(user_id)
    user_ids.include? user_id
  end

  def authorized?(user_id)
    authorized_policy.authorized? user_id
  end

  private

  def message_poster
    @message_poster ||= MessagePoster.new(self)
  end

  def authorized_policy
    @authorized_policy ||= AuthorizedDealPolicy.new(self)
  end
end
