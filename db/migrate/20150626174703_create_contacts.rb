class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.integer			:member_id
    	t.integer			:contact_type
    	t.string			:value
    	t.boolean			:visible, default: false

      t.timestamps null: false
    end
  end
end
