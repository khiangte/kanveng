class SystemDataController < ApplicationController
	before_action :authenticate_user!
	
	def new_system_data
		if current_user.is_all_admin?
			@system_data = SystemDatum.new
		end
	end

	def edit_system_data
		if current_user.is_all_admin?
			@system_data = SystemDatum.find_by_id(params[:id])
		end
	end

	def create_system_data
		if current_user.is_all_admin?
			system_data = SystemDatum.new(system_data_params)
			if system_data.save
				flash[:notice] = "SystemDatum Created"
				redirect_to system_data_path
			else
				flash[:notice] = "SystemDatum Not Created"
				redirect_to new_system_data_path
			end
	  else
	  	flash[:notice] = "Not authorised!"
	  	redirect_to root_path
	  end
	end

	def system_datas
		if current_user.is_all_admin?
			@system_datas = SystemDatum.active.approved.open.limit(10).order('id desc')
		else
	  	flash[:notice] = "Not authorised!"
	  	redirect_to root_path
	  end
	end

	def update_system_data
		
		if current_user.is_all_admin?
			@system_data = SystemDatum.find_by_id(system_data_params["id"])
			@system_data.update_attributes(system_data_params)
			if @system_data.save
				flash[:notice] = "SystemDatum Updated"
				redirect_to system_data_path(:id => @system_data.id)
			else
				redirect_to edit_system_data_path(:id => @system_data.id)
			end
		else
			flash[:notice] = "Not authorised!"
	  	redirect_to root_path
		end
	end

	private
	def system_data_params
  	params.require(:system_datum).permit!
  end

end
