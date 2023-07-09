class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :url_not_found

  def index
    @articles = Article.all
  end

  def show
    id = params[:id]
    @article = Article.find(id)
  end

  def new
    @article = Article.new
  end

  private

  def url_not_found
    response.status = 404
  end
end
