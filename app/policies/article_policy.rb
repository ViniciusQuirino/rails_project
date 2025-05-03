class ArticlePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show? # qlq pessoa pode visualizar os articles
    true
  end

  def create?
    user&.id
  end

  def update? # se o id do usuario logado for igual ao id do usuario que criou o article, pode atualizar
    user&.id == record.user.id
  end

  def destroy? # se o id do usuario logado for igual ao id do usuario que criou o article, pode excluir
    user&.id == record.user.id || user.admin?
  end
end
