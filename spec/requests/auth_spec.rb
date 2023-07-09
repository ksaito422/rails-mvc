require 'rails_helper'

RSpec.describe "Auths", type: :request do
  describe "GET /login" do
    it 'ログイン画面が表示できること' do
      get login_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /login" do
    let(:user) { FactoryBot.create(:user) }

    context '有効な値の場合' do
      it 'ログインできること' do
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password
          }
        }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_url)
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context '存在しないユーザーの場合' do
      it 'ログインできないこと' do
        post login_path, params: {
          session: {
            email: 'invalid@test.com',
            password: 'invalid1234'
          }
        }
        expect(response).to have_http_status(:ok)
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE /logout" do
    let(:user) { FactoryBot.create(:user) }

    it 'ログアウトできること' do
      get login_path
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }

      delete logout_path
      expect(response).to have_http_status(:found)
    end
  end
end
