class CreateSystemData < ActiveRecord::Migration
  def change
    create_table :system_data do |t|
    	t.text		:content
    	t.string	:key_word
    	t.integer	:system_data_type

      t.timestamps null: false
    end
  end
end
