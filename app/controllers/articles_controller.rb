class ArticlesController < ApplicationController
  # ログインしてsessionにuser_idを保持しているかチェックする
  before_action :authenticate_user!, only: [:new, :destroy]

  # リソースが存在しない場合にhttp not foundを返す
  rescue_from ActiveRecord::RecordNotFound, with: :url_not_found

  def index
    @articles = Article.all
  end

  def show
    id = params[:id]
    @article = Article.find(id)
  end

  def new
    authorize Article

    @article = Article.new
  end

  def edit; end

  def create
    authorize Article

    if current_user.nil?
      render new
    else
      Article.create(
        title: params[:article][:title],
        content: params[:article][:content],
        user_id: @current_user.id
      )
      redirect_to root_url
    end
  end

  def update; end

  def destroy
    authorize Article

    id = params[:id]
    article = Article.find(id)
    return unless article.user_id == current_user.id

    article.destroy!
    redirect_to root_url
  end

  private

  def url_not_found
    response.status = 404
  end

  def authenticate_user!
    return if session[:user_id]

    flash[:alert] = 'You need to sign in or sign up before continuing.'
    redirect_to login_path
  end
end
