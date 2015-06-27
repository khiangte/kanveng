class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.string				:name
    	t.string				:description
    	t.integer				:group_type
    	t.boolean				:active, default: true

      t.timestamps null: false
    end
  end
end
