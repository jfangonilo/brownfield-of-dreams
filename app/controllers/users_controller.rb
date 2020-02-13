class UsersController < ApplicationController
  def show
    render locals: {
      facade: UserDashboardFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name} #{user.last_name}."
      UserActivatorMailer.inform(current_user).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    response = request.env['omniauth.auth']
    github_id = response['extra']['raw_info']['id']
    token = request.env['omniauth.auth']['credentials']['token']

    current_user.update(github_token: token, github_id: github_id)

    redirect_to dashboard_path
  end

  def confirm
    user = User.find(params[:id])
    user.update(active?: true)
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
