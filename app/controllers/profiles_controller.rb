class ProfilesController < ApplicationController
  before_action :find_user
  
  def show
    @aliases = @user.aliases
  end

  def aliases
    @aliases = @user.aliases
  end
  
  private
  
  def find_user
    username = params[:username]
    @user = User.find_by(email: "#{username}@#{username.split('@').last || 'example.com'}")
    @user ||= User.find_by("email LIKE ?", "#{username}@%")
    
    unless @user
      redirect_to root_path, alert: "User not found"
    end
  end
end
