class UsersController < ApplicationController
  before_action :set_user, only: %i[ update ]
  before_action :admin_only, only: %i[ create new index ]

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        #format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.html { redirect_to root_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = User.new(registation_params)
    @user.password = SecureRandom.base64(7)
    #debugger
    if @user.save
      Right.create!(:user => @user, :language_id => @user.language_id, :role => "TT")
      PasswordMailer.with(
        user: @user,
        password: @user.password
        ).registration_confirmation.deliver_later
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def registation_params
    params.require(:user).permit(:email, :password, :password_confirmation, :language_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password_digest, :name, :nick, :language_id, :phone, :address, :country, :notifications, :active)
  end
end