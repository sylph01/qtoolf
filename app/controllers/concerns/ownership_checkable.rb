module OwnershipCheckable
  extend ActiveSupport::Concern

  included do
    helper_method :check_ownership_of, :check_contributorship_of, :is_owner?, :is_contributor?
  end

  def is_owner?(entity, user)
    user.id == entity.owner_id
  end

  def is_contributor?(entity, user)
    is_owner?(entity, user) || entity.contributors.map{ |c| c.screen_name.downcase }.include?(user.screen_name.downcase)
  end

  def check_ownership_of(entity, user)
    if !is_owner?(entity, user)
      return_back(alert: "You're not the owner!") and return false
    else
      return true
    end
  end

  def check_contributorship_of(entity, user)
    if !is_contributor?(entity, user)
      return_back(alert: "You're not the contributor!") and return false
    else
      return true
    end
  end
end
