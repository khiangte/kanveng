class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
    	t.string		:name
    	t.integer		:level

      t.timestamps null: false
    end

    Role.create :name => "Master", :level => 1
    Role.create :name => "All Admin", :level => 2
    Role.create :name => "Group Admin", :level => 3
    Role.create :name => "User", :level => 4
  end
end
