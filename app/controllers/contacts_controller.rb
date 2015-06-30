class ContactsController < ApplicationController
	before_action :authenticate_user!, :except => [:view_contact]

	def new_contact
		user = User.find_by_id(params[:user_id])
		if user && user_can?
			@contact = Contact.new
			@contact.user = user
		else
			flash[:notice] = "Not Authorised/Incomplete data"
			redirect_to root_path
		end
	end

	def create_contact
		if user_can?
			contact = Contact.new(contact_params)
			if contact.save
	  		redirect_to member_path(:id => contact.user.member)
	  	else
				flash[:notice] = "Contact Not Created"
	  		render 'new_contact'
	  	end
	  else
	  	flash[:notice] = "Not authorised!"
	  	redirect_to root_path
	  end
	end

	def update_contact
		contact = Contact.find_by_id(contact_params["id"])
		if user_can?(contact)
			contact.update_attributes(contact_params)
			if contact.save
				flash[:notice] = "Contact Updated"
				redirect_to member_path(:id => contact.user.member)
			else
				redirect_to edit_contact_path(:id => contact.id)
			end
		else
			flash[:notice] = "Not authorised!"
	  	redirect_to root_path
		end
	end

	def edit_contact
		@contact = Contact.find_by_id(params[:id])
		@contact = nil unless user_can?(@contact)
	end

	def delete_contact
		contact = Contact.find_by_id(params[:id])
		if user_can?(contact)
			if contact.delete
				flash[:notice] = "Contact deleted"
				redirect_to member_path(:id => contact.user.member)
			end
		else
			flash[:notice] = "Process failed"
			redirect_to root_path
		end
	end

	def view_contact
		@contact = Contact.find_by_id(params[:id])
		@contact = nil unless user_can?(@contact)
	end

	private
  def contact_params
  	params.require(:contact).permit!
  end

	def user_can?(cont = nil)
		current_user.is_all_admin? || (cont.nil? ? true : current_user == cont.user)
	end
end
