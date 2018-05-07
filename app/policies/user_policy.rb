# frozen_string_literal: true

class UserPolicy
  def initialize(user:, params:)
    @user = user
    @params = params
  end
  
  def can_register?
    true
  end
end
