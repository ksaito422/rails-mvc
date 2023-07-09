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
end
