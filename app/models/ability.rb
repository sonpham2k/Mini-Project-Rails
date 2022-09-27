# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_admin?
      can :manage, :all
    end
    if !user.is_admin?
      can [:create, :update, :destroy, :read], Post, user_id: user.id
    end
  end
end
