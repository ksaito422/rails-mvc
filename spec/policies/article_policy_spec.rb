require 'rails_helper'

RSpec.describe ArticlePolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new }

  permissions :new? do
    it '未ログインの場合、アクセスを許可しない' do
      expect(subject).not_to permit(nil, Article.new)
    end

    it 'ログインしている場合、アクセスを許可する' do
      expect(subject).to permit(user, Article.new)
    end
  end

  permissions :create? do
    it '未ログインの場合、投稿を許可しない' do
      expect(subject).not_to permit(nil, Article.new)
    end

    it 'ログインしている場合、投稿を許可する' do
      expect(subject).to permit(user, Article.new)
    end
  end

  permissions :destroy? do
    it '未ログインの場合、削除を許可しない' do
      expect(subject).not_to permit(nil, Article.new)
    end

    it 'ログインしている場合、削除を許可する' do
      expect(subject).to permit(user, Article.new)
    end
  end
end
