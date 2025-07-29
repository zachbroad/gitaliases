class AliasesController < ApplicationController
  before_action :authenticate_user!, except: [ :vote ]

  def index
    @aliases = current_user.aliases.sort_by(&:score) if current_user
  end

  def show
    @alias = Alias.find(params[:id])
  end

  def new
    @alias = current_user.aliases.new
  end

  def create
    @alias = current_user.aliases.new(alias_params)

    if @alias.save
      redirect_to @alias, notice: "Alias was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @alias = Alias.find(params[:id])
    if @alias.user != current_user
      redirect_to root_path, alert: "You are not authorized to edit this alias."
    end
  end

  def update
    @alias = current_user.aliases.find(params[:id])

    if @alias.update(alias_params)
      redirect_to @alias, notice: "Alias was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @alias = current_user.aliases.find(params[:id])
    @alias.destroy
    redirect_to aliases_url, notice: "Alias was successfully deleted."
  end


  skip_before_action :verify_authenticity_token, only: [ :vote ]

  def vote
    @alias = Alias.find params[:id]

    if current_user
      # Logged in user voting
      vote = @alias.votes.find_or_initialize_by(user: current_user)
    else
      # Anonymous voting by IP
      vote = @alias.votes.find_or_initialize_by(ip_address: request.remote_ip, user_id: nil)
    end

    # Toggle functionality: if user/IP clicks same vote type, remove the vote
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
    params.require(:alias).permit(:name, :description, :code, :tag_list)
  end
end
