class Users::RegistrationsController < Devise::RegistrationsController

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
