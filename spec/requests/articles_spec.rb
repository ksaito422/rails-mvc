require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /" do
    it '記事一覧画面を表示できること' do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
