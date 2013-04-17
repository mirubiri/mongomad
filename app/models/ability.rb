class Ability
  include CanCan::Ability

  def initialize(user)

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    #REQUESTS
    can :read, Request, :user_id => user.id
    can :create, Request, :user_id => user.id
    can :update, Request, :active => true, :user_id => user.id
    can :delete, Request, :active => true, :user_id => user.id

    #OFFERS
    can :read, Offer, :user_id => user.id
    can :create, Offer, :user_id => user.id
    can :update, Offer, :user_id => user.id
    can :delete, Offer, :user_id => user.id

    #NEGOTIATIONS
    can :read, Negotiation, :user_id => user.id
    can :create, Negotiation, :user_id => user.id
    can :update, Negotiation, :user_id => user.id
    can :delete, Negotiation, :user_id => user.id

    #DEALS
    can :read, Deal, user_id => user.id
    can :create, Deal, :user_id => user.id
    can :update, Deal, :user_id => user.id
    can :delete, Deal, :user_id => user.id



  end
end
