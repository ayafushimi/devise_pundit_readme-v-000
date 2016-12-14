class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def permitted_attributes
      if user.admin? || user.owner_of?(post)
        [:title, :body, :tag_list]
      else
        [:tag_list]
      end
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end

  def update?
    user.admin? || user.moderator? || record.try(:user) == user
  end
end
