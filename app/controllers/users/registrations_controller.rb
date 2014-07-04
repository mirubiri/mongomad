class Users::RegistrationsController < Devise::RegistrationsController

  def new
    if params[:user]
      full_name = params[:user][:full_name]
      email = params[:user][:email]
      password = params[:user][:password]
    end

    self.resource = resource_class.new

    respond_to do |format|
        format.html { render locals: {email:email,password:password,full_name:full_name} }
    end
  end

  def create
    user_params=params[:user]
    builder = UserBuilder.new
                         .email(user_params[:email])
                         .password(user_params[:password])
                         .full_name(user_params[:full_name])
    user = builder.build

    respond_to do |format|
      if user
        user.save
        sign_in user
        format.html { redirect_to user_offers_path(current_user) }
      else
        format.html { redirect_to root_path }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
