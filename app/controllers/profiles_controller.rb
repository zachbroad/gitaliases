class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [ :me ]
  before_action :find_user, except: [ :list, :me ]

  def show
    @aliases = @user.aliases
  end

  def aliases
    @aliases = @user.aliases
  end

  def list
    @profiles = User.all
  end

  def me
    @user = current_user
    @aliases = @user.aliases if @user
  end

  private

  def find_user
    username = params[:username]
    @user = User.find_by("email LIKE ?", "#{username}@%")

    unless @user
      redirect_to root_path, alert: "User not found"
    end
  end
end
