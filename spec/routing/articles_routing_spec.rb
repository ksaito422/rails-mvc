require 'rails_helper'

RSpec.describe 'Articles', type: :routing do
  describe 'GET /' do
    it 'articles#indexにルーティングすること' do
      expect(get('/')).to route_to('articles#index')
    end
  end
end
