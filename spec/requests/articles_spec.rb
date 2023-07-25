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
    let(:user) { FactoryBot.create(:user) }

    context 'ログインしている場合' do
      it '記事投稿画面を表示できること' do
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password
          }
        }

        get '/articles'
        # articleインスタンスとArticleモデルが一致すること
        article = controller.instance_variable_get(:@article)
        expect(article).to be_a_new(Article)

        expect(response).to have_http_status(:ok)
      end
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

  describe 'DELETE /articles/:id' do
    context 'ログインしている場合' do
      let(:user) { FactoryBot.create(:user) }

      context '自分が作成した記事の場合' do
        let(:article) { FactoryBot.create(:article, user:) }

        it '記事を削除できること' do
          post login_path, params: {
            session: {
              email: user.email,
              password: user.password
            }
          }

          expect(session[:user_id]).to eq(user.id)
          # 念のため記事が作られているか確認する
          expect(Article.where(id: article.id)).to exist
          expect do
            delete "/articles/#{article.id}"
          end.to change(Article, :count).by(-1) # 記事が1件減っているか確認する
          # 作られた記事が存在しないか確認する
          expect(Article.where(id: article.id)).to_not exist
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(root_url)
        end
      end

      context '別のユーザー作成した記事の場合' do
        let(:other_user) { FactoryBot.create(:user) }
        let(:other_article) { FactoryBot.create(:article, user: other_user) }

        it '記事を削除できないこと' do
          post login_path, params: {
            session: {
              email: user.email,
              password: user.password
            }
          }

          expect(session[:user_id]).to eq(user.id)
          delete "/articles/#{other_article.id}"
          # 作られた記事が存在するか確認する
          expect(Article.where(id: other_article.id)).to exist
          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end
end
