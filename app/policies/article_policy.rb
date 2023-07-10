class ArticlePolicy < ApplicationPolicy
  def new?
    user.present?
  end
end
