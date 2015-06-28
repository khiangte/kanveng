class CreateMemberGroups < ActiveRecord::Migration
  def change
    create_table :member_groups do |t|
    	t.integer  	:group_id
    	t.integer		:user_id
    	t.boolean 	:admin, default: false

      t.timestamps null: false
    end
  end
end
