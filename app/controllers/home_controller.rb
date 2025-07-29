class HomeController < ApplicationController
  def index
    @aliases = Alias.includes(:user, :tags)
    @search_query = params[:search]
    @tag_filters = []

    # Apply search filter
    if params[:search].present?
      @aliases = @aliases.search(params[:search])
    end

    # Apply tag filter
    if params[:tags].present?
      tag_names = params[:tags].split(",").map(&:strip)
      @tag_filters = tag_names
      @aliases = @aliases.tagged_with(tag_names)
    end

    @aliases = @aliases.all.sort_by(&:score).reverse
    @total_count = @aliases.count
    @popular_tags = Tag.popular.limit(10)
  end

  private

  def has_active_filters?
    @search_query.present? || @tag_filters.any?
  end

  def search_summary_text
    parts = []

    if @search_query.present?
      parts << "\"#{@search_query}\""
    end

    if @tag_filters.any?
      tags_text = @tag_filters.map { |tag| "##{tag}" }.join(", ")
      parts << "tags: #{tags_text}"
    end

    parts.join(" with ")
  end

  helper_method :has_active_filters?, :search_summary_text
end
