class Contact < ActiveRecord::Base
	enum contact_type: [ :Mobile, :Landline, :Email, :Other ]
	belongs_to :user

	scope :visible, -> { where(visible: true) }
end
