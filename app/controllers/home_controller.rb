class HomeController < ApplicationController
  def index
    @aliases = Alias.includes(:user).all
  end
end
