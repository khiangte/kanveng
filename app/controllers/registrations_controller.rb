class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	super
    current_user.create_member
  end

  def update
    super
  end
end 