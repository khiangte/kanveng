class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def can_approve_member?
  	current_user ? current_user.role.can_approve_member? : false
  end

  def can_create_member?
  	current_user ? current_user.role.can_create_member? : false
  end

  def can_approve_public_post?
  	current_user ? current_user.role.can_approve_public_post? : false
  end

  def can_approve_group_post?
  	current_user ? current_user.role.can_approve_group_post? : false
  end
end
