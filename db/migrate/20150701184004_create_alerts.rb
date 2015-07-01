class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
    	t.string		:message
    	t.integer		:group_id
    	t.integer		:user_id
    	t.boolean 	:sent, default: false

      t.timestamps null: false
    end
  end
end
