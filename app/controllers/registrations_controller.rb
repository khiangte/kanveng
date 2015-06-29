class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	super
    current_user.create_member if user_signed_in?
  end

  def update
    super
  end
end 