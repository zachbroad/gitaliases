class AliasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @aliases = current_user.aliases
  end

  def show
    @alias = current_user.aliases.find(params[:id])
  end

  def new
    @alias = current_user.aliases.new
  end

  def create
    @alias = current_user.aliases.new(alias_params)

    if @alias.save
      redirect_to @alias, notice: 'Alias was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @alias = current_user.aliases.find(params[:id])
  end

  def update
    @alias = current_user.aliases.find(params[:id])

    if @alias.update(alias_params)
      redirect_to @alias, notice: 'Alias was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @alias = current_user.aliases.find(params[:id])
    @alias.destroy
    redirect_to aliases_url, notice: 'Alias was successfully deleted.'
  end


  skip_before_action :verify_authenticity_token, only: [:vote]

  def vote
    @alias = Alias.find params[:id]
    vote = @alias.votes.find_or_initialize_by(user: current_user)
    
    # Toggle functionality: if user clicks same vote type, remove the vote
    if vote.persisted? && vote.vote_type == params[:vote_type]
      vote.destroy
    else
      vote.vote_type = params[:vote_type]
      vote.save!
    end
    
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("alias_#{@alias.id}", partial: "aliases/alias_card", locals: { alias_item: @alias }) }
      format.json { render json: { likes: @alias.likes_count, dislikes: @alias.dislikes_count } }
    end
  end

  private

  def alias_params
    params.require(:alias).permit(:name, :description, :code)
  end
end
