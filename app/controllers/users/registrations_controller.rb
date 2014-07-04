class Users::RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || user_offers_path(current_user)
  end

  def new

    email = params[:user][:email]
    password = params[:user][:password]
    self.resource = resource_class.new

    respond_to do |format|
        format.html { render locals: {email:email,password:password} }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  def create
    builder = UserBuilder.new
                         .email(params[:user][:email])
                         .password(params[:user][:password])
    user = builder.build

    respond_to do |format|
      if user
        user.save
        format.html { redirect_to root_path }
        #format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render 'new' }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
