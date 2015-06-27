class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
    	t.string			:full_name
    	t.date 				:dob
	    t.string			:epic_no
	    t.string			:birth_place
	    t.boolean 		:active, default: true
	    t.string  		:sex, length: 15
	    t.text				:photo_url
	    t.text				:occupation
	    t.text				:address
	    t.boolean			:verified, default: false
	    t.integer 		:user_id

      t.timestamps null: false
    end

    add_index :members, :epic_no,                unique: true
    add_index :members, :full_name
  end
end
