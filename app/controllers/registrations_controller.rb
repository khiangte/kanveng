class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	super
  	debugger
    # add custom create logic here
  end

  def update
    super
  end
end 