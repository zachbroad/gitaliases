class HomeController < ApplicationController
  def index
    @aliases = Alias.includes(:user, :tags)

    # Apply search filter
    if params[:search].present?
      @aliases = @aliases.search(params[:search])
    end
    
    # Apply tag filter
    if params[:tags].present?
      tag_names = params[:tags].split(',').map(&:strip)
      @aliases = @aliases.tagged_with(tag_names)
    end
    
    @aliases = @aliases.all.sort_by(&:score).reverse
    @popular_tags = Tag.popular.limit(10)
  end
end
