require 'rails_helper'

RSpec.describe 'Articles', type: :routing do
  describe 'GET /' do
    it 'articles#indexにルーティングすること' do
      expect(get('/')).to route_to('articles#index')
    end
  end

  describe 'GET /articles/:id' do
    it 'articles#showにルーティングすること' do
      expect(get('/articles/1')).to route_to('articles#show', id: "1")
    end
  end
end
