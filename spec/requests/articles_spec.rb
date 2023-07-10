require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /" do
    it '記事一覧画面を表示できること' do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /articles/:id' do
    let(:article) { FactoryBot.create(:article) }

    it '記事詳細画面を表示できること' do
      get "/articles/#{article.id}"
      expect(response).to have_http_status(:ok)
    end

    context '存在しない記事のidをURLパラメータに渡した場合' do
      it '404を返すこと' do
        get '/articles/100'
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /articles' do
    # TODO: 認可を実装したあとにログイン状態によって遷移可能かテストしたい
    it '記事投稿画面を表示できること' do
      get '/articles'
      # articleインスタンスとArticleモデルが一致すること
      article = controller.instance_variable_get(:@article)
      expect(article).to be_a_new(Article)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /articles' do
    let(:user) { FactoryBot.create(:user) }

    context 'ログインしている場合' do
      it '記事投稿できること' do
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password
          }
        }
        expect(session[:user_id]).to eq(user.id)

        post articles_path, params: {
          article: {
            title: 'test title',
            content: 'test content'
          }
        }
        expect(Article.last.title).to eq 'test title'
        expect(Article.last.content).to eq 'test content'
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_url)
      end
    end

    # context 'ログインしていない場合' do
    #   it '記事投稿できるないこと' do
    #
    #   end
    # end
  end
end
