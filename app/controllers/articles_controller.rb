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

  def create
    if !current_user.nil?
      Article.create(
        title: params[:article][:title],
        content: params[:article][:content],
        user_id: @current_user.id
      )
      redirect_to root_url
    else
      render new
    end
  end

  private

  def url_not_found
    response.status = 404
  end
end
