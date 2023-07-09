require 'rails_helper'

RSpec.describe 'Auth', type: :routing do
  describe 'GET /login' do
    it 'auth#newにルーティングすること' do
      expect(get(login_path)).to route_to('auth#new')
    end
  end

  describe 'POST /login' do
    it 'auth#createにルーティングすること' do
      expect(post(login_path)).to route_to('auth#create')
    end
  end

  describe 'DELETE /logout' do
    it 'auth#destroyにルーティングすること' do
      expect(delete(logout_path)).to route_to('auth#destroy')
    end
  end
end
