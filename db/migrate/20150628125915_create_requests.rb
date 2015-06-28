class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
    	t.integer  	:group_id
    	t.integer		:user_id
    	t.string 		:message
    	
      t.timestamps null: false
    end
  end
end
