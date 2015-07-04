class SystemDatum < ActiveRecord::Base
	enum system_data_type: [ :Contact, :About, :Other ]
end
