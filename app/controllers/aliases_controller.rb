class AliasesController < ApplicationController
  def index
    @aliases = Alias.all
  end
end
