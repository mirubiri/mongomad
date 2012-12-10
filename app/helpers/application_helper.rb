module ApplicationHelper

  def user_data_for(user = @user)
    presenter = UserData.new(user)
    if block_given?
      yield presenter
    else
      presenter
    end
  end

end
